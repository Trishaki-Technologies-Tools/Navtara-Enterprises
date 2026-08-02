<?php
// api/auth.php
// AJAX Handler for Authentication (Login, Logout, and Session Checks)

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

$action = $_GET['action'] ?? '';

if ($action === 'logout') {
    $username = $_SESSION['username'] ?? 'Unknown';
    logActivity('Logout', "User {$username} logged out.");
    session_unset();
    session_destroy();
    sendJSON('success', 'Logged out successfully.');
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($action === 'login') {
        $username = cleanInput($_POST['username'] ?? '');
        $password = $_POST['password'] ?? '';
        
        if (empty($username) || empty($password)) {
            sendJSON('error', 'Please fill in all fields.');
        }
        
        $db = getDBConnection();
        try {
            // Find user and join role
            $stmt = $db->prepare("
                SELECT u.*, r.name as role_name 
                FROM users u 
                JOIN roles r ON u.role_id = r.id 
                WHERE u.username = ? AND u.status = 'Active'
            ");
            $stmt->execute([$username]);
            $user = $stmt->fetch();
            
            if ($user && password_verify($password, $user['password_hash'])) {
                // Populate session details
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['role_id'] = $user['role_id'];
                $_SESSION['username'] = $user['username'];
                $_SESSION['fullname'] = $user['fullname'];
                $_SESSION['role_name'] = $user['role_name'];
                $_SESSION['photo'] = $user['photo'] ?? 'assets/images/default-avatar.png';
                
                logActivity('Login', "User {$username} logged in successfully.");
                
                sendJSON('success', 'Login successful.', [
                    'user_id'   => $user['id'],
                    'fullname'  => $user['fullname'],
                    'role_name' => $user['role_name'],
                    'redirect'  => 'index.php'
                ]);
            } else {
                logActivity('Failed Login Attempt', "Username attempted: {$username}");
                sendJSON('error', 'Invalid username or password.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'status') {
        if (isset($_SESSION['user_id'])) {
            sendJSON('success', 'Session active.', [
                'user_id'   => $_SESSION['user_id'],
                'username'  => $_SESSION['username'],
                'fullname'  => $_SESSION['fullname'],
                'role_name' => $_SESSION['role_name'],
                'photo'     => $_SESSION['photo']
            ]);
        } else {
            sendJSON('error', 'Not logged in.', [], 401);
        }
    }
}

sendJSON('error', 'Invalid request API endpoint.', [], 400);
?>
