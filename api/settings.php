<?php
// api/settings.php
// AJAX Handler for Company Profile Settings, Tax settings and Database backup/restore

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';

// Only Owner can save settings, perform backup, restore, or manage owner credentials
if (in_array($action, ['save', 'backup', 'restore', 'load-owner', 'save-owner'])) {
    checkRole('Owner');
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'load') {
        try {
            $stmt = $db->query("SELECT key_name, val_value FROM settings");
            $rows = $stmt->fetchAll();
            
            $settings = [];
            foreach ($rows as $row) {
                $settings[$row['key_name']] = html_entity_decode($row['val_value'], ENT_QUOTES, 'UTF-8');
            }
            
            sendJSON('success', 'Settings loaded.', $settings);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }

    if ($action === 'load-owner') {
        try {
            $userId = $_SESSION['user_id'];
            $stmt = $db->prepare("SELECT username, fullname, email, mobile, photo FROM users WHERE id = ?");
            $stmt->execute([$userId]);
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if (!$user) {
                sendJSON('error', 'User not found.');
            }
            
            sendJSON('success', 'Owner profile loaded.', $user);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    // BACKUP DATABASE (DUMP TABLES TO SQL FILE)
    if ($action === 'backup') {
        try {
            $tables = ['roles', 'users', 'sales_staff_details', 'brands', 'products', 'skus', 
                       'retailers', 'orders', 'order_items', 'invoices', 'invoice_items', 
                       'payments', 'customer_ledger', 'inventory_history', 'expenses', 
                       'retailer_timeline', 'activity_logs', 'settings'];
            
            $sqlDump = "-- NAVtara ERP Database Backup\n";
            $sqlDump .= "-- Generated on: " . date('Y-m-d H:i:s') . "\n";
            $sqlDump .= "SET FOREIGN_KEY_CHECKS=0;\n\n";
            
            foreach ($tables as $table) {
                // Drop table statement
                $sqlDump .= "DROP TABLE IF EXISTS `{$table}`;\n";
                
                // Create table statement
                $stmtCreate = $db->query("SHOW CREATE TABLE `{$table}`");
                $rowCreate = $stmtCreate->fetch(PDO::FETCH_NUM);
                $sqlDump .= $rowCreate[1] . ";\n\n";
                
                // Data insertion statement
                $stmtData = $db->query("SELECT * FROM `{$table}`");
                $rowsData = $stmtData->fetchAll(PDO::FETCH_ASSOC);
                
                if (count($rowsData) > 0) {
                    $sqlDump .= "INSERT INTO `{$table}` VALUES \n";
                    $valueLines = [];
                    foreach ($rowsData as $rowData) {
                        $escapedValues = array_map(function($val) use ($db) {
                            if ($val === null) return 'NULL';
                            return $db->quote($val);
                        }, array_values($rowData));
                        
                        $valueLines[] = "(" . implode(", ", $escapedValues) . ")";
                    }
                    $sqlDump .= implode(",\n", $valueLines) . ";\n\n";
                }
            }
            
            $sqlDump .= "SET FOREIGN_KEY_CHECKS=1;\n";
            
            // Send file download headers
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="navtara_backup_' . date('Ymd_His') . '.sql"');
            header('Content-Length: ' . strlen($sqlDump));
            echo $sqlDump;
            
            logActivity('Database Backup', 'Exported database SQL backup file.');
            exit;
        } catch (PDOException $e) {
            die("Backup failed: " . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($action === 'save') {
        $db->beginTransaction();
        try {
            $stmt = $db->prepare("INSERT INTO settings (key_name, val_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE val_value = ?");
            
            foreach ($_POST as $key => $val) {
                $cleanKey = cleanInput($key);
                // Do not escape JSON configs or standard rich texts if needed, but cleanInput is fine for simple fields
                $cleanVal = is_array($val) ? json_encode($val) : cleanInput($val);
                
                $stmt->execute([$cleanKey, $cleanVal, $cleanVal]);
            }
            
            $db->commit();
            logActivity('Update Settings', 'Updated company profile details.');
            sendJSON('success', 'Settings saved successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            sendJSON('error', 'Failed to save settings: ' . $e->getMessage());
        }
    }
    
    // RESTORE DATABASE
    if ($action === 'restore') {
        if (!isset($_FILES['backup_file']) || $_FILES['backup_file']['error'] !== UPLOAD_ERR_OK) {
            sendJSON('error', 'Please upload a valid backup SQL file.');
        }
        
        $file = $_FILES['backup_file'];
        $sqlContent = file_get_contents($file['tmp_name']);
        
        if (strpos($sqlContent, 'NAVtara ERP') === false) {
            sendJSON('error', 'Restoration cancelled: The file uploaded is not a valid NAVtara ERP backup.');
        }
        
        try {
            $db->exec($sqlContent);
            logActivity('Database Restore', 'Restored database from uploaded SQL file.');
            sendJSON('success', 'Database restored successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Restoration failed: ' . $e->getMessage());
        }
    }

    if ($action === 'save-owner') {
        try {
            $userId = $_SESSION['user_id'];
            $fullname = cleanInput($_POST['fullname'] ?? '');
            $username = cleanInput($_POST['username'] ?? '');
            $email = cleanInput($_POST['email'] ?? '');
            $mobile = cleanInput($_POST['mobile'] ?? '');
            $password = $_POST['password'] ?? '';
            $password_confirm = $_POST['password_confirm'] ?? '';
            
            if (empty($fullname) || empty($username)) {
                sendJSON('error', 'Full Name and Username are required.');
            }
            
            // Check uniqueness of username
            $stmt = $db->prepare("SELECT COUNT(*) FROM users WHERE username = ? AND id != ?");
            $stmt->execute([$username, $userId]);
            if ($stmt->fetchColumn() > 0) {
                sendJSON('error', 'Username is already taken.');
            }
            
            // Check uniqueness of email
            if (!empty($email)) {
                $stmt = $db->prepare("SELECT COUNT(*) FROM users WHERE email = ? AND id != ?");
                $stmt->execute([$email, $userId]);
                if ($stmt->fetchColumn() > 0) {
                    sendJSON('error', 'Email address is already in use.');
                }
            } else {
                $email = null;
            }
            
            // Handle profile photo upload
            $photoPath = null;
            if (isset($_FILES['photo']) && $_FILES['photo']['error'] === UPLOAD_ERR_OK) {
                $photoPath = uploadFile('photo', 'profile');
                if ($photoPath === false) {
                    sendJSON('error', 'Invalid photo format. Only JPG, PNG, WEBP, and GIF are allowed.');
                }
            }
            
            $db->beginTransaction();
            
            if ($photoPath) {
                // Delete old profile photo if it exists
                $stmtPhoto = $db->prepare("SELECT photo FROM users WHERE id = ?");
                $stmtPhoto->execute([$userId]);
                $oldPhoto = $stmtPhoto->fetchColumn();
                if ($oldPhoto && file_exists(__DIR__ . '/../' . $oldPhoto)) {
                    @unlink(__DIR__ . '/../' . $oldPhoto);
                }
                
                $stmtUpdate = $db->prepare("UPDATE users SET fullname = ?, username = ?, email = ?, mobile = ?, photo = ? WHERE id = ?");
                $stmtUpdate->execute([$fullname, $username, $email, $mobile, $photoPath, $userId]);
                $_SESSION['photo'] = $photoPath;
            } else {
                $stmtUpdate = $db->prepare("UPDATE users SET fullname = ?, username = ?, email = ?, mobile = ? WHERE id = ?");
                $stmtUpdate->execute([$fullname, $username, $email, $mobile, $userId]);
            }
            
            if (!empty($password)) {
                if ($password !== $password_confirm) {
                    $db->rollBack();
                    sendJSON('error', 'Passwords do not match.');
                }
                $password_hash = password_hash($password, PASSWORD_DEFAULT);
                $stmtPwd = $db->prepare("UPDATE users SET password_hash = ? WHERE id = ?");
                $stmtPwd->execute([$password_hash, $userId]);
            }
            
            $db->commit();
            
            $_SESSION['fullname'] = $fullname;
            $_SESSION['username'] = $username;
            
            logActivity('Update Profile', 'Updated owner profile details.');
            sendJSON('success', 'Profile updated successfully.', ['photo' => $photoPath]);
        } catch (PDOException $e) {
            if ($db->inTransaction()) {
                $db->rollBack();
            }
            sendJSON('error', 'Failed to update profile: ' . $e->getMessage());
        }
    }
}
?>
