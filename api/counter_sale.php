<?php
// api/counter_sale.php
// AJAX Handler for Counter Sale (Retail Walk-in / Public Sales)

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';
$userId = $_SESSION['user_id'];
$roleName = $_SESSION['role_name'];

/**
 * Helper to ensure a default Walk-in Customer record exists in the retailers table
 */
function getOrCreateWalkinRetailer($db, $customerName = 'Walk-in Customer', $customerMobile = '') {
    $stmt = $db->prepare("SELECT id FROM retailers WHERE shop_name = 'Counter Sale (Walk-in / Public)' LIMIT 1");
    $stmt->execute();
    $existingId = $stmt->fetchColumn();

    if ($existingId) {
        return (int)$existingId;
    }

    // Create default walk-in retailer
    $stmtInsert = $db->prepare("
        INSERT INTO retailers 
        (name, shop_name, mobile, address, area, city, state, pin_code, business_type, credit_limit, outstanding_amount, status, remarks)
        VALUES 
        ('Walk-in Customer', 'Counter Sale (Walk-in / Public)', '9999999999', 'Store Counter', 'Counter', 'Goa', 'Goa', '403001', 'Retail Shop', 9999999.00, 0.00, 'Active', 'System account for Walk-in and Counter Sales')
    ");
    $stmtInsert->execute();
    return (int)$db->lastInsertId();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // 1. Get list of active SKUs for fast lookup in Counter Sale
    if ($action === 'skus') {
        try {
            $stmt = $db->query("
                SELECT s.id, s.sku_name, s.sku_code, s.selling_price, s.mrp, s.purchase_price,
                       s.current_stock, s.unit, s.gst_percentage, s.weight, s.size,
                       p.name as product_name, p.hsn_code, b.name as brand_name
                FROM skus s
                JOIN products p ON s.product_id = p.id
                JOIN brands b ON p.brand_id = b.id
                WHERE s.status = 'Active'
                ORDER BY s.sku_name ASC
            ");
            $skus = $stmt->fetchAll();
            sendJSON('success', 'SKUs loaded.', $skus);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch SKUs: ' . $e->getMessage());
        }
    }

    // 2. Get today's statistics for Counter Sales
    if ($action === 'stats') {
        try {
            $date = cleanInput($_GET['date'] ?? date('Y-m-d'));
            
            // Total today's counter sales
            $stmt = $db->prepare("
                SELECT 
                    COUNT(DISTINCT i.id) as total_sales_count,
                    COALESCE(SUM(i.grand_total), 0) as total_revenue,
                    COALESCE(SUM(CASE WHEN p.payment_method = 'Cash' THEN p.amount ELSE 0 END), 0) as cash_total,
                    COALESCE(SUM(CASE WHEN p.payment_method = 'UPI' THEN p.amount ELSE 0 END), 0) as upi_total,
                    COALESCE(SUM(CASE WHEN p.payment_method NOT IN ('Cash', 'UPI') THEN p.amount ELSE 0 END), 0) as other_total
                FROM invoices i
                LEFT JOIN payments p ON i.id = p.invoice_id
                WHERE i.invoice_date = ? AND (i.invoice_number LIKE 'CS-%' OR i.remarks LIKE '%Counter Sale%')
            ");
            $stmt->execute([$date]);
            $stats = $stmt->fetch();

            sendJSON('success', 'Stats loaded.', $stats);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch stats: ' . $e->getMessage());
        }
    }

    // 3. Get list of Counter Sales history
    if ($action === 'list') {
        try {
            $dateFilter = cleanInput($_GET['date'] ?? '');
            $where = "WHERE (i.invoice_number LIKE 'CS-%' OR i.remarks LIKE '%Counter Sale%')";
            $params = [];

            if (!empty($dateFilter)) {
                $where .= " AND i.invoice_date = ?";
                $params[] = $dateFilter;
            }

            $stmt = $db->prepare("
                SELECT i.*, 
                       (SELECT COUNT(*) FROM invoice_items ii WHERE ii.invoice_id = i.id) as items_count,
                       (SELECT payment_method FROM payments p WHERE p.invoice_id = i.id LIMIT 1) as payment_mode
                FROM invoices i
                $where
                ORDER BY i.id DESC
                LIMIT 200
            ");
            $stmt->execute($params);
            $invoices = $stmt->fetchAll();

            // Format customer names from JSON details
            foreach ($invoices as &$inv) {
                $retDetails = json_decode($inv['retailer_details'] ?? '{}', true);
                $inv['customer_display_name'] = !empty($retDetails['name']) ? $retDetails['name'] : (!empty($retDetails['shop_name']) ? $retDetails['shop_name'] : 'Walk-in Customer');
                $inv['customer_mobile'] = $retDetails['mobile'] ?? '';
            }

            sendJSON('success', 'Counter sales loaded.', $invoices);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch counter sales: ' . $e->getMessage());
        }
    }

    // 4. Detail of single Counter Sale
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("SELECT * FROM invoices WHERE id = ?");
            $stmt->execute([$id]);
            $invoice = $stmt->fetch();

            if (!$invoice) {
                sendJSON('error', 'Sale record not found.');
            }

            $stmtItems = $db->prepare("SELECT ii.*, s.mrp, s.unit FROM invoice_items ii LEFT JOIN skus s ON ii.sku_id = s.id WHERE ii.invoice_id = ?");
            $stmtItems->execute([$id]);
            $invoice['items'] = $stmtItems->fetchAll();

            $stmtPay = $db->prepare("SELECT * FROM payments WHERE invoice_id = ? LIMIT 1");
            $stmtPay->execute([$id]);
            $invoice['payment'] = $stmtPay->fetch();

            sendJSON('success', 'Sale details loaded.', $invoice);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($action === 'create') {
        $customer_name   = cleanInput($_POST['customer_name'] ?? 'Walk-in Customer');
        $customer_mobile = cleanInput($_POST['customer_mobile'] ?? '');
        $payment_method  = cleanInput($_POST['payment_method'] ?? 'Cash');
        $payment_ref     = cleanInput($_POST['payment_ref'] ?? '');
        $sale_date       = cleanInput($_POST['sale_date'] ?? date('Y-m-d'));
        $sale_remarks    = cleanInput($_POST['remarks'] ?? '');

        // Support both array cart payload and single-item payload
        $sku_ids    = $_POST['sku_ids'] ?? [];
        $quantities = $_POST['quantities'] ?? [];
        $prices     = $_POST['prices'] ?? [];
        $discounts  = $_POST['discounts'] ?? [];

        // Single item fallback if submitted directly
        if (empty($sku_ids) && isset($_POST['sku_id'])) {
            $sku_ids    = [$_POST['sku_id']];
            $quantities = [$_POST['quantity'] ?? 1];
            $prices     = [$_POST['price'] ?? 0];
            $discounts  = [$_POST['discount'] ?? 0];
        }

        if (empty($sku_ids) || count($sku_ids) === 0) {
            sendJSON('error', 'Please select at least one item for the sale.');
        }

        $db->beginTransaction();
        try {
            $walkinRetailerId = getOrCreateWalkinRetailer($db, $customer_name, $customer_mobile);

            $total_subtotal = 0.00;
            $total_discount = 0.00;
            $total_gst      = 0.00;
            $grand_total    = 0.00;

            $items_to_bill = [];

            for ($i = 0; $i < count($sku_ids); $i++) {
                $sku_id = (int)$sku_ids[$i];
                $qty    = (int)$quantities[$i];
                $price  = (float)($prices[$i] ?? 0.00);
                $disc   = (float)($discounts[$i] ?? 0.00);

                if ($sku_id <= 0 || $qty <= 0) continue;

                // Check SKU details and stock
                $stmtSku = $db->prepare("
                    SELECT id, sku_name, sku_code, purchase_price, selling_price, mrp, 
                           current_stock, gst_percentage, unit 
                    FROM skus 
                    WHERE id = ? FOR UPDATE
                ");
                $stmtSku->execute([$sku_id]);
                $sku = $stmtSku->fetch();

                if (!$sku) {
                    throw new Exception("SKU ID {$sku_id} not found.");
                }

                $availableStock = (int)$sku['current_stock'];
                if ($availableStock < $qty) {
                    throw new Exception("Insufficient stock for '{$sku['sku_name']}'. Available: {$availableStock}, Requested: {$qty}");
                }

                // If price was not specified or negative, fall back to selling_price
                if ($price <= 0) {
                    $price = (float)$sku['selling_price'];
                }

                $purchase_price = (float)$sku['purchase_price'];
                if ($purchase_price > 0 && $price < $purchase_price) {
                    throw new Exception("Rate for '{$sku['sku_name']}' (₹" . number_format($price, 2) . ") cannot be lower than purchase rate of ₹" . number_format($purchase_price, 2) . ".");
                }

                $gross_line = $price * $qty;
                // Line discount (ensure not exceeding gross)
                $line_disc  = min($gross_line, max(0.00, $disc));
                $taxable    = max(0.00, $gross_line - $line_disc);

                if ($purchase_price > 0 && ($taxable / $qty) < $purchase_price) {
                    throw new Exception("Net rate after discount for '{$sku['sku_name']}' (₹" . number_format($taxable / $qty, 2) . ") cannot be lower than purchase rate of ₹" . number_format($purchase_price, 2) . ".");
                }

                $gst_pct    = (float)$sku['gst_percentage'];
                $line_gst   = ($taxable * $gst_pct) / 100.00;
                $line_total = $taxable + $line_gst;

                $total_subtotal += $gross_line;
                $total_discount += $line_disc;
                $total_gst      += $line_gst;
                $grand_total    += $line_total;

                $items_to_bill[] = [
                    'sku_id'         => $sku_id,
                    'sku_name'       => $sku['sku_name'],
                    'sku_code'       => $sku['sku_code'],
                    'quantity'       => $qty,
                    'purchase_price' => (float)$sku['purchase_price'],
                    'selling_price'  => $price,
                    'discount_amount'=> $line_disc,
                    'gst_percentage' => $gst_pct,
                    'gst_amount'     => $line_gst,
                    'total_amount'   => $line_total,
                    'prev_stock'     => $availableStock,
                    'new_stock'      => $availableStock - $qty
                ];
            }

            if (empty($items_to_bill)) {
                throw new Exception("No valid items in the sale.");
            }

            // Generate unique Counter Sale invoice number
            $invoice_prefix = 'CS-' . date('Ymd') . '-';
            $prefix_length = strlen($invoice_prefix) + 1;

            $stmtMax = $db->prepare("
                SELECT MAX(CAST(SUBSTRING(invoice_number, ?) AS UNSIGNED)) 
                FROM invoices 
                WHERE invoice_number LIKE ?
            ");
            $stmtMax->execute([$prefix_length, $invoice_prefix . '%']);
            $max_num = $stmtMax->fetchColumn();
            $invoice_count = ($max_num ?: 0) + 1;
            $invoice_number = $invoice_prefix . str_pad($invoice_count, 4, '0', STR_PAD_LEFT);

            // Company & Retailer Details JSON
            $company_details = json_encode([
                'name'    => getSetting('company_name', 'NAVATARA ENTERPRISES'),
                'address' => getSetting('company_address', 'Goa'),
                'mobile'  => getSetting('company_mobile', ''),
                'email'   => getSetting('company_email', ''),
                'gst'     => getSetting('company_gst', ''),
                'pan'     => getSetting('company_pan', '')
            ]);

            $retailer_details = json_encode([
                'shop_name'  => !empty($customer_name) ? "Counter: " . $customer_name : "Walk-in Customer",
                'name'       => !empty($customer_name) ? $customer_name : "Walk-in Customer",
                'mobile'     => $customer_mobile,
                'address'    => 'Store Counter Walk-in Sale',
                'area'       => 'Counter',
                'city'       => 'Goa',
                'pin_code'   => '403001',
                'gst_number' => ''
            ]);

            $remarks = "Counter Sale (Public Retail) | Mode: {$payment_method}";
            if (!empty($payment_ref)) {
                $remarks .= " | Ref: {$payment_ref}";
            }
            if (!empty($sale_remarks)) {
                $remarks .= " | Notes: {$sale_remarks}";
            }

            // 1. Insert Invoice Header (Cash Invoice, fully paid)
            $stmtInvoice = $db->prepare("
                INSERT INTO invoices 
                (order_id, retailer_id, invoice_number, invoice_type, invoice_date, company_details, retailer_details, 
                 subtotal, discount_amount, gst_amount, grand_total, paid_amount, outstanding_amount, payment_status, remarks) 
                VALUES (?, ?, ?, 'Cash Invoice', ?, ?, ?, ?, ?, ?, ?, ?, 0.00, 'Paid', ?)
            ");
            $stmtInvoice->execute([
                null,
                $walkinRetailerId,
                $invoice_number,
                $sale_date,
                $company_details,
                $retailer_details,
                $total_subtotal,
                $total_discount,
                $total_gst,
                $grand_total,
                $grand_total, // 100% paid
                $remarks
            ]);
            $invoiceId = (int)$db->lastInsertId();

            // 2. Insert Invoice Items & Deduct Stock
            $stmtInvItem = $db->prepare("
                INSERT INTO invoice_items 
                (invoice_id, sku_id, sku_name, sku_code, quantity, purchase_price, selling_price, discount_amount, gst_percentage, gst_amount, total_amount)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ");

            $stmtStockReduce = $db->prepare("UPDATE skus SET current_stock = current_stock - ? WHERE id = ?");
            $stmtHistLog = $db->prepare("
                INSERT INTO inventory_history (sku_id, transaction_type, quantity, previous_stock, new_stock, reference_id, reference_type, remarks)
                VALUES (?, 'Invoice Reduction', ?, ?, ?, ?, 'Invoices', ?)
            ");

            foreach ($items_to_bill as $item) {
                // Save item
                $stmtInvItem->execute([
                    $invoiceId,
                    $item['sku_id'],
                    $item['sku_name'],
                    $item['sku_code'],
                    $item['quantity'],
                    $item['purchase_price'],
                    $item['selling_price'],
                    $item['discount_amount'],
                    $item['gst_percentage'],
                    $item['gst_amount'],
                    $item['total_amount']
                ]);

                // Reduce stock
                $stmtStockReduce->execute([$item['quantity'], $item['sku_id']]);

                // Log inventory movement
                $histNote = "Counter Sale Bill #{$invoice_number} ({$customer_name})";
                $stmtHistLog->execute([
                    $item['sku_id'],
                    $item['quantity'],
                    $item['prev_stock'],
                    $item['new_stock'],
                    $invoiceId,
                    $histNote
                ]);
            }

            // 3. Record instant payment
            $stmtPay = $db->prepare("
                INSERT INTO payments 
                (retailer_id, invoice_id, payment_date, payment_type, payment_method, amount, reference_number, remarks, collected_by)
                VALUES (?, ?, ?, 'Full Payment', ?, ?, ?, ?, ?)
            ");
            $payRef = !empty($payment_ref) ? $payment_ref : 'CS-PAID';
            $stmtPay->execute([
                $walkinRetailerId,
                $invoiceId,
                $sale_date,
                $payment_method,
                $grand_total,
                $payRef,
                "Instant payment for Counter Sale {$invoice_number}",
                $userId
            ]);

            $db->commit();

            logActivity('Counter Sale', "Created Counter Sale Invoice: {$invoice_number} for {$customer_name}. Total: " . formatRupees($grand_total));

            sendJSON('success', "Counter Sale #{$invoice_number} recorded successfully!", [
                'invoice_id'     => $invoiceId,
                'invoice_number' => $invoice_number,
                'grand_total'    => $grand_total,
                'customer_name'  => $customer_name,
                'payment_method' => $payment_method
            ]);
        } catch (Exception $e) {
            if ($db->inTransaction()) {
                $db->rollBack();
            }
            sendJSON('error', 'Sale failed: ' . $e->getMessage());
        }
    }
}
?>
