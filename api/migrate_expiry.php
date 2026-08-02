<?php
// api/migrate_expiry.php
// Migration script to initialize the expiry_records database table.

require_once __DIR__ . '/../config/database.php';

try {
    $db = getDBConnection();
    
    // Create the expiry_records table
    $sql = "
    CREATE TABLE IF NOT EXISTS `expiry_records` (
      `id` INT AUTO_INCREMENT PRIMARY KEY,
      `retailer_id` INT NOT NULL,
      `sku_id` INT NOT NULL,
      `quantity` INT NOT NULL,
      `rate` DECIMAL(10, 2) NOT NULL,
      `amount` DECIMAL(10, 2) NOT NULL,
      `collected_by` INT NOT NULL,
      `status` VARCHAR(50) DEFAULT 'Collected', -- 'Collected', 'Returned to Brand', 'Written Off'
      `remarks` TEXT DEFAULT NULL,
      `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (`retailer_id`) REFERENCES `retailers`(`id`) ON DELETE CASCADE,
      FOREIGN KEY (`sku_id`) REFERENCES `skus`(`id`) ON DELETE CASCADE,
      FOREIGN KEY (`collected_by`) REFERENCES `users`(`id`) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ";
    
    $db->exec($sql);
    echo "Table 'expiry_records' created or already exists.\n";
    
} catch (PDOException $e) {
    echo "Database error: " . $e->getMessage() . "\n";
}
