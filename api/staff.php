<?php
// api/staff.php
// AJAX Handler for Sales Staff Management (CRUD & Performance Target Logs)

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkRole('Owner'); // Only the Owner can manage staff accounts

$db = getDBConnection();
$action = $_GET['action'] ?? '';

// Dynamically retrieve 'Sales Staff' role ID, auto-creating it if missing
try {
    $roleStmt = $db->prepare("SELECT id FROM roles WHERE name = 'Sales Staff' LIMIT 1");
    $roleStmt->execute();
    $salesRoleId = $roleStmt->fetchColumn();
    if (!$salesRoleId) {
        $insertRole = $db->prepare("INSERT INTO roles (name, description) VALUES ('Sales Staff', 'Staff with limited access to catalog, retailers, and order placing')");
        $insertRole->execute();
        $salesRoleId = $db->lastInsertId();
    }
} catch (PDOException $e) {
    // Fallback to default ID 2 if roles table query fails or is empty
    $salesRoleId = 2;
}

// Auto-create staff_routes table if it doesn't exist
try {
    $db->exec("
        CREATE TABLE IF NOT EXISTS `staff_routes` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            `user_id` INT NOT NULL,
            `route_id` INT NOT NULL,
            `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            UNIQUE KEY `uq_staff_route` (`user_id`, `route_id`),
            FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
            FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    ");
} catch (PDOException $e) { /* silently ignore */ }

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        try {
            $stmt = $db->prepare("
                SELECT u.id, u.username, u.fullname, u.email, u.mobile, u.photo, u.status, u.created_at,
                       d.assigned_area, d.salary, d.sales_target, d.joining_date,
                       GROUP_CONCAT(rt.route_name ORDER BY rt.route_name SEPARATOR ', ') as route_names,
                       GROUP_CONCAT(rt.id ORDER BY rt.route_name SEPARATOR ',') as route_ids
                FROM users u
                LEFT JOIN sales_staff_details d ON u.id = d.user_id
                LEFT JOIN staff_routes sr ON u.id = sr.user_id
                LEFT JOIN routes rt ON sr.route_id = rt.id
                WHERE u.role_id = ?
                GROUP BY u.id
                ORDER BY u.id DESC
            ");
            $stmt->execute([$salesRoleId]);
            $staff = $stmt->fetchAll();
            sendJSON('success', 'Staff list loaded.', $staff);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch sales staff: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("
                SELECT u.id, u.username, u.fullname, u.email, u.mobile, u.photo, u.status,
                       d.assigned_area, d.salary, d.sales_target, d.joining_date
                FROM users u
                LEFT JOIN sales_staff_details d ON u.id = d.user_id
                WHERE u.id = ? AND u.role_id = ?
            ");
            $stmt->execute([$id, $salesRoleId]);
            $member = $stmt->fetch();
            if ($member) {
                // Fetch assigned route IDs
                $stmtRoutes = $db->prepare("SELECT route_id FROM staff_routes WHERE user_id = ?");
                $stmtRoutes->execute([$id]);
                $member['assigned_route_ids'] = $stmtRoutes->fetchAll(PDO::FETCH_COLUMN);
                sendJSON('success', 'Staff details loaded.', $member);
            } else {
                sendJSON('error', 'Staff member not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    // FETCH ACTIVITY LOGS FOR A SPECIFIC STAFF
    if ($action === 'activity_logs') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("
                SELECT * FROM activity_logs 
                WHERE user_id = ? 
                ORDER BY id DESC 
                LIMIT 50
            ");
            $stmt->execute([$id]);
            $logs = $stmt->fetchAll();
            sendJSON('success', 'Activity logs loaded.', $logs);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($action === 'create') {
        $fullname = cleanInput($_POST['fullname'] ?? '');
        $username = cleanInput($_POST['username'] ?? '');
        $password = $_POST['password'] ?? '';
        $email = cleanInput($_POST['email'] ?? '');
        if ($email === '') {
            $email = null;
        }
        $mobile = cleanInput($_POST['mobile'] ?? '');
        $status = cleanInput($_POST['status'] ?? 'Active');
        
        $assigned_area = cleanInput($_POST['assigned_area'] ?? '');
        $route_ids = isset($_POST['route_ids']) ? array_map('intval', (array)$_POST['route_ids']) : [];
        $salary = (float)($_POST['salary'] ?? 0.00);
        $sales_target = (float)($_POST['sales_target'] ?? 0.00);
        $joining_date = cleanInput($_POST['joining_date'] ?? date('Y-m-d'));
        
        if (empty($fullname) || empty($username) || empty($password) || empty($mobile)) {
            sendJSON('error', 'Full Name, Username, Password, and Mobile are required.');
        }
        
        // Handle photo upload
        $photoPath = null;
        if (isset($_FILES['photo']) && $_FILES['photo']['error'] === UPLOAD_ERR_OK) {
            $photoPath = uploadFile('photo', 'staff');
            if ($photoPath === false) {
                sendJSON('error', 'Invalid photo format. Only JPG, PNG, WEBP, and GIF are allowed.');
            }
        }
        
        $password_hash = password_hash($password, PASSWORD_BCRYPT);
        
        $db->beginTransaction();
        try {
            // 1. Insert into users table
            $stmtUser = $db->prepare("
                INSERT INTO users (role_id, username, password_hash, fullname, email, mobile, photo, status)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmtUser->execute([$salesRoleId, $username, $password_hash, $fullname, $email, $mobile, $photoPath, $status]);
            $newUserId = $db->lastInsertId();
            
            // 2. Insert into sales_staff_details table
            $stmtDetails = $db->prepare("
                INSERT INTO sales_staff_details (user_id, assigned_area, salary, sales_target, joining_date)
                VALUES (?, ?, ?, ?, ?)
            ");
            $stmtDetails->execute([$newUserId, $assigned_area, $salary, $sales_target, $joining_date]);

            // 3. Insert route assignments
            if (!empty($route_ids)) {
                $stmtRoute = $db->prepare("INSERT IGNORE INTO staff_routes (user_id, route_id) VALUES (?, ?)");
                foreach ($route_ids as $rid) {
                    if ($rid > 0) $stmtRoute->execute([$newUserId, $rid]);
                }
            }
            
            $db->commit();
            logActivity('Create Staff Account', "Created sales staff member {$fullname} (Username: {$username})");
            sendJSON('success', 'Sales staff account created successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            if ($e->errorInfo[1] == 1062) {
                sendJSON('error', 'Username or email already exists.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'update') {
        $id = (int)($_POST['id'] ?? 0);
        $fullname = cleanInput($_POST['fullname'] ?? '');
        $username = cleanInput($_POST['username'] ?? '');
        $password = $_POST['password'] ?? ''; // Optional replacement
        $email = cleanInput($_POST['email'] ?? '');
        if ($email === '') {
            $email = null;
        }
        $mobile = cleanInput($_POST['mobile'] ?? '');
        $status = cleanInput($_POST['status'] ?? 'Active');
        
        $assigned_area = cleanInput($_POST['assigned_area'] ?? '');
        $route_ids = isset($_POST['route_ids']) ? array_map('intval', (array)$_POST['route_ids']) : [];
        $salary = (float)($_POST['salary'] ?? 0.00);
        $sales_target = (float)($_POST['sales_target'] ?? 0.00);
        $joining_date = cleanInput($_POST['joining_date'] ?? date('Y-m-d'));
        
        if ($id <= 0 || empty($fullname) || empty($username) || empty($mobile)) {
            sendJSON('error', 'Required fields are missing.');
        }
        
        $db->beginTransaction();
        try {
            // Get current photo
            $stmt = $db->prepare("SELECT photo FROM users WHERE id = ?");
            $stmt->execute([$id]);
            $currentPhoto = $stmt->fetchColumn();
            
            // Handle photo upload
            $photoPath = $currentPhoto;
            if (isset($_FILES['photo']) && $_FILES['photo']['error'] === UPLOAD_ERR_OK) {
                $uploaded = uploadFile('photo', 'staff');
                if ($uploaded === false) {
                    sendJSON('error', 'Invalid photo format.');
                }
                $photoPath = $uploaded;
                if ($currentPhoto && file_exists(__DIR__ . '/../' . $currentPhoto)) {
                    @unlink(__DIR__ . '/../' . $currentPhoto);
                }
            }
            
            // Update users table details
            if (!empty($password)) {
                $password_hash = password_hash($password, PASSWORD_BCRYPT);
                $stmtUser = $db->prepare("
                    UPDATE users 
                    SET username = ?, password_hash = ?, fullname = ?, email = ?, mobile = ?, photo = ?, status = ?
                    WHERE id = ? AND role_id = ?
                ");
                $stmtUser->execute([$username, $password_hash, $fullname, $email, $mobile, $photoPath, $status, $id, $salesRoleId]);
            } else {
                $stmtUser = $db->prepare("
                    UPDATE users 
                    SET username = ?, fullname = ?, email = ?, mobile = ?, photo = ?, status = ?
                    WHERE id = ? AND role_id = ?
                ");
                $stmtUser->execute([$username, $fullname, $email, $mobile, $photoPath, $status, $id, $salesRoleId]);
            }
            
            // Check if details entry exists (in case it got deleted or not initialized)
            $chk = $db->prepare("SELECT COUNT(*) FROM sales_staff_details WHERE user_id = ?");
            $chk->execute([$id]);
            if ($chk->fetchColumn() > 0) {
                $stmtDetails = $db->prepare("
                    UPDATE sales_staff_details 
                    SET assigned_area = ?, salary = ?, sales_target = ?, joining_date = ?
                    WHERE user_id = ?
                ");
                $stmtDetails->execute([$assigned_area, $salary, $sales_target, $joining_date, $id]);
            } else {
                $stmtDetails = $db->prepare("
                    INSERT INTO sales_staff_details (user_id, assigned_area, salary, sales_target, joining_date)
                    VALUES (?, ?, ?, ?, ?)
                ");
                $stmtDetails->execute([$id, $assigned_area, $salary, $sales_target, $joining_date]);
            }

            // Replace route assignments
            $stmtDelRoutes = $db->prepare("DELETE FROM staff_routes WHERE user_id = ?");
            $stmtDelRoutes->execute([$id]);
            if (!empty($route_ids)) {
                $stmtRoute = $db->prepare("INSERT IGNORE INTO staff_routes (user_id, route_id) VALUES (?, ?)");
                foreach ($route_ids as $rid) {
                    if ($rid > 0) $stmtRoute->execute([$id, $rid]);
                }
            }
            
            $db->commit();
            logActivity('Update Staff Account', "Updated details for staff ID: {$id} ({$fullname})");
            sendJSON('success', 'Staff account updated successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            if ($e->errorInfo[1] == 1062) {
                sendJSON('error', 'Username or email already exists.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid staff ID.');
        }
        
        try {
            // Get photo path
            $stmt = $db->prepare("SELECT photo FROM users WHERE id = ?");
            $stmt->execute([$id]);
            $photo = $stmt->fetchColumn();
            
            // Delete user - cascades to details
            $stmtDelete = $db->prepare("DELETE FROM users WHERE id = ? AND role_id = ?");
            $stmtDelete->execute([$id, $salesRoleId]);
            
            if ($photo && file_exists(__DIR__ . '/../' . $photo)) {
                @unlink(__DIR__ . '/../' . $photo);
            }
            
            logActivity('Delete Staff Account', "Deleted sales staff member ID: {$id}");
            sendJSON('success', 'Sales staff account deleted successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1451) {
                sendJSON('error', 'Cannot delete staff member. They have recorded customer visits or orders.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
