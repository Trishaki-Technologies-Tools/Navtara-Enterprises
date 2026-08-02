<?php
// api/expiry.php
// AJAX Handler for Expiry Products Book & Collections

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';
$roleName = $_SESSION['role_name'] ?? '';
$userId = $_SESSION['user_id'] ?? 0;

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    
    // 1. List Expiry Records (Role-filtered)
    if ($action === 'list') {
        try {
            if ($roleName === 'Owner') {
                // Owner sees all collections
                $stmt = $db->query("
                    SELECT er.*, r.shop_name, b.name as brand_name, p.name as product_name, s.sku_name, s.sku_code, u.fullname as collector_name
                    FROM expiry_records er
                    JOIN retailers r ON er.retailer_id = r.id
                    JOIN skus s ON er.sku_id = s.id
                    JOIN products p ON s.product_id = p.id
                    JOIN brands b ON p.brand_id = b.id
                    JOIN users u ON er.collected_by = u.id
                    ORDER BY er.id DESC
                ");
            } else {
                // Staff sees only their collections
                $stmt = $db->prepare("
                    SELECT er.*, r.shop_name, b.name as brand_name, p.name as product_name, s.sku_name, s.sku_code, u.fullname as collector_name
                    FROM expiry_records er
                    JOIN retailers r ON er.retailer_id = r.id
                    JOIN skus s ON er.sku_id = s.id
                    JOIN products p ON s.product_id = p.id
                    JOIN brands b ON p.brand_id = b.id
                    JOIN users u ON er.collected_by = u.id
                    WHERE er.collected_by = ?
                    ORDER BY er.id DESC
                ");
                $stmt->execute([$userId]);
            }
            $records = $stmt->fetchAll();
            sendJSON('success', 'Expiry records loaded.', $records);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch expiry records: ' . $e->getMessage());
        }
    }
    
    // 2. Summary Dashboard stats (Owner Only)
    if ($action === 'summary') {
        checkRole('Owner');
        try {
            // General count and amount (Outstanding only)
            $stmtStats = $db->query("
                SELECT 
                    COALESCE(SUM(quantity), 0) as total_qty, 
                    COALESCE(SUM(amount), 0) as total_amount,
                    COUNT(DISTINCT sku_id) as total_distinct_skus
                FROM expiry_records
                WHERE status = 'Collected'
            ");
            $stats = $stmtStats->fetch();
            
            // Brand-wise returns summary (Outstanding only)
            $stmtBrand = $db->query("
                SELECT 
                    b.name as brand_name, 
                    SUM(er.quantity) as total_qty, 
                    SUM(er.amount) as total_amount,
                    COUNT(DISTINCT er.sku_id) as products_count
                FROM expiry_records er
                JOIN skus s ON er.sku_id = s.id
                JOIN products p ON s.product_id = p.id
                JOIN brands b ON p.brand_id = b.id
                WHERE er.status = 'Collected'
                GROUP BY b.id
                ORDER BY total_amount DESC
            ");
            $brandSummary = $stmtBrand->fetchAll();
            
            // Retailer-wise summary (Outstanding only)
            $stmtRetailer = $db->query("
                SELECT 
                    r.shop_name, 
                    SUM(er.quantity) as total_qty, 
                    SUM(er.amount) as total_amount
                FROM expiry_records er
                JOIN retailers r ON er.retailer_id = r.id
                WHERE er.status = 'Collected'
                GROUP BY r.id
                ORDER BY total_amount DESC
            ");
            $retailerSummary = $stmtRetailer->fetchAll();
            
            sendJSON('success', 'Summary data retrieved.', [
                'stats' => $stats,
                'brands' => $brandSummary,
                'retailers' => $retailerSummary
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to calculate summary: ' . $e->getMessage());
        }
    }
    
    // 5. List Brand Returns Log (Owner Only)
    if ($action === 'returns_log') {
        checkRole('Owner');
        try {
            $stmt = $db->query("
                SELECT er.*, r.shop_name, b.name as brand_name, p.name as product_name, s.sku_name, s.sku_code
                FROM expiry_records er
                JOIN retailers r ON er.retailer_id = r.id
                JOIN skus s ON er.sku_id = s.id
                JOIN products p ON s.product_id = p.id
                JOIN brands b ON p.brand_id = b.id
                WHERE er.status IN ('Returned to Brand', 'Written Off')
                ORDER BY er.id DESC
            ");
            $records = $stmt->fetchAll();
            sendJSON('success', 'Returns log loaded.', $records);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch returns log: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // 3. Create Expiry Claim / Collection
    if ($action === 'create') {
        $retailer_id = (int)($_POST['retailer_id'] ?? 0);
        $sku_id = (int)($_POST['sku_id'] ?? 0);
        $quantity = (int)($_POST['quantity'] ?? 0);
        $rate = (float)($_POST['rate'] ?? 0);
        $remarks = cleanInput($_POST['remarks'] ?? '');
        
        if ($retailer_id <= 0 || $sku_id <= 0 || $quantity <= 0 || $rate <= 0) {
            sendJSON('error', 'Please fill in all required fields with valid values.');
        }
        
        // Verify Retailer assignment if Sales Staff
        if ($roleName !== 'Owner') {
            try {
                $stmtCheck = $db->prepare("SELECT id FROM retailers WHERE id = ? AND assigned_staff_id = ?");
                $stmtCheck->execute([$retailer_id, $userId]);
                if (!$stmtCheck->fetch()) {
                    sendJSON('error', 'Unauthorized: Retailer not assigned to you.');
                }
            } catch (PDOException $e) {
                sendJSON('error', 'Verification failed: ' . $e->getMessage());
            }
        }
        
        $amount = $quantity * $rate;
        
        try {
            $stmt = $db->prepare("
                INSERT INTO expiry_records (retailer_id, sku_id, quantity, rate, amount, collected_by, remarks, status)
                VALUES (?, ?, ?, ?, ?, ?, ?, 'Collected')
            ");
            $stmt->execute([$retailer_id, $sku_id, $quantity, $rate, $amount, $userId, $remarks]);
            
            logActivity('Expiry Collection', "Collected {$quantity} units of SKU ID {$sku_id} from Retailer ID {$retailer_id}. Value: " . formatRupees($amount));
            sendJSON('success', 'Expiry claim recorded successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    // 4. Update Expiry Claim Status (Owner Only)
    if ($action === 'update_status') {
        checkRole('Owner');
        
        $id = (int)($_POST['id'] ?? 0);
        $status = cleanInput($_POST['status'] ?? '');
        
        if ($id <= 0 || !in_array($status, ['Collected', 'Returned to Brand', 'Written Off'])) {
            sendJSON('error', 'Invalid parameters provided.');
        }
        
        try {
            $stmt = $db->prepare("UPDATE expiry_records SET status = ? WHERE id = ?");
            $stmt->execute([$status, $id]);
            
            logActivity('Expiry Status Update', "Updated Expiry ID {$id} status to '{$status}'.");
            sendJSON('success', 'Status updated successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    // 6. Return Brand Expiries (Owner Only)
    if ($action === 'return_brand') {
        checkRole('Owner');
        
        $brand_name = cleanInput($_POST['brand_name'] ?? '');
        
        if (empty($brand_name)) {
            sendJSON('error', 'Brand name is required.');
        }
        
        try {
            // Update all 'Collected' status records for this brand
            $stmt = $db->prepare("
                UPDATE expiry_records er
                JOIN skus s ON er.sku_id = s.id
                JOIN products p ON s.product_id = p.id
                JOIN brands b ON p.brand_id = b.id
                SET er.status = 'Returned to Brand'
                WHERE b.name = ? AND er.status = 'Collected'
            ");
            $stmt->execute([$brand_name]);
            
            $count = $stmt->rowCount();
            
            logActivity('Brand Return Processed', "Processed return to brand '{$brand_name}' for {$count} records.");
            sendJSON('success', "Successfully processed return to brand '{$brand_name}' for {$count} item(s).");
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
