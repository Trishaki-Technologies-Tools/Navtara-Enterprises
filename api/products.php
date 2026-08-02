<?php
// api/products.php
// AJAX Handler for Product Management CRUD

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        try {
            $brand_id = (int)($_GET['brand_id'] ?? 0);
            $whereClause = $brand_id > 0 ? "WHERE p.brand_id = $brand_id" : "";
            $stmt = $db->query("
                SELECT p.*, b.name as brand_name, 
                       (SELECT COUNT(*) FROM skus WHERE product_id = p.id) as sku_count 
                FROM products p 
                JOIN brands b ON p.brand_id = b.id 
                $whereClause
                ORDER BY p.id DESC
            ");
            $products = $stmt->fetchAll();
            sendJSON('success', 'Products loaded.', $products);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch products: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("SELECT * FROM products WHERE id = ?");
            $stmt->execute([$id]);
            $product = $stmt->fetch();
            if ($product) {
                sendJSON('success', 'Product loaded.', $product);
            } else {
                sendJSON('error', 'Product not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    checkRole('Owner'); // Only Owners can manage products
    
    if ($action === 'create') {
        $brand_id = (int)($_POST['brand_id'] ?? 0);
        $name = cleanInput($_POST['name'] ?? '');
        $description = cleanInput($_POST['description'] ?? '');
        $gst_percentage = (float)($_POST['gst_percentage'] ?? 18.00);
        $hsn_code = cleanInput($_POST['hsn_code'] ?? '');
        $status = cleanInput($_POST['status'] ?? 'Active');
        
        if ($brand_id <= 0 || empty($name)) {
            sendJSON('error', 'Product name and brand are required.');
        }
        
        // Handle image upload
        $imagePath = null;
        if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
            $imagePath = uploadFile('image', 'products');
            if ($imagePath === false) {
                sendJSON('error', 'Invalid image file type. Only JPG, PNG, WEBP, and GIF are allowed.');
            }
        }
        
        try {
            $stmt = $db->prepare("INSERT INTO products (brand_id, name, description, gst_percentage, hsn_code, image, status) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$brand_id, $name, $description, $gst_percentage, $hsn_code, $imagePath, $status]);
            logActivity('Create Product', "Created product: {$name} under Brand ID: {$brand_id}");
            sendJSON('success', 'Product created successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1062) {
                sendJSON('error', 'A product with this name already exists under this brand.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'update') {
        $id = (int)($_POST['id'] ?? 0);
        $brand_id = (int)($_POST['brand_id'] ?? 0);
        $name = cleanInput($_POST['name'] ?? '');
        $description = cleanInput($_POST['description'] ?? '');
        $gst_percentage = (float)($_POST['gst_percentage'] ?? 18.00);
        $hsn_code = cleanInput($_POST['hsn_code'] ?? '');
        $status = cleanInput($_POST['status'] ?? 'Active');
        
        if ($id <= 0 || $brand_id <= 0 || empty($name)) {
            sendJSON('error', 'Invalid parameters. Brand and product name are required.');
        }
        
        try {
            // Get current image path
            $stmt = $db->prepare("SELECT image FROM products WHERE id = ?");
            $stmt->execute([$id]);
            $currentImage = $stmt->fetchColumn();
            
            // Handle image upload if replacement provided
            $imagePath = $currentImage;
            if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
                $uploaded = uploadFile('image', 'products');
                if ($uploaded === false) {
                    sendJSON('error', 'Invalid image file type.');
                }
                $imagePath = $uploaded;
                // Delete old image file if exists
                if ($currentImage && file_exists(__DIR__ . '/../' . $currentImage)) {
                    @unlink(__DIR__ . '/../' . $currentImage);
                }
            }
            
            $stmt = $db->prepare("UPDATE products SET brand_id = ?, name = ?, description = ?, gst_percentage = ?, hsn_code = ?, image = ?, status = ? WHERE id = ?");
            $stmt->execute([$brand_id, $name, $description, $gst_percentage, $hsn_code, $imagePath, $status, $id]);
            logActivity('Update Product', "Updated product ID: {$id} to name: {$name}");
            sendJSON('success', 'Product updated successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1062) {
                sendJSON('error', 'A product with this name already exists under this brand.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid product ID.');
        }
        
        try {
            // Check image path to delete file later
            $stmt = $db->prepare("SELECT image FROM products WHERE id = ?");
            $stmt->execute([$id]);
            $image = $stmt->fetchColumn();
            
            $stmt = $db->prepare("DELETE FROM products WHERE id = ?");
            $stmt->execute([$id]);
            
            // Delete file from disk
            if ($image && file_exists(__DIR__ . '/../' . $image)) {
                @unlink(__DIR__ . '/../' . $image);
            }
            
            logActivity('Delete Product', "Deleted product ID: {$id}");
            sendJSON('success', 'Product deleted successfully.');
        } catch (PDOException $e) {
            // Integrity constraint violation (foreign key check)
            if ($e->errorInfo[1] == 1451) {
                sendJSON('error', 'Cannot delete product. It has associated SKUs/Invoices.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
