<?php
require_once __DIR__ . '/../config/database.php';
$db = getDBConnection();
$db->exec("ALTER TABLE purchase_items ADD COLUMN discount_amount DECIMAL(10,2) DEFAULT 0.00 AFTER purchase_price");
echo 'Added column discount_amount to purchase_items';
