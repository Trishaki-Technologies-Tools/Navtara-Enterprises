<?php
// api/supplier_payments.php
// AJAX Handler for Supplier Payments

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        try {
            $stmt = $db->query("SELECT * FROM supplier_payments ORDER BY payment_date DESC, id DESC");
            $payments = $stmt->fetchAll();
            sendJSON('success', 'Supplier payments loaded.', $payments);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch payments: ' . $e->getMessage());
        }
    }
    
    if ($action === 'summary') {
        try {
            // Get all suppliers from the suppliers table
            $stmtSuppliers = $db->query("SELECT name FROM suppliers ORDER BY name ASC");
            $suppliers = $stmtSuppliers->fetchAll(PDO::FETCH_ASSOC);
            
            // Get total purchases per supplier
            $stmtPurchases = $db->query("SELECT supplier_name, SUM(grand_total) as total_purchased FROM purchases GROUP BY supplier_name");
            $purchases = $stmtPurchases->fetchAll(PDO::FETCH_ASSOC);
            $purchaseMap = [];
            foreach ($purchases as $p) {
                $purchaseMap[$p['supplier_name']] = (float)$p['total_purchased'];
            }
            
            // Get total payments per supplier
            $stmtPayments = $db->query("SELECT supplier_name, SUM(amount) as total_paid FROM supplier_payments GROUP BY supplier_name");
            $payments = $stmtPayments->fetchAll(PDO::FETCH_ASSOC);
            $paymentMap = [];
            foreach ($payments as $p) {
                $paymentMap[$p['supplier_name']] = (float)$p['total_paid'];
            }
            
            $summary = [];
            // Combine all unique supplier names
            $allNames = array_unique(array_merge(array_column($suppliers, 'name'), array_keys($purchaseMap), array_keys($paymentMap)));
            
            foreach ($allNames as $name) {
                if (empty($name)) continue;
                $totalPur = $purchaseMap[$name] ?? 0.00;
                $totalPaid = $paymentMap[$name] ?? 0.00;
                $outstanding = $totalPur - $totalPaid;
                
                $summary[] = [
                    'supplier_name' => $name,
                    'total_purchased' => $totalPur,
                    'total_paid' => $totalPaid,
                    'outstanding' => $outstanding
                ];
            }
            
            // Sort by outstanding desc
            usort($summary, function($a, $b) {
                return $b['outstanding'] <=> $a['outstanding'];
            });
            
            sendJSON('success', 'Supplier summary loaded.', $summary);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch supplier summary: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    checkRole('Owner'); // Only Owners should log supplier payments
    
    if ($action === 'create') {
        $supplier_name = cleanInput($_POST['supplier_name'] ?? '');
        $payment_date = cleanInput($_POST['payment_date'] ?? date('Y-m-d'));
        $amount = (float)($_POST['amount'] ?? 0);
        $payment_mode = cleanInput($_POST['payment_mode'] ?? 'Bank Transfer');
        $reference_number = cleanInput($_POST['reference_number'] ?? '');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        
        if (empty($supplier_name) || $amount <= 0) {
            sendJSON('error', 'Supplier name and valid amount are required.');
        }
        
        try {
            $stmt = $db->prepare("
                INSERT INTO supplier_payments (supplier_name, payment_date, amount, payment_mode, reference_number, remarks)
                VALUES (?, ?, ?, ?, ?, ?)
            ");
            $stmt->execute([$supplier_name, $payment_date, $amount, $payment_mode, $reference_number, $remarks]);
            
            logActivity('Supplier Payment', "Logged payment of ₹{$amount} to {$supplier_name}");
            sendJSON('success', 'Supplier payment recorded successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to record payment: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) sendJSON('error', 'Invalid payment ID.');
        
        try {
            $stmtGet = $db->prepare("SELECT * FROM supplier_payments WHERE id = ?");
            $stmtGet->execute([$id]);
            $pay = $stmtGet->fetch();
            
            $stmt = $db->prepare("DELETE FROM supplier_payments WHERE id = ?");
            $stmt->execute([$id]);
            
            if ($pay) {
                logActivity('Deleted Supplier Payment', "Deleted payment of ₹{$pay['amount']} to {$pay['supplier_name']}");
            }
            
            sendJSON('success', 'Supplier payment deleted.');
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to delete payment: ' . $e->getMessage());
        }
    }
}
?>
