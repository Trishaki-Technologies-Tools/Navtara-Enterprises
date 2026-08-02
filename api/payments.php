<?php
// api/payments.php
// AJAX Handler for Payments Collection and Invoice adjustments

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';
$roleName = $_SESSION['role_name'];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        try {
            if ($roleName === 'Owner') {
                $stmt = $db->query("
                    SELECT p.*, r.shop_name, i.invoice_number, u.fullname as collector_name
                    FROM payments p
                    JOIN retailers r ON p.retailer_id = r.id
                    LEFT JOIN invoices i ON p.invoice_id = i.id
                    LEFT JOIN users u ON p.collected_by = u.id
                    ORDER BY p.id DESC
                ");
            } else {
                $stmt = $db->prepare("
                    SELECT DISTINCT p.*, r.shop_name, i.invoice_number, u.fullname as collector_name
                    FROM payments p
                    JOIN retailers r ON p.retailer_id = r.id
                    JOIN route_retailers rr ON r.id = rr.retailer_id
                    JOIN staff_routes sr ON rr.route_id = sr.route_id
                    LEFT JOIN invoices i ON p.invoice_id = i.id
                    LEFT JOIN users u ON p.collected_by = u.id
                    WHERE sr.user_id = ?
                    ORDER BY p.id DESC
                ");
                $stmt->execute([$_SESSION['user_id']]);
            }
            $payments = $stmt->fetchAll();
            sendJSON('success', 'Payments loaded.', $payments);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch payments: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Both Owner and Sales Staff can collect payments (Sales Staff: "Can: Collect Payments")
    if ($action === 'collect') {
        $retailer_id = (int)($_POST['retailer_id'] ?? 0);
        $invoice_id = !empty($_POST['invoice_id']) ? (int)$_POST['invoice_id'] : null;
        $payment_date = cleanInput($_POST['payment_date'] ?? date('Y-m-d'));
        $payment_type = cleanInput($_POST['payment_type'] ?? 'Partial Payment'); // 'Partial Payment', 'Full Payment', 'Advance Payment', 'Credit Adjustment'
        $payment_method = cleanInput($_POST['payment_method'] ?? 'Cash'); // 'Cash', 'UPI', 'Bank Transfer', 'Cheque', 'Card', 'NEFT', 'RTGS', 'IMPS'
        $amount = (float)($_POST['amount'] ?? 0.00);
        $reference_number = cleanInput($_POST['reference_number'] ?? '');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        
        if ($retailer_id <= 0 || $amount <= 0.00) {
            sendJSON('error', 'Please select a retailer and enter a valid payment amount.');
        }
        
        // Authorization check: Sales staff can only collect from their assigned retailers
        if ($roleName !== 'Owner') {
            $chk = $db->prepare("
                SELECT COUNT(DISTINCT r.id) 
                FROM retailers r 
                JOIN route_retailers rr ON r.id = rr.retailer_id
                JOIN staff_routes sr ON rr.route_id = sr.route_id
                WHERE r.id = ? AND sr.user_id = ?
            ");
            $chk->execute([$retailer_id, $_SESSION['user_id']]);
            if ($chk->fetchColumn() == 0) {
                sendJSON('error', 'Unauthorized operation. Retailer not assigned.');
            }
        }
        
        $db->beginTransaction();
        try {
            // 1. Insert Payment Record
            $stmtPay = $db->prepare("
                INSERT INTO payments (retailer_id, invoice_id, payment_date, payment_type, payment_method, amount, reference_number, remarks, collected_by)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmtPay->execute([$retailer_id, $invoice_id, $payment_date, $payment_type, $payment_method, $amount, $reference_number, $remarks, $_SESSION['user_id']]);
            $paymentId = $db->lastInsertId();
            
            // 2. Adjust Specific Invoice (if selected) or auto-distribute chronologically
            $remainingPayment = $amount;
            
            if ($invoice_id !== null) {
                // Adjust specific invoice
                $stmtInv = $db->prepare("SELECT grand_total, paid_amount, outstanding_amount, invoice_number FROM invoices WHERE id = ? FOR UPDATE");
                $stmtInv->execute([$invoice_id]);
                $invoice = $stmtInv->fetch();
                
                if ($invoice) {
                    $invOutstanding = (float)$invoice['outstanding_amount'];
                    $paymentAllocated = min($invOutstanding, $remainingPayment);
                    
                    $newPaid = (float)$invoice['paid_amount'] + $paymentAllocated;
                    $newOutstanding = (float)$invoice['grand_total'] - $newPaid;
                    
                    $status = 'Partially Paid';
                    if ($newOutstanding <= 0.01) {
                        $newOutstanding = 0.00;
                        $status = 'Paid';
                    }
                    
                    $stmtUpdateInv = $db->prepare("UPDATE invoices SET paid_amount = ?, outstanding_amount = ?, payment_status = ? WHERE id = ?");
                    $stmtUpdateInv->execute([$newPaid, $newOutstanding, $status, $invoice_id]);
                    
                    $remainingPayment -= $paymentAllocated;
                }
            } else {
                // Auto-distribute payment across oldest unpaid invoices chronologically
                $stmtUnpaid = $db->prepare("
                    SELECT id, grand_total, paid_amount, outstanding_amount 
                    FROM invoices 
                    WHERE retailer_id = ? AND payment_status != 'Paid'
                    ORDER BY invoice_date ASC, id ASC 
                    FOR UPDATE
                ");
                $stmtUnpaid->execute([$retailer_id]);
                $unpaidInvoices = $stmtUnpaid->fetchAll();
                
                foreach ($unpaidInvoices as $inv) {
                    if ($remainingPayment <= 0) break;
                    
                    $invOutstanding = (float)$inv['outstanding_amount'];
                    $paymentAllocated = min($invOutstanding, $remainingPayment);
                    
                    $newPaid = (float)$inv['paid_amount'] + $paymentAllocated;
                    $newOutstanding = (float)$inv['grand_total'] - $newPaid;
                    
                    $status = 'Partially Paid';
                    if ($newOutstanding <= 0.01) {
                        $newOutstanding = 0.00;
                        $status = 'Paid';
                    }
                    
                    $stmtUpdateInv = $db->prepare("UPDATE invoices SET paid_amount = ?, outstanding_amount = ?, payment_status = ? WHERE id = ?");
                    $stmtUpdateInv->execute([$newPaid, $newOutstanding, $status, $inv['id']]);
                    
                    $remainingPayment -= $paymentAllocated;
                }
            }
            
            $db->commit(); // Commit database changes so far
            
            // 3. Update Customer Ledger & Outstanding Amount of Retailer
            $ledgerRemarks = "Collected via {$payment_method}. Ref: {$reference_number}. " . $remarks;
            updateCustomerLedger(
                $retailer_id, 
                'Payment', 
                $payment_date, 
                $paymentId, 
                'Payments', 
                0.00, 
                $amount, 
                $ledgerRemarks
            );
            
            // 4. Log visit if collected by sales staff
            if ($roleName !== 'Owner') {
                $db->beginTransaction();
                $stmtTimeline = $db->prepare("
                    INSERT INTO retailer_timeline (retailer_id, staff_id, visit_date, visit_status, remarks)
                    VALUES (?, ?, CURDATE(), 'Visited - Payment Collected', ?)
                ");
                $timelineRemarks = "Collected payment of " . formatRupees($amount) . " via {$payment_method}.";
                $stmtTimeline->execute([$retailer_id, $_SESSION['user_id'], $timelineRemarks]);
                $db->commit();
            }
            
            logActivity('Collect Payment', "Recorded payment of " . formatRupees($amount) . " from Retailer ID: {$retailer_id} using Method: {$payment_method}");
            sendJSON('success', 'Payment recorded successfully, customer balance updated.');
        } catch (Exception $e) {
            if ($db->inTransaction()) {
                $db->rollBack();
            }
            sendJSON('error', 'Payment collection failed: ' . $e->getMessage());
        }
    }
}
?>
