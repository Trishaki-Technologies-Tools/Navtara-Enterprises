<?php
// api/returns.php
// AJAX Handler for Sales Returns, Return Logs & Credit Note Generation

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';
$userId = $_SESSION['user_id'];
$roleName = $_SESSION['role_name'];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // ----------------------------------------------------
    // LIST ALL RETURN LOGS
    // ----------------------------------------------------
    if ($action === 'list') {
        try {
            $startDate = cleanInput($_GET['start_date'] ?? '');
            $endDate = cleanInput($_GET['end_date'] ?? '');
            $retailerId = (int)($_GET['retailer_id'] ?? 0);

            $where = "1=1";
            $params = [];

            if (!empty($startDate) && !empty($endDate)) {
                $where .= " AND sr.return_date BETWEEN ? AND ?";
                $params[] = $startDate;
                $params[] = $endDate;
            }

            if ($retailerId > 0) {
                $where .= " AND sr.retailer_id = ?";
                $params[] = $retailerId;
            }

            if ($roleName !== 'Owner') {
                // Sales staff can only view returns from their routes / invoices
                $where .= " AND (sr.staff_id = ? OR sr.retailer_id IN (
                    SELECT DISTINCT rr.retailer_id 
                    FROM route_retailers rr 
                    JOIN staff_routes srr ON rr.route_id = srr.route_id 
                    WHERE srr.user_id = ?
                ))";
                $params[] = $userId;
                $params[] = $userId;
            }

            $sql = "
                SELECT 
                    sr.*,
                    i.invoice_number,
                    i.invoice_date,
                    i.invoice_type,
                    i.grand_total as original_invoice_total,
                    r.shop_name,
                    r.name as retailer_name,
                    r.mobile as retailer_mobile,
                    r.gst_number as retailer_gst,
                    r.area,
                    r.city,
                    u.fullname as staff_name,
                    (SELECT COUNT(*) FROM sales_return_items sri WHERE sri.return_id = sr.id) as items_count,
                    (SELECT COALESCE(SUM(sri.quantity), 0) FROM sales_return_items sri WHERE sri.return_id = sr.id) as total_units_returned
                FROM sales_returns sr
                JOIN invoices i ON sr.invoice_id = i.id
                JOIN retailers r ON sr.retailer_id = r.id
                JOIN users u ON sr.staff_id = u.id
                WHERE {$where}
                ORDER BY sr.return_date DESC, sr.id DESC
            ";

            $stmt = $db->prepare($sql);
            $stmt->execute($params);
            $returns = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Compute KPI Metrics
            $totalReturnsCount = count($returns);
            $totalReturnedValue = 0;
            $totalUnitsReturned = 0;
            $totalCreditNotesCount = 0;

            foreach ($returns as $ret) {
                $totalReturnedValue += (float)$ret['total_amount'];
                $totalUnitsReturned += (int)$ret['total_units_returned'];
                if (!empty($ret['credit_note_number'])) {
                    $totalCreditNotesCount++;
                }
            }

            sendJSON('success', 'Return logs loaded.', [
                'returns' => $returns,
                'summary' => [
                    'total_returns_count' => $totalReturnsCount,
                    'total_returned_value' => $totalReturnedValue,
                    'total_credit_notes_count' => $totalCreditNotesCount,
                    'total_units_returned' => $totalUnitsReturned
                ]
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch return logs: ' . $e->getMessage());
        }
    }

    // ----------------------------------------------------
    // GET RETURN RECORD DETAILS
    // ----------------------------------------------------
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("
                SELECT 
                    sr.*,
                    i.invoice_number,
                    i.invoice_date,
                    i.invoice_type,
                    i.grand_total as original_invoice_total,
                    r.shop_name,
                    r.name as retailer_name,
                    r.mobile as retailer_mobile,
                    r.address as retailer_address,
                    r.gst_number as retailer_gst,
                    r.area,
                    r.city,
                    r.state as retailer_state,
                    r.pin_code,
                    u.fullname as staff_name
                FROM sales_returns sr
                JOIN invoices i ON sr.invoice_id = i.id
                JOIN retailers r ON sr.retailer_id = r.id
                JOIN users u ON sr.staff_id = u.id
                WHERE sr.id = ?
            ");
            $stmt->execute([$id]);
            $return = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$return) {
                sendJSON('error', 'Return record not found.');
            }

            // Fetch return items
            $stmtItems = $db->prepare("
                SELECT 
                    sri.*,
                    s.sku_name,
                    s.sku_code,
                    s.unit,
                    p.hsn_code,
                    p.name as product_name
                FROM sales_return_items sri
                JOIN skus s ON sri.sku_id = s.id
                JOIN products p ON s.product_id = p.id
                WHERE sri.return_id = ?
                ORDER BY sri.id ASC
            ");
            $stmtItems->execute([$id]);
            $return['items'] = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

            sendJSON('success', 'Return details loaded.', $return);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to load return details: ' . $e->getMessage());
        }
    }

    // ----------------------------------------------------
    // GET INVOICE ITEMS WITH REMAINING RETURNABLE QUANTITY
    // ----------------------------------------------------
    if ($action === 'invoice_return_info') {
        $invoiceId = (int)($_GET['invoice_id'] ?? 0);
        try {
            $stmt = $db->prepare("
                SELECT 
                    i.*,
                    r.shop_name,
                    r.name as retailer_name,
                    r.mobile as retailer_mobile,
                    r.address as retailer_address,
                    r.gst_number as retailer_gst,
                    r.outstanding_amount as current_outstanding
                FROM invoices i
                JOIN retailers r ON i.retailer_id = r.id
                WHERE i.id = ?
            ");
            $stmt->execute([$invoiceId]);
            $invoice = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$invoice) {
                sendJSON('error', 'Invoice not found.');
            }

            // Fetch items with previous returns count
            $stmtItems = $db->prepare("
                SELECT 
                    ii.*,
                    s.sku_name,
                    s.sku_code,
                    s.unit,
                    s.purchase_price,
                    COALESCE((
                        SELECT SUM(sri.quantity) 
                        FROM sales_return_items sri 
                        JOIN sales_returns sr ON sri.return_id = sr.id 
                        WHERE sr.invoice_id = ii.invoice_id 
                          AND sri.sku_id = ii.sku_id 
                          AND sr.status != 'Cancelled'
                    ), 0) as already_returned_qty
                FROM invoice_items ii
                JOIN skus s ON ii.sku_id = s.id
                WHERE ii.invoice_id = ?
                ORDER BY ii.id ASC
            ");
            $stmtItems->execute([$invoiceId]);
            $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

            foreach ($items as &$it) {
                $orig = (int)$it['quantity'];
                $already = (int)$it['already_returned_qty'];
                $it['available_return_qty'] = max(0, $orig - $already);
            }
            unset($it);

            $invoice['items'] = $items;

            sendJSON('success', 'Invoice return details loaded.', $invoice);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to load invoice return details: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // ----------------------------------------------------
    // PROCESS SALES RETURN & ISSUE CREDIT NOTE
    // ----------------------------------------------------
    if ($action === 'create') {
        $invoiceId = (int)($_POST['invoice_id'] ?? 0);
        $returnDate = cleanInput($_POST['return_date'] ?? date('Y-m-d'));
        $returnToInventory = !empty($_POST['return_to_inventory']) ? 1 : 0;
        $globalReason = cleanInput($_POST['reason'] ?? 'Damaged / Customer Return');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        $itemsData = $_POST['items'] ?? [];

        if ($invoiceId <= 0) {
            sendJSON('error', 'Valid invoice is required.');
        }

        if (empty($itemsData) || !is_array($itemsData)) {
            sendJSON('error', 'No items selected for return.');
        }

        try {
            $db->beginTransaction();

            // Fetch Invoice & Retailer
            $stmtInv = $db->prepare("SELECT * FROM invoices WHERE id = ? FOR UPDATE");
            $stmtInv->execute([$invoiceId]);
            $invoice = $stmtInv->fetch(PDO::FETCH_ASSOC);

            if (!$invoice) {
                $db->rollBack();
                sendJSON('error', 'Invoice not found.');
            }

            $retailerId = (int)$invoice['retailer_id'];

            $stmtRet = $db->prepare("SELECT * FROM retailers WHERE id = ? FOR UPDATE");
            $stmtRet->execute([$retailerId]);
            $retailer = $stmtRet->fetch(PDO::FETCH_ASSOC);

            // Fetch original invoice items to validate rates & max return quantities
            $stmtOrig = $db->prepare("SELECT * FROM invoice_items WHERE invoice_id = ?");
            $stmtOrig->execute([$invoiceId]);
            $origItems = $stmtOrig->fetchAll(PDO::FETCH_ASSOC);
            $origMap = [];
            foreach ($origItems as $oi) {
                $origMap[$oi['sku_id']] = $oi;
            }

            // Check existing returns for this invoice
            $stmtExisting = $db->prepare("
                SELECT sri.sku_id, SUM(sri.quantity) as returned_qty 
                FROM sales_return_items sri 
                JOIN sales_returns sr ON sri.return_id = sr.id 
                WHERE sr.invoice_id = ? AND sr.status != 'Cancelled'
                GROUP BY sri.sku_id
            ");
            $stmtExisting->execute([$invoiceId]);
            $existingMap = [];
            while ($row = $stmtExisting->fetch(PDO::FETCH_ASSOC)) {
                $existingMap[$row['sku_id']] = (int)$row['returned_qty'];
            }

            $validReturnItems = [];
            $totalTaxable = 0.00;
            $totalGst = 0.00;
            $totalGrand = 0.00;
            $totalUnits = 0;

            foreach ($itemsData as $it) {
                $skuId = (int)($it['sku_id'] ?? 0);
                $qty = (int)($it['quantity'] ?? 0);
                $itemReason = cleanInput($it['reason'] ?? $globalReason);

                if ($skuId <= 0 || $qty <= 0) {
                    continue; // Skip 0 quantity items
                }

                if (!isset($origMap[$skuId])) {
                    $db->rollBack();
                    sendJSON('error', "Item SKU #{$skuId} does not belong to invoice #{$invoice['invoice_number']}.");
                }

                $orig = $origMap[$skuId];
                $origQty = (int)$orig['quantity'];
                $alreadyReturned = $existingMap[$skuId] ?? 0;
                $maxAvailable = max(0, $origQty - $alreadyReturned);

                if ($qty > $maxAvailable) {
                    $db->rollBack();
                    sendJSON('error', "Cannot return {$qty} units of SKU #{$skuId}. Only {$maxAvailable} units remaining available for return.");
                }

                // Calculate proportional prices, discounts, and GST
                $sellingPrice = (float)$orig['selling_price'];
                $origDiscount = (float)$orig['discount_amount'];
                $unitDiscount = $origQty > 0 ? ($origDiscount / $origQty) : 0.00;
                $itemDiscount = round($unitDiscount * $qty, 2);

                $taxable = round(($qty * $sellingPrice) - $itemDiscount, 2);
                $gstPct = (float)$orig['gst_percentage'];
                $gstAmt = round($taxable * ($gstPct / 100), 2);
                $lineTotal = round($taxable + $gstAmt, 2);

                $validReturnItems[] = [
                    'invoice_item_id' => $orig['id'],
                    'sku_id' => $skuId,
                    'quantity' => $qty,
                    'selling_price' => $sellingPrice,
                    'discount_amount' => $itemDiscount,
                    'gst_percentage' => $gstPct,
                    'gst_amount' => $gstAmt,
                    'total_amount' => $lineTotal,
                    'reason' => $itemReason
                ];

                $totalTaxable += $taxable;
                $totalGst += $gstAmt;
                $totalGrand += $lineTotal;
                $totalUnits += $qty;
            }

            if (empty($validReturnItems)) {
                $db->rollBack();
                sendJSON('error', 'Please enter at least 1 return quantity greater than 0.');
            }

            // Generate sequential Return Number and Credit Note Number
            $nextRetCount = $db->query("SELECT COUNT(*) FROM sales_returns")->fetchColumn() + 1;
            $returnNumber = 'RET-' . date('Ym') . '-' . str_pad($nextRetCount, 4, '0', STR_PAD_LEFT);
            $creditNoteNumber = 'CN-' . date('Ym') . '-' . str_pad($nextRetCount, 4, '0', STR_PAD_LEFT);

            // Double check uniqueness
            $checkUnique = $db->prepare("SELECT COUNT(*) FROM sales_returns WHERE return_number = ? OR credit_note_number = ?");
            $checkUnique->execute([$returnNumber, $creditNoteNumber]);
            if ($checkUnique->fetchColumn() > 0) {
                $uniqSuffix = rand(10, 99);
                $returnNumber .= '-' . $uniqSuffix;
                $creditNoteNumber .= '-' . $uniqSuffix;
            }

            // Insert Sales Return Record
            $stmtInsertReturn = $db->prepare("
                INSERT INTO sales_returns (
                    return_number, credit_note_number, invoice_id, retailer_id, staff_id,
                    return_date, taxable_amount, gst_amount, total_amount, return_to_inventory,
                    reason, remarks, status
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Approved')
            ");
            $stmtInsertReturn->execute([
                $returnNumber,
                $creditNoteNumber,
                $invoiceId,
                $retailerId,
                $userId,
                $returnDate,
                $totalTaxable,
                $totalGst,
                $totalGrand,
                $returnToInventory,
                $globalReason,
                $remarks
            ]);
            $returnId = (int)$db->lastInsertId();

            // Insert Line Items & Handle Inventory Restock
            $stmtInsertItem = $db->prepare("
                INSERT INTO sales_return_items (
                    return_id, invoice_item_id, sku_id, quantity, selling_price,
                    discount_amount, gst_percentage, gst_amount, total_amount, reason
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ");

            $stmtStockUpdate = $db->prepare("UPDATE skus SET current_stock = current_stock + ? WHERE id = ?");
            $stmtHist = $db->prepare("
                INSERT INTO inventory_history (
                    sku_id, transaction_type, quantity, previous_stock, new_stock, remarks
                ) VALUES (?, 'Sales Return', ?, ?, ?, ?)
            ");

            foreach ($validReturnItems as $vItem) {
                $stmtInsertItem->execute([
                    $returnId,
                    $vItem['invoice_item_id'],
                    $vItem['sku_id'],
                    $vItem['quantity'],
                    $vItem['selling_price'],
                    $vItem['discount_amount'],
                    $vItem['gst_percentage'],
                    $vItem['gst_amount'],
                    $vItem['total_amount'],
                    $vItem['reason']
                ]);

                if ($returnToInventory === 1) {
                    // Fetch current stock
                    $stmtCur = $db->prepare("SELECT current_stock FROM skus WHERE id = ? FOR UPDATE");
                    $stmtCur->execute([$vItem['sku_id']]);
                    $prevStock = (int)$stmtCur->fetchColumn();
                    $newStock = $prevStock + (int)$vItem['quantity'];

                    $stmtStockUpdate->execute([$vItem['quantity'], $vItem['sku_id']]);
                    $stmtHist->execute([
                        $vItem['sku_id'],
                        $vItem['quantity'],
                        $prevStock,
                        $newStock,
                        "Sales return from Invoice #{$invoice['invoice_number']} (Credit Note #{$creditNoteNumber})"
                    ]);
                }
            }

            // Adjust Retailer Outstanding Balance & Customer Ledger
            $currentOutstanding = (float)($retailer['outstanding_amount'] ?? 0.00);
            $newOutstanding = max(0.00, $currentOutstanding - $totalGrand);

            $stmtUpdateRetailer = $db->prepare("UPDATE retailers SET outstanding_amount = ? WHERE id = ?");
            $stmtUpdateRetailer->execute([$newOutstanding, $retailerId]);

            // Add Entry into Customer Ledger
            $stmtLedger = $db->prepare("
                INSERT INTO customer_ledger (
                    retailer_id, transaction_type, transaction_date, reference_id, reference_type,
                    debit_amount, credit_amount, balance, remarks
                ) VALUES (?, 'Credit Note', ?, ?, 'Invoices', 0.00, ?, ?, ?)
            ");
            $ledgerRemarks = "Credit Note #{$creditNoteNumber} issued for returned goods against Invoice #{$invoice['invoice_number']} ({$totalUnits} pcs)";
            $stmtLedger->execute([
                $retailerId,
                $returnDate,
                $returnId,
                $totalGrand,
                $newOutstanding,
                $ledgerRemarks
            ]);

            // Log activity
            logActivity('Sales Return Processed', "Processed return #{$returnNumber} / Credit Note #{$creditNoteNumber} for {$retailer['shop_name']} totaling ₹" . number_format($totalGrand, 2));

            $db->commit();

            sendJSON('success', "Sales return processed successfully! Credit Note #{$creditNoteNumber} issued for ₹" . number_format($totalGrand, 2), [
                'return_id' => $returnId,
                'return_number' => $returnNumber,
                'credit_note_number' => $creditNoteNumber,
                'total_amount' => $totalGrand
            ]);
        } catch (Exception $e) {
            if ($db->inTransaction()) {
                $db->rollBack();
            }
            sendJSON('error', 'Failed to process return: ' . $e->getMessage());
        }
    }
}
