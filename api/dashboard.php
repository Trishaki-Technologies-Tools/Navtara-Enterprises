<?php
// api/dashboard.php
// AJAX Aggregator for Dashboard KPIs, Graphs, and Lists

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$userId = $_SESSION['user_id'];
$roleName = $_SESSION['role_name'];

function formatRupeesPHP($amount) {
    if ($amount < 0) {
        return '-₹' . number_format(abs($amount), 2);
    }
    return '₹' . number_format($amount, 2);
}

try {
    $stats = [];
    
    if ($roleName === 'Owner') {
        // --- 1. SALES METRICS ---
        $stmtSales = $db->query("
            SELECT 
                COALESCE(SUM(grand_total), 0) as total_sales,
                COUNT(id) as total_invoices
            FROM invoices
        ");
        $salesRow = $stmtSales->fetch();
        $total_sales = (float)$salesRow['total_sales'];
        $total_invoices = (int)$salesRow['total_invoices'];
        
        // Sold Quantity
        $stmtSoldQty = $db->query("SELECT COALESCE(SUM(quantity), 0) FROM invoice_items");
        $sold_qty = (int)$stmtSoldQty->fetchColumn();
        
        // Average Cart Value
        $avg_cart_val = $total_invoices > 0 ? $total_sales / $total_invoices : 0.00;
        
        // --- 2. CUSTOMERS & RECEIVABLES ---
        $stmtCust = $db->query("
            SELECT 
                COUNT(id) as total_customers,
                COALESCE(SUM(outstanding_amount), 0) as to_receive
            FROM retailers
        ");
        $custRow = $stmtCust->fetch();
        $total_customers = (int)$custRow['total_customers'];
        $to_receive = (float)$custRow['to_receive'];
        
        // Sales Return / Expiry
        $stmtSalesReturn = $db->query("SELECT COALESCE(SUM(amount), 0) FROM expiry_records");
        $total_sales_return = (float)$stmtSalesReturn->fetchColumn();
        
        // --- 3. PURCHASES, BILLS & PAYABLES ---
        $stmtPurchases = $db->query("
            SELECT 
                COALESCE(SUM(grand_total), 0) as total_purchase,
                COUNT(id) as total_bills
            FROM purchases
        ");
        $purRow = $stmtPurchases->fetch();
        $total_purchase = (float)$purRow['total_purchase'];
        $total_purchase_bills = (int)$purRow['total_bills'];
        
        // Purchase Qty
        $stmtPurQty = $db->query("SELECT COALESCE(SUM(quantity), 0) FROM purchase_items");
        $purchase_qty = (int)$stmtPurQty->fetchColumn();
        
        // Suppliers Count
        $stmtSupp = $db->query("SELECT COUNT(id) FROM suppliers");
        $total_suppliers = (int)$stmtSupp->fetchColumn();
        
        // Supplier Payments (Total Paid)
        $stmtPaid = $db->query("SELECT COALESCE(SUM(amount), 0) FROM supplier_payments");
        $total_paid = (float)$stmtPaid->fetchColumn();
        
        // To Pay (Payables to suppliers)
        $to_pay = max(0, $total_purchase - $total_paid);
        
        // Purchase Return (Supplier damage/returns)
        $total_purchase_return = 0.00;
        
        // --- 4. EXPENSES ---
        $stmtExp = $db->query("SELECT COALESCE(SUM(amount), 0) FROM expenses");
        $total_expenses = (float)$stmtExp->fetchColumn();
        
        // --- 5. PRODUCTS & STOCK ---
        $stmtSkus = $db->query("
            SELECT 
                COUNT(id) as total_products,
                COALESCE(SUM(current_stock), 0) as stock_qty,
                COALESCE(SUM(current_stock * purchase_price), 0) as stock_val
            FROM skus
            WHERE status = 'Active'
        ");
        $skuRow = $stmtSkus->fetch();
        $total_products = (int)$skuRow['total_products'];
        $stock_qty = (int)$skuRow['stock_qty'];
        $stock_val = (float)$skuRow['stock_val'];
        
        // --- 6. CASH IN HAND & BANK BALANCE ---
        $stmtInflows = $db->query("
            SELECT 
                COALESCE(SUM(CASE WHEN payment_method = 'Cash' THEN amount ELSE 0 END), 0) as cash_inflow,
                COALESCE(SUM(CASE WHEN payment_method != 'Cash' THEN amount ELSE 0 END), 0) as bank_inflow
            FROM payments
        ");
        $inflows = $stmtInflows->fetch();
        
        $stmtExpFlow = $db->query("
            SELECT 
                COALESCE(SUM(CASE WHEN payment_method = 'Cash' THEN amount ELSE 0 END), 0) as cash_exp,
                COALESCE(SUM(CASE WHEN payment_method != 'Cash' THEN amount ELSE 0 END), 0) as bank_exp
            FROM expenses
        ");
        $expFlow = $stmtExpFlow->fetch();
        
        $stmtSuppFlow = $db->query("
            SELECT 
                COALESCE(SUM(CASE WHEN payment_mode = 'Cash' THEN amount ELSE 0 END), 0) as cash_supp,
                COALESCE(SUM(CASE WHEN payment_mode != 'Cash' THEN amount ELSE 0 END), 0) as bank_supp
            FROM supplier_payments
        ");
        $suppFlow = $stmtSuppFlow->fetch();
        
        $cash_in_hand = (float)$inflows['cash_inflow'] - (float)$expFlow['cash_exp'] - (float)$suppFlow['cash_supp'];
        $bank_balance = (float)$inflows['bank_inflow'] - (float)$expFlow['bank_exp'] - (float)$suppFlow['bank_supp'];
        
        // --- 7. PROFIT & MARGINS ---
        $stmtCOGS = $db->query("SELECT COALESCE(SUM(quantity * purchase_price), 0) FROM invoice_items");
        $cogs = (float)$stmtCOGS->fetchColumn();
        $gross_profit = $total_sales - $cogs;
        $avg_profit_margin_pct = $total_sales > 0 ? ($gross_profit / $total_sales) * 100 : 0.00;
        $avg_profit_margin = $total_invoices > 0 ? $gross_profit / $total_invoices : 0.00;
        
        // --- BUILD ALL 23 METRICS REQUESTED BY USER ---
        $stats['metrics'] = [
            'total_sales' => [
                'label' => 'Total Sales',
                'value' => formatRupeesPHP($total_sales),
                'icon'  => 'fa-file-invoice-dollar',
                'color' => 'success'
            ],
            'total_invoices' => [
                'label' => 'Total Invoices',
                'value' => number_format($total_invoices),
                'icon'  => 'fa-receipt',
                'color' => 'primary'
            ],
            'sold_qty' => [
                'label' => 'Sold Qty',
                'value' => number_format($sold_qty) . ' Units',
                'icon'  => 'fa-cubes',
                'color' => 'info'
            ],
            'total_customers' => [
                'label' => 'Total Customers',
                'value' => number_format($total_customers),
                'icon'  => 'fa-users',
                'color' => 'primary'
            ],
            'to_receive' => [
                'label' => 'To Receive',
                'value' => formatRupeesPHP($to_receive),
                'icon'  => 'fa-hand-holding-usd',
                'color' => 'warning'
            ],
            'total_sales_return' => [
                'label' => 'Total Sales Return',
                'value' => formatRupeesPHP($total_sales_return),
                'icon'  => 'fa-undo-alt',
                'color' => 'danger'
            ],
            'total_purchase' => [
                'label' => 'Total Purchase',
                'value' => formatRupeesPHP($total_purchase),
                'icon'  => 'fa-truck-loading',
                'color' => 'info'
            ],
            'total_bills' => [
                'label' => 'Total Bills',
                'value' => number_format($total_purchase_bills),
                'icon'  => 'fa-file-alt',
                'color' => 'primary'
            ],
            'purchase_qty' => [
                'label' => 'Purchase Qty',
                'value' => number_format($purchase_qty) . ' Units',
                'icon'  => 'fa-boxes',
                'color' => 'warning'
            ],
            'total_suppliers' => [
                'label' => 'Total Suppliers',
                'value' => number_format($total_suppliers),
                'icon'  => 'fa-truck',
                'color' => 'secondary'
            ],
            'to_pay' => [
                'label' => 'To Pay',
                'value' => formatRupeesPHP($to_pay),
                'icon'  => 'fa-exclamation-circle',
                'color' => 'danger'
            ],
            'total_purchase_return' => [
                'label' => 'Total Purchase Return',
                'value' => formatRupeesPHP($total_purchase_return),
                'icon'  => 'fa-reply',
                'color' => 'secondary'
            ],
            'total_paid' => [
                'label' => 'Total Paid',
                'value' => formatRupeesPHP($total_paid),
                'icon'  => 'fa-check-circle',
                'color' => 'success'
            ],
            'total_expenses' => [
                'label' => 'Total Expenses',
                'value' => formatRupeesPHP($total_expenses),
                'icon'  => 'fa-wallet',
                'color' => 'danger'
            ],
            'total_products' => [
                'label' => 'Total Products',
                'value' => number_format($total_products),
                'icon'  => 'fa-barcode',
                'color' => 'primary'
            ],
            'stock_qty' => [
                'label' => 'Stock Qty',
                'value' => number_format($stock_qty) . ' Units',
                'icon'  => 'fa-warehouse',
                'color' => 'info'
            ],
            'stock_value' => [
                'label' => 'Stock Value',
                'value' => formatRupeesPHP($stock_val),
                'icon'  => 'fa-coins',
                'color' => 'success'
            ],
            'cash_in_hand' => [
                'label' => 'Cash in Hand',
                'value' => formatRupeesPHP($cash_in_hand),
                'icon'  => 'fa-money-bill-wave',
                'color' => 'success'
            ],
            'gross_profit' => [
                'label' => 'Gross Profit',
                'value' => formatRupeesPHP($gross_profit),
                'icon'  => 'fa-chart-line',
                'color' => 'success'
            ],
            'avg_profit_margin' => [
                'label' => 'Avg Profit Margin',
                'value' => formatRupeesPHP($avg_profit_margin),
                'icon'  => 'fa-tag',
                'color' => 'warning'
            ],
            'avg_profit_margin_pct' => [
                'label' => 'Avg Profit Margin %',
                'value' => number_format($avg_profit_margin_pct, 2) . '%',
                'icon'  => 'fa-percentage',
                'color' => 'info'
            ],
            'avg_cart_value' => [
                'label' => 'Avg Cart Value',
                'value' => formatRupeesPHP($avg_cart_val),
                'icon'  => 'fa-shopping-cart',
                'color' => 'warning'
            ],
            'bank_balance' => [
                'label' => 'Bank Accounts Balance',
                'value' => formatRupeesPHP($bank_balance),
                'icon'  => 'fa-university',
                'color' => ($bank_balance >= 0 ? 'info' : 'danger')
            ]
        ];
        
        // Top Selling Products (Last 30 Days)
        $stmt = $db->prepare("
            SELECT s.sku_name, s.sku_code, SUM(ii.quantity) as total_qty, SUM(ii.total_amount) as total_revenue
            FROM invoice_items ii
            JOIN invoices i ON ii.invoice_id = i.id
            JOIN skus s ON ii.sku_id = s.id
            WHERE i.invoice_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
            GROUP BY s.id, s.sku_name, s.sku_code
            ORDER BY total_qty DESC
            LIMIT 5
        ");
        $stmt->execute();
        $top_selling = $stmt->fetchAll();
        $top_selling_mapped = [];
        foreach ($top_selling as $row) {
            $top_selling_mapped[] = [
                'sku_name' => $row['sku_name'],
                'sku_code' => $row['sku_code'],
                'units_sold' => (int)$row['total_qty'],
                'revenue' => (float)$row['total_revenue']
            ];
        }
        $stats['top_selling'] = $top_selling_mapped;
        
        // Recent Orders
        $stmt = $db->prepare("
            SELECT o.id, r.shop_name, u.fullname as staff_name, o.order_date, o.grand_total, o.status 
            FROM orders o
            JOIN retailers r ON o.retailer_id = r.id
            JOIN users u ON o.staff_id = u.id
            ORDER BY o.id DESC
            LIMIT 6
        ");
        $stmt->execute();
        $stats['recent_orders'] = $stmt->fetchAll();
        
        // Chart Data - Sales Graph (Last 7 Days)
        $stmt = $db->prepare("
            SELECT DATE_FORMAT(d.date, '%b %d') as label_date, COALESCE(SUM(i.grand_total), 0) as total_sales
            FROM (
                SELECT CURDATE() as date UNION SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 4 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            ) d
            LEFT JOIN invoices i ON d.date = i.invoice_date
            GROUP BY d.date, label_date
            ORDER BY d.date ASC
        ");
        $stmt->execute();
        $sales_chart = $stmt->fetchAll();
        
        // Chart Data - Collection Graph (Last 7 Days)
        $stmt = $db->prepare("
            SELECT DATE_FORMAT(d.date, '%b %d') as label_date, COALESCE(SUM(p.amount), 0) as total_collected
            FROM (
                SELECT CURDATE() as date UNION SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 4 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            ) d
            LEFT JOIN payments p ON d.date = p.payment_date
            GROUP BY d.date, label_date
            ORDER BY d.date ASC
        ");
        $stmt->execute();
        $collection_chart = $stmt->fetchAll();
        
        // Build chart_trends
        $chart_trends = [
            'labels' => [],
            'sales' => [],
            'collections' => []
        ];
        foreach ($sales_chart as $index => $row) {
            $chart_trends['labels'][] = $row['label_date'];
            $chart_trends['sales'][] = (float)$row['total_sales'];
            
            $collected = 0.00;
            if (isset($collection_chart[$index])) {
                $collected = (float)$collection_chart[$index]['total_collected'];
            }
            $chart_trends['collections'][] = $collected;
        }
        $stats['chart_trends'] = $chart_trends;
        
        // Chart Data - Outstanding Retailers
        $stmt = $db->prepare("
            SELECT shop_name, outstanding_amount 
            FROM retailers 
            WHERE outstanding_amount > 0 
            ORDER BY outstanding_amount DESC 
            LIMIT 5
        ");
        $stmt->execute();
        $outstanding_chart = $stmt->fetchAll();
        $chart_outstanding = [
            'labels' => [],
            'values' => []
        ];
        foreach ($outstanding_chart as $row) {
            $chart_outstanding['labels'][] = $row['shop_name'];
            $chart_outstanding['values'][] = (float)$row['outstanding_amount'];
        }
        $stats['chart_outstanding'] = $chart_outstanding;
        
    } else {
        // --- SALES STAFF METRICS ---
        
        // Total Sales by this staff
        $stmt = $db->prepare("
            SELECT COALESCE(SUM(i.grand_total), 0) 
            FROM invoices i
            JOIN orders o ON i.order_id = o.id
            WHERE o.staff_id = ?
        ");
        $stmt->execute([$userId]);
        $staff_total_sales = (float)$stmt->fetchColumn();
        
        // Total Invoices
        $stmt = $db->prepare("
            SELECT COUNT(i.id) 
            FROM invoices i
            JOIN orders o ON i.order_id = o.id
            WHERE o.staff_id = ?
        ");
        $stmt->execute([$userId]);
        $staff_total_invoices = (int)$stmt->fetchColumn();
        
        // Sold Quantity
        $stmt = $db->prepare("
            SELECT COALESCE(SUM(ii.quantity), 0)
            FROM invoice_items ii
            JOIN invoices i ON ii.invoice_id = i.id
            JOIN orders o ON i.order_id = o.id
            WHERE o.staff_id = ?
        ");
        $stmt->execute([$userId]);
        $staff_sold_qty = (int)$stmt->fetchColumn();
        
        // Assigned Retailers
        $stmt = $db->prepare("
            SELECT COUNT(DISTINCT r.id) 
            FROM retailers r
            JOIN route_retailers rr ON r.id = rr.retailer_id
            JOIN staff_routes sr ON rr.route_id = sr.route_id
            WHERE sr.user_id = ? AND r.status = 'Active'
        ");
        $stmt->execute([$userId]);
        $staff_retailers = (int)$stmt->fetchColumn();
        
        // Outstanding to receive
        $stmt = $db->prepare("
            SELECT COALESCE(SUM(r.outstanding_amount), 0) 
            FROM retailers r
            JOIN route_retailers rr ON r.id = rr.retailer_id
            JOIN staff_routes sr ON rr.route_id = sr.route_id
            WHERE sr.user_id = ?
        ");
        $stmt->execute([$userId]);
        $staff_outstanding = (float)$stmt->fetchColumn();
        
        // Collections made by staff
        $stmt = $db->prepare("SELECT COALESCE(SUM(amount), 0) FROM payments WHERE collected_by = ?");
        $stmt->execute([$userId]);
        $staff_collected = (float)$stmt->fetchColumn();
        
        // Staff Sales Target
        $stmt = $db->prepare("SELECT sales_target FROM sales_staff_details WHERE user_id = ?");
        $stmt->execute([$userId]);
        $target = (float)$stmt->fetchColumn();
        
        // Monthly sales for target progress
        $stmt = $db->prepare("
            SELECT COALESCE(SUM(i.grand_total), 0) 
            FROM invoices i
            JOIN orders o ON i.order_id = o.id
            WHERE o.staff_id = ? AND MONTH(i.invoice_date) = MONTH(CURDATE()) AND YEAR(i.invoice_date) = YEAR(CURDATE())
        ");
        $stmt->execute([$userId]);
        $monthly_sales = (float)$stmt->fetchColumn();
        
        $target_progress_percentage = $target > 0 ? min(100, round(($monthly_sales / $target) * 100, 1)) : 0;
        
        $stats['target_progress'] = [
            'percentage' => $target_progress_percentage,
            'achieved' => $monthly_sales,
            'target' => $target
        ];
        
        $avg_cart = $staff_total_invoices > 0 ? $staff_total_sales / $staff_total_invoices : 0.00;
        
        $stats['metrics'] = [
            'total_sales' => [
                'label' => 'My Total Sales',
                'value' => formatRupeesPHP($staff_total_sales),
                'icon'  => 'fa-file-invoice-dollar',
                'color' => 'success'
            ],
            'total_invoices' => [
                'label' => 'My Total Invoices',
                'value' => number_format($staff_total_invoices),
                'icon'  => 'fa-receipt',
                'color' => 'primary'
            ],
            'sold_qty' => [
                'label' => 'My Sold Qty',
                'value' => number_format($staff_sold_qty) . ' Units',
                'icon'  => 'fa-cubes',
                'color' => 'info'
            ],
            'total_customers' => [
                'label' => 'Assigned Retailers',
                'value' => number_format($staff_retailers),
                'icon'  => 'fa-users',
                'color' => 'primary'
            ],
            'to_receive' => [
                'label' => 'Pending Collections',
                'value' => formatRupeesPHP($staff_outstanding),
                'icon'  => 'fa-hand-holding-usd',
                'color' => 'warning'
            ],
            'total_paid' => [
                'label' => 'Collected by Me',
                'value' => formatRupeesPHP($staff_collected),
                'icon'  => 'fa-check-circle',
                'color' => 'success'
            ],
            'avg_cart_value' => [
                'label' => 'Avg Order Value',
                'value' => formatRupeesPHP($avg_cart),
                'icon'  => 'fa-shopping-cart',
                'color' => 'warning'
            ]
        ];
        
        // Recent Orders
        $stmt = $db->prepare("
            SELECT o.id, r.shop_name, o.order_date, o.grand_total, o.status 
            FROM orders o
            JOIN retailers r ON o.retailer_id = r.id
            WHERE o.staff_id = ?
            ORDER BY o.id DESC
            LIMIT 5
        ");
        $stmt->execute([$userId]);
        $stats['recent_orders'] = $stmt->fetchAll();
        
        // Chart Data - My Sales Graph (Last 7 Days)
        $stmt = $db->prepare("
            SELECT DATE_FORMAT(d.date, '%b %d') as label_date, COALESCE(SUM(i.grand_total), 0) as total_sales
            FROM (
                SELECT CURDATE() as date UNION SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 4 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            ) d
            LEFT JOIN invoices i ON d.date = i.invoice_date
            LEFT JOIN orders o ON i.order_id = o.id AND o.staff_id = ?
            GROUP BY d.date, label_date
            ORDER BY d.date ASC
        ");
        $stmt->execute([$userId]);
        $sales_chart = $stmt->fetchAll();
        
        // Collection chart by this sales staff
        $stmt = $db->prepare("
            SELECT DATE_FORMAT(d.date, '%b %d') as label_date, COALESCE(SUM(p.amount), 0) as total_collected
            FROM (
                SELECT CURDATE() as date UNION SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 4 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            ) d
            LEFT JOIN payments p ON d.date = p.payment_date AND p.collected_by = ?
            GROUP BY d.date, label_date
            ORDER BY d.date ASC
        ");
        $stmt->execute([$userId]);
        $collection_chart = $stmt->fetchAll();
        
        // Build chart_trends
        $chart_trends = [
            'labels' => [],
            'sales' => [],
            'collections' => []
        ];
        foreach ($sales_chart as $index => $row) {
            $chart_trends['labels'][] = $row['label_date'];
            $chart_trends['sales'][] = (float)$row['total_sales'];
            
            $collected = 0.00;
            if (isset($collection_chart[$index])) {
                $collected = (float)$collection_chart[$index]['total_collected'];
            }
            $chart_trends['collections'][] = $collected;
        }
        $stats['chart_trends'] = $chart_trends;
    }
    
    sendJSON('success', 'Dashboard stats retrieved successfully.', $stats);
} catch (PDOException $e) {
    sendJSON('error', 'Database error: ' . $e->getMessage());
}
?>
