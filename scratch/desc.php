<?php
require_once __DIR__ . '/../config/database.php';
$db = getDBConnection();
$stmt = $db->query("DESCRIBE suppliers");
print_r($stmt->fetchAll(PDO::FETCH_ASSOC));
