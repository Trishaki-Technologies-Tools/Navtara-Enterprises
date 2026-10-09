<?php
// config/database.php
// Database Connection Configuration

// ==============================================================================
// 1. LOCAL DATABASE CONFIG (Comment out when deploying to Live)
// ==============================================================================
// define('DB_HOST', 'localhost');
// define('DB_USER', 'root');
// define('DB_PASS', '');
// define('DB_NAME', 'navtara_db');


// ==============================================================================
// 2. PRODUCTION DATABASE CONFIG (Uncomment when deploying to Live)
// ==============================================================================
define('DB_HOST', 'localhost');
define('DB_USER', 'u345018570_navatara');
define('DB_PASS', 'Navtara@db#01');
define('DB_NAME', 'u345018570_navatara');


// ==============================================================================
// 3. DATABASE CONNECTION
// ==============================================================================
function getDBConnection()
{
    static $pdo = null;
    if ($pdo === null) {
        try {
            $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4";
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ];
            $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
        } catch (PDOException $e) {
            die("Database Connection Failed: " . $e->getMessage());
        }
    }
    return $pdo;
}
?>