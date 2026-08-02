<?php
require_once __DIR__ . '/../config/database.php';
$db = getDBConnection();
$stmt = $db->query("SHOW TABLES");
print_r($stmt->fetchAll(PDO::FETCH_COLUMN));
