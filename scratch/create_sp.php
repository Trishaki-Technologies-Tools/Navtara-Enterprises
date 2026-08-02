<?php
require_once __DIR__ . '/../config/database.php';
$db = getDBConnection();
$sql = "
CREATE TABLE IF NOT EXISTS supplier_payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    payment_mode VARCHAR(50) NOT NULL,
    reference_number VARCHAR(100),
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
";
$db->exec($sql);
echo 'Table supplier_payments created.';
