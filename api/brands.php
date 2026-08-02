<?php
// api/brands.php
// AJAX Handler for Brand Management CRUD

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        try {
            $supplier_id = (int)($_GET['supplier_id'] ?? 0);
            $whereClause = $supplier_id > 0 ? "WHERE b.supplier_id = $supplier_id" : "";
            $stmt = $db->query("
                SELECT b.*, s.name as supplier_name, 
                       (SELECT COUNT(*) FROM products WHERE brand_id = b.id) as product_count 
                FROM brands b 
                LEFT JOIN suppliers s ON b.supplier_id = s.id 
                $whereClause
                ORDER BY b.id DESC
            ");
            $brands = $stmt->fetchAll();
            sendJSON('success', 'Categories loaded.', $brands);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch categories: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("SELECT * FROM brands WHERE id = ?");
            $stmt->execute([$id]);
            $brand = $stmt->fetch();
            if ($brand) {
                sendJSON('success', 'Category loaded.', $brand);
            } else {
                sendJSON('error', 'Category not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    checkRole('Owner'); // Only Owners can create/modify brands
    
    if ($action === 'create') {
        $name = cleanInput($_POST['name'] ?? '');
        $supplier_id = (int)($_POST['supplier_id'] ?? 0);
        $description = cleanInput($_POST['description'] ?? '');
        $status = cleanInput($_POST['status'] ?? 'Active');
        
        if (empty($name)) {
            sendJSON('error', 'Category name is required.');
        }
        if ($supplier_id <= 0) {
            sendJSON('error', 'Supplier is required.');
        }
        
        // Handle logo upload
        $logoPath = null;
        if (isset($_FILES['logo']) && $_FILES['logo']['error'] === UPLOAD_ERR_OK) {
            $logoPath = uploadFile('logo', 'brands');
            if ($logoPath === false) {
                sendJSON('error', 'Invalid logo file type. Only JPG, PNG, WEBP, and GIF are allowed.');
            }
        }
        
        try {
            $stmt = $db->prepare("INSERT INTO brands (name, supplier_id, logo, description, status) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([$name, $supplier_id, $logoPath, $description, $status]);
            logActivity('Create Brand', "Created brand: {$name}");
            sendJSON('success', 'Category created successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1062) {
                sendJSON('error', 'A category with this name already exists.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'update') {
        $id = (int)($_POST['id'] ?? 0);
        $name = cleanInput($_POST['name'] ?? '');
        $supplier_id = (int)($_POST['supplier_id'] ?? 0);
        $description = cleanInput($_POST['description'] ?? '');
        $status = cleanInput($_POST['status'] ?? 'Active');
        
        if (empty($name) || $id <= 0) {
            sendJSON('error', 'Invalid arguments. Category name is required.');
        }
        if ($supplier_id <= 0) {
            sendJSON('error', 'Supplier is required.');
        }
        
        try {
            // Get current logo path
            $stmt = $db->prepare("SELECT logo FROM brands WHERE id = ?");
            $stmt->execute([$id]);
            $currentLogo = $stmt->fetchColumn();
            
            // Handle logo upload if replacement provided
            $logoPath = $currentLogo;
            if (isset($_FILES['logo']) && $_FILES['logo']['error'] === UPLOAD_ERR_OK) {
                $uploaded = uploadFile('logo', 'brands');
                if ($uploaded === false) {
                    sendJSON('error', 'Invalid logo file type.');
                }
                $logoPath = $uploaded;
                // Delete old logo file if exists
                if ($currentLogo && file_exists(__DIR__ . '/../' . $currentLogo)) {
                    @unlink(__DIR__ . '/../' . $currentLogo);
                }
            }
            
            $stmt = $db->prepare("UPDATE brands SET name = ?, supplier_id = ?, logo = ?, description = ?, status = ? WHERE id = ?");
            $stmt->execute([$name, $supplier_id, $logoPath, $description, $status, $id]);
            logActivity('Update Brand', "Updated brand ID: {$id} to Name: {$name}");
            sendJSON('success', 'Category updated successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1062) {
                sendJSON('error', 'A category with this name already exists.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid category ID.');
        }
        
        try {
            // Check logo path to delete file later
            $stmt = $db->prepare("SELECT logo FROM brands WHERE id = ?");
            $stmt->execute([$id]);
            $logo = $stmt->fetchColumn();
            
            $stmt = $db->prepare("DELETE FROM brands WHERE id = ?");
            $stmt->execute([$id]);
            
            // Delete file from disk
            if ($logo && file_exists(__DIR__ . '/../' . $logo)) {
                @unlink(__DIR__ . '/../' . $logo);
            }
            
            logActivity('Delete Brand', "Deleted brand ID: {$id}");
            sendJSON('success', 'Category deleted successfully.');
        } catch (PDOException $e) {
            // Integrity constraint violation (foreign key check)
            if ($e->errorInfo[1] == 1451) {
                sendJSON('error', 'Cannot delete category. It has products associated with it.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
