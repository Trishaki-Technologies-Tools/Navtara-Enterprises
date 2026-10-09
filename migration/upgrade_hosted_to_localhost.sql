-- ==============================================================================
-- DATABASE MIGRATION SCRIPT: Hosted (Production) -> Localhost (Development)
-- Target: Apply to Hosted Database to bring it up to parity with Localhost
-- Generated for: Navtara Enterprises Business Management ERP
-- ==============================================================================

SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- ------------------------------------------------------------------------------
-- 1. MODIFY EXISTING TABLES (Column additions & type changes)
-- ------------------------------------------------------------------------------

-- (a) Update customer_ledger: Change transaction_type from ENUM to VARCHAR(50)
--     This accommodates new transaction types like Sales Returns, Credit Notes, etc.
ALTER TABLE `customer_ledger` 
  MODIFY COLUMN `transaction_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL;

-- (b) Update retailers: Add `is_special` flag
ALTER TABLE `retailers` 
  ADD COLUMN `is_special` tinyint(1) NOT NULL DEFAULT 0 AFTER `status`;

-- (c) Update skus: Add `allow_dynamic_price` flag
ALTER TABLE `skus` 
  ADD COLUMN `allow_dynamic_price` tinyint(1) NOT NULL DEFAULT 0 AFTER `status`;


-- ------------------------------------------------------------------------------
-- 2. CREATE NEW TABLES
-- ------------------------------------------------------------------------------

-- Table: `business_capital`
CREATE TABLE IF NOT EXISTS `business_capital` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `capital_type` enum('Own','Loan') NOT NULL DEFAULT 'Own',
  `amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `source_name` varchar(150) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Table: `sales_returns`
CREATE TABLE IF NOT EXISTS `sales_returns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `return_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credit_note_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `retailer_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `return_date` date NOT NULL,
  `taxable_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `gst_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `return_to_inventory` tinyint(1) NOT NULL DEFAULT 1,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Damaged/Expired/Returned',
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Approved','Pending','Cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Approved',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `return_number` (`return_number`),
  UNIQUE KEY `credit_note_number` (`credit_note_number`),
  KEY `idx_return_inv` (`invoice_id`),
  KEY `idx_return_ret` (`retailer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Table: `sales_return_items`
CREATE TABLE IF NOT EXISTS `sales_return_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `return_id` int(11) NOT NULL,
  `invoice_item_id` int(11) DEFAULT NULL,
  `sku_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `selling_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `gst_percentage` decimal(5,2) NOT NULL DEFAULT 0.00,
  `gst_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Damaged/Returned',
  PRIMARY KEY (`id`),
  KEY `idx_ret_item_parent` (`return_id`),
  KEY `idx_ret_item_sku` (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
