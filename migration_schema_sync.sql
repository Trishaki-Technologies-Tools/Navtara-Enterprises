-- Database Schema Synchronization Migration
-- This migration syncs the column order of the hosted (production) database 
-- to match the exact structure of the localhost development database.
-- Note: The columns were already present in the hosted database, but were located at the end of the tables.

-- 1. Sync `brands` table
ALTER TABLE `brands` 
MODIFY COLUMN `supplier_id` int(11) DEFAULT NULL AFTER `id`;

-- 2. Sync `orders` table
ALTER TABLE `orders` 
MODIFY COLUMN `order_mode` varchar(20) DEFAULT 'By Route' AFTER `status`;

-- 3. Sync `purchases` table
ALTER TABLE `purchases` 
MODIFY COLUMN `discount_amount` decimal(12,2) DEFAULT 0.00 AFTER `subtotal`;

-- 4. Sync `purchase_items` table
ALTER TABLE `purchase_items` 
MODIFY COLUMN `discount_amount` decimal(10,2) DEFAULT 0.00 AFTER `purchase_price`;

-- 5. Sync `sales_staff_details` table
ALTER TABLE `sales_staff_details` 
MODIFY COLUMN `route_id` int(11) DEFAULT NULL AFTER `user_id`;

-- 6. Sync `expiry_records` table collation (Optional, to perfectly match)
ALTER TABLE `expiry_records` 
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
