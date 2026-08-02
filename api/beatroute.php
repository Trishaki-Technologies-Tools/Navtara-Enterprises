<?php
// api/beatroute.php
// AJAX Handler for Beatroute Master and Salesman Route Assignments

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';
$userId = $_SESSION['user_id'];
$roleName = $_SESSION['role_name'];

// Auto-create route_schedules table if missing
try {
    $db->exec("
        CREATE TABLE IF NOT EXISTS `route_schedules` (
            `id`          INT AUTO_INCREMENT PRIMARY KEY,
            `route_id`    INT NOT NULL,
            `staff_id`    INT NULL,
            `day_of_week` ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
            `notes`       VARCHAR(255) NULL,
            `created_at`  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            UNIQUE KEY `uq_route_day_staff` (`route_id`, `day_of_week`, `staff_id`),
            FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE CASCADE,
            FOREIGN KEY (`staff_id`) REFERENCES `users`  (`id`) ON DELETE SET NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    ");
} catch (PDOException $e) { /* silent */ }

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'routes_list') {
        try {
            $stmt = $db->query("
                SELECT r.*, 
                       (SELECT COUNT(*) FROM route_retailers rr WHERE rr.route_id = r.id) as retailer_count 
                FROM routes r 
                ORDER BY r.id DESC
            ");
            $routes = $stmt->fetchAll();
            sendJSON('success', 'Routes loaded.', $routes);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch routes: ' . $e->getMessage());
        }
    }

    // Returns only routes assigned to the current staff member (used in Add/Edit Retailer for staff)
    if ($action === 'my_routes') {
        try {
            if ($roleName === 'Owner') {
                // Owner can pass a specific staff_id to get that staff's routes, or get all routes
                $targetUserId = !empty($_GET['staff_id']) ? (int)$_GET['staff_id'] : null;
                if ($targetUserId) {
                    $stmt = $db->prepare("
                        SELECT r.id, r.route_name
                        FROM routes r
                        JOIN staff_routes sr ON sr.route_id = r.id
                        WHERE sr.user_id = ?
                        ORDER BY r.route_name ASC
                    ");
                    $stmt->execute([$targetUserId]);
                } else {
                    $stmt = $db->query("SELECT id, route_name FROM routes ORDER BY route_name ASC");
                }
            } else {
                $stmt = $db->prepare("
                    SELECT r.id, r.route_name
                    FROM routes r
                    JOIN staff_routes sr ON sr.route_id = r.id
                    WHERE sr.user_id = ?
                    ORDER BY r.route_name ASC
                ");
                $stmt->execute([$userId]);
            }
            $routes = $stmt->fetchAll();
            sendJSON('success', 'My routes loaded.', $routes);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch routes: ' . $e->getMessage());
        }
    }
    
    if ($action === 'route_detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            $stmt = $db->prepare("SELECT * FROM routes WHERE id = ?");
            $stmt->execute([$id]);
            $route = $stmt->fetch();
            if ($route) {
                // Fetch assigned retailers
                $stmtRetailers = $db->prepare("
                    SELECT rr.retailer_id, r.shop_name, r.name as owner_name, r.address, r.area, r.city 
                    FROM route_retailers rr
                    JOIN retailers r ON rr.retailer_id = r.id
                    WHERE rr.route_id = ?
                    ORDER BY rr.sequence_order ASC, rr.id ASC
                ");
                $stmtRetailers->execute([$id]);
                $route['retailers'] = $stmtRetailers->fetchAll();
                
                sendJSON('success', 'Route details loaded.', $route);
            } else {
                sendJSON('error', 'Route not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }

    // Weekly schedule — all days with their assigned routes+staff
    if ($action === 'schedule_list') {
        try {
            $stmt = $db->query("
                SELECT rs.id, rs.day_of_week, rs.notes,
                       r.id   AS route_id,   r.route_name,
                       u.id   AS staff_id,   u.fullname AS staff_name
                FROM route_schedules rs
                JOIN routes r ON rs.route_id = r.id
                LEFT JOIN users u ON rs.staff_id = u.id
                ORDER BY FIELD(rs.day_of_week,'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'), r.route_name
            ");
            sendJSON('success', 'Schedule loaded.', $stmt->fetchAll());
        } catch (PDOException $e) {
            sendJSON('error', 'DB error: ' . $e->getMessage());
        }
    }

    // Today's beat route retailers for the logged-in staff member
    if ($action === 'staff_today_route') {
        $staffId = $_SESSION['user_id'] ?? 0;
        $today   = date('l'); // Monday, Tuesday … 
        try {
            // Get today's schedule entries for this staff
            $stmtSched = $db->prepare("
                SELECT rs.id, rs.day_of_week, rs.notes,
                       r.id AS route_id, r.route_name
                FROM route_schedules rs
                JOIN routes r ON rs.route_id = r.id
                WHERE rs.staff_id = ? AND rs.day_of_week = ?
                ORDER BY rs.id ASC
            ");
            $stmtSched->execute([$staffId, $today]);
            $schedules = $stmtSched->fetchAll();

            // Collect route IDs to fetch retailers
            $routeIds = array_values(array_unique(array_column($schedules, 'route_id')));
            $retailers = [];
            if (!empty($routeIds)) {
                $placeholders = implode(',', array_fill(0, count($routeIds), '?'));
                $stmtRet = $db->prepare("
                    SELECT ret.id, ret.shop_name, ret.owner_name, ret.mobile,
                           ret.address, ret.area, ret.city, ret.outstanding_amount,
                           rr.route_id,
                           r.route_name,
                           (SELECT o.id FROM orders o WHERE o.retailer_id = ret.id AND o.order_date = CURDATE() ORDER BY o.id DESC LIMIT 1) as today_order_id

                    FROM route_retailers rr
                    JOIN retailers ret ON rr.retailer_id = ret.id
                    JOIN routes r ON rr.route_id = r.id
                    WHERE rr.route_id IN ({$placeholders}) AND ret.status = 'Active'
                    ORDER BY rr.sequence_order ASC, ret.shop_name ASC
                ");
                $stmtRet->execute($routeIds);
                $retailers = $stmtRet->fetchAll();
            }

            sendJSON('success', 'Today\'s beat routes loaded.', [
                'day'       => $today,
                'schedules' => $schedules,
                'retailers' => $retailers
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'DB error: ' . $e->getMessage());
        }
    }

}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    checkRole('Owner'); // Only owner can modify beatroutes and schedules
    
    if ($action === 'route_create') {
        $route_name = cleanInput($_POST['route_name'] ?? '');
        $retailer_ids = $_POST['retailer_ids'] ?? [];
        if (empty($route_name)) {
            sendJSON('error', 'Route name is required.');
        }
        $db->beginTransaction();
        try {
            $stmt = $db->prepare("INSERT INTO routes (route_name) VALUES (?)");
            $stmt->execute([$route_name]);
            $route_id = $db->lastInsertId();

            if (!empty($retailer_ids) && is_array($retailer_ids)) {
                $stmtIns = $db->prepare("
                    INSERT INTO route_retailers (route_id, retailer_id, sequence_order) 
                    VALUES (?, ?, ?)
                ");
                $seq = 0;
                foreach ($retailer_ids as $r_id) {
                    $stmtIns->execute([$route_id, (int)$r_id, $seq++]);
                }
            }

            $db->commit();
            logActivity('Create Route', "Created route: {$route_name} with assigned retailers.");
            sendJSON('success', 'Route created successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }

    if ($action === 'route_update') {
        $id = (int)($_POST['id'] ?? 0);
        $route_name = cleanInput($_POST['route_name'] ?? '');
        $retailer_ids = $_POST['retailer_ids'] ?? [];
        if ($id <= 0 || empty($route_name)) {
            sendJSON('error', 'Route ID and Route Name are required.');
        }
        $db->beginTransaction();
        try {
            $stmt = $db->prepare("UPDATE routes SET route_name = ? WHERE id = ?");
            $stmt->execute([$route_name, $id]);

            // Delete current assignments
            $stmtDel = $db->prepare("DELETE FROM route_retailers WHERE route_id = ?");
            $stmtDel->execute([$id]);

            // Insert new ones
            if (!empty($retailer_ids) && is_array($retailer_ids)) {
                $stmtIns = $db->prepare("
                    INSERT INTO route_retailers (route_id, retailer_id, sequence_order) 
                    VALUES (?, ?, ?)
                ");
                $seq = 0;
                foreach ($retailer_ids as $r_id) {
                    $stmtIns->execute([$id, (int)$r_id, $seq++]);
                }
            }

            $db->commit();
            logActivity('Update Route', "Updated route ID: {$id} with name {$route_name} and assigned retailers.");
            sendJSON('success', 'Route updated successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }

    if ($action === 'route_delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid route ID.');
        }
        try {
            $stmt = $db->prepare("DELETE FROM routes WHERE id = ?");
            $stmt->execute([$id]);
            logActivity('Delete Route', "Deleted route ID: {$id}");
            sendJSON('success', 'Route deleted successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }

    // ── Schedule: add entry
    if ($action === 'schedule_add') {
        $route_id   = (int)($_POST['route_id']   ?? 0);
        $staff_id   = !empty($_POST['staff_id'])  ? (int)$_POST['staff_id'] : null;
        $day        = cleanInput($_POST['day_of_week'] ?? '');
        $notes      = cleanInput($_POST['notes']  ?? '');
        $valid_days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
        if ($route_id <= 0 || !in_array($day, $valid_days)) {
            sendJSON('error', 'Route and a valid day are required.');
        }
        try {
            $stmt = $db->prepare("
                INSERT INTO route_schedules (route_id, staff_id, day_of_week, notes)
                VALUES (?, ?, ?, ?)
                ON DUPLICATE KEY UPDATE notes = VALUES(notes), staff_id = VALUES(staff_id)
            ");
            $stmt->execute([$route_id, $staff_id, $day, $notes]);
            logActivity('Schedule Route', "Scheduled route ID {$route_id} on {$day}");
            sendJSON('success', 'Schedule saved.');
        } catch (PDOException $e) {
            sendJSON('error', 'DB error: ' . $e->getMessage());
        }
    }

    // ── Schedule: remove entry
    if ($action === 'schedule_remove') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) sendJSON('error', 'Invalid schedule ID.');
        try {
            $db->prepare("DELETE FROM route_schedules WHERE id = ?")->execute([$id]);
            logActivity('Remove Schedule', "Removed schedule entry ID: {$id}");
            sendJSON('success', 'Schedule entry removed.');
        } catch (PDOException $e) {
            sendJSON('error', 'DB error: ' . $e->getMessage());
        }
    }

    // ── Schedule: reset all entries
    if ($action === 'schedule_reset') {
        checkRole('Owner');
        try {
            $db->exec("DELETE FROM route_schedules");
            logActivity('Reset Schedule', 'All weekly route schedule entries have been cleared.');
            sendJSON('success', 'Weekly schedule has been reset successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'DB error: ' . $e->getMessage());
        }
    }

    // ── Schedule: reset all entries for a specific staff member
    if ($action === 'schedule_reset_staff') {
        $staffId = (int)($_POST['staff_id'] ?? 0);
        if ($staffId <= 0) sendJSON('error', 'Invalid staff ID.');
        try {
            $db->prepare("DELETE FROM route_schedules WHERE staff_id = ?")->execute([$staffId]);
            logActivity('Reset Staff Schedule', "Cleared all schedule entries for Staff ID: {$staffId}");
            sendJSON('success', 'Staff schedule has been reset successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'DB error: ' . $e->getMessage());
        }
    }
}
?>
