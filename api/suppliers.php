<?php
// api/suppliers.php
// AJAX Handler for Supplier Management CRUD

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        try {
            $stmt = $db->query("SELECT * FROM suppliers ORDER BY id DESC");
            $suppliers = $stmt->fetchAll();
            sendJSON('success', 'Suppliers loaded.', $suppliers);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch suppliers: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("SELECT * FROM suppliers WHERE id = ?");
            $stmt->execute([$id]);
            $supplier = $stmt->fetch();
            if ($supplier) {
                sendJSON('success', 'Supplier loaded.', $supplier);
            } else {
                sendJSON('error', 'Supplier not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    checkRole('Owner'); // Only Owners can create/modify suppliers
    
    if ($action === 'create') {
        $name = cleanInput($_POST['name'] ?? '');
        $gst_number = cleanInput($_POST['gst_number'] ?? '');
        $address = cleanInput($_POST['address'] ?? '');
        $fssai_license = cleanInput($_POST['fssai_license'] ?? '');
        $acc_number = cleanInput($_POST['acc_number'] ?? '');
        $bank_branch = cleanInput($_POST['bank_branch'] ?? '');
        $bank_place = cleanInput($_POST['bank_place'] ?? '');
        $acc_holder = cleanInput($_POST['acc_holder'] ?? '');
        $payment_mode = cleanInput($_POST['payment_mode'] ?? '');
        
        if (empty($name)) {
            sendJSON('error', 'Supplier name is required.');
        }
        
        try {
            $stmt = $db->prepare("INSERT INTO suppliers (name, gst_number, address, fssai_license, acc_number, bank_branch, bank_place, acc_holder, payment_mode) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$name, $gst_number, $address, $fssai_license, $acc_number, $bank_branch, $bank_place, $acc_holder, $payment_mode]);
            logActivity('Create Supplier', "Created supplier: {$name}");
            sendJSON('success', 'Supplier created successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'update') {
        $id = (int)($_POST['id'] ?? 0);
        $name = cleanInput($_POST['name'] ?? '');
        $gst_number = cleanInput($_POST['gst_number'] ?? '');
        $address = cleanInput($_POST['address'] ?? '');
        $fssai_license = cleanInput($_POST['fssai_license'] ?? '');
        $acc_number = cleanInput($_POST['acc_number'] ?? '');
        $bank_branch = cleanInput($_POST['bank_branch'] ?? '');
        $bank_place = cleanInput($_POST['bank_place'] ?? '');
        $acc_holder = cleanInput($_POST['acc_holder'] ?? '');
        $payment_mode = cleanInput($_POST['payment_mode'] ?? '');
        
        if (empty($name) || $id <= 0) {
            sendJSON('error', 'Supplier name and ID are required.');
        }
        
        try {
            $stmt = $db->prepare("UPDATE suppliers SET name = ?, gst_number = ?, address = ?, fssai_license = ?, acc_number = ?, bank_branch = ?, bank_place = ?, acc_holder = ?, payment_mode = ? WHERE id = ?");
            $stmt->execute([$name, $gst_number, $address, $fssai_license, $acc_number, $bank_branch, $bank_place, $acc_holder, $payment_mode, $id]);
            logActivity('Update Supplier', "Updated supplier ID: {$id}");
            sendJSON('success', 'Supplier updated successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid supplier ID.');
        }
        
        try {
            $stmt = $db->prepare("DELETE FROM suppliers WHERE id = ?");
            $stmt->execute([$id]);
            logActivity('Delete Supplier', "Deleted supplier ID: {$id}");
            sendJSON('success', 'Supplier deleted successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
