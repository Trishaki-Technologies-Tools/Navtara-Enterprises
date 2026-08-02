<?php
// api/invoices.php
// AJAX Handler for Billing, Invoice Generation, and Ledger integration

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';
$roleName = $_SESSION['role_name'];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        try {
            // Both owner and staff can view invoices (staff can view those of their assigned retailers)
            if ($roleName === 'Owner') {
                $stmt = $db->query("
                    SELECT i.*, r.shop_name, r.name as retailer_name
                    FROM invoices i
                    JOIN retailers r ON i.retailer_id = r.id
                    ORDER BY i.invoice_date DESC, i.id DESC
                ");
            } else {
                $stmt = $db->prepare("
                    SELECT i.*, r.shop_name, r.name as retailer_name
                    FROM invoices i
                    JOIN retailers r ON i.retailer_id = r.id
                    WHERE r.assigned_staff_id = ?
                    ORDER BY i.invoice_date DESC, i.id DESC
                ");
                $stmt->execute([$_SESSION['user_id']]);
            }
            $invoices = $stmt->fetchAll();
            sendJSON('success', 'Invoices loaded.', $invoices);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch invoices: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("
                SELECT i.*, r.shop_name, r.name as retailer_name, r.mobile, r.address, r.gst_number, r.credit_limit
                FROM invoices i
                JOIN retailers r ON i.retailer_id = r.id
                WHERE i.id = ?
            ");
            $stmt->execute([$id]);
            $invoice = $stmt->fetch();
            if ($invoice) {
                // Fetch items
                $stmtItems = $db->prepare("
                    SELECT ii.*, s.mrp 
                    FROM invoice_items ii
                    LEFT JOIN skus s ON ii.sku_id = s.id 
                    WHERE ii.invoice_id = ?
                ");
                $stmtItems->execute([$id]);
                $invoice['items'] = $stmtItems->fetchAll();
                
                sendJSON('success', 'Invoice loaded.', $invoice);
            } else {
                sendJSON('error', 'Invoice not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    checkRole('Owner'); // Only the Owner can perform billing actions
    
    if ($action === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid invoice ID.');
        }

        $db->beginTransaction();
        try {
            // 1. Load invoice
            $stmtInv = $db->prepare("SELECT * FROM invoices WHERE id = ? FOR UPDATE");
            $stmtInv->execute([$id]);
            $invoice = $stmtInv->fetch();
            if (!$invoice) {
                throw new Exception("Invoice not found.");
            }

            $retailer_id   = (int)$invoice['retailer_id'];
            $grand_total   = (float)$invoice['grand_total'];
            $invoice_number = $invoice['invoice_number'];
            $outstanding_on_invoice = (float)$invoice['outstanding_amount'];

            // 2. Restore stock for every line item
            $stmtItems = $db->prepare("SELECT * FROM invoice_items WHERE invoice_id = ?");
            $stmtItems->execute([$id]);
            $items = $stmtItems->fetchAll();

            $stmtRestoreStock = $db->prepare("UPDATE skus SET current_stock = current_stock + ? WHERE id = ?");
            $stmtHistLog = $db->prepare("
                INSERT INTO inventory_history
                    (sku_id, transaction_type, quantity, previous_stock, new_stock, reference_id, reference_type, remarks)
                VALUES (?, 'Stock Addition', ?, ?, ?, ?, 'Invoices', ?)
            ");

            foreach ($items as $item) {
                $stmtCurStock = $db->prepare("SELECT current_stock FROM skus WHERE id = ?");
                $stmtCurStock->execute([$item['sku_id']]);
                $prev = (int)$stmtCurStock->fetchColumn();
                $newStock = $prev + (int)$item['quantity'];

                $stmtRestoreStock->execute([$item['quantity'], $item['sku_id']]);
                $stmtHistLog->execute([
                    $item['sku_id'],
                    $item['quantity'],
                    $prev,
                    $newStock,
                    $id,
                    "Stock restored — Invoice {$invoice_number} deleted"
                ]);
            }

            // 3. Reverse retailer outstanding
            //    Only the outstanding portion still owed affects the balance now.
            //    Paid portions were already credited via payment entries; we only remove
            //    the unpaid outstanding still sitting on the retailer.
            $stmtRet = $db->prepare("SELECT outstanding_amount FROM retailers WHERE id = ? FOR UPDATE");
            $stmtRet->execute([$retailer_id]);
            $retailerRow = $stmtRet->fetch();
            $currentOutstanding = (float)$retailerRow['outstanding_amount'];
            $newOutstanding = max(0, $currentOutstanding - $outstanding_on_invoice);

            $db->prepare("UPDATE retailers SET outstanding_amount = ? WHERE id = ?")
               ->execute([$newOutstanding, $retailer_id]);

            // 4. Remove customer ledger entries tied to this invoice
            $db->prepare("DELETE FROM customer_ledger WHERE reference_id = ? AND reference_type = 'Invoices'")
               ->execute([$id]);

            // 5. If Cash Invoice — also remove the auto-created payment + its ledger entry
            if ($invoice['invoice_type'] === 'Cash Invoice') {
                $stmtCashPay = $db->prepare("SELECT id FROM payments WHERE invoice_id = ? AND reference_number = 'CASH-PAY'");
                $stmtCashPay->execute([$id]);
                $cashPayIds = $stmtCashPay->fetchAll(PDO::FETCH_COLUMN);
                foreach ($cashPayIds as $pid) {
                    $db->prepare("DELETE FROM customer_ledger WHERE reference_id = ? AND reference_type = 'Payments'")
                       ->execute([$pid]);
                }
                $db->prepare("DELETE FROM payments WHERE invoice_id = ? AND reference_number = 'CASH-PAY'")
                   ->execute([$id]);
            }

            // 6. Cancel the linked order
            if (!empty($invoice['order_id'])) {
                $db->prepare("UPDATE orders SET status = 'Cancelled' WHERE id = ?")
                   ->execute([$invoice['order_id']]);
            }

            // 7. Delete invoice (invoice_items cascade via FK)
            $db->prepare("DELETE FROM invoices WHERE id = ?")->execute([$id]);

            $db->commit();

            logActivity('Delete Invoice', "Deleted Invoice {$invoice_number}. Stock restored for " . count($items) . " SKUs. Outstanding reduced by " . formatRupees($outstanding_on_invoice));
            sendJSON('success', "Invoice {$invoice_number} deleted. Stock has been restored.");

        } catch (Exception $e) {
            if ($db->inTransaction()) $db->rollBack();
            sendJSON('error', 'Delete failed: ' . $e->getMessage());
        }
    }

    if ($action === 'generate') {
        $order_id = (int)($_POST['order_id'] ?? 0);
        $invoice_type = cleanInput($_POST['invoice_type'] ?? 'GST Invoice'); // 'GST Invoice', 'Non GST Invoice', 'Cash Invoice', 'Credit Invoice'
        $invoice_date = cleanInput($_POST['invoice_date'] ?? date('Y-m-d'));
        $remarks = cleanInput($_POST['remarks'] ?? '');
        
        if ($order_id <= 0) {
            sendJSON('error', 'Please provide a valid Order ID.');
        }
        
        $db->beginTransaction();
        try {
            // 1. Fetch order details
            $stmtOrder = $db->prepare("SELECT * FROM orders WHERE id = ? FOR UPDATE");
            $stmtOrder->execute([$order_id]);
            $order = $stmtOrder->fetch();
            if (!$order) {
                throw new Exception("Order not found.");
            }
            if ($order['status'] !== 'Approved' && $order['status'] !== 'Pending' && $order['status'] !== 'Processing') {
                throw new Exception("Only approved/pending orders can be billed. Current order status: " . $order['status']);
            }
            
            $retailer_id = (int)$order['retailer_id'];
            $grand_total = (float)$order['grand_total'];
            
            // 2. Retailer Credit Limit Check
            $stmtRet = $db->prepare("SELECT shop_name, credit_limit, outstanding_amount FROM retailers WHERE id = ? FOR UPDATE");
            $stmtRet->execute([$retailer_id]);
            $retailer = $stmtRet->fetch();
            if (!$retailer) {
                throw new Exception("Retailer not found.");
            }
            
            $credit_limit = (float)$retailer['credit_limit'];
            $outstanding = (float)$retailer['outstanding_amount'];
            
            // Check: "Outstanding >= Credit Limit. Do Not Allow New Invoice. CREDIT LIMIT REACHED"
            if ($outstanding >= $credit_limit) {
                throw new Exception("CREDIT LIMIT REACHED: Current outstanding (" . formatRupees($outstanding) . ") equals or exceeds limit (" . formatRupees($credit_limit) . "). Bill blocked.");
            }
            
            // 3. Stock Availability Verification
            $stmtOrderItems = $db->prepare("SELECT oi.*, s.sku_name, s.current_stock FROM order_items oi JOIN skus s ON oi.sku_id = s.id WHERE oi.order_id = ?");
            $stmtOrderItems->execute([$order_id]);
            $orderItems = $stmtOrderItems->fetchAll();
            
            foreach ($orderItems as $item) {
                if ($item['current_stock'] < $item['quantity']) {
                    throw new Exception("Insufficient stock for item: {$item['sku_name']}. Available: {$item['current_stock']}, Required: {$item['quantity']}");
                }
            }
            
            // 4. Generate unique invoice number
            $invoice_prefix = getSetting('invoice_prefix', 'NE/2026-27/');
            $prefix_length = strlen($invoice_prefix) + 1; // +1 for 1-based indexing in SQL SUBSTRING
            
            $stmtMax = $db->prepare("
                SELECT MAX(CAST(SUBSTRING(invoice_number, ?) AS UNSIGNED)) 
                FROM invoices 
                WHERE invoice_number LIKE ?
            ");
            $stmtMax->execute([$prefix_length, $invoice_prefix . '%']);
            $max_num = $stmtMax->fetchColumn();
            
            $invoice_count = ($max_num ?: 0) + 1;
            $invoice_number = $invoice_prefix . str_pad($invoice_count, 4, '0', STR_PAD_LEFT);
            
            // Fetch company settings for invoice details
            $company_details = json_encode([
                'name'    => getSetting('company_name', 'NAVATARA ENTERPRISES'),
                'address' => getSetting('company_address', 'Goa'),
                'mobile'  => getSetting('company_mobile', ''),
                'email'   => getSetting('company_email', ''),
                'gst'     => getSetting('company_gst', ''),
                'pan'     => getSetting('company_pan', '')
            ]);
            
            // Fetch retailer profile for details
            $retailer_details = json_encode([
                'shop_name'  => $retailer['shop_name'],
                'mobile'     => $retailer['mobile'] ?? '',
                'address'    => $retailer['address'] ?? '',
                'gst_number' => $retailer['gst_number'] ?? ''
            ]);
            
            // Cash Invoice is paid fully instantly
            $paid_amount = 0.00;
            $payment_status = 'Unpaid';
            if ($invoice_type === 'Cash Invoice') {
                $paid_amount = $grand_total;
                $payment_status = 'Paid';
            }
            $outstanding_invoice = $grand_total - $paid_amount;
            
            // 5. Insert Invoice Header
            $stmtInvoice = $db->prepare("
                INSERT INTO invoices 
                (order_id, retailer_id, invoice_number, invoice_type, invoice_date, company_details, retailer_details, subtotal, discount_amount, gst_amount, grand_total, paid_amount, outstanding_amount, payment_status, remarks) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmtInvoice->execute([
                $order_id, $retailer_id, $invoice_number, $invoice_type, $invoice_date, $company_details, $retailer_details, 
                $order['total_amount'], $order['discount_amount'], $order['gst_amount'], $grand_total, $paid_amount, $outstanding_invoice, $payment_status, $remarks
            ]);
            $invoiceId = $db->lastInsertId();
            
            // 6. Insert Items & Reduce Stock
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
            
            foreach ($orderItems as $item) {
                // Fetch purchase price from SKUs for inventory costing
                $stmtPrice = $db->prepare("SELECT purchase_price, current_stock, sku_name, sku_code FROM skus WHERE id = ?");
                $stmtPrice->execute([$item['sku_id']]);
                $skuData = $stmtPrice->fetch();
                $purchase_price = (float)$skuData['purchase_price'];
                $prev_stock = (int)$skuData['current_stock'];
                $new_stock = $prev_stock - $item['quantity'];
                
                // Save Item
                $stmtInvItem->execute([
                    $invoiceId, $item['sku_id'], $skuData['sku_name'], $skuData['sku_code'], $item['quantity'], 
                    $purchase_price, $item['price'], $item['discount_amount'], $item['gst_percentage'], $item['gst_amount'], $item['total_amount']
                ]);
                
                // Update stock
                $stmtStockReduce->execute([$item['quantity'], $item['sku_id']]);
                
                // Log stock movement
                $histRemarks = "Invoiced via Invoice No: {$invoice_number}";
                $stmtHistLog->execute([$item['sku_id'], $item['quantity'], $prev_stock, $new_stock, $invoiceId, $histRemarks]);
            }
            
            // 7. Update Customer Ledger & Retailer Outstanding
            // If Cash Invoice, it debits invoice and immediately credits cash payment (so ledger balance remains consistent)
            $db->commit(); // Commit main invoice block
            
            // We call helper to debit invoice
            updateCustomerLedger(
                $retailer_id, 
                'Invoice', 
                $invoice_date, 
                $invoiceId, 
                'Invoices', 
                $grand_total, 
                0.00, 
                "Debited Invoice No: {$invoice_number}"
            );
            
            if ($invoice_type === 'Cash Invoice') {
                // Record instant payment
                $stmtPay = $db->prepare("
                    INSERT INTO payments (retailer_id, invoice_id, payment_date, payment_type, payment_method, amount, reference_number, remarks)
                    VALUES (?, ?, ?, 'Full Payment', 'Cash', ?, 'CASH-PAY', 'Instant payment for Cash Invoice')
                ");
                $stmtPay->execute([$retailer_id, $invoiceId, $invoice_date, $grand_total]);
                $payId = $db->lastInsertId();
                
                // Credit the payment to ledger
                updateCustomerLedger(
                    $retailer_id, 
                    'Payment', 
                    $invoice_date, 
                    $payId, 
                    'Payments', 
                    0.00, 
                    $grand_total, 
                    "Instant cash payment for Invoice No: {$invoice_number}"
                );
            }
            
            // 8. Update Order status to Completed
            $db->beginTransaction();
            $stmtUpdateOrder = $db->prepare("UPDATE orders SET status = 'Completed' WHERE id = ?");
            $stmtUpdateOrder->execute([$order_id]);
            $db->commit();
            
            logActivity('Generate Invoice', "Invoiced Order ID: {$order_id} -> Invoice No: {$invoice_number}. Grand Total: {$grand_total}");
            sendJSON('success', "Invoice {$invoice_number} generated successfully.", ['invoice_id' => $invoiceId]);
        } catch (Exception $e) {
            if ($db->inTransaction()) {
                $db->rollBack();
            }
            sendJSON('error', $e->getMessage());
        }
    }
}
?>
