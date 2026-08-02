<?php
// config/database.php
// Database Connection Configuration using PDO

define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'navtara_erp');

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
            // If database doesn't exist, connect to host first to run installation
            try {
                $dsnHost = "mysql:host=" . DB_HOST . ";charset=utf8mb4";
                $pdoHost = new PDO($dsnHost, DB_USER, DB_PASS, [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
                ]);
                return $pdoHost;
            } catch (PDOException $ex) {
                die("Critical Error: Database Connection Failed. " . $ex->getMessage());
            }
        }
    }
    return $pdo;
}
?>