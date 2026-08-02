<?php
// api/expenses.php
// AJAX Handler for Expense Management CRUD

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';
$roleName = $_SESSION['role_name'];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Only Owners can view or manage expenses
    checkRole('Owner');
    
    if ($action === 'list') {
        try {
            $stmt = $db->query("
                SELECT e.*, u.fullname as creator_name 
                FROM expenses e
                LEFT JOIN users u ON e.created_by = u.id
                ORDER BY e.id DESC
            ");
            $expenses = $stmt->fetchAll();
            sendJSON('success', 'Expenses loaded.', $expenses);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch expenses: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("SELECT * FROM expenses WHERE id = ?");
            $stmt->execute([$id]);
            $expense = $stmt->fetch();
            if ($expense) {
                sendJSON('success', 'Expense loaded.', $expense);
            } else {
                sendJSON('error', 'Expense record not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    checkRole('Owner');
    
    if ($action === 'create') {
        $category = cleanInput($_POST['category'] ?? 'Miscellaneous');
        $amount = (float)($_POST['amount'] ?? 0.00);
        $gst_percentage = (float)($_POST['gst_percentage'] ?? 0.00);
        $gst_amount = (float)($_POST['gst_amount'] ?? 0.00);
        $expense_date = cleanInput($_POST['expense_date'] ?? date('Y-m-d'));
        $paid_to = cleanInput($_POST['paid_to'] ?? '');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        $payment_method = cleanInput($_POST['payment_method'] ?? 'Cash');
        
        if ($amount <= 0.00) {
            sendJSON('error', 'Please enter a valid expense amount.');
        }
        
        try {
            $stmt = $db->prepare("
                INSERT INTO expenses (category, amount, gst_percentage, gst_amount, expense_date, paid_to, remarks, created_by, payment_method)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmt->execute([$category, $amount, $gst_percentage, $gst_amount, $expense_date, $paid_to, $remarks, $_SESSION['user_id'], $payment_method]);
            
            logActivity('Create Expense', "Recorded expense: {$category} of " . formatRupees($amount) . " + GST " . formatRupees($gst_amount) . " paid to {$paid_to} via {$payment_method}");
            sendJSON('success', 'Expense recorded successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'update') {
        $id = (int)($_POST['id'] ?? 0);
        $category = cleanInput($_POST['category'] ?? 'Miscellaneous');
        $amount = (float)($_POST['amount'] ?? 0.00);
        $gst_percentage = (float)($_POST['gst_percentage'] ?? 0.00);
        $gst_amount = (float)($_POST['gst_amount'] ?? 0.00);
        $expense_date = cleanInput($_POST['expense_date'] ?? date('Y-m-d'));
        $paid_to = cleanInput($_POST['paid_to'] ?? '');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        $payment_method = cleanInput($_POST['payment_method'] ?? 'Cash');
        
        if ($id <= 0 || $amount <= 0.00) {
            sendJSON('error', 'Invalid parameters. Please specify ID and valid amount.');
        }
        
        try {
            $stmt = $db->prepare("
                UPDATE expenses 
                SET category = ?, amount = ?, gst_percentage = ?, gst_amount = ?, expense_date = ?, paid_to = ?, remarks = ?, payment_method = ?
                WHERE id = ?
            ");
            $stmt->execute([$category, $amount, $gst_percentage, $gst_amount, $expense_date, $paid_to, $remarks, $payment_method, $id]);
            
            logActivity('Update Expense', "Updated expense ID: {$id} ({$category}) via {$payment_method}");
            sendJSON('success', 'Expense record updated successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid expense ID.');
        }
        
        try {
            $stmt = $db->prepare("DELETE FROM expenses WHERE id = ?");
            $stmt->execute([$id]);
            
            logActivity('Delete Expense', "Deleted expense ID: {$id}");
            sendJSON('success', 'Expense record deleted successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
