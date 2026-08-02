<?php
// config/functions.php
// Common Helper Functions for Security, Session, Loggers and JSON Outputs

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/database.php';

/**
 * Send uniform JSON Response and terminate script
 */
function sendJSON($status, $message, $data = [], $httpCode = 200) {
    http_response_code($httpCode);
    header('Content-Type: application/json');
    echo json_encode([
        'status'  => $status, // 'success' or 'error'
        'message' => $message,
        'data'    => $data
    ]);
    exit;
}

/**
 * Clean user inputs for basic XSS prevention
 */
function cleanInput($data) {
    if (is_array($data)) {
        return array_map('cleanInput', $data);
    }
    return htmlspecialchars(trim($data), ENT_QUOTES, 'UTF-8');
}

/**
 * Check if a user session is active
 */
function isLoggedIn() {
    return isset($_SESSION['user_id']);
}

/**
 * Authenticate session check
 */
function checkAuth() {
    if (!isset($_SESSION['user_id'])) {
        if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
            sendJSON('error', 'Session expired. Please log in again.', [], 401);
        } else {
            header("Location: index.php?route=login");
            exit;
        }
    }
}

/**
 * Check if the active user has a specific role
 */
function checkRole($roleName) {
    checkAuth();
    if ($_SESSION['role_name'] !== $roleName) {
        if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
            sendJSON('error', 'Unauthorized access.', [], 403);
        } else {
            die("Access Denied: You do not have permission to view this resource.");
        }
    }
}

/**
 * Check if user is Owner
 */
function isOwner() {
    return isset($_SESSION['role_name']) && $_SESSION['role_name'] === 'Owner';
}

/**
 * Logger for Audit Trail and Activity History
 */
function logActivity($action, $description = '') {
    $db = getDBConnection();
    $userId = $_SESSION['user_id'] ?? null;
    $ip = $_SERVER['REMOTE_ADDR'] ?? '127.0.0.1';
    
    try {
        $stmt = $db->prepare("INSERT INTO activity_logs (user_id, action, description, ip_address) VALUES (?, ?, ?, ?)");
        $stmt->execute([$userId, $action, $description, $ip]);
    } catch (PDOException $e) {
        // Fail silently to prevent interrupting main workflow
    }
}

/**
 * Get dynamic application setting from database
 */
function getSetting($key, $default = '') {
    $db = getDBConnection();
    try {
        $stmt = $db->prepare("SELECT val_value FROM settings WHERE key_name = ?");
        $stmt->execute([$key]);
        $row = $stmt->fetch();
        return $row ? $row['val_value'] : $default;
    } catch (PDOException $e) {
        return $default;
    }
}

/**
 * Format Currency into Indian Rupees (INR)
 */
function formatRupees($amount) {
    return '₹' . number_format((float)$amount, 2, '.', ',');
}

/**
 * Secure file upload utility
 */
function uploadFile($fileField, $targetSubfolder) {
    if (!isset($_FILES[$fileField]) || $_FILES[$fileField]['error'] !== UPLOAD_ERR_OK) {
        return null;
    }
    
    $file = $_FILES[$fileField];
    $fileName = time() . '_' . basename($file['name']);
    $targetDir = __DIR__ . '/../uploads/' . $targetSubfolder . '/';
    
    // Ensure target folder exists
    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0777, true);
    }
    
    $targetPath = $targetDir . $fileName;
    $allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
    
    // Validate File Type
    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimeType = finfo_file($finfo, $file['tmp_name']);
    finfo_close($finfo);
    
    if (!in_array($mimeType, $allowedTypes)) {
        return false;
    }
    
    if (move_uploaded_file($file['tmp_name'], $targetPath)) {
        return 'uploads/' . $targetSubfolder . '/' . $fileName;
    }
    
    return false;
}

/**
 * Update Customer Ledger (financial transaction double-entry ledger)
 */
function updateCustomerLedger($retailerId, $type, $date, $refId, $refType, $debit, $credit, $remarks = '') {
    $db = getDBConnection();
    
    // Begin transaction for safety
    $db->beginTransaction();
    try {
        // 1. Fetch current outstanding
        $stmt = $db->prepare("SELECT outstanding_amount FROM retailers WHERE id = ? FOR UPDATE");
        $stmt->execute([$retailerId]);
        $retailer = $stmt->fetch();
        if (!$retailer) {
            throw new Exception("Retailer not found.");
        }
        
        $currentOutstanding = (float)$retailer['outstanding_amount'];
        // Debit increases outstanding, Credit decreases outstanding
        $newOutstanding = $currentOutstanding + (float)$debit - (float)$credit;
        
        // 2. Insert into customer ledger
        $stmt = $db->prepare("INSERT INTO customer_ledger 
            (retailer_id, transaction_type, transaction_date, reference_id, reference_type, debit_amount, credit_amount, balance, remarks) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$retailerId, $type, $date, $refId, $refType, $debit, $credit, $newOutstanding, $remarks]);
        
        // 3. Update retailer outstanding amount
        $stmt = $db->prepare("UPDATE retailers SET outstanding_amount = ? WHERE id = ?");
        $stmt->execute([$newOutstanding, $retailerId]);
        
        $db->commit();
        return true;
    } catch (Exception $e) {
        $db->rollBack();
        return false;
    }
}
?>
