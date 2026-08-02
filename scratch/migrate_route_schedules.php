<?php
// scratch/migrate_route_schedules.php
// Run once: creates the route_schedules table

require_once __DIR__ . '/../config/database.php';
$db = getDBConnection();

$db->exec("
    CREATE TABLE IF NOT EXISTS `route_schedules` (
        `id`         INT AUTO_INCREMENT PRIMARY KEY,
        `route_id`   INT NOT NULL,
        `staff_id`   INT NULL,
        `day_of_week` ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
        `notes`      VARCHAR(255) NULL,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE KEY `uq_route_day_staff` (`route_id`, `day_of_week`, `staff_id`),
        FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE CASCADE,
        FOREIGN KEY (`staff_id`) REFERENCES `users`  (`id`) ON DELETE SET NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
");

echo '✅ route_schedules table created (or already exists).<br><strong>Done.</strong>';
?>
