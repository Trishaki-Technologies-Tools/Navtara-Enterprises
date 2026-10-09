<?php
// scratch/migrate_returns.php
require_once __DIR__ . '/../config/database.php';

$db = getDBConnection();

$sql = "
CREATE TABLE IF NOT EXISTS sales_returns (
  id INT(11) NOT NULL AUTO_INCREMENT,
  return_number VARCHAR(50) NOT NULL UNIQUE,
  credit_note_number VARCHAR(50) NOT NULL UNIQUE,
  invoice_id INT(11) NOT NULL,
  retailer_id INT(11) NOT NULL,
  staff_id INT(11) NOT NULL,
  return_date DATE NOT NULL,
  taxable_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  gst_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  return_to_inventory TINYINT(1) NOT NULL DEFAULT 1,
  reason VARCHAR(255) DEFAULT 'Damaged/Expired/Returned',
  remarks TEXT DEFAULT NULL,
  status ENUM('Approved','Pending','Cancelled') NOT NULL DEFAULT 'Approved',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_return_inv (invoice_id),
  KEY idx_return_ret (retailer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS sales_return_items (
  id INT(11) NOT NULL AUTO_INCREMENT,
  return_id INT(11) NOT NULL,
  invoice_item_id INT(11) DEFAULT NULL,
  sku_id INT(11) NOT NULL,
  quantity INT(11) NOT NULL DEFAULT 1,
  selling_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  gst_percentage DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  gst_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  reason VARCHAR(255) DEFAULT 'Damaged/Returned',
  PRIMARY KEY (id),
  KEY idx_ret_item_parent (return_id),
  KEY idx_ret_item_sku (sku_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
";

$db->exec($sql);

try {
    $db->exec("ALTER TABLE customer_ledger MODIFY COLUMN transaction_type VARCHAR(50) NOT NULL");
} catch(Exception $e) {}

echo "Migration completed successfully!\n";
