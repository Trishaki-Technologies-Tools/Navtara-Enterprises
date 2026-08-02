<?php
// api/retailers.php
// AJAX Handler for Retailer Management (CRUD, Timelines & Visits)

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';
$userId = $_SESSION['user_id'];
$roleName = $_SESSION['role_name'];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        try {
            $route_id = !empty($_GET['route_id']) ? (int)$_GET['route_id'] : null;
            
            // Owner can see all retailers, Sales Staff can see only their assigned retailers
            if ($roleName === 'Owner') {
                $sql = "
                    SELECT r.*, 
                           rt.route_name, 
                           (SELECT GROUP_CONCAT(DISTINCT u.fullname SEPARATOR ', ') 
                            FROM route_schedules rs2 JOIN users u ON rs2.staff_id = u.id 
                            WHERE rs2.route_id = rt.id) as staff_names
                    FROM retailers r 
                    LEFT JOIN route_retailers rr ON r.id = rr.retailer_id
                    LEFT JOIN routes rt ON rr.route_id = rt.id
                ";
                $params = [];
                if ($route_id) {
                    $sql .= " WHERE rr.route_id = ?";
                    $params[] = $route_id;
                }
                $sql .= " ORDER BY r.id DESC";
                $stmt = $db->prepare($sql);
                $stmt->execute($params);
            } else {
                $sql = "
                    SELECT DISTINCT r.*, 
                           rt.route_name, 
                           (SELECT GROUP_CONCAT(DISTINCT u.fullname SEPARATOR ', ') 
                            FROM route_schedules rs2 JOIN users u ON rs2.staff_id = u.id 
                            WHERE rs2.route_id = rt.id) as staff_names
                    FROM retailers r 
                    JOIN route_retailers rr ON r.id = rr.retailer_id
                    JOIN routes rt ON rr.route_id = rt.id
                    JOIN route_schedules rs ON rr.route_id = rs.route_id
                    WHERE rs.staff_id = ?
                ";
                $params = [$userId];
                if ($route_id) {
                    $sql .= " AND rr.route_id = ?";
                    $params[] = $route_id;
                }
                $sql .= " ORDER BY r.id DESC";
                $stmt = $db->prepare($sql);
                $stmt->execute($params);
            }
            $retailers = $stmt->fetchAll();
            sendJSON('success', 'Retailers loaded.', $retailers);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch retailers: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            // Verify access
            if ($roleName === 'Owner') {
                $stmt = $db->prepare("
                    SELECT r.*, rr.route_id 
                    FROM retailers r 
                    LEFT JOIN route_retailers rr ON r.id = rr.retailer_id 
                    WHERE r.id = ?
                ");
                $stmt->execute([$id]);
            } else {
                $stmt = $db->prepare("
                    SELECT DISTINCT r.*, rr.route_id 
                    FROM retailers r 
                    JOIN route_retailers rr ON r.id = rr.retailer_id 
                    JOIN route_schedules rs ON rr.route_id = rs.route_id
                    WHERE r.id = ? AND rs.staff_id = ?
                ");
                $stmt->execute([$id, $userId]);
            }
            
            $retailer = $stmt->fetch();
            if ($retailer) {
                // Fetch timeline logs too
                $stmtTimeline = $db->prepare("
                    SELECT t.*, u.fullname as staff_name 
                    FROM retailer_timeline t 
                    JOIN users u ON t.staff_id = u.id 
                    WHERE t.retailer_id = ? 
                    ORDER BY t.id DESC
                ");
                $stmtTimeline->execute([$id]);
                $retailer['timeline'] = $stmtTimeline->fetchAll();
                
                sendJSON('success', 'Retailer details loaded.', $retailer);
            } else {
                sendJSON('error', 'Retailer not found or access denied.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($action === 'create') {
        $name = cleanInput($_POST['name'] ?? '');
        $owner_name = cleanInput($_POST['owner_name'] ?? '');
        $shop_name = cleanInput($_POST['shop_name'] ?? '');
        $gst_number = cleanInput($_POST['gst_number'] ?? '');
        $mobile = cleanInput($_POST['mobile'] ?? '');
        $alternate_mobile = cleanInput($_POST['alternate_mobile'] ?? '');
        $email = cleanInput($_POST['email'] ?? '');
        $address = cleanInput($_POST['address'] ?? '');
        $area = cleanInput($_POST['area'] ?? '');
        $city = cleanInput($_POST['city'] ?? '');
        $state = cleanInput($_POST['state'] ?? 'Goa');
        $pin_code = cleanInput($_POST['pin_code'] ?? '');
        $google_map_link = cleanInput($_POST['google_map_link'] ?? '');
        $business_type = cleanInput($_POST['business_type'] ?? 'Retail Shop');
        $visit_frequency = cleanInput($_POST['visit_frequency'] ?? 'Weekly');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        
        // Owner sets assignment; staff defaults to themselves
        if ($roleName === 'Owner') {
            $assigned_staff_id = !empty($_POST['assigned_staff_id']) ? (int)$_POST['assigned_staff_id'] : null;
            $credit_limit = (float)($_POST['credit_limit'] ?? 50000.00);
            $opening_balance = (float)($_POST['opening_balance'] ?? 0.00);
        } else {
            $assigned_staff_id = $userId; // Auto-assign to creating staff
            $credit_limit = 50000.00; // Default
            $opening_balance = 0.00;
        }
        
        $status = cleanInput($_POST['status'] ?? 'Active');
        $route_id = !empty($_POST['route_id']) ? (int)$_POST['route_id'] : null;
        
        if (empty($name) || empty($shop_name) || empty($mobile) || empty($address) || empty($area) || empty($city) || empty($pin_code)) {
            sendJSON('error', 'All fields marked with * are required.');
        }

        // Validate staff can only assign routes assigned to them
        if ($route_id && $roleName !== 'Owner') {
            $chkRoute = $db->prepare("SELECT COUNT(*) FROM route_schedules WHERE staff_id = ? AND route_id = ?");
            $chkRoute->execute([$userId, $route_id]);
            if ($chkRoute->fetchColumn() == 0) {
                sendJSON('error', 'You can only assign routes that are scheduled to you.');
            }
        }
        
        $db->beginTransaction();
        try {
            $stmt = $db->prepare("
                INSERT INTO retailers 
                (name, owner_name, shop_name, gst_number, mobile, alternate_mobile, email, address, area, city, state, pin_code, google_map_link, business_type, created_by_staff_id, credit_limit, outstanding_amount, opening_balance, status, visit_frequency, remarks) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmt->execute([
                $name, $owner_name, $shop_name, $gst_number, $mobile, $alternate_mobile, $email, $address, $area, $city, $state, $pin_code, $google_map_link, $business_type, $userId, $credit_limit, $opening_balance, $opening_balance, $status, $visit_frequency, $remarks
            ]);
            $retailerId = $db->lastInsertId();
            
            // Log in customer ledger
            $stmtLedger = $db->prepare("
                INSERT INTO customer_ledger (retailer_id, transaction_type, transaction_date, reference_id, reference_type, debit_amount, credit_amount, balance, remarks) 
                VALUES (?, 'Opening Balance', CURDATE(), ?, 'None', ?, 0.00, ?, 'Retailer created with opening balance')
            ");
            $stmtLedger->execute([$retailerId, $retailerId, $opening_balance, $opening_balance]);
            
            if ($route_id) {
                $stmtRoute = $db->prepare("
                    INSERT INTO route_retailers (route_id, retailer_id, sequence_order) 
                    VALUES (?, ?, 0)
                ");
                $stmtRoute->execute([$route_id, $retailerId]);
            }
            
            $db->commit();
            logActivity('Create Retailer', "Created retailer {$shop_name} (Owner: {$owner_name})");
            sendJSON('success', 'Retailer registered successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'update') {
        $id = (int)($_POST['id'] ?? 0);
        $name = cleanInput($_POST['name'] ?? '');
        $owner_name = cleanInput($_POST['owner_name'] ?? '');
        $shop_name = cleanInput($_POST['shop_name'] ?? '');
        $gst_number = cleanInput($_POST['gst_number'] ?? '');
        $mobile = cleanInput($_POST['mobile'] ?? '');
        $alternate_mobile = cleanInput($_POST['alternate_mobile'] ?? '');
        $email = cleanInput($_POST['email'] ?? '');
        $address = cleanInput($_POST['address'] ?? '');
        $area = cleanInput($_POST['area'] ?? '');
        $city = cleanInput($_POST['city'] ?? '');
        $state = cleanInput($_POST['state'] ?? 'Goa');
        $pin_code = cleanInput($_POST['pin_code'] ?? '');
        $google_map_link = cleanInput($_POST['google_map_link'] ?? '');
        $business_type = cleanInput($_POST['business_type'] ?? 'Retail Shop');
        $visit_frequency = cleanInput($_POST['visit_frequency'] ?? 'Weekly');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        $status = cleanInput($_POST['status'] ?? 'Active');
        $route_id = !empty($_POST['route_id']) ? (int)$_POST['route_id'] : null;
        
        if ($id <= 0 || empty($name) || empty($shop_name) || empty($mobile)) {
            sendJSON('error', 'Required fields are missing.');
        }
        
        // Authorization check: Sales staff can only update their assigned retailers
        if ($roleName !== 'Owner') {
            $chk = $db->prepare("
                SELECT COUNT(*) 
                FROM route_retailers rr 
                JOIN route_schedules rs ON rr.route_id = rs.route_id 
                WHERE rr.retailer_id = ? AND rs.staff_id = ?
            ");
            $chk->execute([$id, $userId]);
            if ($chk->fetchColumn() == 0) {
                sendJSON('error', 'Unauthorized operation.');
            }
            // Also validate route belongs to this staff member
            if ($route_id) {
                $chkRoute = $db->prepare("SELECT COUNT(*) FROM route_schedules WHERE staff_id = ? AND route_id = ?");
                $chkRoute->execute([$userId, $route_id]);
                if ($chkRoute->fetchColumn() == 0) {
                    sendJSON('error', 'You can only assign routes that are scheduled to you.');
                }
            }
        }
        
        $db->beginTransaction();
        try {
            if ($roleName === 'Owner') {
                $credit_limit = (float)($_POST['credit_limit'] ?? 50000.00);
                
                $stmt = $db->prepare("
                    UPDATE retailers 
                    SET name = ?, owner_name = ?, shop_name = ?, gst_number = ?, mobile = ?, alternate_mobile = ?, email = ?, address = ?, area = ?, city = ?, state = ?, pin_code = ?, google_map_link = ?, business_type = ?, credit_limit = ?, status = ?, visit_frequency = ?, remarks = ?
                    WHERE id = ?
                ");
                $stmt->execute([
                    $name, $owner_name, $shop_name, $gst_number, $mobile, $alternate_mobile, $email, $address, $area, $city, $state, $pin_code, $google_map_link, $business_type, $credit_limit, $status, $visit_frequency, $remarks, $id
                ]);
            } else {
                // Sales staff cannot change assignments or credit limits
                $stmt = $db->prepare("
                    UPDATE retailers 
                    SET name = ?, owner_name = ?, shop_name = ?, gst_number = ?, mobile = ?, alternate_mobile = ?, email = ?, address = ?, area = ?, city = ?, state = ?, pin_code = ?, google_map_link = ?, business_type = ?, status = ?, visit_frequency = ?, remarks = ?
                    WHERE id = ?
                ");
                $stmt->execute([
                    $name, $owner_name, $shop_name, $gst_number, $mobile, $alternate_mobile, $email, $address, $area, $city, $state, $pin_code, $google_map_link, $business_type, $status, $visit_frequency, $remarks, $id
                ]);
            }
            
            // Update route assignment
            $stmtDelRoute = $db->prepare("DELETE FROM route_retailers WHERE retailer_id = ?");
            $stmtDelRoute->execute([$id]);
            
            if ($route_id) {
                $stmtRoute = $db->prepare("
                    INSERT INTO route_retailers (route_id, retailer_id, sequence_order) 
                    VALUES (?, ?, 0)
                ");
                $stmtRoute->execute([$route_id, $id]);
            }
            
            $db->commit();
            logActivity('Update Retailer', "Updated retailer profile: {$shop_name} (ID: {$id})");
            sendJSON('success', 'Retailer updated successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        checkRole('Owner'); // Only owner can delete a retailer
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid retailer ID.');
        }
        
        try {
            // Delete customer ledger entries first if cascade not configured
            $stmt = $db->prepare("DELETE FROM customer_ledger WHERE retailer_id = ?");
            $stmt->execute([$id]);
            
            $stmt = $db->prepare("DELETE FROM retailers WHERE id = ?");
            $stmt->execute([$id]);
            
            logActivity('Delete Retailer', "Deleted retailer ID: {$id}");
            sendJSON('success', 'Retailer profile deleted successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1451) {
                sendJSON('error', 'Cannot delete retailer. It has transaction, invoice, or order references.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    // ASSIGN BEAT ROUTE
    if ($action === 'assign_route') {
        $id = (int)($_POST['id'] ?? 0);
        $route_id = !empty($_POST['route_id']) ? (int)$_POST['route_id'] : null;
        if ($id <= 0) {
            sendJSON('error', 'Invalid retailer ID.');
        }
        try {
            $db->beginTransaction();
            $stmtDel = $db->prepare("DELETE FROM route_retailers WHERE retailer_id = ?");
            $stmtDel->execute([$id]);
            
            if ($route_id) {
                $stmtIns = $db->prepare("INSERT INTO route_retailers (route_id, retailer_id, sequence_order) VALUES (?, ?, 0)");
                $stmtIns->execute([$route_id, $id]);
            }
            $db->commit();
            
            logActivity('Assign Route', "Retailer ID {$id} route set to " . ($route_id ?? 'None'));
            sendJSON('success', 'Route assignment updated.');
        } catch (PDOException $e) {
            $db->rollBack();
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }

    // SALES VISITS / TIMELINE LOGGING
    if ($action === 'log_visit') {
        $retailer_id = (int)($_POST['retailer_id'] ?? 0);
        $visit_status = cleanInput($_POST['visit_status'] ?? 'Visited - No Order');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        $lat = !empty($_POST['lat']) ? (float)$_POST['lat'] : null;
        $lng = !empty($_POST['lng']) ? (float)$_POST['lng'] : null;
        
        if ($retailer_id <= 0 || empty($remarks)) {
            sendJSON('error', 'Remarks are required to register a visit.');
        }
        
        // Verify staff access to retailer
        if ($roleName !== 'Owner') {
            $chk = $db->prepare("SELECT COUNT(*) FROM retailers WHERE id = ? AND assigned_staff_id = ?");
            $chk->execute([$retailer_id, $userId]);
            if ($chk->fetchColumn() == 0) {
                sendJSON('error', 'Access denied.');
            }
        }
        
        try {
            $stmt = $db->prepare("
                INSERT INTO retailer_timeline (retailer_id, staff_id, visit_date, visit_status, remarks, location_lat, location_lng)
                VALUES (?, ?, CURDATE(), ?, ?, ?, ?)
            ");
            $stmt->execute([$retailer_id, $userId, $visit_status, $remarks, $lat, $lng]);
            
            logActivity('Log Visit', "Logged visit status '{$visit_status}' for Retailer ID: {$retailer_id}");
            sendJSON('success', 'Visit details logged successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
