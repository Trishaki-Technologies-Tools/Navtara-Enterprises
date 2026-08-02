<?php
// api/skus.php
// AJAX Handler for SKU Management CRUD

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        $brand_id = (int)($_GET['brand_id'] ?? 0);
        $product_id = (int)($_GET['product_id'] ?? 0);
        try {
            $whereClause = "";
            $params = [];
            
            if ($product_id > 0) {
                $whereClause = "WHERE s.product_id = ?";
                $params[] = $product_id;
            } elseif ($brand_id > 0) {
                $whereClause = "WHERE p.brand_id = ?";
                $params[] = $brand_id;
            }

            $stmt = $db->prepare("
                SELECT s.*, p.name as product_name, b.name as brand_name, p.hsn_code
                FROM skus s
                JOIN products p ON s.product_id = p.id
                JOIN brands b ON p.brand_id = b.id
                $whereClause
                ORDER BY s.id DESC
            ");
            $stmt->execute($params);
            $skus = $stmt->fetchAll();
            sendJSON('success', 'SKUs loaded.', $skus);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch SKUs: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("SELECT s.*, p.gst_percentage as product_gst FROM skus s JOIN products p ON s.product_id = p.id WHERE s.id = ?");
            $stmt->execute([$id]);
            $sku = $stmt->fetch();
            if ($sku) {
                // Fetch discount rules
                $dstmt = $db->prepare("SELECT * FROM sku_discounts WHERE sku_id = ? AND status = 'Active' ORDER BY discount_type, min_qty DESC");
                $dstmt->execute([$id]);
                $sku['discount_rules'] = $dstmt->fetchAll();
                
                sendJSON('success', 'SKU loaded.', $sku);
            } else {
                sendJSON('error', 'SKU not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    checkRole('Owner'); // Only Owners can manage SKUs
    
    if ($action === 'create') {
        $product_id = (int)($_POST['product_id'] ?? 0);
        $sku_name = cleanInput($_POST['sku_name'] ?? '');
        $sku_code = cleanInput($_POST['sku_code'] ?? '');
        $purchase_price = (float)($_POST['purchase_price'] ?? 0.00);
        $selling_price = (float)($_POST['selling_price'] ?? 0.00);
        $mrp = (float)($_POST['mrp'] ?? 0.00);
        $gst_percentage = (float)($_POST['gst_percentage'] ?? 0.00);
        $unit = cleanInput($_POST['unit'] ?? 'Pcs');
        $weight = cleanInput($_POST['weight'] ?? '');
        $size = cleanInput($_POST['size'] ?? '');
        $current_stock = (int)($_POST['current_stock'] ?? 0);
        $minimum_stock = (int)($_POST['minimum_stock'] ?? 5);
        $status = cleanInput($_POST['status'] ?? 'Active');
        
        if ($product_id <= 0 || empty($sku_name)) {
            sendJSON('error', 'Product and SKU Name are required fields.');
        }
        
        if (empty($sku_code)) {
            // Get product and brand details
            $prodStmt = $db->prepare("
                SELECT p.name as product_name, b.name as brand_name 
                FROM products p 
                JOIN brands b ON p.brand_id = b.id 
                WHERE p.id = ?
            ");
            $prodStmt->execute([$product_id]);
            $prod = $prodStmt->fetch();
            $prodName = $prod ? $prod['product_name'] : '';
            $brandName = $prod ? $prod['brand_name'] : '';
            
            // Generate clean SKU code
            $combined = ($brandName ? $brandName . '-' : '') . $prodName . '-' . $sku_name;
            $clean = preg_replace('/[^A-Za-z0-9\-]/', '', str_replace(' ', '-', $combined));
            $clean = preg_replace('/-+/', '-', $clean);
            $sku_code = strtoupper(trim($clean, '-'));
            
            // Ensure uniqueness
            $checkStmt = $db->prepare("SELECT COUNT(*) FROM skus WHERE sku_code = ?");
            $checkStmt->execute([$sku_code]);
            if ($checkStmt->fetchColumn() > 0) {
                $sku_code = substr($sku_code, 0, 43) . '-' . strtoupper(substr(uniqid(), -5));
            }
        }
        
        $db->beginTransaction();
        try {
            $stmt = $db->prepare("
                INSERT INTO skus 
                (product_id, sku_name, sku_code, purchase_price, selling_price, mrp, gst_percentage, unit, weight, size, current_stock, minimum_stock, status) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmt->execute([$product_id, $sku_name, $sku_code, $purchase_price, $selling_price, $mrp, $gst_percentage, $unit, $weight, $size, $current_stock, $minimum_stock, $status]);
            $skuId = $db->lastInsertId();
            
            // Log opening stock in history
            $stmtHist = $db->prepare("
                INSERT INTO inventory_history (sku_id, transaction_type, quantity, previous_stock, new_stock, remarks) 
                VALUES (?, 'Opening Stock', ?, 0, ?, 'SKU created with opening stock')
            ");
            $stmtHist->execute([$skuId, $current_stock, $current_stock]);
            
            $db->commit();
            logActivity('Create SKU', "Created SKU: {$sku_name} (Code: {$sku_code}) with opening stock {$current_stock}");
            sendJSON('success', 'SKU created successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            if ($e->errorInfo[1] == 1062) {
                sendJSON('error', 'An SKU with this SKU Code already exists.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'update') {
        $id = (int)($_POST['id'] ?? 0);
        $product_id = (int)($_POST['product_id'] ?? 0);
        $sku_name = cleanInput($_POST['sku_name'] ?? '');
        $purchase_price = (float)($_POST['purchase_price'] ?? 0.00);
        $selling_price = (float)($_POST['selling_price'] ?? 0.00);
        $mrp = (float)($_POST['mrp'] ?? 0.00);
        $gst_percentage = (float)($_POST['gst_percentage'] ?? 0.00);
        $unit = cleanInput($_POST['unit'] ?? 'Pcs');
        $minimum_stock = (int)($_POST['minimum_stock'] ?? 5);
        $status = cleanInput($_POST['status'] ?? 'Active');
        
        if ($id <= 0 || $product_id <= 0 || empty($sku_name)) {
            sendJSON('error', 'Invalid parameters. SKU Name and Product are required.');
        }
        
        try {
            $stmt = $db->prepare("
                UPDATE skus 
                SET product_id = ?, sku_name = ?, purchase_price = ?, selling_price = ?, mrp = ?, gst_percentage = ?, unit = ?, minimum_stock = ?, status = ? 
                WHERE id = ?
            ");
            $stmt->execute([$product_id, $sku_name, $purchase_price, $selling_price, $mrp, $gst_percentage, $unit, $minimum_stock, $status, $id]);
            logActivity('Update SKU', "Updated SKU ID: {$id} ({$sku_name})");
            sendJSON('success', 'SKU updated successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1062) {
                sendJSON('error', 'An SKU with this SKU Code already exists.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid SKU ID.');
        }
        
        try {
            // Delete history first or handle foreign keys (on delete restrict)
            $stmt = $db->prepare("DELETE FROM inventory_history WHERE sku_id = ? AND transaction_type = 'Opening Stock'");
            $stmt->execute([$id]);
            
            $stmt = $db->prepare("DELETE FROM skus WHERE id = ?");
            $stmt->execute([$id]);
            
            logActivity('Delete SKU', "Deleted SKU ID: {$id}");
            sendJSON('success', 'SKU deleted successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1451) {
                sendJSON('error', 'Cannot delete SKU. It has associated history, order items or invoice items.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
