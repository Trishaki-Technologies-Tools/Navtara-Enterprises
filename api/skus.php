<?php
// api/skus.php
// AJAX Handler for SKU Management CRUD

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        $brand_id = (int)($_GET['brand_id'] ?? 0);
        $product_id = (int)($_GET['product_id'] ?? 0);
        try {
            $whereClause = "";
            $params = [];
            
            if ($product_id > 0) {
                $whereClause = "WHERE s.product_id = ?";
                $params[] = $product_id;
            } elseif ($brand_id > 0) {
                $whereClause = "WHERE p.brand_id = ?";
                $params[] = $brand_id;
            }

            $stmt = $db->prepare("
                SELECT s.*, p.name as product_name, b.name as brand_name, p.hsn_code
                FROM skus s
                JOIN products p ON s.product_id = p.id
                JOIN brands b ON p.brand_id = b.id
                $whereClause
                ORDER BY s.id DESC
            ");
            $stmt->execute($params);
            $skus = $stmt->fetchAll();
            sendJSON('success', 'SKUs loaded.', $skus);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch SKUs: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("SELECT s.*, p.gst_percentage as product_gst FROM skus s JOIN products p ON s.product_id = p.id WHERE s.id = ?");
            $stmt->execute([$id]);
            $sku = $stmt->fetch();
            if ($sku) {
                // Fetch discount rules
                $dstmt = $db->prepare("SELECT * FROM sku_discounts WHERE sku_id = ? AND status = 'Active' ORDER BY discount_type, min_qty DESC");
                $dstmt->execute([$id]);
                $sku['discount_rules'] = $dstmt->fetchAll();
                
                sendJSON('success', 'SKU loaded.', $sku);
            } else {
                sendJSON('error', 'SKU not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'analytics') {
        try {
            $month = isset($_GET['month']) && is_numeric($_GET['month']) ? (int)$_GET['month'] : (int)date('m');
            $year = isset($_GET['year']) && is_numeric($_GET['year']) ? (int)$_GET['year'] : (int)date('Y');
            $brand_id = (int)($_GET['brand_id'] ?? 0);
            
            // Format start and end date for the selected month
            $start_date = sprintf('%04d-%02d-01', $year, $month);
            $end_date = date('Y-m-t', strtotime($start_date));
            
            // Query SKU performance in the period
            $whereBrand = $brand_id > 0 ? "AND p.brand_id = {$brand_id}" : "";
            
            $sql = "
                SELECT 
                    s.id as sku_id,
                    s.sku_code,
                    s.sku_name,
                    s.unit,
                    s.weight,
                    s.size,
                    s.purchase_price,
                    s.selling_price,
                    s.mrp,
                    s.current_stock,
                    s.minimum_stock,
                    s.status,
                    p.id as product_id,
                    p.name as product_name,
                    p.hsn_code,
                    b.id as brand_id,
                    b.name as brand_name,
                    COALESCE(sales.total_qty, 0) as total_quantity_sold,
                    COALESCE(sales.total_revenue, 0) as total_revenue,
                    COALESCE(sales.total_taxable, 0) as total_taxable_value,
                    COALESCE(sales.total_discount, 0) as total_discount_given,
                    COALESCE(sales.total_gst, 0) as total_gst_collected,
                    COALESCE(sales.invoices_count, 0) as invoices_count,
                    COALESCE(sales.last_sale_date, NULL) as last_sale_date
                FROM skus s
                JOIN products p ON s.product_id = p.id
                JOIN brands b ON p.brand_id = b.id
                LEFT JOIN (
                    SELECT 
                        ii.sku_id,
                        SUM(ii.quantity) as total_qty,
                        SUM(ii.total_amount) as total_revenue,
                        SUM((ii.quantity * ii.selling_price) - ii.discount_amount) as total_taxable,
                        SUM(ii.discount_amount) as total_discount,
                        SUM(ii.gst_amount) as total_gst,
                        COUNT(DISTINCT ii.invoice_id) as invoices_count,
                        MAX(inv.invoice_date) as last_sale_date
                    FROM invoice_items ii
                    JOIN invoices inv ON ii.invoice_id = inv.id
                    WHERE inv.invoice_date BETWEEN ? AND ?
                    GROUP BY ii.sku_id
                ) sales ON s.id = sales.sku_id
                WHERE 1=1 $whereBrand
                ORDER BY total_quantity_sold DESC, total_revenue DESC, s.sku_name ASC
            ";
            
            $stmt = $db->prepare($sql);
            $stmt->execute([$start_date, $end_date]);
            $skus = $stmt->fetchAll();
            
            // Calculate KPI Totals & High Selling stats
            $totalUnitsSold = 0;
            $totalRevenue = 0;
            $totalProfitEstimate = 0;
            $topSkuByQty = null;
            $topSkuByRevenue = null;
            
            $categoryShare = [];
            
            foreach ($skus as &$sku) {
                $qty = (int)$sku['total_quantity_sold'];
                $rev = (float)$sku['total_revenue'];
                $taxable = (float)$sku['total_taxable_value'];
                $cost = $qty * (float)$sku['purchase_price'];
                $profit = $taxable - $cost;
                $margin = $taxable > 0 ? round(($profit / $taxable) * 100, 1) : 0;
                
                $sku['estimated_profit'] = $profit;
                $sku['profit_margin'] = $margin;
                
                $totalUnitsSold += $qty;
                $totalRevenue += $rev;
                $totalProfitEstimate += $profit;
                
                // Track category share
                $bName = $sku['brand_name'];
                if (!isset($categoryShare[$bName])) {
                    $categoryShare[$bName] = ['qty' => 0, 'revenue' => 0];
                }
                $categoryShare[$bName]['qty'] += $qty;
                $categoryShare[$bName]['revenue'] += $rev;
            }
            unset($sku);
            
            if (!empty($skus)) {
                // Top SKU by quantity
                $byQty = $skus;
                usort($byQty, function($a, $b) { return $b['total_quantity_sold'] <=> $a['total_quantity_sold']; });
                if ($byQty[0]['total_quantity_sold'] > 0) {
                    $topSkuByQty = $byQty[0];
                }
                
                // Top SKU by revenue
                $byRev = $skus;
                usort($byRev, function($a, $b) { return $b['total_revenue'] <=> $a['total_revenue']; });
                if ($byRev[0]['total_revenue'] > 0) {
                    $topSkuByRevenue = $byRev[0];
                }
            }
            
            // Monthly Trend for the last 6 months
            $monthlyTrends = [];
            for ($i = 5; $i >= 0; $i--) {
                $tMonthDate = date('Y-m-01', strtotime("-$i months", strtotime($start_date)));
                $tMonthEnd = date('Y-m-t', strtotime($tMonthDate));
                $tMonthLabel = date('M Y', strtotime($tMonthDate));
                
                $tStmt = $db->prepare("
                    SELECT 
                        COALESCE(SUM(ii.quantity), 0) as month_qty,
                        COALESCE(SUM(ii.total_amount), 0) as month_revenue
                    FROM invoice_items ii
                    JOIN invoices inv ON ii.invoice_id = inv.id
                    WHERE inv.invoice_date BETWEEN ? AND ?
                ");
                $tStmt->execute([$tMonthDate, $tMonthEnd]);
                $tData = $tStmt->fetch();
                
                $monthlyTrends[] = [
                    'label' => $tMonthLabel,
                    'month_date' => $tMonthDate,
                    'qty' => (int)$tData['month_qty'],
                    'revenue' => (float)$tData['month_revenue']
                ];
            }
            
            sendJSON('success', 'SKU analytics loaded.', [
                'period' => [
                    'month' => $month,
                    'year' => $year,
                    'month_name' => date('F Y', strtotime($start_date)),
                    'start_date' => $start_date,
                    'end_date' => $end_date
                ],
                'summary' => [
                    'total_skus' => count($skus),
                    'total_units_sold' => $totalUnitsSold,
                    'total_revenue' => $totalRevenue,
                    'total_profit_estimate' => $totalProfitEstimate,
                    'top_sku_qty' => $topSkuByQty,
                    'top_sku_revenue' => $topSkuByRevenue
                ],
                'category_share' => $categoryShare,
                'monthly_trends' => $monthlyTrends,
                'skus' => $skus
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to load SKU analytics: ' . $e->getMessage());
        }
    }
    
    if ($action === 'sku_sales_history') {
        $sku_id = (int)($_GET['sku_id'] ?? 0);
        $year = isset($_GET['year']) ? (int)$_GET['year'] : (int)date('Y');
        
        if ($sku_id <= 0) {
            sendJSON('error', 'Invalid SKU ID.');
        }
        
        try {
            // Fetch SKU info
            $stmtSku = $db->prepare("
                SELECT s.*, p.name as product_name, b.name as brand_name 
                FROM skus s 
                JOIN products p ON s.product_id = p.id 
                JOIN brands b ON p.brand_id = b.id 
                WHERE s.id = ?
            ");
            $stmtSku->execute([$sku_id]);
            $sku = $stmtSku->fetch();
            
            if (!$sku) {
                sendJSON('error', 'SKU not found.');
            }
            
            // 12 Months breakdown for selected year
            $monthlySales = [];
            for ($m = 1; $m <= 12; $m++) {
                $mStart = sprintf('%04d-%02d-01', $year, $m);
                $mEnd = date('Y-m-t', strtotime($mStart));
                $mLabel = date('M', strtotime($mStart));
                
                $stmtM = $db->prepare("
                    SELECT 
                        COALESCE(SUM(ii.quantity), 0) as qty,
                        COALESCE(SUM(ii.total_amount), 0) as revenue
                    FROM invoice_items ii
                    JOIN invoices inv ON ii.invoice_id = inv.id
                    WHERE ii.sku_id = ? AND inv.invoice_date BETWEEN ? AND ?
                ");
                $stmtM->execute([$sku_id, $mStart, $mEnd]);
                $mData = $stmtM->fetch();
                
                $monthlySales[] = [
                    'month_num' => $m,
                    'month_name' => $mLabel,
                    'qty' => (int)$mData['qty'],
                    'revenue' => (float)$mData['revenue']
                ];
            }
            
            // Recent invoice sales entries (up to 25)
            $stmtSales = $db->prepare("
                SELECT 
                    ii.*, 
                    inv.invoice_number, 
                    inv.invoice_date, 
                    r.shop_name as retailer_shop, 
                    r.area as retailer_area
                FROM invoice_items ii
                JOIN invoices inv ON ii.invoice_id = inv.id
                JOIN retailers r ON inv.retailer_id = r.id
                WHERE ii.sku_id = ?
                ORDER BY inv.invoice_date DESC, inv.id DESC
                LIMIT 25
            ");
            $stmtSales->execute([$sku_id]);
            $recentSales = $stmtSales->fetchAll();
            
            sendJSON('success', 'SKU sales history loaded.', [
                'sku' => $sku,
                'year' => $year,
                'monthly_breakdown' => $monthlySales,
                'recent_sales' => $recentSales
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    checkRole('Owner'); // Only Owners can manage SKUs
    
    if ($action === 'create') {
        $product_id = (int)($_POST['product_id'] ?? 0);
        $sku_name = cleanInput($_POST['sku_name'] ?? '');
        $sku_code = cleanInput($_POST['sku_code'] ?? '');
        $purchase_price = (float)($_POST['purchase_price'] ?? 0.00);
        $selling_price = (float)($_POST['selling_price'] ?? 0.00);
        $mrp = (float)($_POST['mrp'] ?? 0.00);
        $gst_percentage = (float)($_POST['gst_percentage'] ?? 0.00);
        $unit = cleanInput($_POST['unit'] ?? 'Pcs');
        $weight = cleanInput($_POST['weight'] ?? '');
        $size = cleanInput($_POST['size'] ?? '');
        $current_stock = (int)($_POST['current_stock'] ?? 0);
        $minimum_stock = (int)($_POST['minimum_stock'] ?? 5);
        $status = cleanInput($_POST['status'] ?? 'Active');
        $allow_dynamic_price = !empty($_POST['allow_dynamic_price']) ? 1 : 0;
        
        if ($product_id <= 0 || empty($sku_name)) {
            sendJSON('error', 'Product and SKU Name are required fields.');
        }
        
        if (empty($sku_code)) {
            // Get product and brand details
            $prodStmt = $db->prepare("
                SELECT p.name as product_name, b.name as brand_name 
                FROM products p 
                JOIN brands b ON p.brand_id = b.id 
                WHERE p.id = ?
            ");
            $prodStmt->execute([$product_id]);
            $prod = $prodStmt->fetch();
            $prodName = $prod ? $prod['product_name'] : '';
            $brandName = $prod ? $prod['brand_name'] : '';
            
            // Generate clean SKU code
            $combined = ($brandName ? $brandName . '-' : '') . $prodName . '-' . $sku_name;
            $clean = preg_replace('/[^A-Za-z0-9\-]/', '', str_replace(' ', '-', $combined));
            $clean = preg_replace('/-+/', '-', $clean);
            $sku_code = strtoupper(trim($clean, '-'));
            
            // Ensure uniqueness
            $checkStmt = $db->prepare("SELECT COUNT(*) FROM skus WHERE sku_code = ?");
            $checkStmt->execute([$sku_code]);
            if ($checkStmt->fetchColumn() > 0) {
                $sku_code = substr($sku_code, 0, 43) . '-' . strtoupper(substr(uniqid(), -5));
            }
        }
        
        $db->beginTransaction();
        try {
            $stmt = $db->prepare("
                INSERT INTO skus 
                (product_id, sku_name, sku_code, purchase_price, selling_price, mrp, gst_percentage, unit, weight, size, current_stock, minimum_stock, status, allow_dynamic_price) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmt->execute([$product_id, $sku_name, $sku_code, $purchase_price, $selling_price, $mrp, $gst_percentage, $unit, $weight, $size, $current_stock, $minimum_stock, $status, $allow_dynamic_price]);
            $skuId = $db->lastInsertId();
            
            // Log opening stock in history
            $stmtHist = $db->prepare("
                INSERT INTO inventory_history (sku_id, transaction_type, quantity, previous_stock, new_stock, remarks) 
                VALUES (?, 'Opening Stock', ?, 0, ?, 'SKU created with opening stock')
            ");
            $stmtHist->execute([$skuId, $current_stock, $current_stock]);
            
            $db->commit();
            logActivity('Create SKU', "Created SKU: {$sku_name} (Code: {$sku_code}) with opening stock {$current_stock}");
            sendJSON('success', 'SKU created successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            if ($e->errorInfo[1] == 1062) {
                sendJSON('error', 'An SKU with this SKU Code already exists.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'update') {
        $id = (int)($_POST['id'] ?? 0);
        $product_id = (int)($_POST['product_id'] ?? 0);
        $sku_name = cleanInput($_POST['sku_name'] ?? '');
        $purchase_price = (float)($_POST['purchase_price'] ?? 0.00);
        $selling_price = (float)($_POST['selling_price'] ?? 0.00);
        $mrp = (float)($_POST['mrp'] ?? 0.00);
        $gst_percentage = (float)($_POST['gst_percentage'] ?? 0.00);
        $unit = cleanInput($_POST['unit'] ?? 'Pcs');
        $minimum_stock = (int)($_POST['minimum_stock'] ?? 5);
        $status = cleanInput($_POST['status'] ?? 'Active');
        $allow_dynamic_price = !empty($_POST['allow_dynamic_price']) ? 1 : 0;
        
        if ($id <= 0 || $product_id <= 0 || empty($sku_name)) {
            sendJSON('error', 'Invalid parameters. SKU Name and Product are required.');
        }
        
        try {
            $stmt = $db->prepare("
                UPDATE skus 
                SET product_id = ?, sku_name = ?, purchase_price = ?, selling_price = ?, mrp = ?, gst_percentage = ?, unit = ?, minimum_stock = ?, status = ?, allow_dynamic_price = ? 
                WHERE id = ?
            ");
            $stmt->execute([$product_id, $sku_name, $purchase_price, $selling_price, $mrp, $gst_percentage, $unit, $minimum_stock, $status, $allow_dynamic_price, $id]);
            logActivity('Update SKU', "Updated SKU ID: {$id} ({$sku_name})");
            sendJSON('success', 'SKU updated successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1062) {
                sendJSON('error', 'An SKU with this SKU Code already exists.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }

    if ($action === 'toggle_dynamic_price') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid SKU ID.');
        }
        try {
            $stmt = $db->prepare("UPDATE skus SET allow_dynamic_price = NOT allow_dynamic_price WHERE id = ?");
            $stmt->execute([$id]);
            
            $stmtGet = $db->prepare("SELECT allow_dynamic_price, sku_name FROM skus WHERE id = ?");
            $stmtGet->execute([$id]);
            $row = $stmtGet->fetch();
            
            $statusText = $row['allow_dynamic_price'] == 1 ? 'Dynamic Price / Manual Billing Enabled' : 'Dynamic Price Disabled (Fixed Rate)';
            logActivity('Toggle SKU Dynamic Price', "{$statusText} for SKU: {$row['sku_name']}");
            sendJSON('success', "{$statusText} for {$row['sku_name']}.", ['allow_dynamic_price' => (int)$row['allow_dynamic_price']]);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid SKU ID.');
        }
        
        try {
            // Delete history first or handle foreign keys (on delete restrict)
            $stmt = $db->prepare("DELETE FROM inventory_history WHERE sku_id = ? AND transaction_type = 'Opening Stock'");
            $stmt->execute([$id]);
            
            $stmt = $db->prepare("DELETE FROM skus WHERE id = ?");
            $stmt->execute([$id]);
            
            logActivity('Delete SKU', "Deleted SKU ID: {$id}");
            sendJSON('success', 'SKU deleted successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1451) {
                sendJSON('error', 'Cannot delete SKU. It has associated history, order items or invoice items.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
