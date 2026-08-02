<?php
// api/discount_slabs.php
// AJAX Handler for SKU Discount Slabs

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();
checkRole('Owner');

$db = getDBConnection();
$action = $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        $sku_id = (int)($_GET['sku_id'] ?? 0);
        try {
            if ($sku_id > 0) {
                $stmt = $db->prepare("SELECT * FROM sku_discounts WHERE sku_id = ? ORDER BY discount_type, min_qty ASC");
                $stmt->execute([$sku_id]);
                $discounts = $stmt->fetchAll();
                sendJSON('success', 'Discounts loaded.', $discounts);
            } else {
                $stmt = $db->query("
                    SELECT d.*, s.sku_name, s.sku_code 
                    FROM sku_discounts d 
                    JOIN skus s ON d.sku_id = s.id 
                    ORDER BY s.sku_name ASC, d.discount_type ASC, d.min_qty ASC
                ");
                $discounts = $stmt->fetchAll();
                sendJSON('success', 'All discounts loaded.', $discounts);
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch discounts: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($action === 'create') {
        $sku_id = (int)($_POST['sku_id'] ?? 0);
        $discount_type = cleanInput($_POST['discount_type'] ?? 'Quantity Slab');
        $min_qty = (int)($_POST['min_qty'] ?? 1);
        $max_qty = (int)($_POST['max_qty'] ?? 999999);
        $discount_value = (float)($_POST['discount_value'] ?? 0.00);
        $status = cleanInput($_POST['status'] ?? 'Active');
        
        if ($sku_id <= 0 || $discount_value <= 0) {
            sendJSON('error', 'Invalid parameters. Please specify a valid SKU and discount value.');
        }
        
        try {
            $stmt = $db->prepare("INSERT INTO sku_discounts (sku_id, discount_type, min_qty, max_qty, discount_value, status) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->execute([$sku_id, $discount_type, $min_qty, $max_qty, $discount_value, $status]);
            logActivity('Create Discount', "Added {$discount_type} for SKU ID: {$sku_id}");
            sendJSON('success', 'Discount added successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'update') {
        $id = (int)($_POST['id'] ?? 0);
        $discount_type = cleanInput($_POST['discount_type'] ?? 'Quantity Slab');
        $min_qty = (int)($_POST['min_qty'] ?? 1);
        $max_qty = (int)($_POST['max_qty'] ?? 999999);
        $discount_value = (float)($_POST['discount_value'] ?? 0.00);
        $status = cleanInput($_POST['status'] ?? 'Active');
        
        if ($id <= 0 || $discount_value <= 0) {
            sendJSON('error', 'Invalid parameters. ID and positive discount value required.');
        }
        
        try {
            $stmt = $db->prepare("UPDATE sku_discounts SET discount_type = ?, min_qty = ?, max_qty = ?, discount_value = ?, status = ? WHERE id = ?");
            $stmt->execute([$discount_type, $min_qty, $max_qty, $discount_value, $status, $id]);
            logActivity('Update Discount', "Updated discount ID: {$id}");
            sendJSON('success', 'Discount updated successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) sendJSON('error', 'Invalid ID.');
        try {
            $stmt = $db->prepare("DELETE FROM sku_discounts WHERE id = ?");
            $stmt->execute([$id]);
            logActivity('Delete Discount', "Deleted discount ID: {$id}");
            sendJSON('success', 'Discount removed.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
