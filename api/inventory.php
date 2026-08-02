<?php
// api/inventory.php
// AJAX Handler for Inventory Stock Adjustments & Movement History

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'purchases_list') {
        try {
            $stmt = $db->query("SELECT * FROM purchases ORDER BY id DESC");
            $purchases = $stmt->fetchAll();
            sendJSON('success', 'Purchases loaded.', $purchases);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch purchases: ' . $e->getMessage());
        }
    }
    
    if ($action === 'purchase_detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("SELECT * FROM purchases WHERE id = ?");
            $stmt->execute([$id]);
            $purchase = $stmt->fetch();
            if ($purchase) {
                $stmtItems = $db->prepare("
                    SELECT pi.*, s.sku_name, s.sku_code
                    FROM purchase_items pi
                    JOIN skus s ON pi.sku_id = s.id
                    WHERE pi.purchase_id = ?
                ");
                $stmtItems->execute([$id]);
                $purchase['items'] = $stmtItems->fetchAll();
                sendJSON('success', 'Purchase details loaded.', $purchase);
            } else {
                sendJSON('error', 'Purchase not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }

    if ($action === 'history') {
        try {
            $stmt = $db->query("
                SELECT ih.*, s.sku_name, s.sku_code, u.fullname as user_name
                FROM inventory_history ih
                JOIN skus s ON ih.sku_id = s.id
                LEFT JOIN users u ON ih.remarks LIKE CONCAT('%By User ID: ', u.id, '%') 
                                  OR ih.remarks LIKE CONCAT('%User: ', u.fullname, '%')
                ORDER BY ih.id DESC
            ");
            $history = $stmt->fetchAll();
            sendJSON('success', 'Inventory history loaded.', $history);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch inventory history: ' . $e->getMessage());
        }
    }
    
    if ($action === 'low_stock') {
        try {
            $stmt = $db->query("
                SELECT s.*, p.name as product_name, b.name as brand_name
                FROM skus s
                JOIN products p ON s.product_id = p.id
                JOIN brands b ON p.brand_id = b.id
                WHERE s.current_stock <= s.minimum_stock AND s.status = 'Active'
                ORDER BY s.current_stock ASC
            ");
            $lowStock = $stmt->fetchAll();
            sendJSON('success', 'Low stock items loaded.', $lowStock);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch low stock items: ' . $e->getMessage());
        }
    }
    
    if ($action === 'valuation') {
        try {
            $stmt = $db->query("
                SELECT s.sku_name, s.sku_code, s.purchase_price, s.selling_price, s.current_stock,
                       (s.purchase_price * s.current_stock) as valuation_purchase,
                       (s.selling_price * s.current_stock) as valuation_selling
                FROM skus s
                WHERE s.status = 'Active'
                ORDER BY valuation_purchase DESC
            ");
            $valuation = $stmt->fetchAll();
            
            $summary = [
                'total_items' => count($valuation),
                'total_qty' => array_sum(array_column($valuation, 'current_stock')),
                'total_valuation_purchase' => array_sum(array_column($valuation, 'valuation_purchase')),
                'total_valuation_selling' => array_sum(array_column($valuation, 'valuation_selling'))
            ];
            
            sendJSON('success', 'Valuation report generated.', [
                'details' => $valuation,
                'summary' => $summary
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to generate valuation report: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    checkRole('Owner'); // Only Owners can modify inventory manually
    
    if ($action === 'purchase_entry' || $action === 'purchase') {
        $sku_ids = $_POST['sku_ids'] ?? []; // Array
        $quantities = $_POST['quantities'] ?? []; // Array corresponding to SKU IDs
        $supplier_name = cleanInput($_POST['supplier_name'] ?? '');
        $invoice_no = cleanInput($_POST['supplier_invoice'] ?? '');
        $purchase_date = cleanInput($_POST['purchase_date'] ?? date('Y-m-d'));
        $payment_mode = cleanInput($_POST['payment_mode'] ?? 'Unpaid');
        $discounts = $_POST['discounts'] ?? [];
        $remarks = cleanInput($_POST['remarks'] ?? '');
        
        if (empty($sku_ids) || count($sku_ids) !== count($quantities)) {
            sendJSON('error', 'Please add at least one SKU with a valid quantity.');
        }
        if (empty($supplier_name) || empty($invoice_no)) {
            sendJSON('error', 'Supplier Name and Invoice Number are required.');
        }
        
        $db->beginTransaction();
        try {
            // Check for duplicate invoice number
            $stmtCheck = $db->prepare("SELECT COUNT(*) FROM purchases WHERE supplier_invoice = ?");
            $stmtCheck->execute([$invoice_no]);
            if ($stmtCheck->fetchColumn() > 0) {
                throw new Exception("Supplier invoice number '{$invoice_no}' has already been recorded.");
            }

            $total_subtotal = 0.00;
            $total_discount = 0.00;
            $total_gst = 0.00;
            $total_grand = 0.00;
            $items_to_insert = [];

            for ($i = 0; $i < count($sku_ids); $i++) {
                $sku_id = (int)$sku_ids[$i];
                $qty = (int)$quantities[$i];
                $disc = (float)($discounts[$i] ?? 0.00);
                
                if ($qty <= 0) continue;
                
                $stmt = $db->prepare("SELECT purchase_price, gst_percentage, current_stock, sku_name, sku_code FROM skus WHERE id = ? FOR UPDATE");
                $stmt->execute([$sku_id]);
                $sku = $stmt->fetch();
                if (!$sku) {
                    throw new Exception("SKU ID {$sku_id} not found.");
                }
                
                $purchase_price = (float)$sku['purchase_price'];
                $gst_pct = (float)$sku['gst_percentage'];
                
                $gross_subtotal = $purchase_price * $qty;
                $item_disc = min($gross_subtotal, $disc);
                $taxable_value = $gross_subtotal - $item_disc;
                
                $item_gst = ($taxable_value * $gst_pct) / 100;
                $item_total = $taxable_value + $item_gst;
                
                $total_subtotal += $gross_subtotal;
                $total_discount += $item_disc;
                $total_gst += $item_gst;
                $total_grand += $item_total;
                
                $items_to_insert[] = [
                    'sku_id' => $sku_id,
                    'quantity' => $qty,
                    'purchase_price' => $purchase_price,
                    'discount_amount' => $item_disc,
                    'gst_percentage' => $gst_pct,
                    'gst_amount' => $item_gst,
                    'total_amount' => $item_total,
                    'prev_stock' => (int)$sku['current_stock'],
                    'sku_name' => $sku['sku_name']
                ];
            }

            if (empty($items_to_insert)) {
                throw new Exception("No valid items in the purchase list.");
            }

            // Insert Purchase Header
            $stmtPurchase = $db->prepare("
                INSERT INTO purchases (supplier_name, supplier_invoice, purchase_date, subtotal, discount_amount, gst_amount, grand_total, remarks)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmtPurchase->execute([$supplier_name, $invoice_no, $purchase_date, $total_subtotal, $total_discount, $total_gst, $total_grand, $remarks]);
            $purchaseId = $db->lastInsertId();

            // Insert Items & Update Stock & History
            $stmtItemInsert = $db->prepare("
                INSERT INTO purchase_items (purchase_id, sku_id, quantity, purchase_price, discount_amount, gst_percentage, gst_amount, total_amount)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ");
            
            $stmtUpdate = $db->prepare("UPDATE skus SET current_stock = current_stock + ? WHERE id = ?");
            
            $stmtHist = $db->prepare("
                INSERT INTO inventory_history (sku_id, transaction_type, quantity, previous_stock, new_stock, remarks, reference_id, reference_type)
                VALUES (?, 'Purchase Entry', ?, ?, ?, ?, ?, 'purchase')
            ");

            foreach ($items_to_insert as $item) {
                // Insert item record
                $stmtItemInsert->execute([
                    $purchaseId, $item['sku_id'], $item['quantity'], $item['purchase_price'], $item['discount_amount'],
                    $item['gst_percentage'], $item['gst_amount'], $item['total_amount']
                ]);
                
                // Update stock
                $stmtUpdate->execute([$item['quantity'], $item['sku_id']]);
                
                // Log history
                $newStock = $item['prev_stock'] + $item['quantity'];
                $histRemarks = "Purchase Entry. Supplier Invoice: {$invoice_no}. " . $remarks . " (Recorded by User: " . $_SESSION['fullname'] . ")";
                $stmtHist->execute([$item['sku_id'], $item['quantity'], $item['prev_stock'], $newStock, $histRemarks, $purchaseId]);
                
                logActivity('Inventory Purchase Entry', "Added {$item['quantity']} units to SKU {$item['sku_name']} via Purchase Entry.");
            }
            
            // Record payment if not unpaid
            if ($payment_mode !== 'Unpaid') {
                $stmtPayment = $db->prepare("
                    INSERT INTO supplier_payments (supplier_name, payment_date, amount, payment_mode, reference_number, remarks)
                    VALUES (?, ?, ?, ?, ?, ?)
                ");
                $paymentRemarks = "Auto-generated for Purchase Invoice: {$invoice_no}";
                $stmtPayment->execute([$supplier_name, $purchase_date, $total_grand, $payment_mode, $invoice_no, $paymentRemarks]);
            }
            
            $db->commit();
            sendJSON('success', 'Purchase entry recorded, financial log created and inventory updated.');
        } catch (Exception $e) {
            $db->rollBack();
            sendJSON('error', 'Purchase entry failed: ' . $e->getMessage());
        }
    }
    
    if ($action === 'purchase_update') {
        $purchase_id = (int)($_POST['purchase_id'] ?? 0);
        $sku_ids = $_POST['sku_ids'] ?? []; // Array
        $quantities = $_POST['quantities'] ?? []; // Array
        $supplier_name = cleanInput($_POST['supplier_name'] ?? '');
        $invoice_no = cleanInput($_POST['supplier_invoice'] ?? '');
        $purchase_date = cleanInput($_POST['purchase_date'] ?? date('Y-m-d'));
        $discounts = $_POST['discounts'] ?? [];
        $remarks = cleanInput($_POST['remarks'] ?? '');
        
        if ($purchase_id <= 0) {
            sendJSON('error', 'Invalid Purchase ID.');
        }
        if (empty($sku_ids) || count($sku_ids) !== count($quantities)) {
            sendJSON('error', 'Please add at least one SKU with a valid quantity.');
        }
        if (empty($supplier_name) || empty($invoice_no)) {
            sendJSON('error', 'Supplier Name and Invoice Number are required.');
        }
        
        $db->beginTransaction();
        try {
            // Check for duplicate invoice number (excluding this purchase)
            $stmtCheck = $db->prepare("SELECT COUNT(*) FROM purchases WHERE supplier_invoice = ? AND id != ?");
            $stmtCheck->execute([$invoice_no, $purchase_id]);
            if ($stmtCheck->fetchColumn() > 0) {
                throw new Exception("Supplier invoice number '{$invoice_no}' has already been recorded on another purchase.");
            }
            
            // 1. Fetch old items and reverse stock changes
            $stmtOldItems = $db->prepare("SELECT * FROM purchase_items WHERE purchase_id = ?");
            $stmtOldItems->execute([$purchase_id]);
            $oldItems = $stmtOldItems->fetchAll();
            
            $stmtReduceStock = $db->prepare("UPDATE skus SET current_stock = current_stock - ? WHERE id = ?");
            
            foreach ($oldItems as $oldItem) {
                // Get current stock
                $stmtStock = $db->prepare("SELECT current_stock, sku_name FROM skus WHERE id = ? FOR UPDATE");
                $stmtStock->execute([$oldItem['sku_id']]);
                $sku = $stmtStock->fetch();
                if ($sku) {
                    // Update stock
                    $stmtReduceStock->execute([$oldItem['quantity'], $oldItem['sku_id']]);
                }
            }
            
            // Delete matching inventory history logs for this purchase
            $likeInvoice1 = "%Invoice: " . $invoice_no . "%";
            $likeInvoice2 = "%Supplier Invoice: " . $invoice_no . "%";
            $stmtDelHist = $db->prepare("
                DELETE FROM inventory_history 
                WHERE (reference_id = ? AND reference_type = 'purchase')
                   OR ((remarks LIKE ? OR remarks LIKE ?) AND transaction_type IN ('Purchase Entry', 'Purchase Correction', 'Purchase Deletion'))
            ");
            $stmtDelHist->execute([$purchase_id, $likeInvoice1, $likeInvoice2]);
            
            // Delete old items
            $stmtDelItems = $db->prepare("DELETE FROM purchase_items WHERE purchase_id = ?");
            $stmtDelItems->execute([$purchase_id]);
            
            // 2. Process new items and calculate totals
            $total_subtotal = 0.00;
            $total_discount = 0.00;
            $total_gst = 0.00;
            $total_grand = 0.00;
            $items_to_insert = [];
            
            for ($i = 0; $i < count($sku_ids); $i++) {
                $sku_id = (int)$sku_ids[$i];
                $qty = (int)$quantities[$i];
                $disc = (float)($discounts[$i] ?? 0.00);
                
                if ($qty <= 0) continue;
                
                $stmt = $db->prepare("SELECT purchase_price, gst_percentage, current_stock, sku_name FROM skus WHERE id = ? FOR UPDATE");
                $stmt->execute([$sku_id]);
                $sku = $stmt->fetch();
                if (!$sku) {
                    throw new Exception("SKU ID {$sku_id} not found.");
                }
                
                $purchase_price = (float)$sku['purchase_price'];
                $gst_pct = (float)$sku['gst_percentage'];
                
                $gross_subtotal = $purchase_price * $qty;
                $item_disc = min($gross_subtotal, $disc);
                $taxable_value = $gross_subtotal - $item_disc;
                
                $item_gst = ($taxable_value * $gst_pct) / 100;
                $item_total = $taxable_value + $item_gst;
                
                $total_subtotal += $gross_subtotal;
                $total_discount += $item_disc;
                $total_gst += $item_gst;
                $total_grand += $item_total;
                
                $items_to_insert[] = [
                    'sku_id' => $sku_id,
                    'quantity' => $qty,
                    'purchase_price' => $purchase_price,
                    'discount_amount' => $item_disc,
                    'gst_percentage' => $gst_pct,
                    'gst_amount' => $item_gst,
                    'total_amount' => $item_total,
                    'prev_stock' => (int)$sku['current_stock'],
                    'sku_name' => $sku['sku_name']
                ];
            }
            
            if (empty($items_to_insert)) {
                throw new Exception("No valid items in the purchase list.");
            }
            
            // Update Purchase Header
            $stmtPurchaseUpdate = $db->prepare("
                UPDATE purchases 
                SET supplier_name = ?, supplier_invoice = ?, purchase_date = ?, subtotal = ?, discount_amount = ?, gst_amount = ?, grand_total = ?, remarks = ?
                WHERE id = ?
            ");
            $stmtPurchaseUpdate->execute([$supplier_name, $invoice_no, $purchase_date, $total_subtotal, $total_discount, $total_gst, $total_grand, $remarks, $purchase_id]);
            
            // Insert new items & Update stock & write new history logs
            $stmtItemInsert = $db->prepare("
                INSERT INTO purchase_items (purchase_id, sku_id, quantity, purchase_price, discount_amount, gst_percentage, gst_amount, total_amount)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmtAddStock = $db->prepare("UPDATE skus SET current_stock = current_stock + ? WHERE id = ?");
            $stmtHistNew = $db->prepare("
                INSERT INTO inventory_history (sku_id, transaction_type, quantity, previous_stock, new_stock, remarks, reference_id, reference_type)
                VALUES (?, 'Purchase Entry', ?, ?, ?, ?, ?, 'purchase')
            ");
            
            foreach ($items_to_insert as $item) {
                // Insert item record
                $stmtItemInsert->execute([
                    $purchase_id, $item['sku_id'], $item['quantity'], $item['purchase_price'], $item['discount_amount'],
                    $item['gst_percentage'], $item['gst_amount'], $item['total_amount']
                ]);
                
                // Update stock
                $stmtAddStock->execute([$item['quantity'], $item['sku_id']]);
                
                // Log history
                $newStock = $item['prev_stock'] + $item['quantity'];
                $histRemarks = "Purchase Entry. Supplier Invoice: {$invoice_no}. " . $remarks . " (Recorded by User: " . $_SESSION['fullname'] . ")";
                $stmtHistNew->execute([$item['sku_id'], $item['quantity'], $item['prev_stock'], $newStock, $histRemarks, $purchase_id]);
                
                logActivity('Inventory Purchase Entry Update', "Updated purchase items: added {$item['quantity']} units to SKU {$item['sku_name']}.");
            }
            
            $db->commit();
            sendJSON('success', 'Purchase entry updated successfully.');
        } catch (Exception $e) {
            $db->rollBack();
            sendJSON('error', 'Purchase entry update failed: ' . $e->getMessage());
        }
    }
    
    if ($action === 'purchase_delete') {
        $purchase_id = (int)($_POST['id'] ?? 0);
        if ($purchase_id <= 0) {
            sendJSON('error', 'Invalid purchase ID.');
        }
        
        $db->beginTransaction();
        try {
            // 1. Fetch old items and reverse stock changes
            $stmtOldItems = $db->prepare("SELECT pi.*, p.supplier_invoice FROM purchase_items pi JOIN purchases p ON pi.purchase_id = p.id WHERE pi.purchase_id = ?");
            $stmtOldItems->execute([$purchase_id]);
            $oldItems = $stmtOldItems->fetchAll();
            
            $stmtReduceStock = $db->prepare("UPDATE skus SET current_stock = current_stock - ? WHERE id = ?");
            
            $invoice_no = '';
            foreach ($oldItems as $oldItem) {
                $invoice_no = $oldItem['supplier_invoice'];
                // Get current stock
                $stmtStock = $db->prepare("SELECT current_stock, sku_name FROM skus WHERE id = ? FOR UPDATE");
                $stmtStock->execute([$oldItem['sku_id']]);
                $sku = $stmtStock->fetch();
                if ($sku) {
                    // Update stock
                    $stmtReduceStock->execute([$oldItem['quantity'], $oldItem['sku_id']]);
                }
            }
            
            // Delete matching inventory history logs completely
            $likeInvoice1 = "%Invoice: " . $invoice_no . "%";
            $likeInvoice2 = "%Supplier Invoice: " . $invoice_no . "%";
            $stmtDelHist = $db->prepare("
                DELETE FROM inventory_history 
                WHERE (reference_id = ? AND reference_type = 'purchase')
                   OR ((remarks LIKE ? OR remarks LIKE ?) AND transaction_type IN ('Purchase Entry', 'Purchase Correction', 'Purchase Deletion'))
            ");
            $stmtDelHist->execute([$purchase_id, $likeInvoice1, $likeInvoice2]);
            
            // Delete purchase items
            $stmtDelItems = $db->prepare("DELETE FROM purchase_items WHERE purchase_id = ?");
            $stmtDelItems->execute([$purchase_id]);
            
            // Delete purchase header
            $stmtDelPurchase = $db->prepare("DELETE FROM purchases WHERE id = ?");
            $stmtDelPurchase->execute([$purchase_id]);
            
            $db->commit();
            logActivity('Delete Purchase Entry', "Deleted purchase entry ID: {$purchase_id} (Invoice: {$invoice_no})");
            sendJSON('success', 'Purchase entry deleted and inventory corrected successfully.');
        } catch (Exception $e) {
            $db->rollBack();
            sendJSON('error', 'Purchase deletion failed: ' . $e->getMessage());
        }
    }
}
?>
