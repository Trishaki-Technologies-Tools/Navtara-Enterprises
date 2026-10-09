-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 08, 2026 at 07:15 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `navtara_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `ip_address`, `created_at`) VALUES
(56, 1, 'Logout', 'User 6361742356 logged out.', '2405:201:d00a:3842:81e6:635a:71b7:d81e', '2026-07-12 09:46:00'),
(57, NULL, 'Failed Login Attempt', 'Username attempted: 6361742356', '2405:201:d00a:3842:81e6:635a:71b7:d81e', '2026-07-12 09:46:07'),
(58, 1, 'Login', 'User owner logged in successfully.', '2405:201:d00a:3842:81e6:635a:71b7:d81e', '2026-07-12 09:46:18'),
(59, 1, 'Logout', 'User owner logged out.', '2405:201:d00a:3842:81e6:635a:71b7:d81e', '2026-07-12 09:46:25'),
(60, NULL, 'Failed Login Attempt', 'Username attempted: 6361742356', '2409:40f2:4e:15a0:8000::', '2026-07-12 09:46:52'),
(61, NULL, 'Failed Login Attempt', 'Username attempted: 6361742356', '2409:40f2:4e:15a0:8000::', '2026-07-12 09:47:04'),
(62, 1, 'Login', 'User owner logged in successfully.', '2409:40f2:4e:15a0:8000::', '2026-07-12 09:47:24'),
(63, NULL, 'Failed Login Attempt', 'Username attempted: 6361742356', '152.57.99.80', '2026-07-12 11:44:40'),
(64, NULL, 'Failed Login Attempt', 'Username attempted: 6361742356', '152.57.99.80', '2026-07-12 11:45:01'),
(65, 1, 'Login', 'User owner logged in successfully.', '152.57.99.80', '2026-07-12 11:45:07'),
(66, 1, 'Create Brand', 'Created brand: SHREE KRISHNA', '152.57.99.80', '2026-07-12 11:52:00'),
(67, 1, 'Update Brand', 'Updated brand ID: 5 to Name: SHREE KRISHNA FOODS PVT LTD', '152.57.99.80', '2026-07-12 11:52:26'),
(68, 1, 'Create Brand', 'Created brand: VINAYAKA SALES AND PERFUMARY', '152.57.99.80', '2026-07-12 11:54:09'),
(69, 1, 'Logout', 'User owner logged out.', '152.57.99.80', '2026-07-12 11:59:16'),
(70, NULL, 'Failed Login Attempt', 'Username attempted: NAVATARA_06', '152.57.99.80', '2026-07-12 11:59:39'),
(71, NULL, 'Failed Login Attempt', 'Username attempted: NAVATARA_06', '152.57.99.80', '2026-07-12 11:59:53'),
(72, NULL, 'Failed Login Attempt', 'Username attempted: NAVATARA_06', '152.57.99.80', '2026-07-12 12:00:24'),
(73, 1, 'Login', 'User owner logged in successfully.', '152.57.99.80', '2026-07-12 12:00:56'),
(74, 1, 'Logout', 'User owner logged out.', '152.57.99.80', '2026-07-12 12:03:00'),
(75, NULL, 'Failed Login Attempt', 'Username attempted: NAVATARA_06', '152.57.99.80', '2026-07-12 12:03:17'),
(76, 1, 'Login', 'User owner logged in successfully.', '152.57.99.80', '2026-07-12 12:03:27'),
(77, 1, 'Login', 'User owner logged in successfully.', '152.57.99.80', '2026-07-12 12:04:38'),
(78, 1, 'Login', 'User owner logged in successfully.', '152.57.109.108', '2026-07-13 01:22:24'),
(79, 1, 'Update Brand', 'Updated brand ID: 5 to Name: SHREE KRISHNA FOODS PVT LTD', '152.57.109.108', '2026-07-13 01:23:54'),
(80, 1, 'Export Report', 'Exported Retailer Outstandings CSV Report', '152.57.109.108', '2026-07-13 01:25:31'),
(81, 1, 'Login', 'User owner logged in successfully.', '152.57.109.108', '2026-07-13 01:27:27'),
(82, 1, 'Update Settings', 'Updated company profile details.', '152.57.109.108', '2026-07-13 01:31:22'),
(83, 1, 'Logout', 'User owner logged out.', '152.57.109.108', '2026-07-13 01:31:52'),
(84, NULL, 'Failed Login Attempt', 'Username attempted: NAVATARA', '152.57.109.108', '2026-07-13 01:32:14'),
(85, NULL, 'Failed Login Attempt', 'Username attempted: NAVATARA', '152.57.109.108', '2026-07-13 01:32:22'),
(86, 1, 'Login', 'User owner logged in successfully.', '152.57.109.108', '2026-07-13 01:32:31'),
(87, 1, 'Update Settings', 'Updated company profile details.', '152.57.109.108', '2026-07-13 01:34:28'),
(88, 1, 'Login', 'User owner logged in successfully.', '152.57.109.108', '2026-07-13 01:34:50'),
(89, 1, 'Create Product', 'Created product: COW GHEE 200 ML JAR under Brand ID: 5', '152.57.109.108', '2026-07-13 01:39:43'),
(90, 1, 'Update Product', 'Updated product ID: 7 to name: COW GHEE', '152.57.109.108', '2026-07-13 01:40:14'),
(91, 1, 'Create Product', 'Created product: APPALAM under Brand ID: 5', '152.57.109.108', '2026-07-13 01:40:55'),
(92, 1, 'Create SKU', 'Created SKU: 200 ML JAR (Code: COW GHEE 200ML JAR) with opening stock 60', '152.57.109.108', '2026-07-13 01:44:11'),
(93, 1, 'Create SKU', 'Created SKU: 100ML JAR (Code: COW GHEE 100ML JAR) with opening stock 80', '152.57.109.108', '2026-07-13 01:46:45'),
(94, 1, 'Create SKU', 'Created SKU: 50ML JAR (Code: COW GHEE 50ML JAR) with opening stock 80', '152.57.109.108', '2026-07-13 01:49:25'),
(95, NULL, 'Failed Login Attempt', 'Username attempted: 6361742356', '2409:40f2:30b:4dfa:8000::', '2026-07-13 02:56:11'),
(96, 1, 'Login', 'User owner logged in successfully.', '2409:40f2:30b:4dfa:8000::', '2026-07-13 02:56:24'),
(97, NULL, 'Failed Login Attempt', 'Username attempted: owner', '152.57.118.137', '2026-07-13 03:18:20'),
(98, 1, 'Login', 'User owner logged in successfully.', '152.57.118.137', '2026-07-13 03:18:24'),
(99, 1, 'Login', 'User owner logged in successfully.', '152.57.118.137', '2026-07-13 03:30:55'),
(100, 1, 'Login', 'User owner logged in successfully.', '152.57.143.86', '2026-07-13 07:34:53'),
(101, 1, 'Create SKU', 'Created SKU: 10 RS SHEET (Code: 10 RS SHEET COW GHEE) with opening stock 200', '157.50.206.32', '2026-07-13 07:48:08'),
(102, 1, 'Create SKU', 'Created SKU: 20 RS SHEET (Code: 20 RS SHEET COW GHEE) with opening stock 100', '157.50.206.32', '2026-07-13 07:49:44'),
(103, 1, 'Create SKU', 'Created SKU: APPALAM (Code: APPALAM  PAPER PACK) with opening stock 240', '157.50.206.32', '2026-07-13 07:55:48'),
(104, 1, 'Create Staff Account', 'Created sales staff member SHREYANSH (Username: Shreyansh_)', '152.57.124.63', '2026-07-13 08:02:13'),
(105, 1, 'Logout', 'User owner logged out.', '152.57.124.63', '2026-07-13 08:02:57'),
(106, 15, 'Login', 'User Shreyansh_ logged in successfully.', '152.57.124.63', '2026-07-13 08:03:16'),
(107, 15, 'Create Retailer', 'Created retailer VARUN GENERAL STORE (Owner: ), assigned to Staff ID: 15', '152.57.124.63', '2026-07-13 08:06:34'),
(108, 15, 'Update Retailer', 'Updated retailer profile: VARUN GENERAL STORE (ID: 6)', '152.57.124.63', '2026-07-13 08:08:38'),
(109, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:100e:4ae0:8000::', '2026-07-13 09:00:35'),
(110, 1, 'Login', 'User owner logged in successfully.', '2401:4900:16f0:8d65:2:2:4bd2:5062', '2026-07-13 09:48:07'),
(111, 1, 'Create Expense', 'Recorded expense: Salaries / Commissions of ₹500.00 + GST ₹0.00 paid to  via Bank Transfer', '2401:4900:16f0:8d65:2:2:4bd2:5062', '2026-07-13 09:49:03'),
(112, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:100e:4ae0:8000::', '2026-07-13 09:49:26'),
(113, 1, 'Login', 'User owner logged in successfully.', '2409:40f2:100e:4ae0:8000::', '2026-07-13 09:49:35'),
(114, 1, 'Logout', 'User owner logged out.', '2401:4900:16f0:8d65:2:2:4bd2:5062', '2026-07-13 09:51:35'),
(115, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2401:4900:16f0:8d65:2:2:4bd2:5062', '2026-07-13 09:51:44'),
(116, 1, 'Logout', 'User owner logged out.', '2409:40f2:100e:4ae0:8000::', '2026-07-13 09:53:26'),
(117, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:100e:4ae0:8000::', '2026-07-13 09:53:37'),
(118, 1, 'Login', 'User owner logged in successfully.', '152.57.31.175', '2026-07-13 09:58:14'),
(119, 1, 'Delete Expense', 'Deleted expense ID: 2', '152.57.31.175', '2026-07-13 09:58:36'),
(120, 1, 'Delete Expense', 'Deleted expense ID: 2', '152.57.31.175', '2026-07-13 09:58:47'),
(121, 1, 'Login', 'User owner logged in successfully.', '152.57.31.175', '2026-07-13 10:02:23'),
(122, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-07-01 To: 2026-07-13)', '152.57.31.175', '2026-07-13 10:03:16'),
(123, 1, 'Logout', 'User owner logged out.', '152.57.31.175', '2026-07-13 10:04:44'),
(124, 15, 'Login', 'User Shreyansh_ logged in successfully.', '152.57.31.175', '2026-07-13 10:04:56'),
(125, 1, 'Login', 'User owner logged in successfully.', '152.57.31.175', '2026-07-13 10:11:01'),
(126, 1, 'Login', 'User owner logged in successfully.', '152.57.31.175', '2026-07-13 10:12:34'),
(127, 1, 'Login', 'User owner logged in successfully.', '152.57.31.175', '2026-07-13 10:19:24'),
(128, 1, 'Logout', 'User owner logged out.', '152.57.31.175', '2026-07-13 10:22:02'),
(129, 15, 'Login', 'User Shreyansh_ logged in successfully.', '152.57.31.175', '2026-07-13 10:22:55'),
(130, 1, 'Login', 'User owner logged in successfully.', '152.57.31.175', '2026-07-13 10:27:45'),
(131, 1, 'Delete Retailer', 'Deleted retailer ID: 6', '152.57.31.175', '2026-07-13 10:27:57'),
(132, 1, 'Login', 'User owner logged in successfully.', '152.57.31.175', '2026-07-13 10:34:14'),
(133, 1, 'Logout', 'User owner logged out.', '152.57.31.175', '2026-07-13 10:35:58'),
(134, 15, 'Login', 'User Shreyansh_ logged in successfully.', '152.57.31.175', '2026-07-13 10:36:29'),
(135, 1, 'Login', 'User owner logged in successfully.', '152.57.31.175', '2026-07-13 10:38:40'),
(136, 1, 'Login', 'User owner logged in successfully.', '152.57.26.3', '2026-07-13 11:29:47'),
(137, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-07-01 To: 2026-07-13)', '152.57.26.3', '2026-07-13 11:37:44'),
(138, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:23:1ba4:8000::', '2026-07-13 14:12:57'),
(139, 1, 'Login', 'User owner logged in successfully.', '152.57.120.250', '2026-07-13 14:40:34'),
(140, 1, 'Update Settings', 'Updated company profile details.', '152.57.120.250', '2026-07-13 14:43:59'),
(141, 1, 'Update Profile', 'Updated owner profile details.', '152.57.120.250', '2026-07-13 14:44:27'),
(142, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.120.250', '2026-07-13 14:44:52'),
(143, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.120.250', '2026-07-13 14:44:52'),
(144, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.120.250', '2026-07-13 14:44:54'),
(145, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.120.250', '2026-07-13 14:44:54'),
(146, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.120.250', '2026-07-13 14:44:54'),
(147, 1, 'Create Retailer', 'Created retailer SANDEEP KURANGI (Owner: ), assigned to Staff ID: 15', '152.57.120.250', '2026-07-13 14:47:25'),
(148, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:23:1ba4:8000::', '2026-07-13 14:47:58'),
(149, 15, 'Create Order', 'Staff created Order ID: 3 for Retailer ID: 7. Grand Total: 1866.5745', '2409:40f2:23:1ba4:8000::', '2026-07-13 14:49:21'),
(150, 1, 'Update Order Status', 'Owner updated Order ID: 3 to Status: Approved', '152.57.120.250', '2026-07-13 14:49:38'),
(151, 1, 'Generate Invoice', 'Invoiced Order ID: 3 -> Invoice No: NE/2026-27/0001. Grand Total: 1866.57', '152.57.120.250', '2026-07-13 14:49:56'),
(152, 1, 'Export Report', 'Exported Sales CSV Report (From: 2026-07-01 To: 2026-07-13)', '152.57.120.250', '2026-07-13 15:05:22'),
(153, 1, 'Export Report', 'Exported GST Expenses (Inward) CSV (From: 2026-07-01 To: 2026-07-13)', '152.57.120.250', '2026-07-13 15:12:55'),
(154, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.120.250', '2026-07-13 15:14:47'),
(155, 1, 'Update Profile', 'Updated owner profile details.', '152.57.120.250', '2026-07-13 15:15:14'),
(156, 1, 'Update Settings', 'Updated company profile details.', '152.57.120.250', '2026-07-13 15:15:20'),
(157, 1, 'Update Profile', 'Updated owner profile details.', '152.57.120.250', '2026-07-13 15:15:34'),
(158, 1, 'Update Settings', 'Updated company profile details.', '152.57.120.250', '2026-07-13 15:15:39'),
(159, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.120.250', '2026-07-13 15:20:17'),
(160, 1, 'Logout', 'User NAVATARA_06 logged out.', '152.57.120.250', '2026-07-13 15:22:23'),
(161, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.15.220', '2026-07-15 02:01:33'),
(162, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:1036:ad40:8000::', '2026-07-15 02:03:50'),
(163, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.165.46', '2026-07-15 10:40:00'),
(164, 1, 'Create Retailer', 'Created retailer SHRI NEELAMBARI KIRANA &amp; GENERAL STORE (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 10:43:36'),
(165, 1, 'Create Retailer', 'Created retailer GURUPRASAD KIRANA STORE (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 10:45:20'),
(166, 1, 'Create Retailer', 'Created retailer PATIL GENERAL STORES (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 10:46:50'),
(167, 1, 'Create Retailer', 'Created retailer ANJANEYA GENERAL STORES (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 10:48:29'),
(168, 1, 'Create Retailer', 'Created retailer DURGA GENERAL STORES (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 10:50:52'),
(169, 1, 'Create Retailer', 'Created retailer HARSH ENTERPRISE (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 10:53:31'),
(170, 1, 'Create Retailer', 'Created retailer SATVIK GENERAL STORES (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 10:54:52'),
(171, 1, 'Create Retailer', 'Created retailer MAHAKALI GENRAL STORES (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 10:56:03'),
(172, 1, 'Create Retailer', 'Created retailer SIDDHAROODHA KIRANA STORE (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 10:58:15'),
(173, 1, 'Create Retailer', 'Created retailer MAHALAXMI GENERAL STORES (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 11:00:16'),
(174, 1, 'Create Retailer', 'Created retailer VEERA BHADRESHWAR ENTERPRISE (Owner: ), assigned to Staff ID: 15', '157.50.165.46', '2026-07-15 11:02:31'),
(175, 1, 'Create Product', 'Created product: BLACK FANTASY ZIPPER under Brand ID: 6', '157.50.165.46', '2026-07-15 11:08:21'),
(176, 1, 'Update SKU', 'Updated SKU ID: 15 (10 RS SHEET)', '157.50.165.46', '2026-07-15 11:09:26'),
(177, 1, 'Update SKU', 'Updated SKU ID: 15 (SHRI KRISHNA 10 RS SHEET)', '157.50.165.46', '2026-07-15 11:10:43'),
(178, 1, 'Update Product', 'Updated product ID: 9 to name: ZIPPER PACKS', '157.50.165.46', '2026-07-15 11:11:31'),
(179, 1, 'Create Product', 'Created product: ECONOMY POUCHES under Brand ID: 6', '157.50.165.46', '2026-07-15 11:12:08'),
(180, 1, 'Create Product', 'Created product: REGULAR POUCH SERIES under Brand ID: 6', '157.50.165.46', '2026-07-15 11:13:05'),
(181, 1, 'Create SKU', 'Created SKU: VINAYAKA BLACK FANTASY ZIPPER PACKS (Code: ZIPPER 110G) with opening stock 240', '157.50.165.46', '2026-07-15 11:18:26'),
(182, 1, 'Create SKU', 'Created SKU: VINAYAKA WILD PURPLE ZIPPER PACKS (Code: ZIPPER 2) with opening stock 240', '157.50.165.46', '2026-07-15 11:21:38'),
(183, 1, 'Update SKU', 'Updated SKU ID: 18 (VINAYAKA BLACK FANTASY ZIPPER PACKS)', '157.50.165.46', '2026-07-15 11:21:57'),
(184, 1, 'Create SKU', 'Created SKU: VINAYAKA KASTURI ZIPPER PACK (Code: ZIPPER 3) with opening stock 240', '157.50.165.46', '2026-07-15 11:23:08'),
(185, 1, 'Create SKU', 'Created SKU: VINAYAKA DIAMOND ZIPPER PACK (Code: ZIPPER 4) with opening stock 240', '157.50.165.46', '2026-07-15 11:24:32'),
(186, 1, 'Create SKU', 'Created SKU: VINAYAKA HEENA ZIPPER PACKS (Code: ZIPPER 5) with opening stock 240', '157.50.165.46', '2026-07-15 11:26:23'),
(187, 1, 'Create SKU', 'Created SKU: VINAYAKA DREAMS ZIPPER PACKS (Code: ZIPPER 6) with opening stock 240', '157.50.165.46', '2026-07-15 11:27:43'),
(188, 1, 'Create SKU', 'Created SKU: VINAYAKA BOLENATH ZIPPER PACKS (Code: ZIPPER 7) with opening stock 240', '157.50.165.46', '2026-07-15 11:28:48'),
(189, 1, 'Create SKU', 'Created SKU: VINAYAKA REGULAR POUCH MIX (Code: ZIPPER 8) with opening stock 960', '157.50.165.46', '2026-07-15 11:34:30'),
(190, 1, 'Create SKU', 'Created SKU: VINAYAKA GOOD MORNING ECONOMY (Code: ZIPPER 9) with opening stock 300', '157.50.165.46', '2026-07-15 11:37:22'),
(191, 1, 'Create SKU', 'Created SKU: VINAYAKA BLACK FANTASY 60G (Code: ECONOMY 1) with opening stock 180', '157.50.165.46', '2026-07-15 11:40:58'),
(192, 1, 'Create SKU', 'Created SKU: VINAYAKA WILD PURPLE 60G (Code: ECONOMY 2) with opening stock 180', '157.50.165.46', '2026-07-15 11:43:00'),
(193, 1, 'Update SKU', 'Updated SKU ID: 31 (VINAYAKA BLACK FANTASY 60G)', '157.50.165.46', '2026-07-15 11:44:46'),
(194, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:2132:b186:8000::', '2026-07-15 11:47:12'),
(195, 15, 'Create Order', 'Staff created Order ID: 4 for Retailer ID: 8. Grand Total: 724.5', '2409:40f2:2132:b186:8000::', '2026-07-15 11:50:54'),
(196, 15, 'Create Order', 'Staff created Order ID: 5 for Retailer ID: 9. Grand Total: 346.5', '2409:40f2:2132:b186:8000::', '2026-07-15 11:52:05'),
(197, 15, 'Create Order', 'Staff created Order ID: 6 for Retailer ID: 10. Grand Total: 504', '2409:40f2:2132:b186:8000::', '2026-07-15 11:54:28'),
(198, 15, 'Create Order', 'Staff created Order ID: 7 for Retailer ID: 11. Grand Total: 189', '2409:40f2:2132:b186:8000::', '2026-07-15 11:55:11'),
(199, 15, 'Create Order', 'Staff created Order ID: 8 for Retailer ID: 12. Grand Total: 441', '2409:40f2:2132:b186:8000::', '2026-07-15 11:56:38'),
(200, 15, 'Create Order', 'Staff created Order ID: 9 for Retailer ID: 13. Grand Total: 1197', '2409:40f2:2132:b186:8000::', '2026-07-15 11:58:47'),
(201, 15, 'Create Order', 'Staff created Order ID: 10 for Retailer ID: 14. Grand Total: 94.5', '2409:40f2:2132:b186:8000::', '2026-07-15 12:00:00'),
(202, 15, 'Create Order', 'Staff created Order ID: 11 for Retailer ID: 15. Grand Total: 189', '2409:40f2:2132:b186:8000::', '2026-07-15 12:00:48'),
(203, 15, 'Create Order', 'Staff created Order ID: 12 for Retailer ID: 16. Grand Total: 189', '2409:40f2:2132:b186:8000::', '2026-07-15 12:01:34'),
(204, 15, 'Create Order', 'Staff created Order ID: 13 for Retailer ID: 17. Grand Total: 1197', '2409:40f2:2132:b186:8000::', '2026-07-15 12:03:33'),
(205, 15, 'Create Order', 'Staff created Order ID: 14 for Retailer ID: 18. Grand Total: 210.042', '2409:40f2:2132:b186:8000::', '2026-07-15 12:04:21'),
(206, 1, 'Update Retailer', 'Updated retailer profile: SHRI NEELAMBARI KIRANA AND GENERAL STORE (ID: 8)', '157.50.165.46', '2026-07-15 12:09:10'),
(207, 1, 'Update Order Status', 'Owner updated Order ID: 4 to Status: Approved', '157.50.165.46', '2026-07-15 12:09:37'),
(208, 1, 'Update Order Status', 'Owner updated Order ID: 5 to Status: Approved', '157.50.165.46', '2026-07-15 12:09:51'),
(209, 1, 'Update Order Status', 'Owner updated Order ID: 6 to Status: Approved', '157.50.165.46', '2026-07-15 12:10:03'),
(210, 1, 'Update Order Status', 'Owner updated Order ID: 7 to Status: Approved', '157.50.165.46', '2026-07-15 12:10:17'),
(211, 1, 'Update Order Status', 'Owner updated Order ID: 8 to Status: Approved', '157.50.165.46', '2026-07-15 12:10:32'),
(212, 1, 'Update Order Status', 'Owner updated Order ID: 9 to Status: Approved', '157.50.165.46', '2026-07-15 12:10:55'),
(213, 1, 'Update Order Status', 'Owner updated Order ID: 10 to Status: Approved', '157.50.165.46', '2026-07-15 12:11:06'),
(214, 1, 'Update Order Status', 'Owner updated Order ID: 11 to Status: Approved', '157.50.165.46', '2026-07-15 12:11:18'),
(215, 1, 'Update Order Status', 'Owner updated Order ID: 12 to Status: Approved', '157.50.165.46', '2026-07-15 12:11:28'),
(216, 1, 'Update Order Status', 'Owner updated Order ID: 13 to Status: Approved', '157.50.165.46', '2026-07-15 12:11:48'),
(217, 1, 'Update Order Status', 'Owner updated Order ID: 14 to Status: Approved', '157.50.165.46', '2026-07-15 12:12:02'),
(218, 1, 'Update Retailer', 'Updated retailer profile: ANJANEYA GENERAL STORES (ID: 11)', '157.50.165.46', '2026-07-15 12:14:30'),
(219, 1, 'Update Retailer', 'Updated retailer profile: DURGA GENERAL STORES (ID: 12)', '157.50.165.46', '2026-07-15 12:14:48'),
(220, 1, 'Update Retailer', 'Updated retailer profile: GURUPRASAD KIRANA STORE (ID: 9)', '157.50.165.46', '2026-07-15 12:15:01'),
(221, 1, 'Update Retailer', 'Updated retailer profile: MAHAKALI GENRAL STORES (ID: 15)', '157.50.165.46', '2026-07-15 12:15:18'),
(222, 1, 'Update Retailer', 'Updated retailer profile: PATIL GENERAL STORES (ID: 10)', '157.50.165.46', '2026-07-15 12:15:35'),
(223, 1, 'Update Retailer', 'Updated retailer profile: SATVIK GENERAL STORES (ID: 14)', '157.50.165.46', '2026-07-15 12:15:46'),
(224, 1, 'Update Retailer', 'Updated retailer profile: SHRI NEELAMBARI KIRANA AND GENERAL STORE (ID: 8)', '157.50.165.46', '2026-07-15 12:15:57'),
(225, 1, 'Update Retailer', 'Updated retailer profile: SHRI NEELAMBARI KIRANA AND GENERAL STORE (ID: 8)', '157.50.165.46', '2026-07-15 12:16:06'),
(226, 1, 'Update Retailer', 'Updated retailer profile: SIDDHAROODHA KIRANA STORE (ID: 16)', '157.50.165.46', '2026-07-15 12:16:19'),
(227, 1, 'Update Retailer', 'Updated retailer profile: VEERA BHADRESHWAR ENTERPRISE (ID: 18)', '157.50.165.46', '2026-07-15 12:16:34'),
(228, 1, 'Generate Invoice', 'Invoiced Order ID: 10 -> Invoice No: NE/2026-27/0002. Grand Total: 94.5', '157.50.165.46', '2026-07-15 12:16:55'),
(229, 1, 'Generate Invoice', 'Invoiced Order ID: 11 -> Invoice No: NE/2026-27/0003. Grand Total: 189', '157.50.165.46', '2026-07-15 12:19:43'),
(230, 1, 'Generate Invoice', 'Invoiced Order ID: 12 -> Invoice No: NE/2026-27/0004. Grand Total: 189', '157.50.165.46', '2026-07-15 12:25:13'),
(231, 1, 'Update Retailer', 'Updated retailer profile: MAHALAXMI GENERAL STORES (ID: 17)', '157.50.165.46', '2026-07-15 12:26:09'),
(232, 1, 'Generate Invoice', 'Invoiced Order ID: 13 -> Invoice No: NE/2026-27/0005. Grand Total: 1197', '157.50.165.46', '2026-07-15 12:26:20'),
(233, 1, 'Generate Invoice', 'Invoiced Order ID: 14 -> Invoice No: NE/2026-27/0006. Grand Total: 210.04', '157.50.165.46', '2026-07-15 12:26:53'),
(234, 1, 'Generate Invoice', 'Invoiced Order ID: 4 -> Invoice No: NE/2026-27/0007. Grand Total: 724.5', '157.50.165.46', '2026-07-15 12:27:14'),
(235, 1, 'Generate Invoice', 'Invoiced Order ID: 5 -> Invoice No: NE/2026-27/0008. Grand Total: 346.5', '157.50.165.46', '2026-07-15 12:27:31'),
(236, 1, 'Generate Invoice', 'Invoiced Order ID: 6 -> Invoice No: NE/2026-27/0009. Grand Total: 504', '157.50.165.46', '2026-07-15 12:28:17'),
(237, 1, 'Generate Invoice', 'Invoiced Order ID: 7 -> Invoice No: NE/2026-27/0010. Grand Total: 189', '157.50.165.46', '2026-07-15 12:28:42'),
(238, 1, 'Generate Invoice', 'Invoiced Order ID: 8 -> Invoice No: NE/2026-27/0011. Grand Total: 441', '157.50.165.46', '2026-07-15 12:28:58'),
(239, 1, 'Update Retailer', 'Updated retailer profile: HARSH ENTERPRISE (ID: 13)', '157.50.165.46', '2026-07-15 12:29:38'),
(240, 1, 'Generate Invoice', 'Invoiced Order ID: 9 -> Invoice No: NE/2026-27/0012. Grand Total: 1197', '157.50.165.46', '2026-07-15 12:29:51'),
(241, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:358:dc1a:8000::', '2026-07-15 18:06:54'),
(242, 15, 'Collect Payment', 'Recorded payment of ₹210.00 from Retailer ID: 18 using Method: Cash', '2409:40f2:358:dc1a:8000::', '2026-07-15 18:07:49'),
(243, 15, 'Collect Payment', 'Recorded payment of ₹0.04 from Retailer ID: 18 using Method: Cash', '2409:40f2:358:dc1a:8000::', '2026-07-15 18:08:49'),
(244, 15, 'Collect Payment', 'Recorded payment of ₹185.00 from Retailer ID: 11 using Method: Cash', '2409:40f2:358:dc1a:8000::', '2026-07-15 18:09:39'),
(245, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:358:dc1a:8000::', '2026-07-16 03:06:55'),
(246, 1, 'Create Expense', 'Recorded expense: Office / Stationery of ₹11,694.92 + GST ₹2,105.09 paid to CLICKTRONICS - GSTIN- 29AOQPP5207G1ZK via Cash', '2409:40f2:358:dc1a:8000::', '2026-07-16 03:12:52'),
(247, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.135.110', '2026-07-16 03:20:20'),
(248, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:121:e46a:8000::', '2026-07-16 05:28:26'),
(249, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:121:e46a:8000::', '2026-07-16 05:28:42'),
(250, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:121:e46a:8000::', '2026-07-16 05:29:07'),
(251, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:121:e46a:8000::', '2026-07-16 05:29:34'),
(252, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:121:e46a:8000::', '2026-07-16 05:29:48'),
(253, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:1047:c5f0:8000::', '2026-07-16 05:55:40'),
(254, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1047:c5f0:8000::', '2026-07-16 05:55:54'),
(255, 1, 'Create Retailer', 'Created retailer SHRI  GENERAL STORES (Owner: ), assigned to Staff ID: 15', '2409:40f2:1047:c5f0:8000::', '2026-07-16 05:59:14'),
(256, 1, 'Create Retailer', 'Created retailer SIDDHI GENERAL STORES (Owner: ), assigned to Staff ID: 15', '2409:40f2:1047:c5f0:8000::', '2026-07-16 06:03:17'),
(257, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.24.189', '2026-07-16 09:08:04'),
(258, 1, 'Create Retailer', 'Created retailer KIRAN PATIL STORES (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:11:47'),
(259, 1, 'Create Retailer', 'Created retailer BELAGAONKAR  GENERAL STORES (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:14:26'),
(260, 1, 'Create Retailer', 'Created retailer ANAND MASALA STORE (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:15:37'),
(261, 1, 'Create Retailer', 'Created retailer P R PALAKAR (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:16:58'),
(262, 1, 'Create Retailer', 'Created retailer PATTANSHETTY GENERAL STORES (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:18:35'),
(263, 1, 'Create Retailer', 'Created retailer D A ATTARA (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:21:17'),
(264, 1, 'Create Retailer', 'Created retailer PANKAJ COCONUT STORE (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:24:45'),
(265, 1, 'Create Retailer', 'Created retailer M. ANGOLKAR AND  SONS (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:26:55'),
(266, 1, 'Create Retailer', 'Created retailer RAVALNATH TRADERS (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:28:14'),
(267, 1, 'Create Retailer', 'Created retailer ARVIND ENTERPRISE (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:29:40'),
(268, 1, 'Create Retailer', 'Created retailer ARVIND ENTERPRISE (Owner: ), assigned to Staff ID: 15', '152.57.24.189', '2026-07-16 09:29:41'),
(269, 1, 'Logout', 'User NAVATARA_06 logged out.', '152.57.24.189', '2026-07-16 09:30:36'),
(270, 15, 'Login', 'User Shreyansh_ logged in successfully.', '152.57.24.189', '2026-07-16 09:30:50'),
(271, 15, 'Create Order', 'Staff created Order ID: 15 for Retailer ID: 19. Grand Total: 504', '152.57.24.189', '2026-07-16 09:33:49'),
(272, NULL, 'Logout', 'User Unknown logged out.', '2409:40f2:1047:c5f0:8000::', '2026-07-16 09:36:17'),
(273, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1047:c5f0:8000::', '2026-07-16 09:36:32'),
(274, 1, 'Create SKU', 'Created SKU: VINAYAKA BRUTS ZIPPER PACKS (Code: ZIPPER -11) with opening stock 240', '2409:40f2:1047:c5f0:8000::', '2026-07-16 09:38:37'),
(275, 15, 'Create Order', 'Staff created Order ID: 16 for Retailer ID: 20. Grand Total: 1512', '152.57.24.189', '2026-07-16 09:42:19'),
(276, 15, 'Create Order', 'Staff created Order ID: 17 for Retailer ID: 21. Grand Total: 1008', '152.57.24.189', '2026-07-16 09:43:23'),
(277, 15, 'Create Order', 'Staff created Order ID: 18 for Retailer ID: 22. Grand Total: 693', '152.57.24.189', '2026-07-16 09:44:45'),
(278, 15, 'Create Order', 'Staff created Order ID: 19 for Retailer ID: 23. Grand Total: 1008', '152.57.24.189', '2026-07-16 09:46:37'),
(279, 1, 'Delete Retailer', 'Deleted retailer ID: 30', '2409:40f2:1047:c5f0:8000::', '2026-07-16 09:47:41'),
(280, 15, 'Create Order', 'Staff created Order ID: 20 for Retailer ID: 24. Grand Total: 252', '152.57.24.189', '2026-07-16 09:48:50'),
(281, 15, 'Create Order', 'Staff created Order ID: 21 for Retailer ID: 25. Grand Total: 1008', '152.57.24.189', '2026-07-16 09:55:23'),
(282, 15, 'Create Order', 'Staff created Order ID: 22 for Retailer ID: 26. Grand Total: 1008', '152.57.24.189', '2026-07-16 09:56:01'),
(283, 15, 'Create Order', 'Staff created Order ID: 23 for Retailer ID: 27. Grand Total: 1008', '152.57.24.189', '2026-07-16 09:57:47'),
(284, 15, 'Create Order', 'Staff created Order ID: 24 for Retailer ID: 28. Grand Total: 1008', '152.57.24.189', '2026-07-16 10:00:25'),
(285, 15, 'Create Order', 'Staff created Order ID: 25 for Retailer ID: 29. Grand Total: 1008', '152.57.24.189', '2026-07-16 10:01:43'),
(286, 15, 'Create Order', 'Staff created Order ID: 26 for Retailer ID: 31. Grand Total: 682.542', '152.57.24.189', '2026-07-16 10:03:45'),
(287, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.20.90', '2026-07-16 10:44:53'),
(288, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.20.90', '2026-07-16 10:44:53'),
(289, 1, 'Update Order Status', 'Owner updated Order ID: 15 to Status: Approved', '152.57.20.90', '2026-07-16 11:14:11'),
(290, 1, 'Update Order Status', 'Owner updated Order ID: 16 to Status: Approved', '152.57.20.90', '2026-07-16 11:14:18'),
(291, 1, 'Update Order Status', 'Owner updated Order ID: 17 to Status: Approved', '152.57.20.90', '2026-07-16 11:14:24'),
(292, 1, 'Update Order Status', 'Owner updated Order ID: 18 to Status: Approved', '152.57.20.90', '2026-07-16 11:14:30'),
(293, 1, 'Update Order Status', 'Owner updated Order ID: 19 to Status: Approved', '152.57.20.90', '2026-07-16 11:14:34'),
(294, 1, 'Update Order Status', 'Owner updated Order ID: 20 to Status: Approved', '152.57.20.90', '2026-07-16 11:14:44'),
(295, 1, 'Update Order Status', 'Owner updated Order ID: 21 to Status: Approved', '152.57.20.90', '2026-07-16 11:14:55'),
(296, 1, 'Update Order Status', 'Owner updated Order ID: 26 to Status: Approved', '152.57.20.90', '2026-07-16 11:15:04'),
(297, 1, 'Update Order Status', 'Owner updated Order ID: 25 to Status: Approved', '152.57.20.90', '2026-07-16 11:15:15'),
(298, 1, 'Update Order Status', 'Owner updated Order ID: 24 to Status: Approved', '152.57.20.90', '2026-07-16 11:15:24'),
(299, 1, 'Update Order Status', 'Owner updated Order ID: 23 to Status: Approved', '152.57.20.90', '2026-07-16 11:15:35'),
(300, 1, 'Update Order Status', 'Owner updated Order ID: 22 to Status: Approved', '152.57.20.90', '2026-07-16 11:15:44'),
(301, 1, 'Generate Invoice', 'Invoiced Order ID: 15 -> Invoice No: NE/2026-27/0013. Grand Total: 504', '152.57.20.90', '2026-07-16 11:16:11'),
(302, 1, 'Generate Invoice', 'Invoiced Order ID: 16 -> Invoice No: NE/2026-27/0014. Grand Total: 1512', '152.57.20.90', '2026-07-16 11:19:30'),
(303, 1, 'Generate Invoice', 'Invoiced Order ID: 17 -> Invoice No: NE/2026-27/0015. Grand Total: 1008', '152.57.20.90', '2026-07-16 11:19:43'),
(304, 1, 'Generate Invoice', 'Invoiced Order ID: 18 -> Invoice No: NE/2026-27/0016. Grand Total: 693', '152.57.20.90', '2026-07-16 11:20:05'),
(305, 1, 'Generate Invoice', 'Invoiced Order ID: 19 -> Invoice No: NE/2026-27/0017. Grand Total: 1008', '152.57.20.90', '2026-07-16 11:20:16'),
(306, 1, 'Generate Invoice', 'Invoiced Order ID: 20 -> Invoice No: NE/2026-27/0018. Grand Total: 252', '152.57.20.90', '2026-07-16 11:20:32'),
(307, 1, 'Generate Invoice', 'Invoiced Order ID: 21 -> Invoice No: NE/2026-27/0019. Grand Total: 1008', '152.57.20.90', '2026-07-16 11:20:57'),
(308, 1, 'Generate Invoice', 'Invoiced Order ID: 22 -> Invoice No: NE/2026-27/0020. Grand Total: 1008', '152.57.20.90', '2026-07-16 11:21:18'),
(309, 1, 'Generate Invoice', 'Invoiced Order ID: 23 -> Invoice No: NE/2026-27/0021. Grand Total: 1008', '152.57.20.90', '2026-07-16 11:21:37'),
(310, 1, 'Generate Invoice', 'Invoiced Order ID: 24 -> Invoice No: NE/2026-27/0022. Grand Total: 1008', '152.57.20.90', '2026-07-16 11:23:06'),
(311, 1, 'Generate Invoice', 'Invoiced Order ID: 25 -> Invoice No: NE/2026-27/0023. Grand Total: 1008', '152.57.20.90', '2026-07-16 11:26:12'),
(312, 1, 'Generate Invoice', 'Invoiced Order ID: 26 -> Invoice No: NE/2026-27/0024. Grand Total: 682.54', '152.57.20.90', '2026-07-16 11:26:27'),
(313, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.33.233', '2026-07-17 02:44:27'),
(314, 1, 'Delete SKU', 'Deleted SKU ID: 15', '152.57.33.233', '2026-07-17 02:45:28'),
(315, 1, 'Update SKU', 'Updated SKU ID: 16 (SHRI KRISHNA 20 RS SHEET COW GHEE)', '152.57.33.233', '2026-07-17 02:48:44'),
(316, NULL, 'Failed Login Attempt', 'Username attempted: Shreyansh_', '2409:40f2:1047:c5f0:8000::', '2026-07-17 02:49:21'),
(317, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:1047:c5f0:8000::', '2026-07-17 02:49:24'),
(318, 1, 'Update SKU', 'Updated SKU ID: 13 (SHRI KRISHNA 100ML JAR COW GHEE)', '152.57.33.233', '2026-07-17 02:54:43'),
(319, 1, 'Update SKU', 'Updated SKU ID: 12 (SHRI KRISHNA 200 ML JAR COW GHEE)', '152.57.33.233', '2026-07-17 02:57:08'),
(320, 1, 'Update SKU', 'Updated SKU ID: 14 (SHRI KRISHNA 50ML JAR COW GHEE)', '152.57.33.233', '2026-07-17 03:00:29'),
(321, 1, 'Create SKU', 'Created SKU: SHRI KRISHNA 10RS SHEET COW GHEE (Code: 10 RS SHEET COW GHEE) with opening stock 80', '152.57.33.233', '2026-07-17 03:13:09'),
(322, 1, 'Update SKU', 'Updated SKU ID: 17 (APPALAM)', '152.57.33.233', '2026-07-17 03:19:18'),
(323, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1047:c5f0:8000::', '2026-07-17 05:18:29'),
(324, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.136.73', '2026-07-18 02:54:26'),
(325, 1, 'Create Retailer', 'Created retailer MARUTI GENERAL STORES (Owner: ), assigned to Staff ID: 15', '152.57.136.73', '2026-07-18 02:58:34'),
(326, 1, 'Create Retailer', 'Created retailer CHANDRAKANTH V SAJJAN GENRAL STORES (Owner: ), assigned to Staff ID: 15', '152.57.136.73', '2026-07-18 03:01:19'),
(327, 1, 'Create Retailer', 'Created retailer MAHALAXMI GENERAL STORES (Owner: ), assigned to Staff ID: 15', '152.57.136.73', '2026-07-18 03:03:10'),
(328, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:12c:8584:8000::', '2026-07-18 03:03:50'),
(329, NULL, 'Failed Login Attempt', 'Username attempted: owner', '::1', '2026-07-18 07:37:44'),
(330, NULL, 'Failed Login Attempt', 'Username attempted: owner', '::1', '2026-07-18 07:37:58'),
(331, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:212c:f27b:8000::', '2026-07-18 08:26:49'),
(332, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3842:d16b:f31f:c361:646', '2026-07-18 10:16:57'),
(333, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3842:d16b:f31f:c361:646', '2026-07-18 17:17:16'),
(334, 1, 'Create Route', 'Created route: dfasd with assigned retailers.', '2405:201:d00a:3842:d16b:f31f:c361:646', '2026-07-18 17:17:33'),
(335, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.96.179', '2026-07-19 05:47:57'),
(336, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.96.179', '2026-07-19 05:58:29'),
(337, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.96.179', '2026-07-19 06:00:32'),
(338, 1, 'Update SKU', 'Updated SKU ID: 33 (VINAYAKA BRUTS ZIPPER PACKS)', '152.57.37.5', '2026-07-19 06:07:13'),
(339, 1, 'Update SKU', 'Updated SKU ID: 18 (VINAYAKA BLACK FANTASY ZIPPER PACKS)', '152.57.37.5', '2026-07-19 06:07:33'),
(340, 1, 'Update SKU', 'Updated SKU ID: 21 (VINAYAKA WILD PURPLE ZIPPER PACKS)', '152.57.37.5', '2026-07-19 06:07:55'),
(341, 1, 'Update SKU', 'Updated SKU ID: 22 (VINAYAKA KASTURI ZIPPER PACK)', '152.57.37.5', '2026-07-19 06:08:08'),
(342, 1, 'Update SKU', 'Updated SKU ID: 23 (VINAYAKA DIAMOND ZIPPER PACK)', '152.57.37.5', '2026-07-19 06:08:24'),
(343, 1, 'Update SKU', 'Updated SKU ID: 25 (VINAYAKA HEENA ZIPPER PACKS)', '152.57.37.5', '2026-07-19 06:08:48'),
(344, 1, 'Update SKU', 'Updated SKU ID: 26 (VINAYAKA DREAMS ZIPPER PACKS)', '152.57.37.5', '2026-07-19 06:09:06'),
(345, 1, 'Update SKU', 'Updated SKU ID: 28 (VINAYAKA BOLENATH ZIPPER PACKS)', '152.57.37.5', '2026-07-19 06:09:21'),
(346, 1, 'Update SKU', 'Updated SKU ID: 30 (VINAYAKA GOOD MORNING ECONOMY)', '152.57.37.5', '2026-07-19 06:10:56'),
(347, NULL, 'Failed Login Attempt', 'Username attempted: NAVATARA_06', '152.57.37.5', '2026-07-19 06:11:52'),
(348, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.37.5', '2026-07-19 06:11:55'),
(349, 1, 'Update SKU', 'Updated SKU ID: 30 (VINAYAKA GOOD MORNING ECONOMY)', '152.57.37.5', '2026-07-19 06:13:15'),
(350, 1, 'Update SKU', 'Updated SKU ID: 31 (VINAYAKA BLACK FANTASY 60G)', '152.57.37.5', '2026-07-19 06:15:14'),
(351, 1, 'Update SKU', 'Updated SKU ID: 32 (VINAYAKA WILD PURPLE 60G)', '152.57.37.5', '2026-07-19 06:15:51'),
(352, 1, 'Update SKU', 'Updated SKU ID: 31 (VINAYAKA BLACK FANTASY 60G)', '152.57.37.5', '2026-07-19 06:16:17'),
(353, 1, 'Update SKU', 'Updated SKU ID: 32 (VINAYAKA WILD PURPLE 60G)', '152.57.37.5', '2026-07-19 06:16:37'),
(354, 1, 'Update SKU', 'Updated SKU ID: 29 (VINAYAKA REGULAR POUCH MIX)', '152.57.37.5', '2026-07-19 06:18:49'),
(355, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2401:4900:4bbf:6408:1:0:9172:25f', '2026-07-19 06:23:56'),
(356, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.20.97', '2026-07-19 08:07:17'),
(357, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.20.97', '2026-07-19 08:09:04'),
(358, 1, 'Create Supplier', 'Created supplier: SHREE KRISHNA FOODS PVT LTD', '152.57.20.97', '2026-07-19 08:09:32'),
(359, 1, 'Create Supplier', 'Created supplier: VINAYAKA SALES AND PERFUMARY', '152.57.20.97', '2026-07-19 08:11:34'),
(360, 1, 'Update Supplier', 'Updated supplier ID: 1', '152.57.20.97', '2026-07-19 08:13:45'),
(361, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.20.56', '2026-07-19 13:08:09'),
(362, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.20.56', '2026-07-19 13:14:35'),
(363, 1, 'Update Supplier', 'Updated supplier ID: 1', '152.57.20.56', '2026-07-19 13:17:50'),
(364, 1, 'Update Retailer', 'Updated retailer profile: ANJANEYA GENERAL STORES (ID: 11)', '152.57.17.187', '2026-07-19 14:54:54'),
(365, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.17.187', '2026-07-19 14:58:13'),
(366, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.17.187', '2026-07-19 15:14:16'),
(367, 1, 'Delete Discount', 'Deleted discount ID: 1', '152.57.17.187', '2026-07-19 15:14:48'),
(368, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:12b:53d:8000::', '2026-07-20 07:21:18'),
(369, 1, 'Update Route', 'Updated route ID: 1 with name RAVIWAR PETH, MAIN MARKET and assigned retailers.', '2409:40f2:12b:53d:8000::', '2026-07-20 07:26:20'),
(370, 1, 'Schedule Route', 'Scheduled route ID 1 on Thursday', '2409:40f2:12b:53d:8000::', '2026-07-20 07:26:35'),
(371, 1, 'Create Route', 'Created route: SAMBRA SULEBHAVI with assigned retailers.', '2409:40f2:12b:53d:8000::', '2026-07-20 07:27:07'),
(372, 1, 'Schedule Route', 'Scheduled route ID 2 on Friday', '2409:40f2:12b:53d:8000::', '2026-07-20 07:27:19'),
(373, 1, 'Create Route', 'Created route: Kakati Honaga with assigned retailers.', '2409:40f2:12b:53d:8000::', '2026-07-20 07:27:36'),
(374, 1, 'Schedule Route', 'Scheduled route ID 3 on Saturday', '2409:40f2:12b:53d:8000::', '2026-07-20 07:27:49'),
(375, 1, 'Create Route', 'Created route: Mahantesh Nagar, Autonagar,Kanbargi with assigned retailers.', '2409:40f2:12b:53d:8000::', '2026-07-20 07:28:23'),
(376, 1, 'Schedule Route', 'Scheduled route ID 4 on Wednesday', '2409:40f2:12b:53d:8000::', '2026-07-20 07:28:34'),
(377, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:12b:53d:8000::', '2026-07-20 07:34:56'),
(378, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:12b:53d:8000::', '2026-07-20 07:35:09'),
(379, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:12b:53d:8000::', '2026-07-20 07:36:43'),
(380, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:12b:53d:8000::', '2026-07-20 07:37:03'),
(381, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d018:d84a:4819:c801:7c85:9fa2', '2026-07-20 14:24:24'),
(382, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:102c:254b:8000::', '2026-07-21 03:32:42'),
(383, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:102c:254b:8000::', '2026-07-21 03:39:07'),
(384, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:392a:44e4:68be:21a5:2904', '2026-07-21 06:38:46'),
(385, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:102c:254b:8000::', '2026-07-21 08:39:23'),
(386, 1, 'Create Supplier', 'Created supplier: AMUL', '2409:40f2:102c:254b:8000::', '2026-07-21 08:39:40'),
(387, 1, 'Delete Supplier', 'Deleted supplier ID: 3', '2409:40f2:102c:254b:8000::', '2026-07-21 08:39:46'),
(388, 1, 'Update Brand', 'Updated brand ID: 5 to Name: GHEE', '2409:40f2:102c:254b:8000::', '2026-07-21 08:40:27'),
(389, 1, 'Update Brand', 'Updated brand ID: 6 to Name: INCENSE STICKS', '2409:40f2:102c:254b:8000::', '2026-07-21 08:40:50'),
(390, 1, 'Update Retailer', 'Updated retailer profile: ANAND MASALA STORE (ID: 23)', '2409:40f2:102c:254b:8000::', '2026-07-21 08:43:26'),
(391, 1, 'Update Retailer', 'Updated retailer profile: ANAND MASALA STORE (ID: 23)', '2409:40f2:102c:254b:8000::', '2026-07-21 08:43:26'),
(392, 1, 'Update Retailer', 'Updated retailer profile: ANAND MASALA STORE (ID: 23)', '2409:40f2:102c:254b:8000::', '2026-07-21 08:43:26'),
(393, 1, 'Update Retailer', 'Updated retailer profile: ANJANEYA GENERAL STORES (ID: 11)', '2409:40f2:102c:254b:8000::', '2026-07-21 08:43:56'),
(394, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.197.248', '2026-07-21 13:42:28'),
(395, 1, 'Update Retailer', 'Updated retailer profile: ANAND MASALA STORE (ID: 23)', '157.50.197.248', '2026-07-21 13:56:07'),
(396, 1, 'Update Retailer', 'Updated retailer profile: ANJANEYA GENERAL STORES (ID: 11)', '157.50.197.248', '2026-07-21 13:56:22'),
(397, 1, 'Update Retailer', 'Updated retailer profile: ARVIND ENTERPRISE (ID: 31)', '157.50.197.248', '2026-07-21 13:56:36'),
(398, 1, 'Update Retailer', 'Updated retailer profile: BELAGAONKAR  GENERAL STORES (ID: 22)', '157.50.197.248', '2026-07-21 13:57:05'),
(399, 1, 'Update Retailer', 'Updated retailer profile: CHANDRAKANTH V SAJJAN GENRAL STORES (ID: 33)', '157.50.197.248', '2026-07-21 13:57:56'),
(400, 1, 'Update Retailer', 'Updated retailer profile: D A ATTARA (ID: 26)', '157.50.197.248', '2026-07-21 13:58:14'),
(401, 1, 'Update Retailer', 'Updated retailer profile: DURGA GENERAL STORES (ID: 12)', '157.50.197.248', '2026-07-21 13:58:57'),
(402, 1, 'Update Retailer', 'Updated retailer profile: GURUPRASAD KIRANA STORE (ID: 9)', '157.50.197.248', '2026-07-21 13:59:32'),
(403, 1, 'Update Retailer', 'Updated retailer profile: HARSH ENTERPRISE (ID: 13)', '157.50.197.248', '2026-07-21 13:59:49'),
(404, 1, 'Update Retailer', 'Updated retailer profile: KIRAN PATIL STORES (ID: 21)', '157.50.197.248', '2026-07-21 14:00:21'),
(405, 1, 'Update Retailer', 'Updated retailer profile: M. ANGOLKAR AND  SONS (ID: 28)', '157.50.197.248', '2026-07-21 14:00:55'),
(406, 1, 'Update Retailer', 'Updated retailer profile: MAHAKALI GENRAL STORES (ID: 15)', '157.50.197.248', '2026-07-21 14:01:09'),
(407, 1, 'Update Retailer', 'Updated retailer profile: MAHALAXMI GENERAL STORES (ID: 34)', '157.50.197.248', '2026-07-21 14:01:23'),
(408, 1, 'Update Retailer', 'Updated retailer profile: MAHALAXMI GENERAL STORES (ID: 17)', '157.50.197.248', '2026-07-21 14:01:44'),
(409, 1, 'Update Retailer', 'Updated retailer profile: MARUTI GENERAL STORES (ID: 32)', '157.50.197.248', '2026-07-21 14:02:00'),
(410, 1, 'Update Retailer', 'Updated retailer profile: P R PALAKAR (ID: 24)', '157.50.197.248', '2026-07-21 14:02:24'),
(411, 1, 'Update Retailer', 'Updated retailer profile: PANKAJ COCONUT STORE (ID: 27)', '157.50.197.248', '2026-07-21 14:02:48'),
(412, 1, 'Update Retailer', 'Updated retailer profile: PATIL GENERAL STORES (ID: 10)', '157.50.197.248', '2026-07-21 14:03:10'),
(413, 1, 'Update Retailer', 'Updated retailer profile: PATTANSHETTY GENERAL STORES (ID: 25)', '157.50.197.248', '2026-07-21 14:03:26'),
(414, 1, 'Update Retailer', 'Updated retailer profile: RAVALNATH TRADERS (ID: 29)', '157.50.197.248', '2026-07-21 14:03:45'),
(415, 1, 'Update Retailer', 'Updated retailer profile: SANDEEP KURANGI (ID: 7)', '157.50.197.248', '2026-07-21 14:04:06'),
(416, 1, 'Update Retailer', 'Updated retailer profile: SATVIK GENERAL STORES (ID: 14)', '157.50.197.248', '2026-07-21 14:04:35'),
(417, 1, 'Update Retailer', 'Updated retailer profile: SHRI  GENERAL STORES (ID: 19)', '157.50.197.248', '2026-07-21 14:04:50'),
(418, 1, 'Update Retailer', 'Updated retailer profile: SHRI  GENERAL STORES (ID: 19)', '157.50.197.248', '2026-07-21 14:05:06'),
(419, 1, 'Update Retailer', 'Updated retailer profile: SHRI NEELAMBARI KIRANA AND GENERAL STORE (ID: 8)', '157.50.197.248', '2026-07-21 14:05:30'),
(420, 1, 'Update Retailer', 'Updated retailer profile: SIDDHAROODHA KIRANA STORE (ID: 16)', '157.50.197.248', '2026-07-21 14:06:00'),
(421, 1, 'Update Retailer', 'Updated retailer profile: SIDDHI GENERAL STORES (ID: 20)', '157.50.197.248', '2026-07-21 14:06:20'),
(422, 1, 'Update Retailer', 'Updated retailer profile: VEERA BHADRESHWAR ENTERPRISE (ID: 18)', '157.50.197.248', '2026-07-21 14:07:08'),
(423, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2123:6366:8000::', '2026-07-21 14:58:58'),
(424, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:2123:6366:8000::', '2026-07-21 15:03:57'),
(425, NULL, 'Failed Login Attempt', 'Username attempted: owner', '2409:40f2:2123:6366:8000::', '2026-07-21 15:04:08'),
(426, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2123:6366:8000::', '2026-07-21 15:04:30'),
(427, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1027:adfb:8000::', '2026-07-22 02:13:15'),
(428, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.96.185', '2026-07-22 04:23:26'),
(429, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:204d:bcc1:8000::', '2026-07-22 05:26:45'),
(430, 15, 'Collect Payment', 'Recorded payment of ₹724.50 from Retailer ID: 8 using Method: Cash', '2409:40f2:204d:bcc1:8000::', '2026-07-22 05:31:41'),
(431, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:204d:bcc1:8000::', '2026-07-22 07:04:31'),
(432, 15, 'Collect Payment', 'Recorded payment of ₹189.00 from Retailer ID: 15 using Method: Cash', '2409:40f2:204d:bcc1:8000::', '2026-07-22 07:10:12'),
(433, 15, 'Collect Payment', 'Recorded payment of ₹189.00 from Retailer ID: 16 using Method: Bank Transfer', '2409:40f2:204d:bcc1:8000::', '2026-07-22 07:13:04'),
(434, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.189.30', '2026-07-22 12:46:39'),
(435, 1, 'Delete Invoice', 'Deleted Invoice NE/2026-27/0002. Stock restored for 1 SKUs. Outstanding reduced by ₹94.50', '157.50.189.30', '2026-07-22 12:55:39'),
(436, 1, 'Delete Invoice', 'Deleted Invoice NE/2026-27/0001. Stock restored for 4 SKUs. Outstanding reduced by ₹1,866.57', '157.50.189.30', '2026-07-22 12:57:15'),
(437, 1, 'Delete Invoice', 'Deleted Invoice NE/2026-27/0019. Stock restored for 2 SKUs. Outstanding reduced by ₹1,008.00', '157.50.189.30', '2026-07-22 13:00:12'),
(438, 1, 'Delete Invoice', 'Deleted Invoice NE/2026-27/0020. Stock restored for 1 SKUs. Outstanding reduced by ₹1,008.00', '157.50.189.30', '2026-07-22 13:00:36'),
(439, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.173.174', '2026-07-23 01:44:22'),
(440, 1, 'Inventory Purchase Entry', 'Added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE via Purchase Entry.', '157.50.173.174', '2026-07-23 01:49:56'),
(441, 1, 'Inventory Purchase Entry', 'Added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE via Purchase Entry.', '157.50.173.174', '2026-07-23 01:49:56'),
(442, 1, 'Inventory Purchase Entry', 'Added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE via Purchase Entry.', '157.50.173.174', '2026-07-23 01:49:56'),
(443, 1, 'Inventory Purchase Entry', 'Added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE via Purchase Entry.', '157.50.173.174', '2026-07-23 01:49:56'),
(444, 1, 'Inventory Purchase Entry', 'Added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE via Purchase Entry.', '157.50.173.174', '2026-07-23 01:49:56'),
(445, 1, 'Inventory Purchase Entry', 'Added 240 units to SKU APPALAM via Purchase Entry.', '157.50.173.174', '2026-07-23 01:49:56'),
(446, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '157.50.173.174', '2026-07-23 01:50:31'),
(447, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '157.50.173.174', '2026-07-23 01:50:31'),
(448, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '157.50.173.174', '2026-07-23 01:50:31'),
(449, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '157.50.173.174', '2026-07-23 01:50:31'),
(450, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '157.50.173.174', '2026-07-23 01:50:31'),
(451, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 240 units to SKU APPALAM.', '157.50.173.174', '2026-07-23 01:50:31'),
(452, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '157.50.173.174', '2026-07-23 01:51:06'),
(453, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '157.50.173.174', '2026-07-23 01:51:06'),
(454, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '157.50.173.174', '2026-07-23 01:51:06'),
(455, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '157.50.173.174', '2026-07-23 01:51:06'),
(456, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '157.50.173.174', '2026-07-23 01:51:06'),
(457, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 240 units to SKU APPALAM.', '157.50.173.174', '2026-07-23 01:51:06'),
(458, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-07-01 To: 2026-07-23)', '157.50.173.174', '2026-07-23 02:03:38');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `ip_address`, `created_at`) VALUES
(459, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.5.54', '2026-07-24 04:07:41'),
(460, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.5.54', '2026-07-24 04:07:41'),
(461, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.5.54', '2026-07-24 04:08:53'),
(462, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1039:895:8000::', '2026-07-24 04:09:15'),
(463, 1, 'Delete Discount', 'Deleted discount ID: 2', '152.57.5.54', '2026-07-24 04:24:37'),
(464, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.5.54', '2026-07-24 04:24:53'),
(465, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.5.54', '2026-07-24 04:25:15'),
(466, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.5.54', '2026-07-24 04:25:31'),
(467, 1, 'Delete Discount', 'Deleted discount ID: 4', '152.57.5.54', '2026-07-24 04:27:27'),
(468, 1, 'Delete Discount', 'Deleted discount ID: 3', '152.57.5.54', '2026-07-24 04:27:27'),
(469, 1, 'Delete Discount', 'Deleted discount ID: 5', '152.57.5.54', '2026-07-24 04:27:27'),
(470, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.5.54', '2026-07-24 04:27:47'),
(471, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.5.54', '2026-07-24 04:28:00'),
(472, 1, 'Delete Discount', 'Deleted discount ID: 7', '152.57.5.54', '2026-07-24 04:28:04'),
(473, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.5.54', '2026-07-24 04:28:20'),
(474, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.5.54', '2026-07-24 04:28:33'),
(475, 1, 'Create Retailer', 'Created retailer ANNAPURNESHWARI SUPER MARKET (Owner: )', '152.57.5.54', '2026-07-24 04:33:56'),
(476, 1, 'Create Retailer', 'Created retailer SUPRIYA GENERAL STORES (Owner: )', '152.57.5.54', '2026-07-24 04:35:22'),
(477, 1, 'Create Retailer', 'Created retailer SHRI MAHADEV GENERAL STORES (Owner: )', '152.57.5.54', '2026-07-24 04:36:56'),
(478, 1, 'Create Retailer', 'Created retailer MANGAI GENRAL STORES (Owner: )', '152.57.5.54', '2026-07-24 04:38:38'),
(479, 1, 'Create Discount', 'Added Flat Rate for SKU ID: 12', '152.57.5.54', '2026-07-24 04:45:46'),
(480, 15, 'Create Order', 'Staff created Order ID: 27 for Retailer ID: 35. Grand Total: 141.17', '2409:40f2:1039:895:8000::', '2026-07-24 04:49:32'),
(481, 15, 'Create Order', 'Staff created Order ID: 28 for Retailer ID: 36. Grand Total: 141.17', '2409:40f2:1039:895:8000::', '2026-07-24 04:51:52'),
(482, 15, 'Create Order', 'Staff created Order ID: 29 for Retailer ID: 37. Grand Total: 1038.555', '2409:40f2:1039:895:8000::', '2026-07-24 05:02:48'),
(483, 15, 'Create Order', 'Staff created Order ID: 30 for Retailer ID: 38. Grand Total: 314.1495', '2409:40f2:1039:895:8000::', '2026-07-24 05:04:45'),
(484, 1, 'Update Order Status', 'Owner updated Order ID: 30 to Status: Approved', '152.57.5.54', '2026-07-24 05:23:18'),
(485, 1, 'Update Order Status', 'Owner updated Order ID: 29 to Status: Approved', '152.57.5.54', '2026-07-24 05:23:24'),
(486, 1, 'Update Order Status', 'Owner updated Order ID: 28 to Status: Approved', '152.57.5.54', '2026-07-24 05:23:29'),
(487, 1, 'Update Order Status', 'Owner updated Order ID: 27 to Status: Approved', '152.57.5.54', '2026-07-24 05:23:33'),
(488, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1039:895:8000::', '2026-07-24 10:14:35'),
(489, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.113.81', '2026-07-24 13:51:35'),
(490, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:103a:944c:8000::', '2026-07-25 01:38:39'),
(491, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.46.141', '2026-07-25 02:14:32'),
(492, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.46.141', '2026-07-25 02:22:59'),
(493, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.46.141', '2026-07-25 02:24:45'),
(494, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:9c83:9a31:543e:9252', '2026-07-25 08:48:19'),
(495, 1, 'Logout', 'User NAVATARA_06 logged out.', '2405:201:d00a:3992:9c83:9a31:543e:9252', '2026-07-25 09:58:40'),
(496, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:9c83:9a31:543e:9252', '2026-07-25 09:58:48'),
(497, 1, 'Logout', 'User NAVATARA_06 logged out.', '2405:201:d00a:3992:9c83:9a31:543e:9252', '2026-07-25 10:11:32'),
(498, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:9c83:9a31:543e:9252', '2026-07-25 10:11:44'),
(499, 1, 'Logout', 'User Trishaki@console logged out.', '::1', '2026-07-25 10:12:09'),
(500, NULL, 'Failed Login Attempt', 'Username attempted: owner', '::1', '2026-07-25 10:12:17'),
(501, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '::1', '2026-07-25 10:12:26'),
(502, 1, 'Logout', 'User NAVATARA_06 logged out.', '2405:201:d00a:3992:9c83:9a31:543e:9252', '2026-07-25 10:15:08'),
(503, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:9c83:9a31:543e:9252', '2026-07-25 10:15:20'),
(504, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:9c83:9a31:543e:9252', '2026-07-25 10:15:44'),
(505, 1, 'Logout', 'User NAVATARA_06 logged out.', '2405:201:d00a:3992:9c83:9a31:543e:9252', '2026-07-25 10:16:46'),
(506, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.130.31', '2026-07-25 10:20:03'),
(507, 1, 'Generate Invoice', 'Invoiced Order ID: 27 -> Invoice No: NE/2026-27/0025. Grand Total: 141.17', '152.57.130.31', '2026-07-25 10:22:40'),
(508, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:9c83:9a31:543e:9252', '2026-07-25 10:23:42'),
(509, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.130.31', '2026-07-25 10:24:56'),
(510, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.130.31', '2026-07-25 10:26:42'),
(511, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.130.31', '2026-07-25 11:10:17'),
(512, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.130.31', '2026-07-25 11:11:24'),
(513, 1, 'Generate Invoice', 'Invoiced Order ID: 28 -> Invoice No: NE/2026-27/0026. Grand Total: 141.17', '152.57.130.31', '2026-07-25 11:11:54'),
(514, 1, 'Generate Invoice', 'Invoiced Order ID: 29 -> Invoice No: NE/2026-27/0027. Grand Total: 1038.56', '152.57.130.31', '2026-07-25 11:26:27'),
(515, 1, 'Generate Invoice', 'Invoiced Order ID: 30 -> Invoice No: NE/2026-27/0028. Grand Total: 314.15', '152.57.130.31', '2026-07-25 11:32:15'),
(516, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-25 14:24:06'),
(517, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-25 14:26:40'),
(518, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:24:3873:8000::', '2026-07-25 14:29:52'),
(519, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-25 14:30:09'),
(520, 1, 'Update Retailer', 'Updated retailer profile: MANGAI GENRAL STORES (ID: 38)', '2409:40f2:24:3873:8000::', '2026-07-25 14:30:31'),
(521, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:24:3873:8000::', '2026-07-25 14:31:27'),
(522, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-25 14:31:41'),
(523, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.138.174', '2026-07-25 14:41:10'),
(524, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.138.174', '2026-07-25 14:45:06'),
(525, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '152.57.138.174', '2026-07-25 14:46:54'),
(526, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '152.57.138.174', '2026-07-25 14:46:54'),
(527, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '152.57.138.174', '2026-07-25 14:46:54'),
(528, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '152.57.138.174', '2026-07-25 14:46:54'),
(529, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '152.57.138.174', '2026-07-25 14:46:54'),
(530, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 240 units to SKU APPALAM.', '152.57.138.174', '2026-07-25 14:46:54'),
(531, 1, 'Delete Purchase Entry', 'Deleted purchase entry ID: 2 (Invoice: 1692)', '152.57.138.174', '2026-07-25 14:47:36'),
(532, 1, 'Inventory Purchase Entry', 'Added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE via Purchase Entry.', '152.57.138.174', '2026-07-25 14:50:26'),
(533, 1, 'Inventory Purchase Entry', 'Added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE via Purchase Entry.', '152.57.138.174', '2026-07-25 14:50:26'),
(534, 1, 'Inventory Purchase Entry', 'Added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE via Purchase Entry.', '152.57.138.174', '2026-07-25 14:50:26'),
(535, 1, 'Inventory Purchase Entry', 'Added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE via Purchase Entry.', '152.57.138.174', '2026-07-25 14:50:26'),
(536, 1, 'Inventory Purchase Entry', 'Added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE via Purchase Entry.', '152.57.138.174', '2026-07-25 14:50:26'),
(537, 1, 'Inventory Purchase Entry', 'Added 240 units to SKU APPALAM via Purchase Entry.', '152.57.138.174', '2026-07-25 14:50:26'),
(538, 1, 'Logout', 'User NAVATARA_06 logged out.', '152.57.138.174', '2026-07-25 14:58:13'),
(539, 15, 'Login', 'User shreyansh_ logged in successfully.', '152.57.138.174', '2026-07-25 14:58:36'),
(540, 15, 'Update Retailer', 'Updated retailer profile: ANNAPURNESHWARI SUPER MARKET (ID: 35)', '152.57.138.174', '2026-07-25 14:59:23'),
(541, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:02:41'),
(542, 1, 'Logout', 'User NAVATARA_06 logged out.', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:02:58'),
(543, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:03:17'),
(544, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:04:03'),
(545, NULL, 'Failed Login Attempt', 'Username attempted: kishan', '::1', '2026-07-25 15:05:50'),
(546, NULL, 'Failed Login Attempt', 'Username attempted: owner', '::1', '2026-07-25 15:06:02'),
(547, 1, 'Update Retailer', 'Updated retailer profile: ANNAPURNESHWARI SUPER MARKET (ID: 35)', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:13:24'),
(548, 1, 'Inventory Purchase Entry', 'Added 100 units to SKU VINAYAKA REGULAR POUCH MIX via Purchase Entry.', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:17:50'),
(549, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-25 15:18:29'),
(550, 1, 'Delete Purchase Entry', 'Deleted purchase entry ID: 4 (Invoice: fngmb fgmn)', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:19:04'),
(551, 1, 'Update SKU', 'Updated SKU ID: 12 (SHRI KRISHNA 200 ML JAR COW GHEE)', '2409:40f2:24:3873:8000::', '2026-07-25 15:22:30'),
(552, 1, 'Create SKU', 'Created SKU: KISHAN (Code: INCENSE-STICKS-REGULAR-POUCH-SERIES-KISHAN) with opening stock 10', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:25:13'),
(553, 1, 'Inventory Purchase Entry', 'Added 10 units to SKU KISHAN via Purchase Entry.', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:25:50'),
(554, 1, 'Delete Purchase Entry', 'Deleted purchase entry ID: 5 (Invoice: ghjdfghdfg)', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:26:13'),
(555, 1, 'Delete SKU', 'Deleted SKU ID: 35', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 15:26:18'),
(556, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:b431:f992:36f4:31c2', '2026-07-25 16:22:02'),
(557, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.116.112', '2026-07-26 06:06:16'),
(558, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.116.112', '2026-07-26 06:06:17'),
(559, 1, 'Update SKU', 'Updated SKU ID: 33 (VINAYAKA BRUTS ZIPPER PACKS)', '152.57.116.112', '2026-07-26 06:09:13'),
(560, 1, 'Update SKU', 'Updated SKU ID: 18 (VINAYAKA BLACK FANTASY ZIPPER PACKS)', '152.57.116.112', '2026-07-26 06:09:27'),
(561, 1, 'Update SKU', 'Updated SKU ID: 21 (VINAYAKA WILD PURPLE ZIPPER PACKS)', '152.57.116.112', '2026-07-26 06:10:22'),
(562, 1, 'Update SKU', 'Updated SKU ID: 22 (VINAYAKA KASTURI ZIPPER PACK)', '152.57.116.112', '2026-07-26 06:10:39'),
(563, 1, 'Update SKU', 'Updated SKU ID: 23 (VINAYAKA DIAMOND ZIPPER PACK)', '152.57.116.112', '2026-07-26 06:10:53'),
(564, 1, 'Update SKU', 'Updated SKU ID: 25 (VINAYAKA HEENA ZIPPER PACKS)', '152.57.116.112', '2026-07-26 06:11:08'),
(565, 1, 'Update SKU', 'Updated SKU ID: 26 (VINAYAKA DREAMS ZIPPER PACKS)', '152.57.116.112', '2026-07-26 06:11:18'),
(566, 1, 'Update SKU', 'Updated SKU ID: 28 (VINAYAKA BOLENATH ZIPPER PACKS)', '152.57.116.112', '2026-07-26 06:11:34'),
(567, 1, 'Update SKU', 'Updated SKU ID: 31 (VINAYAKA BLACK FANTASY 60G)', '152.57.116.112', '2026-07-26 06:13:52'),
(568, 1, 'Update SKU', 'Updated SKU ID: 32 (VINAYAKA WILD PURPLE 60G)', '152.57.116.112', '2026-07-26 06:14:02'),
(569, 1, 'Update SKU', 'Updated SKU ID: 29 (VINAYAKA REGULAR POUCH MIX)', '152.57.116.112', '2026-07-26 06:15:33'),
(570, 1, 'Update SKU', 'Updated SKU ID: 30 (VINAYAKA GOOD MORNING ECONOMY)', '152.57.116.112', '2026-07-26 06:16:25'),
(571, 1, 'Delete Purchase Entry', 'Deleted purchase entry ID: 3 (Invoice: 1692)', '152.57.116.112', '2026-07-26 06:17:43'),
(572, 1, 'Inventory Purchase Entry', 'Added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:20:18'),
(573, 1, 'Inventory Purchase Entry', 'Added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:20:18'),
(574, 1, 'Inventory Purchase Entry', 'Added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:20:18'),
(575, 1, 'Inventory Purchase Entry', 'Added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:20:18'),
(576, 1, 'Inventory Purchase Entry', 'Added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:20:18'),
(577, 1, 'Inventory Purchase Entry', 'Added 240 units to SKU APPALAM via Purchase Entry.', '152.57.116.112', '2026-07-26 06:20:18'),
(578, 1, 'Update SKU', 'Updated SKU ID: 12 (SHRI KRISHNA 200 ML JAR COW GHEE)', '152.57.116.112', '2026-07-26 06:22:11'),
(579, 1, 'Update SKU', 'Updated SKU ID: 13 (SHRI KRISHNA 100ML JAR COW GHEE)', '152.57.116.112', '2026-07-26 06:24:05'),
(580, 1, 'Update SKU', 'Updated SKU ID: 14 (SHRI KRISHNA 50ML JAR COW GHEE)', '152.57.116.112', '2026-07-26 06:24:28'),
(581, 1, 'Update SKU', 'Updated SKU ID: 34 (SHRI KRISHNA 10RS SHEET COW GHEE)', '152.57.116.112', '2026-07-26 06:24:58'),
(582, 1, 'Update SKU', 'Updated SKU ID: 16 (SHRI KRISHNA 20 RS SHEET COW GHEE)', '152.57.116.112', '2026-07-26 06:25:28'),
(583, 1, 'Delete Purchase Entry', 'Deleted purchase entry ID: 6 (Invoice: 1692)', '152.57.116.112', '2026-07-26 06:26:09'),
(584, 1, 'Inventory Purchase Entry', 'Added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:27:07'),
(585, 1, 'Inventory Purchase Entry', 'Added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:27:07'),
(586, 1, 'Delete Purchase Entry', 'Deleted purchase entry ID: 7 (Invoice: 1692)', '152.57.116.112', '2026-07-26 06:27:28'),
(587, 1, 'Inventory Purchase Entry', 'Added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:29:23'),
(588, 1, 'Inventory Purchase Entry', 'Added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:29:23'),
(589, 1, 'Inventory Purchase Entry', 'Added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:29:23'),
(590, 1, 'Inventory Purchase Entry', 'Added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:29:23'),
(591, 1, 'Inventory Purchase Entry', 'Added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:29:23'),
(592, 1, 'Inventory Purchase Entry', 'Added 240 units to SKU APPALAM via Purchase Entry.', '152.57.116.112', '2026-07-26 06:29:23'),
(593, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 06:36:57'),
(594, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 06:36:57'),
(595, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '152.57.116.112', '2026-07-26 06:36:57'),
(596, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '152.57.116.112', '2026-07-26 06:36:57'),
(597, 1, 'Inventory Purchase Entry', 'Added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE via Purchase Entry.', '152.57.116.112', '2026-07-26 06:37:58'),
(598, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2401:4900:33dc:4fe9:2:2:72cf:1855', '2026-07-26 06:44:11'),
(599, 1, 'Inventory Purchase Entry', 'Added 10 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS via Purchase Entry.', '152.57.116.112', '2026-07-26 06:44:15'),
(600, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 12 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:45:09'),
(601, 1, 'Inventory Purchase Entry', 'Added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE via Purchase Entry.', '2401:4900:33dc:4fe9:2:2:72cf:1855', '2026-07-26 06:45:44'),
(602, 1, 'Delete Purchase Entry', 'Deleted purchase entry ID: 11 (Invoice: Test)', '2401:4900:33dc:4fe9:2:2:72cf:1855', '2026-07-26 06:45:53'),
(603, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:46:04'),
(604, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:46:04'),
(605, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:48:51'),
(606, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:48:51'),
(607, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA KASTURI ZIPPER PACK.', '152.57.116.112', '2026-07-26 06:48:51'),
(608, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DIAMOND ZIPPER PACK.', '152.57.116.112', '2026-07-26 06:48:51'),
(609, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA HEENA ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:48:51'),
(610, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DREAMS ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:48:51'),
(611, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BOLENATH ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:48:51'),
(612, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BRUTS ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:48:51'),
(613, 1, 'Inventory Purchase Entry', 'Added 960 units to SKU VINAYAKA REGULAR POUCH MIX via Purchase Entry.', '152.57.116.112', '2026-07-26 06:50:39'),
(614, 1, 'Delete Purchase Entry', 'Deleted purchase entry ID: 12 (Invoice: 22526)', '152.57.116.112', '2026-07-26 06:52:36'),
(615, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:57:48'),
(616, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:57:48'),
(617, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA KASTURI ZIPPER PACK.', '152.57.116.112', '2026-07-26 06:57:48'),
(618, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DIAMOND ZIPPER PACK.', '152.57.116.112', '2026-07-26 06:57:48'),
(619, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA HEENA ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:57:48'),
(620, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DREAMS ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:57:48'),
(621, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BOLENATH ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:57:48'),
(622, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BRUTS ZIPPER PACKS.', '152.57.116.112', '2026-07-26 06:57:48'),
(623, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 960 units to SKU VINAYAKA REGULAR POUCH MIX.', '152.57.116.112', '2026-07-26 06:57:48'),
(624, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 250 units to SKU VINAYAKA GOOD MORNING ECONOMY.', '152.57.116.112', '2026-07-26 06:57:48'),
(625, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 150 units to SKU VINAYAKA BLACK FANTASY 60G.', '152.57.116.112', '2026-07-26 06:57:48'),
(626, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 150 units to SKU VINAYAKA WILD PURPLE 60G.', '152.57.116.112', '2026-07-26 06:57:48'),
(627, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.116.112', '2026-07-26 07:01:40'),
(628, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS.', '152.57.116.112', '2026-07-26 07:01:40'),
(629, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA KASTURI ZIPPER PACK.', '152.57.116.112', '2026-07-26 07:01:40'),
(630, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DIAMOND ZIPPER PACK.', '152.57.116.112', '2026-07-26 07:01:40'),
(631, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA HEENA ZIPPER PACKS.', '152.57.116.112', '2026-07-26 07:01:40'),
(632, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DREAMS ZIPPER PACKS.', '152.57.116.112', '2026-07-26 07:01:40'),
(633, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BOLENATH ZIPPER PACKS.', '152.57.116.112', '2026-07-26 07:01:40'),
(634, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BRUTS ZIPPER PACKS.', '152.57.116.112', '2026-07-26 07:01:40'),
(635, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 960 units to SKU VINAYAKA REGULAR POUCH MIX.', '152.57.116.112', '2026-07-26 07:01:40'),
(636, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 300 units to SKU VINAYAKA GOOD MORNING ECONOMY.', '152.57.116.112', '2026-07-26 07:01:40'),
(637, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 180 units to SKU VINAYAKA BLACK FANTASY 60G.', '152.57.116.112', '2026-07-26 07:01:40'),
(638, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 180 units to SKU VINAYAKA WILD PURPLE 60G.', '152.57.116.112', '2026-07-26 07:01:40'),
(639, 1, 'Delete Purchase Entry', 'Deleted purchase entry ID: 9 (Invoice: 1693)', '152.57.116.112', '2026-07-26 07:02:15'),
(640, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 07:02:58'),
(641, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 07:02:58'),
(642, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '152.57.116.112', '2026-07-26 07:02:58'),
(643, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '152.57.116.112', '2026-07-26 07:02:58'),
(644, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 07:02:58'),
(645, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 07:04:35'),
(646, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 07:04:35'),
(647, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '152.57.116.112', '2026-07-26 07:04:35'),
(648, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '152.57.116.112', '2026-07-26 07:04:35'),
(649, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 07:04:35'),
(650, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 07:04:44'),
(651, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 07:04:44'),
(652, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '152.57.116.112', '2026-07-26 07:04:44'),
(653, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '152.57.116.112', '2026-07-26 07:04:44'),
(654, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '152.57.116.112', '2026-07-26 07:04:44'),
(655, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-26 07:15:33'),
(656, 1, 'Update Retailer', 'Updated retailer profile: SUPRIYA GENERAL STORES (ID: 36)', '2409:40f2:24:3873:8000::', '2026-07-26 07:16:16'),
(657, 1, 'Update Retailer', 'Updated retailer profile: MANGAI GENRAL STORES (ID: 38)', '2409:40f2:24:3873:8000::', '2026-07-26 07:17:11'),
(658, 1, 'Update Retailer', 'Updated retailer profile: SHRI MAHADEV GENERAL STORES (ID: 37)', '2409:40f2:24:3873:8000::', '2026-07-26 07:17:37'),
(659, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:24:3873:8000::', '2026-07-26 07:17:44'),
(660, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-26 07:18:02'),
(661, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-26 09:19:39'),
(662, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-26 09:21:30'),
(663, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-26 09:23:23'),
(664, 1, 'Update Retailer', 'Updated retailer profile: SHRI MAHADEV GENERAL STORES (ID: 37)', '2409:40f2:24:3873:8000::', '2026-07-26 09:24:13'),
(665, 1, 'Remove Schedule', 'Removed schedule entry ID: 2', '2409:40f2:24:3873:8000::', '2026-07-26 09:25:13'),
(666, 1, 'Remove Schedule', 'Removed schedule entry ID: 3', '2409:40f2:24:3873:8000::', '2026-07-26 09:25:15'),
(667, 1, 'Remove Schedule', 'Removed schedule entry ID: 1', '2409:40f2:24:3873:8000::', '2026-07-26 09:25:17'),
(668, 1, 'Remove Schedule', 'Removed schedule entry ID: 4', '2409:40f2:24:3873:8000::', '2026-07-26 09:25:21'),
(669, 1, 'Update Route', 'Updated route ID: 4 with name Mahantesh Nagar, Autonagar,Kanbargi and assigned retailers.', '2409:40f2:24:3873:8000::', '2026-07-26 09:25:29'),
(670, 1, 'Schedule Route', 'Scheduled route ID 4 on Wednesday', '2409:40f2:24:3873:8000::', '2026-07-26 09:25:45'),
(671, 1, 'Schedule Route', 'Scheduled route ID 2 on Friday', '2409:40f2:24:3873:8000::', '2026-07-26 09:25:58'),
(672, 1, 'Schedule Route', 'Scheduled route ID 1 on Thursday', '2409:40f2:24:3873:8000::', '2026-07-26 09:26:07'),
(673, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:24:3873:8000::', '2026-07-26 09:26:35'),
(674, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-26 09:26:50'),
(675, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:24:3873:8000::', '2026-07-26 09:29:08'),
(676, 1, 'Remove Schedule', 'Removed schedule entry ID: 5', '2409:40f2:24:3873:8000::', '2026-07-26 09:29:49'),
(677, 1, 'Remove Schedule', 'Removed schedule entry ID: 5', '2409:40f2:24:3873:8000::', '2026-07-26 09:29:50'),
(678, 1, 'Remove Schedule', 'Removed schedule entry ID: 6', '2409:40f2:24:3873:8000::', '2026-07-26 09:29:52'),
(679, 1, 'Remove Schedule', 'Removed schedule entry ID: 6', '2409:40f2:24:3873:8000::', '2026-07-26 09:29:53'),
(680, 1, 'Remove Schedule', 'Removed schedule entry ID: 7', '2409:40f2:24:3873:8000::', '2026-07-26 09:29:54'),
(681, 1, 'Remove Schedule', 'Removed schedule entry ID: 7', '2409:40f2:24:3873:8000::', '2026-07-26 09:29:55'),
(682, 1, 'Reset Staff Schedule', 'Cleared all schedule entries for Staff ID: 15', '2409:40f2:24:3873:8000::', '2026-07-26 09:29:58'),
(683, 1, 'Schedule Route', 'Scheduled route ID 4 on Wednesday', '2409:40f2:24:3873:8000::', '2026-07-26 09:30:27'),
(684, 1, 'Schedule Route', 'Scheduled route ID 2 on Friday', '2409:40f2:24:3873:8000::', '2026-07-26 09:30:38'),
(685, 1, 'Schedule Route', 'Scheduled route ID 1 on Thursday', '2409:40f2:24:3873:8000::', '2026-07-26 09:30:47'),
(686, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.31.130', '2026-07-26 13:50:47'),
(687, 1, 'Logout', 'User NAVATARA_06 logged out.', '152.57.31.130', '2026-07-26 13:51:17'),
(688, 15, 'Login', 'User shreyansh_ logged in successfully.', '152.57.31.130', '2026-07-26 13:51:39'),
(689, 1, 'Logout', 'User NAVATARA_06 logged out.', '223.186.249.4', '2026-07-26 14:07:17'),
(690, NULL, 'Failed Login Attempt', 'Username attempted: Shreyansh_ |', '223.186.249.4', '2026-07-26 14:07:27'),
(691, 15, 'Login', 'User Shreyansh_ logged in successfully.', '223.186.249.4', '2026-07-26 14:07:40'),
(692, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.31.130', '2026-07-26 14:12:21'),
(693, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:12:7015:8000::', '2026-07-27 04:47:37'),
(694, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:12:7015:8000::', '2026-07-27 04:47:37'),
(695, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:12:7015:8000::', '2026-07-27 05:59:33'),
(696, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:4d:68ab:8000::', '2026-07-27 14:49:03'),
(697, 1, 'Delete Purchase Entry', 'Deleted purchase entry ID: 8 (Invoice: 1692)', '2409:40f2:4d:68ab:8000::', '2026-07-27 14:49:39'),
(698, 1, 'Create Route', 'Created route: KHADE BAZAR with assigned retailers.', '2409:40f2:4d:68ab:8000::', '2026-07-27 14:50:40'),
(699, 1, 'Schedule Route', 'Scheduled route ID 5 on Monday', '2409:40f2:4d:68ab:8000::', '2026-07-27 14:50:55'),
(700, 1, 'Create Retailer', 'Created retailer SAI PAN SHOP (Owner: )', '2409:40f2:4d:68ab:8000::', '2026-07-27 14:52:53'),
(701, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:4d:68ab:8000::', '2026-07-27 14:53:08'),
(702, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:4d:68ab:8000::', '2026-07-27 14:53:20'),
(703, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311:cc61:8000::', '2026-07-29 04:45:23'),
(704, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311:cc61:8000::', '2026-07-29 04:53:51'),
(705, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311:cc61:8000::', '2026-07-29 05:04:46'),
(706, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311:cc61:8000::', '2026-07-29 05:48:27'),
(707, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311:cc61:8000::', '2026-07-29 07:53:52'),
(708, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:311:cc61:8000::', '2026-07-29 07:55:13'),
(709, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:311:cc61:8000::', '2026-07-29 07:55:26'),
(710, 1, 'Remove Schedule', 'Removed schedule entry ID: 8', '2409:40f2:311:cc61:8000::', '2026-07-29 07:55:40'),
(711, 1, 'Schedule Route', 'Scheduled route ID 4 on Wednesday', '2409:40f2:311:cc61:8000::', '2026-07-29 07:55:52'),
(712, 1, 'Update Retailer', 'Updated retailer profile: GURUPRASAD KIRANA STORE (ID: 9)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:57:31'),
(713, 1, 'Update Retailer', 'Updated retailer profile: PATIL GENERAL STORES (ID: 10)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:57:59'),
(714, 1, 'Update Retailer', 'Updated retailer profile: DURGA GENERAL STORES (ID: 12)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:58:07'),
(715, 1, 'Update Retailer', 'Updated retailer profile: DURGA GENERAL STORES (ID: 12)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:58:07'),
(716, 1, 'Update Retailer', 'Updated retailer profile: HARSH ENTERPRISE (ID: 13)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:58:18'),
(717, 1, 'Update Retailer', 'Updated retailer profile: SATVIK GENERAL STORES (ID: 14)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:58:27'),
(718, 1, 'Update Retailer', 'Updated retailer profile: MAHAKALI GENRAL STORES (ID: 15)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:58:40'),
(719, 1, 'Update Retailer', 'Updated retailer profile: SIDDHAROODHA KIRANA STORE (ID: 16)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:58:52'),
(720, 1, 'Update Retailer', 'Updated retailer profile: MAHALAXMI GENERAL STORES (ID: 17)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:59:02'),
(721, 1, 'Update Retailer', 'Updated retailer profile: VEERA BHADRESHWAR ENTERPRISE (ID: 18)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:59:12'),
(722, 1, 'Update Retailer', 'Updated retailer profile: ANNAPURNESHWARI SUPER MARKET (ID: 35)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:59:35'),
(723, 1, 'Update Retailer', 'Updated retailer profile: MANGAI GENRAL STORES (ID: 38)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:59:50'),
(724, 1, 'Update Retailer', 'Updated retailer profile: SHRI MAHADEV GENERAL STORES (ID: 37)', '2409:40f2:311:cc61:8000::', '2026-07-29 07:59:56'),
(725, 1, 'Update Retailer', 'Updated retailer profile: SUPRIYA GENERAL STORES (ID: 36)', '2409:40f2:311:cc61:8000::', '2026-07-29 08:00:11'),
(726, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:311:cc61:8000::', '2026-07-29 08:01:04'),
(727, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311:cc61:8000::', '2026-07-29 08:01:17'),
(728, 15, 'Collect Payment', 'Recorded payment of ₹504.00 from Retailer ID: 10 using Method: Cash', '2409:40f2:311:cc61:8000::', '2026-07-29 08:02:12'),
(729, 15, 'Collect Payment', 'Recorded payment of ₹441.00 from Retailer ID: 12 using Method: Cash', '2409:40f2:311:cc61:8000::', '2026-07-29 08:02:41'),
(730, 15, 'Collect Payment', 'Recorded payment of ₹347.00 from Retailer ID: 9 using Method: UPI', '2409:40f2:311:cc61:8000::', '2026-07-29 08:03:22'),
(731, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.119.33', '2026-07-29 08:08:25'),
(732, 1, 'Collect Payment', 'Recorded payment of ₹1,038.56 from Retailer ID: 37 using Method: Cash', '152.57.119.33', '2026-07-29 08:10:38'),
(733, 1, 'Collect Payment', 'Recorded payment of ₹141.17 from Retailer ID: 36 using Method: Cash', '152.57.119.33', '2026-07-29 08:11:35'),
(734, 1, 'Collect Payment', 'Recorded payment of ₹141.17 from Retailer ID: 35 using Method: Cash', '152.57.119.33', '2026-07-29 08:12:13'),
(735, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311:cc61:8000::', '2026-07-29 11:42:23'),
(736, 15, 'Create Order', 'Staff created Order ID: 31 for Retailer ID: 15. Grand Total: 179.676', '2409:40f2:311:cc61:8000::', '2026-07-29 11:52:02'),
(737, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.119.103', '2026-07-29 11:52:30'),
(738, 1, 'Update Order Status', 'Owner updated Order ID: 31 to Status: Approved', '152.57.119.103', '2026-07-29 11:53:25'),
(739, 1, 'Generate Invoice', 'Invoiced Order ID: 31 -> Invoice No: NE/2026-27/0029. Grand Total: 179.68', '152.57.119.103', '2026-07-29 11:56:41'),
(740, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1028:ce1e:8000::', '2026-07-30 11:56:47'),
(741, 15, 'Collect Payment', 'Recorded payment of ₹682.54 from Retailer ID: 31 using Method: Cash', '2409:40f2:1028:ce1e:8000::', '2026-07-30 11:57:01'),
(742, 15, 'Collect Payment', 'Recorded payment of ₹252.00 from Retailer ID: 24 using Method: Cash', '2409:40f2:1028:ce1e:8000::', '2026-07-30 11:57:11'),
(743, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2054:3058:8000::', '2026-07-31 03:59:31'),
(744, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2054:3058:8000::', '2026-07-31 04:05:12'),
(745, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:2054:3058:8000::', '2026-07-31 04:09:30'),
(746, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2054:3058:8000::', '2026-07-31 04:09:43'),
(747, 1, 'Update SKU', 'Updated SKU ID: 33 (VINAYAKA BRUTS ZIPPER PACKS)', '2409:40f2:2054:3058:8000::', '2026-07-31 04:10:19'),
(748, 1, 'Update SKU', 'Updated SKU ID: 28 (VINAYAKA BOLENATH ZIPPER PACKS)', '2409:40f2:2054:3058:8000::', '2026-07-31 04:10:51'),
(749, 1, 'Update SKU', 'Updated SKU ID: 26 (VINAYAKA DREAMS ZIPPER PACKS)', '2409:40f2:2054:3058:8000::', '2026-07-31 04:11:02'),
(750, 1, 'Update SKU', 'Updated SKU ID: 25 (VINAYAKA HEENA ZIPPER PACKS)', '2409:40f2:2054:3058:8000::', '2026-07-31 04:11:16'),
(751, 1, 'Update SKU', 'Updated SKU ID: 23 (VINAYAKA DIAMOND ZIPPER PACK)', '2409:40f2:2054:3058:8000::', '2026-07-31 04:11:26'),
(752, 1, 'Update SKU', 'Updated SKU ID: 22 (VINAYAKA KASTURI ZIPPER PACK)', '2409:40f2:2054:3058:8000::', '2026-07-31 04:11:37'),
(753, 1, 'Update SKU', 'Updated SKU ID: 21 (VINAYAKA WILD PURPLE ZIPPER PACKS)', '2409:40f2:2054:3058:8000::', '2026-07-31 04:11:46'),
(754, 1, 'Update SKU', 'Updated SKU ID: 18 (VINAYAKA BLACK FANTASY ZIPPER PACKS)', '2409:40f2:2054:3058:8000::', '2026-07-31 04:11:56'),
(755, 1, 'Create SKU', 'Created SKU: VINAYAKA ONE PLUS ZIPPER PACKS (Code: INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPPER-PACKS) with opening stock 0', '2409:40f2:2054:3058:8000::', '2026-07-31 04:13:02'),
(756, 1, 'Collect Payment', 'Recorded payment of ₹500.00 from Retailer ID: 20 using Method: Cash', '2409:40f2:2054:3058:8000::', '2026-07-31 04:13:51'),
(757, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:2054:3058:8000::', '2026-07-31 04:14:42'),
(758, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2054:3058:8000::', '2026-07-31 04:14:54'),
(759, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.189.68', '2026-07-31 05:33:03'),
(760, 1, 'Create Retailer', 'Created retailer BASAVESHWAR TRADERS (Owner: )', '157.50.189.68', '2026-07-31 05:36:32'),
(761, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2054:3058:8000::', '2026-07-31 05:37:19'),
(762, 15, 'Create Order', 'Staff created Order ID: 32 for Retailer ID: 40. Grand Total: 3389.57', '2409:40f2:2054:3058:8000::', '2026-07-31 05:37:56'),
(763, 1, 'Update Order Status', 'Owner updated Order ID: 32 to Status: Cancelled', '157.50.189.68', '2026-07-31 05:39:19'),
(764, 1, 'Delete Discount', 'Deleted discount ID: 9', '157.50.189.68', '2026-07-31 05:40:08'),
(765, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '157.50.189.68', '2026-07-31 05:40:19'),
(766, 15, 'Create Order', 'Staff created Order ID: 33 for Retailer ID: 40. Grand Total: 3389.57', '2409:40f2:2054:3058:8000::', '2026-07-31 05:41:53'),
(767, 1, 'Update SKU', 'Updated SKU ID: 17 (APPALAM)', '157.50.189.68', '2026-07-31 05:45:20'),
(768, 1, 'Update SKU', 'Updated SKU ID: 17 (APPALAM)', '157.50.189.68', '2026-07-31 05:45:56'),
(769, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2054:3058:8000::', '2026-07-31 07:15:02'),
(770, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2f:7028:8000::', '2026-08-01 12:41:07'),
(771, 15, 'Collect Payment', 'Recorded payment of ₹1,008.00 from Retailer ID: 28 using Method: Cash', '2409:40f2:2f:7028:8000::', '2026-08-01 12:41:42'),
(772, 15, 'Collect Payment', 'Recorded payment of ₹300.00 from Retailer ID: 23 using Method: Cash', '2409:40f2:2f:7028:8000::', '2026-08-01 12:42:20'),
(773, 15, 'Collect Payment', 'Recorded payment of ₹1,008.00 from Retailer ID: 21 using Method: Cash', '2409:40f2:2f:7028:8000::', '2026-08-01 12:43:19'),
(774, 15, 'Collect Payment', 'Recorded payment of ₹504.00 from Retailer ID: 19 using Method: Cash', '2409:40f2:2f:7028:8000::', '2026-08-01 12:43:47'),
(775, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:212e:568f:8000::', '2026-08-02 06:04:56'),
(776, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:e8eb:30ca:8a6f:4717', '2026-08-02 12:19:52'),
(777, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2405:201:d00a:3992:e8eb:30ca:8a6f:4717', '2026-08-02 12:20:14'),
(778, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2405:201:d00a:3992:e8eb:30ca:8a6f:4717', '2026-08-02 12:25:48'),
(779, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2405:201:d00a:3992:e8eb:30ca:8a6f:4717', '2026-08-02 12:26:38'),
(780, 1, 'Remove Schedule', 'Removed schedule entry ID: 9', '2405:201:d00a:3992:e8eb:30ca:8a6f:4717', '2026-08-02 12:27:31'),
(781, 1, 'Remove Schedule', 'Removed schedule entry ID: 9', '2405:201:d00a:3992:e8eb:30ca:8a6f:4717', '2026-08-02 12:27:32'),
(782, 1, 'Schedule Route', 'Scheduled route ID 5 on Sunday', '2405:201:d00a:3992:e8eb:30ca:8a6f:4717', '2026-08-02 12:27:51'),
(783, 1, 'Schedule Route', 'Scheduled route ID 5 on Sunday', '2405:201:d00a:3992:e8eb:30ca:8a6f:4717', '2026-08-02 12:28:23'),
(784, 15, 'Create Order', 'Staff created Order ID: 34 for Retailer ID: 39. Grand Total: 3248.27', '2405:201:d00a:3992:e8eb:30ca:8a6f:4717', '2026-08-02 12:29:48'),
(785, 15, 'Create Order', 'Staff created Order ID: 35 for Retailer ID: 39. Grand Total: 2625', '2405:201:d00a:3992:e8eb:30ca:8a6f:4717', '2026-08-02 12:48:39'),
(786, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2b:3ed4:8000::', '2026-08-02 13:44:59'),
(787, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.128.120', '2026-08-02 14:23:12'),
(788, 1, 'Update Staff Account', 'Updated details for staff ID: 15 (SHREYANSH)', '152.57.128.120', '2026-08-02 14:24:10'),
(789, 1, 'Logout', 'User NAVATARA_06 logged out.', '152.57.128.120', '2026-08-02 14:25:00'),
(790, 15, 'Login', 'User Shreyansh_ logged in successfully.', '152.57.128.120', '2026-08-02 14:25:21'),
(791, 15, 'Logout', 'User Shreyansh_ logged out.', '152.57.128.120', '2026-08-02 14:26:37'),
(792, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.128.120', '2026-08-02 14:26:41'),
(793, 1, 'Inventory Purchase Entry', 'Added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE via Purchase Entry.', '152.57.128.120', '2026-08-02 14:27:18'),
(794, 1, 'Update Order Status', 'Owner updated Order ID: 35 to Status: Cancelled', '152.57.128.120', '2026-08-02 14:31:07'),
(795, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.128.120', '2026-08-02 14:32:27'),
(796, 1, 'Update Order Status', 'Owner updated Order ID: 34 to Status: Cancelled', '152.57.128.120', '2026-08-02 14:33:04'),
(797, 1, 'Update Order Status', 'Owner updated Order ID: 33 to Status: Cancelled', '152.57.128.120', '2026-08-02 14:33:19'),
(798, 1, 'Logout', 'User NAVATARA_06 logged out.', '152.57.128.120', '2026-08-02 14:33:50'),
(799, 15, 'Login', 'User Shreyansh_ logged in successfully.', '152.57.128.120', '2026-08-02 14:34:03'),
(800, 15, 'Update Retailer', 'Updated retailer profile: BASAVESHWAR TRADERS (ID: 40)', '152.57.128.120', '2026-08-02 14:36:29'),
(801, 15, 'Create Order', 'Staff created Order ID: 36 for Retailer ID: 40. Grand Total: 3000', '152.57.128.120', '2026-08-02 14:37:52'),
(802, 15, 'Logout', 'User Shreyansh_ logged out.', '152.57.128.120', '2026-08-02 14:38:14'),
(803, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.128.120', '2026-08-02 14:38:20'),
(804, 1, 'Update Order Status', 'Owner updated Order ID: 36 to Status: Approved', '152.57.128.120', '2026-08-02 14:38:43'),
(805, 1, 'Generate Invoice', 'Invoiced Order ID: 36 -> Invoice No: NE/2026-27/0030. Grand Total: 3000', '152.57.128.120', '2026-08-02 14:39:41'),
(806, 1, 'Update Expense', 'Updated expense ID: 3 (Office / Stationery) via Cash', '152.57.128.120', '2026-08-02 14:47:35'),
(807, 1, 'Update Expense', 'Updated expense ID: 3 (Office / Stationery) via Cash', '152.57.128.120', '2026-08-02 14:47:52'),
(808, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 14:58:25'),
(809, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 14:58:25'),
(810, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 15:00:07'),
(811, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 15:00:07'),
(812, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 15:00:07'),
(813, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '152.57.128.120', '2026-08-02 15:00:07'),
(814, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '152.57.128.120', '2026-08-02 15:00:07'),
(815, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 240 units to SKU APPALAM.', '152.57.128.120', '2026-08-02 15:00:07'),
(816, 1, 'Create Brand', 'Created brand: CUP DHOOP', '152.57.128.120', '2026-08-02 15:01:35'),
(817, 1, 'Delete Brand', 'Deleted brand ID: 7', '152.57.128.120', '2026-08-02 15:02:49'),
(818, 1, 'Create Product', 'Created product: CUP DHOOP under Brand ID: 6', '152.57.128.120', '2026-08-02 15:03:29'),
(819, 1, 'Update SKU', 'Updated SKU ID: 36 (VINAYAKA ONE PLUS ZIPPER PACKS)', '152.57.128.120', '2026-08-02 15:03:49'),
(820, 1, 'Create SKU', 'Created SKU: VINAYAKA CUP DHOOP GUGGAL (Code: INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL) with opening stock 48', '152.57.128.120', '2026-08-02 15:19:35'),
(821, 1, 'Create SKU', 'Created SKU: VINAYAKA CUP DHOOP SAMBRANI (Code: INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRANI) with opening stock 48', '152.57.128.120', '2026-08-02 15:20:56'),
(822, 1, 'Create SKU', 'Created SKU: VINAYAKA CUP DHOOP MANGAL (Code: INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL) with opening stock 48', '152.57.128.120', '2026-08-02 15:22:06'),
(823, 1, 'Update SKU', 'Updated SKU ID: 39 (VINAYAKA CUP DHOOP MANGAL)', '152.57.128.120', '2026-08-02 15:22:21'),
(824, 1, 'Update SKU', 'Updated SKU ID: 39 (VINAYAKA CUP DHOOP MANGAL)', '152.57.128.120', '2026-08-02 15:22:41'),
(825, 1, 'Inventory Purchase Entry', 'Added 480 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS via Purchase Entry.', '152.57.128.120', '2026-08-02 15:25:21'),
(826, 1, 'Inventory Purchase Entry', 'Added 48 units to SKU VINAYAKA CUP DHOOP GUGGAL via Purchase Entry.', '152.57.128.120', '2026-08-02 15:25:21'),
(827, 1, 'Inventory Purchase Entry', 'Added 48 units to SKU VINAYAKA CUP DHOOP SAMBRANI via Purchase Entry.', '152.57.128.120', '2026-08-02 15:25:21'),
(828, 1, 'Inventory Purchase Entry', 'Added 48 units to SKU VINAYAKA CUP DHOOP MANGAL via Purchase Entry.', '152.57.128.120', '2026-08-02 15:25:21'),
(829, 1, 'Inventory Purchase Entry', 'Added 480 units to SKU APPALAM via Purchase Entry.', '152.57.128.120', '2026-08-02 15:27:11'),
(830, 1, 'Create Brand', 'Created brand: MASALA', '152.57.128.120', '2026-08-02 15:30:08'),
(831, 1, 'Create Product', 'Created product: GINGER GARLIC PASTE under Brand ID: 8', '152.57.128.120', '2026-08-02 15:31:05'),
(832, 1, 'Create Product', 'Created product: TURMERIC POWDER under Brand ID: 8', '152.57.128.120', '2026-08-02 15:32:10'),
(833, 1, 'Create Product', 'Created product: TURMERIC POWDER SHEET under Brand ID: 8', '152.57.128.120', '2026-08-02 15:32:48'),
(834, 1, 'Create SKU', 'Created SKU: GINGER GARLIC PASTE 5RS (Code: MASALA-GINGER-GARLIC-PASTE-GINGER-GARLIC-PASTE-5RS) with opening stock 0', '152.57.128.120', '2026-08-02 15:35:24'),
(835, 1, 'Create SKU', 'Created SKU: TURMERIC POWDER 5KG (Code: MASALA-TURMERIC-POWDER-TURMERIC-POWDER-5KG) with opening stock 0', '152.57.128.120', '2026-08-02 15:38:12'),
(836, 1, 'Create SKU', 'Created SKU: TURMERIC POWDER SHEET 10RS (Code: MASALA-TURMERIC-POWDER-SHEET-TURMERIC-POWDER-SHEET-10RS) with opening stock 0', '152.57.128.120', '2026-08-02 15:41:57'),
(837, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 480 units to SKU APPALAM.', '152.57.128.120', '2026-08-02 15:45:29');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `ip_address`, `created_at`) VALUES
(838, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 1000 units to SKU GINGER GARLIC PASTE 5RS.', '152.57.128.120', '2026-08-02 15:45:29'),
(839, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 4 units to SKU TURMERIC POWDER 5KG.', '152.57.128.120', '2026-08-02 15:45:29'),
(840, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 50 units to SKU TURMERIC POWDER SHEET 10RS.', '152.57.128.120', '2026-08-02 15:45:29'),
(841, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹367.50 to VINAYAKA SALES AND PERFUMARY', '152.57.128.120', '2026-08-02 15:47:29'),
(842, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 15:48:34'),
(843, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 15:48:34'),
(844, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 15:48:34'),
(845, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '152.57.128.120', '2026-08-02 15:48:34'),
(846, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '152.57.128.120', '2026-08-02 15:48:34'),
(847, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 240 units to SKU APPALAM.', '152.57.128.120', '2026-08-02 15:48:34'),
(848, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹28302.24 to SHREE KRISHNA FOODS PVT LTD', '152.57.128.120', '2026-08-02 15:49:00'),
(849, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹16636.62 to SHREE KRISHNA FOODS PVT LTD', '152.57.128.120', '2026-08-02 15:49:10'),
(850, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹27538.44 to SHREE KRISHNA FOODS PVT LTD', '152.57.128.120', '2026-08-02 15:49:15'),
(851, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹6723.36 to VINAYAKA SALES AND PERFUMARY', '152.57.128.120', '2026-08-02 15:49:22'),
(852, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹27113.85 to SHREE KRISHNA FOODS PVT LTD', '152.57.128.120', '2026-08-02 15:49:28'),
(853, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹9844.38 to SHREE KRISHNA FOODS PVT LTD', '152.57.128.120', '2026-08-02 15:49:38'),
(854, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹5716.80 to SHREE KRISHNA FOODS PVT LTD', '152.57.128.120', '2026-08-02 15:49:43'),
(855, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹525.00 to VINAYAKA SALES AND PERFUMARY', '152.57.128.120', '2026-08-02 15:49:50'),
(856, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹997.50 to VINAYAKA SALES AND PERFUMARY', '152.57.128.120', '2026-08-02 15:49:56'),
(857, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹9844.38 to SHREE KRISHNA FOODS PVT LTD', '152.57.128.120', '2026-08-02 15:50:03'),
(858, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹23158.30 to VINAYAKA SALES AND PERFUMARY', '152.57.128.120', '2026-08-02 15:50:08'),
(859, 1, 'Deleted Supplier Payment', 'Deleted payment of ₹9529.38 to SHREE KRISHNA FOODS PVT LTD', '152.57.128.120', '2026-08-02 15:50:14'),
(860, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 480 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS.', '152.57.128.120', '2026-08-02 15:50:46'),
(861, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP GUGGAL.', '152.57.128.120', '2026-08-02 15:50:46'),
(862, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP SAMBRANI.', '152.57.128.120', '2026-08-02 15:50:46'),
(863, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP MANGAL.', '152.57.128.120', '2026-08-02 15:50:46'),
(864, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 480 units to SKU APPALAM.', '152.57.128.120', '2026-08-02 15:50:56'),
(865, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 1000 units to SKU GINGER GARLIC PASTE 5RS.', '152.57.128.120', '2026-08-02 15:50:56'),
(866, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 4 units to SKU TURMERIC POWDER 5KG.', '152.57.128.120', '2026-08-02 15:50:56'),
(867, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 50 units to SKU TURMERIC POWDER SHEET 10RS.', '152.57.128.120', '2026-08-02 15:50:56'),
(868, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.128.120', '2026-08-02 15:51:31'),
(869, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS.', '152.57.128.120', '2026-08-02 15:51:31'),
(870, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA KASTURI ZIPPER PACK.', '152.57.128.120', '2026-08-02 15:51:31'),
(871, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DIAMOND ZIPPER PACK.', '152.57.128.120', '2026-08-02 15:51:31'),
(872, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA HEENA ZIPPER PACKS.', '152.57.128.120', '2026-08-02 15:51:31'),
(873, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DREAMS ZIPPER PACKS.', '152.57.128.120', '2026-08-02 15:51:31'),
(874, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BOLENATH ZIPPER PACKS.', '152.57.128.120', '2026-08-02 15:51:31'),
(875, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BRUTS ZIPPER PACKS.', '152.57.128.120', '2026-08-02 15:51:31'),
(876, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 960 units to SKU VINAYAKA REGULAR POUCH MIX.', '152.57.128.120', '2026-08-02 15:51:31'),
(877, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 300 units to SKU VINAYAKA GOOD MORNING ECONOMY.', '152.57.128.120', '2026-08-02 15:51:31'),
(878, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 180 units to SKU VINAYAKA BLACK FANTASY 60G.', '152.57.128.120', '2026-08-02 15:51:31'),
(879, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 180 units to SKU VINAYAKA WILD PURPLE 60G.', '152.57.128.120', '2026-08-02 15:51:31'),
(880, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 15:51:49'),
(881, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 15:51:49'),
(882, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '152.57.128.120', '2026-08-02 15:51:49'),
(883, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '152.57.128.120', '2026-08-02 15:51:49'),
(884, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '152.57.128.120', '2026-08-02 15:51:49'),
(885, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 240 units to SKU APPALAM.', '152.57.128.120', '2026-08-02 15:51:49'),
(886, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2052:e094:8000::', '2026-08-02 17:23:23'),
(887, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2052:e094:8000::', '2026-08-02 17:27:51'),
(888, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:2052:e094:8000::', '2026-08-02 17:28:40'),
(889, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2052:e094:8000::', '2026-08-02 17:28:53'),
(890, 1, 'Update SKU', 'Updated SKU ID: 41 (TURMERIC POWDER 5KG)', '2409:40f2:2052:e094:8000::', '2026-08-02 17:32:14'),
(891, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.119.159', '2026-08-03 05:00:38'),
(892, 1, 'Create Retailer', 'Created retailer SHRI REVENSIDDESHWAR TRADERS (Owner: )', '152.57.119.159', '2026-08-03 05:03:36'),
(893, 1, 'Create Retailer', 'Created retailer G V PATIL (Owner: )', '152.57.119.159', '2026-08-03 05:05:19'),
(894, 1, 'Create Retailer', 'Created retailer SHRIDHAR GENERAL STORES (Owner: )', '152.57.119.159', '2026-08-03 05:08:04'),
(895, 1, 'Create Retailer', 'Created retailer IRSHAD GENERAL STORES (Owner: )', '152.57.119.159', '2026-08-03 05:10:38'),
(896, 1, 'Create Retailer', 'Created retailer SAMIVOOLA GENERAL STORES (Owner: )', '152.57.119.159', '2026-08-03 05:13:00'),
(897, 1, 'Create Retailer', 'Created retailer SAJIYA GENERAL STORES (Owner: )', '152.57.119.159', '2026-08-03 05:14:36'),
(898, 1, 'Remove Schedule', 'Removed schedule entry ID: 11', '152.57.119.159', '2026-08-03 05:26:29'),
(899, 1, 'Remove Schedule', 'Removed schedule entry ID: 13', '152.57.119.159', '2026-08-03 05:26:39'),
(900, 1, 'Remove Schedule', 'Removed schedule entry ID: 14', '152.57.119.159', '2026-08-03 05:26:43'),
(901, 1, 'Schedule Route', 'Scheduled route ID 5 on Monday', '152.57.119.159', '2026-08-03 05:26:51'),
(902, 1, 'Update Route', 'Updated route ID: 4 with name Mahantesh Nagar, Autonagar,Kanbargi and assigned retailers.', '152.57.119.159', '2026-08-03 05:27:04'),
(903, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1d:6f96:8000::', '2026-08-03 05:27:41'),
(904, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.119.159', '2026-08-03 05:31:34'),
(905, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS.', '152.57.119.159', '2026-08-03 05:31:34'),
(906, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA KASTURI ZIPPER PACK.', '152.57.119.159', '2026-08-03 05:31:34'),
(907, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DIAMOND ZIPPER PACK.', '152.57.119.159', '2026-08-03 05:31:34'),
(908, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA HEENA ZIPPER PACKS.', '152.57.119.159', '2026-08-03 05:31:34'),
(909, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DREAMS ZIPPER PACKS.', '152.57.119.159', '2026-08-03 05:31:34'),
(910, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BOLENATH ZIPPER PACKS.', '152.57.119.159', '2026-08-03 05:31:34'),
(911, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BRUTS ZIPPER PACKS.', '152.57.119.159', '2026-08-03 05:31:34'),
(912, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 960 units to SKU VINAYAKA REGULAR POUCH MIX.', '152.57.119.159', '2026-08-03 05:31:34'),
(913, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 300 units to SKU VINAYAKA GOOD MORNING ECONOMY.', '152.57.119.159', '2026-08-03 05:31:34'),
(914, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 180 units to SKU VINAYAKA BLACK FANTASY 60G.', '152.57.119.159', '2026-08-03 05:31:34'),
(915, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 180 units to SKU VINAYAKA WILD PURPLE 60G.', '152.57.119.159', '2026-08-03 05:31:34'),
(916, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 45 units to SKU VINAYAKA ONE PLUS ZIPPER PACKS.', '152.57.119.159', '2026-08-03 05:31:34'),
(917, 15, 'Create Order', 'Staff created Order ID: 37 for Retailer ID: 39. Grand Total: 959.616', '2409:40f2:1d:6f96:8000::', '2026-08-03 05:34:04'),
(918, 15, 'Create Order', 'Staff created Order ID: 38 for Retailer ID: 41. Grand Total: 1139.292', '2409:40f2:1d:6f96:8000::', '2026-08-03 05:36:50'),
(919, 15, 'Create Order', 'Staff created Order ID: 39 for Retailer ID: 42. Grand Total: 239.904', '2409:40f2:1d:6f96:8000::', '2026-08-03 05:37:41'),
(920, 15, 'Create Order', 'Staff created Order ID: 40 for Retailer ID: 43. Grand Total: 179.676', '2409:40f2:1d:6f96:8000::', '2026-08-03 05:38:51'),
(921, 15, 'Create Order', 'Staff created Order ID: 41 for Retailer ID: 44. Grand Total: 179.676', '2409:40f2:1d:6f96:8000::', '2026-08-03 05:40:07'),
(922, 15, 'Create Order', 'Staff created Order ID: 42 for Retailer ID: 45. Grand Total: 959.616', '2409:40f2:1d:6f96:8000::', '2026-08-03 05:40:51'),
(923, 15, 'Create Order', 'Staff created Order ID: 43 for Retailer ID: 46. Grand Total: 1139.292', '2409:40f2:1d:6f96:8000::', '2026-08-03 05:42:11'),
(924, 1, 'Update Order Status', 'Owner updated Order ID: 37 to Status: Approved', '152.57.119.159', '2026-08-03 05:44:55'),
(925, 1, 'Generate Invoice', 'Invoiced Order ID: 37 -> Invoice No: NE/2026-27/0031. Grand Total: 959.62', '152.57.119.159', '2026-08-03 05:45:18'),
(926, 1, 'Update Order Status', 'Owner updated Order ID: 38 to Status: Approved', '152.57.119.159', '2026-08-03 05:56:19'),
(927, 1, 'Generate Invoice', 'Invoiced Order ID: 38 -> Invoice No: NE/2026-27/0032. Grand Total: 1139.29', '152.57.119.159', '2026-08-03 05:56:28'),
(928, 1, 'Update Order Status', 'Owner updated Order ID: 39 to Status: Approved', '152.57.119.159', '2026-08-03 05:56:56'),
(929, 1, 'Generate Invoice', 'Invoiced Order ID: 39 -> Invoice No: NE/2026-27/0033. Grand Total: 239.9', '152.57.119.159', '2026-08-03 05:57:05'),
(930, 1, 'Update Order Status', 'Owner updated Order ID: 40 to Status: Approved', '152.57.119.159', '2026-08-03 05:57:24'),
(931, 1, 'Generate Invoice', 'Invoiced Order ID: 40 -> Invoice No: NE/2026-27/0034. Grand Total: 179.68', '152.57.119.159', '2026-08-03 05:57:48'),
(932, 1, 'Update Order Status', 'Owner updated Order ID: 41 to Status: Approved', '152.57.119.159', '2026-08-03 05:58:13'),
(933, 1, 'Generate Invoice', 'Invoiced Order ID: 41 -> Invoice No: NE/2026-27/0035. Grand Total: 179.68', '152.57.119.159', '2026-08-03 05:58:22'),
(934, 1, 'Update Order Status', 'Owner updated Order ID: 42 to Status: Approved', '152.57.119.159', '2026-08-03 05:58:45'),
(935, 1, 'Generate Invoice', 'Invoiced Order ID: 42 -> Invoice No: NE/2026-27/0036. Grand Total: 959.62', '152.57.119.159', '2026-08-03 05:59:04'),
(936, 1, 'Update Order Status', 'Owner updated Order ID: 43 to Status: Approved', '152.57.119.159', '2026-08-03 05:59:20'),
(937, 1, 'Generate Invoice', 'Invoiced Order ID: 43 -> Invoice No: NE/2026-27/0037. Grand Total: 1139.29', '152.57.119.159', '2026-08-03 05:59:30'),
(938, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:129:6ac8:8000::', '2026-08-04 02:15:53'),
(939, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-07-01 To: 2026-07-31)', '2409:40f2:129:6ac8:8000::', '2026-08-04 02:16:37'),
(940, 1, 'Export Report', 'Exported GST Purchases (Inward) CSV (From: 2026-07-01 To: 2026-07-31)', '2409:40f2:129:6ac8:8000::', '2026-08-04 02:17:26'),
(941, 1, 'Export Report', 'Exported GST Expenses (Inward) CSV (From: 2026-07-01 To: 2026-07-31)', '2409:40f2:129:6ac8:8000::', '2026-08-04 02:17:40'),
(942, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:3041:fb6c:8000::', '2026-08-04 05:56:28'),
(943, 1, 'Create Retailer', 'Created retailer CHOPADE STORES (Owner: )', '2409:40f2:3041:fb6c:8000::', '2026-08-04 05:57:59'),
(944, 1, 'Create Route', 'Created route: GANESHPUR HINDALGA with assigned retailers.', '2409:40f2:3041:fb6c:8000::', '2026-08-04 05:59:17'),
(945, 1, 'Schedule Route', 'Scheduled route ID 6 on Tuesday', '2409:40f2:3041:fb6c:8000::', '2026-08-04 06:01:36'),
(946, 1, 'Update Route', 'Updated route ID: 6 with name GANESHPUR HINDALGA and assigned retailers.', '2409:40f2:3041:fb6c:8000::', '2026-08-04 06:01:41'),
(947, 1, 'Update Staff Account', 'Updated details for staff ID: 15 (SHREYANSH)', '2409:40f2:3041:fb6c:8000::', '2026-08-04 06:02:01'),
(948, 1, 'Update Route', 'Updated route ID: 6 with name GANESHPUR HINDALGA and assigned retailers.', '2409:40f2:3041:fb6c:8000::', '2026-08-04 06:02:14'),
(949, 1, 'Update Retailer', 'Updated retailer profile: CHOPADE STORES (ID: 47)', '2409:40f2:3041:fb6c:8000::', '2026-08-04 06:02:41'),
(950, 1, 'Create Retailer', 'Created retailer Shridhar General store (Owner: )', '2409:40f2:104a:e13:8000::', '2026-08-04 09:05:53'),
(951, 1, 'Create Retailer', 'Created retailer SUNIL GENERAL STORES (Owner: )', '2409:40f2:104a:e13:8000::', '2026-08-04 09:06:53'),
(952, 1, 'Create Retailer', 'Created retailer KRISHNA GENERAL STORES (Owner: )', '2409:40f2:104a:e13:8000::', '2026-08-04 09:08:53'),
(953, 1, 'Create Retailer', 'Created retailer SHRI JYOTIRLING GENERAL STORES (Owner: )', '2409:40f2:104a:e13:8000::', '2026-08-04 09:12:32'),
(954, 1, 'Update SKU', 'Updated SKU ID: 40 (GINGER GARLIC PASTE 5RS)', '2409:40f2:104a:e13:8000::', '2026-08-04 09:27:50'),
(955, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '2409:40f2:104a:e13:8000::', '2026-08-04 09:35:20'),
(956, 1, 'Delete Discount', 'Deleted discount ID: 6', '2409:40f2:104a:e13:8000::', '2026-08-04 09:35:28'),
(957, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '2409:40f2:104a:e13:8000::', '2026-08-04 09:37:36'),
(958, 1, 'Delete Discount', 'Deleted discount ID: 8', '2409:40f2:104a:e13:8000::', '2026-08-04 09:37:40'),
(959, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:104a:e13:8000::', '2026-08-04 09:38:37'),
(960, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:104a:e13:8000::', '2026-08-04 09:39:01'),
(961, 15, 'Create Order', 'Staff created Order ID: 44 for Retailer ID: 47. Grand Total: 616.538', '2409:40f2:104a:e13:8000::', '2026-08-04 09:44:20'),
(962, 15, 'Create Order', 'Staff created Order ID: 45 for Retailer ID: 48. Grand Total: 130', '2409:40f2:104a:e13:8000::', '2026-08-04 09:44:58'),
(963, 15, 'Create Order', 'Staff created Order ID: 46 for Retailer ID: 49. Grand Total: 459.458', '2409:40f2:104a:e13:8000::', '2026-08-04 09:52:30'),
(964, 15, 'Create Order', 'Staff created Order ID: 47 for Retailer ID: 50. Grand Total: 688.938', '2409:40f2:104a:e13:8000::', '2026-08-04 09:56:01'),
(965, 15, 'Create Order', 'Staff created Order ID: 48 for Retailer ID: 51. Grand Total: 844.651', '2409:40f2:104a:e13:8000::', '2026-08-04 09:58:00'),
(966, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:104a:e13:8000::', '2026-08-04 09:58:32'),
(967, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.40.26', '2026-08-04 11:28:37'),
(968, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.40.26', '2026-08-04 11:28:37'),
(969, 1, 'Update Order Status', 'Owner updated Order ID: 44 to Status: Approved', '152.57.40.26', '2026-08-04 11:29:14'),
(970, 1, 'Generate Invoice', 'Invoiced Order ID: 44 -> Invoice No: NE/2026-27/0038. Grand Total: 616.54', '152.57.40.26', '2026-08-04 11:30:51'),
(971, 1, 'Update Order Status', 'Owner updated Order ID: 45 to Status: Approved', '152.57.40.26', '2026-08-04 11:32:20'),
(972, 1, 'Generate Invoice', 'Invoiced Order ID: 45 -> Invoice No: NE/2026-27/0039. Grand Total: 130', '152.57.40.26', '2026-08-04 11:32:30'),
(973, 1, 'Update Order Status', 'Owner updated Order ID: 46 to Status: Approved', '152.57.40.26', '2026-08-04 11:33:15'),
(974, 1, 'Generate Invoice', 'Invoiced Order ID: 46 -> Invoice No: NE/2026-27/0040. Grand Total: 459.46', '152.57.40.26', '2026-08-04 11:33:22'),
(975, 1, 'Update Order Status', 'Owner updated Order ID: 47 to Status: Approved', '152.57.40.26', '2026-08-04 11:34:22'),
(976, 1, 'Generate Invoice', 'Invoiced Order ID: 47 -> Invoice No: NE/2026-27/0041. Grand Total: 688.94', '152.57.40.26', '2026-08-04 11:34:32'),
(977, 1, 'Update Order Status', 'Owner updated Order ID: 48 to Status: Approved', '152.57.40.26', '2026-08-04 11:36:44'),
(978, 1, 'Generate Invoice', 'Invoiced Order ID: 48 -> Invoice No: NE/2026-27/0042. Grand Total: 844.65', '152.57.40.26', '2026-08-04 11:36:52'),
(979, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:104a:e13:8000::', '2026-08-04 13:29:45'),
(980, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:104a:e13:8000::', '2026-08-04 13:31:38'),
(981, 15, 'Collect Payment', 'Recorded payment of ₹689.00 from Retailer ID: 50 using Method: Cash', '2409:40f2:104a:e13:8000::', '2026-08-04 13:32:17'),
(982, 15, 'Collect Payment', 'Recorded payment of ₹616.54 from Retailer ID: 47 using Method: Cash', '2409:40f2:104a:e13:8000::', '2026-08-04 13:32:43'),
(983, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 03:53:29'),
(984, 15, 'Collect Payment', 'Recorded payment of ₹1,008.00 from Retailer ID: 29 using Method: Cash', '2409:40f2:341:560:8000::', '2026-08-05 03:54:36'),
(985, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:341:560:8000::', '2026-08-05 03:56:34'),
(986, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 03:56:46'),
(987, 1, 'Update Retailer', 'Updated retailer profile: SHRI NEELAMBARI KIRANA AND GENERAL STORE (ID: 8)', '2409:40f2:341:560:8000::', '2026-08-05 03:57:51'),
(988, 1, 'Update Retailer', 'Updated retailer profile: GURUPRASAD KIRANA STORE (ID: 9)', '2409:40f2:341:560:8000::', '2026-08-05 03:58:06'),
(989, 1, 'Update Retailer', 'Updated retailer profile: DURGA GENERAL STORES (ID: 12)', '2409:40f2:341:560:8000::', '2026-08-05 03:58:24'),
(990, 1, 'Update Retailer', 'Updated retailer profile: MAHAKALI GENRAL STORES (ID: 15)', '2409:40f2:341:560:8000::', '2026-08-05 03:58:36'),
(991, 1, 'Update Retailer', 'Updated retailer profile: MAHALAXMI GENERAL STORES (ID: 17)', '2409:40f2:341:560:8000::', '2026-08-05 03:58:50'),
(992, 1, 'Update Retailer', 'Updated retailer profile: VEERA BHADRESHWAR ENTERPRISE (ID: 18)', '2409:40f2:341:560:8000::', '2026-08-05 03:58:59'),
(993, 1, 'Update Retailer', 'Updated retailer profile: SIDDHAROODHA KIRANA STORE (ID: 16)', '2409:40f2:341:560:8000::', '2026-08-05 04:00:10'),
(994, 1, 'Schedule Route', 'Scheduled route ID 2 on Friday', '2409:40f2:341:560:8000::', '2026-08-05 04:03:15'),
(995, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:341:560:8000::', '2026-08-05 04:06:37'),
(996, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 04:07:01'),
(997, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 04:07:01'),
(998, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 04:07:01'),
(999, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 04:50:20'),
(1000, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:341:560:8000::', '2026-08-05 05:00:12'),
(1001, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 05:00:24'),
(1002, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:341:560:8000::', '2026-08-05 05:41:33'),
(1003, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 05:41:53'),
(1004, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 05:41:53'),
(1005, 1, 'Update Retailer', 'Updated retailer profile: HARSH ENTERPRISE (ID: 13)', '2409:40f2:341:560:8000::', '2026-08-05 05:42:17'),
(1006, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:341:560:8000::', '2026-08-05 05:43:25'),
(1007, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 05:43:36'),
(1008, 15, 'Create Order', 'Staff created Order ID: 49 for Retailer ID: 8. Grand Total: 549.99', '2409:40f2:341:560:8000::', '2026-08-05 05:51:05'),
(1009, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:341:560:8000::', '2026-08-05 08:03:34'),
(1010, 15, 'Create Order', 'Staff created Order ID: 50 for Retailer ID: 17. Grand Total: 959.616', '2409:40f2:341:560:8000::', '2026-08-05 08:08:13'),
(1011, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.173.158', '2026-08-05 12:04:23'),
(1012, 1, 'Update Order Status', 'Owner updated Order ID: 49 to Status: Approved', '157.50.173.158', '2026-08-05 12:05:01'),
(1013, 1, 'Generate Invoice', 'Invoiced Order ID: 49 -> Invoice No: NE/2026-27/0043. Grand Total: 549.99', '157.50.173.158', '2026-08-05 12:05:14'),
(1014, 1, 'Update Order Status', 'Owner updated Order ID: 50 to Status: Approved', '157.50.173.158', '2026-08-05 12:06:09'),
(1015, 1, 'Generate Invoice', 'Invoiced Order ID: 50 -> Invoice No: NE/2026-27/0044. Grand Total: 959.62', '157.50.173.158', '2026-08-05 12:06:18'),
(1016, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2048:1861:8000::', '2026-08-05 12:24:01'),
(1017, 15, 'Collect Payment', 'Recorded payment of ₹717.00 from Retailer ID: 13 using Method: UPI', '2409:40f2:2048:1861:8000::', '2026-08-05 12:24:41'),
(1018, 15, 'Collect Payment', 'Recorded payment of ₹1,197.00 from Retailer ID: 17 using Method: Cash', '2409:40f2:2048:1861:8000::', '2026-08-05 12:25:07'),
(1019, 15, 'Expiry Collection', 'Collected 6 units of SKU ID 21 from Retailer ID 13. Value: ₹228.48', '2409:40f2:2048:1861:8000::', '2026-08-05 12:25:50'),
(1020, 15, 'Expiry Collection', 'Collected 6 units of SKU ID 22 from Retailer ID 13. Value: ₹228.48', '2409:40f2:2048:1861:8000::', '2026-08-05 12:26:21'),
(1021, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:46:8c7f:8000::', '2026-08-06 05:59:08'),
(1022, 15, 'Create Order', 'Staff created Order ID: 51 for Retailer ID: 24. Grand Total: 549.99', '2409:40f2:46:8c7f:8000::', '2026-08-06 06:32:15'),
(1023, 15, 'Create Order', 'Staff created Order ID: 52 for Retailer ID: 25. Grand Total: 3693.123', '2409:40f2:46:8c7f:8000::', '2026-08-06 06:40:49'),
(1024, 15, 'Create Order', 'Staff created Order ID: 53 for Retailer ID: 26. Grand Total: 959.616', '2409:40f2:46:8c7f:8000::', '2026-08-06 06:46:11'),
(1025, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.106.247', '2026-08-06 08:04:49'),
(1026, 1, 'Update SKU', 'Updated SKU ID: 36 (VINAYAKA ONE PLUS ZIPPER PACKS)', '152.57.106.247', '2026-08-06 08:08:27'),
(1027, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:46:8c7f:8000::', '2026-08-06 08:08:49'),
(1028, 15, 'Create Order', 'Staff created Order ID: 54 for Retailer ID: 19. Grand Total: 479.808', '2409:40f2:46:8c7f:8000::', '2026-08-06 08:09:51'),
(1029, 15, 'Create Order', 'Staff created Order ID: 55 for Retailer ID: 20. Grand Total: 1274.175', '2409:40f2:46:8c7f:8000::', '2026-08-06 08:11:41'),
(1030, 1, 'Update SKU', 'Updated SKU ID: 36 (VINAYAKA ONE PLUS ZIPPER PACKS)', '152.57.106.247', '2026-08-06 08:13:57'),
(1031, 1, 'Create Retailer', 'Created retailer P L KAWALE (Owner: )', '152.57.106.247', '2026-08-06 08:16:59'),
(1032, 1, 'Create Retailer', 'Created retailer V B SIDDANNAVAR (Owner: )', '152.57.106.247', '2026-08-06 08:19:20'),
(1033, 1, 'Create Retailer', 'Created retailer PRAVEEN PAWAR COCONUT (Owner: )', '152.57.106.247', '2026-08-06 08:20:45'),
(1034, 1, 'Create Retailer', 'Created retailer R M ANGOLKAR (Owner: )', '152.57.106.247', '2026-08-06 08:22:36'),
(1035, 15, 'Create Order', 'Staff created Order ID: 56 for Retailer ID: 52. Grand Total: 5488.434', '2409:40f2:46:8c7f:8000::', '2026-08-06 08:39:40'),
(1036, 15, 'Create Order', 'Staff created Order ID: 57 for Retailer ID: 54. Grand Total: 479.808', '2409:40f2:46:8c7f:8000::', '2026-08-06 08:40:41'),
(1037, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 32', '152.57.106.247', '2026-08-06 08:44:05'),
(1038, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 31', '152.57.106.247', '2026-08-06 08:44:19'),
(1039, 15, 'Create Order', 'Staff created Order ID: 58 for Retailer ID: 53. Grand Total: 5268.312', '2409:40f2:46:8c7f:8000::', '2026-08-06 08:50:21'),
(1040, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 33', '152.57.106.247', '2026-08-06 08:52:43'),
(1041, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 25', '152.57.106.247', '2026-08-06 08:53:09'),
(1042, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 23', '152.57.106.247', '2026-08-06 08:53:46'),
(1043, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 18', '152.57.106.247', '2026-08-06 08:54:23'),
(1044, 15, 'Create Order', 'Staff created Order ID: 59 for Retailer ID: 55. Grand Total: 2860.2', '2409:40f2:46:8c7f:8000::', '2026-08-06 08:57:21'),
(1045, 1, 'Update Order Status', 'Owner updated Order ID: 51 to Status: Approved', '152.57.106.247', '2026-08-06 09:16:30'),
(1046, 1, 'Generate Invoice', 'Invoiced Order ID: 51 -> Invoice No: NE/2026-27/0045. Grand Total: 549.99', '152.57.106.247', '2026-08-06 09:16:42'),
(1047, 1, 'Update Order Status', 'Owner updated Order ID: 52 to Status: Approved', '152.57.106.247', '2026-08-06 09:18:22'),
(1048, 1, 'Generate Invoice', 'Invoiced Order ID: 52 -> Invoice No: NE/2026-27/0046. Grand Total: 3693.12', '152.57.106.247', '2026-08-06 09:18:32'),
(1049, 1, 'Update Order Status', 'Owner updated Order ID: 53 to Status: Approved', '152.57.106.247', '2026-08-06 09:19:32'),
(1050, 1, 'Generate Invoice', 'Invoiced Order ID: 53 -> Invoice No: NE/2026-27/0047. Grand Total: 959.62', '152.57.106.247', '2026-08-06 09:19:45'),
(1051, 1, 'Update Order Status', 'Owner updated Order ID: 54 to Status: Approved', '152.57.106.247', '2026-08-06 09:20:26'),
(1052, 1, 'Generate Invoice', 'Invoiced Order ID: 54 -> Invoice No: NE/2026-27/0048. Grand Total: 479.81', '152.57.106.247', '2026-08-06 09:20:50'),
(1053, 1, 'Update Order Status', 'Owner updated Order ID: 55 to Status: Approved', '152.57.106.247', '2026-08-06 09:21:20'),
(1054, 1, 'Generate Invoice', 'Invoiced Order ID: 55 -> Invoice No: NE/2026-27/0049. Grand Total: 1274.18', '152.57.106.247', '2026-08-06 09:21:30'),
(1055, 1, 'Update Order Status', 'Owner updated Order ID: 56 to Status: Approved', '152.57.106.247', '2026-08-06 09:22:10'),
(1056, 1, 'Generate Invoice', 'Invoiced Order ID: 56 -> Invoice No: NE/2026-27/0050. Grand Total: 5488.43', '152.57.106.247', '2026-08-06 09:22:20'),
(1057, 1, 'Update Order Status', 'Owner updated Order ID: 57 to Status: Approved', '152.57.106.247', '2026-08-06 09:26:08'),
(1058, 1, 'Generate Invoice', 'Invoiced Order ID: 57 -> Invoice No: NE/2026-27/0051. Grand Total: 479.81', '152.57.106.247', '2026-08-06 09:26:15'),
(1059, 1, 'Update Order Status', 'Owner updated Order ID: 58 to Status: Approved', '152.57.106.247', '2026-08-06 09:26:47'),
(1060, 1, 'Generate Invoice', 'Invoiced Order ID: 58 -> Invoice No: NE/2026-27/0052. Grand Total: 5268.31', '152.57.106.247', '2026-08-06 09:27:14'),
(1061, 1, 'Update Order Status', 'Owner updated Order ID: 59 to Status: Approved', '152.57.106.247', '2026-08-06 09:28:01'),
(1062, 1, 'Generate Invoice', 'Invoiced Order ID: 59 -> Invoice No: NE/2026-27/0053. Grand Total: 2860.2', '152.57.106.247', '2026-08-06 09:28:17'),
(1063, 1, 'Export Report', 'Exported Collections CSV Report (From: 2026-08-01 To: 2026-08-06)', '152.57.106.247', '2026-08-06 09:29:32'),
(1064, 1, 'Delete Discount', 'Deleted discount ID: 19', '152.57.106.247', '2026-08-06 09:30:33'),
(1065, 1, 'Delete Discount', 'Deleted discount ID: 16', '152.57.106.247', '2026-08-06 09:30:53'),
(1066, 1, 'Delete Discount', 'Deleted discount ID: 17', '152.57.106.247', '2026-08-06 09:31:17'),
(1067, 1, 'Delete Discount', 'Deleted discount ID: 18', '152.57.106.247', '2026-08-06 09:31:26'),
(1068, 1, 'Delete Discount', 'Deleted discount ID: 14', '152.57.106.247', '2026-08-06 09:32:05'),
(1069, 1, 'Delete Discount', 'Deleted discount ID: 15', '152.57.106.247', '2026-08-06 09:32:12'),
(1070, 1, 'Export Report', 'Exported Retailer Outstandings CSV Report', '152.57.106.247', '2026-08-06 09:36:50'),
(1071, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.106.247', '2026-08-06 09:39:04'),
(1072, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:204d:f208:8000::', '2026-08-07 08:21:00'),
(1073, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1047:4810:8000::', '2026-08-07 10:55:47'),
(1074, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2f:3148:8000::', '2026-08-08 04:50:01'),
(1075, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2f:3148:8000::', '2026-08-08 08:36:07'),
(1076, 1, 'Collect Payment', 'Recorded payment of ₹314.15 from Retailer ID: 38 using Method: Cash', '2409:40f2:2f:3148:8000::', '2026-08-08 08:36:42'),
(1077, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.203.19', '2026-08-09 15:50:43'),
(1078, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:307:c1d1:8000::', '2026-08-10 07:16:14'),
(1079, 15, 'Collect Payment', 'Recorded payment of ₹239.90 from Retailer ID: 42 using Method: Cash', '2409:40f2:307:c1d1:8000::', '2026-08-10 07:16:31'),
(1080, 15, 'Collect Payment', 'Recorded payment of ₹100.00 from Retailer ID: 39 using Method: Cash', '2409:40f2:307:c1d1:8000::', '2026-08-10 07:16:52'),
(1081, 15, 'Collect Payment', 'Recorded payment of ₹500.00 from Retailer ID: 41 using Method: Cash', '2409:40f2:307:c1d1:8000::', '2026-08-10 08:04:35'),
(1082, 15, 'Collect Payment', 'Recorded payment of ₹180.00 from Retailer ID: 44 using Method: Cash', '2409:40f2:307:c1d1:8000::', '2026-08-10 08:06:08'),
(1083, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.165.67', '2026-08-11 03:21:17'),
(1084, 1, 'Create Retailer', 'Created retailer SIDDHI VINAYAKA GENERAL STORES (Owner: )', '157.50.165.67', '2026-08-11 03:24:17'),
(1085, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 34', '157.50.167.85', '2026-08-11 03:57:31'),
(1086, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 16', '157.50.163.80', '2026-08-11 04:21:06'),
(1087, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 16', '157.50.163.80', '2026-08-11 04:21:06'),
(1088, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 16', '157.50.163.80', '2026-08-11 04:21:06'),
(1089, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 16', '157.50.163.80', '2026-08-11 04:21:06'),
(1090, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 16', '157.50.163.80', '2026-08-11 04:21:06'),
(1091, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 16', '157.50.163.80', '2026-08-11 04:21:06'),
(1092, 1, 'Delete Discount', 'Deleted discount ID: 26', '157.50.163.80', '2026-08-11 04:21:14'),
(1093, 1, 'Delete Discount', 'Deleted discount ID: 25', '157.50.163.80', '2026-08-11 04:21:22'),
(1094, 1, 'Delete Discount', 'Deleted discount ID: 25', '157.50.163.80', '2026-08-11 04:21:26'),
(1095, 1, 'Delete Discount', 'Deleted discount ID: 24', '157.50.163.80', '2026-08-11 04:21:31'),
(1096, 1, 'Delete Discount', 'Deleted discount ID: 22', '157.50.163.80', '2026-08-11 04:21:38'),
(1097, 1, 'Delete Discount', 'Deleted discount ID: 23', '157.50.163.80', '2026-08-11 04:21:44'),
(1098, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2133:177c:8000::', '2026-08-11 04:22:23'),
(1099, 15, 'Create Order', 'Staff created Order ID: 60 for Retailer ID: 56. Grand Total: 2722.8995', '2409:40f2:2133:177c:8000::', '2026-08-11 04:24:48'),
(1100, 1, 'Update Order Status', 'Owner updated Order ID: 60 to Status: Approved', '157.50.163.80', '2026-08-11 04:25:49'),
(1101, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '157.50.163.80', '2026-08-11 04:31:55'),
(1102, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '157.50.163.80', '2026-08-11 04:31:55'),
(1103, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '157.50.163.80', '2026-08-11 04:31:55'),
(1104, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 300 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '157.50.163.80', '2026-08-11 04:31:55'),
(1105, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '157.50.163.80', '2026-08-11 04:31:55'),
(1106, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 240 units to SKU APPALAM.', '157.50.163.80', '2026-08-11 04:31:55'),
(1107, 1, 'Generate Invoice', 'Invoiced Order ID: 60 -> Invoice No: NE/2026-27/0054. Grand Total: 2722.9', '157.50.163.80', '2026-08-11 04:32:27'),
(1108, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 60 units to SKU SHRI KRISHNA 200 ML JAR COW GHEE.', '157.50.163.80', '2026-08-11 04:35:51'),
(1109, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 100ML JAR COW GHEE.', '157.50.163.80', '2026-08-11 04:35:51'),
(1110, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 80 units to SKU SHRI KRISHNA 50ML JAR COW GHEE.', '157.50.163.80', '2026-08-11 04:35:51'),
(1111, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 200 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE.', '157.50.163.80', '2026-08-11 04:35:51'),
(1112, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 100 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE.', '157.50.163.80', '2026-08-11 04:35:51'),
(1113, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 240 units to SKU APPALAM.', '157.50.163.80', '2026-08-11 04:35:51'),
(1114, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2133:177c:8000::', '2026-08-11 07:32:52'),
(1115, 15, 'Collect Payment', 'Recorded payment of ₹200.00 from Retailer ID: 49 using Method: Cash', '2409:40f2:2133:177c:8000::', '2026-08-11 07:33:20'),
(1116, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.117.140', '2026-08-11 09:58:23'),
(1117, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:102a:253e:8000::', '2026-08-11 14:08:00'),
(1118, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1039:e24b:8000::', '2026-08-12 11:19:13'),
(1119, 1, 'Collect Payment', 'Recorded payment of ₹3,000.00 from Retailer ID: 40 using Method: Cheque', '2409:40f2:1039:e24b:8000::', '2026-08-12 11:22:27'),
(1120, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:12c:7b8b:8000::', '2026-08-13 12:23:38'),
(1121, 15, 'Collect Payment', 'Recorded payment of ₹350.00 from Retailer ID: 23 using Method: Cash', '2409:40f2:12c:7b8b:8000::', '2026-08-13 12:24:42'),
(1122, 15, 'Collect Payment', 'Recorded payment of ₹500.00 from Retailer ID: 22 using Method: UPI', '2409:40f2:12c:7b8b:8000::', '2026-08-13 12:25:01'),
(1123, 15, 'Collect Payment', 'Recorded payment of ₹193.00 from Retailer ID: 22 using Method: Cash', '2409:40f2:12c:7b8b:8000::', '2026-08-13 12:25:07'),
(1124, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:d:e804:8000::', '2026-08-15 02:31:39'),
(1125, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.103.153', '2026-08-15 03:47:11'),
(1126, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:d:e804:8000::', '2026-08-15 03:52:01'),
(1127, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:d:e804:8000::', '2026-08-15 03:52:11'),
(1128, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:d:e804:8000::', '2026-08-15 03:52:21'),
(1129, 15, 'Create Order', 'Staff created Order ID: 61 for Retailer ID: 33. Grand Total: 1229.13', '2409:40f2:d:e804:8000::', '2026-08-15 03:55:50'),
(1130, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 30', '152.57.103.153', '2026-08-15 04:03:10'),
(1131, 15, 'Create Order', 'Staff created Order ID: 62 for Retailer ID: 34. Grand Total: 1125.18', '2409:40f2:d:e804:8000::', '2026-08-15 04:05:12'),
(1132, 1, 'Create Retailer', 'Created retailer BHARATI GENERAL STORES (Owner: )', '152.57.103.153', '2026-08-15 04:29:32'),
(1133, 1, 'Create Retailer', 'Created retailer JAIRAJ RETAILS (Owner: )', '152.57.103.153', '2026-08-15 04:30:52'),
(1134, 1, 'Create Retailer', 'Created retailer JAIRAJ RETAILS (Owner: )', '152.57.103.153', '2026-08-15 04:30:53'),
(1135, 1, 'Delete Retailer', 'Deleted retailer ID: 58', '152.57.103.153', '2026-08-15 04:32:19'),
(1136, 1, 'Delete Discount', 'Deleted discount ID: 20', '152.57.103.153', '2026-08-15 04:33:14'),
(1137, 1, 'Delete Discount', 'Deleted discount ID: 21', '152.57.103.153', '2026-08-15 04:33:33'),
(1138, 15, 'Create Order', 'Staff created Order ID: 63 for Retailer ID: 59. Grand Total: 1143.985', '2409:40f2:d:e804:8000::', '2026-08-15 04:34:59'),
(1139, 15, 'Create Order', 'Staff created Order ID: 64 for Retailer ID: 57. Grand Total: 199.458', '2409:40f2:d:e804:8000::', '2026-08-15 04:36:09'),
(1140, 1, 'Update Order Status', 'Owner updated Order ID: 61 to Status: Approved', '152.57.103.153', '2026-08-15 04:38:35'),
(1141, 1, 'Update Order Status', 'Owner updated Order ID: 62 to Status: Approved', '152.57.103.153', '2026-08-15 04:38:39'),
(1142, 1, 'Update Order Status', 'Owner updated Order ID: 63 to Status: Approved', '152.57.103.153', '2026-08-15 04:38:44'),
(1143, 1, 'Update Order Status', 'Owner updated Order ID: 64 to Status: Approved', '152.57.103.153', '2026-08-15 04:38:48'),
(1144, 1, 'Generate Invoice', 'Invoiced Order ID: 61 -> Invoice No: NE/2026-27/0055. Grand Total: 1229.13', '152.57.103.153', '2026-08-15 04:44:56'),
(1145, 1, 'Generate Invoice', 'Invoiced Order ID: 62 -> Invoice No: NE/2026-27/0056. Grand Total: 1125.18', '152.57.103.153', '2026-08-15 04:45:56'),
(1146, 1, 'Generate Invoice', 'Invoiced Order ID: 63 -> Invoice No: NE/2026-27/0057. Grand Total: 1143.99', '152.57.103.153', '2026-08-15 04:46:19'),
(1147, 1, 'Generate Invoice', 'Invoiced Order ID: 64 -> Invoice No: NE/2026-27/0058. Grand Total: 199.46', '152.57.103.153', '2026-08-15 04:46:39'),
(1148, 15, 'Collect Payment', 'Recorded payment of ₹1,125.18 from Retailer ID: 34 using Method: Cash', '2409:40f2:129:f2b:8000::', '2026-08-15 07:00:22'),
(1149, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.1.13', '2026-08-15 14:13:05'),
(1150, 1, 'Export Report', 'Exported Sales CSV Report (From: 2026-08-01 To: 2026-08-15)', '152.57.1.13', '2026-08-15 14:16:56'),
(1151, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2164:4453:8000::', '2026-08-15 16:56:00'),
(1152, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1028:8fd5:8000::', '2026-08-17 05:06:09'),
(1153, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2175:1ea7:8000::', '2026-08-17 08:04:36'),
(1154, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2045:70d5:8000::', '2026-08-18 07:18:16'),
(1155, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2045:70d5:8000::', '2026-08-18 07:19:25'),
(1156, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-08-01 To: 2026-08-18)', '2409:40f2:2045:70d5:8000::', '2026-08-18 07:19:36'),
(1157, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:200a:bb2c:8000::', '2026-08-18 14:26:59'),
(1158, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:200a:bb2c:8000::', '2026-08-18 14:26:59'),
(1159, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:200a:bb2c:8000::', '2026-08-18 14:26:59'),
(1160, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:200a:bb2c:8000::', '2026-08-18 14:26:59'),
(1161, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:200a:bb2c:8000::', '2026-08-18 14:26:59'),
(1162, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:200a:bb2c:8000::', '2026-08-18 14:26:59'),
(1163, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:200a:bb2c:8000::', '2026-08-18 14:27:57'),
(1164, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2013:6dc7:8000::', '2026-08-19 00:52:39'),
(1165, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1048:e153:8000::', '2026-08-19 04:22:56'),
(1166, 1, 'Collect Payment', 'Recorded payment of ₹500.00 from Retailer ID: 20 using Method: UPI', '2409:40f2:1048:e153:8000::', '2026-08-19 04:23:39'),
(1167, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1048:e153:8000::', '2026-08-19 05:41:11'),
(1168, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:1048:e153:8000::', '2026-08-19 05:41:52'),
(1169, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1048:e153:8000::', '2026-08-19 05:42:03'),
(1170, 15, 'Create Order', 'Staff created Order ID: 65 for Retailer ID: 16. Grand Total: 1209.316', '2409:40f2:1048:e153:8000::', '2026-08-19 05:56:50'),
(1171, 15, 'Collect Payment', 'Recorded payment of ₹180.00 from Retailer ID: 15 using Method: Cash', '2409:40f2:1048:e153:8000::', '2026-08-19 06:09:59'),
(1172, 15, 'Create Order', 'Staff created Order ID: 66 for Retailer ID: 18. Grand Total: 309.676', '2409:40f2:1048:e153:8000::', '2026-08-19 06:30:14'),
(1173, 15, 'Create Order', 'Staff created Order ID: 67 for Retailer ID: 18. Grand Total: 309.676', '2409:40f2:1048:e153:8000::', '2026-08-19 06:30:14'),
(1174, 15, 'Create Order', 'Staff created Order ID: 68 for Retailer ID: 18. Grand Total: 309.676', '2409:40f2:1048:e153:8000::', '2026-08-19 06:30:14'),
(1175, 15, 'Create Order', 'Staff created Order ID: 69 for Retailer ID: 18. Grand Total: 309.676', '2409:40f2:1048:e153:8000::', '2026-08-19 06:30:14'),
(1176, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:1048:e153:8000::', '2026-08-19 06:50:32'),
(1177, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1048:e153:8000::', '2026-08-19 06:50:45'),
(1178, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.36.187', '2026-08-19 10:49:22'),
(1179, 1, 'Update Order Status', 'Owner updated Order ID: 65 to Status: Approved', '152.57.36.187', '2026-08-19 10:49:49'),
(1180, 1, 'Update Order Status', 'Owner updated Order ID: 66 to Status: Approved', '152.57.36.187', '2026-08-19 10:49:56'),
(1181, 1, 'Update Order Status', 'Owner updated Order ID: 67 to Status: Cancelled', '152.57.36.187', '2026-08-19 10:50:34'),
(1182, 1, 'Update Order Status', 'Owner updated Order ID: 68 to Status: Cancelled', '152.57.36.187', '2026-08-19 10:50:56'),
(1183, 1, 'Update Order Status', 'Owner updated Order ID: 69 to Status: Cancelled', '152.57.36.187', '2026-08-19 10:51:29'),
(1184, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:16'),
(1185, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:16'),
(1186, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA KASTURI ZIPPER PACK.', '152.57.36.187', '2026-08-19 10:54:16'),
(1187, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DIAMOND ZIPPER PACK.', '152.57.36.187', '2026-08-19 10:54:16'),
(1188, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA HEENA ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:16'),
(1189, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DREAMS ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:16'),
(1190, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BOLENATH ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:16'),
(1191, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BRUTS ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:16'),
(1192, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 960 units to SKU VINAYAKA REGULAR POUCH MIX.', '152.57.36.187', '2026-08-19 10:54:16'),
(1193, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 300 units to SKU VINAYAKA GOOD MORNING ECONOMY.', '152.57.36.187', '2026-08-19 10:54:16'),
(1194, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 180 units to SKU VINAYAKA BLACK FANTASY 60G.', '152.57.36.187', '2026-08-19 10:54:16'),
(1195, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 180 units to SKU VINAYAKA WILD PURPLE 60G.', '152.57.36.187', '2026-08-19 10:54:16'),
(1196, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 84 units to SKU VINAYAKA ONE PLUS ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:16'),
(1197, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:32'),
(1198, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:32'),
(1199, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA KASTURI ZIPPER PACK.', '152.57.36.187', '2026-08-19 10:54:32'),
(1200, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DIAMOND ZIPPER PACK.', '152.57.36.187', '2026-08-19 10:54:32'),
(1201, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA HEENA ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:32'),
(1202, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DREAMS ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:32'),
(1203, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BOLENATH ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:32'),
(1204, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA BRUTS ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:32'),
(1205, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 960 units to SKU VINAYAKA REGULAR POUCH MIX.', '152.57.36.187', '2026-08-19 10:54:32'),
(1206, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 300 units to SKU VINAYAKA GOOD MORNING ECONOMY.', '152.57.36.187', '2026-08-19 10:54:32'),
(1207, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 180 units to SKU VINAYAKA BLACK FANTASY 60G.', '152.57.36.187', '2026-08-19 10:54:32');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `ip_address`, `created_at`) VALUES
(1208, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 180 units to SKU VINAYAKA WILD PURPLE 60G.', '152.57.36.187', '2026-08-19 10:54:32'),
(1209, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 84 units to SKU VINAYAKA ONE PLUS ZIPPER PACKS.', '152.57.36.187', '2026-08-19 10:54:32'),
(1210, 1, 'Generate Invoice', 'Invoiced Order ID: 65 -> Invoice No: NE/2026-27/0059. Grand Total: 1209.32', '152.57.36.187', '2026-08-19 10:55:04'),
(1211, 1, 'Generate Invoice', 'Invoiced Order ID: 66 -> Invoice No: NE/2026-27/0060. Grand Total: 309.68', '152.57.36.187', '2026-08-19 10:55:53'),
(1212, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.36.187', '2026-08-19 10:57:41'),
(1213, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:104b:7b89:8000::', '2026-08-19 12:19:10'),
(1214, 1, 'Collect Payment', 'Recorded payment of ₹310.00 from Retailer ID: 18 using Method: Cash', '2409:40f2:104b:7b89:8000::', '2026-08-19 12:19:51'),
(1215, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1e:7d8f:8000::', '2026-08-19 15:35:15'),
(1216, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:19:01'),
(1217, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹100.00 + GST ₹0.00 paid to fuel via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:19:50'),
(1218, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹120.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:20:17'),
(1219, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹120.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:20:47'),
(1220, 1, 'Update Expense', 'Updated expense ID: 5 (Travel / Fuel) via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:20:59'),
(1221, 1, 'Update Expense', 'Updated expense ID: 6 (Travel / Fuel) via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:21:14'),
(1222, 1, 'Update Expense', 'Updated expense ID: 6 (Travel / Fuel) via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:21:14'),
(1223, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹150.00 + GST ₹0.00 paid to  via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:21:35'),
(1224, 1, 'Update Expense', 'Updated expense ID: 7 (Travel / Fuel) via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:21:46'),
(1225, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹180.00 + GST ₹0.00 paid to fuel via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:22:09'),
(1226, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹130.00 + GST ₹0.00 paid to fuel via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:22:46'),
(1227, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹130.00 + GST ₹0.00 paid to fuel via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:23:24'),
(1228, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹120.00 + GST ₹0.00 paid to fuel via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:23:44'),
(1229, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹130.00 + GST ₹0.00 paid to fuel via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:24:18'),
(1230, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹120.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:24:39'),
(1231, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹120.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:24:59'),
(1232, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹280.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:25:18'),
(1233, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹110.00 + GST ₹0.00 paid to fuel via UPI', '2409:40f2:1e:7d8f:8000::', '2026-08-20 02:25:40'),
(1234, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1e:7d8f:8000::', '2026-08-20 04:22:51'),
(1235, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:212e:590b:8000::', '2026-08-20 12:18:40'),
(1236, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:212e:590b:8000::', '2026-08-20 12:47:11'),
(1237, 15, 'Collect Payment', 'Recorded payment of ₹358.00 from Retailer ID: 23 using Method: Cash', '2409:40f2:212e:590b:8000::', '2026-08-20 12:47:24'),
(1238, 15, 'Collect Payment', 'Recorded payment of ₹480.00 from Retailer ID: 19 using Method: UPI', '2409:40f2:212e:590b:8000::', '2026-08-20 12:52:42'),
(1239, 15, 'Collect Payment', 'Recorded payment of ₹512.00 from Retailer ID: 20 using Method: Cash', '2409:40f2:212e:590b:8000::', '2026-08-20 13:00:33'),
(1240, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:212e:590b:8000::', '2026-08-20 13:35:59'),
(1241, 15, 'Collect Payment', 'Recorded payment of ₹1,500.00 from Retailer ID: 52 using Method: Cash', '2409:40f2:212e:590b:8000::', '2026-08-20 13:36:27'),
(1242, 15, 'Collect Payment', 'Recorded payment of ₹500.00 from Retailer ID: 26 using Method: Cash', '2409:40f2:212e:590b:8000::', '2026-08-20 13:37:02'),
(1243, 15, 'Collect Payment', 'Recorded payment of ₹300.00 from Retailer ID: 24 using Method: Cash', '2409:40f2:212e:590b:8000::', '2026-08-20 13:37:38'),
(1244, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:212e:590b:8000::', '2026-08-20 13:50:06'),
(1245, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:212e:590b:8000::', '2026-08-21 06:09:22'),
(1246, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:31:5be2:8000::', '2026-08-22 13:44:02'),
(1247, 1, 'Collect Payment', 'Recorded payment of ₹1,000.00 from Retailer ID: 55 using Method: Cash', '2409:40f2:31:5be2:8000::', '2026-08-22 13:44:38'),
(1248, 1, 'Collect Payment', 'Recorded payment of ₹460.00 from Retailer ID: 26 using Method: Cash', '2409:40f2:31:5be2:8000::', '2026-08-22 13:45:06'),
(1249, 1, 'Collect Payment', 'Recorded payment of ₹1,200.00 from Retailer ID: 25 using Method: Cash', '2409:40f2:31:5be2:8000::', '2026-08-22 13:46:07'),
(1250, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-08-01 To: 2026-08-22)', '2409:40f2:31:5be2:8000::', '2026-08-22 13:47:18'),
(1251, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:31:5be2:8000::', '2026-08-22 13:49:24'),
(1252, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:31:5be2:8000::', '2026-08-22 13:49:37'),
(1253, 15, 'Create Order', 'Staff created Order ID: 70 for Retailer ID: 33. Grand Total: 260', '2409:40f2:31:5be2:8000::', '2026-08-22 13:50:24'),
(1254, 15, 'Create Order', 'Staff created Order ID: 71 for Retailer ID: 32. Grand Total: 166.635', '2409:40f2:1c:83f:8000::', '2026-08-22 13:54:29'),
(1255, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:124:98b1:8000::', '2026-08-23 01:26:02'),
(1256, 15, 'Create Order', 'Staff created Order ID: 72 for Retailer ID: 35. Grand Total: 130', '2409:40f2:124:98b1:8000::', '2026-08-23 01:27:00'),
(1257, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:124:98b1:8000::', '2026-08-23 01:28:55'),
(1258, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:124:98b1:8000::', '2026-08-23 01:29:08'),
(1259, 1, 'Create Retailer', 'Created retailer CHANDRAKANTH GENERAL STORES (Owner: )', '2409:40f2:124:98b1:8000::', '2026-08-23 01:32:22'),
(1260, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:124:98b1:8000::', '2026-08-23 18:05:11'),
(1261, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1033:cfe5:8000::', '2026-08-24 03:29:59'),
(1262, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹70.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1033:cfe5:8000::', '2026-08-24 03:30:47'),
(1263, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹80.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1033:cfe5:8000::', '2026-08-24 03:31:09'),
(1264, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹110.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1033:cfe5:8000::', '2026-08-24 03:31:24'),
(1265, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:19:c4df:8000::', '2026-08-24 14:36:37'),
(1266, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:104a:7170:8000::', '2026-08-25 02:06:15'),
(1267, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:104a:7170:8000::', '2026-08-25 05:52:19'),
(1268, 1, 'Collect Payment', 'Recorded payment of ₹1,140.00 from Retailer ID: 46 using Method: Cash', '2409:40f2:104a:7170:8000::', '2026-08-25 05:52:44'),
(1269, 1, 'Collect Payment', 'Recorded payment of ₹300.00 from Retailer ID: 45 using Method: Cash', '2409:40f2:104a:7170:8000::', '2026-08-25 06:04:32'),
(1270, 1, 'Collect Payment', 'Recorded payment of ₹180.00 from Retailer ID: 43 using Method: Cash', '2409:40f2:104a:7170:8000::', '2026-08-25 06:05:43'),
(1271, 1, 'Collect Payment', 'Recorded payment of ₹639.00 from Retailer ID: 41 using Method: Cash', '2409:40f2:104a:7170:8000::', '2026-08-25 06:21:38'),
(1272, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:104a:7170:8000::', '2026-08-25 07:18:52'),
(1273, 1, 'Collect Payment', 'Recorded payment of ₹130.00 from Retailer ID: 48 using Method: Cash', '2409:40f2:104a:7170:8000::', '2026-08-25 07:19:33'),
(1274, 1, 'Collect Payment', 'Recorded payment of ₹500.00 from Retailer ID: 51 using Method: UPI', '2409:40f2:104a:7170:8000::', '2026-08-25 07:39:24'),
(1275, 1, 'Collect Payment', 'Recorded payment of ₹345.00 from Retailer ID: 51 using Method: Cash', '2409:40f2:104a:7170:8000::', '2026-08-25 07:39:55'),
(1276, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:38:5fdf:8000::', '2026-08-26 02:33:50'),
(1277, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-08-01 To: 2026-08-26)', '2409:40f2:38:5fdf:8000::', '2026-08-26 02:35:04'),
(1278, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:42:1b04:8000::', '2026-08-26 06:07:20'),
(1279, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹110.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:42:1b04:8000::', '2026-08-26 06:08:19'),
(1280, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:356:bf03:8000::', '2026-08-26 14:32:19'),
(1281, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.27.21', '2026-08-27 06:30:55'),
(1282, 1, 'Update Order Status', 'Owner updated Order ID: 70 to Status: Approved', '152.57.27.21', '2026-08-27 06:31:32'),
(1283, 1, 'Generate Invoice', 'Invoiced Order ID: 70 -> Invoice No: NE/2026-27/0061. Grand Total: 260', '152.57.27.21', '2026-08-27 06:31:42'),
(1284, 1, 'Collect Payment', 'Recorded payment of ₹260.00 from Retailer ID: 33 using Method: Cash', '152.57.27.21', '2026-08-27 06:33:18'),
(1285, 1, 'Logout', 'User NAVATARA_06 logged out.', '152.57.27.21', '2026-08-27 06:33:44'),
(1286, 15, 'Login', 'User Shreyansh_ logged in successfully.', '152.57.27.21', '2026-08-27 06:33:56'),
(1287, 15, 'Create Order', 'Staff created Order ID: 73 for Retailer ID: 60. Grand Total: 295.029', '152.57.27.21', '2026-08-27 06:35:43'),
(1288, 15, 'Update Order', 'Staff updated Order ID: 73 for Retailer ID: 60. Grand Total: 2523.998', '152.57.27.21', '2026-08-27 06:41:03'),
(1289, 15, 'Logout', 'User Shreyansh_ logged out.', '152.57.27.21', '2026-08-27 06:42:39'),
(1290, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.27.21', '2026-08-27 06:42:44'),
(1291, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 40', '152.57.27.21', '2026-08-27 06:43:24'),
(1292, 1, 'Logout', 'User NAVATARA_06 logged out.', '152.57.27.21', '2026-08-27 06:43:34'),
(1293, 15, 'Login', 'User Shreyansh_ logged in successfully.', '152.57.27.21', '2026-08-27 06:43:43'),
(1294, 15, 'Create Order', 'Staff created Order ID: 74 for Retailer ID: 40. Grand Total: 2154.18', '152.57.27.21', '2026-08-27 06:44:37'),
(1295, 15, 'Logout', 'User Shreyansh_ logged out.', '152.57.27.21', '2026-08-27 06:45:07'),
(1296, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.27.21', '2026-08-27 06:45:12'),
(1297, 1, 'Update Order Status', 'Owner updated Order ID: 74 to Status: Approved', '152.57.27.21', '2026-08-27 06:45:29'),
(1298, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 480 units to SKU APPALAM.', '152.57.27.21', '2026-08-27 06:46:37'),
(1299, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 2000 units to SKU GINGER GARLIC PASTE 5RS.', '152.57.27.21', '2026-08-27 06:46:37'),
(1300, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 4 units to SKU TURMERIC POWDER 5KG.', '152.57.27.21', '2026-08-27 06:46:37'),
(1301, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 50 units to SKU TURMERIC POWDER SHEET 10RS.', '152.57.27.21', '2026-08-27 06:46:37'),
(1302, 1, 'Generate Invoice', 'Invoiced Order ID: 74 -> Invoice No: NE/2026-27/0062. Grand Total: 2154.18', '152.57.27.21', '2026-08-27 06:46:54'),
(1303, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 480 units to SKU APPALAM.', '152.57.27.21', '2026-08-27 06:47:24'),
(1304, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 1000 units to SKU GINGER GARLIC PASTE 5RS.', '152.57.27.21', '2026-08-27 06:47:24'),
(1305, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 4 units to SKU TURMERIC POWDER 5KG.', '152.57.27.21', '2026-08-27 06:47:24'),
(1306, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 50 units to SKU TURMERIC POWDER SHEET 10RS.', '152.57.27.21', '2026-08-27 06:47:24'),
(1307, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.27.21', '2026-08-27 06:51:02'),
(1308, 1, 'Update Order Status', 'Owner updated Order ID: 73 to Status: Approved', '152.57.27.21', '2026-08-27 06:52:51'),
(1309, 1, 'Generate Invoice', 'Invoiced Order ID: 73 -> Invoice No: NE/2026-27/0063. Grand Total: 2524', '152.57.27.21', '2026-08-27 06:53:02'),
(1310, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:4b:391b:8000::', '2026-08-27 13:58:05'),
(1311, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:4b:391b:8000::', '2026-08-27 15:51:39'),
(1312, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:43:16f5:8000::', '2026-08-28 14:04:17'),
(1313, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:4c:6d8f:8000::', '2026-08-29 02:00:31'),
(1314, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1030:266f:8000::', '2026-08-29 10:28:27'),
(1315, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:1030:266f:8000::', '2026-08-29 10:28:36'),
(1316, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:1030:266f:8000::', '2026-08-29 10:28:46'),
(1317, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:103b:958:8000::', '2026-08-29 13:37:00'),
(1318, 1, 'Collect Payment', 'Recorded payment of ₹480.00 from Retailer ID: 54 using Method: UPI', '2409:40f2:103b:958:8000::', '2026-08-29 13:37:41'),
(1319, 1, 'Collect Payment', 'Recorded payment of ₹2,000.00 from Retailer ID: 53 using Method: Cash', '2409:40f2:103b:958:8000::', '2026-08-29 13:38:10'),
(1320, 1, 'Collect Payment', 'Recorded payment of ₹250.00 from Retailer ID: 24 using Method: Cash', '2409:40f2:103b:958:8000::', '2026-08-29 13:38:39'),
(1321, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:30a:d0d9:8000::', '2026-08-31 04:42:05'),
(1322, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:30a:d0d9:8000::', '2026-08-31 06:26:02'),
(1323, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:30a:d0d9:8000::', '2026-08-31 06:26:14'),
(1324, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:30a:d0d9:8000::', '2026-08-31 06:26:23'),
(1325, 15, 'Collect Payment', 'Recorded payment of ₹2,723.00 from Retailer ID: 56 using Method: Cash', '2409:40f2:30a:d0d9:8000::', '2026-08-31 06:27:33'),
(1326, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:3143:25ac:8000::', '2026-08-31 07:40:27'),
(1327, 15, 'Collect Payment', 'Recorded payment of ₹259.00 from Retailer ID: 49 using Method: Cash', '2409:40f2:3143:25ac:8000::', '2026-08-31 07:41:13'),
(1328, 15, 'Collect Payment', 'Recorded payment of ₹300.00 from Retailer ID: 45 using Method: Cash', '2409:40f2:3143:25ac:8000::', '2026-08-31 07:43:13'),
(1329, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:3143:25ac:8000::', '2026-08-31 08:14:08'),
(1330, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:3143:25ac:8000::', '2026-08-31 08:34:21'),
(1331, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:3143:25ac:8000::', '2026-08-31 08:34:34'),
(1332, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹50.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:3143:25ac:8000::', '2026-08-31 08:35:38'),
(1333, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1038:4df0:8000::', '2026-08-31 12:23:41'),
(1334, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:308:6f5:8000::', '2026-09-02 06:13:33'),
(1335, 15, 'Collect Payment', 'Recorded payment of ₹1,209.00 from Retailer ID: 16 using Method: Cash', '2409:40f2:308:6f5:8000::', '2026-09-02 06:15:05'),
(1336, 15, 'Collect Payment', 'Recorded payment of ₹550.00 from Retailer ID: 8 using Method: Cash', '2409:40f2:308:6f5:8000::', '2026-09-02 06:15:26'),
(1337, 15, 'Collect Payment', 'Recorded payment of ₹960.00 from Retailer ID: 17 using Method: Cash', '2409:40f2:308:6f5:8000::', '2026-09-02 06:15:46'),
(1338, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:308:6f5:8000::', '2026-09-02 07:12:02'),
(1339, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1038:c093:8000::', '2026-09-02 07:56:12'),
(1340, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1038:c093:8000::', '2026-09-02 10:00:41'),
(1341, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:1038:c093:8000::', '2026-09-02 10:00:49'),
(1342, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1038:c093:8000::', '2026-09-02 10:01:01'),
(1343, 15, 'Create Order', 'Staff created Order ID: 75 for Retailer ID: 12. Grand Total: 179.676', '2409:40f2:1038:c093:8000::', '2026-09-02 10:01:58'),
(1344, 15, 'Create Order', 'Staff created Order ID: 76 for Retailer ID: 15. Grand Total: 658.476', '2409:40f2:1038:c093:8000::', '2026-09-02 10:05:23'),
(1345, 15, 'Create Order', 'Staff created Order ID: 77 for Retailer ID: 16. Grand Total: 394.695', '2409:40f2:1038:c093:8000::', '2026-09-02 10:07:04'),
(1346, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.15.143', '2026-09-02 10:33:45'),
(1347, 1, 'Update Order Status', 'Owner updated Order ID: 75 to Status: Approved', '152.57.15.143', '2026-09-02 10:35:07'),
(1348, 1, 'Update Order Status', 'Owner updated Order ID: 76 to Status: Approved', '152.57.15.143', '2026-09-02 10:35:12'),
(1349, 1, 'Update Order Status', 'Owner updated Order ID: 77 to Status: Approved', '152.57.15.143', '2026-09-02 10:35:18'),
(1350, 1, 'Generate Invoice', 'Invoiced Order ID: 75 -> Invoice No: NE/2026-27/0064. Grand Total: 179.68', '152.57.15.143', '2026-09-02 10:35:40'),
(1351, 1, 'Generate Invoice', 'Invoiced Order ID: 76 -> Invoice No: NE/2026-27/0065. Grand Total: 658.48', '152.57.15.143', '2026-09-02 10:37:48'),
(1352, 1, 'Generate Invoice', 'Invoiced Order ID: 77 -> Invoice No: NE/2026-27/0066. Grand Total: 394.7', '152.57.15.143', '2026-09-02 10:38:10'),
(1353, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:35e:8e7a:8000::', '2026-09-04 15:33:27'),
(1354, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2d:fa20:8000::', '2026-09-05 02:36:54'),
(1355, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:2d:fa20:8000::', '2026-09-05 02:37:02'),
(1356, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2d:fa20:8000::', '2026-09-05 02:37:15'),
(1357, 15, 'Collect Payment', 'Recorded payment of ₹200.00 from Retailer ID: 57 using Method: Cash', '2409:40f2:2d:fa20:8000::', '2026-09-05 02:38:47'),
(1358, 15, 'Collect Payment', 'Recorded payment of ₹2,154.00 from Retailer ID: 40 using Method: Cheque', '2409:40f2:2d:fa20:8000::', '2026-09-05 02:39:27'),
(1359, 15, 'Update Retailer', 'Updated retailer profile: MANGAI GENRAL STORES (ID: 38)', '2409:40f2:2d:fa20:8000::', '2026-09-05 02:40:50'),
(1360, 15, 'Update Retailer', 'Updated retailer profile: SUPRIYA GENERAL STORES (ID: 36)', '2409:40f2:2d:fa20:8000::', '2026-09-05 02:41:07'),
(1361, 15, 'Update Retailer', 'Updated retailer profile: MARUTI GENERAL STORES (ID: 32)', '2409:40f2:2d:fa20:8000::', '2026-09-05 02:41:34'),
(1362, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:318:6ceb:8000::', '2026-09-05 04:33:49'),
(1363, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:318:6ceb:8000::', '2026-09-05 04:36:35'),
(1364, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:318:6ceb:8000::', '2026-09-05 04:36:47'),
(1365, 15, 'Create Order', 'Staff created Order ID: 78 for Retailer ID: 26. Grand Total: 539.028', '2409:40f2:318:6ceb:8000::', '2026-09-05 04:37:55'),
(1366, 15, 'Create Order', 'Staff created Order ID: 79 for Retailer ID: 51. Grand Total: 1049.4845', '2409:40f2:318:6ceb:8000::', '2026-09-05 04:39:00'),
(1367, 15, 'Create Order', 'Staff created Order ID: 80 for Retailer ID: 59. Grand Total: 260', '2409:40f2:318:6ceb:8000::', '2026-09-05 04:40:42'),
(1368, 15, 'Create Order', 'Staff created Order ID: 81 for Retailer ID: 37. Grand Total: 1201.64', '2409:40f2:318:6ceb:8000::', '2026-09-05 04:42:07'),
(1369, 15, 'Update Order', 'Staff updated Order ID: 78 for Retailer ID: 26. Grand Total: 539.028', '2409:40f2:318:6ceb:8000::', '2026-09-05 04:42:33'),
(1370, 15, 'Update Order', 'Staff updated Order ID: 79 for Retailer ID: 51. Grand Total: 1049.4845', '2409:40f2:318:6ceb:8000::', '2026-09-05 04:42:45'),
(1371, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.137.132', '2026-09-05 05:28:10'),
(1372, 1, 'Update Order Status', 'Owner updated Order ID: 80 to Status: Approved', '152.57.137.132', '2026-09-05 05:29:28'),
(1373, 1, 'Generate Invoice', 'Invoiced Order ID: 80 -> Invoice No: NE/2026-27/0067. Grand Total: 260', '152.57.137.132', '2026-09-05 05:29:37'),
(1374, 1, 'Update Order Status', 'Owner updated Order ID: 81 to Status: Approved', '152.57.137.132', '2026-09-05 05:30:11'),
(1375, 1, 'Generate Invoice', 'Invoiced Order ID: 81 -> Invoice No: NE/2026-27/0068. Grand Total: 1201.64', '152.57.137.132', '2026-09-05 05:30:50'),
(1376, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:37:1e05:8000::', '2026-09-05 10:15:52'),
(1377, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:37:1e05:8000::', '2026-09-05 10:15:54'),
(1378, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹50.00 + GST ₹0.00 paid to  via Cash', '2409:40f2:37:1e05:8000::', '2026-09-05 10:16:36'),
(1379, 1, 'Update Expense', 'Updated expense ID: 22 (Travel / Fuel) via Cash', '2409:40f2:37:1e05:8000::', '2026-09-05 10:16:51'),
(1380, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹100.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:37:1e05:8000::', '2026-09-05 10:17:07'),
(1381, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:37:1e05:8000::', '2026-09-05 10:18:54'),
(1382, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:37:1e05:8000::', '2026-09-05 10:19:06'),
(1383, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:37:1e05:8000::', '2026-09-05 10:19:16'),
(1384, 15, 'Collect Payment', 'Recorded payment of ₹260.00 from Retailer ID: 59 using Method: Cash', '2409:40f2:37:1e05:8000::', '2026-09-05 10:19:52'),
(1385, 15, 'Collect Payment', 'Recorded payment of ₹1,000.00 from Retailer ID: 60 using Method: Cash', '2409:40f2:37:1e05:8000::', '2026-09-05 10:20:19'),
(1386, 15, 'Collect Payment', 'Recorded payment of ₹1,202.00 from Retailer ID: 37 using Method: Cash', '2409:40f2:37:1e05:8000::', '2026-09-05 10:20:41'),
(1387, NULL, 'Logout', 'User Unknown logged out.', '2409:40f2:37:1e05:8000::', '2026-09-05 12:14:45'),
(1388, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:37:1e05:8000::', '2026-09-05 12:14:59'),
(1389, 15, 'Collect Payment', 'Recorded payment of ₹1,500.00 from Retailer ID: 52 using Method: Cash', '2409:40f2:37:1e05:8000::', '2026-09-05 12:15:31'),
(1390, 15, 'Collect Payment', 'Recorded payment of ₹1,000.00 from Retailer ID: 53 using Method: Cash', '2409:40f2:37:1e05:8000::', '2026-09-05 12:16:02'),
(1391, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:37:1e05:8000::', '2026-09-05 13:04:38'),
(1392, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:37:1e05:8000::', '2026-09-05 13:04:51'),
(1393, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹100.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:37:1e05:8000::', '2026-09-05 13:05:21'),
(1394, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:50:14'),
(1395, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:50:23'),
(1396, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:50:34'),
(1397, 15, 'Create Order', 'Staff created Order ID: 82 for Retailer ID: 26. Grand Total: 2878.848', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:52:23'),
(1398, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:55:05'),
(1399, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:55:18'),
(1400, 1, 'Create SKU', 'Created SKU: FRESH GUGGAL (Code: INCENSE-STICKS-ZIPPER-PACKS-FRESH-GUGGAL) with opening stock 42', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:57:31'),
(1401, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 480 units to SKU VINAYAKA BLACK FANTASY ZIPPER PACKS.', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:58:17'),
(1402, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP GUGGAL.', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:58:17'),
(1403, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP SAMBRANI.', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:58:17'),
(1404, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP MANGAL.', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:58:17'),
(1405, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 42 units to SKU FRESH GUGGAL.', '2409:40f2:104e:46a6:8000::', '2026-09-07 01:58:17'),
(1406, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:104e:46a6:8000::', '2026-09-07 02:00:14'),
(1407, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:104e:46a6:8000::', '2026-09-07 02:00:26'),
(1408, 15, 'Create Order', 'Staff created Order ID: 83 for Retailer ID: 25. Grand Total: 2399.04', '2409:40f2:104e:46a6:8000::', '2026-09-07 02:03:10'),
(1409, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2000:f664:8000::', '2026-09-07 04:39:05'),
(1410, 1, 'Update Order Status', 'Owner updated Order ID: 82 to Status: Approved', '2409:40f2:2000:f664:8000::', '2026-09-07 04:40:18'),
(1411, 1, 'Generate Invoice', 'Invoiced Order ID: 82 -> Invoice No: NE/2026-27/0069. Grand Total: 2878.85', '2409:40f2:2000:f664:8000::', '2026-09-07 04:40:25'),
(1412, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.205.82', '2026-09-07 04:43:55'),
(1413, 1, 'Update Order Status', 'Owner updated Order ID: 83 to Status: Approved', '157.50.205.82', '2026-09-07 04:44:14'),
(1414, 1, 'Generate Invoice', 'Invoiced Order ID: 83 -> Invoice No: NE/2026-27/0070. Grand Total: 2399.04', '157.50.205.82', '2026-09-07 04:44:21'),
(1415, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:2000:f664:8000::', '2026-09-07 05:16:05'),
(1416, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2000:f664:8000::', '2026-09-07 07:00:31'),
(1417, 15, 'Create Order', 'Staff created Order ID: 84 for Retailer ID: 41. Grand Total: 959.616', '2409:40f2:2000:f664:8000::', '2026-09-07 07:03:58'),
(1418, 15, 'Collect Payment', 'Recorded payment of ₹360.00 from Retailer ID: 45 using Method: Cash', '2409:40f2:2000:f664:8000::', '2026-09-07 07:19:49'),
(1419, 15, 'Create Order', 'Staff created Order ID: 85 for Retailer ID: 45. Grand Total: 3148.362', '2409:40f2:2000:f664:8000::', '2026-09-07 07:24:20'),
(1420, NULL, 'Failed Login Attempt', 'Username attempted: Navatara_06', '2409:40f2:304:ec3d:8000::', '2026-09-08 04:58:00'),
(1421, NULL, 'Failed Login Attempt', 'Username attempted: Navatara_06', '2409:40f2:304:ec3d:8000::', '2026-09-08 04:58:22'),
(1422, NULL, 'Failed Login Attempt', 'Username attempted: Navatara_06', '2409:40f2:304:ec3d:8000::', '2026-09-08 04:58:48'),
(1423, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:304:ec3d:8000::', '2026-09-08 04:59:08'),
(1424, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:304:ec3d:8000::', '2026-09-08 04:59:14'),
(1425, NULL, 'Failed Login Attempt', 'Username attempted: Navatara_06', '2409:40f2:304:ec3d:8000::', '2026-09-08 04:59:28'),
(1426, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:304:ec3d:8000::', '2026-09-08 05:02:10'),
(1427, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.117.232', '2026-09-08 05:02:17'),
(1428, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.113.162', '2026-09-08 08:27:43'),
(1429, 1, 'Update Order Status', 'Owner updated Order ID: 84 to Status: Approved', '152.57.113.162', '2026-09-08 08:28:32'),
(1430, 1, 'Update Order Status', 'Owner updated Order ID: 85 to Status: Approved', '152.57.113.162', '2026-09-08 08:28:37'),
(1431, 1, 'Generate Invoice', 'Invoiced Order ID: 84 -> Invoice No: NE/2026-27/0071. Grand Total: 959.62', '152.57.113.162', '2026-09-08 08:28:45'),
(1432, 1, 'Generate Invoice', 'Invoiced Order ID: 85 -> Invoice No: NE/2026-27/0072. Grand Total: 3148.36', '152.57.113.162', '2026-09-08 08:29:40'),
(1433, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:304:ec3d:8000::', '2026-09-08 08:41:01'),
(1434, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹80.00 + GST ₹0.00 paid to  via Cash', '2409:40f2:304:ec3d:8000::', '2026-09-08 08:41:38'),
(1435, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:304:ec3d:8000::', '2026-09-08 08:48:11'),
(1436, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:304:ec3d:8000::', '2026-09-08 08:48:26'),
(1437, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:304:ec3d:8000::', '2026-09-08 11:14:38'),
(1438, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:304:ec3d:8000::', '2026-09-08 11:14:44'),
(1439, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:304:ec3d:8000::', '2026-09-08 11:14:54'),
(1440, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:304:ec3d:8000::', '2026-09-08 14:37:49'),
(1441, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-08-01 To: 2026-08-31)', '2409:40f2:304:ec3d:8000::', '2026-09-08 14:38:54'),
(1442, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:340:f12c:8000::', '2026-09-10 14:04:30'),
(1443, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:340:f12c:8000::', '2026-09-10 14:04:35'),
(1444, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:340:f12c:8000::', '2026-09-10 14:04:47'),
(1445, 15, 'Collect Payment', 'Recorded payment of ₹600.00 from Retailer ID: 25 using Method: Cash', '2409:40f2:340:f12c:8000::', '2026-09-10 14:05:17'),
(1446, 15, 'Collect Payment', 'Recorded payment of ₹1,500.00 from Retailer ID: 53 using Method: Cash', '2409:40f2:340:f12c:8000::', '2026-09-10 14:06:03'),
(1447, 15, 'Collect Payment', 'Recorded payment of ₹1,000.00 from Retailer ID: 55 using Method: Cash', '2409:40f2:340:f12c:8000::', '2026-09-10 14:06:31'),
(1448, 15, 'Collect Payment', 'Recorded payment of ₹500.00 from Retailer ID: 26 using Method: Cash', '2409:40f2:340:f12c:8000::', '2026-09-10 14:06:51'),
(1449, 15, 'Collect Payment', 'Recorded payment of ₹500.00 from Retailer ID: 27 using Method: Cash', '2409:40f2:340:f12c:8000::', '2026-09-10 14:07:17'),
(1450, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:340:f12c:8000::', '2026-09-10 15:50:05'),
(1451, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1029:7828:8000::', '2026-09-11 02:50:27'),
(1452, 15, 'Create Order', 'Staff created Order ID: 86 for Retailer ID: 56. Grand Total: 1300', '2409:40f2:1029:7828:8000::', '2026-09-11 02:56:19'),
(1453, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:204c:c48a:8000::', '2026-09-12 05:30:55'),
(1454, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:204c:c48a:8000::', '2026-09-12 05:31:24'),
(1455, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:204c:c48a:8000::', '2026-09-12 05:31:38'),
(1456, 1, 'Update Retailer', 'Updated retailer profile: BASAVESHWAR TRADERS (ID: 40)', '2409:40f2:204c:c48a:8000::', '2026-09-12 05:32:51'),
(1457, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:204c:c48a:8000::', '2026-09-12 05:33:18'),
(1458, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:204c:c48a:8000::', '2026-09-12 05:33:29'),
(1459, 15, 'Create Order', 'Staff created Order ID: 87 for Retailer ID: 40. Grand Total: 3000', '2409:40f2:204c:c48a:8000::', '2026-09-12 05:34:56'),
(1460, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.191.58', '2026-09-12 05:55:41'),
(1461, 1, 'Update Order Status', 'Owner updated Order ID: 86 to Status: Approved', '157.50.191.58', '2026-09-12 05:56:19'),
(1462, 1, 'Update Order Status', 'Owner updated Order ID: 87 to Status: Approved', '157.50.191.58', '2026-09-12 05:56:26'),
(1463, 1, 'Generate Invoice', 'Invoiced Order ID: 86 -> Invoice No: NE/2026-27/0073. Grand Total: 1300', '157.50.191.58', '2026-09-12 05:56:55'),
(1464, 1, 'Update SKU', 'Updated SKU ID: 40 (GINGER GARLIC PASTE 5RS)', '152.57.126.27', '2026-09-12 06:07:27'),
(1465, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 480 units to SKU APPALAM.', '152.57.126.27', '2026-09-12 06:17:03'),
(1466, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 1000 units to SKU GINGER GARLIC PASTE 5RS.', '152.57.126.27', '2026-09-12 06:17:03'),
(1467, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 4 units to SKU TURMERIC POWDER 5KG.', '152.57.126.27', '2026-09-12 06:17:03'),
(1468, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 50 units to SKU TURMERIC POWDER SHEET 10RS.', '152.57.126.27', '2026-09-12 06:17:03'),
(1469, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 240 units to SKU APPALAM.', '152.57.126.27', '2026-09-12 06:17:03'),
(1470, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 480 units to SKU APPALAM.', '152.57.126.27', '2026-09-12 06:18:14'),
(1471, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 1000 units to SKU GINGER GARLIC PASTE 5RS.', '152.57.126.27', '2026-09-12 06:18:14'),
(1472, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 4 units to SKU TURMERIC POWDER 5KG.', '152.57.126.27', '2026-09-12 06:18:14'),
(1473, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 50 units to SKU TURMERIC POWDER SHEET 10RS.', '152.57.126.27', '2026-09-12 06:18:14'),
(1474, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 240 units to SKU APPALAM.', '152.57.126.27', '2026-09-12 06:18:14'),
(1475, 1, 'Generate Invoice', 'Invoiced Order ID: 87 -> Invoice No: NE/2026-27/0074. Grand Total: 3000', '152.57.126.27', '2026-09-12 06:18:54'),
(1476, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:344:c33f:8000::', '2026-09-12 08:23:45'),
(1477, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:344:c33f:8000::', '2026-09-12 08:41:59'),
(1478, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:344:c33f:8000::', '2026-09-12 08:42:10'),
(1479, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:40:de6f:8000::', '2026-09-12 12:49:58'),
(1480, 15, 'Create Order', 'Staff created Order ID: 88 for Retailer ID: 34. Grand Total: 260', '2409:40f2:40:de6f:8000::', '2026-09-12 12:50:43'),
(1481, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:32:a238:8000::', '2026-09-13 15:49:03'),
(1482, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:12e:68c7:8000::', '2026-09-16 13:16:18'),
(1483, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹100.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:12e:68c7:8000::', '2026-09-16 13:19:21'),
(1484, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹270.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:12e:68c7:8000::', '2026-09-16 13:20:04'),
(1485, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹80.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:12e:68c7:8000::', '2026-09-16 13:20:34'),
(1486, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹80.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:12e:68c7:8000::', '2026-09-16 13:22:29'),
(1487, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1005:f3b0:8000::', '2026-09-17 14:28:38'),
(1488, 15, 'Collect Payment', 'Recorded payment of ₹396.00 from Retailer ID: 16 using Method: Cash', '2409:40f2:1005:f3b0:8000::', '2026-09-17 14:29:20'),
(1489, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:1005:f3b0:8000::', '2026-09-17 14:29:30'),
(1490, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1005:f3b0:8000::', '2026-09-17 14:29:45'),
(1491, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹100.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1005:f3b0:8000::', '2026-09-17 14:30:09'),
(1492, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:125:df09:8000::', '2026-09-18 05:10:58'),
(1493, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:125:df09:8000::', '2026-09-18 07:23:35'),
(1494, 1, 'Collect Payment', 'Recorded payment of ₹1,144.00 from Retailer ID: 59 using Method: UPI', '2409:40f2:125:df09:8000::', '2026-09-18 07:24:29'),
(1495, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:125:df09:8000::', '2026-09-18 07:37:26'),
(1496, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:125:df09:8000::', '2026-09-18 07:37:40'),
(1497, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:125:df09:8000::', '2026-09-18 07:39:15'),
(1498, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:125:df09:8000::', '2026-09-18 07:39:27'),
(1499, 1, 'Inventory Purchase Entry', 'Added 400 units to SKU SHRI KRISHNA 10RS SHEET COW GHEE via Purchase Entry.', '2409:40f2:125:df09:8000::', '2026-09-18 07:43:44'),
(1500, 1, 'Inventory Purchase Entry', 'Added 200 units to SKU SHRI KRISHNA 20 RS SHEET COW GHEE via Purchase Entry.', '2409:40f2:125:df09:8000::', '2026-09-18 07:43:44'),
(1501, 1, 'Inventory Purchase Entry', 'Added 480 units to SKU APPALAM via Purchase Entry.', '2409:40f2:125:df09:8000::', '2026-09-18 07:43:44'),
(1502, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:125:df09:8000::', '2026-09-18 07:48:49'),
(1503, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:125:df09:8000::', '2026-09-18 07:49:27'),
(1504, 15, 'Create Order', 'Staff created Order ID: 89 for Retailer ID: 59. Grand Total: 333.48', '2409:40f2:125:df09:8000::', '2026-09-18 07:50:11'),
(1505, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:201b:3c2e:8000::', '2026-09-18 07:51:06'),
(1506, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:201b:3c2e:8000::', '2026-09-18 07:51:16'),
(1507, 15, 'Create Order', 'Staff created Order ID: 90 for Retailer ID: 60. Grand Total: 1693.355', '2409:40f2:201b:3c2e:8000::', '2026-09-18 07:53:00'),
(1508, 15, 'Create Order', 'Staff created Order ID: 91 for Retailer ID: 33. Grand Total: 539.028', '2409:40f2:201b:3c2e:8000::', '2026-09-18 07:54:24'),
(1509, 15, 'Create Order', 'Staff created Order ID: 92 for Retailer ID: 16. Grand Total: 89.838', '2409:40f2:201b:3c2e:8000::', '2026-09-18 07:56:16'),
(1510, 15, 'Create Order', 'Staff created Order ID: 93 for Retailer ID: 8. Grand Total: 549.99', '2409:40f2:201b:3c2e:8000::', '2026-09-18 08:02:38'),
(1511, 15, 'Create Order', 'Staff created Order ID: 94 for Retailer ID: 18. Grand Total: 89.838', '2409:40f2:201b:3c2e:8000::', '2026-09-18 08:05:14'),
(1512, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '157.50.201.228', '2026-09-18 10:22:11'),
(1513, 1, 'Update Order Status', 'Owner updated Order ID: 88 to Status: Approved', '157.50.201.228', '2026-09-18 10:23:29'),
(1514, 1, 'Update Order Status', 'Owner updated Order ID: 89 to Status: Approved', '157.50.201.228', '2026-09-18 10:23:54'),
(1515, 1, 'Generate Invoice', 'Invoiced Order ID: 89 -> Invoice No: NE/2026-27/0075. Grand Total: 333.48', '157.50.201.228', '2026-09-18 10:26:19'),
(1516, 1, 'Generate Invoice', 'Invoiced Order ID: 88 -> Invoice No: NE/2026-27/0076. Grand Total: 260', '157.50.201.228', '2026-09-18 10:27:02'),
(1517, 1, 'Update Order Status', 'Owner updated Order ID: 90 to Status: Approved', '157.50.201.228', '2026-09-18 10:28:09'),
(1518, 1, 'Generate Invoice', 'Invoiced Order ID: 90 -> Invoice No: NE/2026-27/0077. Grand Total: 1693.36', '157.50.201.228', '2026-09-18 10:28:17'),
(1519, 1, 'Update Order Status', 'Owner updated Order ID: 91 to Status: Approved', '157.50.201.228', '2026-09-18 10:28:46'),
(1520, 1, 'Generate Invoice', 'Invoiced Order ID: 91 -> Invoice No: NE/2026-27/0078. Grand Total: 539.03', '157.50.201.228', '2026-09-18 10:29:01'),
(1521, 1, 'Update Order Status', 'Owner updated Order ID: 92 to Status: Approved', '157.50.201.228', '2026-09-18 10:29:30'),
(1522, 1, 'Generate Invoice', 'Invoiced Order ID: 92 -> Invoice No: NE/2026-27/0079. Grand Total: 89.84', '157.50.201.228', '2026-09-18 10:29:43'),
(1523, 1, 'Update Order Status', 'Owner updated Order ID: 93 to Status: Approved', '157.50.201.228', '2026-09-18 10:30:14'),
(1524, 1, 'Generate Invoice', 'Invoiced Order ID: 93 -> Invoice No: NE/2026-27/0080. Grand Total: 549.99', '157.50.201.228', '2026-09-18 10:30:23'),
(1525, 1, 'Update Order Status', 'Owner updated Order ID: 94 to Status: Approved', '157.50.201.228', '2026-09-18 10:30:58'),
(1526, 1, 'Generate Invoice', 'Invoiced Order ID: 94 -> Invoice No: NE/2026-27/0081. Grand Total: 89.84', '157.50.201.228', '2026-09-18 10:31:09'),
(1527, 1, 'Collect Payment', 'Recorded payment of ₹260.00 from Retailer ID: 34 using Method: Cash', '157.50.201.228', '2026-09-18 10:33:22'),
(1528, 1, 'Collect Payment', 'Recorded payment of ₹260.00 from Retailer ID: 34 using Method: Cash', '157.50.201.228', '2026-09-18 10:33:22'),
(1529, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:201b:3c2e:8000::', '2026-09-18 12:54:17'),
(1530, 1, 'Collect Payment', 'Recorded payment of ₹1,524.00 from Retailer ID: 60 using Method: Cash', '2409:40f2:201b:3c2e:8000::', '2026-09-18 12:55:22'),
(1531, 1, 'Collect Payment', 'Recorded payment of ₹1,229.00 from Retailer ID: 33 using Method: Cash', '2409:40f2:201b:3c2e:8000::', '2026-09-18 12:56:22'),
(1532, 1, 'Collect Payment', 'Recorded payment of ₹90.00 from Retailer ID: 16 using Method: Cash', '2409:40f2:201b:3c2e:8000::', '2026-09-18 13:15:35'),
(1533, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:201b:3c2e:8000::', '2026-09-18 13:29:19'),
(1534, 1, 'Collect Payment', 'Recorded payment of ₹90.00 from Retailer ID: 18 using Method: Cash', '2409:40f2:201b:3c2e:8000::', '2026-09-18 13:29:42'),
(1535, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:34c:709:8000::', '2026-09-18 15:01:28'),
(1536, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹50.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:34c:709:8000::', '2026-09-18 15:01:53'),
(1537, 1, 'Create Expense', 'Recorded expense: Miscellaneous of ₹50.00 + GST ₹0.00 paid to  via Cash', '2409:40f2:34c:709:8000::', '2026-09-18 15:02:32'),
(1538, 1, 'Create Expense', 'Recorded expense: Miscellaneous of ₹20.00 + GST ₹0.00 paid to transport via Cash', '2409:40f2:34c:709:8000::', '2026-09-18 15:02:54'),
(1539, 1, 'Update Expense', 'Updated expense ID: 32 (Miscellaneous) via Cash', '2409:40f2:34c:709:8000::', '2026-09-18 15:03:08'),
(1540, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2051:90f2:8000::', '2026-09-19 10:49:42'),
(1541, 1, 'Collect Payment', 'Recorded payment of ₹1,893.00 from Retailer ID: 25 using Method: UPI', '2409:40f2:2051:90f2:8000::', '2026-09-19 10:50:21'),
(1542, 1, 'Collect Payment', 'Recorded payment of ₹768.00 from Retailer ID: 53 using Method: Cash', '2409:40f2:2051:90f2:8000::', '2026-09-19 10:58:36'),
(1543, 1, 'Collect Payment', 'Recorded payment of ₹1,200.00 from Retailer ID: 52 using Method: Cash', '2409:40f2:2051:90f2:8000::', '2026-09-19 10:59:20'),
(1544, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2051:90f2:8000::', '2026-09-19 11:18:55'),
(1545, 1, 'Collect Payment', 'Recorded payment of ₹300.00 from Retailer ID: 26 using Method: Cash', '2409:40f2:2051:90f2:8000::', '2026-09-19 11:19:35'),
(1546, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:2051:90f2:8000::', '2026-09-19 11:20:30'),
(1547, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.103.73', '2026-09-21 04:43:48'),
(1548, 1, 'Create SKU', 'Created SKU: VINAYAKA SATIN PLUS ZIPPER (Code: INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-SATIN-PLUS-ZIPPER) with opening stock 0', '152.57.103.73', '2026-09-21 04:46:42'),
(1549, 1, 'Update SKU', 'Updated SKU ID: 44 (VINAYAKA SATIN PLUS ZIPPER)', '152.57.103.73', '2026-09-21 04:47:36'),
(1550, 1, 'Create Product', 'Created product: JAR DHOOP under Brand ID: 6', '152.57.103.73', '2026-09-21 04:48:40'),
(1551, 1, 'Create Product', 'Created product: CONE JAR under Brand ID: 6', '152.57.103.73', '2026-09-21 04:49:05'),
(1552, 1, 'Create SKU', 'Created SKU: VINAYAKA JAR DHOOP  STICKS  MIX (Code: INCENSE-STICKS-JAR-DHOOP-VINAYAKA-JAR-DHOOP-STICKS-MIX) with opening stock 0', '152.57.103.73', '2026-09-21 04:51:19'),
(1553, 1, 'Create SKU', 'Created SKU: VINAYAKA CONE JAR MIX (Code: INCENSE-STICKS-CONE-JAR-VINAYAKA-CONE-JAR-MIX) with opening stock 0', '152.57.103.73', '2026-09-21 04:53:23'),
(1554, 1, 'Inventory Purchase Entry', 'Added 48 units to SKU VINAYAKA CUP DHOOP SAMBRANI via Purchase Entry.', '152.57.103.73', '2026-09-21 05:00:13'),
(1555, 1, 'Inventory Purchase Entry', 'Added 48 units to SKU VINAYAKA CUP DHOOP GUGGAL via Purchase Entry.', '152.57.103.73', '2026-09-21 05:00:13'),
(1556, 1, 'Inventory Purchase Entry', 'Added 48 units to SKU VINAYAKA CUP DHOOP MANGAL via Purchase Entry.', '152.57.103.73', '2026-09-21 05:00:13'),
(1557, 1, 'Inventory Purchase Entry', 'Added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS via Purchase Entry.', '152.57.103.73', '2026-09-21 05:00:13'),
(1558, 1, 'Inventory Purchase Entry', 'Added 96 units to SKU VINAYAKA KASTURI ZIPPER PACK via Purchase Entry.', '152.57.103.73', '2026-09-21 05:00:13'),
(1559, 1, 'Inventory Purchase Entry', 'Added 120 units to SKU VINAYAKA DREAMS ZIPPER PACKS via Purchase Entry.', '152.57.103.73', '2026-09-21 05:00:13'),
(1560, 1, 'Inventory Purchase Entry', 'Added 96 units to SKU VINAYAKA SATIN PLUS ZIPPER via Purchase Entry.', '152.57.103.73', '2026-09-21 05:00:13'),
(1561, 1, 'Inventory Purchase Entry', 'Added 96 units to SKU VINAYAKA JAR DHOOP  STICKS  MIX via Purchase Entry.', '152.57.103.73', '2026-09-21 05:00:13'),
(1562, 1, 'Inventory Purchase Entry', 'Added 96 units to SKU VINAYAKA CONE JAR MIX via Purchase Entry.', '152.57.103.73', '2026-09-21 05:00:13'),
(1563, 1, 'Update SKU', 'Updated SKU ID: 46 (VINAYAKA CONE JAR MIX)', '152.57.103.73', '2026-09-21 05:06:42'),
(1564, 1, 'Update SKU', 'Updated SKU ID: 45 (VINAYAKA JAR DHOOP  STICKS  MIX)', '152.57.103.73', '2026-09-21 05:07:18'),
(1565, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP SAMBRANI.', '152.57.103.73', '2026-09-21 05:08:27'),
(1566, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP GUGGAL.', '152.57.103.73', '2026-09-21 05:08:27'),
(1567, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP MANGAL.', '152.57.103.73', '2026-09-21 05:08:27'),
(1568, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.103.73', '2026-09-21 05:08:27'),
(1569, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 96 units to SKU VINAYAKA KASTURI ZIPPER PACK.', '152.57.103.73', '2026-09-21 05:08:27'),
(1570, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DREAMS ZIPPER PACKS.', '152.57.103.73', '2026-09-21 05:08:27'),
(1571, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 96 units to SKU VINAYAKA SATIN PLUS ZIPPER.', '152.57.103.73', '2026-09-21 05:08:27'),
(1572, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 96 units to SKU VINAYAKA JAR DHOOP  STICKS  MIX.', '152.57.103.73', '2026-09-21 05:08:27'),
(1573, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 96 units to SKU VINAYAKA CONE JAR MIX.', '152.57.103.73', '2026-09-21 05:08:27'),
(1574, 1, 'Update SKU', 'Updated SKU ID: 38 (VINAYAKA CUP DHOOP SAMBRANI)', '152.57.103.73', '2026-09-21 05:17:32'),
(1575, 1, 'Update SKU', 'Updated SKU ID: 37 (VINAYAKA CUP DHOOP GUGGAL)', '152.57.103.73', '2026-09-21 05:18:15'),
(1576, 1, 'Update SKU', 'Updated SKU ID: 37 (VINAYAKA CUP DHOOP GUGGAL)', '152.57.103.73', '2026-09-21 05:23:28'),
(1577, 1, 'Update SKU', 'Updated SKU ID: 38 (VINAYAKA CUP DHOOP SAMBRANI)', '152.57.103.73', '2026-09-21 05:24:51'),
(1578, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP SAMBRANI.', '152.57.103.73', '2026-09-21 05:31:26'),
(1579, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP GUGGAL.', '152.57.103.73', '2026-09-21 05:31:26'),
(1580, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 48 units to SKU VINAYAKA CUP DHOOP MANGAL.', '152.57.103.73', '2026-09-21 05:31:26');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `ip_address`, `created_at`) VALUES
(1581, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA WILD PURPLE ZIPPER PACKS.', '152.57.103.73', '2026-09-21 05:31:26'),
(1582, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 96 units to SKU VINAYAKA KASTURI ZIPPER PACK.', '152.57.103.73', '2026-09-21 05:31:26'),
(1583, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 120 units to SKU VINAYAKA DREAMS ZIPPER PACKS.', '152.57.103.73', '2026-09-21 05:31:26'),
(1584, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 96 units to SKU VINAYAKA SATIN PLUS ZIPPER.', '152.57.103.73', '2026-09-21 05:31:26'),
(1585, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 96 units to SKU VINAYAKA JAR DHOOP  STICKS  MIX.', '152.57.103.73', '2026-09-21 05:31:26'),
(1586, 1, 'Inventory Purchase Entry Update', 'Updated purchase items: added 96 units to SKU VINAYAKA CONE JAR MIX.', '152.57.103.73', '2026-09-21 05:31:26'),
(1587, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:7:4434:8000::', '2026-09-21 05:44:07'),
(1588, 15, 'Create Order', 'Staff created Order ID: 95 for Retailer ID: 53. Grand Total: 1099.98', '2409:40f2:7:4434:8000::', '2026-09-21 05:44:57'),
(1589, 1, 'Update Order Status', 'Owner updated Order ID: 95 to Status: Approved', '152.57.103.73', '2026-09-21 05:47:11'),
(1590, 1, 'Generate Invoice', 'Invoiced Order ID: 95 -> Invoice No: NE/2026-27/0082. Grand Total: 1099.98', '152.57.103.73', '2026-09-21 05:47:19'),
(1591, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:7:4434:8000::', '2026-09-21 11:59:01'),
(1592, 15, 'Collect Payment', 'Recorded payment of ₹200.00 from Retailer ID: 39 using Method: Cash', '2409:40f2:7:4434:8000::', '2026-09-21 12:00:07'),
(1593, 15, 'Collect Payment', 'Recorded payment of ₹960.00 from Retailer ID: 41 using Method: Cash', '152.57.28.75', '2026-09-21 12:03:21'),
(1594, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1002:a270:8000::', '2026-09-21 13:15:37'),
(1595, 15, 'Collect Payment', 'Recorded payment of ₹600.00 from Retailer ID: 45 using Method: Cash', '2409:40f2:1002:a270:8000::', '2026-09-21 13:16:34'),
(1596, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1002:a270:8000::', '2026-09-22 01:57:33'),
(1597, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1002:a270:8000::', '2026-09-22 04:19:23'),
(1598, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:1002:a270:8000::', '2026-09-22 04:21:17'),
(1599, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1002:a270:8000::', '2026-09-22 04:21:33'),
(1600, 15, 'Create Order', 'Staff created Order ID: 96 for Retailer ID: 51. Grand Total: 1049.4845', '2409:40f2:1002:a270:8000::', '2026-09-22 04:22:46'),
(1601, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311e:c029:8000::', '2026-09-22 06:29:55'),
(1602, 15, 'Collect Payment', 'Recorded payment of ₹1,299.90 from Retailer ID: 56 using Method: Cash', '2409:40f2:311e:c029:8000::', '2026-09-22 06:30:20'),
(1603, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311e:c029:8000::', '2026-09-22 09:09:35'),
(1604, 15, 'Create Order', 'Staff created Order ID: 97 for Retailer ID: 49. Grand Total: 577.521', '2409:40f2:311e:c029:8000::', '2026-09-22 09:11:03'),
(1605, 15, 'Create Order', 'Staff created Order ID: 98 for Retailer ID: 50. Grand Total: 130', '2409:40f2:311e:c029:8000::', '2026-09-22 09:11:58'),
(1606, 15, 'Update Retailer', 'Updated retailer profile: SHRI JYOTIRLING GENERAL STORES (ID: 51)', '2409:40f2:311e:c029:8000::', '2026-09-22 09:14:00'),
(1607, 15, 'Create Retailer', 'Created retailer Akunti General store (Owner: )', '2409:40f2:311e:c029:8000::', '2026-09-22 09:16:41'),
(1608, 15, 'Create Retailer', 'Created retailer VENKATESHWAR CO OPERATIVE POWER LTD (Owner: )', '2409:40f2:311e:c029:8000::', '2026-09-22 09:19:46'),
(1609, 15, 'Create Retailer', 'Created retailer C G Kadolkar (Owner: )', '2409:40f2:311e:c029:8000::', '2026-09-22 09:21:02'),
(1610, 15, 'Create Retailer', 'Created retailer MOURYA GENERAL STORES (Owner: )', '2409:40f2:311e:c029:8000::', '2026-09-22 09:22:25'),
(1611, 15, 'Create Retailer', 'Created retailer Mark General store (Owner: )', '2409:40f2:311e:c029:8000::', '2026-09-22 09:23:15'),
(1612, 15, 'Update Retailer', 'Updated retailer profile: C G Kadolkar kirana store (ID: 63)', '2409:40f2:311e:c029:8000::', '2026-09-22 09:23:31'),
(1613, 15, 'Create Order', 'Staff created Order ID: 99 for Retailer ID: 63. Grand Total: 983.27', '2409:40f2:311e:c029:8000::', '2026-09-22 09:26:04'),
(1614, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:311e:c029:8000::', '2026-09-22 09:26:44'),
(1615, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:311e:c029:8000::', '2026-09-22 09:27:17'),
(1616, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:311e:c029:8000::', '2026-09-22 09:28:36'),
(1617, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:311e:c029:8000::', '2026-09-22 10:26:49'),
(1618, 1, 'Delete Discount', 'Deleted discount ID: 12', '2409:40f2:311e:c029:8000::', '2026-09-22 10:27:13'),
(1619, 1, 'Delete Discount', 'Deleted discount ID: 13', '2409:40f2:311e:c029:8000::', '2026-09-22 10:27:15'),
(1620, 1, 'Delete Discount', 'Deleted discount ID: 11', '2409:40f2:311e:c029:8000::', '2026-09-22 10:27:17'),
(1621, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '2409:40f2:311e:c029:8000::', '2026-09-22 10:27:31'),
(1622, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:311e:c029:8000::', '2026-09-22 10:27:51'),
(1623, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311e:c029:8000::', '2026-09-22 10:28:03'),
(1624, 15, 'Create Order', 'Staff created Order ID: 100 for Retailer ID: 61. Grand Total: 140', '2409:40f2:311e:c029:8000::', '2026-09-22 10:28:59'),
(1625, 15, 'Create Order', 'Staff created Order ID: 101 for Retailer ID: 64. Grand Total: 563.318', '2409:40f2:311e:c029:8000::', '2026-09-22 10:31:37'),
(1626, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:311e:c029:8000::', '2026-09-22 10:32:36'),
(1627, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:311e:c029:8000::', '2026-09-22 10:32:55'),
(1628, 1, 'Delete Discount', 'Deleted discount ID: 29', '2409:40f2:311e:c029:8000::', '2026-09-22 10:33:23'),
(1629, 1, 'Update SKU', 'Updated SKU ID: 17 (APPALAM)', '2409:40f2:311e:c029:8000::', '2026-09-22 10:34:10'),
(1630, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:311e:c029:8000::', '2026-09-22 10:34:18'),
(1631, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:311e:c029:8000::', '2026-09-22 10:34:31'),
(1632, 15, 'Create Order', 'Staff created Order ID: 102 for Retailer ID: 62. Grand Total: 2357.373', '2409:40f2:311e:c029:8000::', '2026-09-22 10:36:47'),
(1633, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:311e:c029:8000::', '2026-09-22 10:37:06'),
(1634, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:311e:c029:8000::', '2026-09-22 10:37:19'),
(1635, 1, 'Update SKU', 'Updated SKU ID: 17 (APPALAM)', '2409:40f2:311e:c029:8000::', '2026-09-22 10:37:38'),
(1636, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:311e:c029:8000::', '2026-09-22 10:37:54'),
(1637, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.78.127', '2026-09-22 11:21:58'),
(1638, 1, 'Update Order Status', 'Owner updated Order ID: 96 to Status: Approved', '152.57.78.127', '2026-09-22 11:22:21'),
(1639, 1, 'Generate Invoice', 'Invoiced Order ID: 96 -> Invoice No: NE/2026-27/0083. Grand Total: 1049.48', '152.57.78.127', '2026-09-22 11:24:01'),
(1640, 1, 'Collect Payment', 'Recorded payment of ₹1,050.00 from Retailer ID: 51 using Method: Cash', '152.57.78.127', '2026-09-22 11:24:44'),
(1641, 1, 'Update Order Status', 'Owner updated Order ID: 97 to Status: Approved', '152.57.78.127', '2026-09-22 11:25:00'),
(1642, 1, 'Generate Invoice', 'Invoiced Order ID: 97 -> Invoice No: NE/2026-27/0084. Grand Total: 577.52', '152.57.78.127', '2026-09-22 11:25:08'),
(1643, 1, 'Update Order Status', 'Owner updated Order ID: 98 to Status: Approved', '152.57.78.127', '2026-09-22 11:26:06'),
(1644, 1, 'Generate Invoice', 'Invoiced Order ID: 98 -> Invoice No: NE/2026-27/0085. Grand Total: 130', '152.57.78.127', '2026-09-22 11:26:13'),
(1645, 1, 'Update Order Status', 'Owner updated Order ID: 99 to Status: Approved', '152.57.78.127', '2026-09-22 11:27:01'),
(1646, 1, 'Generate Invoice', 'Invoiced Order ID: 99 -> Invoice No: NE/2026-27/0086. Grand Total: 983.27', '152.57.78.127', '2026-09-22 11:27:19'),
(1647, 1, 'Update Order Status', 'Owner updated Order ID: 100 to Status: Approved', '152.57.78.127', '2026-09-22 11:27:55'),
(1648, 1, 'Generate Invoice', 'Invoiced Order ID: 100 -> Invoice No: NE/2026-27/0087. Grand Total: 140', '152.57.78.127', '2026-09-22 11:28:09'),
(1649, 1, 'Update Order Status', 'Owner updated Order ID: 101 to Status: Approved', '152.57.78.127', '2026-09-22 11:28:33'),
(1650, 1, 'Generate Invoice', 'Invoiced Order ID: 101 -> Invoice No: NE/2026-27/0088. Grand Total: 563.32', '152.57.78.127', '2026-09-22 11:28:46'),
(1651, 1, 'Update Order Status', 'Owner updated Order ID: 102 to Status: Approved', '152.57.78.127', '2026-09-22 11:29:08'),
(1652, 1, 'Generate Invoice', 'Invoiced Order ID: 102 -> Invoice No: NE/2026-27/0089. Grand Total: 2357.37', '152.57.78.127', '2026-09-22 11:29:26'),
(1653, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311e:c029:8000::', '2026-09-22 11:45:33'),
(1654, 15, 'Create Order', 'Staff created Order ID: 103 for Retailer ID: 51. Grand Total: 1084.6215', '2409:40f2:311e:c029:8000::', '2026-09-22 11:46:49'),
(1655, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.78.127', '2026-09-22 11:47:07'),
(1656, 1, 'Update Order Status', 'Owner updated Order ID: 103 to Status: Approved', '152.57.78.127', '2026-09-22 11:47:21'),
(1657, 1, 'Generate Invoice', 'Invoiced Order ID: 103 -> Invoice No: NE/2026-27/0090. Grand Total: 1084.62', '152.57.78.127', '2026-09-22 11:47:45'),
(1658, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:311e:c029:8000::', '2026-09-22 13:09:12'),
(1659, 15, 'Collect Payment', 'Recorded payment of ₹129.94 from Retailer ID: 50 using Method: Cash', '2409:40f2:311e:c029:8000::', '2026-09-22 13:09:33'),
(1660, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2134:383:8000::', '2026-09-23 03:56:41'),
(1661, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹220.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:2134:383:8000::', '2026-09-23 03:58:00'),
(1662, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹50.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:2134:383:8000::', '2026-09-23 03:58:40'),
(1663, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹100.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:2134:383:8000::', '2026-09-23 03:58:57'),
(1664, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:2134:383:8000::', '2026-09-23 08:18:12'),
(1665, 15, 'Collect Payment', 'Recorded payment of ₹180.00 from Retailer ID: 12 using Method: Cash', '2409:40f2:2134:383:8000::', '2026-09-23 08:18:35'),
(1666, 15, 'Collect Payment', 'Recorded payment of ₹658.00 from Retailer ID: 15 using Method: Cash', '2409:40f2:2134:383:8000::', '2026-09-23 08:19:03'),
(1667, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:2134:383:8000::', '2026-09-23 08:19:28'),
(1668, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1039:8f5a:8000::', '2026-09-23 08:49:27'),
(1669, 15, 'Login', 'User Shreyansh_ logged in successfully.', '2409:40f2:1039:8f5a:8000::', '2026-09-23 10:42:52'),
(1670, 15, 'Create Retailer', 'Created retailer M G PAN SHOP (Owner: )', '2409:40f2:1039:8f5a:8000::', '2026-09-23 10:44:41'),
(1671, 15, 'Create Retailer', 'Created retailer KHUSRO GENERAL STORES (Owner: )', '2409:40f2:1039:8f5a:8000::', '2026-09-23 10:46:30'),
(1672, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:1039:8f5a:8000::', '2026-09-23 10:48:04'),
(1673, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1039:8f5a:8000::', '2026-09-23 10:48:17'),
(1674, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 39', '2409:40f2:1039:8f5a:8000::', '2026-09-23 10:49:47'),
(1675, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 38', '2409:40f2:1039:8f5a:8000::', '2026-09-23 10:50:03'),
(1676, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 37', '2409:40f2:1039:8f5a:8000::', '2026-09-23 10:50:19'),
(1677, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:1039:8f5a:8000::', '2026-09-23 10:53:12'),
(1678, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1039:8f5a:8000::', '2026-09-23 10:53:28'),
(1679, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:1039:8f5a:8000::', '2026-09-24 00:52:18'),
(1680, 15, 'Create Order', 'Staff created Order ID: 104 for Retailer ID: 18. Grand Total: 239.4', '2409:40f2:1039:8f5a:8000::', '2026-09-24 00:53:16'),
(1681, 15, 'Create Order', 'Staff created Order ID: 105 for Retailer ID: 66. Grand Total: 532.035', '2409:40f2:1039:8f5a:8000::', '2026-09-24 00:54:18'),
(1682, 15, 'Create Order', 'Staff created Order ID: 106 for Retailer ID: 67. Grand Total: 379.134', '2409:40f2:1039:8f5a:8000::', '2026-09-24 00:58:02'),
(1683, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:1039:8f5a:8000::', '2026-09-24 00:58:23'),
(1684, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1039:8f5a:8000::', '2026-09-24 00:58:35'),
(1685, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:35e:9ab6:8000::', '2026-09-24 01:50:43'),
(1686, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:19:4d31:8000::', '2026-09-24 05:24:06'),
(1687, 1, 'Logout', 'User NAVATARA_06 logged out.', '2409:40f2:19:4d31:8000::', '2026-09-24 05:24:38'),
(1688, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:19:4d31:8000::', '2026-09-24 05:24:48'),
(1689, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:2177:dc53:8000::', '2026-09-27 10:53:29'),
(1690, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:1032:4b60:8000::', '2026-09-28 04:25:22'),
(1691, 1, 'Collect Payment', 'Recorded payment of ₹300.00 from Retailer ID: 26 using Method: Cash', '2409:40f2:1032:4b60:8000::', '2026-09-28 04:27:57'),
(1692, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹50.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1032:4b60:8000::', '2026-09-28 04:28:31'),
(1693, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹100.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:1032:4b60:8000::', '2026-09-28 04:34:15'),
(1694, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '2409:40f2:213b:96fd:8000::', '2026-09-28 11:59:00'),
(1695, 1, 'Collect Payment', 'Recorded payment of ₹200.00 from Retailer ID: 39 using Method: Cash', '2409:40f2:213b:96fd:8000::', '2026-09-28 11:59:30'),
(1696, 1, 'Collect Payment', 'Recorded payment of ₹500.00 from Retailer ID: 45 using Method: Cash', '2409:40f2:213b:96fd:8000::', '2026-09-28 11:59:51'),
(1697, 1, 'Login', 'User NAVATARA_06 logged in successfully.', '152.57.134.85', '2026-09-29 04:24:53'),
(1698, 1, 'Update Profile', 'Updated owner profile details.', '152.57.134.85', '2026-09-29 04:25:42'),
(1699, 1, 'Logout', 'User NAVATARA_03 logged out.', '152.57.134.85', '2026-09-29 04:25:51'),
(1700, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '152.57.134.85', '2026-09-29 04:26:36'),
(1701, 1, 'Logout', 'User NAVATARA_03 logged out.', '152.57.134.85', '2026-09-29 04:27:18'),
(1702, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '152.57.134.85', '2026-09-29 04:27:35'),
(1703, 1, 'Update Order Status', 'Owner updated Order ID: 104 to Status: Approved', '152.57.134.85', '2026-09-29 04:27:56'),
(1704, 1, 'Generate Invoice', 'Invoiced Order ID: 104 -> Invoice No: NE/2026-27/0091. Grand Total: 239.4', '152.57.134.85', '2026-09-29 04:28:02'),
(1705, 1, 'Update Order Status', 'Owner updated Order ID: 105 to Status: Approved', '152.57.134.85', '2026-09-29 04:28:21'),
(1706, 1, 'Generate Invoice', 'Invoiced Order ID: 105 -> Invoice No: NE/2026-27/0092. Grand Total: 532.04', '152.57.134.85', '2026-09-29 04:28:30'),
(1707, 1, 'Update Order Status', 'Owner updated Order ID: 106 to Status: Approved', '152.57.134.85', '2026-09-29 04:28:42'),
(1708, 1, 'Generate Invoice', 'Invoiced Order ID: 106 -> Invoice No: NE/2026-27/0093. Grand Total: 379.13', '152.57.134.85', '2026-09-29 04:28:49'),
(1709, 1, 'Collect Payment', 'Recorded payment of ₹239.00 from Retailer ID: 18 using Method: Cash', '152.57.134.85', '2026-09-29 04:29:22'),
(1710, 1, 'Update Retailer', 'Updated retailer profile: CHANDRAKANTH GENERAL STORES (ID: 60)', '152.57.134.85', '2026-09-29 04:30:44'),
(1711, 1, 'Update Retailer', 'Updated retailer profile: VENKATESHWAR CO OPERATIVE POWER LTD (ID: 62)', '152.57.134.85', '2026-09-29 04:31:51'),
(1712, 1, 'Update Retailer', 'Updated retailer profile: SUNIL GENERAL STORES (ID: 49)', '152.57.134.85', '2026-09-29 04:32:33'),
(1713, 1, 'Update Retailer', 'Updated retailer profile: PRAVEEN PAWAR COCONUT (ID: 54)', '152.57.134.85', '2026-09-29 04:34:27'),
(1714, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:303:9e6a:8000::', '2026-09-29 04:56:04'),
(1715, 1, 'Logout', 'User NAVATARA_03 logged out.', '2409:40f2:303:9e6a:8000::', '2026-09-29 04:56:17'),
(1716, NULL, 'Failed Login Attempt', 'Username attempted: NAVATARA_06', '2409:40f2:303:9e6a:8000::', '2026-09-29 04:56:28'),
(1717, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:303:9e6a:8000::', '2026-09-29 04:56:35'),
(1718, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:303:9e6a:8000::', '2026-09-29 11:37:42'),
(1719, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:303:618a:8000::', '2026-09-30 05:32:37'),
(1720, 1, 'Collect Payment', 'Recorded payment of ₹140.00 from Retailer ID: 61 using Method: Cash', '2409:40f2:303:618a:8000::', '2026-09-30 05:33:08'),
(1721, 1, 'Collect Payment', 'Recorded payment of ₹500.00 from Retailer ID: 63 using Method: UPI', '2409:40f2:303:618a:8000::', '2026-09-30 05:33:35'),
(1722, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:303:618a:8000::', '2026-09-30 12:01:39'),
(1723, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:303:618a:8000::', '2026-09-30 12:02:42'),
(1724, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:303:618a:8000::', '2026-09-30 12:02:54'),
(1725, 1, 'Delete Discount', 'Deleted discount ID: 30', '2409:40f2:303:618a:8000::', '2026-09-30 12:03:12'),
(1726, 1, 'Delete Discount', 'Deleted discount ID: 31', '2409:40f2:303:618a:8000::', '2026-09-30 12:03:16'),
(1727, 1, 'Delete Discount', 'Deleted discount ID: 32', '2409:40f2:303:618a:8000::', '2026-09-30 12:03:22'),
(1728, 1, 'Logout', 'User NAVATARA_03 logged out.', '2409:40f2:303:618a:8000::', '2026-09-30 12:03:32'),
(1729, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:303:618a:8000::', '2026-09-30 12:03:44'),
(1730, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:102e:bfeb:8000::', '2026-10-01 11:16:19'),
(1731, 1, 'Logout', 'User NAVATARA_03 logged out.', '2409:40f2:102e:bfeb:8000::', '2026-10-01 11:16:38'),
(1732, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:102e:bfeb:8000::', '2026-10-01 11:16:55'),
(1733, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:102e:bfeb:8000::', '2026-10-01 11:25:19'),
(1734, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:102e:bfeb:8000::', '2026-10-01 13:19:32'),
(1735, 1, 'Collect Payment', 'Recorded payment of ₹578.00 from Retailer ID: 49 using Method: Cash', '2409:40f2:102e:bfeb:8000::', '2026-10-01 13:20:18'),
(1736, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:100d:1417:8000::', '2026-10-02 02:29:45'),
(1737, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:100d:1417:8000::', '2026-10-02 02:30:10'),
(1738, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:100d:1417:8000::', '2026-10-02 02:30:24'),
(1739, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:100d:1417:8000::', '2026-10-02 05:05:48'),
(1740, 1, 'Logout', 'User NAVATARA_03 logged out.', '2409:40f2:100d:1417:8000::', '2026-10-02 05:09:31'),
(1741, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:100d:1417:8000::', '2026-10-02 05:09:41'),
(1742, 15, 'Create Order', 'Staff created Order ID: 107 for Retailer ID: 49. Grand Total: 333.48', '2409:40f2:100d:1417:8000::', '2026-10-02 05:10:15'),
(1743, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:100d:1417:8000::', '2026-10-02 05:10:46'),
(1744, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:100d:1417:8000::', '2026-10-02 05:11:01'),
(1745, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:100d:1417:8000::', '2026-10-02 07:20:07'),
(1746, 1, 'Collect Payment', 'Recorded payment of ₹333.00 from Retailer ID: 59 using Method: Cash', '2409:40f2:100d:1417:8000::', '2026-10-02 08:36:19'),
(1747, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:100d:1417:8000::', '2026-10-02 08:40:05'),
(1748, 1, 'Create Retailer', 'Created retailer shri veerabhadreshwar General Store (Owner: )', '2409:40f2:100d:1417:8000::', '2026-10-02 08:53:28'),
(1749, 1, 'Create Retailer', 'Created retailer Shiv Parvati General Store (Owner: )', '2409:40f2:100d:1417:8000::', '2026-10-02 08:55:00'),
(1750, 1, 'Create Retailer', 'Created retailer Maruti General Store (Owner: )', '2409:40f2:100d:1417:8000::', '2026-10-02 08:56:29'),
(1751, 1, 'Logout', 'User NAVATARA_03 logged out.', '2409:40f2:100d:1417:8000::', '2026-10-02 08:56:54'),
(1752, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:100d:1417:8000::', '2026-10-02 08:57:25'),
(1753, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:48:60bb:8000::', '2026-10-02 10:53:42'),
(1754, 15, 'Logout', 'User Shreyansh_ logged out.', '2409:40f2:48:60bb:8000::', '2026-10-02 10:54:39'),
(1755, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '152.57.96.222', '2026-10-02 10:55:02'),
(1756, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.96.222', '2026-10-02 10:55:29'),
(1757, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.96.222', '2026-10-02 10:55:50'),
(1758, 1, 'Create Discount', 'Added Quantity Slab for SKU ID: 17', '152.57.96.222', '2026-10-02 10:56:17'),
(1759, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:48:60bb:8000::', '2026-10-02 10:56:34'),
(1760, 15, 'Create Order', 'Staff created Order ID: 108 for Retailer ID: 60. Grand Total: 650', '2409:40f2:48:60bb:8000::', '2026-10-02 10:57:20'),
(1761, 15, 'Create Order', 'Staff created Order ID: 109 for Retailer ID: 70. Grand Total: 593.48', '2409:40f2:48:60bb:8000::', '2026-10-02 10:58:18'),
(1762, 1, 'Update Retailer', 'Updated retailer profile: JAIRAJ RETAILS (ID: 59)', '152.57.96.222', '2026-10-02 10:59:17'),
(1763, 15, 'Create Order', 'Staff created Order ID: 110 for Retailer ID: 59. Grand Total: 491.715', '2409:40f2:48:60bb:8000::', '2026-10-02 11:00:03'),
(1764, 15, 'Create Order', 'Staff created Order ID: 111 for Retailer ID: 69. Grand Total: 549.99', '2409:40f2:48:60bb:8000::', '2026-10-02 11:01:04'),
(1765, 15, 'Create Order', 'Staff created Order ID: 112 for Retailer ID: 68. Grand Total: 479.808', '2409:40f2:48:60bb:8000::', '2026-10-02 11:01:39'),
(1766, 1, 'Update Order Status', 'Owner updated Order ID: 107 to Status: Approved', '152.57.96.222', '2026-10-02 11:03:40'),
(1767, 1, 'Generate Invoice', 'Invoiced Order ID: 107 -> Invoice No: NE/2026-27/0094. Grand Total: 333.48', '152.57.96.222', '2026-10-02 11:03:48'),
(1768, 1, 'Update Order Status', 'Owner updated Order ID: 108 to Status: Approved', '152.57.96.222', '2026-10-02 11:05:04'),
(1769, 1, 'Generate Invoice', 'Invoiced Order ID: 108 -> Invoice No: NE/2026-27/0095. Grand Total: 650', '152.57.96.222', '2026-10-02 11:05:14'),
(1770, 1, 'Update Order Status', 'Owner updated Order ID: 109 to Status: Approved', '152.57.96.222', '2026-10-02 11:06:19'),
(1771, 1, 'Generate Invoice', 'Invoiced Order ID: 109 -> Invoice No: NE/2026-27/0096. Grand Total: 593.48', '152.57.96.222', '2026-10-02 11:06:29'),
(1772, 1, 'Update Order Status', 'Owner updated Order ID: 110 to Status: Approved', '152.57.96.222', '2026-10-02 11:07:41'),
(1773, 1, 'Generate Invoice', 'Invoiced Order ID: 110 -> Invoice No: NE/2026-27/0097. Grand Total: 491.72', '152.57.96.222', '2026-10-02 11:07:50'),
(1774, 1, 'Update Order Status', 'Owner updated Order ID: 111 to Status: Approved', '152.57.96.222', '2026-10-02 11:08:10'),
(1775, 1, 'Generate Invoice', 'Invoiced Order ID: 111 -> Invoice No: NE/2026-27/0098. Grand Total: 549.99', '152.57.96.222', '2026-10-02 11:08:19'),
(1776, 1, 'Update Order Status', 'Owner updated Order ID: 112 to Status: Approved', '152.57.96.222', '2026-10-02 11:08:32'),
(1777, 1, 'Generate Invoice', 'Invoiced Order ID: 112 -> Invoice No: NE/2026-27/0099. Grand Total: 479.81', '152.57.96.222', '2026-10-02 11:08:39'),
(1778, 1, 'Collect Payment', 'Recorded payment of ₹480.00 from Retailer ID: 68 using Method: Cash', '152.57.96.222', '2026-10-02 11:11:59'),
(1779, 15, 'Login', 'User shreyansh_ logged in successfully.', '2409:40f2:48:60bb:8000::', '2026-10-02 11:46:52'),
(1780, 15, 'Collect Payment', 'Recorded payment of ₹650.00 from Retailer ID: 60 using Method: UPI', '2409:40f2:48:60bb:8000::', '2026-10-02 11:47:36'),
(1781, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '2409:40f2:48:60bb:8000::', '2026-10-02 12:18:53'),
(1782, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹120.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:48:60bb:8000::', '2026-10-02 12:19:39'),
(1783, 1, 'Create Expense', 'Recorded expense: Travel / Fuel of ₹80.00 + GST ₹0.00 paid to fuel via Cash', '2409:40f2:48:60bb:8000::', '2026-10-02 12:20:11'),
(1784, 1, 'Collect Payment', 'Recorded payment of ₹593.00 from Retailer ID: 70 using Method: Cash', '2409:40f2:48:60bb:8000::', '2026-10-02 12:21:50'),
(1785, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '::1', '2026-10-02 14:28:47'),
(1786, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-10-01 To: 2026-10-02)', '::1', '2026-10-02 15:20:33'),
(1787, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-10-01 To: 2026-10-02)', '::1', '2026-10-02 15:38:26'),
(1788, 1, 'Update Settings', 'Updated company profile details.', '::1', '2026-10-02 15:53:20'),
(1789, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-10-01 To: 2026-10-02)', '::1', '2026-10-02 15:54:02'),
(1790, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-08-01 To: 2026-10-02)', '::1', '2026-10-02 15:55:37'),
(1791, 1, 'Export Report', 'Exported GST Sales (Outward) CSV (From: 2026-10-01 To: 2026-10-02)', '::1', '2026-10-02 15:59:11'),
(1792, 1, 'Logout', 'User NAVATARA_03 logged out.', '::1', '2026-10-02 16:03:57'),
(1793, NULL, 'Failed Login Attempt', 'Username attempted: shreynash_', '::1', '2026-10-02 16:04:11'),
(1794, NULL, 'Failed Login Attempt', 'Username attempted: shreynash_', '::1', '2026-10-02 16:04:15'),
(1795, 15, 'Login', 'User shreyansh_ logged in successfully.', '::1', '2026-10-02 16:04:30'),
(1796, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '::1', '2026-10-02 16:16:10'),
(1797, 1, 'Toggle SKU Dynamic Price', 'Dynamic Price / Manual Billing Enabled for SKU: APPALAM', '::1', '2026-10-02 16:25:53'),
(1798, 1, 'Toggle SKU Dynamic Price', 'Dynamic Price Disabled (Fixed Rate) for SKU: APPALAM', '::1', '2026-10-02 16:27:07'),
(1799, 1, 'Login', 'User NAVATARA_03 logged in successfully.', '::1', '2026-10-04 11:48:13'),
(1800, 1, 'Counter Sale', 'Created Counter Sale Invoice: CS-20261004-0001 for Walk-in Test Customer. Total: ₹78.75', '127.0.0.1', '2026-10-04 12:00:45'),
(1801, 1, 'Counter Sale', 'Created Counter Sale Invoice: CS-20261004-0002 for Walk-in Customer. Total: ₹188.33', '::1', '2026-10-04 12:03:33'),
(1802, 1, 'Export Report', 'Exported GST Purchases (Inward) CSV (From: 2026-09-01 To: 2026-10-04)', '::1', '2026-10-04 12:42:23'),
(1803, 15, 'Login', 'User Shreyansh_ logged in successfully.', '::1', '2026-10-04 12:44:39'),
(1804, 1, 'Update Retailer', 'Updated retailer profile: PRAVEEN PAWAR COCONUT (ID: 54)', '::1', '2026-10-04 12:50:09'),
(1805, 1, 'Update Retailer', 'Updated retailer profile: PRAVEEN PAWAR COCONUT (ID: 54)', '::1', '2026-10-04 12:50:31'),
(1806, 1, 'Toggle Special Retailer', 'Retailer Shiv Parvati General Store marked as Special Retailer (Dynamic SKU Pricing Enabled)', '::1', '2026-10-04 13:10:48'),
(1807, 15, 'Toggle Special Retailer', 'Retailer Maruti General Store marked as Special Retailer (Dynamic SKU Pricing Enabled)', '::1', '2026-10-04 13:11:16'),
(1808, 15, 'Toggle Special Retailer', 'Retailer Maruti General Store unmarked from Special Retailers (Standard Fixed Rates)', '::1', '2026-10-04 13:11:18'),
(1809, 1, 'Add Capital', 'Added Loan capital of ₹100000 from ', '::1', '2026-10-04 14:05:57'),
(1810, 1, 'Add Capital', 'Added Loan capital of ₹100000 from ', '::1', '2026-10-04 14:06:32'),
(1811, 1, 'Add Capital', 'Added Loan capital of ₹100000 from ', '::1', '2026-10-04 14:10:10'),
(1812, 1, 'Delete Capital', 'Deleted capital record ID: 1', '::1', '2026-10-04 14:14:19'),
(1813, 1, 'Delete Capital', 'Deleted capital record ID: 2', '::1', '2026-10-04 14:14:20'),
(1814, 1, 'Delete Capital', 'Deleted capital record ID: 3', '::1', '2026-10-04 14:14:22'),
(1815, 1, 'Add Capital', 'Added Loan capital of ₹100000 from ', '::1', '2026-10-04 14:14:48'),
(1816, 1, 'Delete Capital', 'Deleted capital record ID: 4', '::1', '2026-10-04 14:17:21'),
(1817, 15, 'Login', 'User Shreyansh_ logged in successfully.', '::1', '2026-10-04 14:19:07'),
(1818, 1, 'Update Order Status', 'Owner updated Order ID: 79 to Status: Approved', '::1', '2026-10-04 14:29:11');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `supplier_id`, `name`, `logo`, `description`, `status`, `created_at`) VALUES
(5, 1, 'GHEE', 'uploads/brands/1783857120_sri_sadananda_foods_pvt_ltd_logo.jpg', 'MANUFACTURERS IN GHEE, APPLAMA', 'Active', '2026-07-12 11:52:00'),
(6, 2, 'INCENSE STICKS', 'uploads/brands/1783857249_VINAYAKA SALES AND PERFUMERY LOGO.jpg', 'MANUFACTURERS IN INCENSE STICKS', 'Active', '2026-07-12 11:54:09'),
(8, 1, 'MASALA', NULL, '', 'Active', '2026-08-02 15:30:08');

-- --------------------------------------------------------

--
-- Table structure for table `business_capital`
--

CREATE TABLE `business_capital` (
  `id` int(11) NOT NULL,
  `capital_type` enum('Own','Loan') NOT NULL DEFAULT 'Own',
  `amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `source_name` varchar(150) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer_ledger`
--

CREATE TABLE `customer_ledger` (
  `id` int(11) NOT NULL,
  `retailer_id` int(11) NOT NULL,
  `transaction_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_date` date NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reference_type` enum('Invoices','Payments','None') COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `debit_amount` decimal(12,2) DEFAULT 0.00,
  `credit_amount` decimal(12,2) DEFAULT 0.00,
  `balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_ledger`
--

INSERT INTO `customer_ledger` (`id`, `retailer_id`, `transaction_type`, `transaction_date`, `reference_id`, `reference_type`, `debit_amount`, `credit_amount`, `balance`, `remarks`, `created_at`) VALUES
(11, 8, 'Opening Balance', '2026-07-15', 8, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 10:43:36'),
(12, 9, 'Opening Balance', '2026-07-15', 9, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 10:45:20'),
(13, 10, 'Opening Balance', '2026-07-15', 10, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 10:46:50'),
(14, 11, 'Opening Balance', '2026-07-15', 11, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 10:48:29'),
(15, 12, 'Opening Balance', '2026-07-15', 12, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 10:50:52'),
(16, 13, 'Opening Balance', '2026-07-15', 13, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 10:53:31'),
(17, 14, 'Opening Balance', '2026-07-15', 14, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 10:54:52'),
(18, 15, 'Opening Balance', '2026-07-15', 15, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 10:56:03'),
(19, 16, 'Opening Balance', '2026-07-15', 16, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 10:58:15'),
(20, 17, 'Opening Balance', '2026-07-15', 17, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 11:00:16'),
(21, 18, 'Opening Balance', '2026-07-15', 18, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-15 11:02:31'),
(23, 15, 'Invoice', '2026-07-15', 4, 'Invoices', '189.00', '0.00', '189.00', 'Debited Invoice No: NE/2026-27/0003', '2026-07-15 12:19:43'),
(24, 16, 'Invoice', '2026-07-15', 5, 'Invoices', '189.00', '0.00', '189.00', 'Debited Invoice No: NE/2026-27/0004', '2026-07-15 12:25:13'),
(25, 17, 'Invoice', '2026-07-15', 6, 'Invoices', '1197.00', '0.00', '1197.00', 'Debited Invoice No: NE/2026-27/0005', '2026-07-15 12:26:20'),
(26, 18, 'Invoice', '2026-07-15', 7, 'Invoices', '210.04', '0.00', '210.04', 'Debited Invoice No: NE/2026-27/0006', '2026-07-15 12:26:53'),
(27, 8, 'Invoice', '2026-07-15', 8, 'Invoices', '724.50', '0.00', '724.50', 'Debited Invoice No: NE/2026-27/0007', '2026-07-15 12:27:14'),
(28, 9, 'Invoice', '2026-07-15', 9, 'Invoices', '346.50', '0.00', '346.50', 'Debited Invoice No: NE/2026-27/0008', '2026-07-15 12:27:31'),
(29, 10, 'Invoice', '2026-07-15', 10, 'Invoices', '504.00', '0.00', '504.00', 'Debited Invoice No: NE/2026-27/0009', '2026-07-15 12:28:17'),
(30, 11, 'Invoice', '2026-07-15', 11, 'Invoices', '189.00', '0.00', '189.00', 'Debited Invoice No: NE/2026-27/0010', '2026-07-15 12:28:42'),
(31, 12, 'Invoice', '2026-07-15', 12, 'Invoices', '441.00', '0.00', '441.00', 'Debited Invoice No: NE/2026-27/0011', '2026-07-15 12:28:58'),
(32, 13, 'Invoice', '2026-07-15', 13, 'Invoices', '1197.00', '0.00', '1197.00', 'Debited Invoice No: NE/2026-27/0012', '2026-07-15 12:29:51'),
(33, 18, 'Payment', '2026-07-15', 2, 'Payments', '0.00', '210.00', '0.04', 'Collected via Cash. Ref: Cash. ', '2026-07-15 18:07:49'),
(34, 18, 'Payment', '2026-07-15', 3, 'Payments', '0.00', '0.04', '0.00', 'Collected via Cash. Ref: . ', '2026-07-15 18:08:49'),
(35, 11, 'Payment', '2026-07-15', 4, 'Payments', '0.00', '185.00', '4.00', 'Collected via Cash. Ref: Cash. ', '2026-07-15 18:09:39'),
(36, 19, 'Opening Balance', '2026-07-16', 19, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 05:59:14'),
(37, 20, 'Opening Balance', '2026-07-16', 20, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 06:03:17'),
(38, 21, 'Opening Balance', '2026-07-16', 21, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 09:11:47'),
(39, 22, 'Opening Balance', '2026-07-16', 22, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 09:14:26'),
(40, 23, 'Opening Balance', '2026-07-16', 23, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 09:15:37'),
(41, 24, 'Opening Balance', '2026-07-16', 24, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 09:16:58'),
(42, 25, 'Opening Balance', '2026-07-16', 25, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 09:18:35'),
(43, 26, 'Opening Balance', '2026-07-16', 26, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 09:21:17'),
(44, 27, 'Opening Balance', '2026-07-16', 27, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 09:24:45'),
(45, 28, 'Opening Balance', '2026-07-16', 28, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 09:26:55'),
(46, 29, 'Opening Balance', '2026-07-16', 29, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 09:28:14'),
(48, 31, 'Opening Balance', '2026-07-16', 31, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-16 09:29:41'),
(49, 19, 'Invoice', '2026-07-16', 14, 'Invoices', '504.00', '0.00', '504.00', 'Debited Invoice No: NE/2026-27/0013', '2026-07-16 11:16:11'),
(50, 20, 'Invoice', '2026-07-16', 15, 'Invoices', '1512.00', '0.00', '1512.00', 'Debited Invoice No: NE/2026-27/0014', '2026-07-16 11:19:30'),
(51, 21, 'Invoice', '2026-07-16', 16, 'Invoices', '1008.00', '0.00', '1008.00', 'Debited Invoice No: NE/2026-27/0015', '2026-07-16 11:19:43'),
(52, 22, 'Invoice', '2026-07-16', 17, 'Invoices', '693.00', '0.00', '693.00', 'Debited Invoice No: NE/2026-27/0016', '2026-07-16 11:20:05'),
(53, 23, 'Invoice', '2026-07-16', 18, 'Invoices', '1008.00', '0.00', '1008.00', 'Debited Invoice No: NE/2026-27/0017', '2026-07-16 11:20:16'),
(54, 24, 'Invoice', '2026-07-16', 19, 'Invoices', '252.00', '0.00', '252.00', 'Debited Invoice No: NE/2026-27/0018', '2026-07-16 11:20:32'),
(57, 27, 'Invoice', '2026-07-16', 22, 'Invoices', '1008.00', '0.00', '1008.00', 'Debited Invoice No: NE/2026-27/0021', '2026-07-16 11:21:37'),
(58, 28, 'Invoice', '2026-07-16', 23, 'Invoices', '1008.00', '0.00', '1008.00', 'Debited Invoice No: NE/2026-27/0022', '2026-07-16 11:23:06'),
(59, 29, 'Invoice', '2026-07-16', 24, 'Invoices', '1008.00', '0.00', '1008.00', 'Debited Invoice No: NE/2026-27/0023', '2026-07-16 11:26:12'),
(60, 31, 'Invoice', '2026-07-16', 25, 'Invoices', '682.54', '0.00', '682.54', 'Debited Invoice No: NE/2026-27/0024', '2026-07-16 11:26:27'),
(61, 32, 'Opening Balance', '2026-07-18', 32, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-18 02:58:34'),
(62, 33, 'Opening Balance', '2026-07-18', 33, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-18 03:01:19'),
(63, 34, 'Opening Balance', '2026-07-18', 34, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-18 03:03:10'),
(64, 8, 'Payment', '2026-07-22', 5, 'Payments', '0.00', '724.50', '0.00', 'Collected via Cash. Ref: . ', '2026-07-22 05:31:41'),
(65, 15, 'Payment', '2026-07-22', 6, 'Payments', '0.00', '189.00', '0.00', 'Collected via Cash. Ref: . ', '2026-07-22 07:10:12'),
(66, 16, 'Payment', '2026-07-22', 7, 'Payments', '0.00', '189.00', '0.00', 'Collected via Bank Transfer. Ref: . ', '2026-07-22 07:13:04'),
(67, 35, 'Opening Balance', '2026-07-24', 35, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-24 04:33:56'),
(68, 36, 'Opening Balance', '2026-07-24', 36, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-24 04:35:22'),
(69, 37, 'Opening Balance', '2026-07-24', 37, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-24 04:36:56'),
(70, 38, 'Opening Balance', '2026-07-24', 38, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-24 04:38:38'),
(71, 35, 'Invoice', '2026-07-25', 50, 'Invoices', '141.17', '0.00', '141.17', 'Debited Invoice No: NE/2026-27/0025', '2026-07-25 10:22:40'),
(72, 36, 'Invoice', '2026-07-25', 51, 'Invoices', '141.17', '0.00', '141.17', 'Debited Invoice No: NE/2026-27/0026', '2026-07-25 11:11:54'),
(73, 37, 'Invoice', '2026-07-25', 52, 'Invoices', '1038.56', '0.00', '1038.56', 'Debited Invoice No: NE/2026-27/0027', '2026-07-25 11:26:27'),
(74, 38, 'Invoice', '2026-07-25', 53, 'Invoices', '314.15', '0.00', '314.15', 'Debited Invoice No: NE/2026-27/0028', '2026-07-25 11:32:15'),
(75, 39, 'Opening Balance', '2026-07-27', 39, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-27 14:52:53'),
(76, 10, 'Payment', '2026-07-29', 8, 'Payments', '0.00', '504.00', '0.00', 'Collected via Cash. Ref: . ', '2026-07-29 08:02:12'),
(77, 12, 'Payment', '2026-07-29', 9, 'Payments', '0.00', '441.00', '0.00', 'Collected via Cash. Ref: . ', '2026-07-29 08:02:41'),
(78, 9, 'Payment', '2026-07-29', 10, 'Payments', '0.00', '347.00', '-0.50', 'Collected via UPI. Ref: . ', '2026-07-29 08:03:22'),
(79, 37, 'Payment', '2026-07-29', 11, 'Payments', '0.00', '1038.56', '0.00', 'Collected via Cash. Ref: . ', '2026-07-29 08:10:38'),
(80, 36, 'Payment', '2026-07-24', 12, 'Payments', '0.00', '141.17', '0.00', 'Collected via Cash. Ref: . ', '2026-07-29 08:11:35'),
(81, 35, 'Payment', '2026-07-24', 13, 'Payments', '0.00', '141.17', '0.00', 'Collected via Cash. Ref: . ', '2026-07-29 08:12:13'),
(82, 15, 'Invoice', '2026-07-29', 54, 'Invoices', '179.68', '0.00', '179.68', 'Debited Invoice No: NE/2026-27/0029', '2026-07-29 11:56:41'),
(83, 31, 'Payment', '2026-07-30', 14, 'Payments', '0.00', '682.54', '0.00', 'Collected via Cash. Ref: . ', '2026-07-30 11:57:01'),
(84, 24, 'Payment', '2026-07-30', 15, 'Payments', '0.00', '252.00', '0.00', 'Collected via Cash. Ref: . ', '2026-07-30 11:57:11'),
(85, 20, 'Payment', '2026-07-30', 16, 'Payments', '0.00', '500.00', '1012.00', 'Collected via Cash. Ref: . ', '2026-07-31 04:13:51'),
(86, 40, 'Opening Balance', '2026-07-31', 40, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-07-31 05:36:32'),
(87, 28, 'Payment', '2026-08-01', 17, 'Payments', '0.00', '1008.00', '0.00', 'Collected via Cash. Ref: . ', '2026-08-01 12:41:42'),
(88, 23, 'Payment', '2026-08-01', 18, 'Payments', '0.00', '300.00', '708.00', 'Collected via Cash. Ref: . ', '2026-08-01 12:42:20'),
(89, 21, 'Payment', '2026-08-01', 19, 'Payments', '0.00', '1008.00', '0.00', 'Collected via Cash. Ref: . ', '2026-08-01 12:43:19'),
(90, 19, 'Payment', '2026-08-01', 20, 'Payments', '0.00', '504.00', '0.00', 'Collected via Cash. Ref: . ', '2026-08-01 12:43:47'),
(91, 40, 'Invoice', '2026-08-02', 55, 'Invoices', '3000.00', '0.00', '3000.00', 'Debited Invoice No: NE/2026-27/0030', '2026-08-02 14:39:41'),
(92, 41, 'Opening Balance', '2026-08-03', 41, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-03 05:03:36'),
(93, 42, 'Opening Balance', '2026-08-03', 42, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-03 05:05:19'),
(94, 43, 'Opening Balance', '2026-08-03', 43, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-03 05:08:04'),
(95, 44, 'Opening Balance', '2026-08-03', 44, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-03 05:10:38'),
(96, 45, 'Opening Balance', '2026-08-03', 45, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-03 05:13:00'),
(97, 46, 'Opening Balance', '2026-08-03', 46, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-03 05:14:36'),
(98, 39, 'Invoice', '2026-08-03', 56, 'Invoices', '959.62', '0.00', '959.62', 'Debited Invoice No: NE/2026-27/0031', '2026-08-03 05:45:18'),
(99, 41, 'Invoice', '2026-08-03', 57, 'Invoices', '1139.29', '0.00', '1139.29', 'Debited Invoice No: NE/2026-27/0032', '2026-08-03 05:56:28'),
(100, 42, 'Invoice', '2026-08-03', 58, 'Invoices', '239.90', '0.00', '239.90', 'Debited Invoice No: NE/2026-27/0033', '2026-08-03 05:57:05'),
(101, 43, 'Invoice', '2026-08-03', 59, 'Invoices', '179.68', '0.00', '179.68', 'Debited Invoice No: NE/2026-27/0034', '2026-08-03 05:57:48'),
(102, 44, 'Invoice', '2026-08-03', 60, 'Invoices', '179.68', '0.00', '179.68', 'Debited Invoice No: NE/2026-27/0035', '2026-08-03 05:58:22'),
(103, 45, 'Invoice', '2026-08-03', 61, 'Invoices', '959.62', '0.00', '959.62', 'Debited Invoice No: NE/2026-27/0036', '2026-08-03 05:59:04'),
(104, 46, 'Invoice', '2026-08-03', 62, 'Invoices', '1139.29', '0.00', '1139.29', 'Debited Invoice No: NE/2026-27/0037', '2026-08-03 05:59:30'),
(105, 47, 'Opening Balance', '2026-08-04', 47, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-04 05:57:59'),
(106, 48, 'Opening Balance', '2026-08-04', 48, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-04 09:05:53'),
(107, 49, 'Opening Balance', '2026-08-04', 49, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-04 09:06:53'),
(108, 50, 'Opening Balance', '2026-08-04', 50, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-04 09:08:53'),
(109, 51, 'Opening Balance', '2026-08-04', 51, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-04 09:12:32'),
(110, 47, 'Invoice', '2026-08-04', 63, 'Invoices', '616.54', '0.00', '616.54', 'Debited Invoice No: NE/2026-27/0038', '2026-08-04 11:30:51'),
(111, 48, 'Invoice', '2026-08-04', 64, 'Invoices', '130.00', '0.00', '130.00', 'Debited Invoice No: NE/2026-27/0039', '2026-08-04 11:32:30'),
(112, 49, 'Invoice', '2026-08-04', 65, 'Invoices', '459.46', '0.00', '459.46', 'Debited Invoice No: NE/2026-27/0040', '2026-08-04 11:33:22'),
(113, 50, 'Invoice', '2026-08-04', 66, 'Invoices', '688.94', '0.00', '688.94', 'Debited Invoice No: NE/2026-27/0041', '2026-08-04 11:34:32'),
(114, 51, 'Invoice', '2026-08-04', 67, 'Invoices', '844.65', '0.00', '844.65', 'Debited Invoice No: NE/2026-27/0042', '2026-08-04 11:36:52'),
(115, 50, 'Payment', '2026-08-04', 21, 'Payments', '0.00', '689.00', '-0.06', 'Collected via Cash. Ref: . ', '2026-08-04 13:32:17'),
(116, 47, 'Payment', '2026-08-04', 22, 'Payments', '0.00', '616.54', '0.00', 'Collected via Cash. Ref: . ', '2026-08-04 13:32:43'),
(117, 29, 'Payment', '2026-08-05', 23, 'Payments', '0.00', '1008.00', '0.00', 'Collected via Cash. Ref: . ', '2026-08-05 03:54:36'),
(118, 8, 'Invoice', '2026-08-05', 68, 'Invoices', '549.99', '0.00', '549.99', 'Debited Invoice No: NE/2026-27/0043', '2026-08-05 12:05:14'),
(119, 17, 'Invoice', '2026-08-05', 69, 'Invoices', '959.62', '0.00', '2156.62', 'Debited Invoice No: NE/2026-27/0044', '2026-08-05 12:06:18'),
(120, 13, 'Payment', '2026-08-05', 24, 'Payments', '0.00', '717.00', '480.00', 'Collected via UPI. Ref: . ', '2026-08-05 12:24:41'),
(121, 17, 'Payment', '2026-08-05', 25, 'Payments', '0.00', '1197.00', '959.62', 'Collected via Cash. Ref: . ', '2026-08-05 12:25:07'),
(122, 52, 'Opening Balance', '2026-08-06', 52, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-06 08:16:59'),
(123, 53, 'Opening Balance', '2026-08-06', 53, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-06 08:19:20'),
(124, 54, 'Opening Balance', '2026-08-06', 54, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-06 08:20:45'),
(125, 55, 'Opening Balance', '2026-08-06', 55, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-06 08:22:36'),
(126, 24, 'Invoice', '2026-08-06', 70, 'Invoices', '549.99', '0.00', '549.99', 'Debited Invoice No: NE/2026-27/0045', '2026-08-06 09:16:42'),
(127, 25, 'Invoice', '2026-08-06', 71, 'Invoices', '3693.12', '0.00', '3693.12', 'Debited Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(128, 26, 'Invoice', '2026-08-06', 72, 'Invoices', '959.62', '0.00', '959.62', 'Debited Invoice No: NE/2026-27/0047', '2026-08-06 09:19:45'),
(129, 19, 'Invoice', '2026-08-06', 73, 'Invoices', '479.81', '0.00', '479.81', 'Debited Invoice No: NE/2026-27/0048', '2026-08-06 09:20:50'),
(130, 20, 'Invoice', '2026-08-06', 74, 'Invoices', '1274.18', '0.00', '2286.18', 'Debited Invoice No: NE/2026-27/0049', '2026-08-06 09:21:30'),
(131, 52, 'Invoice', '2026-08-06', 75, 'Invoices', '5488.43', '0.00', '5488.43', 'Debited Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(132, 54, 'Invoice', '2026-08-06', 76, 'Invoices', '479.81', '0.00', '479.81', 'Debited Invoice No: NE/2026-27/0051', '2026-08-06 09:26:15'),
(133, 53, 'Invoice', '2026-08-06', 77, 'Invoices', '5268.31', '0.00', '5268.31', 'Debited Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(134, 55, 'Invoice', '2026-08-06', 78, 'Invoices', '2860.20', '0.00', '2860.20', 'Debited Invoice No: NE/2026-27/0053', '2026-08-06 09:28:17'),
(135, 38, 'Payment', '2026-08-08', 26, 'Payments', '0.00', '314.15', '0.00', 'Collected via Cash. Ref: . ', '2026-08-08 08:36:42'),
(136, 42, 'Payment', '2026-08-10', 27, 'Payments', '0.00', '239.90', '0.00', 'Collected via Cash. Ref: . ', '2026-08-10 07:16:31'),
(137, 39, 'Payment', '2026-08-10', 28, 'Payments', '0.00', '100.00', '859.62', 'Collected via Cash. Ref: . ', '2026-08-10 07:16:52'),
(138, 41, 'Payment', '2026-08-10', 29, 'Payments', '0.00', '500.00', '639.29', 'Collected via Cash. Ref: . ', '2026-08-10 08:04:35'),
(139, 44, 'Payment', '2026-08-10', 30, 'Payments', '0.00', '180.00', '-0.32', 'Collected via Cash. Ref: . ', '2026-08-10 08:06:08'),
(140, 56, 'Opening Balance', '2026-08-11', 56, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-11 03:24:17'),
(141, 56, 'Invoice', '2026-08-11', 79, 'Invoices', '2722.90', '0.00', '2722.90', 'Debited Invoice No: NE/2026-27/0054', '2026-08-11 04:32:27'),
(142, 49, 'Payment', '2026-08-11', 31, 'Payments', '0.00', '200.00', '259.46', 'Collected via Cash. Ref: . ', '2026-08-11 07:33:20'),
(143, 40, 'Payment', '2026-08-11', 32, 'Payments', '0.00', '3000.00', '0.00', 'Collected via Cheque. Ref: . ', '2026-08-12 11:22:27'),
(144, 23, 'Payment', '2026-08-13', 33, 'Payments', '0.00', '350.00', '358.00', 'Collected via Cash. Ref: . ', '2026-08-13 12:24:42'),
(145, 22, 'Payment', '2026-08-13', 34, 'Payments', '0.00', '500.00', '193.00', 'Collected via UPI. Ref: . ', '2026-08-13 12:25:01'),
(146, 22, 'Payment', '2026-08-13', 35, 'Payments', '0.00', '193.00', '0.00', 'Collected via Cash. Ref: . ', '2026-08-13 12:25:07'),
(147, 57, 'Opening Balance', '2026-08-15', 57, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-15 04:29:32'),
(149, 59, 'Opening Balance', '2026-08-15', 59, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-15 04:30:53'),
(150, 33, 'Invoice', '2026-08-15', 80, 'Invoices', '1229.13', '0.00', '1229.13', 'Debited Invoice No: NE/2026-27/0055', '2026-08-15 04:44:56'),
(151, 34, 'Invoice', '2026-08-15', 81, 'Invoices', '1125.18', '0.00', '1125.18', 'Debited Invoice No: NE/2026-27/0056', '2026-08-15 04:45:56'),
(152, 59, 'Invoice', '2026-08-15', 82, 'Invoices', '1143.99', '0.00', '1143.99', 'Debited Invoice No: NE/2026-27/0057', '2026-08-15 04:46:19'),
(153, 57, 'Invoice', '2026-08-15', 83, 'Invoices', '199.46', '0.00', '199.46', 'Debited Invoice No: NE/2026-27/0058', '2026-08-15 04:46:39'),
(154, 34, 'Payment', '2026-08-15', 36, 'Payments', '0.00', '1125.18', '0.00', 'Collected via Cash. Ref: . ', '2026-08-15 07:00:22'),
(155, 20, 'Payment', '2026-08-17', 37, 'Payments', '0.00', '500.00', '1786.18', 'Collected via UPI. Ref: . ', '2026-08-19 04:23:39'),
(156, 15, 'Payment', '2026-08-19', 38, 'Payments', '0.00', '180.00', '-0.32', 'Collected via Cash. Ref: . ', '2026-08-19 06:09:59'),
(157, 16, 'Invoice', '2026-08-19', 84, 'Invoices', '1209.32', '0.00', '1209.32', 'Debited Invoice No: NE/2026-27/0059', '2026-08-19 10:55:04'),
(158, 18, 'Invoice', '2026-08-19', 85, 'Invoices', '309.68', '0.00', '309.68', 'Debited Invoice No: NE/2026-27/0060', '2026-08-19 10:55:53'),
(159, 18, 'Payment', '2026-08-19', 39, 'Payments', '0.00', '310.00', '-0.32', 'Collected via Cash. Ref: . ', '2026-08-19 12:19:51'),
(160, 23, 'Payment', '2026-08-20', 40, 'Payments', '0.00', '358.00', '0.00', 'Collected via Cash. Ref: . ', '2026-08-20 12:47:24'),
(161, 19, 'Payment', '2026-08-20', 41, 'Payments', '0.00', '480.00', '-0.19', 'Collected via UPI. Ref: . ', '2026-08-20 12:52:42'),
(162, 20, 'Payment', '2026-08-20', 42, 'Payments', '0.00', '512.00', '1274.18', 'Collected via Cash. Ref: . ', '2026-08-20 13:00:33'),
(163, 52, 'Payment', '2026-08-20', 43, 'Payments', '0.00', '1500.00', '3988.43', 'Collected via Cash. Ref: . ', '2026-08-20 13:36:27'),
(164, 26, 'Payment', '2026-08-20', 44, 'Payments', '0.00', '500.00', '459.62', 'Collected via Cash. Ref: . ', '2026-08-20 13:37:02'),
(165, 24, 'Payment', '2026-08-20', 45, 'Payments', '0.00', '300.00', '249.99', 'Collected via Cash. Ref: . ', '2026-08-20 13:37:38'),
(166, 55, 'Payment', '2026-08-22', 46, 'Payments', '0.00', '1000.00', '1860.20', 'Collected via Cash. Ref: . ', '2026-08-22 13:44:38'),
(167, 26, 'Payment', '2026-08-22', 47, 'Payments', '0.00', '460.00', '-0.38', 'Collected via Cash. Ref: . ', '2026-08-22 13:45:06'),
(168, 25, 'Payment', '2026-08-22', 48, 'Payments', '0.00', '1200.00', '2493.12', 'Collected via Cash. Ref: . ', '2026-08-22 13:46:07'),
(169, 60, 'Opening Balance', '2026-08-23', 60, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-08-23 01:32:22'),
(170, 46, 'Payment', '2026-08-25', 49, 'Payments', '0.00', '1140.00', '-0.71', 'Collected via Cash. Ref: . ', '2026-08-25 05:52:44'),
(171, 45, 'Payment', '2026-08-25', 50, 'Payments', '0.00', '300.00', '659.62', 'Collected via Cash. Ref: . ', '2026-08-25 06:04:32'),
(172, 43, 'Payment', '2026-08-25', 51, 'Payments', '0.00', '180.00', '-0.32', 'Collected via Cash. Ref: . ', '2026-08-25 06:05:43'),
(173, 41, 'Payment', '2026-08-25', 52, 'Payments', '0.00', '639.00', '0.29', 'Collected via Cash. Ref: . ', '2026-08-25 06:21:38'),
(174, 48, 'Payment', '2026-08-25', 53, 'Payments', '0.00', '130.00', '0.00', 'Collected via Cash. Ref: . ', '2026-08-25 07:19:33'),
(175, 51, 'Payment', '2026-08-25', 54, 'Payments', '0.00', '500.00', '344.65', 'Collected via UPI. Ref: . ', '2026-08-25 07:39:24'),
(176, 51, 'Payment', '2026-08-25', 55, 'Payments', '0.00', '345.00', '-0.35', 'Collected via Cash. Ref: . ', '2026-08-25 07:39:55'),
(177, 33, 'Invoice', '2026-08-27', 86, 'Invoices', '260.00', '0.00', '1489.13', 'Debited Invoice No: NE/2026-27/0061', '2026-08-27 06:31:42'),
(178, 33, 'Payment', '2026-08-23', 56, 'Payments', '0.00', '260.00', '1229.13', 'Collected via Cash. Ref: . ', '2026-08-27 06:33:18'),
(179, 40, 'Invoice', '2026-08-27', 87, 'Invoices', '2154.18', '0.00', '2154.18', 'Debited Invoice No: NE/2026-27/0062', '2026-08-27 06:46:54'),
(180, 60, 'Invoice', '2026-08-27', 88, 'Invoices', '2524.00', '0.00', '2524.00', 'Debited Invoice No: NE/2026-27/0063', '2026-08-27 06:53:02'),
(181, 54, 'Payment', '2026-08-29', 57, 'Payments', '0.00', '480.00', '-0.19', 'Collected via UPI. Ref: . ', '2026-08-29 13:37:41'),
(182, 53, 'Payment', '2026-08-29', 58, 'Payments', '0.00', '2000.00', '3268.31', 'Collected via Cash. Ref: . ', '2026-08-29 13:38:10'),
(183, 24, 'Payment', '2026-08-29', 59, 'Payments', '0.00', '250.00', '-0.01', 'Collected via Cash. Ref: . ', '2026-08-29 13:38:39'),
(184, 56, 'Payment', '2026-08-31', 60, 'Payments', '0.00', '2723.00', '-0.10', 'Collected via Cash. Ref: . ', '2026-08-31 06:27:33'),
(185, 49, 'Payment', '2026-08-31', 61, 'Payments', '0.00', '259.00', '0.46', 'Collected via Cash. Ref: . ', '2026-08-31 07:41:13'),
(186, 45, 'Payment', '2026-08-31', 62, 'Payments', '0.00', '300.00', '359.62', 'Collected via Cash. Ref: . ', '2026-08-31 07:43:13'),
(187, 16, 'Payment', '2026-09-02', 63, 'Payments', '0.00', '1209.00', '0.32', 'Collected via Cash. Ref: . ', '2026-09-02 06:15:05'),
(188, 8, 'Payment', '2026-09-02', 64, 'Payments', '0.00', '550.00', '-0.01', 'Collected via Cash. Ref: . ', '2026-09-02 06:15:26'),
(189, 17, 'Payment', '2026-09-02', 65, 'Payments', '0.00', '960.00', '-0.38', 'Collected via Cash. Ref: . ', '2026-09-02 06:15:46'),
(190, 12, 'Invoice', '2026-09-02', 89, 'Invoices', '179.68', '0.00', '179.68', 'Debited Invoice No: NE/2026-27/0064', '2026-09-02 10:35:40'),
(191, 15, 'Invoice', '2026-09-02', 90, 'Invoices', '658.48', '0.00', '658.16', 'Debited Invoice No: NE/2026-27/0065', '2026-09-02 10:37:48'),
(192, 16, 'Invoice', '2026-09-02', 91, 'Invoices', '394.70', '0.00', '395.02', 'Debited Invoice No: NE/2026-27/0066', '2026-09-02 10:38:10'),
(193, 57, 'Payment', '2026-09-04', 66, 'Payments', '0.00', '200.00', '-0.54', 'Collected via Cash. Ref: . ', '2026-09-05 02:38:47'),
(194, 40, 'Payment', '2026-09-04', 67, 'Payments', '0.00', '2154.00', '0.18', 'Collected via Cheque. Ref: . ', '2026-09-05 02:39:27'),
(195, 59, 'Invoice', '2026-09-05', 92, 'Invoices', '260.00', '0.00', '1403.99', 'Debited Invoice No: NE/2026-27/0067', '2026-09-05 05:29:37'),
(196, 37, 'Invoice', '2026-09-05', 93, 'Invoices', '1201.64', '0.00', '1201.64', 'Debited Invoice No: NE/2026-27/0068', '2026-09-05 05:30:50'),
(197, 59, 'Payment', '2026-09-05', 68, 'Payments', '0.00', '260.00', '1143.99', 'Collected via Cash. Ref: . ', '2026-09-05 10:19:52'),
(198, 60, 'Payment', '2026-09-05', 69, 'Payments', '0.00', '1000.00', '1524.00', 'Collected via Cash. Ref: . ', '2026-09-05 10:20:19'),
(199, 37, 'Payment', '2026-09-05', 70, 'Payments', '0.00', '1202.00', '-0.36', 'Collected via Cash. Ref: . ', '2026-09-05 10:20:41'),
(200, 52, 'Payment', '2026-09-05', 71, 'Payments', '0.00', '1500.00', '2488.43', 'Collected via Cash. Ref: . ', '2026-09-05 12:15:31'),
(201, 53, 'Payment', '2026-09-05', 72, 'Payments', '0.00', '1000.00', '2268.31', 'Collected via Cash. Ref: . ', '2026-09-05 12:16:02'),
(202, 26, 'Invoice', '2026-09-07', 94, 'Invoices', '2878.85', '0.00', '2878.47', 'Debited Invoice No: NE/2026-27/0069', '2026-09-07 04:40:25'),
(203, 25, 'Invoice', '2026-09-07', 95, 'Invoices', '2399.04', '0.00', '4892.16', 'Debited Invoice No: NE/2026-27/0070', '2026-09-07 04:44:21'),
(204, 45, 'Payment', '2026-09-07', 73, 'Payments', '0.00', '360.00', '-0.38', 'Collected via Cash. Ref: . ', '2026-09-07 07:19:49'),
(205, 41, 'Invoice', '2026-09-08', 96, 'Invoices', '959.62', '0.00', '959.91', 'Debited Invoice No: NE/2026-27/0071', '2026-09-08 08:28:45'),
(206, 45, 'Invoice', '2026-09-08', 97, 'Invoices', '3148.36', '0.00', '3147.98', 'Debited Invoice No: NE/2026-27/0072', '2026-09-08 08:29:40'),
(207, 25, 'Payment', '2026-09-10', 74, 'Payments', '0.00', '600.00', '4292.16', 'Collected via Cash. Ref: . ', '2026-09-10 14:05:17'),
(208, 53, 'Payment', '2026-09-10', 75, 'Payments', '0.00', '1500.00', '768.31', 'Collected via Cash. Ref: . ', '2026-09-10 14:06:03'),
(209, 55, 'Payment', '2026-09-10', 76, 'Payments', '0.00', '1000.00', '860.20', 'Collected via Cash. Ref: . ', '2026-09-10 14:06:31'),
(210, 26, 'Payment', '2026-09-10', 77, 'Payments', '0.00', '500.00', '2378.47', 'Collected via Cash. Ref: . ', '2026-09-10 14:06:51'),
(211, 27, 'Payment', '2026-09-10', 78, 'Payments', '0.00', '500.00', '508.00', 'Collected via Cash. Ref: . ', '2026-09-10 14:07:17'),
(212, 56, 'Invoice', '2026-09-12', 98, 'Invoices', '1300.00', '0.00', '1299.90', 'Debited Invoice No: NE/2026-27/0073', '2026-09-12 05:56:55'),
(213, 40, 'Invoice', '2026-09-12', 99, 'Invoices', '3000.00', '0.00', '3000.18', 'Debited Invoice No: NE/2026-27/0074', '2026-09-12 06:18:54'),
(214, 16, 'Payment', '2026-09-17', 79, 'Payments', '0.00', '396.00', '-0.98', 'Collected via Cash. Ref: . ', '2026-09-17 14:29:20'),
(215, 59, 'Payment', '2026-09-18', 80, 'Payments', '0.00', '1144.00', '-0.01', 'Collected via UPI. Ref: . ', '2026-09-18 07:24:29'),
(216, 59, 'Invoice', '2026-09-18', 100, 'Invoices', '333.48', '0.00', '333.47', 'Debited Invoice No: NE/2026-27/0075', '2026-09-18 10:26:19'),
(217, 34, 'Invoice', '2026-09-18', 101, 'Invoices', '260.00', '0.00', '260.00', 'Debited Invoice No: NE/2026-27/0076', '2026-09-18 10:27:02'),
(218, 60, 'Invoice', '2026-09-18', 102, 'Invoices', '1693.36', '0.00', '3217.36', 'Debited Invoice No: NE/2026-27/0077', '2026-09-18 10:28:17'),
(219, 33, 'Invoice', '2026-09-18', 103, 'Invoices', '539.03', '0.00', '1768.16', 'Debited Invoice No: NE/2026-27/0078', '2026-09-18 10:29:01'),
(220, 16, 'Invoice', '2026-09-18', 104, 'Invoices', '89.84', '0.00', '88.86', 'Debited Invoice No: NE/2026-27/0079', '2026-09-18 10:29:43'),
(221, 8, 'Invoice', '2026-09-18', 105, 'Invoices', '549.99', '0.00', '549.98', 'Debited Invoice No: NE/2026-27/0080', '2026-09-18 10:30:23'),
(222, 18, 'Invoice', '2026-09-18', 106, 'Invoices', '89.84', '0.00', '89.52', 'Debited Invoice No: NE/2026-27/0081', '2026-09-18 10:31:09'),
(223, 34, 'Payment', '2026-09-18', 81, 'Payments', '0.00', '260.00', '0.00', 'Collected via Cash. Ref: . ', '2026-09-18 10:33:22'),
(224, 34, 'Payment', '2026-09-18', 82, 'Payments', '0.00', '260.00', '-260.00', 'Collected via Cash. Ref: . ', '2026-09-18 10:33:22'),
(225, 60, 'Payment', '2026-09-18', 83, 'Payments', '0.00', '1524.00', '1693.36', 'Collected via Cash. Ref: . ', '2026-09-18 12:55:22'),
(226, 33, 'Payment', '2026-09-18', 84, 'Payments', '0.00', '1229.00', '539.16', 'Collected via Cash. Ref: . ', '2026-09-18 12:56:22'),
(227, 16, 'Payment', '2026-09-18', 85, 'Payments', '0.00', '90.00', '-1.14', 'Collected via Cash. Ref: . ', '2026-09-18 13:15:35'),
(228, 18, 'Payment', '2026-09-18', 86, 'Payments', '0.00', '90.00', '-0.48', 'Collected via Cash. Ref: . ', '2026-09-18 13:29:42'),
(229, 25, 'Payment', '2026-09-19', 87, 'Payments', '0.00', '1893.00', '2399.16', 'Collected via UPI. Ref: . ', '2026-09-19 10:50:21'),
(230, 53, 'Payment', '2026-09-19', 88, 'Payments', '0.00', '768.00', '0.31', 'Collected via Cash. Ref: . ', '2026-09-19 10:58:36'),
(231, 52, 'Payment', '2026-09-19', 89, 'Payments', '0.00', '1200.00', '1288.43', 'Collected via Cash. Ref: . ', '2026-09-19 10:59:20'),
(232, 26, 'Payment', '2026-09-19', 90, 'Payments', '0.00', '300.00', '2078.47', 'Collected via Cash. Ref: . ', '2026-09-19 11:19:35'),
(233, 53, 'Invoice', '2026-09-21', 107, 'Invoices', '1099.98', '0.00', '1100.29', 'Debited Invoice No: NE/2026-27/0082', '2026-09-21 05:47:19'),
(234, 39, 'Payment', '2026-09-21', 91, 'Payments', '0.00', '200.00', '659.62', 'Collected via Cash. Ref: . ', '2026-09-21 12:00:07'),
(235, 41, 'Payment', '2026-09-21', 92, 'Payments', '0.00', '960.00', '-0.09', 'Collected via Cash. Ref: . ', '2026-09-21 12:03:21'),
(236, 45, 'Payment', '2026-09-21', 93, 'Payments', '0.00', '600.00', '2547.98', 'Collected via Cash. Ref: . ', '2026-09-21 13:16:34'),
(237, 56, 'Payment', '2026-09-22', 94, 'Payments', '0.00', '1299.90', '0.00', 'Collected via Cash. Ref: . ', '2026-09-22 06:30:20'),
(238, 61, 'Opening Balance', '2026-09-22', 61, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-09-22 09:16:41'),
(239, 62, 'Opening Balance', '2026-09-22', 62, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-09-22 09:19:46'),
(240, 63, 'Opening Balance', '2026-09-22', 63, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-09-22 09:21:02'),
(241, 64, 'Opening Balance', '2026-09-22', 64, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-09-22 09:22:25'),
(242, 65, 'Opening Balance', '2026-09-22', 65, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-09-22 09:23:15'),
(243, 51, 'Invoice', '2026-09-22', 108, 'Invoices', '1049.48', '0.00', '1049.13', 'Debited Invoice No: NE/2026-27/0083', '2026-09-22 11:24:01'),
(244, 51, 'Payment', '2026-09-22', 95, 'Payments', '0.00', '1050.00', '-0.87', 'Collected via Cash. Ref: . ', '2026-09-22 11:24:44'),
(245, 49, 'Invoice', '2026-09-22', 109, 'Invoices', '577.52', '0.00', '577.98', 'Debited Invoice No: NE/2026-27/0084', '2026-09-22 11:25:08'),
(246, 50, 'Invoice', '2026-09-22', 110, 'Invoices', '130.00', '0.00', '129.94', 'Debited Invoice No: NE/2026-27/0085', '2026-09-22 11:26:13'),
(247, 63, 'Invoice', '2026-09-22', 111, 'Invoices', '983.27', '0.00', '983.27', 'Debited Invoice No: NE/2026-27/0086', '2026-09-22 11:27:19'),
(248, 61, 'Invoice', '2026-09-22', 112, 'Invoices', '140.00', '0.00', '140.00', 'Debited Invoice No: NE/2026-27/0087', '2026-09-22 11:28:09'),
(249, 64, 'Invoice', '2026-09-22', 113, 'Invoices', '563.32', '0.00', '563.32', 'Debited Invoice No: NE/2026-27/0088', '2026-09-22 11:28:46'),
(250, 62, 'Invoice', '2026-09-22', 114, 'Invoices', '2357.37', '0.00', '2357.37', 'Debited Invoice No: NE/2026-27/0089', '2026-09-22 11:29:26'),
(251, 51, 'Invoice', '2026-09-22', 115, 'Invoices', '1084.62', '0.00', '1083.75', 'Debited Invoice No: NE/2026-27/0090', '2026-09-22 11:47:45'),
(252, 50, 'Payment', '2026-09-22', 96, 'Payments', '0.00', '129.94', '0.00', 'Collected via Cash. Ref: . ', '2026-09-22 13:09:33'),
(253, 12, 'Payment', '2026-09-23', 97, 'Payments', '0.00', '180.00', '-0.32', 'Collected via Cash. Ref: . ', '2026-09-23 08:18:35'),
(254, 15, 'Payment', '2026-09-23', 98, 'Payments', '0.00', '658.00', '0.16', 'Collected via Cash. Ref: . ', '2026-09-23 08:19:03'),
(255, 66, 'Opening Balance', '2026-09-23', 66, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-09-23 10:44:41'),
(256, 67, 'Opening Balance', '2026-09-23', 67, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-09-23 10:46:30'),
(257, 26, 'Payment', '2026-09-26', 99, 'Payments', '0.00', '300.00', '1778.47', 'Collected via Cash. Ref: . ', '2026-09-28 04:27:57'),
(258, 39, 'Payment', '2026-09-28', 100, 'Payments', '0.00', '200.00', '459.62', 'Collected via Cash. Ref: . ', '2026-09-28 11:59:30'),
(259, 45, 'Payment', '2026-09-28', 101, 'Payments', '0.00', '500.00', '2047.98', 'Collected via Cash. Ref: . ', '2026-09-28 11:59:51'),
(260, 18, 'Invoice', '2026-09-29', 116, 'Invoices', '239.40', '0.00', '238.92', 'Debited Invoice No: NE/2026-27/0091', '2026-09-29 04:28:02'),
(261, 66, 'Invoice', '2026-09-29', 117, 'Invoices', '532.04', '0.00', '532.04', 'Debited Invoice No: NE/2026-27/0092', '2026-09-29 04:28:30'),
(262, 67, 'Invoice', '2026-09-29', 118, 'Invoices', '379.13', '0.00', '379.13', 'Debited Invoice No: NE/2026-27/0093', '2026-09-29 04:28:49'),
(263, 18, 'Payment', '2026-09-29', 102, 'Payments', '0.00', '239.00', '-0.08', 'Collected via Cash. Ref: . ', '2026-09-29 04:29:22'),
(264, 61, 'Payment', '2026-09-29', 103, 'Payments', '0.00', '140.00', '0.00', 'Collected via Cash. Ref: . ', '2026-09-30 05:33:08'),
(265, 63, 'Payment', '2026-09-29', 104, 'Payments', '0.00', '500.00', '483.27', 'Collected via UPI. Ref: . ', '2026-09-30 05:33:35'),
(266, 49, 'Payment', '2026-10-01', 105, 'Payments', '0.00', '578.00', '-0.02', 'Collected via Cash. Ref: . ', '2026-10-01 13:20:18'),
(267, 59, 'Payment', '2026-10-02', 106, 'Payments', '0.00', '333.00', '0.47', 'Collected via Cash. Ref: . ', '2026-10-02 08:36:19'),
(268, 68, 'Opening Balance', '2026-10-02', 68, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-10-02 08:53:28'),
(269, 69, 'Opening Balance', '2026-10-02', 69, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-10-02 08:55:00'),
(270, 70, 'Opening Balance', '2026-10-02', 70, 'None', '0.00', '0.00', '0.00', 'Retailer created with opening balance', '2026-10-02 08:56:29'),
(271, 49, 'Invoice', '2026-10-02', 119, 'Invoices', '333.48', '0.00', '333.46', 'Debited Invoice No: NE/2026-27/0094', '2026-10-02 11:03:48'),
(272, 60, 'Invoice', '2026-10-02', 120, 'Invoices', '650.00', '0.00', '2343.36', 'Debited Invoice No: NE/2026-27/0095', '2026-10-02 11:05:14'),
(273, 70, 'Invoice', '2026-10-02', 121, 'Invoices', '593.48', '0.00', '593.48', 'Debited Invoice No: NE/2026-27/0096', '2026-10-02 11:06:29'),
(274, 59, 'Invoice', '2026-10-02', 122, 'Invoices', '491.72', '0.00', '492.19', 'Debited Invoice No: NE/2026-27/0097', '2026-10-02 11:07:50'),
(275, 69, 'Invoice', '2026-10-02', 123, 'Invoices', '549.99', '0.00', '549.99', 'Debited Invoice No: NE/2026-27/0098', '2026-10-02 11:08:19'),
(276, 68, 'Invoice', '2026-10-02', 124, 'Invoices', '479.81', '0.00', '479.81', 'Debited Invoice No: NE/2026-27/0099', '2026-10-02 11:08:39'),
(277, 68, 'Payment', '2026-10-02', 107, 'Payments', '0.00', '480.00', '-0.19', 'Collected via Cash. Ref: . ', '2026-10-02 11:11:59'),
(278, 60, 'Payment', '2026-10-02', 108, 'Payments', '0.00', '650.00', '1693.36', 'Collected via UPI. Ref: . ', '2026-10-02 11:47:36'),
(279, 70, 'Payment', '2026-10-02', 109, 'Payments', '0.00', '593.00', '0.48', 'Collected via Cash. Ref: . ', '2026-10-02 12:21:50');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
  `category` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `gst_percentage` decimal(5,2) DEFAULT 0.00,
  `gst_amount` decimal(10,2) DEFAULT 0.00,
  `expense_date` date NOT NULL,
  `paid_to` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Cash'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `category`, `amount`, `gst_percentage`, `gst_amount`, `expense_date`, `paid_to`, `remarks`, `created_by`, `created_at`, `payment_method`) VALUES
(3, 'Office / Stationery', '11694.92', '18.00', '2105.09', '2026-07-09', 'CLICKTRONICS - GSTIN- 29AOQPP5207G1ZK', '1526/1B, Deshpande Galli, Belagavi, 590001\r\nMobile:- 9886450148', 1, '2026-07-16 03:12:52', 'Cash'),
(4, 'Travel / Fuel', '100.00', '0.00', '0.00', '2026-07-16', 'fuel', '', 1, '2026-08-20 02:19:50', 'UPI'),
(5, 'Travel / Fuel', '120.00', '0.00', '0.00', '2026-07-17', 'fuel', '', 1, '2026-08-20 02:20:17', 'UPI'),
(6, 'Travel / Fuel', '120.00', '0.00', '0.00', '2026-07-19', 'fuel', '', 1, '2026-08-20 02:20:47', 'UPI'),
(7, 'Travel / Fuel', '150.00', '0.00', '0.00', '2026-07-23', 'fuel', '', 1, '2026-08-20 02:21:35', 'UPI'),
(8, 'Travel / Fuel', '180.00', '0.00', '0.00', '2026-07-26', 'fuel', '', 1, '2026-08-20 02:22:09', 'UPI'),
(9, 'Travel / Fuel', '130.00', '0.00', '0.00', '2026-07-29', 'fuel', '', 1, '2026-08-20 02:22:46', 'UPI'),
(10, 'Travel / Fuel', '130.00', '0.00', '0.00', '2026-07-30', 'fuel', '', 1, '2026-08-20 02:23:24', 'UPI'),
(11, 'Travel / Fuel', '120.00', '0.00', '0.00', '2026-07-30', 'fuel', '', 1, '2026-08-20 02:23:44', 'UPI'),
(12, 'Travel / Fuel', '130.00', '0.00', '0.00', '2026-08-03', 'fuel', '', 1, '2026-08-20 02:24:18', 'UPI'),
(13, 'Travel / Fuel', '120.00', '0.00', '0.00', '2026-08-04', 'fuel', '', 1, '2026-08-20 02:24:39', 'Cash'),
(14, 'Travel / Fuel', '120.00', '0.00', '0.00', '2026-08-07', 'fuel', '', 1, '2026-08-20 02:24:59', 'Cash'),
(15, 'Travel / Fuel', '280.00', '0.00', '0.00', '2026-08-12', 'fuel', '', 1, '2026-08-20 02:25:18', 'Cash'),
(16, 'Travel / Fuel', '110.00', '0.00', '0.00', '2026-08-17', 'fuel', '', 1, '2026-08-20 02:25:40', 'UPI'),
(17, 'Travel / Fuel', '70.00', '0.00', '0.00', '2026-08-20', 'fuel', '', 1, '2026-08-24 03:30:47', 'Cash'),
(18, 'Travel / Fuel', '80.00', '0.00', '0.00', '2026-08-21', 'fuel', '', 1, '2026-08-24 03:31:09', 'Cash'),
(19, 'Travel / Fuel', '110.00', '0.00', '0.00', '2026-08-23', 'fuel', '', 1, '2026-08-24 03:31:24', 'Cash'),
(20, 'Travel / Fuel', '110.00', '0.00', '0.00', '2026-08-25', 'fuel', '', 1, '2026-08-26 06:08:19', 'Cash'),
(21, 'Travel / Fuel', '50.00', '0.00', '0.00', '2026-08-31', 'fuel', '', 1, '2026-08-31 08:35:38', 'Cash'),
(22, 'Travel / Fuel', '50.00', '0.00', '0.00', '2026-09-02', 'fuel', '', 1, '2026-09-05 10:16:36', 'Cash'),
(23, 'Travel / Fuel', '100.00', '0.00', '0.00', '2026-09-04', 'fuel', '', 1, '2026-09-05 10:17:07', 'Cash'),
(24, 'Travel / Fuel', '100.00', '0.00', '0.00', '2026-09-05', 'fuel', '', 1, '2026-09-05 13:05:21', 'Cash'),
(25, 'Travel / Fuel', '80.00', '0.00', '0.00', '2026-09-07', '', '', 1, '2026-09-08 08:41:38', 'Cash'),
(26, 'Travel / Fuel', '100.00', '0.00', '0.00', '2026-09-10', 'fuel', '', 1, '2026-09-16 13:19:21', 'Cash'),
(27, 'Travel / Fuel', '270.00', '0.00', '0.00', '2026-09-11', 'fuel', '', 1, '2026-09-16 13:20:04', 'Cash'),
(28, 'Travel / Fuel', '80.00', '0.00', '0.00', '2026-09-12', 'fuel', '', 1, '2026-09-16 13:20:34', 'Cash'),
(29, 'Travel / Fuel', '80.00', '0.00', '0.00', '2026-09-13', 'fuel', '', 1, '2026-09-16 13:22:29', 'Cash'),
(30, 'Travel / Fuel', '100.00', '0.00', '0.00', '2026-09-17', 'fuel', '', 1, '2026-09-17 14:30:09', 'Cash'),
(31, 'Travel / Fuel', '50.00', '0.00', '0.00', '2026-09-18', 'fuel', '', 1, '2026-09-18 15:01:53', 'Cash'),
(32, 'Miscellaneous', '50.00', '0.00', '0.00', '2026-09-18', 'Transport', 'VRL transport cost', 1, '2026-09-18 15:02:32', 'Cash'),
(33, 'Miscellaneous', '20.00', '0.00', '0.00', '2026-09-18', 'transport', 'VRL TRANSPORT COST', 1, '2026-09-18 15:02:54', 'Cash'),
(34, 'Travel / Fuel', '220.00', '0.00', '0.00', '2026-09-20', 'fuel', '', 1, '2026-09-23 03:58:00', 'Cash'),
(35, 'Travel / Fuel', '50.00', '0.00', '0.00', '2026-09-21', 'fuel', '', 1, '2026-09-23 03:58:40', 'Cash'),
(36, 'Travel / Fuel', '100.00', '0.00', '0.00', '2026-09-22', 'fuel', '', 1, '2026-09-23 03:58:57', 'Cash'),
(37, 'Travel / Fuel', '50.00', '0.00', '0.00', '2026-09-23', 'fuel', '', 1, '2026-09-28 04:28:31', 'Cash'),
(38, 'Travel / Fuel', '100.00', '0.00', '0.00', '2026-09-27', 'fuel', '', 1, '2026-09-28 04:34:15', 'Cash'),
(39, 'Travel / Fuel', '120.00', '0.00', '0.00', '2026-09-28', 'fuel', '', 1, '2026-10-02 12:19:39', 'Cash'),
(40, 'Travel / Fuel', '80.00', '0.00', '0.00', '2026-10-02', 'fuel', '', 1, '2026-10-02 12:20:11', 'Cash');

-- --------------------------------------------------------

--
-- Table structure for table `expiry_records`
--

CREATE TABLE `expiry_records` (
  `id` int(11) NOT NULL,
  `retailer_id` int(11) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `rate` decimal(10,2) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `collected_by` int(11) NOT NULL,
  `status` varchar(50) DEFAULT 'Collected',
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `expiry_records`
--

INSERT INTO `expiry_records` (`id`, `retailer_id`, `sku_id`, `quantity`, `rate`, `amount`, `collected_by`, `status`, `remarks`, `created_at`) VALUES
(2, 13, 21, 6, '38.08', '228.48', 15, 'Collected', '', '2026-08-05 12:25:50'),
(3, 13, 22, 6, '38.08', '228.48', 15, 'Collected', '', '2026-08-05 12:26:21');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_history`
--

CREATE TABLE `inventory_history` (
  `id` int(11) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `transaction_type` enum('Opening Stock','Stock Addition','Stock Reduction','Manual Adjustment','Purchase Entry','Invoice Reduction') COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `previous_stock` int(11) NOT NULL,
  `new_stock` int(11) NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reference_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory_history`
--

INSERT INTO `inventory_history` (`id`, `sku_id`, `transaction_type`, `quantity`, `previous_stock`, `new_stock`, `reference_id`, `reference_type`, `remarks`, `created_at`) VALUES
(19, 17, 'Opening Stock', 240, 0, 240, NULL, NULL, 'SKU created with opening stock', '2026-07-13 07:55:48'),
(20, 16, 'Invoice Reduction', 10, 100, 90, 2, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0001', '2026-07-13 14:49:56'),
(21, 14, 'Invoice Reduction', 12, 80, 68, 2, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0001', '2026-07-13 14:49:56'),
(22, 12, 'Invoice Reduction', 1, 60, 59, 2, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0001', '2026-07-13 14:49:56'),
(23, 13, 'Invoice Reduction', 10, 80, 70, 2, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0001', '2026-07-13 14:49:56'),
(24, 18, 'Opening Stock', 240, 0, 240, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:18:26'),
(25, 21, 'Opening Stock', 240, 0, 240, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:21:38'),
(26, 22, 'Opening Stock', 240, 0, 240, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:23:08'),
(27, 23, 'Opening Stock', 240, 0, 240, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:24:32'),
(28, 25, 'Opening Stock', 240, 0, 240, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:26:23'),
(29, 26, 'Opening Stock', 240, 0, 240, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:27:43'),
(30, 28, 'Opening Stock', 240, 0, 240, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:28:48'),
(31, 29, 'Opening Stock', 960, 0, 960, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:34:30'),
(32, 30, 'Opening Stock', 300, 0, 300, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:37:22'),
(33, 31, 'Opening Stock', 180, 0, 180, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:40:58'),
(34, 32, 'Opening Stock', 180, 0, 180, NULL, NULL, 'SKU created with opening stock', '2026-07-15 11:43:00'),
(35, 29, 'Invoice Reduction', 12, 960, 948, 3, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0002', '2026-07-15 12:16:55'),
(36, 29, 'Invoice Reduction', 24, 948, 924, 4, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0003', '2026-07-15 12:19:43'),
(37, 29, 'Invoice Reduction', 24, 924, 900, 5, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0004', '2026-07-15 12:25:13'),
(38, 29, 'Invoice Reduction', 24, 900, 876, 6, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0005', '2026-07-15 12:26:20'),
(39, 18, 'Invoice Reduction', 6, 240, 234, 6, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0005', '2026-07-15 12:26:20'),
(40, 21, 'Invoice Reduction', 6, 240, 234, 6, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0005', '2026-07-15 12:26:20'),
(41, 22, 'Invoice Reduction', 6, 240, 234, 6, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0005', '2026-07-15 12:26:20'),
(42, 23, 'Invoice Reduction', 6, 240, 234, 6, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0005', '2026-07-15 12:26:20'),
(43, 31, 'Invoice Reduction', 6, 180, 174, 7, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0006', '2026-07-15 12:26:53'),
(44, 32, 'Invoice Reduction', 6, 180, 174, 7, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0006', '2026-07-15 12:26:53'),
(45, 29, 'Invoice Reduction', 60, 876, 816, 8, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0007', '2026-07-15 12:27:14'),
(46, 30, 'Invoice Reduction', 12, 300, 288, 8, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0007', '2026-07-15 12:27:14'),
(47, 18, 'Invoice Reduction', 6, 234, 228, 9, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0008', '2026-07-15 12:27:31'),
(48, 29, 'Invoice Reduction', 12, 816, 804, 9, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0008', '2026-07-15 12:27:31'),
(49, 18, 'Invoice Reduction', 6, 228, 222, 10, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0009', '2026-07-15 12:28:17'),
(50, 21, 'Invoice Reduction', 6, 234, 228, 10, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0009', '2026-07-15 12:28:17'),
(51, 29, 'Invoice Reduction', 24, 804, 780, 11, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0010', '2026-07-15 12:28:42'),
(52, 29, 'Invoice Reduction', 24, 780, 756, 12, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0011', '2026-07-15 12:28:58'),
(53, 18, 'Invoice Reduction', 3, 222, 219, 12, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0011', '2026-07-15 12:28:58'),
(54, 21, 'Invoice Reduction', 3, 228, 225, 12, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0011', '2026-07-15 12:28:58'),
(55, 29, 'Invoice Reduction', 24, 756, 732, 13, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0012', '2026-07-15 12:29:51'),
(56, 18, 'Invoice Reduction', 6, 219, 213, 13, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0012', '2026-07-15 12:29:51'),
(57, 21, 'Invoice Reduction', 6, 225, 219, 13, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0012', '2026-07-15 12:29:51'),
(58, 22, 'Invoice Reduction', 6, 234, 228, 13, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0012', '2026-07-15 12:29:51'),
(59, 23, 'Invoice Reduction', 6, 234, 228, 13, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0012', '2026-07-15 12:29:51'),
(60, 33, 'Opening Stock', 240, 0, 240, NULL, NULL, 'SKU created with opening stock', '2026-07-16 09:38:37'),
(61, 28, 'Invoice Reduction', 6, 240, 234, 14, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0013', '2026-07-16 11:16:11'),
(62, 18, 'Invoice Reduction', 6, 213, 207, 14, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0013', '2026-07-16 11:16:11'),
(63, 18, 'Invoice Reduction', 6, 207, 201, 15, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0014', '2026-07-16 11:19:30'),
(64, 21, 'Invoice Reduction', 6, 219, 213, 15, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0014', '2026-07-16 11:19:30'),
(65, 22, 'Invoice Reduction', 6, 228, 222, 15, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0014', '2026-07-16 11:19:30'),
(66, 28, 'Invoice Reduction', 6, 234, 228, 15, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0014', '2026-07-16 11:19:30'),
(67, 23, 'Invoice Reduction', 3, 228, 225, 15, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0014', '2026-07-16 11:19:30'),
(68, 25, 'Invoice Reduction', 3, 240, 237, 15, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0014', '2026-07-16 11:19:30'),
(69, 33, 'Invoice Reduction', 3, 240, 237, 15, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0014', '2026-07-16 11:19:30'),
(70, 26, 'Invoice Reduction', 3, 240, 237, 15, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0014', '2026-07-16 11:19:30'),
(71, 18, 'Invoice Reduction', 12, 201, 189, 16, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0015', '2026-07-16 11:19:43'),
(72, 23, 'Invoice Reduction', 12, 225, 213, 16, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0015', '2026-07-16 11:19:43'),
(73, 29, 'Invoice Reduction', 24, 732, 708, 17, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0016', '2026-07-16 11:20:05'),
(74, 18, 'Invoice Reduction', 12, 189, 177, 17, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0016', '2026-07-16 11:20:05'),
(75, 18, 'Invoice Reduction', 12, 177, 165, 18, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0017', '2026-07-16 11:20:16'),
(76, 22, 'Invoice Reduction', 6, 222, 216, 18, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0017', '2026-07-16 11:20:16'),
(77, 25, 'Invoice Reduction', 6, 237, 231, 18, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0017', '2026-07-16 11:20:16'),
(78, 30, 'Invoice Reduction', 12, 288, 276, 19, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0018', '2026-07-16 11:20:32'),
(79, 33, 'Invoice Reduction', 12, 237, 225, 20, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0019', '2026-07-16 11:20:57'),
(80, 21, 'Invoice Reduction', 12, 213, 201, 20, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0019', '2026-07-16 11:20:57'),
(81, 18, 'Invoice Reduction', 24, 165, 141, 21, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0020', '2026-07-16 11:21:18'),
(82, 25, 'Invoice Reduction', 6, 231, 225, 22, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0021', '2026-07-16 11:21:37'),
(83, 18, 'Invoice Reduction', 6, 141, 135, 22, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0021', '2026-07-16 11:21:37'),
(84, 21, 'Invoice Reduction', 6, 201, 195, 22, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0021', '2026-07-16 11:21:37'),
(85, 22, 'Invoice Reduction', 6, 216, 210, 22, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0021', '2026-07-16 11:21:37'),
(86, 18, 'Invoice Reduction', 24, 135, 111, 23, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0022', '2026-07-16 11:23:06'),
(87, 22, 'Invoice Reduction', 12, 210, 198, 24, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0023', '2026-07-16 11:26:12'),
(88, 18, 'Invoice Reduction', 6, 111, 105, 24, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0023', '2026-07-16 11:26:12'),
(89, 21, 'Invoice Reduction', 6, 195, 189, 24, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0023', '2026-07-16 11:26:12'),
(90, 29, 'Invoice Reduction', 60, 708, 648, 25, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0024', '2026-07-16 11:26:27'),
(91, 31, 'Invoice Reduction', 6, 174, 168, 25, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0024', '2026-07-16 11:26:27'),
(92, 32, 'Invoice Reduction', 6, 174, 168, 25, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0024', '2026-07-16 11:26:27'),
(93, 34, 'Opening Stock', 80, 0, 80, NULL, NULL, 'SKU created with opening stock', '2026-07-17 03:13:09'),
(94, 29, 'Stock Addition', 12, 648, 660, 3, 'Invoices', 'Stock restored — Invoice NE/2026-27/0002 deleted', '2026-07-22 12:55:39'),
(95, 16, 'Stock Addition', 10, 90, 100, 2, 'Invoices', 'Stock restored — Invoice NE/2026-27/0001 deleted', '2026-07-22 12:57:15'),
(96, 14, 'Stock Addition', 12, 68, 80, 2, 'Invoices', 'Stock restored — Invoice NE/2026-27/0001 deleted', '2026-07-22 12:57:15'),
(97, 12, 'Stock Addition', 1, 59, 60, 2, 'Invoices', 'Stock restored — Invoice NE/2026-27/0001 deleted', '2026-07-22 12:57:15'),
(98, 13, 'Stock Addition', 10, 70, 80, 2, 'Invoices', 'Stock restored — Invoice NE/2026-27/0001 deleted', '2026-07-22 12:57:15'),
(99, 33, 'Stock Addition', 12, 225, 237, 20, 'Invoices', 'Stock restored — Invoice NE/2026-27/0019 deleted', '2026-07-22 13:00:12'),
(100, 21, 'Stock Addition', 12, 189, 201, 20, 'Invoices', 'Stock restored — Invoice NE/2026-27/0019 deleted', '2026-07-22 13:00:12'),
(101, 18, 'Stock Addition', 24, 105, 129, 21, 'Invoices', 'Stock restored — Invoice NE/2026-27/0020 deleted', '2026-07-22 13:00:36'),
(120, 17, 'Invoice Reduction', 10, 480, 470, 50, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0025', '2026-07-25 10:22:40'),
(121, 17, 'Invoice Reduction', 10, 470, 460, 51, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0026', '2026-07-25 11:11:54'),
(122, 12, 'Invoice Reduction', 6, 120, 114, 52, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0027', '2026-07-25 11:26:27'),
(123, 14, 'Invoice Reduction', 3, 160, 157, 53, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0028', '2026-07-25 11:32:15'),
(124, 16, 'Invoice Reduction', 10, 200, 190, 53, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0028', '2026-07-25 11:32:15'),
(212, 29, 'Invoice Reduction', 24, 1620, 1596, 54, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0029', '2026-07-29 11:56:41'),
(213, 36, 'Opening Stock', 0, 0, 0, NULL, NULL, 'SKU created with opening stock', '2026-07-31 04:13:02'),
(215, 17, 'Invoice Reduction', 240, 660, 420, 55, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0030', '2026-08-02 14:39:41'),
(224, 37, 'Opening Stock', 48, 0, 48, NULL, NULL, 'SKU created with opening stock', '2026-08-02 15:19:35'),
(225, 38, 'Opening Stock', 48, 0, 48, NULL, NULL, 'SKU created with opening stock', '2026-08-02 15:20:56'),
(226, 39, 'Opening Stock', 48, 0, 48, NULL, NULL, 'SKU created with opening stock', '2026-08-02 15:22:06'),
(232, 40, 'Opening Stock', 0, 0, 0, NULL, NULL, 'SKU created with opening stock', '2026-08-02 15:35:24'),
(233, 41, 'Opening Stock', 0, 0, 0, NULL, NULL, 'SKU created with opening stock', '2026-08-02 15:38:12'),
(234, 42, 'Opening Stock', 0, 0, 0, NULL, NULL, 'SKU created with opening stock', '2026-08-02 15:41:57'),
(284, 18, 'Invoice Reduction', 6, 675, 669, 56, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0031', '2026-08-03 05:45:18'),
(285, 23, 'Invoice Reduction', 6, 327, 321, 56, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0031', '2026-08-03 05:45:18'),
(286, 26, 'Invoice Reduction', 6, 351, 345, 56, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0031', '2026-08-03 05:45:18'),
(287, 33, 'Invoice Reduction', 6, 351, 345, 56, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0031', '2026-08-03 05:45:18'),
(288, 36, 'Invoice Reduction', 1, 41, 40, 56, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0031', '2026-08-03 05:45:18'),
(289, 18, 'Invoice Reduction', 6, 669, 663, 57, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0032', '2026-08-03 05:56:28'),
(290, 22, 'Invoice Reduction', 6, 306, 300, 57, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0032', '2026-08-03 05:56:28'),
(291, 25, 'Invoice Reduction', 6, 333, 327, 57, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0032', '2026-08-03 05:56:28'),
(292, 28, 'Invoice Reduction', 6, 342, 336, 57, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0032', '2026-08-03 05:56:28'),
(293, 36, 'Invoice Reduction', 1, 40, 39, 57, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0032', '2026-08-03 05:56:28'),
(294, 29, 'Invoice Reduction', 24, 1500, 1476, 57, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0032', '2026-08-03 05:56:28'),
(295, 22, 'Invoice Reduction', 6, 300, 294, 58, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0033', '2026-08-03 05:57:05'),
(296, 29, 'Invoice Reduction', 24, 1476, 1452, 59, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0034', '2026-08-03 05:57:48'),
(297, 29, 'Invoice Reduction', 24, 1452, 1428, 60, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0035', '2026-08-03 05:58:22'),
(298, 18, 'Invoice Reduction', 24, 663, 639, 61, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0036', '2026-08-03 05:59:04'),
(299, 36, 'Invoice Reduction', 1, 39, 38, 61, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0036', '2026-08-03 05:59:04'),
(300, 18, 'Invoice Reduction', 18, 639, 621, 62, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0037', '2026-08-03 05:59:30'),
(301, 25, 'Invoice Reduction', 6, 327, 321, 62, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0037', '2026-08-03 05:59:30'),
(302, 36, 'Invoice Reduction', 1, 38, 37, 62, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0037', '2026-08-03 05:59:30'),
(303, 29, 'Invoice Reduction', 24, 1428, 1404, 62, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0037', '2026-08-03 05:59:30'),
(304, 17, 'Invoice Reduction', 20, 1068, 1048, 63, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0038', '2026-08-04 11:30:51'),
(305, 40, 'Invoice Reduction', 40, 960, 920, 63, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0038', '2026-08-04 11:30:51'),
(306, 34, 'Invoice Reduction', 20, 220, 200, 63, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0038', '2026-08-04 11:30:51'),
(307, 29, 'Invoice Reduction', 12, 1392, 1380, 63, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0038', '2026-08-04 11:30:51'),
(308, 17, 'Invoice Reduction', 10, 1048, 1038, 64, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0039', '2026-08-04 11:32:30'),
(309, 17, 'Invoice Reduction', 20, 1038, 1018, 65, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0040', '2026-08-04 11:33:22'),
(310, 31, 'Invoice Reduction', 12, 324, 312, 65, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0040', '2026-08-04 11:33:22'),
(311, 34, 'Invoice Reduction', 40, 200, 160, 66, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0041', '2026-08-04 11:34:32'),
(312, 17, 'Invoice Reduction', 12, 1018, 1006, 66, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0041', '2026-08-04 11:34:32'),
(313, 31, 'Invoice Reduction', 12, 312, 300, 66, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0041', '2026-08-04 11:34:32'),
(314, 13, 'Invoice Reduction', 4, 156, 152, 67, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0042', '2026-08-04 11:36:52'),
(315, 12, 'Invoice Reduction', 2, 112, 110, 67, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0042', '2026-08-04 11:36:52'),
(316, 17, 'Invoice Reduction', 10, 1006, 996, 67, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0042', '2026-08-04 11:36:52'),
(317, 39, 'Invoice Reduction', 4, 92, 88, 68, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0043', '2026-08-05 12:05:14'),
(318, 38, 'Invoice Reduction', 4, 92, 88, 68, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0043', '2026-08-05 12:05:14'),
(319, 37, 'Invoice Reduction', 4, 92, 88, 68, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0043', '2026-08-05 12:05:14'),
(320, 18, 'Invoice Reduction', 6, 615, 609, 69, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0044', '2026-08-05 12:06:18'),
(321, 22, 'Invoice Reduction', 6, 288, 282, 69, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0044', '2026-08-05 12:06:18'),
(322, 28, 'Invoice Reduction', 6, 330, 324, 69, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0044', '2026-08-05 12:06:18'),
(323, 23, 'Invoice Reduction', 6, 315, 309, 69, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0044', '2026-08-05 12:06:18'),
(324, 36, 'Invoice Reduction', 1, 36, 35, 69, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0044', '2026-08-05 12:06:18'),
(325, 37, 'Invoice Reduction', 4, 56, 52, 70, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0045', '2026-08-06 09:16:42'),
(326, 38, 'Invoice Reduction', 4, 50, 46, 70, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0045', '2026-08-06 09:16:42'),
(327, 39, 'Invoice Reduction', 4, 50, 46, 70, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0045', '2026-08-06 09:16:42'),
(328, 18, 'Invoice Reduction', 12, 513, 501, 71, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(329, 21, 'Invoice Reduction', 12, 285, 273, 71, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(330, 33, 'Invoice Reduction', 12, 297, 285, 71, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(331, 26, 'Invoice Reduction', 12, 309, 297, 71, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(332, 32, 'Invoice Reduction', 12, 312, 300, 71, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(333, 31, 'Invoice Reduction', 12, 252, 240, 71, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(334, 37, 'Invoice Reduction', 6, 52, 46, 71, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(335, 38, 'Invoice Reduction', 12, 46, 34, 71, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(336, 39, 'Invoice Reduction', 12, 46, 34, 71, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(337, 36, 'Invoice Reduction', 2, 19, 17, 71, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0046', '2026-08-06 09:18:32'),
(338, 18, 'Invoice Reduction', 24, 501, 477, 72, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0047', '2026-08-06 09:19:45'),
(339, 36, 'Invoice Reduction', 6, 17, 11, 73, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0048', '2026-08-06 09:20:50'),
(340, 28, 'Invoice Reduction', 6, 294, 288, 73, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0048', '2026-08-06 09:20:50'),
(341, 37, 'Invoice Reduction', 6, 46, 40, 74, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0049', '2026-08-06 09:21:30'),
(342, 38, 'Invoice Reduction', 6, 34, 28, 74, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0049', '2026-08-06 09:21:30'),
(343, 39, 'Invoice Reduction', 6, 34, 28, 74, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0049', '2026-08-06 09:21:30'),
(344, 29, 'Invoice Reduction', 60, 1320, 1260, 74, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0049', '2026-08-06 09:21:30'),
(345, 18, 'Invoice Reduction', 12, 477, 465, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(346, 21, 'Invoice Reduction', 12, 273, 261, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(347, 22, 'Invoice Reduction', 12, 258, 246, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(348, 23, 'Invoice Reduction', 12, 273, 261, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(349, 25, 'Invoice Reduction', 12, 273, 261, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(350, 26, 'Invoice Reduction', 12, 297, 285, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(351, 28, 'Invoice Reduction', 12, 288, 276, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(352, 33, 'Invoice Reduction', 12, 285, 273, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(353, 37, 'Invoice Reduction', 12, 40, 28, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(354, 38, 'Invoice Reduction', 12, 28, 16, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(355, 39, 'Invoice Reduction', 12, 28, 16, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(356, 36, 'Invoice Reduction', 2, 11, 9, 75, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0050', '2026-08-06 09:22:20'),
(357, 18, 'Invoice Reduction', 12, 465, 453, 76, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0051', '2026-08-06 09:26:15'),
(358, 18, 'Invoice Reduction', 24, 453, 429, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(359, 21, 'Invoice Reduction', 12, 261, 249, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(360, 22, 'Invoice Reduction', 12, 246, 234, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(361, 23, 'Invoice Reduction', 12, 261, 249, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(362, 25, 'Invoice Reduction', 12, 261, 249, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(363, 26, 'Invoice Reduction', 12, 285, 273, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(364, 28, 'Invoice Reduction', 12, 276, 264, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(365, 33, 'Invoice Reduction', 12, 273, 261, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(366, 32, 'Invoice Reduction', 24, 300, 276, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(367, 31, 'Invoice Reduction', 36, 240, 204, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(368, 36, 'Invoice Reduction', 4, 9, 5, 77, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0052', '2026-08-06 09:27:14'),
(369, 18, 'Invoice Reduction', 12, 429, 417, 78, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0053', '2026-08-06 09:28:17'),
(370, 23, 'Invoice Reduction', 12, 249, 237, 78, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0053', '2026-08-06 09:28:17'),
(371, 33, 'Invoice Reduction', 12, 261, 249, 78, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0053', '2026-08-06 09:28:17'),
(372, 25, 'Invoice Reduction', 24, 249, 225, 78, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0053', '2026-08-06 09:28:17'),
(373, 39, 'Invoice Reduction', 4, 16, 12, 78, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0053', '2026-08-06 09:28:17'),
(374, 38, 'Invoice Reduction', 4, 16, 12, 78, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0053', '2026-08-06 09:28:17'),
(375, 37, 'Invoice Reduction', 4, 28, 24, 78, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0053', '2026-08-06 09:28:17'),
(376, 36, 'Invoice Reduction', 2, 5, 3, 78, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0053', '2026-08-06 09:28:17'),
(383, 34, 'Invoice Reduction', 99, 161, 62, 79, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0054', '2026-08-11 04:32:27'),
(384, 16, 'Invoice Reduction', 80, 110, 30, 79, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0054', '2026-08-11 04:32:27'),
(385, 17, 'Invoice Reduction', 50, 946, 896, 79, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0054', '2026-08-11 04:32:27'),
(386, 12, 'Purchase Entry', 60, 50, 110, 13, 'purchase', 'Purchase Entry. Supplier Invoice: 1692.  (Recorded by User: Shreyansh Janagouda)', '2026-08-11 04:35:51'),
(387, 13, 'Purchase Entry', 80, 72, 152, 13, 'purchase', 'Purchase Entry. Supplier Invoice: 1692.  (Recorded by User: Shreyansh Janagouda)', '2026-08-11 04:35:51'),
(388, 14, 'Purchase Entry', 80, 77, 157, 13, 'purchase', 'Purchase Entry. Supplier Invoice: 1692.  (Recorded by User: Shreyansh Janagouda)', '2026-08-11 04:35:51'),
(389, 34, 'Purchase Entry', 200, -238, -38, 13, 'purchase', 'Purchase Entry. Supplier Invoice: 1692.  (Recorded by User: Shreyansh Janagouda)', '2026-08-11 04:35:51'),
(390, 16, 'Purchase Entry', 100, -70, 30, 13, 'purchase', 'Purchase Entry. Supplier Invoice: 1692.  (Recorded by User: Shreyansh Janagouda)', '2026-08-11 04:35:51'),
(391, 17, 'Purchase Entry', 240, 656, 896, 13, 'purchase', 'Purchase Entry. Supplier Invoice: 1692.  (Recorded by User: Shreyansh Janagouda)', '2026-08-11 04:35:51'),
(392, 29, 'Invoice Reduction', 36, 1224, 1188, 80, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0055', '2026-08-15 04:44:56'),
(393, 18, 'Invoice Reduction', 12, 405, 393, 80, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0055', '2026-08-15 04:44:56'),
(394, 25, 'Invoice Reduction', 3, 222, 219, 80, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0055', '2026-08-15 04:44:56'),
(395, 23, 'Invoice Reduction', 3, 234, 231, 80, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0055', '2026-08-15 04:44:56'),
(396, 33, 'Invoice Reduction', 3, 246, 243, 80, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0055', '2026-08-15 04:44:56'),
(397, 28, 'Invoice Reduction', 3, 261, 258, 80, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0055', '2026-08-15 04:44:56'),
(398, 36, 'Invoice Reduction', 1, 2, 1, 80, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0055', '2026-08-15 04:44:56'),
(399, 30, 'Invoice Reduction', 60, 516, 456, 81, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0056', '2026-08-15 04:45:56'),
(400, 17, 'Invoice Reduction', 10, 886, 876, 82, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0057', '2026-08-15 04:46:19'),
(401, 12, 'Invoice Reduction', 6, 104, 98, 82, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0057', '2026-08-15 04:46:19'),
(402, 32, 'Invoice Reduction', 6, 270, 264, 83, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0058', '2026-08-15 04:46:39'),
(403, 31, 'Invoice Reduction', 6, 198, 192, 83, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0058', '2026-08-15 04:46:39'),
(417, 21, 'Purchase Entry', 120, 123, 243, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(418, 18, 'Purchase Entry', 120, 267, 387, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(419, 22, 'Purchase Entry', 120, 108, 228, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(420, 23, 'Purchase Entry', 120, 111, 231, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(421, 25, 'Purchase Entry', 120, 99, 219, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(422, 26, 'Purchase Entry', 120, 147, 267, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(423, 28, 'Purchase Entry', 120, 138, 258, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(424, 33, 'Purchase Entry', 120, 123, 243, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(425, 29, 'Purchase Entry', 960, 204, 1164, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(426, 30, 'Purchase Entry', 300, 150, 450, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(427, 31, 'Purchase Entry', 180, 12, 192, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(428, 32, 'Purchase Entry', 180, 84, 264, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(429, 36, 'Purchase Entry', 84, -45, 39, 10, 'purchase', 'Purchase Entry. Supplier Invoice: 22527.  (Recorded by User: Shreyansh Janagouda)', '2026-08-19 10:54:32'),
(430, 18, 'Invoice Reduction', 6, 387, 381, 84, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0059', '2026-08-19 10:55:04'),
(431, 21, 'Invoice Reduction', 6, 243, 237, 84, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0059', '2026-08-19 10:55:04'),
(432, 22, 'Invoice Reduction', 6, 228, 222, 84, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0059', '2026-08-19 10:55:04'),
(433, 26, 'Invoice Reduction', 6, 267, 261, 84, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0059', '2026-08-19 10:55:04'),
(434, 30, 'Invoice Reduction', 6, 450, 444, 84, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0059', '2026-08-19 10:55:04'),
(435, 36, 'Invoice Reduction', 1, 39, 38, 84, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0059', '2026-08-19 10:55:04'),
(436, 17, 'Invoice Reduction', 10, 856, 846, 84, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0059', '2026-08-19 10:55:04'),
(437, 29, 'Invoice Reduction', 24, 1164, 1140, 85, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0060', '2026-08-19 10:55:53'),
(438, 17, 'Invoice Reduction', 10, 846, 836, 85, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0060', '2026-08-19 10:55:53'),
(439, 17, 'Invoice Reduction', 20, 806, 786, 86, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0061', '2026-08-27 06:31:42'),
(444, 40, 'Invoice Reduction', 920, 1000, 80, 87, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0062', '2026-08-27 06:46:54'),
(449, 14, 'Invoice Reduction', 6, 151, 145, 88, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0063', '2026-08-27 06:53:02'),
(450, 13, 'Invoice Reduction', 6, 146, 140, 88, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0063', '2026-08-27 06:53:02'),
(451, 12, 'Invoice Reduction', 6, 92, 86, 88, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0063', '2026-08-27 06:53:02'),
(452, 17, 'Invoice Reduction', 50, 736, 686, 88, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0063', '2026-08-27 06:53:02'),
(453, 29, 'Invoice Reduction', 24, 1092, 1068, 89, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0064', '2026-09-02 10:35:40'),
(454, 29, 'Invoice Reduction', 24, 1068, 1044, 90, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0065', '2026-09-02 10:37:48'),
(455, 30, 'Invoice Reduction', 24, 414, 390, 90, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0065', '2026-09-02 10:37:48'),
(456, 39, 'Invoice Reduction', 2, 10, 8, 91, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0066', '2026-09-02 10:38:10'),
(457, 38, 'Invoice Reduction', 2, 10, 8, 91, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0066', '2026-09-02 10:38:10'),
(458, 37, 'Invoice Reduction', 2, 22, 20, 91, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0066', '2026-09-02 10:38:10'),
(459, 30, 'Invoice Reduction', 6, 390, 384, 91, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0066', '2026-09-02 10:38:10'),
(460, 17, 'Invoice Reduction', 20, 626, 606, 92, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0067', '2026-09-05 05:29:37'),
(461, 13, 'Invoice Reduction', 10, 127, 117, 93, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0068', '2026-09-05 05:30:50'),
(462, 17, 'Invoice Reduction', 20, 606, 586, 93, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0068', '2026-09-05 05:30:50'),
(463, 43, 'Opening Stock', 42, 0, 42, NULL, NULL, 'SKU created with opening stock', '2026-09-07 01:57:31'),
(464, 18, 'Purchase Entry', 480, -147, 333, 14, 'purchase', 'Purchase Entry. Supplier Invoice: 22648.  (Recorded by User: Shreyansh Janagouda)', '2026-09-07 01:58:17'),
(465, 37, 'Purchase Entry', 48, -28, 20, 14, 'purchase', 'Purchase Entry. Supplier Invoice: 22648.  (Recorded by User: Shreyansh Janagouda)', '2026-09-07 01:58:17'),
(466, 38, 'Purchase Entry', 48, -40, 8, 14, 'purchase', 'Purchase Entry. Supplier Invoice: 22648.  (Recorded by User: Shreyansh Janagouda)', '2026-09-07 01:58:17'),
(467, 39, 'Purchase Entry', 48, -40, 8, 14, 'purchase', 'Purchase Entry. Supplier Invoice: 22648.  (Recorded by User: Shreyansh Janagouda)', '2026-09-07 01:58:17'),
(468, 43, 'Purchase Entry', 42, 42, 84, 14, 'purchase', 'Purchase Entry. Supplier Invoice: 22648.  (Recorded by User: Shreyansh Janagouda)', '2026-09-07 01:58:17'),
(469, 18, 'Invoice Reduction', 48, 321, 273, 94, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0069', '2026-09-07 04:40:25'),
(470, 21, 'Invoice Reduction', 24, 201, 177, 94, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0069', '2026-09-07 04:40:25'),
(471, 36, 'Invoice Reduction', 3, 35, 32, 94, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0069', '2026-09-07 04:40:25'),
(472, 18, 'Invoice Reduction', 12, 273, 261, 95, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0070', '2026-09-07 04:44:21'),
(473, 21, 'Invoice Reduction', 12, 177, 165, 95, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0070', '2026-09-07 04:44:21'),
(474, 22, 'Invoice Reduction', 12, 210, 198, 95, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0070', '2026-09-07 04:44:21'),
(475, 26, 'Invoice Reduction', 12, 249, 237, 95, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0070', '2026-09-07 04:44:21'),
(476, 33, 'Invoice Reduction', 12, 231, 219, 95, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0070', '2026-09-07 04:44:21'),
(477, 43, 'Invoice Reduction', 2, 82, 80, 95, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0070', '2026-09-07 04:44:21'),
(478, 28, 'Invoice Reduction', 12, 246, 234, 96, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0071', '2026-09-08 08:28:45'),
(479, 18, 'Invoice Reduction', 6, 231, 225, 96, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0071', '2026-09-08 08:28:45'),
(480, 25, 'Invoice Reduction', 6, 201, 195, 96, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0071', '2026-09-08 08:28:45'),
(481, 36, 'Invoice Reduction', 1, 28, 27, 96, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0071', '2026-09-08 08:28:45'),
(482, 18, 'Invoice Reduction', 24, 225, 201, 97, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0072', '2026-09-08 08:29:40'),
(483, 22, 'Invoice Reduction', 12, 186, 174, 97, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0072', '2026-09-08 08:29:40'),
(484, 25, 'Invoice Reduction', 12, 195, 183, 97, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0072', '2026-09-08 08:29:40'),
(485, 33, 'Invoice Reduction', 12, 207, 195, 97, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0072', '2026-09-08 08:29:40'),
(486, 26, 'Invoice Reduction', 12, 225, 213, 97, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0072', '2026-09-08 08:29:40'),
(487, 36, 'Invoice Reduction', 3, 27, 24, 97, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0072', '2026-09-08 08:29:40'),
(488, 29, 'Invoice Reduction', 36, 936, 900, 97, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0072', '2026-09-08 08:29:40'),
(489, 17, 'Invoice Reduction', 100, 246, 146, 98, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0073', '2026-09-12 05:56:55'),
(495, 17, 'Purchase Entry', 480, -334, 146, 15, 'purchase', 'Purchase Entry. Supplier Invoice: 2069.  (Recorded by User: Shreyansh Janagouda)', '2026-09-12 06:18:14'),
(496, 40, 'Purchase Entry', 1000, -1920, -920, 15, 'purchase', 'Purchase Entry. Supplier Invoice: 2069.  (Recorded by User: Shreyansh Janagouda)', '2026-09-12 06:18:14'),
(497, 41, 'Purchase Entry', 4, 0, 4, 15, 'purchase', 'Purchase Entry. Supplier Invoice: 2069.  (Recorded by User: Shreyansh Janagouda)', '2026-09-12 06:18:14'),
(498, 42, 'Purchase Entry', 50, 0, 50, 15, 'purchase', 'Purchase Entry. Supplier Invoice: 2069.  (Recorded by User: Shreyansh Janagouda)', '2026-09-12 06:18:14'),
(499, 17, 'Purchase Entry', 240, -334, -94, 15, 'purchase', 'Purchase Entry. Supplier Invoice: 2069.  (Recorded by User: Shreyansh Janagouda)', '2026-09-12 06:18:14'),
(500, 17, 'Invoice Reduction', 240, 386, 146, 99, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0074', '2026-09-12 06:18:54'),
(501, 34, 'Purchase Entry', 400, -38, 362, 16, 'purchase', 'Purchase Entry. Supplier Invoice: 3151.  (Recorded by User: Shreyansh Janagouda)', '2026-09-18 07:43:44'),
(502, 16, 'Purchase Entry', 200, 20, 220, 16, 'purchase', 'Purchase Entry. Supplier Invoice: 3151.  (Recorded by User: Shreyansh Janagouda)', '2026-09-18 07:43:44'),
(503, 17, 'Purchase Entry', 480, 126, 606, 16, 'purchase', 'Purchase Entry. Supplier Invoice: 3151.  (Recorded by User: Shreyansh Janagouda)', '2026-09-18 07:43:44'),
(504, 34, 'Invoice Reduction', 40, 322, 282, 100, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0075', '2026-09-18 10:26:19'),
(505, 17, 'Invoice Reduction', 20, 586, 566, 101, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0076', '2026-09-18 10:27:02'),
(506, 14, 'Invoice Reduction', 10, 135, 125, 102, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0077', '2026-09-18 10:28:17'),
(507, 13, 'Invoice Reduction', 10, 107, 97, 102, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0077', '2026-09-18 10:28:17'),
(508, 17, 'Invoice Reduction', 20, 566, 546, 102, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0077', '2026-09-18 10:28:17'),
(509, 29, 'Invoice Reduction', 72, 804, 732, 103, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0078', '2026-09-18 10:29:01'),
(510, 29, 'Invoice Reduction', 12, 732, 720, 104, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0079', '2026-09-18 10:29:43'),
(511, 37, 'Invoice Reduction', 6, 14, 8, 105, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0080', '2026-09-18 10:30:23'),
(512, 38, 'Invoice Reduction', 3, 5, 2, 105, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0080', '2026-09-18 10:30:23'),
(513, 39, 'Invoice Reduction', 3, 5, 2, 105, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0080', '2026-09-18 10:30:23'),
(514, 29, 'Invoice Reduction', 12, 720, 708, 106, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0081', '2026-09-18 10:31:09'),
(515, 44, 'Opening Stock', 0, 0, 0, NULL, NULL, 'SKU created with opening stock', '2026-09-21 04:46:42'),
(516, 45, 'Opening Stock', 0, 0, 0, NULL, NULL, 'SKU created with opening stock', '2026-09-21 04:51:19'),
(517, 46, 'Opening Stock', 0, 0, 0, NULL, NULL, 'SKU created with opening stock', '2026-09-21 04:53:23'),
(536, 38, 'Purchase Entry', 48, 2, 50, 17, 'purchase', 'Purchase Entry. Supplier Invoice: 22887.  (Recorded by User: Shreyansh Janagouda)', '2026-09-21 05:31:26'),
(537, 37, 'Purchase Entry', 48, 8, 56, 17, 'purchase', 'Purchase Entry. Supplier Invoice: 22887.  (Recorded by User: Shreyansh Janagouda)', '2026-09-21 05:31:26'),
(538, 39, 'Purchase Entry', 48, 2, 50, 17, 'purchase', 'Purchase Entry. Supplier Invoice: 22887.  (Recorded by User: Shreyansh Janagouda)', '2026-09-21 05:31:26'),
(539, 21, 'Purchase Entry', 120, 165, 285, 17, 'purchase', 'Purchase Entry. Supplier Invoice: 22887.  (Recorded by User: Shreyansh Janagouda)', '2026-09-21 05:31:26'),
(540, 22, 'Purchase Entry', 96, 174, 270, 17, 'purchase', 'Purchase Entry. Supplier Invoice: 22887.  (Recorded by User: Shreyansh Janagouda)', '2026-09-21 05:31:26'),
(541, 26, 'Purchase Entry', 120, 213, 333, 17, 'purchase', 'Purchase Entry. Supplier Invoice: 22887.  (Recorded by User: Shreyansh Janagouda)', '2026-09-21 05:31:26'),
(542, 44, 'Purchase Entry', 96, 0, 96, 17, 'purchase', 'Purchase Entry. Supplier Invoice: 22887.  (Recorded by User: Shreyansh Janagouda)', '2026-09-21 05:31:26'),
(543, 45, 'Purchase Entry', 96, 0, 96, 17, 'purchase', 'Purchase Entry. Supplier Invoice: 22887.  (Recorded by User: Shreyansh Janagouda)', '2026-09-21 05:31:26'),
(544, 46, 'Purchase Entry', 96, 0, 96, 17, 'purchase', 'Purchase Entry. Supplier Invoice: 22887.  (Recorded by User: Shreyansh Janagouda)', '2026-09-21 05:31:26'),
(545, 37, 'Invoice Reduction', 12, 44, 32, 107, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0082', '2026-09-21 05:47:19'),
(546, 38, 'Invoice Reduction', 12, 38, 26, 107, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0082', '2026-09-21 05:47:19'),
(547, 12, 'Invoice Reduction', 3, 74, 71, 108, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0083', '2026-09-22 11:24:01'),
(548, 13, 'Invoice Reduction', 3, 85, 82, 108, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0083', '2026-09-22 11:24:01'),
(549, 17, 'Invoice Reduction', 20, 436, 416, 108, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0083', '2026-09-22 11:24:01'),
(550, 14, 'Invoice Reduction', 6, 113, 107, 109, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0084', '2026-09-22 11:25:08'),
(551, 13, 'Invoice Reduction', 3, 82, 79, 109, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0084', '2026-09-22 11:25:08'),
(552, 17, 'Invoice Reduction', 10, 416, 406, 110, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0085', '2026-09-22 11:26:13'),
(553, 16, 'Invoice Reduction', 20, 190, 170, 111, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0086', '2026-09-22 11:27:19'),
(554, 17, 'Invoice Reduction', 50, 406, 356, 111, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0086', '2026-09-22 11:27:19'),
(555, 17, 'Invoice Reduction', 10, 356, 346, 112, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0087', '2026-09-22 11:28:09'),
(556, 34, 'Invoice Reduction', 40, 222, 182, 113, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0088', '2026-09-22 11:28:46'),
(557, 17, 'Invoice Reduction', 10, 346, 336, 113, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0088', '2026-09-22 11:28:46'),
(558, 29, 'Invoice Reduction', 12, 696, 684, 113, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0088', '2026-09-22 11:28:46'),
(559, 14, 'Invoice Reduction', 6, 107, 101, 114, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0089', '2026-09-22 11:29:26'),
(560, 13, 'Invoice Reduction', 6, 79, 73, 114, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0089', '2026-09-22 11:29:26'),
(561, 12, 'Invoice Reduction', 6, 71, 65, 114, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0089', '2026-09-22 11:29:26'),
(562, 34, 'Invoice Reduction', 20, 182, 162, 114, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0089', '2026-09-22 11:29:26'),
(563, 16, 'Invoice Reduction', 10, 170, 160, 114, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0089', '2026-09-22 11:29:26'),
(564, 17, 'Invoice Reduction', 10, 336, 326, 114, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0089', '2026-09-22 11:29:26'),
(565, 12, 'Invoice Reduction', 3, 62, 59, 115, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0090', '2026-09-22 11:47:45'),
(566, 14, 'Invoice Reduction', 6, 95, 89, 115, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0090', '2026-09-22 11:47:45'),
(567, 17, 'Invoice Reduction', 20, 306, 286, 115, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0090', '2026-09-22 11:47:45'),
(568, 30, 'Invoice Reduction', 12, 372, 360, 116, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0091', '2026-09-29 04:28:02'),
(569, 39, 'Invoice Reduction', 2, 48, 46, 117, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0092', '2026-09-29 04:28:30'),
(570, 38, 'Invoice Reduction', 2, 24, 22, 117, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0092', '2026-09-29 04:28:30'),
(571, 37, 'Invoice Reduction', 2, 30, 28, 117, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0092', '2026-09-29 04:28:30'),
(572, 29, 'Invoice Reduction', 36, 624, 588, 117, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0092', '2026-09-29 04:28:30'),
(573, 29, 'Invoice Reduction', 24, 588, 564, 118, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0093', '2026-09-29 04:28:49'),
(574, 31, 'Invoice Reduction', 12, 180, 168, 118, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0093', '2026-09-29 04:28:49'),
(575, 34, 'Invoice Reduction', 40, 82, 42, 119, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0094', '2026-10-02 11:03:48'),
(576, 17, 'Invoice Reduction', 50, 216, 166, 120, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0095', '2026-10-02 11:05:14'),
(577, 34, 'Invoice Reduction', 40, 42, 2, 121, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0096', '2026-10-02 11:06:29'),
(578, 17, 'Invoice Reduction', 20, 166, 146, 121, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0096', '2026-10-02 11:06:29'),
(579, 14, 'Invoice Reduction', 10, 79, 69, 122, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0097', '2026-10-02 11:07:50'),
(580, 39, 'Invoice Reduction', 4, 42, 38, 123, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0098', '2026-10-02 11:08:19'),
(581, 38, 'Invoice Reduction', 4, 18, 14, 123, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0098', '2026-10-02 11:08:19'),
(582, 37, 'Invoice Reduction', 4, 24, 20, 123, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0098', '2026-10-02 11:08:19'),
(583, 18, 'Invoice Reduction', 6, 195, 189, 124, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0099', '2026-10-02 11:08:39'),
(584, 22, 'Invoice Reduction', 6, 264, 258, 124, 'Invoices', 'Invoiced via Invoice No: NE/2026-27/0099', '2026-10-02 11:08:39'),
(585, 18, 'Invoice Reduction', 2, 189, 187, 125, 'Invoices', 'Counter Sale Bill #CS-20261004-0001 (Walk-in Test Customer)', '2026-10-04 12:00:45'),
(586, 13, 'Invoice Reduction', 2, 73, 71, 126, 'Invoices', 'Counter Sale Bill #CS-20261004-0002 (Walk-in Customer)', '2026-10-04 12:03:33');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `retailer_id` int(11) NOT NULL,
  `invoice_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_type` enum('GST Invoice','Non GST Invoice','Cash Invoice','Credit Invoice') COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_date` date NOT NULL,
  `company_details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `retailer_details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `gst_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `grand_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `paid_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `outstanding_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `payment_status` enum('Unpaid','Partially Paid','Paid') COLLATE utf8mb4_unicode_ci DEFAULT 'Unpaid',
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `order_id`, `retailer_id`, `invoice_number`, `invoice_type`, `invoice_date`, `company_details`, `retailer_details`, `subtotal`, `discount_amount`, `gst_amount`, `grand_total`, `paid_amount`, `outstanding_amount`, `payment_status`, `remarks`, `created_at`) VALUES
(4, 11, 15, 'NE/2026-27/0003', 'GST Invoice', '2026-07-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"MAHAKALI GENRAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '180.00', '0.00', '9.00', '189.00', '189.00', '0.00', 'Paid', '', '2026-07-15 12:19:43'),
(5, 12, 16, 'NE/2026-27/0004', 'GST Invoice', '2026-07-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SIDDHAROODHA KIRANA STORE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '180.00', '0.00', '9.00', '189.00', '189.00', '0.00', 'Paid', '', '2026-07-15 12:25:13'),
(6, 13, 17, 'NE/2026-27/0005', 'GST Invoice', '2026-07-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"MAHALAXMI GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1140.00', '0.00', '57.00', '1197.00', '1197.00', '0.00', 'Paid', '', '2026-07-15 12:26:20'),
(7, 14, 18, 'NE/2026-27/0006', 'GST Invoice', '2026-07-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"VEERA BHADRESHWAR ENTERPRISE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '200.04', '0.00', '10.00', '210.04', '210.04', '0.00', 'Paid', '', '2026-07-15 12:26:53'),
(8, 4, 8, 'NE/2026-27/0007', 'GST Invoice', '2026-07-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI NEELAMBARI KIRANA AND GENERAL STORE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '690.00', '0.00', '34.50', '724.50', '724.50', '0.00', 'Paid', '', '2026-07-15 12:27:14'),
(9, 5, 9, 'NE/2026-27/0008', 'GST Invoice', '2026-07-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"GURUPRASAD KIRANA STORE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '330.00', '0.00', '16.50', '346.50', '346.50', '0.00', 'Paid', '', '2026-07-15 12:27:31'),
(10, 6, 10, 'NE/2026-27/0009', 'GST Invoice', '2026-07-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"PATIL GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '480.00', '0.00', '24.00', '504.00', '504.00', '0.00', 'Paid', '', '2026-07-15 12:28:17'),
(11, 7, 11, 'NE/2026-27/0010', 'GST Invoice', '2026-07-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"ANJANEYA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '180.00', '0.00', '9.00', '189.00', '185.00', '4.00', 'Partially Paid', '', '2026-07-15 12:28:42'),
(12, 8, 12, 'NE/2026-27/0011', 'GST Invoice', '2026-07-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"DURGA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '420.00', '0.00', '21.00', '441.00', '441.00', '0.00', 'Paid', '', '2026-07-15 12:28:58'),
(13, 9, 13, 'NE/2026-27/0012', 'GST Invoice', '2026-07-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"HARSH ENTERPRISE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1140.00', '0.00', '57.00', '1197.00', '717.00', '480.00', 'Partially Paid', '', '2026-07-15 12:29:51'),
(14, 15, 19, 'NE/2026-27/0013', 'GST Invoice', '2026-07-16', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI  GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '480.00', '0.00', '24.00', '504.00', '504.00', '0.00', 'Paid', '', '2026-07-16 11:16:11'),
(15, 16, 20, 'NE/2026-27/0014', 'GST Invoice', '2026-07-16', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SIDDHI GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1440.00', '0.00', '72.00', '1512.00', '1512.00', '0.00', 'Paid', '', '2026-07-16 11:19:30'),
(16, 17, 21, 'NE/2026-27/0015', 'GST Invoice', '2026-07-16', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"KIRAN PATIL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '960.00', '0.00', '48.00', '1008.00', '1008.00', '0.00', 'Paid', '', '2026-07-16 11:19:43'),
(17, 18, 22, 'NE/2026-27/0016', 'GST Invoice', '2026-07-16', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"BELAGAONKAR  GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '660.00', '0.00', '33.00', '693.00', '693.00', '0.00', 'Paid', '', '2026-07-16 11:20:05'),
(18, 19, 23, 'NE/2026-27/0017', 'GST Invoice', '2026-07-16', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"ANAND MASALA STORE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '960.00', '0.00', '48.00', '1008.00', '1008.00', '0.00', 'Paid', '', '2026-07-16 11:20:16'),
(19, 20, 24, 'NE/2026-27/0018', 'GST Invoice', '2026-07-16', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"P R PALAKAR\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '240.00', '0.00', '12.00', '252.00', '252.00', '0.00', 'Paid', '', '2026-07-16 11:20:32'),
(22, 23, 27, 'NE/2026-27/0021', 'GST Invoice', '2026-07-16', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"PANKAJ COCONUT STORE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '960.00', '0.00', '48.00', '1008.00', '500.00', '508.00', 'Partially Paid', '', '2026-07-16 11:21:37'),
(23, 24, 28, 'NE/2026-27/0022', 'GST Invoice', '2026-07-16', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"M. ANGOLKAR AND  SONS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '960.00', '0.00', '48.00', '1008.00', '1008.00', '0.00', 'Paid', '', '2026-07-16 11:23:06'),
(24, 25, 29, 'NE/2026-27/0023', 'GST Invoice', '2026-07-16', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"RAVALNATH TRADERS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '960.00', '0.00', '48.00', '1008.00', '1008.00', '0.00', 'Paid', '', '2026-07-16 11:26:12'),
(25, 26, 31, 'NE/2026-27/0024', 'GST Invoice', '2026-07-16', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"ARVIND ENTERPRISE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '650.04', '0.00', '32.50', '682.54', '682.54', '0.00', 'Paid', '', '2026-07-16 11:26:27'),
(50, 27, 35, 'NE/2026-27/0025', 'GST Invoice', '2026-07-25', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"ANNAPURNESHWARI SUPER MARKET\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '141.30', '0.13', '0.00', '141.17', '141.17', '0.00', 'Paid', '', '2026-07-25 10:22:40'),
(51, 28, 36, 'NE/2026-27/0026', 'GST Invoice', '2026-07-25', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SUPRIYA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '141.30', '0.13', '0.00', '141.17', '141.17', '0.00', 'Paid', '', '2026-07-25 11:11:54'),
(52, 29, 37, 'NE/2026-27/0027', 'GST Invoice', '2026-07-25', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI MAHADEV GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '993.78', '4.68', '49.46', '1038.56', '1038.56', '0.00', 'Paid', '', '2026-07-25 11:26:27'),
(53, 30, 38, 'NE/2026-27/0028', 'GST Invoice', '2026-07-25', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"MANGAI GENRAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '299.19', '0.00', '14.96', '314.15', '314.15', '0.00', 'Paid', '', '2026-07-25 11:32:15'),
(54, 31, 15, 'NE/2026-27/0029', 'GST Invoice', '2026-07-29', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"MAHAKALI GENRAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '171.12', '0.00', '8.56', '179.68', '179.68', '0.00', 'Paid', '', '2026-07-29 11:56:41'),
(55, 36, 40, 'NE/2026-27/0030', 'GST Invoice', '2026-08-02', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"BASAVESHWAR TRADERS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '3391.20', '391.20', '0.00', '3000.00', '3000.00', '0.00', 'Paid', '', '2026-08-02 14:39:41'),
(56, 37, 39, 'NE/2026-27/0031', 'GST Invoice', '2026-08-03', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SAI PAN SHOP\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '913.92', '0.00', '45.70', '959.62', '500.00', '459.62', 'Partially Paid', '', '2026-08-03 05:45:18'),
(57, 38, 41, 'NE/2026-27/0032', 'GST Invoice', '2026-08-03', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI REVENSIDDESHWAR TRADERS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1085.04', '0.00', '54.25', '1139.29', '1139.00', '0.29', 'Partially Paid', '', '2026-08-03 05:56:28'),
(58, 39, 42, 'NE/2026-27/0033', 'GST Invoice', '2026-08-03', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"G V PATIL\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '228.48', '0.00', '11.42', '239.90', '239.90', '0.00', 'Paid', '', '2026-08-03 05:57:05'),
(59, 40, 43, 'NE/2026-27/0034', 'GST Invoice', '2026-08-03', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRIDHAR GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '171.12', '0.00', '8.56', '179.68', '179.68', '0.00', 'Paid', '', '2026-08-03 05:57:48'),
(60, 41, 44, 'NE/2026-27/0035', 'GST Invoice', '2026-08-03', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"IRSHAD GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '171.12', '0.00', '8.56', '179.68', '179.68', '0.00', 'Paid', '', '2026-08-03 05:58:22'),
(61, 42, 45, 'NE/2026-27/0036', 'GST Invoice', '2026-08-03', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SAMIVOOLA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '913.92', '0.00', '45.70', '959.62', '959.62', '0.00', 'Paid', '', '2026-08-03 05:59:04'),
(62, 43, 46, 'NE/2026-27/0037', 'GST Invoice', '2026-08-03', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SAJIYA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1085.04', '0.00', '54.25', '1139.29', '1139.29', '0.00', 'Paid', '', '2026-08-03 05:59:30'),
(63, 44, 47, 'NE/2026-27/0038', 'GST Invoice', '2026-08-04', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"CHOPADE STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '622.16', '22.60', '16.98', '616.54', '616.54', '0.00', 'Paid', '', '2026-08-04 11:30:51'),
(64, 45, 48, 'NE/2026-27/0039', 'GST Invoice', '2026-08-04', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"Shridhar General store\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '141.30', '11.30', '0.00', '130.00', '130.00', '0.00', 'Paid', '', '2026-08-04 11:32:30'),
(65, 46, 49, 'NE/2026-27/0040', 'GST Invoice', '2026-08-04', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SUNIL GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '472.56', '22.60', '9.50', '459.46', '459.00', '0.46', 'Partially Paid', '', '2026-08-04 11:33:22'),
(66, 47, 50, 'NE/2026-27/0041', 'GST Invoice', '2026-08-04', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"KRISHNA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '677.12', '13.56', '25.38', '688.94', '688.94', '0.00', 'Paid', '', '2026-08-04 11:34:32'),
(67, 48, 51, 'NE/2026-27/0042', 'GST Invoice', '2026-08-04', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI JYOTIRLING GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '831.28', '20.66', '34.03', '844.65', '844.65', '0.00', 'Paid', '', '2026-08-04 11:36:52'),
(68, 49, 8, 'NE/2026-27/0043', 'GST Invoice', '2026-08-05', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI NEELAMBARI KIRANA AND GENERAL STORE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '523.80', '0.00', '26.19', '549.99', '549.99', '0.00', 'Paid', '', '2026-08-05 12:05:14'),
(69, 50, 17, 'NE/2026-27/0044', 'GST Invoice', '2026-08-05', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"MAHALAXMI GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '913.92', '0.00', '45.70', '959.62', '959.62', '0.00', 'Paid', '', '2026-08-05 12:06:18'),
(70, 51, 24, 'NE/2026-27/0045', 'GST Invoice', '2026-08-06', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"P R PALAKAR\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '523.80', '0.00', '26.19', '549.99', '549.99', '0.00', 'Paid', '', '2026-08-06 09:16:42'),
(71, 52, 25, 'NE/2026-27/0046', 'GST Invoice', '2026-08-06', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"PATTANSHETTY GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '3517.26', '0.00', '175.86', '3693.12', '3693.00', '0.12', 'Partially Paid', '', '2026-08-06 09:18:32'),
(72, 53, 26, 'NE/2026-27/0047', 'GST Invoice', '2026-08-06', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"D A ATTARA\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '913.92', '0.00', '45.70', '959.62', '959.62', '0.00', 'Paid', '', '2026-08-06 09:19:45'),
(73, 54, 19, 'NE/2026-27/0048', 'GST Invoice', '2026-08-06', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI  GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '456.96', '0.00', '22.85', '479.81', '479.81', '0.00', 'Paid', '', '2026-08-06 09:20:50'),
(74, 55, 20, 'NE/2026-27/0049', 'GST Invoice', '2026-08-06', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SIDDHI GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1213.50', '0.00', '60.68', '1274.18', '0.00', '1274.18', 'Unpaid', '', '2026-08-06 09:21:30'),
(75, 56, 52, 'NE/2026-27/0050', 'GST Invoice', '2026-08-06', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"P L KAWALE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '5227.08', '0.00', '261.35', '5488.43', '4200.00', '1288.43', 'Partially Paid', '', '2026-08-06 09:22:20'),
(76, 57, 54, 'NE/2026-27/0051', 'GST Invoice', '2026-08-06', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"PRAVEEN PAWAR COCONUT\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '456.96', '0.00', '22.85', '479.81', '479.81', '0.00', 'Paid', '', '2026-08-06 09:26:15'),
(77, 58, 53, 'NE/2026-27/0052', 'GST Invoice', '2026-08-06', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"V B SIDDANNAVAR\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '5062.44', '45.00', '250.87', '5268.31', '5268.00', '0.31', 'Partially Paid', '', '2026-08-06 09:27:14'),
(78, 59, 55, 'NE/2026-27/0053', 'GST Invoice', '2026-08-06', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"R M ANGOLKAR\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '2808.60', '84.60', '136.20', '2860.20', '2000.00', '860.20', 'Partially Paid', '', '2026-08-06 09:28:17'),
(79, 60, 56, 'NE/2026-27/0054', 'GST Invoice', '2026-08-11', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SIDDHI VINAYAKA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '2762.16', '137.97', '98.71', '2722.90', '2722.90', '0.00', 'Paid', '', '2026-08-11 04:32:27'),
(80, 61, 33, 'NE/2026-27/0055', 'GST Invoice', '2026-08-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"CHANDRAKANTH V SAJJAN GENRAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1170.60', '0.00', '58.53', '1229.13', '1229.00', '0.13', 'Partially Paid', '', '2026-08-15 04:44:56'),
(81, 62, 34, 'NE/2026-27/0056', 'GST Invoice', '2026-08-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"MAHALAXMI GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1140.00', '68.40', '53.58', '1125.18', '1125.18', '0.00', 'Paid', '', '2026-08-15 04:45:56'),
(82, 63, 59, 'NE/2026-27/0057', 'GST Invoice', '2026-08-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"JAIRAJ RETAILS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1135.08', '39.38', '48.29', '1143.99', '1143.99', '0.00', 'Paid', '', '2026-08-15 04:46:19'),
(83, 64, 57, 'NE/2026-27/0058', 'GST Invoice', '2026-08-15', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"BHARATI GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '189.96', '0.00', '9.50', '199.46', '199.46', '0.00', 'Paid', '', '2026-08-15 04:46:39'),
(84, 65, 16, 'NE/2026-27/0059', 'GST Invoice', '2026-08-19', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SIDDHAROODHA KIRANA STORE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1169.22', '11.30', '51.40', '1209.32', '1209.00', '0.32', 'Partially Paid', '', '2026-08-19 10:55:04'),
(85, 66, 18, 'NE/2026-27/0060', 'GST Invoice', '2026-08-19', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"VEERA BHADRESHWAR ENTERPRISE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '312.42', '11.30', '8.56', '309.68', '309.68', '0.00', 'Paid', '', '2026-08-19 10:55:53'),
(86, 70, 33, 'NE/2026-27/0061', 'GST Invoice', '2026-08-27', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"CHANDRAKANTH V SAJJAN GENRAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '282.60', '22.60', '0.00', '260.00', '260.00', '0.00', 'Paid', '', '2026-08-27 06:31:42'),
(87, 74, 40, 'NE/2026-27/0062', 'GST Invoice', '2026-08-27', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"BASAVESHWAR TRADERS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '2189.60', '138.00', '102.58', '2154.18', '2154.00', '0.18', 'Partially Paid', '', '2026-08-27 06:46:54'),
(88, 73, 60, 'NE/2026-27/0063', 'GST Invoice', '2026-08-27', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"CHANDRAKANTH GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '2519.34', '84.58', '89.24', '2524.00', '2524.00', '0.00', 'Paid', '', '2026-08-27 06:53:02'),
(89, 75, 12, 'NE/2026-27/0064', 'GST Invoice', '2026-09-02', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"DURGA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '171.12', '0.00', '8.56', '179.68', '179.68', '0.00', 'Paid', '', '2026-09-02 10:35:40'),
(90, 76, 15, 'NE/2026-27/0065', 'GST Invoice', '2026-09-02', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"MAHAKALI GENRAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '627.12', '0.00', '31.36', '658.48', '658.00', '0.48', 'Partially Paid', '', '2026-09-02 10:37:48'),
(91, 77, 16, 'NE/2026-27/0066', 'GST Invoice', '2026-09-02', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SIDDHAROODHA KIRANA STORE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '375.90', '0.00', '18.80', '394.70', '394.70', '0.00', 'Paid', '', '2026-09-02 10:38:10'),
(92, 80, 59, 'NE/2026-27/0067', 'GST Invoice', '2026-09-05', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"JAIRAJ RETAILS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '282.60', '22.60', '0.00', '260.00', '260.00', '0.00', 'Paid', '', '2026-09-05 05:29:37'),
(93, 81, 37, 'NE/2026-27/0068', 'GST Invoice', '2026-09-05', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI MAHADEV GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1179.40', '22.60', '44.84', '1201.64', '1201.64', '0.00', 'Paid', '', '2026-09-05 05:30:50'),
(94, 82, 26, 'NE/2026-27/0069', 'GST Invoice', '2026-09-07', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"D A ATTARA\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '2741.76', '0.00', '137.09', '2878.85', '1100.00', '1778.85', 'Partially Paid', '', '2026-09-07 04:40:25'),
(95, 83, 25, 'NE/2026-27/0070', 'GST Invoice', '2026-09-07', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"PATTANSHETTY GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '2284.80', '0.00', '114.24', '2399.04', '0.00', '2399.04', 'Unpaid', '', '2026-09-07 04:44:21'),
(96, 84, 41, 'NE/2026-27/0071', 'GST Invoice', '2026-09-08', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI REVENSIDDESHWAR TRADERS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '913.92', '0.00', '45.70', '959.62', '959.62', '0.00', 'Paid', '', '2026-09-08 08:28:45'),
(97, 85, 45, 'NE/2026-27/0072', 'GST Invoice', '2026-09-08', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SAMIVOOLA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '2998.44', '0.00', '149.92', '3148.36', '1100.00', '2048.36', 'Partially Paid', '', '2026-09-08 08:29:40'),
(98, 86, 56, 'NE/2026-27/0073', 'GST Invoice', '2026-09-12', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SIDDHI VINAYAKA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1413.00', '113.00', '0.00', '1300.00', '1299.90', '0.10', 'Partially Paid', '', '2026-09-12 05:56:55'),
(99, 87, 40, 'NE/2026-27/0074', 'GST Invoice', '2026-09-12', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"BASAVESHWAR TRADERS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '3391.20', '391.20', '0.00', '3000.00', '0.00', '3000.00', 'Unpaid', '', '2026-09-12 06:18:54'),
(100, 89, 59, 'NE/2026-27/0075', 'GST Invoice', '2026-09-18', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"JAIRAJ RETAILS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '317.60', '0.00', '15.88', '333.48', '333.00', '0.48', 'Partially Paid', '', '2026-09-18 10:26:19'),
(101, 88, 34, 'NE/2026-27/0076', 'GST Invoice', '2026-09-18', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"MAHALAXMI GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '282.60', '22.60', '0.00', '260.00', '260.00', '0.00', 'Paid', '', '2026-09-18 10:27:02'),
(102, 90, 60, 'NE/2026-27/0077', 'GST Invoice', '2026-09-18', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"CHANDRAKANTH GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1647.70', '22.60', '68.26', '1693.36', '0.00', '1693.36', 'Unpaid', '', '2026-09-18 10:28:17'),
(103, 91, 33, 'NE/2026-27/0078', 'GST Invoice', '2026-09-18', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"CHANDRAKANTH V SAJJAN GENRAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '513.36', '0.00', '25.67', '539.03', '0.00', '539.03', 'Unpaid', '', '2026-09-18 10:29:01'),
(104, 92, 16, 'NE/2026-27/0079', 'GST Invoice', '2026-09-18', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SIDDHAROODHA KIRANA STORE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '85.56', '0.00', '4.28', '89.84', '89.84', '0.00', 'Paid', '', '2026-09-18 10:29:43'),
(105, 93, 8, 'NE/2026-27/0080', 'GST Invoice', '2026-09-18', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI NEELAMBARI KIRANA AND GENERAL STORE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '523.80', '0.00', '26.19', '549.99', '0.00', '549.99', 'Unpaid', '', '2026-09-18 10:30:23'),
(106, 94, 18, 'NE/2026-27/0081', 'GST Invoice', '2026-09-18', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"VEERA BHADRESHWAR ENTERPRISE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '85.56', '0.00', '4.28', '89.84', '89.84', '0.00', 'Paid', '', '2026-09-18 10:31:09'),
(107, 95, 53, 'NE/2026-27/0082', 'GST Invoice', '2026-09-21', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"V B SIDDANNAVAR\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1047.60', '0.00', '52.38', '1099.98', '0.00', '1099.98', 'Unpaid', '', '2026-09-21 05:47:19'),
(108, 96, 51, 'NE/2026-27/0083', 'GST Invoice', '2026-09-22', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI JYOTIRLING GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1048.53', '36.64', '37.59', '1049.48', '1049.48', '0.00', 'Paid', '', '2026-09-22 11:24:01'),
(109, 97, 49, 'NE/2026-27/0084', 'GST Invoice', '2026-09-22', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SUNIL GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '550.02', '0.00', '27.50', '577.52', '577.52', '0.00', 'Paid', '', '2026-09-22 11:25:08'),
(110, 98, 50, 'NE/2026-27/0085', 'GST Invoice', '2026-09-22', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"KRISHNA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '141.30', '11.30', '0.00', '130.00', '129.94', '0.06', 'Partially Paid', '', '2026-09-22 11:26:13'),
(111, 99, 63, 'NE/2026-27/0086', 'GST Invoice', '2026-09-22', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"C G Kadolkar kirana store\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1023.90', '56.50', '15.87', '983.27', '500.00', '483.27', 'Partially Paid', '', '2026-09-22 11:27:19'),
(112, 100, 61, 'NE/2026-27/0087', 'GST Invoice', '2026-09-22', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"Akunti General store\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '141.30', '1.30', '0.00', '140.00', '140.00', '0.00', 'Paid', '', '2026-09-22 11:28:09'),
(113, 101, 64, 'NE/2026-27/0088', 'GST Invoice', '2026-09-22', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"MOURYA GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '544.46', '1.30', '20.16', '563.32', '0.00', '563.32', 'Unpaid', '', '2026-09-22 11:28:46'),
(114, 102, 62, 'NE/2026-27/0089', 'GST Invoice', '2026-09-22', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"VENKATESHWAR CO OPERATIVE POWER LTD\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '2280.34', '28.08', '105.11', '2357.37', '0.00', '2357.37', 'Unpaid', '', '2026-09-22 11:29:26'),
(115, 103, 51, 'NE/2026-27/0090', 'GST Invoice', '2026-09-22', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SHRI JYOTIRLING GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '1060.47', '14.04', '38.19', '1084.62', '0.00', '1084.62', 'Unpaid', '', '2026-09-22 11:47:45'),
(116, 104, 18, 'NE/2026-27/0091', 'GST Invoice', '2026-09-29', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"VEERA BHADRESHWAR ENTERPRISE\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '228.00', '0.00', '11.40', '239.40', '239.00', '0.40', 'Partially Paid', '', '2026-09-29 04:28:02'),
(117, 105, 66, 'NE/2026-27/0092', 'GST Invoice', '2026-09-29', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"M G PAN SHOP\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '518.58', '11.88', '25.34', '532.04', '0.00', '532.04', 'Unpaid', '', '2026-09-29 04:28:30'),
(118, 106, 67, 'NE/2026-27/0093', 'GST Invoice', '2026-09-29', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"KHUSRO GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '361.08', '0.00', '18.05', '379.13', '0.00', '379.13', 'Unpaid', '', '2026-09-29 04:28:49'),
(119, 107, 49, 'NE/2026-27/0094', 'GST Invoice', '2026-10-02', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"SUNIL GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '317.60', '0.00', '15.88', '333.48', '0.00', '333.48', 'Unpaid', '', '2026-10-02 11:03:48'),
(120, 108, 60, 'NE/2026-27/0095', 'GST Invoice', '2026-10-02', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"CHANDRAKANTH GENERAL STORES\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '706.50', '56.50', '0.00', '650.00', '650.00', '0.00', 'Paid', '', '2026-10-02 11:05:14'),
(121, 109, 70, 'NE/2026-27/0096', 'GST Invoice', '2026-10-02', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"Maruti General Store\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '600.20', '22.60', '15.88', '593.48', '593.00', '0.48', 'Partially Paid', '', '2026-10-02 11:06:29'),
(122, 110, 59, 'NE/2026-27/0097', 'GST Invoice', '2026-10-02', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"JAIRAJ RETAILS\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '468.30', '0.00', '23.42', '491.72', '0.00', '491.72', 'Unpaid', '', '2026-10-02 11:07:50'),
(123, 111, 69, 'NE/2026-27/0098', 'GST Invoice', '2026-10-02', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"Shiv Parvati General Store\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '523.80', '0.00', '26.19', '549.99', '0.00', '549.99', 'Unpaid', '', '2026-10-02 11:08:19'),
(124, 112, 68, 'NE/2026-27/0099', 'GST Invoice', '2026-10-02', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"shri veerabhadreshwar General Store\",\"mobile\":\"\",\"address\":\"\",\"gst_number\":\"\"}', '456.96', '0.00', '22.85', '479.81', '479.81', '0.00', 'Paid', '', '2026-10-02 11:08:39'),
(125, NULL, 71, 'CS-20261004-0001', 'Cash Invoice', '2026-10-04', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"Counter: Walk-in Test Customer\",\"name\":\"Walk-in Test Customer\",\"mobile\":\"9876543210\",\"address\":\"Store Counter Walk-in Sale\",\"area\":\"Counter\",\"city\":\"Goa\",\"pin_code\":\"403001\",\"gst_number\":\"\"}', '80.00', '5.00', '3.75', '78.75', '78.75', '0.00', 'Paid', 'Counter Sale (Public Retail) | Mode: Cash | Notes: Test single unit counter sale', '2026-10-04 12:00:45'),
(126, NULL, 71, 'CS-20261004-0002', 'Cash Invoice', '2026-10-04', '{\"name\":\"Navatara Enterprises\",\"address\":\"Alarwad , Belagavi - 590020\",\"mobile\":\"6361742356\",\"email\":\"navataraenterprise@gmail.com\",\"gst\":\"29APPPJ6887A1ZD\",\"pan\":\"AAAAA1111A\"}', '{\"shop_name\":\"Counter: Walk-in Customer\",\"name\":\"Walk-in Customer\",\"mobile\":\"\",\"address\":\"Store Counter Walk-in Sale\",\"area\":\"Counter\",\"city\":\"Goa\",\"pin_code\":\"403001\",\"gst_number\":\"\"}', '179.36', '0.00', '8.97', '188.33', '188.33', '0.00', 'Paid', 'Counter Sale (Public Retail) | Mode: Cash', '2026-10-04 12:03:33');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `sku_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `gst_percentage` decimal(5,2) NOT NULL,
  `gst_amount` decimal(10,2) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `invoice_id`, `sku_id`, `sku_name`, `sku_code`, `quantity`, `purchase_price`, `selling_price`, `discount_amount`, `gst_percentage`, `gst_amount`, `total_amount`) VALUES
(8, 4, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '7.00', '7.50', '0.00', '5.00', '9.00', '189.00'),
(9, 5, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '7.00', '7.50', '0.00', '5.00', '9.00', '189.00'),
(10, 6, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '7.00', '7.50', '0.00', '5.00', '9.00', '189.00'),
(11, 6, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(12, 6, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(13, 6, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(14, 6, 23, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(15, 7, 31, 'VINAYAKA BLACK FANTASY 60G', 'ECONOMY 1', 6, '14.87', '16.67', '0.00', '5.00', '5.00', '105.02'),
(16, 7, 32, 'VINAYAKA WILD PURPLE 60G', 'ECONOMY 2', 6, '14.87', '16.67', '0.00', '5.00', '5.00', '105.02'),
(17, 8, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 60, '7.00', '7.50', '0.00', '5.00', '22.50', '472.50'),
(18, 8, 30, 'VINAYAKA GOOD MORNING ECONOMY', 'ZIPPER 9', 12, '16.62', '20.00', '0.00', '5.00', '12.00', '252.00'),
(19, 9, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(20, 9, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 12, '7.00', '7.50', '0.00', '5.00', '4.50', '94.50'),
(21, 10, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(22, 10, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(23, 11, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '7.00', '7.50', '0.00', '5.00', '9.00', '189.00'),
(24, 12, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '7.00', '7.50', '0.00', '5.00', '9.00', '189.00'),
(25, 12, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 3, '36.75', '40.00', '0.00', '5.00', '6.00', '126.00'),
(26, 12, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 3, '36.75', '40.00', '0.00', '5.00', '6.00', '126.00'),
(27, 13, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '7.00', '7.50', '0.00', '5.00', '9.00', '189.00'),
(28, 13, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(29, 13, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(30, 13, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(31, 13, 23, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(32, 14, 28, 'VINAYAKA BOLENATH ZIPPER PACKS', 'ZIPPER 7', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(33, 14, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(34, 15, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(35, 15, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(36, 15, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(37, 15, 28, 'VINAYAKA BOLENATH ZIPPER PACKS', 'ZIPPER 7', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(38, 15, 23, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', 3, '36.75', '40.00', '0.00', '5.00', '6.00', '126.00'),
(39, 15, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 3, '36.75', '40.00', '0.00', '5.00', '6.00', '126.00'),
(40, 15, 33, 'VINAYAKA BRUTS ZIPPER PACKS', 'ZIPPER -11', 3, '36.75', '40.00', '0.00', '5.00', '6.00', '126.00'),
(41, 15, 26, 'VINAYAKA DREAMS ZIPPER PACKS', 'ZIPPER 6', 3, '36.75', '40.00', '0.00', '5.00', '6.00', '126.00'),
(42, 16, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 12, '36.75', '40.00', '0.00', '5.00', '24.00', '504.00'),
(43, 16, 23, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', 12, '36.75', '40.00', '0.00', '5.00', '24.00', '504.00'),
(44, 17, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '7.00', '7.50', '0.00', '5.00', '9.00', '189.00'),
(45, 17, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 12, '36.75', '40.00', '0.00', '5.00', '24.00', '504.00'),
(46, 18, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 12, '36.75', '40.00', '0.00', '5.00', '24.00', '504.00'),
(47, 18, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(48, 18, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(49, 19, 30, 'VINAYAKA GOOD MORNING ECONOMY', 'ZIPPER 9', 12, '16.62', '20.00', '0.00', '5.00', '12.00', '252.00'),
(53, 22, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(54, 22, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(55, 22, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(56, 22, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(57, 23, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 24, '36.75', '40.00', '0.00', '5.00', '48.00', '1008.00'),
(58, 24, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 12, '36.75', '40.00', '0.00', '5.00', '24.00', '504.00'),
(59, 24, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(60, 24, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 6, '36.75', '40.00', '0.00', '5.00', '12.00', '252.00'),
(61, 25, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 60, '7.00', '7.50', '0.00', '5.00', '22.50', '472.50'),
(62, 25, 31, 'VINAYAKA BLACK FANTASY 60G', 'ECONOMY 1', 6, '14.87', '16.67', '0.00', '5.00', '5.00', '105.02'),
(63, 25, 32, 'VINAYAKA WILD PURPLE 60G', 'ECONOMY 2', 6, '14.87', '16.67', '0.00', '5.00', '5.00', '105.02'),
(64, 50, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '14.13', '0.13', '0.00', '0.00', '141.17'),
(65, 51, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '14.13', '0.13', '0.00', '0.00', '141.17'),
(66, 52, 12, 'SHRI KRISHNA 200 ML JAR COW GHEE', 'COW GHEE 200ML JAR', 6, '164.07', '165.63', '4.68', '5.00', '49.46', '1038.56'),
(67, 53, 14, 'SHRI KRISHNA 50ML JAR COW GHEE', 'COW GHEE 50ML JAR', 3, '46.38', '46.83', '0.00', '5.00', '7.02', '147.51'),
(68, 53, 16, 'SHRI KRISHNA 20 RS SHEET COW GHEE', '20 RS SHEET COW GHEE', 10, '15.71', '15.87', '0.00', '5.00', '7.94', '166.64'),
(69, 54, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '6.67', '7.13', '0.00', '5.00', '8.56', '179.68'),
(70, 55, 17, 'APPALAM', 'APPALAM  PAPER PACK', 240, '13.78', '14.13', '391.20', '0.00', '0.00', '3000.00'),
(71, 56, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(72, 56, 23, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(73, 56, 26, 'VINAYAKA DREAMS ZIPPER PACKS', 'ZIPPER 6', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(74, 56, 33, 'VINAYAKA BRUTS ZIPPER PACKS', 'ZIPPER -11', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(75, 56, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 1, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(76, 57, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(77, 57, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(78, 57, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(79, 57, 28, 'VINAYAKA BOLENATH ZIPPER PACKS', 'ZIPPER 7', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(80, 57, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 1, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(81, 57, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '6.67', '7.13', '0.00', '5.00', '8.56', '179.68'),
(82, 58, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(83, 59, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '6.67', '7.13', '0.00', '5.00', '8.56', '179.68'),
(84, 60, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '6.67', '7.13', '0.00', '5.00', '8.56', '179.68'),
(85, 61, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 24, '35.00', '38.08', '0.00', '5.00', '45.70', '959.62'),
(86, 61, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 1, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(87, 62, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 18, '35.00', '38.08', '0.00', '5.00', '34.27', '719.71'),
(88, 62, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(89, 62, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 1, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(90, 62, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '6.67', '7.13', '0.00', '5.00', '8.56', '179.68'),
(91, 63, 17, 'APPALAM', 'APPALAM  PAPER PACK', 20, '13.78', '14.13', '22.60', '0.00', '0.00', '260.00'),
(92, 63, 40, 'GINGER GARLIC PASTE 5RS', 'MASALA-GINGER-GARLIC-PASTE-GINGER-GARLIC-PASTE-5RS', 40, '2.08', '2.38', '0.00', '5.00', '4.76', '99.96'),
(93, 63, 34, 'SHRI KRISHNA 10RS SHEET COW GHEE', '10 RS SHEET COW GHEE', 20, '7.49', '7.94', '0.00', '5.00', '7.94', '166.74'),
(94, 63, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 12, '6.67', '7.13', '0.00', '5.00', '4.28', '89.84'),
(95, 64, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '14.13', '11.30', '0.00', '0.00', '130.00'),
(96, 65, 17, 'APPALAM', 'APPALAM  PAPER PACK', 20, '13.78', '14.13', '22.60', '0.00', '0.00', '260.00'),
(97, 65, 31, 'VINAYAKA BLACK FANTASY 60G', 'ECONOMY 1', 12, '14.16', '15.83', '0.00', '5.00', '9.50', '199.46'),
(98, 66, 34, 'SHRI KRISHNA 10RS SHEET COW GHEE', '10 RS SHEET COW GHEE', 40, '7.49', '7.94', '0.00', '5.00', '15.88', '333.48'),
(99, 66, 17, 'APPALAM', 'APPALAM  PAPER PACK', 12, '13.78', '14.13', '13.56', '0.00', '0.00', '156.00'),
(100, 66, 31, 'VINAYAKA BLACK FANTASY 60G', 'ECONOMY 1', 12, '14.16', '15.83', '0.00', '5.00', '9.50', '199.46'),
(101, 67, 13, 'SHRI KRISHNA 100ML JAR COW GHEE', 'COW GHEE 100ML JAR', 4, '84.61', '89.68', '0.00', '5.00', '17.94', '376.66'),
(102, 67, 12, 'SHRI KRISHNA 200 ML JAR COW GHEE', 'COW GHEE 200ML JAR', 2, '156.26', '165.63', '9.36', '5.00', '16.10', '338.00'),
(103, 67, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '14.13', '11.30', '0.00', '0.00', '130.00'),
(104, 68, 39, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', 4, '33.33', '43.65', '0.00', '5.00', '8.73', '183.33'),
(105, 68, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 4, '38.08', '43.65', '0.00', '5.00', '8.73', '183.33'),
(106, 68, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 4, '38.08', '43.65', '0.00', '5.00', '8.73', '183.33'),
(107, 69, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(108, 69, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(109, 69, 28, 'VINAYAKA BOLENATH ZIPPER PACKS', 'ZIPPER 7', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(110, 69, 23, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(111, 69, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 1, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(112, 70, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 4, '38.08', '43.65', '0.00', '5.00', '8.73', '183.33'),
(113, 70, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 4, '38.08', '43.65', '0.00', '5.00', '8.73', '183.33'),
(114, 70, 39, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', 4, '33.33', '43.65', '0.00', '5.00', '8.73', '183.33'),
(115, 71, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(116, 71, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(117, 71, 33, 'VINAYAKA BRUTS ZIPPER PACKS', 'ZIPPER -11', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(118, 71, 26, 'VINAYAKA DREAMS ZIPPER PACKS', 'ZIPPER 6', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(119, 71, 32, 'VINAYAKA WILD PURPLE 60G', 'ECONOMY 2', 12, '14.16', '15.83', '0.00', '5.00', '9.50', '199.46'),
(120, 71, 31, 'VINAYAKA BLACK FANTASY 60G', 'ECONOMY 1', 12, '14.16', '15.83', '0.00', '5.00', '9.50', '199.46'),
(121, 71, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 6, '38.08', '43.65', '0.00', '5.00', '13.10', '275.00'),
(122, 71, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 12, '38.08', '43.65', '0.00', '5.00', '26.19', '549.99'),
(123, 71, 39, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', 12, '33.33', '43.65', '0.00', '5.00', '26.19', '549.99'),
(124, 71, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 2, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(125, 72, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 24, '35.00', '38.08', '0.00', '5.00', '45.70', '959.62'),
(126, 73, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 6, '0.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(127, 73, 28, 'VINAYAKA BOLENATH ZIPPER PACKS', 'ZIPPER 7', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(128, 74, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 6, '38.08', '43.65', '0.00', '5.00', '13.10', '275.00'),
(129, 74, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 6, '38.08', '43.65', '0.00', '5.00', '13.10', '275.00'),
(130, 74, 39, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', 6, '33.33', '43.65', '0.00', '5.00', '13.10', '275.00'),
(131, 74, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 60, '6.67', '7.13', '0.00', '5.00', '21.39', '449.19'),
(132, 75, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(133, 75, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(134, 75, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(135, 75, 23, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(136, 75, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(137, 75, 26, 'VINAYAKA DREAMS ZIPPER PACKS', 'ZIPPER 6', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(138, 75, 28, 'VINAYAKA BOLENATH ZIPPER PACKS', 'ZIPPER 7', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(139, 75, 33, 'VINAYAKA BRUTS ZIPPER PACKS', 'ZIPPER -11', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(140, 75, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 12, '38.08', '43.65', '0.00', '5.00', '26.19', '549.99'),
(141, 75, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 12, '38.08', '43.65', '0.00', '5.00', '26.19', '549.99'),
(142, 75, 39, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', 12, '33.33', '43.65', '0.00', '5.00', '26.19', '549.99'),
(143, 75, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 2, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(144, 76, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(145, 77, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 24, '35.00', '38.08', '0.00', '5.00', '45.70', '959.62'),
(146, 77, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(147, 77, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(148, 77, 23, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(149, 77, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(150, 77, 26, 'VINAYAKA DREAMS ZIPPER PACKS', 'ZIPPER 6', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(151, 77, 28, 'VINAYAKA BOLENATH ZIPPER PACKS', 'ZIPPER 7', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(152, 77, 33, 'VINAYAKA BRUTS ZIPPER PACKS', 'ZIPPER -11', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(153, 77, 32, 'VINAYAKA WILD PURPLE 60G', 'ECONOMY 2', 24, '14.16', '15.83', '18.00', '5.00', '18.10', '380.02'),
(154, 77, 31, 'VINAYAKA BLACK FANTASY 60G', 'ECONOMY 1', 36, '14.16', '15.83', '27.00', '5.00', '27.14', '570.02'),
(155, 77, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 4, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(156, 78, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 12, '35.00', '38.08', '16.92', '5.00', '22.00', '462.04'),
(157, 78, 23, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', 12, '35.00', '38.08', '16.92', '5.00', '22.00', '462.04'),
(158, 78, 33, 'VINAYAKA BRUTS ZIPPER PACKS', 'ZIPPER -11', 12, '35.00', '38.08', '16.92', '5.00', '22.00', '462.04'),
(159, 78, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 24, '35.00', '38.08', '33.84', '5.00', '44.00', '924.08'),
(160, 78, 39, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', 4, '33.33', '43.65', '0.00', '5.00', '8.73', '183.33'),
(161, 78, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 4, '38.08', '43.65', '0.00', '5.00', '8.73', '183.33'),
(162, 78, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 4, '38.08', '43.65', '0.00', '5.00', '8.73', '183.33'),
(163, 78, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 2, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(164, 79, 34, 'SHRI KRISHNA 10RS SHEET COW GHEE', '10 RS SHEET COW GHEE', 99, '7.49', '7.94', '32.67', '5.00', '37.67', '791.06'),
(165, 79, 16, 'SHRI KRISHNA 20 RS SHEET COW GHEE', '20 RS SHEET COW GHEE', 80, '14.97', '15.87', '48.80', '5.00', '61.04', '1281.84'),
(166, 79, 17, 'APPALAM', 'APPALAM  PAPER PACK', 50, '13.78', '14.13', '56.50', '0.00', '0.00', '650.00'),
(167, 80, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 36, '6.67', '7.13', '0.00', '5.00', '12.83', '269.51'),
(168, 80, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(169, 80, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 3, '35.00', '38.08', '0.00', '5.00', '5.71', '119.95'),
(170, 80, 23, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', 3, '35.00', '38.08', '0.00', '5.00', '5.71', '119.95'),
(171, 80, 33, 'VINAYAKA BRUTS ZIPPER PACKS', 'ZIPPER -11', 3, '35.00', '38.08', '0.00', '5.00', '5.71', '119.95'),
(172, 80, 28, 'VINAYAKA BOLENATH ZIPPER PACKS', 'ZIPPER 7', 3, '35.00', '38.08', '0.00', '5.00', '5.71', '119.95'),
(173, 80, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 1, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(174, 81, 30, 'VINAYAKA GOOD MORNING ECONOMY', 'ZIPPER 9', 60, '15.83', '19.00', '68.40', '5.00', '53.58', '1125.18'),
(175, 82, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '14.13', '11.30', '0.00', '0.00', '130.00'),
(176, 82, 12, 'SHRI KRISHNA 200 ML JAR COW GHEE', 'COW GHEE 200ML JAR', 6, '156.26', '165.63', '28.08', '5.00', '48.29', '1013.99'),
(177, 83, 32, 'VINAYAKA WILD PURPLE 60G', 'ECONOMY 2', 6, '14.16', '15.83', '0.00', '5.00', '4.75', '99.73'),
(178, 83, 31, 'VINAYAKA BLACK FANTASY 60G', 'ECONOMY 1', 6, '14.16', '15.83', '0.00', '5.00', '4.75', '99.73'),
(179, 84, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(180, 84, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(181, 84, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(182, 84, 26, 'VINAYAKA DREAMS ZIPPER PACKS', 'ZIPPER 6', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(183, 84, 30, 'VINAYAKA GOOD MORNING ECONOMY', 'ZIPPER 9', 6, '15.83', '19.00', '0.00', '5.00', '5.70', '119.70'),
(184, 84, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 1, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(185, 84, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '14.13', '11.30', '0.00', '0.00', '130.00'),
(186, 85, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '6.67', '7.13', '0.00', '5.00', '8.56', '179.68'),
(187, 85, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '14.13', '11.30', '0.00', '0.00', '130.00'),
(188, 86, 17, 'APPALAM', 'APPALAM  PAPER PACK', 20, '13.78', '14.13', '22.60', '0.00', '0.00', '260.00'),
(189, 87, 40, 'GINGER GARLIC PASTE 5RS', 'MASALA-GINGER-GARLIC-PASTE-GINGER-GARLIC-PASTE-5RS', 920, '2.08', '2.38', '138.00', '5.00', '102.58', '2154.18'),
(190, 88, 14, 'SHRI KRISHNA 50ML JAR COW GHEE', 'COW GHEE 50ML JAR', 6, '44.17', '46.83', '0.00', '5.00', '14.05', '295.03'),
(191, 88, 13, 'SHRI KRISHNA 100ML JAR COW GHEE', 'COW GHEE 100ML JAR', 6, '84.61', '89.68', '0.00', '5.00', '26.90', '564.98'),
(192, 88, 12, 'SHRI KRISHNA 200 ML JAR COW GHEE', 'COW GHEE 200ML JAR', 6, '156.26', '165.63', '28.08', '5.00', '48.29', '1013.99'),
(193, 88, 17, 'APPALAM', 'APPALAM  PAPER PACK', 50, '13.78', '14.13', '56.50', '0.00', '0.00', '650.00'),
(194, 89, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '6.67', '7.13', '0.00', '5.00', '8.56', '179.68'),
(195, 90, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '6.67', '7.13', '0.00', '5.00', '8.56', '179.68'),
(196, 90, 30, 'VINAYAKA GOOD MORNING ECONOMY', 'ZIPPER 9', 24, '15.83', '19.00', '0.00', '5.00', '22.80', '478.80'),
(197, 91, 39, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', 2, '33.33', '43.65', '0.00', '5.00', '4.37', '91.67'),
(198, 91, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 2, '38.08', '43.65', '0.00', '5.00', '4.37', '91.67'),
(199, 91, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 2, '38.08', '43.65', '0.00', '5.00', '4.37', '91.67'),
(200, 91, 30, 'VINAYAKA GOOD MORNING ECONOMY', 'ZIPPER 9', 6, '15.83', '19.00', '0.00', '5.00', '5.70', '119.70'),
(201, 92, 17, 'APPALAM', 'APPALAM  PAPER PACK', 20, '13.78', '14.13', '22.60', '0.00', '0.00', '260.00'),
(202, 93, 13, 'SHRI KRISHNA 100ML JAR COW GHEE', 'COW GHEE 100ML JAR', 10, '84.61', '89.68', '0.00', '5.00', '44.84', '941.64'),
(203, 93, 17, 'APPALAM', 'APPALAM  PAPER PACK', 20, '13.78', '14.13', '22.60', '0.00', '0.00', '260.00'),
(204, 94, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 48, '35.00', '38.08', '0.00', '5.00', '91.39', '1919.23'),
(205, 94, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 24, '35.00', '38.08', '0.00', '5.00', '45.70', '959.62'),
(206, 94, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 3, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(207, 95, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(208, 95, 21, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(209, 95, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(210, 95, 26, 'VINAYAKA DREAMS ZIPPER PACKS', 'ZIPPER 6', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(211, 95, 33, 'VINAYAKA BRUTS ZIPPER PACKS', 'ZIPPER -11', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(212, 95, 43, 'FRESH GUGGAL', 'INCENSE-STICKS-ZIPPER-PACKS-FRESH-GUGGAL', 2, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(213, 96, 28, 'VINAYAKA BOLENATH ZIPPER PACKS', 'ZIPPER 7', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(214, 96, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(215, 96, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(216, 96, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 1, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(217, 97, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 24, '35.00', '38.08', '0.00', '5.00', '45.70', '959.62'),
(218, 97, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(219, 97, 25, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(220, 97, 33, 'VINAYAKA BRUTS ZIPPER PACKS', 'ZIPPER -11', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(221, 97, 26, 'VINAYAKA DREAMS ZIPPER PACKS', 'ZIPPER 6', 12, '35.00', '38.08', '0.00', '5.00', '22.85', '479.81'),
(222, 97, 36, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', 3, '0.00', '0.00', '0.00', '5.00', '0.00', '0.00'),
(223, 97, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 36, '6.67', '7.13', '0.00', '5.00', '12.83', '269.51'),
(224, 98, 17, 'APPALAM', 'APPALAM  PAPER PACK', 100, '13.78', '14.13', '113.00', '0.00', '0.00', '1300.00'),
(225, 99, 17, 'APPALAM', 'APPALAM  PAPER PACK', 240, '13.78', '14.13', '391.20', '0.00', '0.00', '3000.00'),
(226, 100, 34, 'SHRI KRISHNA 10RS SHEET COW GHEE', '10 RS SHEET COW GHEE', 40, '7.49', '7.94', '0.00', '5.00', '15.88', '333.48'),
(227, 101, 17, 'APPALAM', 'APPALAM  PAPER PACK', 20, '13.78', '14.13', '22.60', '0.00', '0.00', '260.00'),
(228, 102, 14, 'SHRI KRISHNA 50ML JAR COW GHEE', 'COW GHEE 50ML JAR', 10, '44.17', '46.83', '0.00', '5.00', '23.42', '491.72'),
(229, 102, 13, 'SHRI KRISHNA 100ML JAR COW GHEE', 'COW GHEE 100ML JAR', 10, '84.61', '89.68', '0.00', '5.00', '44.84', '941.64'),
(230, 102, 17, 'APPALAM', 'APPALAM  PAPER PACK', 20, '13.78', '14.13', '22.60', '0.00', '0.00', '260.00'),
(231, 103, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 72, '6.67', '7.13', '0.00', '5.00', '25.67', '539.03'),
(232, 104, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 12, '6.67', '7.13', '0.00', '5.00', '4.28', '89.84'),
(233, 105, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 6, '38.08', '43.65', '0.00', '5.00', '13.10', '275.00'),
(234, 105, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 3, '38.08', '43.65', '0.00', '5.00', '6.55', '137.50'),
(235, 105, 39, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', 3, '33.33', '43.65', '0.00', '5.00', '6.55', '137.50'),
(236, 106, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 12, '6.67', '7.13', '0.00', '5.00', '4.28', '89.84'),
(237, 107, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 12, '38.08', '43.65', '0.00', '5.00', '26.19', '549.99'),
(238, 107, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 12, '38.08', '43.65', '0.00', '5.00', '26.19', '549.99'),
(239, 108, 12, 'SHRI KRISHNA 200 ML JAR COW GHEE', 'COW GHEE 200ML JAR', 3, '156.26', '165.63', '14.04', '5.00', '24.14', '506.99'),
(240, 108, 13, 'SHRI KRISHNA 100ML JAR COW GHEE', 'COW GHEE 100ML JAR', 3, '84.61', '89.68', '0.00', '5.00', '13.45', '282.49'),
(241, 108, 17, 'APPALAM', 'APPALAM  PAPER PACK', 20, '13.78', '14.13', '22.60', '0.00', '0.00', '260.00'),
(242, 109, 14, 'SHRI KRISHNA 50ML JAR COW GHEE', 'COW GHEE 50ML JAR', 6, '44.17', '46.83', '0.00', '5.00', '14.05', '295.03'),
(243, 109, 13, 'SHRI KRISHNA 100ML JAR COW GHEE', 'COW GHEE 100ML JAR', 3, '84.61', '89.68', '0.00', '5.00', '13.45', '282.49'),
(244, 110, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '14.13', '11.30', '0.00', '0.00', '130.00'),
(245, 111, 16, 'SHRI KRISHNA 20 RS SHEET COW GHEE', '20 RS SHEET COW GHEE', 20, '14.97', '15.87', '0.00', '5.00', '15.87', '333.27'),
(246, 111, 17, 'APPALAM', 'APPALAM  PAPER PACK', 50, '13.78', '14.13', '56.50', '0.00', '0.00', '650.00'),
(247, 112, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '14.13', '1.30', '0.00', '0.00', '140.00'),
(248, 113, 34, 'SHRI KRISHNA 10RS SHEET COW GHEE', '10 RS SHEET COW GHEE', 40, '7.49', '7.94', '0.00', '5.00', '15.88', '333.48'),
(249, 113, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '14.13', '1.30', '0.00', '0.00', '140.00'),
(250, 113, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 12, '6.67', '7.13', '0.00', '5.00', '4.28', '89.84'),
(251, 114, 14, 'SHRI KRISHNA 50ML JAR COW GHEE', 'COW GHEE 50ML JAR', 6, '44.17', '46.83', '0.00', '5.00', '14.05', '295.03'),
(252, 114, 13, 'SHRI KRISHNA 100ML JAR COW GHEE', 'COW GHEE 100ML JAR', 6, '84.61', '89.68', '0.00', '5.00', '26.90', '564.98'),
(253, 114, 12, 'SHRI KRISHNA 200 ML JAR COW GHEE', 'COW GHEE 200ML JAR', 6, '156.26', '165.63', '28.08', '5.00', '48.29', '1013.99'),
(254, 114, 34, 'SHRI KRISHNA 10RS SHEET COW GHEE', '10 RS SHEET COW GHEE', 20, '7.49', '7.94', '0.00', '5.00', '7.94', '166.74'),
(255, 114, 16, 'SHRI KRISHNA 20 RS SHEET COW GHEE', '20 RS SHEET COW GHEE', 10, '14.97', '15.87', '0.00', '5.00', '7.94', '166.64'),
(256, 114, 17, 'APPALAM', 'APPALAM  PAPER PACK', 10, '13.78', '15.00', '0.00', '0.00', '0.00', '150.00'),
(257, 115, 12, 'SHRI KRISHNA 200 ML JAR COW GHEE', 'COW GHEE 200ML JAR', 3, '156.26', '165.63', '14.04', '5.00', '24.14', '506.99'),
(258, 115, 14, 'SHRI KRISHNA 50ML JAR COW GHEE', 'COW GHEE 50ML JAR', 6, '44.17', '46.83', '0.00', '5.00', '14.05', '295.03'),
(259, 115, 17, 'APPALAM', 'APPALAM  PAPER PACK', 20, '13.78', '14.13', '0.00', '0.00', '0.00', '282.60'),
(260, 116, 30, 'VINAYAKA GOOD MORNING ECONOMY', 'ZIPPER 9', 12, '15.83', '19.00', '0.00', '5.00', '11.40', '239.40'),
(261, 117, 39, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', 2, '33.33', '43.65', '3.96', '5.00', '4.17', '87.51'),
(262, 117, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 2, '38.08', '43.65', '3.96', '5.00', '4.17', '87.51'),
(263, 117, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 2, '38.08', '43.65', '3.96', '5.00', '4.17', '87.51'),
(264, 117, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 36, '6.67', '7.13', '0.00', '5.00', '12.83', '269.51'),
(265, 118, 29, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', 24, '6.67', '7.13', '0.00', '5.00', '8.56', '179.68'),
(266, 118, 31, 'VINAYAKA BLACK FANTASY 60G', 'ECONOMY 1', 12, '14.16', '15.83', '0.00', '5.00', '9.50', '199.46'),
(267, 119, 34, 'SHRI KRISHNA 10RS SHEET COW GHEE', '10 RS SHEET COW GHEE', 40, '7.49', '7.94', '0.00', '5.00', '15.88', '333.48'),
(268, 120, 17, 'APPALAM', 'APPALAM  PAPER PACK', 50, '13.78', '14.13', '56.50', '0.00', '0.00', '650.00'),
(269, 121, 34, 'SHRI KRISHNA 10RS SHEET COW GHEE', '10 RS SHEET COW GHEE', 40, '7.49', '7.94', '0.00', '5.00', '15.88', '333.48'),
(270, 121, 17, 'APPALAM', 'APPALAM  PAPER PACK', 20, '13.78', '14.13', '22.60', '0.00', '0.00', '260.00'),
(271, 122, 14, 'SHRI KRISHNA 50ML JAR COW GHEE', 'COW GHEE 50ML JAR', 10, '44.17', '46.83', '0.00', '5.00', '23.42', '491.72'),
(272, 123, 39, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', 4, '33.33', '43.65', '0.00', '5.00', '8.73', '183.33'),
(273, 123, 38, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', 4, '38.08', '43.65', '0.00', '5.00', '8.73', '183.33'),
(274, 123, 37, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', 4, '38.08', '43.65', '0.00', '5.00', '8.73', '183.33'),
(275, 124, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(276, 124, 22, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', 6, '35.00', '38.08', '0.00', '5.00', '11.42', '239.90'),
(277, 125, 18, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', 2, '35.00', '40.00', '5.00', '5.00', '3.75', '78.75'),
(278, 126, 13, 'SHRI KRISHNA 100ML JAR COW GHEE', 'COW GHEE 100ML JAR', 2, '84.61', '89.68', '0.00', '5.00', '8.97', '188.33');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `retailer_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `gst_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `grand_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('Pending','Approved','Processing','Completed','Cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `order_mode` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'By Route',
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `retailer_id`, `staff_id`, `order_date`, `total_amount`, `discount_amount`, `gst_amount`, `grand_total`, `status`, `order_mode`, `remarks`, `created_at`) VALUES
(3, 7, 15, '2026-07-13', '1777.69', '0.00', '88.88', '1866.57', 'Approved', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-13 14:49:21'),
(4, 8, 15, '2026-07-15', '690.00', '0.00', '34.50', '724.50', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 11:50:54'),
(5, 9, 15, '2026-07-15', '330.00', '0.00', '16.50', '346.50', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 11:52:05'),
(6, 10, 15, '2026-07-15', '480.00', '0.00', '24.00', '504.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 11:54:28'),
(7, 11, 15, '2026-07-15', '180.00', '0.00', '9.00', '189.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 11:55:11'),
(8, 12, 15, '2026-07-15', '420.00', '0.00', '21.00', '441.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 11:56:38'),
(9, 13, 15, '2026-07-15', '1140.00', '0.00', '57.00', '1197.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 11:58:47'),
(10, 14, 15, '2026-07-15', '90.00', '0.00', '4.50', '94.50', 'Approved', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 11:59:59'),
(11, 15, 15, '2026-07-15', '180.00', '0.00', '9.00', '189.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 12:00:48'),
(12, 16, 15, '2026-07-15', '180.00', '0.00', '9.00', '189.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 12:01:34'),
(13, 17, 15, '2026-07-15', '1140.00', '0.00', '57.00', '1197.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 12:03:33'),
(14, 18, 15, '2026-07-15', '200.04', '0.00', '10.00', '210.04', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-15 12:04:21'),
(15, 19, 15, '2026-07-16', '480.00', '0.00', '24.00', '504.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 09:33:49'),
(16, 20, 15, '2026-07-16', '1440.00', '0.00', '72.00', '1512.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 09:42:19'),
(17, 21, 15, '2026-07-16', '960.00', '0.00', '48.00', '1008.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 09:43:23'),
(18, 22, 15, '2026-07-16', '660.00', '0.00', '33.00', '693.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 09:44:45'),
(19, 23, 15, '2026-07-16', '960.00', '0.00', '48.00', '1008.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 09:46:37'),
(20, 24, 15, '2026-07-16', '240.00', '0.00', '12.00', '252.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 09:48:50'),
(21, 25, 15, '2026-07-16', '960.00', '0.00', '48.00', '1008.00', 'Approved', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 09:55:23'),
(22, 26, 15, '2026-07-16', '960.00', '0.00', '48.00', '1008.00', 'Approved', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 09:56:01'),
(23, 27, 15, '2026-07-16', '960.00', '0.00', '48.00', '1008.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 09:57:47'),
(24, 28, 15, '2026-07-16', '960.00', '0.00', '48.00', '1008.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 10:00:25'),
(25, 29, 15, '2026-07-16', '960.00', '0.00', '48.00', '1008.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 10:01:43'),
(26, 31, 15, '2026-07-16', '650.04', '0.00', '32.50', '682.54', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-16 10:03:45'),
(27, 35, 15, '2026-07-24', '141.30', '0.13', '0.00', '141.17', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-24 04:49:32'),
(28, 36, 15, '2026-07-24', '141.30', '0.13', '0.00', '141.17', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-24 04:51:52'),
(29, 37, 15, '2026-07-24', '993.78', '4.68', '49.46', '1038.56', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-24 05:02:48'),
(30, 38, 15, '2026-07-24', '299.19', '0.00', '14.96', '314.15', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-24 05:04:45'),
(31, 15, 15, '2026-07-29', '171.12', '0.00', '8.56', '179.68', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-07-29 11:52:02'),
(32, 40, 15, '2026-07-31', '3391.20', '1.63', '0.00', '3389.57', 'Cancelled', 'By Call', '\n[Status updated to Cancelled by Owner. Note: RATE VARIATION]', '2026-07-31 05:37:56'),
(33, 40, 15, '2026-07-31', '3391.20', '1.63', '0.00', '3389.57', 'Cancelled', 'By Call', '\n[Status updated to Cancelled by Owner. Note: its just for practice of software funtions]', '2026-07-31 05:41:53'),
(34, 39, 15, '2026-08-02', '3249.90', '1.63', '0.00', '3248.27', 'Cancelled', 'By Call', '\n[Status updated to Cancelled by Owner. Note: its just for practice of software funtions]', '2026-08-02 12:29:48'),
(35, 39, 15, '2026-08-02', '2967.30', '342.30', '0.00', '2625.00', 'Cancelled', 'By Call', '\n[Status updated to Cancelled by Owner. Note: its just for practice of software funtions]', '2026-08-02 12:48:39'),
(36, 40, 15, '2026-07-31', '3391.20', '391.20', '0.00', '3000.00', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-02 14:37:52'),
(37, 39, 15, '2026-08-03', '913.92', '0.00', '45.70', '959.62', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-03 05:34:04'),
(38, 41, 15, '2026-08-03', '1085.04', '0.00', '54.25', '1139.29', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-03 05:36:50'),
(39, 42, 15, '2026-08-03', '228.48', '0.00', '11.42', '239.90', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-03 05:37:41'),
(40, 43, 15, '2026-08-03', '171.12', '0.00', '8.56', '179.68', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-03 05:38:51'),
(41, 44, 15, '2026-08-03', '171.12', '0.00', '8.56', '179.68', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-03 05:40:07'),
(42, 45, 15, '2026-08-03', '913.92', '0.00', '45.70', '959.62', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-03 05:40:51'),
(43, 46, 15, '2026-08-03', '1085.04', '0.00', '54.25', '1139.29', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-03 05:42:11'),
(44, 47, 15, '2026-08-04', '622.16', '22.60', '16.98', '616.54', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-04 09:44:20'),
(45, 48, 15, '2026-08-04', '141.30', '11.30', '0.00', '130.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-04 09:44:58'),
(46, 49, 15, '2026-08-04', '472.56', '22.60', '9.50', '459.46', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-04 09:52:30'),
(47, 50, 15, '2026-08-04', '677.12', '13.56', '25.38', '688.94', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-04 09:56:01'),
(48, 51, 15, '2026-08-04', '831.28', '20.66', '34.03', '844.65', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-04 09:58:00'),
(49, 8, 15, '2026-08-05', '523.80', '0.00', '26.19', '549.99', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-05 05:51:05'),
(50, 17, 15, '2026-08-05', '913.92', '0.00', '45.70', '959.62', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-05 08:08:13'),
(51, 24, 15, '2026-08-06', '523.80', '0.00', '26.19', '549.99', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-06 06:32:15'),
(52, 25, 15, '2026-08-06', '3517.26', '0.00', '175.86', '3693.12', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-06 06:40:49'),
(53, 26, 15, '2026-08-06', '913.92', '0.00', '45.70', '959.62', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-06 06:46:11'),
(54, 19, 15, '2026-08-06', '456.96', '0.00', '22.85', '479.81', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-06 08:09:51'),
(55, 20, 15, '2026-08-06', '1213.50', '0.00', '60.68', '1274.18', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-06 08:11:41'),
(56, 52, 15, '2026-08-06', '5227.08', '0.00', '261.35', '5488.43', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-06 08:39:40'),
(57, 54, 15, '2026-08-06', '456.96', '0.00', '22.85', '479.81', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-06 08:40:41'),
(58, 53, 15, '2026-08-06', '5062.44', '45.00', '250.87', '5268.31', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-06 08:50:21'),
(59, 55, 15, '2026-08-06', '2808.60', '84.60', '136.20', '2860.20', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-06 08:57:21'),
(60, 56, 15, '2026-08-11', '2762.16', '137.97', '98.71', '2722.90', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-11 04:24:47'),
(61, 33, 15, '2026-08-15', '1170.60', '0.00', '58.53', '1229.13', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-15 03:55:50'),
(62, 34, 15, '2026-08-15', '1140.00', '68.40', '53.58', '1125.18', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-15 04:05:12'),
(63, 59, 15, '2026-08-15', '1135.08', '39.38', '48.29', '1143.99', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-15 04:34:59'),
(64, 57, 15, '2026-08-15', '189.96', '0.00', '9.50', '199.46', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-15 04:36:09'),
(65, 16, 15, '2026-08-19', '1169.22', '11.30', '51.40', '1209.32', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-19 05:56:50'),
(66, 18, 15, '2026-08-19', '312.42', '11.30', '8.56', '309.68', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-19 06:30:14'),
(67, 18, 15, '2026-08-19', '312.42', '11.30', '8.56', '309.68', 'Cancelled', 'By Route', '\n[Status updated to Cancelled by Owner. Note: MANY CLICKS]', '2026-08-19 06:30:14'),
(68, 18, 15, '2026-08-19', '312.42', '11.30', '8.56', '309.68', 'Cancelled', 'By Route', '\n[Status updated to Cancelled by Owner. Note: MANY CLICKS]', '2026-08-19 06:30:14'),
(69, 18, 15, '2026-08-19', '312.42', '11.30', '8.56', '309.68', 'Cancelled', 'By Route', '\n[Status updated to Cancelled by Owner. Note: MANY CLICKS]', '2026-08-19 06:30:14'),
(70, 33, 15, '2026-08-22', '282.60', '22.60', '0.00', '260.00', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-22 13:50:24'),
(71, 32, 15, '2026-08-22', '158.70', '0.00', '7.94', '166.64', 'Pending', 'By Call', '', '2026-08-22 13:54:29'),
(72, 35, 15, '2026-08-23', '141.30', '11.30', '0.00', '130.00', 'Pending', 'By Call', '', '2026-08-23 01:27:00'),
(73, 60, 15, '2026-08-27', '2519.34', '84.58', '89.24', '2524.00', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-27 06:35:43'),
(74, 40, 15, '2026-08-23', '2189.60', '138.00', '102.58', '2154.18', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-08-27 06:44:37'),
(75, 12, 15, '2026-09-02', '171.12', '0.00', '8.56', '179.68', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-02 10:01:58'),
(76, 15, 15, '2026-09-02', '627.12', '0.00', '31.36', '658.48', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-02 10:05:23'),
(77, 16, 15, '2026-09-02', '375.90', '0.00', '18.80', '394.70', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-02 10:07:04'),
(78, 26, 15, '2026-09-02', '513.36', '0.00', '25.67', '539.03', 'Pending', 'By Call', '', '2026-09-05 04:37:55'),
(79, 51, 15, '2026-09-02', '1048.53', '36.64', '37.59', '1049.48', 'Approved', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-05 04:39:00'),
(80, 59, 15, '2026-09-04', '282.60', '22.60', '0.00', '260.00', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-05 04:40:42'),
(81, 37, 15, '2026-09-04', '1179.40', '22.60', '44.84', '1201.64', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-05 04:42:07'),
(82, 26, 15, '2026-09-07', '2741.76', '0.00', '137.09', '2878.85', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-07 01:52:23'),
(83, 25, 15, '2026-09-07', '2284.80', '0.00', '114.24', '2399.04', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-07 02:03:10'),
(84, 41, 15, '2026-09-07', '913.92', '0.00', '45.70', '959.62', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-07 07:03:58'),
(85, 45, 15, '2026-09-07', '2998.44', '0.00', '149.92', '3148.36', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-07 07:24:20'),
(86, 56, 15, '2026-09-10', '1413.00', '113.00', '0.00', '1300.00', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-11 02:56:19'),
(87, 40, 15, '2026-09-12', '3391.20', '391.20', '0.00', '3000.00', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-12 05:34:56'),
(88, 34, 15, '2026-09-12', '282.60', '22.60', '0.00', '260.00', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-12 12:50:43'),
(89, 59, 15, '2026-09-18', '317.60', '0.00', '15.88', '333.48', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-18 07:50:11'),
(90, 60, 15, '2026-09-18', '1647.70', '22.60', '68.26', '1693.36', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-18 07:53:00'),
(91, 33, 15, '2026-09-18', '513.36', '0.00', '25.67', '539.03', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-18 07:54:24'),
(92, 16, 15, '2026-09-18', '85.56', '0.00', '4.28', '89.84', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-18 07:56:16'),
(93, 8, 15, '2026-09-18', '523.80', '0.00', '26.19', '549.99', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-18 08:02:38'),
(94, 18, 15, '2026-09-18', '85.56', '0.00', '4.28', '89.84', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-18 08:05:14'),
(95, 53, 15, '2026-09-21', '1047.60', '0.00', '52.38', '1099.98', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-21 05:44:57'),
(96, 51, 15, '2026-09-22', '1048.53', '36.64', '37.59', '1049.48', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-22 04:22:46'),
(97, 49, 15, '2026-09-22', '550.02', '0.00', '27.50', '577.52', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-22 09:11:03'),
(98, 50, 15, '2026-09-22', '141.30', '11.30', '0.00', '130.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-22 09:11:58'),
(99, 63, 15, '2026-09-22', '1023.90', '56.50', '15.87', '983.27', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-22 09:26:04'),
(100, 61, 15, '2026-09-22', '141.30', '1.30', '0.00', '140.00', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-22 10:28:59'),
(101, 64, 15, '2026-09-22', '544.46', '1.30', '20.16', '563.32', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-22 10:31:37'),
(102, 62, 15, '2026-09-22', '2280.34', '28.08', '105.11', '2357.37', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-22 10:36:47'),
(103, 51, 15, '2026-09-22', '1060.47', '14.04', '38.19', '1084.62', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-22 11:46:49'),
(104, 18, 15, '2026-09-24', '228.00', '0.00', '11.40', '239.40', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-24 00:53:16'),
(105, 66, 15, '2026-09-24', '518.58', '11.88', '25.34', '532.04', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-24 00:54:18'),
(106, 67, 15, '2026-09-24', '361.08', '0.00', '18.05', '379.13', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-09-24 00:58:02'),
(107, 49, 15, '2026-10-02', '317.60', '0.00', '15.88', '333.48', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-10-02 05:10:15'),
(108, 60, 15, '2026-10-02', '706.50', '56.50', '0.00', '650.00', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-10-02 10:57:20'),
(109, 70, 15, '2026-10-02', '600.20', '22.60', '15.88', '593.48', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-10-02 10:58:18'),
(110, 59, 15, '2026-10-02', '468.30', '0.00', '23.42', '491.72', 'Completed', 'By Route', '\n[Status updated to Approved by Owner. Note: ]', '2026-10-02 11:00:03'),
(111, 69, 15, '2026-10-02', '523.80', '0.00', '26.19', '549.99', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-10-02 11:01:04'),
(112, 68, 15, '2026-10-02', '456.96', '0.00', '22.85', '479.81', 'Completed', 'By Call', '\n[Status updated to Approved by Owner. Note: ]', '2026-10-02 11:01:39');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `gst_percentage` decimal(5,2) NOT NULL,
  `gst_amount` decimal(10,2) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `sku_id`, `quantity`, `price`, `discount_amount`, `gst_percentage`, `gst_amount`, `total_amount`) VALUES
(4, 3, 16, 10, '15.87', '0.00', '5.00', '7.94', '166.64'),
(5, 3, 14, 12, '46.38', '0.00', '5.00', '27.83', '584.39'),
(6, 3, 12, 1, '165.63', '0.00', '5.00', '8.28', '173.91'),
(7, 3, 13, 10, '89.68', '0.00', '5.00', '44.84', '941.64'),
(8, 4, 29, 60, '7.50', '0.00', '5.00', '22.50', '472.50'),
(9, 4, 30, 12, '20.00', '0.00', '5.00', '12.00', '252.00'),
(10, 5, 18, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(11, 5, 29, 12, '7.50', '0.00', '5.00', '4.50', '94.50'),
(12, 6, 18, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(13, 6, 21, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(14, 7, 29, 24, '7.50', '0.00', '5.00', '9.00', '189.00'),
(15, 8, 29, 24, '7.50', '0.00', '5.00', '9.00', '189.00'),
(16, 8, 18, 3, '40.00', '0.00', '5.00', '6.00', '126.00'),
(17, 8, 21, 3, '40.00', '0.00', '5.00', '6.00', '126.00'),
(18, 9, 29, 24, '7.50', '0.00', '5.00', '9.00', '189.00'),
(19, 9, 18, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(20, 9, 21, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(21, 9, 22, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(22, 9, 23, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(23, 10, 29, 12, '7.50', '0.00', '5.00', '4.50', '94.50'),
(24, 11, 29, 24, '7.50', '0.00', '5.00', '9.00', '189.00'),
(25, 12, 29, 24, '7.50', '0.00', '5.00', '9.00', '189.00'),
(26, 13, 29, 24, '7.50', '0.00', '5.00', '9.00', '189.00'),
(27, 13, 18, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(28, 13, 21, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(29, 13, 22, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(30, 13, 23, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(31, 14, 31, 6, '16.67', '0.00', '5.00', '5.00', '105.02'),
(32, 14, 32, 6, '16.67', '0.00', '5.00', '5.00', '105.02'),
(33, 15, 28, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(34, 15, 18, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(35, 16, 18, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(36, 16, 21, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(37, 16, 22, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(38, 16, 28, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(39, 16, 23, 3, '40.00', '0.00', '5.00', '6.00', '126.00'),
(40, 16, 25, 3, '40.00', '0.00', '5.00', '6.00', '126.00'),
(41, 16, 33, 3, '40.00', '0.00', '5.00', '6.00', '126.00'),
(42, 16, 26, 3, '40.00', '0.00', '5.00', '6.00', '126.00'),
(43, 17, 18, 12, '40.00', '0.00', '5.00', '24.00', '504.00'),
(44, 17, 23, 12, '40.00', '0.00', '5.00', '24.00', '504.00'),
(45, 18, 29, 24, '7.50', '0.00', '5.00', '9.00', '189.00'),
(46, 18, 18, 12, '40.00', '0.00', '5.00', '24.00', '504.00'),
(47, 19, 18, 12, '40.00', '0.00', '5.00', '24.00', '504.00'),
(48, 19, 22, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(49, 19, 25, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(50, 20, 30, 12, '20.00', '0.00', '5.00', '12.00', '252.00'),
(51, 21, 33, 12, '40.00', '0.00', '5.00', '24.00', '504.00'),
(52, 21, 21, 12, '40.00', '0.00', '5.00', '24.00', '504.00'),
(53, 22, 18, 24, '40.00', '0.00', '5.00', '48.00', '1008.00'),
(54, 23, 25, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(55, 23, 18, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(56, 23, 21, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(57, 23, 22, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(58, 24, 18, 24, '40.00', '0.00', '5.00', '48.00', '1008.00'),
(59, 25, 22, 12, '40.00', '0.00', '5.00', '24.00', '504.00'),
(60, 25, 18, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(61, 25, 21, 6, '40.00', '0.00', '5.00', '12.00', '252.00'),
(62, 26, 29, 60, '7.50', '0.00', '5.00', '22.50', '472.50'),
(63, 26, 31, 6, '16.67', '0.00', '5.00', '5.00', '105.02'),
(64, 26, 32, 6, '16.67', '0.00', '5.00', '5.00', '105.02'),
(65, 27, 17, 10, '14.13', '0.13', '0.00', '0.00', '141.17'),
(66, 28, 17, 10, '14.13', '0.13', '0.00', '0.00', '141.17'),
(67, 29, 12, 6, '165.63', '4.68', '5.00', '49.46', '1038.56'),
(68, 30, 14, 3, '46.83', '0.00', '5.00', '7.02', '147.51'),
(69, 30, 16, 10, '15.87', '0.00', '5.00', '7.94', '166.64'),
(70, 31, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(71, 32, 17, 240, '14.13', '1.63', '0.00', '0.00', '3389.57'),
(72, 33, 17, 240, '14.13', '1.63', '0.00', '0.00', '3389.57'),
(73, 34, 17, 230, '14.13', '1.63', '0.00', '0.00', '3248.27'),
(74, 35, 17, 210, '14.13', '342.30', '0.00', '0.00', '2625.00'),
(75, 36, 17, 240, '14.13', '391.20', '0.00', '0.00', '3000.00'),
(76, 37, 18, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(77, 37, 23, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(78, 37, 26, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(79, 37, 33, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(80, 37, 36, 1, '0.00', '0.00', '5.00', '0.00', '0.00'),
(81, 38, 18, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(82, 38, 22, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(83, 38, 25, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(84, 38, 28, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(85, 38, 36, 1, '0.00', '0.00', '5.00', '0.00', '0.00'),
(86, 38, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(87, 39, 22, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(88, 40, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(89, 41, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(90, 42, 18, 24, '38.08', '0.00', '5.00', '45.70', '959.62'),
(91, 42, 36, 1, '0.00', '0.00', '5.00', '0.00', '0.00'),
(92, 43, 18, 18, '38.08', '0.00', '5.00', '34.27', '719.71'),
(93, 43, 25, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(94, 43, 36, 1, '0.00', '0.00', '5.00', '0.00', '0.00'),
(95, 43, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(96, 44, 17, 20, '14.13', '22.60', '0.00', '0.00', '260.00'),
(97, 44, 40, 40, '2.38', '0.00', '5.00', '4.76', '99.96'),
(98, 44, 34, 20, '7.94', '0.00', '5.00', '7.94', '166.74'),
(99, 44, 29, 12, '7.13', '0.00', '5.00', '4.28', '89.84'),
(100, 45, 17, 10, '14.13', '11.30', '0.00', '0.00', '130.00'),
(101, 46, 17, 20, '14.13', '22.60', '0.00', '0.00', '260.00'),
(102, 46, 31, 12, '15.83', '0.00', '5.00', '9.50', '199.46'),
(103, 47, 34, 40, '7.94', '0.00', '5.00', '15.88', '333.48'),
(104, 47, 17, 12, '14.13', '13.56', '0.00', '0.00', '156.00'),
(105, 47, 31, 12, '15.83', '0.00', '5.00', '9.50', '199.46'),
(106, 48, 13, 4, '89.68', '0.00', '5.00', '17.94', '376.66'),
(107, 48, 12, 2, '165.63', '9.36', '5.00', '16.10', '338.00'),
(108, 48, 17, 10, '14.13', '11.30', '0.00', '0.00', '130.00'),
(109, 49, 39, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(110, 49, 38, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(111, 49, 37, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(112, 50, 18, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(113, 50, 22, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(114, 50, 28, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(115, 50, 23, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(116, 50, 36, 1, '0.00', '0.00', '5.00', '0.00', '0.00'),
(117, 51, 37, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(118, 51, 38, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(119, 51, 39, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(120, 52, 18, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(121, 52, 21, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(122, 52, 33, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(123, 52, 26, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(124, 52, 32, 12, '15.83', '0.00', '5.00', '9.50', '199.46'),
(125, 52, 31, 12, '15.83', '0.00', '5.00', '9.50', '199.46'),
(126, 52, 37, 6, '43.65', '0.00', '5.00', '13.10', '275.00'),
(127, 52, 38, 12, '43.65', '0.00', '5.00', '26.19', '549.99'),
(128, 52, 39, 12, '43.65', '0.00', '5.00', '26.19', '549.99'),
(129, 52, 36, 2, '0.00', '0.00', '5.00', '0.00', '0.00'),
(130, 53, 18, 24, '38.08', '0.00', '5.00', '45.70', '959.62'),
(131, 54, 36, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(132, 54, 28, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(133, 55, 37, 6, '43.65', '0.00', '5.00', '13.10', '275.00'),
(134, 55, 38, 6, '43.65', '0.00', '5.00', '13.10', '275.00'),
(135, 55, 39, 6, '43.65', '0.00', '5.00', '13.10', '275.00'),
(136, 55, 29, 60, '7.13', '0.00', '5.00', '21.39', '449.19'),
(137, 56, 18, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(138, 56, 21, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(139, 56, 22, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(140, 56, 23, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(141, 56, 25, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(142, 56, 26, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(143, 56, 28, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(144, 56, 33, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(145, 56, 37, 12, '43.65', '0.00', '5.00', '26.19', '549.99'),
(146, 56, 38, 12, '43.65', '0.00', '5.00', '26.19', '549.99'),
(147, 56, 39, 12, '43.65', '0.00', '5.00', '26.19', '549.99'),
(148, 56, 36, 2, '0.00', '0.00', '5.00', '0.00', '0.00'),
(149, 57, 18, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(150, 58, 18, 24, '38.08', '0.00', '5.00', '45.70', '959.62'),
(151, 58, 21, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(152, 58, 22, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(153, 58, 23, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(154, 58, 25, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(155, 58, 26, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(156, 58, 28, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(157, 58, 33, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(158, 58, 32, 24, '15.83', '18.00', '5.00', '18.10', '380.02'),
(159, 58, 31, 36, '15.83', '27.00', '5.00', '27.14', '570.02'),
(160, 58, 36, 4, '0.00', '0.00', '5.00', '0.00', '0.00'),
(161, 59, 18, 12, '38.08', '16.92', '5.00', '22.00', '462.04'),
(162, 59, 23, 12, '38.08', '16.92', '5.00', '22.00', '462.04'),
(163, 59, 33, 12, '38.08', '16.92', '5.00', '22.00', '462.04'),
(164, 59, 25, 24, '38.08', '33.84', '5.00', '44.00', '924.08'),
(165, 59, 39, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(166, 59, 38, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(167, 59, 37, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(168, 59, 36, 2, '0.00', '0.00', '5.00', '0.00', '0.00'),
(169, 60, 34, 99, '7.94', '32.67', '5.00', '37.67', '791.06'),
(170, 60, 16, 80, '15.87', '48.80', '5.00', '61.04', '1281.84'),
(171, 60, 17, 50, '14.13', '56.50', '0.00', '0.00', '650.00'),
(172, 61, 29, 36, '7.13', '0.00', '5.00', '12.83', '269.51'),
(173, 61, 18, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(174, 61, 25, 3, '38.08', '0.00', '5.00', '5.71', '119.95'),
(175, 61, 23, 3, '38.08', '0.00', '5.00', '5.71', '119.95'),
(176, 61, 33, 3, '38.08', '0.00', '5.00', '5.71', '119.95'),
(177, 61, 28, 3, '38.08', '0.00', '5.00', '5.71', '119.95'),
(178, 61, 36, 1, '0.00', '0.00', '5.00', '0.00', '0.00'),
(179, 62, 30, 60, '19.00', '68.40', '5.00', '53.58', '1125.18'),
(180, 63, 17, 10, '14.13', '11.30', '0.00', '0.00', '130.00'),
(181, 63, 12, 6, '165.63', '28.08', '5.00', '48.29', '1013.99'),
(182, 64, 32, 6, '15.83', '0.00', '5.00', '4.75', '99.73'),
(183, 64, 31, 6, '15.83', '0.00', '5.00', '4.75', '99.73'),
(184, 65, 18, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(185, 65, 21, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(186, 65, 22, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(187, 65, 26, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(188, 65, 30, 6, '19.00', '0.00', '5.00', '5.70', '119.70'),
(189, 65, 36, 1, '0.00', '0.00', '5.00', '0.00', '0.00'),
(190, 65, 17, 10, '14.13', '11.30', '0.00', '0.00', '130.00'),
(191, 66, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(192, 66, 17, 10, '14.13', '11.30', '0.00', '0.00', '130.00'),
(193, 67, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(194, 67, 17, 10, '14.13', '11.30', '0.00', '0.00', '130.00'),
(195, 68, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(196, 68, 17, 10, '14.13', '11.30', '0.00', '0.00', '130.00'),
(197, 69, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(198, 69, 17, 10, '14.13', '11.30', '0.00', '0.00', '130.00'),
(199, 70, 17, 20, '14.13', '22.60', '0.00', '0.00', '260.00'),
(200, 71, 16, 10, '15.87', '0.00', '5.00', '7.94', '166.64'),
(201, 72, 17, 10, '14.13', '11.30', '0.00', '0.00', '130.00'),
(203, 73, 14, 6, '46.83', '0.00', '5.00', '14.05', '295.03'),
(204, 73, 13, 6, '89.68', '0.00', '5.00', '26.90', '564.98'),
(205, 73, 12, 6, '165.63', '28.08', '5.00', '48.29', '1013.99'),
(206, 73, 17, 50, '14.13', '56.50', '0.00', '0.00', '650.00'),
(207, 74, 40, 920, '2.38', '138.00', '5.00', '102.58', '2154.18'),
(208, 75, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(209, 76, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(210, 76, 30, 24, '19.00', '0.00', '5.00', '22.80', '478.80'),
(211, 77, 39, 2, '43.65', '0.00', '5.00', '4.37', '91.67'),
(212, 77, 38, 2, '43.65', '0.00', '5.00', '4.37', '91.67'),
(213, 77, 37, 2, '43.65', '0.00', '5.00', '4.37', '91.67'),
(214, 77, 30, 6, '19.00', '0.00', '5.00', '5.70', '119.70'),
(219, 80, 17, 20, '14.13', '22.60', '0.00', '0.00', '260.00'),
(220, 81, 13, 10, '89.68', '0.00', '5.00', '44.84', '941.64'),
(221, 81, 17, 20, '14.13', '22.60', '0.00', '0.00', '260.00'),
(222, 78, 29, 72, '7.13', '0.00', '5.00', '25.67', '539.03'),
(223, 79, 13, 3, '89.68', '0.00', '5.00', '13.45', '282.49'),
(224, 79, 12, 3, '165.63', '14.04', '5.00', '24.14', '506.99'),
(225, 79, 17, 20, '14.13', '22.60', '0.00', '0.00', '260.00'),
(226, 82, 18, 48, '38.08', '0.00', '5.00', '91.39', '1919.23'),
(227, 82, 21, 24, '38.08', '0.00', '5.00', '45.70', '959.62'),
(228, 82, 36, 3, '0.00', '0.00', '5.00', '0.00', '0.00'),
(229, 83, 18, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(230, 83, 21, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(231, 83, 22, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(232, 83, 26, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(233, 83, 33, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(234, 83, 43, 2, '0.00', '0.00', '5.00', '0.00', '0.00'),
(235, 84, 28, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(236, 84, 18, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(237, 84, 25, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(238, 84, 36, 1, '0.00', '0.00', '5.00', '0.00', '0.00'),
(239, 85, 18, 24, '38.08', '0.00', '5.00', '45.70', '959.62'),
(240, 85, 22, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(241, 85, 25, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(242, 85, 33, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(243, 85, 26, 12, '38.08', '0.00', '5.00', '22.85', '479.81'),
(244, 85, 36, 3, '0.00', '0.00', '5.00', '0.00', '0.00'),
(245, 85, 29, 36, '7.13', '0.00', '5.00', '12.83', '269.51'),
(246, 86, 17, 100, '14.13', '113.00', '0.00', '0.00', '1300.00'),
(247, 87, 17, 240, '14.13', '391.20', '0.00', '0.00', '3000.00'),
(248, 88, 17, 20, '14.13', '22.60', '0.00', '0.00', '260.00'),
(249, 89, 34, 40, '7.94', '0.00', '5.00', '15.88', '333.48'),
(250, 90, 14, 10, '46.83', '0.00', '5.00', '23.42', '491.72'),
(251, 90, 13, 10, '89.68', '0.00', '5.00', '44.84', '941.64'),
(252, 90, 17, 20, '14.13', '22.60', '0.00', '0.00', '260.00'),
(253, 91, 29, 72, '7.13', '0.00', '5.00', '25.67', '539.03'),
(254, 92, 29, 12, '7.13', '0.00', '5.00', '4.28', '89.84'),
(255, 93, 37, 6, '43.65', '0.00', '5.00', '13.10', '275.00'),
(256, 93, 38, 3, '43.65', '0.00', '5.00', '6.55', '137.50'),
(257, 93, 39, 3, '43.65', '0.00', '5.00', '6.55', '137.50'),
(258, 94, 29, 12, '7.13', '0.00', '5.00', '4.28', '89.84'),
(259, 95, 37, 12, '43.65', '0.00', '5.00', '26.19', '549.99'),
(260, 95, 38, 12, '43.65', '0.00', '5.00', '26.19', '549.99'),
(261, 96, 12, 3, '165.63', '14.04', '5.00', '24.14', '506.99'),
(262, 96, 13, 3, '89.68', '0.00', '5.00', '13.45', '282.49'),
(263, 96, 17, 20, '14.13', '22.60', '0.00', '0.00', '260.00'),
(264, 97, 14, 6, '46.83', '0.00', '5.00', '14.05', '295.03'),
(265, 97, 13, 3, '89.68', '0.00', '5.00', '13.45', '282.49'),
(266, 98, 17, 10, '14.13', '11.30', '0.00', '0.00', '130.00'),
(267, 99, 16, 20, '15.87', '0.00', '5.00', '15.87', '333.27'),
(268, 99, 17, 50, '14.13', '56.50', '0.00', '0.00', '650.00'),
(269, 100, 17, 10, '14.13', '1.30', '0.00', '0.00', '140.00'),
(270, 101, 34, 40, '7.94', '0.00', '5.00', '15.88', '333.48'),
(271, 101, 17, 10, '14.13', '1.30', '0.00', '0.00', '140.00'),
(272, 101, 29, 12, '7.13', '0.00', '5.00', '4.28', '89.84'),
(273, 102, 14, 6, '46.83', '0.00', '5.00', '14.05', '295.03'),
(274, 102, 13, 6, '89.68', '0.00', '5.00', '26.90', '564.98'),
(275, 102, 12, 6, '165.63', '28.08', '5.00', '48.29', '1013.99'),
(276, 102, 34, 20, '7.94', '0.00', '5.00', '7.94', '166.74'),
(277, 102, 16, 10, '15.87', '0.00', '5.00', '7.94', '166.64'),
(278, 102, 17, 10, '15.00', '0.00', '0.00', '0.00', '150.00'),
(279, 103, 12, 3, '165.63', '14.04', '5.00', '24.14', '506.99'),
(280, 103, 14, 6, '46.83', '0.00', '5.00', '14.05', '295.03'),
(281, 103, 17, 20, '14.13', '0.00', '0.00', '0.00', '282.60'),
(282, 104, 30, 12, '19.00', '0.00', '5.00', '11.40', '239.40'),
(283, 105, 39, 2, '43.65', '3.96', '5.00', '4.17', '87.51'),
(284, 105, 38, 2, '43.65', '3.96', '5.00', '4.17', '87.51'),
(285, 105, 37, 2, '43.65', '3.96', '5.00', '4.17', '87.51'),
(286, 105, 29, 36, '7.13', '0.00', '5.00', '12.83', '269.51'),
(287, 106, 29, 24, '7.13', '0.00', '5.00', '8.56', '179.68'),
(288, 106, 31, 12, '15.83', '0.00', '5.00', '9.50', '199.46'),
(289, 107, 34, 40, '7.94', '0.00', '5.00', '15.88', '333.48'),
(290, 108, 17, 50, '14.13', '56.50', '0.00', '0.00', '650.00'),
(291, 109, 34, 40, '7.94', '0.00', '5.00', '15.88', '333.48'),
(292, 109, 17, 20, '14.13', '22.60', '0.00', '0.00', '260.00'),
(293, 110, 14, 10, '46.83', '0.00', '5.00', '23.42', '491.72'),
(294, 111, 39, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(295, 111, 38, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(296, 111, 37, 4, '43.65', '0.00', '5.00', '8.73', '183.33'),
(297, 112, 18, 6, '38.08', '0.00', '5.00', '11.42', '239.90'),
(298, 112, 22, 6, '38.08', '0.00', '5.00', '11.42', '239.90');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `retailer_id` int(11) NOT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `payment_date` date NOT NULL,
  `payment_type` enum('Partial Payment','Full Payment','Advance Payment','Credit Adjustment') COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` enum('Cash','UPI','Bank Transfer','Cheque','Card','NEFT','RTGS','IMPS') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `reference_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `collected_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `retailer_id`, `invoice_id`, `payment_date`, `payment_type`, `payment_method`, `amount`, `reference_number`, `remarks`, `created_at`, `collected_by`) VALUES
(2, 18, 7, '2026-07-15', 'Full Payment', 'Cash', '210.00', 'Cash', '', '2026-07-15 18:07:49', 15),
(3, 18, 7, '2026-07-15', 'Partial Payment', 'Cash', '0.04', '', '', '2026-07-15 18:08:49', 15),
(4, 11, NULL, '2026-07-15', 'Partial Payment', 'Cash', '185.00', 'Cash', '', '2026-07-15 18:09:39', 15),
(5, 8, 8, '2026-07-22', 'Full Payment', 'Cash', '724.50', '', '', '2026-07-22 05:31:41', 15),
(6, 15, 4, '2026-07-22', 'Full Payment', 'Cash', '189.00', '', '', '2026-07-22 07:10:12', 15),
(7, 16, 5, '2026-07-22', 'Full Payment', 'Bank Transfer', '189.00', '', '', '2026-07-22 07:13:04', 15),
(8, 10, 10, '2026-07-29', 'Full Payment', 'Cash', '504.00', '', '', '2026-07-29 08:02:12', 15),
(9, 12, 12, '2026-07-29', 'Full Payment', 'Cash', '441.00', '', '', '2026-07-29 08:02:41', 15),
(10, 9, 9, '2026-07-29', 'Full Payment', 'UPI', '347.00', '', '', '2026-07-29 08:03:22', 15),
(11, 37, NULL, '2026-07-29', 'Full Payment', 'Cash', '1038.56', '', '', '2026-07-29 08:10:38', 1),
(12, 36, 51, '2026-07-24', 'Full Payment', 'Cash', '141.17', '', '', '2026-07-29 08:11:35', 1),
(13, 35, 50, '2026-07-24', 'Full Payment', 'Cash', '141.17', '', '', '2026-07-29 08:12:13', 1),
(14, 31, NULL, '2026-07-30', 'Partial Payment', 'Cash', '682.54', '', '', '2026-07-30 11:57:01', 15),
(15, 24, NULL, '2026-07-30', 'Partial Payment', 'Cash', '252.00', '', '', '2026-07-30 11:57:11', 15),
(16, 20, 15, '2026-07-30', 'Partial Payment', 'Cash', '500.00', '', '', '2026-07-31 04:13:51', 1),
(17, 28, 23, '2026-08-01', 'Full Payment', 'Cash', '1008.00', '', '', '2026-08-01 12:41:42', 15),
(18, 23, 18, '2026-08-01', 'Partial Payment', 'Cash', '300.00', '', '', '2026-08-01 12:42:20', 15),
(19, 21, 16, '2026-08-01', 'Full Payment', 'Cash', '1008.00', '', '', '2026-08-01 12:43:19', 15),
(20, 19, 14, '2026-08-01', 'Full Payment', 'Cash', '504.00', '', '', '2026-08-01 12:43:47', 15),
(21, 50, 66, '2026-08-04', 'Full Payment', 'Cash', '689.00', '', '', '2026-08-04 13:32:17', 15),
(22, 47, 63, '2026-08-04', 'Full Payment', 'Cash', '616.54', '', '', '2026-08-04 13:32:43', 15),
(23, 29, 24, '2026-08-05', 'Full Payment', 'Cash', '1008.00', '', '', '2026-08-05 03:54:36', 15),
(24, 13, 13, '2026-08-05', 'Partial Payment', 'UPI', '717.00', '', '', '2026-08-05 12:24:41', 15),
(25, 17, 6, '2026-08-05', 'Full Payment', 'Cash', '1197.00', '', '', '2026-08-05 12:25:07', 15),
(26, 38, 53, '2026-08-08', 'Full Payment', 'Cash', '314.15', '', '', '2026-08-08 08:36:42', 1),
(27, 42, NULL, '2026-08-10', 'Partial Payment', 'Cash', '239.90', '', '', '2026-08-10 07:16:31', 15),
(28, 39, NULL, '2026-08-10', 'Partial Payment', 'Cash', '100.00', '', '', '2026-08-10 07:16:52', 15),
(29, 41, NULL, '2026-08-10', 'Partial Payment', 'Cash', '500.00', '', '', '2026-08-10 08:04:35', 15),
(30, 44, NULL, '2026-08-10', 'Partial Payment', 'Cash', '180.00', '', '', '2026-08-10 08:06:08', 15),
(31, 49, NULL, '2026-08-11', 'Partial Payment', 'Cash', '200.00', '', '', '2026-08-11 07:33:20', 15),
(32, 40, 55, '2026-08-11', 'Full Payment', 'Cheque', '3000.00', '', '', '2026-08-12 11:22:27', 1),
(33, 23, NULL, '2026-08-13', 'Partial Payment', 'Cash', '350.00', '', '', '2026-08-13 12:24:42', 15),
(34, 22, NULL, '2026-08-13', 'Partial Payment', 'UPI', '500.00', '', '', '2026-08-13 12:25:01', 15),
(35, 22, NULL, '2026-08-13', 'Partial Payment', 'Cash', '193.00', '', '', '2026-08-13 12:25:07', 15),
(36, 34, 81, '2026-08-15', 'Full Payment', 'Cash', '1125.18', '', '', '2026-08-15 07:00:22', 15),
(37, 20, 15, '2026-08-17', 'Partial Payment', 'UPI', '500.00', '', '', '2026-08-19 04:23:39', 1),
(38, 15, NULL, '2026-08-19', 'Partial Payment', 'Cash', '180.00', '', '', '2026-08-19 06:09:59', 15),
(39, 18, 85, '2026-08-19', 'Full Payment', 'Cash', '310.00', '', '', '2026-08-19 12:19:51', 1),
(40, 23, NULL, '2026-08-20', 'Partial Payment', 'Cash', '358.00', '', '', '2026-08-20 12:47:24', 15),
(41, 19, NULL, '2026-08-20', 'Partial Payment', 'UPI', '480.00', '', '', '2026-08-20 12:52:42', 15),
(42, 20, 15, '2026-08-20', 'Full Payment', 'Cash', '512.00', '', '', '2026-08-20 13:00:33', 15),
(43, 52, NULL, '2026-08-20', 'Partial Payment', 'Cash', '1500.00', '', '', '2026-08-20 13:36:27', 15),
(44, 26, NULL, '2026-08-20', 'Partial Payment', 'Cash', '500.00', '', '', '2026-08-20 13:37:02', 15),
(45, 24, NULL, '2026-08-20', 'Partial Payment', 'Cash', '300.00', '', '', '2026-08-20 13:37:38', 15),
(46, 55, 78, '2026-08-22', 'Partial Payment', 'Cash', '1000.00', '', '', '2026-08-22 13:44:38', 1),
(47, 26, 72, '2026-08-22', 'Full Payment', 'Cash', '460.00', '', '', '2026-08-22 13:45:06', 1),
(48, 25, 71, '2026-08-22', 'Partial Payment', 'Cash', '1200.00', '', '', '2026-08-22 13:46:07', 1),
(49, 46, 62, '2026-08-25', 'Full Payment', 'Cash', '1140.00', '', '', '2026-08-25 05:52:44', 1),
(50, 45, 61, '2026-08-25', 'Partial Payment', 'Cash', '300.00', '', '', '2026-08-25 06:04:32', 1),
(51, 43, 59, '2026-08-25', 'Full Payment', 'Cash', '180.00', '', '', '2026-08-25 06:05:43', 1),
(52, 41, 57, '2026-08-25', 'Full Payment', 'Cash', '639.00', '', '', '2026-08-25 06:21:38', 1),
(53, 48, 64, '2026-08-25', 'Full Payment', 'Cash', '130.00', '', '', '2026-08-25 07:19:33', 1),
(54, 51, 67, '2026-08-25', 'Partial Payment', 'UPI', '500.00', '', '', '2026-08-25 07:39:24', 1),
(55, 51, 67, '2026-08-25', 'Full Payment', 'Cash', '345.00', '', '', '2026-08-25 07:39:55', 1),
(56, 33, 86, '2026-08-23', 'Full Payment', 'Cash', '260.00', '', '', '2026-08-27 06:33:18', 1),
(57, 54, 76, '2026-08-29', 'Full Payment', 'UPI', '480.00', '', '', '2026-08-29 13:37:41', 1),
(58, 53, 77, '2026-08-29', 'Partial Payment', 'Cash', '2000.00', '', '', '2026-08-29 13:38:10', 1),
(59, 24, 70, '2026-08-29', 'Full Payment', 'Cash', '250.00', '', '', '2026-08-29 13:38:39', 1),
(60, 56, 79, '2026-08-31', 'Full Payment', 'Cash', '2723.00', '', '', '2026-08-31 06:27:33', 15),
(61, 49, NULL, '2026-08-31', 'Full Payment', 'Cash', '259.00', '', '', '2026-08-31 07:41:13', 15),
(62, 45, 61, '2026-08-31', 'Partial Payment', 'Cash', '300.00', '', '', '2026-08-31 07:43:13', 15),
(63, 16, 84, '2026-09-02', 'Full Payment', 'Cash', '1209.00', '', '', '2026-09-02 06:15:05', 15),
(64, 8, 68, '2026-09-02', 'Full Payment', 'Cash', '550.00', '', '', '2026-09-02 06:15:26', 15),
(65, 17, 69, '2026-09-02', 'Full Payment', 'Cash', '960.00', '', '', '2026-09-02 06:15:46', 15),
(66, 57, 83, '2026-09-04', 'Full Payment', 'Cash', '200.00', '', '', '2026-09-05 02:38:47', 15),
(67, 40, 87, '2026-09-04', 'Full Payment', 'Cheque', '2154.00', '', '', '2026-09-05 02:39:27', 15),
(68, 59, 92, '2026-09-05', 'Full Payment', 'Cash', '260.00', '', '', '2026-09-05 10:19:52', 15),
(69, 60, 88, '2026-09-05', 'Partial Payment', 'Cash', '1000.00', '', '', '2026-09-05 10:20:19', 15),
(70, 37, 93, '2026-09-05', 'Full Payment', 'Cash', '1202.00', '', '', '2026-09-05 10:20:41', 15),
(71, 52, 75, '2026-09-05', 'Partial Payment', 'Cash', '1500.00', '', '', '2026-09-05 12:15:31', 15),
(72, 53, 77, '2026-09-05', 'Partial Payment', 'Cash', '1000.00', '', '', '2026-09-05 12:16:02', 15),
(73, 45, 61, '2026-09-07', 'Full Payment', 'Cash', '360.00', '', '', '2026-09-07 07:19:49', 15),
(74, 25, 71, '2026-09-10', 'Partial Payment', 'Cash', '600.00', '', '', '2026-09-10 14:05:17', 15),
(75, 53, 77, '2026-09-10', 'Partial Payment', 'Cash', '1500.00', '', '', '2026-09-10 14:06:03', 15),
(76, 55, 78, '2026-09-10', 'Partial Payment', 'Cash', '1000.00', '', '', '2026-09-10 14:06:31', 15),
(77, 26, 94, '2026-09-10', 'Partial Payment', 'Cash', '500.00', '', '', '2026-09-10 14:06:51', 15),
(78, 27, 22, '2026-09-10', 'Partial Payment', 'Cash', '500.00', '', '', '2026-09-10 14:07:17', 15),
(79, 16, 91, '2026-09-17', 'Full Payment', 'Cash', '396.00', '', '', '2026-09-17 14:29:19', 15),
(80, 59, 82, '2026-09-18', 'Full Payment', 'UPI', '1144.00', '', '', '2026-09-18 07:24:29', 1),
(81, 34, 101, '2026-09-18', 'Full Payment', 'Cash', '260.00', '', '', '2026-09-18 10:33:22', 1),
(82, 34, 101, '2026-09-18', 'Full Payment', 'Cash', '260.00', '', '', '2026-09-18 10:33:22', 1),
(83, 60, 88, '2026-09-18', 'Full Payment', 'Cash', '1524.00', '', '', '2026-09-18 12:55:22', 1),
(84, 33, 80, '2026-09-18', 'Full Payment', 'Cash', '1229.00', '', '', '2026-09-18 12:56:22', 1),
(85, 16, 104, '2026-09-18', 'Full Payment', 'Cash', '90.00', '', '', '2026-09-18 13:15:35', 1),
(86, 18, 106, '2026-09-18', 'Full Payment', 'Cash', '90.00', '', '', '2026-09-18 13:29:42', 1),
(87, 25, 71, '2026-09-19', 'Full Payment', 'UPI', '1893.00', '', '', '2026-09-19 10:50:21', 1),
(88, 53, 77, '2026-09-19', 'Full Payment', 'Cash', '768.00', '', '', '2026-09-19 10:58:36', 1),
(89, 52, 75, '2026-09-19', 'Partial Payment', 'Cash', '1200.00', '', '', '2026-09-19 10:59:20', 1),
(90, 26, 94, '2026-09-19', 'Partial Payment', 'Cash', '300.00', '', '', '2026-09-19 11:19:35', 1),
(91, 39, 56, '2026-09-21', 'Partial Payment', 'Cash', '200.00', '', '', '2026-09-21 12:00:07', 15),
(92, 41, 96, '2026-09-21', 'Full Payment', 'Cash', '960.00', '', '', '2026-09-21 12:03:21', 15),
(93, 45, 97, '2026-09-21', 'Partial Payment', 'Cash', '600.00', '', '', '2026-09-21 13:16:34', 15),
(94, 56, NULL, '2026-09-22', 'Partial Payment', 'Cash', '1299.90', '', '', '2026-09-22 06:30:20', 15),
(95, 51, 108, '2026-09-22', 'Full Payment', 'Cash', '1050.00', '', '', '2026-09-22 11:24:44', 1),
(96, 50, NULL, '2026-09-22', 'Partial Payment', 'Cash', '129.94', '', '', '2026-09-22 13:09:33', 15),
(97, 12, 89, '2026-09-23', 'Full Payment', 'Cash', '180.00', '', '', '2026-09-23 08:18:35', 15),
(98, 15, 90, '2026-09-23', 'Full Payment', 'Cash', '658.00', '', '', '2026-09-23 08:19:03', 15),
(99, 26, 94, '2026-09-26', 'Partial Payment', 'Cash', '300.00', '', '', '2026-09-28 04:27:57', 1),
(100, 39, 56, '2026-09-28', 'Partial Payment', 'Cash', '200.00', '', '', '2026-09-28 11:59:30', 1),
(101, 45, 97, '2026-09-28', 'Partial Payment', 'Cash', '500.00', '', '', '2026-09-28 11:59:51', 1),
(102, 18, 116, '2026-09-29', 'Full Payment', 'Cash', '239.00', '', '', '2026-09-29 04:29:22', 1),
(103, 61, 112, '2026-09-29', 'Full Payment', 'Cash', '140.00', '', '', '2026-09-30 05:33:08', 1),
(104, 63, 111, '2026-09-29', 'Partial Payment', 'UPI', '500.00', '', '', '2026-09-30 05:33:35', 1),
(105, 49, 109, '2026-10-01', 'Full Payment', 'Cash', '578.00', '', '', '2026-10-01 13:20:18', 1),
(106, 59, 100, '2026-10-02', 'Partial Payment', 'Cash', '333.00', '', '', '2026-10-02 08:36:19', 1),
(107, 68, 124, '2026-10-02', 'Full Payment', 'Cash', '480.00', '', '', '2026-10-02 11:11:59', 1),
(108, 60, 120, '2026-10-02', 'Full Payment', 'UPI', '650.00', '', '', '2026-10-02 11:47:36', 15),
(109, 70, 121, '2026-10-02', 'Full Payment', 'Cash', '593.00', '', '', '2026-10-02 12:21:50', 1),
(110, 71, 125, '2026-10-04', 'Full Payment', 'Cash', '78.75', 'CS-PAID', 'Instant payment for Counter Sale CS-20261004-0001', '2026-10-04 12:00:45', 1),
(111, 71, 126, '2026-10-04', 'Full Payment', 'Cash', '188.33', 'CS-PAID', 'Instant payment for Counter Sale CS-20261004-0002', '2026-10-04 12:03:33', 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gst_percentage` decimal(5,2) DEFAULT 18.00,
  `hsn_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `brand_id`, `name`, `description`, `gst_percentage`, `hsn_code`, `image`, `status`, `created_at`) VALUES
(7, 5, 'COW GHEE', '', '5.00', '04059020', NULL, 'Active', '2026-07-13 01:39:43'),
(8, 5, 'APPALAM', '', '0.00', '19059040', NULL, 'Active', '2026-07-13 01:40:55'),
(9, 6, 'ZIPPER PACKS', '', '5.00', '33074100', NULL, 'Active', '2026-07-15 11:08:21'),
(10, 6, 'ECONOMY POUCHES', '', '5.00', '33074100', NULL, 'Active', '2026-07-15 11:12:08'),
(11, 6, 'REGULAR POUCH SERIES', '', '5.00', '33074100', NULL, 'Active', '2026-07-15 11:13:05'),
(12, 6, 'CUP DHOOP', '', '5.00', '33074100', NULL, 'Active', '2026-08-02 15:03:29'),
(13, 8, 'GINGER GARLIC PASTE', '', '5.00', '21039090', NULL, 'Active', '2026-08-02 15:31:05'),
(14, 8, 'TURMERIC POWDER', '', '5.00', '09103030', NULL, 'Active', '2026-08-02 15:32:10'),
(15, 8, 'TURMERIC POWDER SHEET', '', '5.00', '09042219', NULL, 'Active', '2026-08-02 15:32:48'),
(16, 6, 'JAR DHOOP', '', '5.00', '33074100', NULL, 'Active', '2026-09-21 04:48:40'),
(17, 6, 'CONE JAR', '', '5.00', '33074100', NULL, 'Active', '2026-09-21 04:49:05');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
  `supplier_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_invoice` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_date` date NOT NULL,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(12,2) DEFAULT 0.00,
  `gst_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `grand_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `supplier_name`, `supplier_invoice`, `purchase_date`, `subtotal`, `discount_amount`, `gst_amount`, `grand_total`, `remarks`, `created_at`) VALUES
(10, 'VINAYAKA SALES AND PERFUMARY', '22527', '2026-07-06', '49849.80', '0.00', '2492.49', '52342.29', '', '2026-07-26 06:44:15'),
(13, 'SHREE KRISHNA FOODS PVT LTD', '1692', '2026-07-09', '25980.20', '748.80', '1118.65', '26350.05', '', '2026-08-02 14:27:18'),
(14, 'VINAYAKA SALES AND PERFUMARY', '22648', '2026-07-27', '22055.52', '0.00', '1102.78', '23158.30', '', '2026-08-02 15:25:21'),
(15, 'SHREE KRISHNA FOODS PVT LTD', '2069', '2026-07-18', '16025.42', '1816.84', '281.67', '14490.25', '', '2026-08-02 15:27:11'),
(16, 'SHREE KRISHNA FOODS PVT LTD', '3151', '2026-09-17', '12604.40', '897.60', '299.50', '12006.30', '', '2026-09-18 07:43:44'),
(17, 'VINAYAKA SALES AND PERFUMARY', '22887', '2026-09-18', '26456.16', '240.00', '1310.81', '27526.97', '', '2026-09-21 05:00:13');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `id` int(11) NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `gst_percentage` decimal(5,2) NOT NULL,
  `gst_amount` decimal(10,2) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_items`
--

INSERT INTO `purchase_items` (`id`, `purchase_id`, `sku_id`, `quantity`, `purchase_price`, `discount_amount`, `gst_percentage`, `gst_amount`, `total_amount`) VALUES
(175, 13, 12, 60, '156.26', '300.00', '5.00', '453.78', '9529.38'),
(176, 13, 13, 80, '84.61', '0.00', '5.00', '338.44', '7107.24'),
(177, 13, 14, 80, '44.17', '0.00', '5.00', '176.68', '3710.28'),
(178, 13, 34, 200, '7.49', '0.00', '5.00', '74.90', '1572.90'),
(179, 13, 16, 100, '14.97', '0.00', '5.00', '74.85', '1571.85'),
(180, 13, 17, 240, '13.78', '448.80', '0.00', '0.00', '2858.40'),
(194, 10, 21, 120, '35.00', '0.00', '5.00', '210.00', '4410.00'),
(195, 10, 18, 120, '35.00', '0.00', '5.00', '210.00', '4410.00'),
(196, 10, 22, 120, '35.00', '0.00', '5.00', '210.00', '4410.00'),
(197, 10, 23, 120, '35.00', '0.00', '5.00', '210.00', '4410.00'),
(198, 10, 25, 120, '35.00', '0.00', '5.00', '210.00', '4410.00'),
(199, 10, 26, 120, '35.00', '0.00', '5.00', '210.00', '4410.00'),
(200, 10, 28, 120, '35.00', '0.00', '5.00', '210.00', '4410.00'),
(201, 10, 33, 120, '35.00', '0.00', '5.00', '210.00', '4410.00'),
(202, 10, 29, 960, '6.67', '0.00', '5.00', '320.16', '6723.36'),
(203, 10, 30, 300, '15.83', '0.00', '5.00', '237.45', '4986.45'),
(204, 10, 31, 180, '14.16', '0.00', '5.00', '127.44', '2676.24'),
(205, 10, 32, 180, '14.16', '0.00', '5.00', '127.44', '2676.24'),
(206, 10, 36, 84, '0.00', '0.00', '5.00', '0.00', '0.00'),
(215, 14, 18, 480, '35.00', '0.00', '5.00', '840.00', '17640.00'),
(216, 14, 37, 48, '38.08', '0.00', '5.00', '91.39', '1919.23'),
(217, 14, 38, 48, '38.08', '0.00', '5.00', '91.39', '1919.23'),
(218, 14, 39, 48, '33.33', '0.00', '5.00', '79.99', '1679.83'),
(219, 14, 43, 42, '0.00', '0.00', '5.00', '0.00', '0.00'),
(225, 15, 17, 480, '13.78', '897.60', '0.00', '0.00', '5716.80'),
(226, 15, 40, 1000, '2.36', '280.00', '5.00', '104.00', '2184.00'),
(227, 15, 41, 4, '881.83', '190.44', '5.00', '166.84', '3503.72'),
(228, 15, 42, 50, '4.33', '0.00', '5.00', '10.83', '227.33'),
(229, 15, 17, 240, '13.78', '448.80', '0.00', '0.00', '2858.40'),
(230, 16, 34, 400, '7.49', '0.00', '5.00', '149.80', '3145.80'),
(231, 16, 16, 200, '14.97', '0.00', '5.00', '149.70', '3143.70'),
(232, 16, 17, 480, '13.78', '897.60', '0.00', '0.00', '5716.80'),
(251, 17, 38, 48, '38.08', '80.00', '5.00', '87.39', '1835.23'),
(252, 17, 37, 48, '38.08', '80.00', '5.00', '87.39', '1835.23'),
(253, 17, 39, 48, '33.33', '80.00', '5.00', '75.99', '1595.83'),
(254, 17, 21, 120, '35.00', '0.00', '5.00', '210.00', '4410.00'),
(255, 17, 22, 96, '35.00', '0.00', '5.00', '168.00', '3528.00'),
(256, 17, 26, 120, '35.00', '0.00', '5.00', '210.00', '4410.00'),
(257, 17, 44, 96, '35.00', '0.00', '5.00', '168.00', '3528.00'),
(258, 17, 45, 96, '31.67', '0.00', '5.00', '152.02', '3192.34'),
(259, 17, 46, 96, '31.67', '0.00', '5.00', '152.02', '3192.34');

-- --------------------------------------------------------

--
-- Table structure for table `retailers`
--

CREATE TABLE `retailers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shop_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gst_number` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alternate_mobile` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `area` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Goa',
  `pin_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `google_map_link` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_type` enum('Distributor','Wholesaler','Retail Shop','Medical','Super Market','General Store') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Retail Shop',
  `created_by_staff_id` int(11) DEFAULT NULL,
  `assigned_staff_id` int(11) DEFAULT NULL,
  `credit_limit` decimal(12,2) DEFAULT 50000.00,
  `outstanding_amount` decimal(12,2) DEFAULT 0.00,
  `opening_balance` decimal(12,2) DEFAULT 0.00,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `is_special` tinyint(1) NOT NULL DEFAULT 0,
  `visit_frequency` enum('Daily','Weekly','Bi-Weekly','Monthly') COLLATE utf8mb4_unicode_ci DEFAULT 'Weekly',
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `retailers`
--

INSERT INTO `retailers` (`id`, `name`, `owner_name`, `shop_name`, `gst_number`, `mobile`, `alternate_mobile`, `email`, `address`, `area`, `city`, `state`, `pin_code`, `google_map_link`, `business_type`, `created_by_staff_id`, `assigned_staff_id`, `credit_limit`, `outstanding_amount`, `opening_balance`, `status`, `is_special`, `visit_frequency`, `remarks`, `created_at`) VALUES
(7, 'SANDEEP', '', 'SANDEEP KURANGI', 'AGSHSGSHAJA', '9740855487', '', '', 'MASTAMARDI', 'MASTAMARDI', 'Belagavi', 'Karnataka', '590020', '', 'Retail Shop', 1, 15, '50000.00', '0.00', '0.00', 'Inactive', 0, 'Weekly', '', '2026-07-13 14:47:25'),
(8, 'NEELAMBARI', '', 'SHRI NEELAMBARI KIRANA AND GENERAL STORE', '', '9481746646', '', '', 'MAHANTESH NAGAR', 'MAHANTESH NAGAR', 'BELAGAVI', 'Karnataka', '590016', '', 'Retail Shop', 1, 15, '10000.00', '549.98', '0.00', 'Active', 0, 'Weekly', '', '2026-07-15 10:43:36'),
(9, 'GURUPRASAD', '', 'GURUPRASAD KIRANA STORE', '', '9902435249', '', '', 'MAHANTESH NAGAR', 'MAHANTESH NAGAR', 'BELAGAVI', 'Karnataka', '590016', '', 'Retail Shop', 1, 15, '10000.00', '-0.50', '0.00', 'Active', 0, 'Weekly', '', '2026-07-15 10:45:20'),
(10, 'PATIL', '', 'PATIL GENERAL STORES', '', '7353073690', '', '', 'MAHANTESH NAGAR', 'MAHANTESH NAGAR', 'BELAGAVI', 'Karnataka', '590016', '', 'Retail Shop', 1, 15, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-15 10:46:50'),
(11, 'ANJANEYA', '', 'ANJANEYA GENERAL STORES', '', '9449883567', '', '', 'MAHANTESH NAGAR', 'MAHANTESH NAGAR', 'BELAGAVI', 'Karnataka', '590016', '', 'Retail Shop', 1, 15, '10000.00', '4.00', '0.00', 'Inactive', 0, 'Weekly', '', '2026-07-15 10:48:29'),
(12, 'DURGA', '', 'DURGA GENERAL STORES', '', '8431859577', '', '', 'MAHANTESH NAGAR, BELAGAVI.', 'MAHANTESH NAGAR', 'BELAGAVI', 'Karnataka', '590016', '', 'Retail Shop', 1, 15, '1000.00', '-0.32', '0.00', 'Active', 0, 'Weekly', '', '2026-07-15 10:50:52'),
(13, 'HARSH', '', 'HARSH ENTERPRISE', '', '9741660617', '', '', 'AUTO NAGAR', 'AUTO NAGAR', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, 15, '10000.00', '480.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-15 10:53:31'),
(14, 'SATVIK', '', 'SATVIK GENERAL STORES', '', '9986646323', '', '', 'AUTO NAGAR', 'AUTO NAGAR', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, 15, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-15 10:54:52'),
(15, 'MAHAKALI', '', 'MAHAKALI GENRAL STORES', '', '8792268532', '', '', 'AUTO NAGAR', 'AUTO NAGAR', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, 15, '10000.00', '0.16', '0.00', 'Active', 0, 'Weekly', '', '2026-07-15 10:56:03'),
(16, 'SIDDHAROODHA', '', 'SIDDHAROODHA KIRANA STORE', '', '8904369204', '', '', 'AUTO NAGAR', 'AUTO NAGAR', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, 15, '10000.00', '-1.14', '0.00', 'Active', 0, 'Weekly', '', '2026-07-15 10:58:15'),
(17, 'MAHALAKSHMI', '', 'MAHALAXMI GENERAL STORES', '', '6360866572', '', '', 'KANBARGI', 'KANBARGI', 'BELAGAVI', 'Karnataka', '590015', '', 'Retail Shop', 1, 15, '10000.00', '-0.38', '0.00', 'Active', 0, 'Weekly', '', '2026-07-15 11:00:16'),
(18, 'VEERABHADRESHWAR', '', 'VEERA BHADRESHWAR ENTERPRISE', '', '6360804413', '', '', 'MAHANTESH NAGAR', 'MAHANTESH NAGAR', 'BELAGAVI', 'Karnataka', '590016', '', 'Retail Shop', 1, 15, '10000.00', '-0.08', '0.00', 'Active', 0, 'Weekly', '', '2026-07-15 11:02:31'),
(19, 'SHRI', '', 'SHRI  GENERAL STORES', '', '8073547099', '', '', 'RAVIWAR PETH BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '-0.19', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 05:59:14'),
(20, 'SIDDHI', '', 'SIDDHI GENERAL STORES', '', '9036251805', '', '', 'RAVIWAR PETH', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '1274.18', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 06:03:17'),
(21, 'KIRAN', '', 'KIRAN PATIL STORES', '', '8861855870', '', '', 'RAVIWAR PETH,BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 09:11:47'),
(22, 'BELAGAONKAR', '', 'BELAGAONKAR  GENERAL STORES', '', '9036250450', '', '', 'RAVIWAR PETH, BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 09:14:26'),
(23, 'ANAND', '', 'ANAND MASALA STORE', '', '9886413800', '', '', 'RAVIWAR PETH, BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 09:15:37'),
(24, 'P R', '', 'P R PALAKAR', '', '8880996962', '', '', 'RAVIWAR PETH, BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '-0.01', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 09:16:58'),
(25, 'PATTANSHETTY', '', 'PATTANSHETTY GENERAL STORES', '', '8147400972', '', '', 'RAVIWAR PETH, BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '2399.16', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 09:18:35'),
(26, 'D A', '', 'D A ATTARA', '', '9035516380', '', '', 'RAVIWAR PETH, BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '1778.47', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 09:21:17'),
(27, 'PANKAJ', '', 'PANKAJ COCONUT STORE', '', '8105000379', '', '', 'RAVIWAR PETH, BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '508.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 09:24:45'),
(28, 'M ANGOLKAR', '', 'M. ANGOLKAR AND  SONS', '', '9986611812', '', '', 'RAVIWAR PETH, BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 09:26:55'),
(29, 'RAVALNATH', '', 'RAVALNATH TRADERS', '', '8884541349', '', '', 'RAVIWAR PETH, BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 09:28:14'),
(31, 'ARVIND', '', 'ARVIND ENTERPRISE', '', '9448542631', '', '', 'RAVIWAR PETH, BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, 15, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-16 09:29:41'),
(32, 'MARUTI', '', 'MARUTI GENERAL STORES', '', '9901785608', '', '', 'S C MOTORS , SAMBRA ROAD , BELAGAVI.', 'S C MOTORS', 'BELAGAVI59', 'Karnataka', '591124', '', 'Retail Shop', 1, 15, '10000.00', '0.00', '0.00', 'Inactive', 0, 'Weekly', '', '2026-07-18 02:58:34'),
(33, 'CHANDRAKANTH', '', 'CHANDRAKANTH V SAJJAN GENRAL STORES', '', '9035398435', '', '', 'S C MOTORS , SAMBRA ROAD , BELAGAVI', 'S C MOTORS', 'BELAGAVI', 'Karnataka', '591124', '', 'Retail Shop', 1, 15, '10000.00', '539.16', '0.00', 'Active', 0, 'Weekly', '', '2026-07-18 03:01:19'),
(34, 'MAHALAKSHMI', '', 'MAHALAXMI GENERAL STORES', '', '7483677806', '', '', 'SHINDOLLI, BELAGAVI', 'SHINDOLLI', 'BELAGAVI', 'Karnataka', '591124', '', 'Retail Shop', 1, 15, '10000.00', '-260.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-18 03:03:10'),
(35, 'ANNAPURNESHWARI', '', 'ANNAPURNESHWARI SUPER MARKET', '', '9845391598', '', '', 'SHINDOLLI , NILAJI.', 'NILAJI', 'BELAGAVI', 'Karnataka', '591124', '', 'Retail Shop', 1, NULL, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-07-24 04:33:56'),
(36, 'SUPRIYA', '', 'SUPRIYA GENERAL STORES', '', '7892553547', '', '', 'NILAJI.', 'NILAJI CROSS', 'BELAGAVI', 'Karnataka', '591124', '', 'Retail Shop', 1, NULL, '10000.00', '0.00', '0.00', 'Inactive', 0, 'Weekly', '', '2026-07-24 04:35:22'),
(37, 'MAHADEV', '', 'SHRI MAHADEV GENERAL STORES', '', '9845861069', '', '', 'SAMBRA', 'SAMBRA', 'BELAGAVI', 'Karnataka', '591124', '', 'Retail Shop', 1, NULL, '10000.00', '-0.36', '0.00', 'Active', 0, 'Weekly', '', '2026-07-24 04:36:56'),
(38, 'TUKARAM', '', 'MANGAI GENRAL STORES', '', '9380879713', '', '', 'SHINDOLLI.', 'SHINDOLLI BUS STOP', 'BELAGAVI', 'Karnataka', '591124', '', 'Retail Shop', 1, NULL, '10000.00', '0.00', '0.00', 'Inactive', 0, 'Weekly', '', '2026-07-24 04:38:38'),
(39, 'SAI', '', 'SAI PAN SHOP', '', '6366647754', '', '', 'KHADE BAZAR, BELAGAVI', 'NAVDEEP HOSPITAL', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '459.62', '0.00', 'Active', 0, 'Weekly', '', '2026-07-27 14:52:53'),
(40, 'BASAVESHWAR', '', 'BASAVESHWAR TRADERS', '29BDRPK1100Q1Z5', '9164208686', '', '', 'SULEBHAVI.', 'MARIHAL POLICE STATION', 'BELAGAVI', 'Karnataka', '591124', '', 'Retail Shop', 1, NULL, '10000.00', '3000.18', '0.00', 'Active', 0, 'Weekly', '', '2026-07-31 05:36:32'),
(41, 'REVAN', '', 'SHRI REVENSIDDESHWAR TRADERS', '', '8050139450', '', '', 'OPPOSITE TO NAVDEEP HOSPITAL, KADEBAZAR', 'NAVDEEP HOSPITAL', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '9999.75', '-0.09', '0.00', 'Active', 0, 'Weekly', '', '2026-08-03 05:03:36'),
(42, 'G V PATIL', '', 'G V PATIL', '', '9886869093', '', '', 'OPPOSITE TO NAVDEEP HOSPITAL KADEBAZAR', 'NAVDEEP HOSPITAL', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-08-03 05:05:19'),
(43, 'SHRIDHAR', '', 'SHRIDHAR GENERAL STORES', '', '9480786529', '', '', 'KADAK GALLI KADEBAZAR', 'KOTWAL GALLI', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '-0.32', '0.00', 'Active', 0, 'Weekly', '', '2026-08-03 05:08:04'),
(44, 'IRSHAD', '', 'IRSHAD GENERAL STORES', '', '000000000', '', '', 'DARBAR GALLI KADEBAZAR', 'DARBAR GALLI', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '-0.32', '0.00', 'Active', 0, 'Weekly', '', '2026-08-03 05:10:38'),
(45, 'SAMIVOOLA', '', 'SAMIVOOLA GENERAL STORES', '', '9880495513', '', '', 'KOTWAL GALLI KADE BAZAR', 'KOTWAL GALLI', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '2047.98', '0.00', 'Active', 0, 'Weekly', '', '2026-08-03 05:13:00'),
(46, 'SAJIYA', '', 'SAJIYA GENERAL STORES', '', '8147444873', '', '', 'CBT BUS STOP KADE BAZAR', 'KADE BAZAR', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '-0.71', '0.00', 'Active', 0, 'Weekly', '', '2026-08-03 05:14:36'),
(47, 'chopade', '', 'CHOPADE STORES', '', '000000000', '', '', 'GANESHPUR', 'PETROL PUMP', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-08-04 05:57:59'),
(48, 'shridhar', '', 'Shridhar General store', '', '00000000', '', '', 'GANESHPUR', 'GANESHPUR', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-08-04 09:05:53'),
(49, 'SUNIL', '', 'SUNIL GENERAL STORES', '', '9480312831', '', '', 'GANESHPUR', 'GANESHPUR', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '333.46', '0.00', 'Active', 0, 'Weekly', '', '2026-08-04 09:06:53'),
(50, 'krishna', '', 'KRISHNA GENERAL STORES', '', '8105275478', '', '', 'GANESHPUR', 'GANESHPUR', 'BELAGAVI', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-08-04 09:08:53'),
(51, 'SHRI', '', 'SHRI JYOTIRLING GENERAL STORES', '', '9886256493', '', '', 'HINDALGA', 'HINDALGA', 'BELAGAVI', 'Karnataka', '591108', '', 'Retail Shop', 1, NULL, '10000.00', '1083.75', '0.00', 'Active', 0, 'Weekly', '', '2026-08-04 09:12:32'),
(52, 'P L KAWALE', '', 'P L KAWALE', '29ANAPK6216D1ZA', '9449650960', '', '', 'RAVIWAR PETH BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, NULL, '10000.00', '1288.43', '0.00', 'Active', 0, 'Weekly', '', '2026-08-06 08:16:59'),
(53, 'V B', '', 'V B SIDDANNAVAR', '', '9482636034', '', '', 'RAVIWAR PETH', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, NULL, '10000.00', '1100.29', '0.00', 'Active', 0, 'Weekly', '', '2026-08-06 08:19:20'),
(54, 'PRAVEEN', '', 'PRAVEEN PAWAR COCONUT', '', '000000000', '', '', 'RAVIWAR PETH BELAGAVI', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, NULL, '10000.00', '-0.19', '0.00', 'Inactive', 0, 'Weekly', '', '2026-08-06 08:20:45'),
(55, 'R M', '', 'R M ANGOLKAR', '29AIRPA1081A1ZM', '9886233068', '', '', 'RAVIWAR PETH', 'RAVIWAR PETH', 'BELAGAVI', 'Karnataka', '590002', '', 'Retail Shop', 1, NULL, '10000.00', '860.20', '0.00', 'Active', 0, 'Weekly', '', '2026-08-06 08:22:36'),
(56, 'SIDDHI', '', 'SIDDHI VINAYAKA GENERAL STORES', '', '9148702604', '', '', 'GANESHPUR', 'PETROL PUMP', 'BELAGAVI', 'Karnataka', '591108', '', 'Retail Shop', 1, NULL, '10000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-08-11 03:24:17'),
(57, 'BHARATI', '', 'BHARATI GENERAL STORES', '', '8668313815', '', '', 'SHINDOLLI', 'BUS  STOP', 'BELAGAVI', 'Karnataka', '591124', '', 'Retail Shop', 1, NULL, '10000.00', '-0.54', '0.00', 'Active', 0, 'Weekly', '', '2026-08-15 04:29:32'),
(59, 'JAIRAJ', '', 'JAIRAJ RETAILS', '', '9738682397', '', '', 'SAMBRA', 'SAMBRA', 'BELAGAVI', 'Karnataka', '591124', '', 'Retail Shop', 1, NULL, '10000.01', '492.19', '0.00', 'Active', 0, 'Weekly', '', '2026-08-15 04:30:53'),
(60, 'chandrakant', '', 'CHANDRAKANTH GENERAL STORES', '', '7892534013', '', '', 'BALEKUNDRI CROSS .', 'BALEKUNDRI', 'BELAGAVI', 'Karnataka', '591124', '', 'Retail Shop', 1, NULL, '10000.00', '1693.36', '0.00', 'Active', 0, 'Weekly', '', '2026-08-23 01:32:22'),
(61, 'Akunti', '', 'Akunti General store', '', '8880807277', '', '', 'Ganehspur', 'GANESHPUR', 'Belagavi', 'Karnataka', '591108', '', 'Retail Shop', 15, NULL, '50000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-09-22 09:16:41'),
(62, 'Venkatesh', '', 'VENKATESHWAR CO OPERATIVE POWER LTD', '29AABAV8504E1ZF', '7795116558', '', '', 'GANESHPUR.', 'Main road GANESHPUR', 'Belagavi', 'Karnataka', '591108', '', 'Super Market', 15, NULL, '50000.00', '2357.37', '0.00', 'Active', 0, 'Weekly', '', '2026-09-22 09:19:46'),
(63, 'C G Kadolkar', '', 'C G Kadolkar kirana store', '', '6360194495', '', '', 'Hindalga', 'Hindalga', 'Belagavi', 'Karnataka', '591108', '', 'Retail Shop', 15, NULL, '50000.00', '483.27', '0.00', 'Active', 0, 'Weekly', '', '2026-09-22 09:21:02'),
(64, 'mourya', '', 'MOURYA GENERAL STORES', '', '00', '', '', 'Hindalga', 'Hindalga', 'Belagavi', 'Karnataka', '591108', '', 'Retail Shop', 15, NULL, '50000.00', '563.32', '0.00', 'Active', 0, 'Weekly', '', '2026-09-22 09:22:25'),
(65, 'Mark', '', 'Mark General store', '', '8147413544', '', '', 'Hindalga', 'Hindalga', 'Belagavi', 'Karnataka', '591108', '', 'Retail Shop', 15, NULL, '50000.00', '0.00', '0.00', 'Active', 0, 'Weekly', '', '2026-09-22 09:23:15'),
(66, 'M G', '', 'M G PAN SHOP', '', '7353186307', '', '', 'MAHATESH NAGAR BELAGAVI', 'Mahatesh Nagar', 'Belagavi', 'Karnataka', '590016', '', 'Retail Shop', 15, NULL, '50000.00', '532.04', '0.00', 'Active', 0, 'Weekly', '', '2026-09-23 10:44:41'),
(67, 'khusro', '', 'KHUSRO GENERAL STORES', '', '9980612013', '', '', 'Mahantesh Nagar Belagavi', 'Mahantesh Nagar', 'Belagavi', 'Karnataka', '590016', '', 'Retail Shop', 15, NULL, '50000.00', '379.13', '0.00', 'Active', 0, 'Weekly', '', '2026-09-23 10:46:30'),
(68, 'Shri', '', 'shri veerabhadreshwar General Store', '', '9113575524', '', '', 'AUTO NAGAR BELAGAVI', 'Bus stop', 'Belagavi', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '-0.19', '0.00', 'Active', 0, 'Weekly', '', '2026-10-02 08:53:28'),
(69, 'parvati', '', 'Shiv Parvati General Store', '', '8431603951', '', '', 'Auto Nagar Belagavi', 'Auto nagar', 'Belagavi', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '549.99', '0.00', 'Active', 1, 'Weekly', '', '2026-10-02 08:55:00'),
(70, 'Maruti', '', 'Maruti General Store', '', '8088819039', '', '', 'Modaga , Belagavi', 'Bus Stop', 'Belagavi', 'Karnataka', '590001', '', 'Retail Shop', 1, NULL, '10000.00', '0.48', '0.00', 'Active', 0, 'Weekly', '', '2026-10-02 08:56:29'),
(71, 'Walk-in Customer', NULL, 'Counter Sale (Walk-in / Public)', NULL, '9999999999', NULL, NULL, 'Store Counter', 'Counter', 'Goa', 'Goa', '403001', NULL, 'Retail Shop', NULL, NULL, '9999999.00', '0.00', '0.00', 'Active', 0, 'Weekly', 'System account for Walk-in and Counter Sales', '2026-10-04 12:00:45');

-- --------------------------------------------------------

--
-- Table structure for table `retailer_timeline`
--

CREATE TABLE `retailer_timeline` (
  `id` int(11) NOT NULL,
  `retailer_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `visit_date` date NOT NULL,
  `visit_status` enum('Visited - Order Taken','Visited - No Order','Visited - Payment Collected','Called Retailer','Closed') COLLATE utf8mb4_unicode_ci DEFAULT 'Visited - No Order',
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_lat` decimal(10,8) DEFAULT NULL,
  `location_lng` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `retailer_timeline`
--

INSERT INTO `retailer_timeline` (`id`, `retailer_id`, `staff_id`, `visit_date`, `visit_status`, `remarks`, `location_lat`, `location_lng`, `created_at`) VALUES
(4, 7, 15, '2026-07-13', 'Visited - Order Taken', 'Placed Order ID: 3. Total: ₹1,866.57', NULL, NULL, '2026-07-13 14:49:21'),
(5, 8, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 4. Total: ₹724.50', NULL, NULL, '2026-07-15 11:50:54'),
(6, 9, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 5. Total: ₹346.50', NULL, NULL, '2026-07-15 11:52:05'),
(7, 10, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 6. Total: ₹504.00', NULL, NULL, '2026-07-15 11:54:28'),
(8, 11, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 7. Total: ₹189.00', NULL, NULL, '2026-07-15 11:55:11'),
(9, 12, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 8. Total: ₹441.00', NULL, NULL, '2026-07-15 11:56:38'),
(10, 13, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 9. Total: ₹1,197.00', NULL, NULL, '2026-07-15 11:58:47'),
(11, 14, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 10. Total: ₹94.50', NULL, NULL, '2026-07-15 12:00:00'),
(12, 15, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 11. Total: ₹189.00', NULL, NULL, '2026-07-15 12:00:48'),
(13, 16, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 12. Total: ₹189.00', NULL, NULL, '2026-07-15 12:01:34'),
(14, 17, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 13. Total: ₹1,197.00', NULL, NULL, '2026-07-15 12:03:33'),
(15, 18, 15, '2026-07-15', 'Visited - Order Taken', 'Placed Order ID: 14. Total: ₹210.04', NULL, NULL, '2026-07-15 12:04:21'),
(16, 18, 15, '2026-07-15', 'Visited - Payment Collected', 'Collected payment of ₹210.00 via Cash.', NULL, NULL, '2026-07-15 18:07:49'),
(17, 18, 15, '2026-07-15', 'Visited - Payment Collected', 'Collected payment of ₹0.04 via Cash.', NULL, NULL, '2026-07-15 18:08:49'),
(18, 11, 15, '2026-07-15', 'Visited - Payment Collected', 'Collected payment of ₹185.00 via Cash.', NULL, NULL, '2026-07-15 18:09:39'),
(19, 19, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 15. Total: ₹504.00', NULL, NULL, '2026-07-16 09:33:49'),
(20, 20, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 16. Total: ₹1,512.00', NULL, NULL, '2026-07-16 09:42:19'),
(21, 21, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 17. Total: ₹1,008.00', NULL, NULL, '2026-07-16 09:43:23'),
(22, 22, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 18. Total: ₹693.00', NULL, NULL, '2026-07-16 09:44:45'),
(23, 23, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 19. Total: ₹1,008.00', NULL, NULL, '2026-07-16 09:46:37'),
(24, 24, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 20. Total: ₹252.00', NULL, NULL, '2026-07-16 09:48:50'),
(25, 25, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 21. Total: ₹1,008.00', NULL, NULL, '2026-07-16 09:55:23'),
(26, 26, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 22. Total: ₹1,008.00', NULL, NULL, '2026-07-16 09:56:01'),
(27, 27, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 23. Total: ₹1,008.00', NULL, NULL, '2026-07-16 09:57:47'),
(28, 28, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 24. Total: ₹1,008.00', NULL, NULL, '2026-07-16 10:00:25'),
(29, 29, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 25. Total: ₹1,008.00', NULL, NULL, '2026-07-16 10:01:43'),
(30, 31, 15, '2026-07-16', 'Visited - Order Taken', 'Placed Order ID: 26. Total: ₹682.54', NULL, NULL, '2026-07-16 10:03:45'),
(31, 8, 15, '2026-07-22', 'Visited - Payment Collected', 'Collected payment of ₹724.50 via Cash.', NULL, NULL, '2026-07-22 05:31:41'),
(32, 15, 15, '2026-07-22', 'Visited - Payment Collected', 'Collected payment of ₹189.00 via Cash.', NULL, NULL, '2026-07-22 07:10:12'),
(33, 16, 15, '2026-07-22', 'Visited - Payment Collected', 'Collected payment of ₹189.00 via Bank Transfer.', NULL, NULL, '2026-07-22 07:13:04'),
(34, 35, 15, '2026-07-24', 'Visited - Order Taken', 'Placed Order ID: 27. Total: ₹141.17', NULL, NULL, '2026-07-24 04:49:32'),
(35, 36, 15, '2026-07-24', 'Visited - Order Taken', 'Placed Order ID: 28. Total: ₹141.17', NULL, NULL, '2026-07-24 04:51:52'),
(36, 37, 15, '2026-07-24', 'Visited - Order Taken', 'Placed Order ID: 29. Total: ₹1,038.56', NULL, NULL, '2026-07-24 05:02:48'),
(37, 38, 15, '2026-07-24', 'Visited - Order Taken', 'Placed Order ID: 30. Total: ₹314.15', NULL, NULL, '2026-07-24 05:04:45'),
(38, 10, 15, '2026-07-29', 'Visited - Payment Collected', 'Collected payment of ₹504.00 via Cash.', NULL, NULL, '2026-07-29 08:02:12'),
(39, 12, 15, '2026-07-29', 'Visited - Payment Collected', 'Collected payment of ₹441.00 via Cash.', NULL, NULL, '2026-07-29 08:02:41'),
(40, 9, 15, '2026-07-29', 'Visited - Payment Collected', 'Collected payment of ₹347.00 via UPI.', NULL, NULL, '2026-07-29 08:03:22'),
(41, 15, 15, '2026-07-29', 'Visited - Order Taken', 'Placed Order ID: 31. Total: ₹179.68', NULL, NULL, '2026-07-29 11:52:02'),
(42, 31, 15, '2026-07-30', 'Visited - Payment Collected', 'Collected payment of ₹682.54 via Cash.', NULL, NULL, '2026-07-30 11:57:01'),
(43, 24, 15, '2026-07-30', 'Visited - Payment Collected', 'Collected payment of ₹252.00 via Cash.', NULL, NULL, '2026-07-30 11:57:11'),
(44, 40, 15, '2026-07-31', 'Visited - Order Taken', 'Placed Order ID: 32. Total: ₹3,389.57', NULL, NULL, '2026-07-31 05:37:56'),
(45, 40, 15, '2026-07-31', 'Visited - Order Taken', 'Placed Order ID: 33. Total: ₹3,389.57', NULL, NULL, '2026-07-31 05:41:53'),
(46, 28, 15, '2026-08-01', 'Visited - Payment Collected', 'Collected payment of ₹1,008.00 via Cash.', NULL, NULL, '2026-08-01 12:41:42'),
(47, 23, 15, '2026-08-01', 'Visited - Payment Collected', 'Collected payment of ₹300.00 via Cash.', NULL, NULL, '2026-08-01 12:42:20'),
(48, 21, 15, '2026-08-01', 'Visited - Payment Collected', 'Collected payment of ₹1,008.00 via Cash.', NULL, NULL, '2026-08-01 12:43:19'),
(49, 19, 15, '2026-08-01', 'Visited - Payment Collected', 'Collected payment of ₹504.00 via Cash.', NULL, NULL, '2026-08-01 12:43:47'),
(50, 39, 15, '2026-08-02', 'Visited - Order Taken', 'Placed Order ID: 34. Total: ₹3,248.27', NULL, NULL, '2026-08-02 12:29:48'),
(51, 39, 15, '2026-08-02', 'Visited - Order Taken', 'Placed Order ID: 35. Total: ₹2,625.00', NULL, NULL, '2026-08-02 12:48:39'),
(52, 40, 15, '2026-08-02', 'Visited - Order Taken', 'Placed Order ID: 36. Total: ₹3,000.00', NULL, NULL, '2026-08-02 14:37:52'),
(53, 39, 15, '2026-08-03', 'Visited - Order Taken', 'Placed Order ID: 37. Total: ₹959.62', NULL, NULL, '2026-08-03 05:34:04'),
(54, 41, 15, '2026-08-03', 'Visited - Order Taken', 'Placed Order ID: 38. Total: ₹1,139.29', NULL, NULL, '2026-08-03 05:36:50'),
(55, 42, 15, '2026-08-03', 'Visited - Order Taken', 'Placed Order ID: 39. Total: ₹239.90', NULL, NULL, '2026-08-03 05:37:41'),
(56, 43, 15, '2026-08-03', 'Visited - Order Taken', 'Placed Order ID: 40. Total: ₹179.68', NULL, NULL, '2026-08-03 05:38:51'),
(57, 44, 15, '2026-08-03', 'Visited - Order Taken', 'Placed Order ID: 41. Total: ₹179.68', NULL, NULL, '2026-08-03 05:40:07'),
(58, 45, 15, '2026-08-03', 'Visited - Order Taken', 'Placed Order ID: 42. Total: ₹959.62', NULL, NULL, '2026-08-03 05:40:51'),
(59, 46, 15, '2026-08-03', 'Visited - Order Taken', 'Placed Order ID: 43. Total: ₹1,139.29', NULL, NULL, '2026-08-03 05:42:11'),
(60, 47, 15, '2026-08-04', 'Visited - Order Taken', 'Placed Order ID: 44. Total: ₹616.54', NULL, NULL, '2026-08-04 09:44:20'),
(61, 48, 15, '2026-08-04', 'Visited - Order Taken', 'Placed Order ID: 45. Total: ₹130.00', NULL, NULL, '2026-08-04 09:44:58'),
(62, 49, 15, '2026-08-04', 'Visited - Order Taken', 'Placed Order ID: 46. Total: ₹459.46', NULL, NULL, '2026-08-04 09:52:30'),
(63, 50, 15, '2026-08-04', 'Visited - Order Taken', 'Placed Order ID: 47. Total: ₹688.94', NULL, NULL, '2026-08-04 09:56:01'),
(64, 51, 15, '2026-08-04', 'Visited - Order Taken', 'Placed Order ID: 48. Total: ₹844.65', NULL, NULL, '2026-08-04 09:58:00'),
(65, 50, 15, '2026-08-04', 'Visited - Payment Collected', 'Collected payment of ₹689.00 via Cash.', NULL, NULL, '2026-08-04 13:32:17'),
(66, 47, 15, '2026-08-04', 'Visited - Payment Collected', 'Collected payment of ₹616.54 via Cash.', NULL, NULL, '2026-08-04 13:32:43'),
(67, 29, 15, '2026-08-05', 'Visited - Payment Collected', 'Collected payment of ₹1,008.00 via Cash.', NULL, NULL, '2026-08-05 03:54:36'),
(68, 8, 15, '2026-08-05', 'Visited - Order Taken', 'Placed Order ID: 49. Total: ₹549.99', NULL, NULL, '2026-08-05 05:51:05'),
(69, 17, 15, '2026-08-05', 'Visited - Order Taken', 'Placed Order ID: 50. Total: ₹959.62', NULL, NULL, '2026-08-05 08:08:13'),
(70, 13, 15, '2026-08-05', 'Visited - Payment Collected', 'Collected payment of ₹717.00 via UPI.', NULL, NULL, '2026-08-05 12:24:41'),
(71, 17, 15, '2026-08-05', 'Visited - Payment Collected', 'Collected payment of ₹1,197.00 via Cash.', NULL, NULL, '2026-08-05 12:25:07'),
(72, 24, 15, '2026-08-06', 'Visited - Order Taken', 'Placed Order ID: 51. Total: ₹549.99', NULL, NULL, '2026-08-06 06:32:15'),
(73, 25, 15, '2026-08-06', 'Visited - Order Taken', 'Placed Order ID: 52. Total: ₹3,693.12', NULL, NULL, '2026-08-06 06:40:49'),
(74, 26, 15, '2026-08-06', 'Visited - Order Taken', 'Placed Order ID: 53. Total: ₹959.62', NULL, NULL, '2026-08-06 06:46:11'),
(75, 19, 15, '2026-08-06', 'Visited - Order Taken', 'Placed Order ID: 54. Total: ₹479.81', NULL, NULL, '2026-08-06 08:09:51'),
(76, 20, 15, '2026-08-06', 'Visited - Order Taken', 'Placed Order ID: 55. Total: ₹1,274.18', NULL, NULL, '2026-08-06 08:11:41'),
(77, 52, 15, '2026-08-06', 'Visited - Order Taken', 'Placed Order ID: 56. Total: ₹5,488.43', NULL, NULL, '2026-08-06 08:39:40'),
(78, 54, 15, '2026-08-06', 'Visited - Order Taken', 'Placed Order ID: 57. Total: ₹479.81', NULL, NULL, '2026-08-06 08:40:41'),
(79, 53, 15, '2026-08-06', 'Visited - Order Taken', 'Placed Order ID: 58. Total: ₹5,268.31', NULL, NULL, '2026-08-06 08:50:21'),
(80, 55, 15, '2026-08-06', 'Visited - Order Taken', 'Placed Order ID: 59. Total: ₹2,860.20', NULL, NULL, '2026-08-06 08:57:21'),
(81, 42, 15, '2026-08-10', 'Visited - Payment Collected', 'Collected payment of ₹239.90 via Cash.', NULL, NULL, '2026-08-10 07:16:31'),
(82, 39, 15, '2026-08-10', 'Visited - Payment Collected', 'Collected payment of ₹100.00 via Cash.', NULL, NULL, '2026-08-10 07:16:52'),
(83, 41, 15, '2026-08-10', 'Visited - Payment Collected', 'Collected payment of ₹500.00 via Cash.', NULL, NULL, '2026-08-10 08:04:35'),
(84, 44, 15, '2026-08-10', 'Visited - Payment Collected', 'Collected payment of ₹180.00 via Cash.', NULL, NULL, '2026-08-10 08:06:08'),
(85, 56, 15, '2026-08-11', 'Visited - Order Taken', 'Placed Order ID: 60. Total: ₹2,722.90', NULL, NULL, '2026-08-11 04:24:48'),
(86, 49, 15, '2026-08-11', 'Visited - Payment Collected', 'Collected payment of ₹200.00 via Cash.', NULL, NULL, '2026-08-11 07:33:20'),
(87, 23, 15, '2026-08-13', 'Visited - Payment Collected', 'Collected payment of ₹350.00 via Cash.', NULL, NULL, '2026-08-13 12:24:42'),
(88, 22, 15, '2026-08-13', 'Visited - Payment Collected', 'Collected payment of ₹500.00 via UPI.', NULL, NULL, '2026-08-13 12:25:01'),
(89, 22, 15, '2026-08-13', 'Visited - Payment Collected', 'Collected payment of ₹193.00 via Cash.', NULL, NULL, '2026-08-13 12:25:07'),
(90, 33, 15, '2026-08-15', 'Visited - Order Taken', 'Placed Order ID: 61. Total: ₹1,229.13', NULL, NULL, '2026-08-15 03:55:50'),
(91, 34, 15, '2026-08-15', 'Visited - Order Taken', 'Placed Order ID: 62. Total: ₹1,125.18', NULL, NULL, '2026-08-15 04:05:12'),
(92, 59, 15, '2026-08-15', 'Visited - Order Taken', 'Placed Order ID: 63. Total: ₹1,143.99', NULL, NULL, '2026-08-15 04:34:59'),
(93, 57, 15, '2026-08-15', 'Visited - Order Taken', 'Placed Order ID: 64. Total: ₹199.46', NULL, NULL, '2026-08-15 04:36:09'),
(94, 34, 15, '2026-08-15', 'Visited - Payment Collected', 'Collected payment of ₹1,125.18 via Cash.', NULL, NULL, '2026-08-15 07:00:22'),
(95, 16, 15, '2026-08-19', 'Visited - Order Taken', 'Placed Order ID: 65. Total: ₹1,209.32', NULL, NULL, '2026-08-19 05:56:50'),
(96, 15, 15, '2026-08-19', 'Visited - Payment Collected', 'Collected payment of ₹180.00 via Cash.', NULL, NULL, '2026-08-19 06:09:59'),
(97, 18, 15, '2026-08-19', 'Visited - Order Taken', 'Placed Order ID: 66. Total: ₹309.68', NULL, NULL, '2026-08-19 06:30:14'),
(98, 18, 15, '2026-08-19', 'Visited - Order Taken', 'Placed Order ID: 67. Total: ₹309.68', NULL, NULL, '2026-08-19 06:30:14'),
(99, 18, 15, '2026-08-19', 'Visited - Order Taken', 'Placed Order ID: 68. Total: ₹309.68', NULL, NULL, '2026-08-19 06:30:14'),
(100, 18, 15, '2026-08-19', 'Visited - Order Taken', 'Placed Order ID: 69. Total: ₹309.68', NULL, NULL, '2026-08-19 06:30:14'),
(101, 23, 15, '2026-08-20', 'Visited - Payment Collected', 'Collected payment of ₹358.00 via Cash.', NULL, NULL, '2026-08-20 12:47:24'),
(102, 19, 15, '2026-08-20', 'Visited - Payment Collected', 'Collected payment of ₹480.00 via UPI.', NULL, NULL, '2026-08-20 12:52:42'),
(103, 20, 15, '2026-08-20', 'Visited - Payment Collected', 'Collected payment of ₹512.00 via Cash.', NULL, NULL, '2026-08-20 13:00:33'),
(104, 52, 15, '2026-08-20', 'Visited - Payment Collected', 'Collected payment of ₹1,500.00 via Cash.', NULL, NULL, '2026-08-20 13:36:27'),
(105, 26, 15, '2026-08-20', 'Visited - Payment Collected', 'Collected payment of ₹500.00 via Cash.', NULL, NULL, '2026-08-20 13:37:02'),
(106, 24, 15, '2026-08-20', 'Visited - Payment Collected', 'Collected payment of ₹300.00 via Cash.', NULL, NULL, '2026-08-20 13:37:38'),
(107, 33, 15, '2026-08-22', 'Visited - Order Taken', 'Placed Order ID: 70. Total: ₹260.00', NULL, NULL, '2026-08-22 13:50:24'),
(108, 32, 15, '2026-08-22', 'Visited - Order Taken', 'Placed Order ID: 71. Total: ₹166.64', NULL, NULL, '2026-08-22 13:54:29'),
(109, 35, 15, '2026-08-23', 'Visited - Order Taken', 'Placed Order ID: 72. Total: ₹130.00', NULL, NULL, '2026-08-23 01:27:00'),
(110, 60, 15, '2026-08-27', 'Visited - Order Taken', 'Placed Order ID: 73. Total: ₹295.03', NULL, NULL, '2026-08-27 06:35:43'),
(111, 40, 15, '2026-08-27', 'Visited - Order Taken', 'Placed Order ID: 74. Total: ₹2,154.18', NULL, NULL, '2026-08-27 06:44:37'),
(112, 56, 15, '2026-08-31', 'Visited - Payment Collected', 'Collected payment of ₹2,723.00 via Cash.', NULL, NULL, '2026-08-31 06:27:33'),
(113, 49, 15, '2026-08-31', 'Visited - Payment Collected', 'Collected payment of ₹259.00 via Cash.', NULL, NULL, '2026-08-31 07:41:13'),
(114, 45, 15, '2026-08-31', 'Visited - Payment Collected', 'Collected payment of ₹300.00 via Cash.', NULL, NULL, '2026-08-31 07:43:13'),
(115, 16, 15, '2026-09-02', 'Visited - Payment Collected', 'Collected payment of ₹1,209.00 via Cash.', NULL, NULL, '2026-09-02 06:15:05'),
(116, 8, 15, '2026-09-02', 'Visited - Payment Collected', 'Collected payment of ₹550.00 via Cash.', NULL, NULL, '2026-09-02 06:15:26'),
(117, 17, 15, '2026-09-02', 'Visited - Payment Collected', 'Collected payment of ₹960.00 via Cash.', NULL, NULL, '2026-09-02 06:15:46'),
(118, 12, 15, '2026-09-02', 'Visited - Order Taken', 'Placed Order ID: 75. Total: ₹179.68', NULL, NULL, '2026-09-02 10:01:58'),
(119, 15, 15, '2026-09-02', 'Visited - Order Taken', 'Placed Order ID: 76. Total: ₹658.48', NULL, NULL, '2026-09-02 10:05:23'),
(120, 16, 15, '2026-09-02', 'Visited - Order Taken', 'Placed Order ID: 77. Total: ₹394.70', NULL, NULL, '2026-09-02 10:07:04'),
(121, 57, 15, '2026-09-05', 'Visited - Payment Collected', 'Collected payment of ₹200.00 via Cash.', NULL, NULL, '2026-09-05 02:38:47'),
(122, 40, 15, '2026-09-05', 'Visited - Payment Collected', 'Collected payment of ₹2,154.00 via Cheque.', NULL, NULL, '2026-09-05 02:39:27'),
(123, 26, 15, '2026-09-05', 'Visited - Order Taken', 'Placed Order ID: 78. Total: ₹539.03', NULL, NULL, '2026-09-05 04:37:55'),
(124, 51, 15, '2026-09-05', 'Visited - Order Taken', 'Placed Order ID: 79. Total: ₹1,049.48', NULL, NULL, '2026-09-05 04:39:00'),
(125, 59, 15, '2026-09-05', 'Visited - Order Taken', 'Placed Order ID: 80. Total: ₹260.00', NULL, NULL, '2026-09-05 04:40:42'),
(126, 37, 15, '2026-09-05', 'Visited - Order Taken', 'Placed Order ID: 81. Total: ₹1,201.64', NULL, NULL, '2026-09-05 04:42:07'),
(127, 59, 15, '2026-09-05', 'Visited - Payment Collected', 'Collected payment of ₹260.00 via Cash.', NULL, NULL, '2026-09-05 10:19:52'),
(128, 60, 15, '2026-09-05', 'Visited - Payment Collected', 'Collected payment of ₹1,000.00 via Cash.', NULL, NULL, '2026-09-05 10:20:19'),
(129, 37, 15, '2026-09-05', 'Visited - Payment Collected', 'Collected payment of ₹1,202.00 via Cash.', NULL, NULL, '2026-09-05 10:20:41'),
(130, 52, 15, '2026-09-05', 'Visited - Payment Collected', 'Collected payment of ₹1,500.00 via Cash.', NULL, NULL, '2026-09-05 12:15:31'),
(131, 53, 15, '2026-09-05', 'Visited - Payment Collected', 'Collected payment of ₹1,000.00 via Cash.', NULL, NULL, '2026-09-05 12:16:02'),
(132, 26, 15, '2026-09-07', 'Visited - Order Taken', 'Placed Order ID: 82. Total: ₹2,878.85', NULL, NULL, '2026-09-07 01:52:23'),
(133, 25, 15, '2026-09-07', 'Visited - Order Taken', 'Placed Order ID: 83. Total: ₹2,399.04', NULL, NULL, '2026-09-07 02:03:10'),
(134, 41, 15, '2026-09-07', 'Visited - Order Taken', 'Placed Order ID: 84. Total: ₹959.62', NULL, NULL, '2026-09-07 07:03:58'),
(135, 45, 15, '2026-09-07', 'Visited - Payment Collected', 'Collected payment of ₹360.00 via Cash.', NULL, NULL, '2026-09-07 07:19:49'),
(136, 45, 15, '2026-09-07', 'Visited - Order Taken', 'Placed Order ID: 85. Total: ₹3,148.36', NULL, NULL, '2026-09-07 07:24:20'),
(137, 25, 15, '2026-09-10', 'Visited - Payment Collected', 'Collected payment of ₹600.00 via Cash.', NULL, NULL, '2026-09-10 14:05:17'),
(138, 53, 15, '2026-09-10', 'Visited - Payment Collected', 'Collected payment of ₹1,500.00 via Cash.', NULL, NULL, '2026-09-10 14:06:03'),
(139, 55, 15, '2026-09-10', 'Visited - Payment Collected', 'Collected payment of ₹1,000.00 via Cash.', NULL, NULL, '2026-09-10 14:06:31'),
(140, 26, 15, '2026-09-10', 'Visited - Payment Collected', 'Collected payment of ₹500.00 via Cash.', NULL, NULL, '2026-09-10 14:06:51'),
(141, 27, 15, '2026-09-10', 'Visited - Payment Collected', 'Collected payment of ₹500.00 via Cash.', NULL, NULL, '2026-09-10 14:07:17'),
(142, 56, 15, '2026-09-11', 'Visited - Order Taken', 'Placed Order ID: 86. Total: ₹1,300.00', NULL, NULL, '2026-09-11 02:56:19'),
(143, 40, 15, '2026-09-12', 'Visited - Order Taken', 'Placed Order ID: 87. Total: ₹3,000.00', NULL, NULL, '2026-09-12 05:34:56'),
(144, 34, 15, '2026-09-12', 'Visited - Order Taken', 'Placed Order ID: 88. Total: ₹260.00', NULL, NULL, '2026-09-12 12:50:43'),
(145, 16, 15, '2026-09-17', 'Visited - Payment Collected', 'Collected payment of ₹396.00 via Cash.', NULL, NULL, '2026-09-17 14:29:20'),
(146, 59, 15, '2026-09-18', 'Visited - Order Taken', 'Placed Order ID: 89. Total: ₹333.48', NULL, NULL, '2026-09-18 07:50:11'),
(147, 60, 15, '2026-09-18', 'Visited - Order Taken', 'Placed Order ID: 90. Total: ₹1,693.36', NULL, NULL, '2026-09-18 07:53:00'),
(148, 33, 15, '2026-09-18', 'Visited - Order Taken', 'Placed Order ID: 91. Total: ₹539.03', NULL, NULL, '2026-09-18 07:54:24'),
(149, 16, 15, '2026-09-18', 'Visited - Order Taken', 'Placed Order ID: 92. Total: ₹89.84', NULL, NULL, '2026-09-18 07:56:16'),
(150, 8, 15, '2026-09-18', 'Visited - Order Taken', 'Placed Order ID: 93. Total: ₹549.99', NULL, NULL, '2026-09-18 08:02:38'),
(151, 18, 15, '2026-09-18', 'Visited - Order Taken', 'Placed Order ID: 94. Total: ₹89.84', NULL, NULL, '2026-09-18 08:05:14'),
(152, 53, 15, '2026-09-21', 'Visited - Order Taken', 'Placed Order ID: 95. Total: ₹1,099.98', NULL, NULL, '2026-09-21 05:44:57'),
(153, 39, 15, '2026-09-21', 'Visited - Payment Collected', 'Collected payment of ₹200.00 via Cash.', NULL, NULL, '2026-09-21 12:00:07'),
(154, 41, 15, '2026-09-21', 'Visited - Payment Collected', 'Collected payment of ₹960.00 via Cash.', NULL, NULL, '2026-09-21 12:03:21'),
(155, 45, 15, '2026-09-21', 'Visited - Payment Collected', 'Collected payment of ₹600.00 via Cash.', NULL, NULL, '2026-09-21 13:16:34'),
(156, 51, 15, '2026-09-22', 'Visited - Order Taken', 'Placed Order ID: 96. Total: ₹1,049.48', NULL, NULL, '2026-09-22 04:22:46'),
(157, 56, 15, '2026-09-22', 'Visited - Payment Collected', 'Collected payment of ₹1,299.90 via Cash.', NULL, NULL, '2026-09-22 06:30:20'),
(158, 49, 15, '2026-09-22', 'Visited - Order Taken', 'Placed Order ID: 97. Total: ₹577.52', NULL, NULL, '2026-09-22 09:11:03'),
(159, 50, 15, '2026-09-22', 'Visited - Order Taken', 'Placed Order ID: 98. Total: ₹130.00', NULL, NULL, '2026-09-22 09:11:58'),
(160, 63, 15, '2026-09-22', 'Visited - Order Taken', 'Placed Order ID: 99. Total: ₹983.27', NULL, NULL, '2026-09-22 09:26:04'),
(161, 61, 15, '2026-09-22', 'Visited - Order Taken', 'Placed Order ID: 100. Total: ₹140.00', NULL, NULL, '2026-09-22 10:28:59'),
(162, 64, 15, '2026-09-22', 'Visited - Order Taken', 'Placed Order ID: 101. Total: ₹563.32', NULL, NULL, '2026-09-22 10:31:37'),
(163, 62, 15, '2026-09-22', 'Visited - Order Taken', 'Placed Order ID: 102. Total: ₹2,357.37', NULL, NULL, '2026-09-22 10:36:47'),
(164, 51, 15, '2026-09-22', 'Visited - Order Taken', 'Placed Order ID: 103. Total: ₹1,084.62', NULL, NULL, '2026-09-22 11:46:49'),
(165, 50, 15, '2026-09-22', 'Visited - Payment Collected', 'Collected payment of ₹129.94 via Cash.', NULL, NULL, '2026-09-22 13:09:33'),
(166, 12, 15, '2026-09-23', 'Visited - Payment Collected', 'Collected payment of ₹180.00 via Cash.', NULL, NULL, '2026-09-23 08:18:35'),
(167, 15, 15, '2026-09-23', 'Visited - Payment Collected', 'Collected payment of ₹658.00 via Cash.', NULL, NULL, '2026-09-23 08:19:03'),
(168, 18, 15, '2026-09-24', 'Visited - Order Taken', 'Placed Order ID: 104. Total: ₹239.40', NULL, NULL, '2026-09-24 00:53:16'),
(169, 66, 15, '2026-09-24', 'Visited - Order Taken', 'Placed Order ID: 105. Total: ₹532.04', NULL, NULL, '2026-09-24 00:54:18'),
(170, 67, 15, '2026-09-24', 'Visited - Order Taken', 'Placed Order ID: 106. Total: ₹379.13', NULL, NULL, '2026-09-24 00:58:02'),
(171, 49, 15, '2026-10-02', 'Visited - Order Taken', 'Placed Order ID: 107. Total: ₹333.48', NULL, NULL, '2026-10-02 05:10:15'),
(172, 60, 15, '2026-10-02', 'Visited - Order Taken', 'Placed Order ID: 108. Total: ₹650.00', NULL, NULL, '2026-10-02 10:57:20'),
(173, 70, 15, '2026-10-02', 'Visited - Order Taken', 'Placed Order ID: 109. Total: ₹593.48', NULL, NULL, '2026-10-02 10:58:18'),
(174, 59, 15, '2026-10-02', 'Visited - Order Taken', 'Placed Order ID: 110. Total: ₹491.72', NULL, NULL, '2026-10-02 11:00:03'),
(175, 69, 15, '2026-10-02', 'Visited - Order Taken', 'Placed Order ID: 111. Total: ₹549.99', NULL, NULL, '2026-10-02 11:01:04'),
(176, 68, 15, '2026-10-02', 'Visited - Order Taken', 'Placed Order ID: 112. Total: ₹479.81', NULL, NULL, '2026-10-02 11:01:39'),
(177, 60, 15, '2026-10-02', 'Visited - Payment Collected', 'Collected payment of ₹650.00 via UPI.', NULL, NULL, '2026-10-02 11:47:36');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'Owner', 'Super Admin with access to all modules', '2026-07-07 14:34:18'),
(2, 'Sales Staff', 'Staff with limited access to catalog, retailers, and order placing', '2026-07-07 14:34:18');

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `id` int(11) NOT NULL,
  `route_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`id`, `route_name`, `created_at`) VALUES
(1, 'RAVIWAR PETH, MAIN MARKET', '2026-07-18 17:17:33'),
(2, 'SAMBRA SULEBHAVI', '2026-07-20 07:27:07'),
(3, 'Kakati Honaga', '2026-07-20 07:27:36'),
(4, 'Mahantesh Nagar, Autonagar,Kanbargi', '2026-07-20 07:28:23'),
(5, 'KHADE BAZAR', '2026-07-27 14:50:40'),
(6, 'GANESHPUR HINDALGA', '2026-08-04 05:59:17');

-- --------------------------------------------------------

--
-- Table structure for table `route_retailers`
--

CREATE TABLE `route_retailers` (
  `id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `retailer_id` int(11) NOT NULL,
  `sequence_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `route_retailers`
--

INSERT INTO `route_retailers` (`id`, `route_id`, `retailer_id`, `sequence_order`) VALUES
(5, 1, 23, 0),
(7, 1, 31, 0),
(8, 1, 22, 0),
(9, 2, 33, 0),
(10, 1, 26, 0),
(14, 1, 21, 0),
(15, 1, 28, 0),
(17, 2, 34, 0),
(20, 1, 24, 0),
(21, 1, 27, 0),
(23, 1, 25, 0),
(24, 1, 29, 0),
(27, 1, 19, 0),
(30, 1, 20, 0),
(42, 5, 39, 0),
(53, 2, 35, 0),
(55, 2, 37, 0),
(59, 5, 41, 0),
(60, 5, 42, 0),
(61, 5, 43, 0),
(62, 5, 44, 0),
(63, 5, 45, 0),
(64, 5, 46, 0),
(65, 6, 47, 0),
(66, 6, 48, 0),
(68, 6, 50, 0),
(70, 4, 8, 0),
(71, 4, 9, 0),
(72, 4, 12, 0),
(73, 4, 15, 0),
(74, 4, 17, 0),
(75, 4, 18, 0),
(76, 4, 16, 0),
(77, 4, 13, 0),
(78, 1, 52, 0),
(79, 1, 53, 0),
(81, 1, 55, 0),
(82, 6, 56, 0),
(83, 2, 57, 0),
(87, 2, 38, 0),
(88, 2, 36, 0),
(89, 2, 32, 0),
(90, 2, 40, 0),
(91, 6, 51, 0),
(92, 6, 61, 0),
(95, 6, 64, 0),
(96, 6, 65, 0),
(97, 6, 63, 0),
(98, 4, 66, 0),
(99, 4, 67, 0),
(100, 2, 60, 0),
(101, 6, 62, 0),
(102, 6, 49, 0),
(104, 4, 68, 0),
(105, 4, 69, 0),
(106, 2, 70, 0),
(107, 2, 59, 0),
(109, 1, 54, 0);

-- --------------------------------------------------------

--
-- Table structure for table `route_schedules`
--

CREATE TABLE `route_schedules` (
  `id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `day_of_week` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `route_schedules`
--

INSERT INTO `route_schedules` (`id`, `route_id`, `staff_id`, `day_of_week`, `notes`, `created_at`) VALUES
(10, 1, 15, 'Thursday', '', '2026-07-26 09:30:47'),
(12, 4, 15, 'Wednesday', '', '2026-07-29 07:55:52'),
(15, 5, NULL, 'Monday', '', '2026-08-03 05:26:51'),
(16, 6, NULL, 'Tuesday', '', '2026-08-04 06:01:36'),
(17, 2, NULL, 'Friday', '', '2026-08-05 04:03:15');

-- --------------------------------------------------------

--
-- Table structure for table `salesman_routes`
--

CREATE TABLE `salesman_routes` (
  `id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `day_of_week` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `route_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales_returns`
--

CREATE TABLE `sales_returns` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales_return_items`
--

CREATE TABLE `sales_return_items` (
  `id` int(11) NOT NULL,
  `return_id` int(11) NOT NULL,
  `invoice_item_id` int(11) DEFAULT NULL,
  `sku_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `selling_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `gst_percentage` decimal(5,2) NOT NULL DEFAULT 0.00,
  `gst_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Damaged/Returned'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales_staff_details`
--

CREATE TABLE `sales_staff_details` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `route_id` int(11) DEFAULT NULL,
  `assigned_area` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT 0.00,
  `sales_target` decimal(10,2) DEFAULT 0.00,
  `joining_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales_staff_details`
--

INSERT INTO `sales_staff_details` (`id`, `user_id`, `route_id`, `assigned_area`, `salary`, `sales_target`, `joining_date`) VALUES
(6, 15, NULL, 'BELAGAVI', '1000.00', '1000.00', '2026-07-13');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `key_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `val_value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key_name`, `val_value`, `updated_at`) VALUES
(1, 'company_name', 'Navatara Enterprises', '2026-07-07 14:40:07'),
(2, 'company_address', 'Alarwad , Belagavi - 590020', '2026-07-12 08:58:37'),
(3, 'company_mobile', '6361742356', '2026-07-12 08:58:37'),
(4, 'company_email', 'navataraenterprise@gmail.com', '2026-07-13 01:31:22'),
(5, 'company_gst', '29APPPJ6887A1ZD', '2026-07-12 08:58:37'),
(6, 'company_pan', 'AAAAA1111A', '2026-07-07 14:34:19'),
(7, 'invoice_prefix', 'NE/2026-27/', '2026-07-07 14:34:19'),
(8, 'invoice_footer', '', '2026-07-12 08:58:37'),
(9, 'financial_year', '2026-2027', '2026-07-07 14:34:19'),
(10, 'tax_settings', '{\"default_gst\":18.00,\"tax_inclusive\":false}', '2026-07-07 14:34:19'),
(18, 'default_credit_limit', '50000.00', '2026-07-13 01:31:22'),
(21, 'expense_categories', '[\"Travel \\/ Fuel\",\"Salaries \\/ Commissions\",\"Rent & Bills\",\"Office \\/ Stationery\",\"Marketing \\/ Refreshments\",\"Miscellaneous\"]', '2026-07-12 07:48:15'),
(22, 'payment_methods', '[&quot;Cash&quot;,&quot;UPI&quot;,&quot;Bank Transfer&quot;,&quot;Cheque&quot;]', '2026-07-12 07:52:20'),
(31, 'company_fssai', '', '2026-07-12 08:58:37'),
(32, 'bank_name', 'CANARA BANK', '2026-07-13 01:31:22'),
(33, 'bank_account_no', '120040650849', '2026-07-12 08:58:37'),
(34, 'bank_ifsc', 'CNRB0002537', '2026-07-12 08:58:37'),
(35, 'bank_branch', 'TRIMURTHI COMPLEX, MAHADWAR ROAD, BELAGAVI,590001', '2026-07-13 01:31:22'),
(127, 'company_state', 'Karnataka', '2026-10-02 15:53:20');

-- --------------------------------------------------------

--
-- Table structure for table `skus`
--

CREATE TABLE `skus` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `sku_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `mrp` decimal(10,2) NOT NULL,
  `gst_percentage` decimal(5,2) NOT NULL DEFAULT 18.00,
  `unit` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pcs',
  `weight` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_stock` int(11) DEFAULT 0,
  `minimum_stock` int(11) DEFAULT 5,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `allow_dynamic_price` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `skus`
--

INSERT INTO `skus` (`id`, `product_id`, `sku_name`, `sku_code`, `purchase_price`, `selling_price`, `mrp`, `gst_percentage`, `unit`, `weight`, `size`, `current_stock`, `minimum_stock`, `status`, `allow_dynamic_price`, `created_at`) VALUES
(12, 7, 'SHRI KRISHNA 200 ML JAR COW GHEE', 'COW GHEE 200ML JAR', '156.26', '165.63', '200.00', '5.00', 'Pcs', '', '', 59, 5, 'Active', 0, '2026-07-13 01:44:11'),
(13, 7, 'SHRI KRISHNA 100ML JAR COW GHEE', 'COW GHEE 100ML JAR', '84.61', '89.68', '113.00', '5.00', 'Pcs', '', '', 71, 5, 'Active', 0, '2026-07-13 01:46:45'),
(14, 7, 'SHRI KRISHNA 50ML JAR COW GHEE', 'COW GHEE 50ML JAR', '44.17', '46.83', '59.00', '5.00', 'Pcs', '', '', 69, 5, 'Active', 0, '2026-07-13 01:49:25'),
(16, 7, 'SHRI KRISHNA 20 RS SHEET COW GHEE', '20 RS SHEET COW GHEE', '14.97', '15.87', '20.00', '5.00', 'Pcs', '', '', 160, 5, 'Active', 0, '2026-07-13 07:49:44'),
(17, 8, 'APPALAM', 'APPALAM  PAPER PACK', '13.78', '14.13', '30.00', '0.00', 'Pcs', '100G', '', 146, 5, 'Active', 0, '2026-07-13 07:55:48'),
(18, 9, 'VINAYAKA BLACK FANTASY ZIPPER PACKS', 'ZIPPER 1', '35.00', '38.08', '72.00', '5.00', 'Pcs', '110G', '', 187, 5, 'Active', 0, '2026-07-15 11:18:26'),
(21, 9, 'VINAYAKA WILD PURPLE ZIPPER PACKS', 'ZIPPER 2', '35.00', '38.08', '72.00', '5.00', 'Pcs', '110G', '', 285, 5, 'Active', 0, '2026-07-15 11:21:38'),
(22, 9, 'VINAYAKA KASTURI ZIPPER PACK', 'ZIPPER 3', '35.00', '38.08', '72.00', '5.00', 'Pcs', '110G', '', 258, 5, 'Active', 0, '2026-07-15 11:23:08'),
(23, 9, 'VINAYAKA DIAMOND ZIPPER PACK', 'ZIPPER 4', '35.00', '38.08', '72.00', '5.00', 'Pcs', '110G', '', 231, 5, 'Active', 0, '2026-07-15 11:24:32'),
(25, 9, 'VINAYAKA HEENA ZIPPER PACKS', 'ZIPPER 5', '35.00', '38.08', '72.00', '5.00', 'Pcs', '110G', '', 183, 5, 'Active', 0, '2026-07-15 11:26:23'),
(26, 9, 'VINAYAKA DREAMS ZIPPER PACKS', 'ZIPPER 6', '35.00', '38.08', '72.00', '5.00', 'Pcs', '110G', '', 333, 5, 'Active', 0, '2026-07-15 11:27:43'),
(28, 9, 'VINAYAKA BOLENATH ZIPPER PACKS', 'ZIPPER 7', '35.00', '38.08', '72.00', '5.00', 'Pcs', '110G', '', 234, 5, 'Active', 0, '2026-07-15 11:28:48'),
(29, 11, 'VINAYAKA REGULAR POUCH MIX', 'ZIPPER 8', '6.67', '7.13', '15.00', '5.00', 'Pcs', '', '', 564, 5, 'Active', 0, '2026-07-15 11:34:30'),
(30, 10, 'VINAYAKA GOOD MORNING ECONOMY', 'ZIPPER 9', '15.83', '19.00', '30.00', '5.00', 'Pcs', '', '', 360, 5, 'Active', 0, '2026-07-15 11:37:22'),
(31, 10, 'VINAYAKA BLACK FANTASY 60G', 'ECONOMY 1', '14.16', '15.83', '25.00', '5.00', 'Pcs', '', '', 168, 5, 'Active', 0, '2026-07-15 11:40:58'),
(32, 10, 'VINAYAKA WILD PURPLE 60G', 'ECONOMY 2', '14.16', '15.83', '25.00', '5.00', 'Pcs', '', '', 264, 5, 'Active', 0, '2026-07-15 11:43:00'),
(33, 9, 'VINAYAKA BRUTS ZIPPER PACKS', 'ZIPPER -11', '35.00', '38.08', '72.00', '5.00', 'Pcs', '', '', 195, 5, 'Active', 0, '2026-07-16 09:38:37'),
(34, 7, 'SHRI KRISHNA 10RS SHEET COW GHEE', '10 RS SHEET COW GHEE', '7.49', '7.94', '10.00', '5.00', 'Pcs', '', '', 2, 5, 'Active', 0, '2026-07-17 03:13:09'),
(36, 9, 'VINAYAKA ONE PLUS ZIPPER PACKS', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-ONE-PLUS-ZIPP', '0.00', '0.00', '72.00', '5.00', 'Pcs', '', '', 24, 10, 'Active', 0, '2026-07-31 04:13:02'),
(37, 12, 'VINAYAKA CUP DHOOP GUGGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-GUGGAL', '38.08', '43.65', '120.00', '5.00', 'Pcs', '', '', 20, 5, 'Active', 0, '2026-08-02 15:19:35'),
(38, 12, 'VINAYAKA CUP DHOOP SAMBRANI', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-SAMBRA', '38.08', '43.65', '120.00', '5.00', 'Pcs', '', '', 14, 5, 'Active', 0, '2026-08-02 15:20:56'),
(39, 12, 'VINAYAKA CUP DHOOP MANGAL', 'INCENSE-STICKS-CUP-DHOOP-VINAYAKA-CUP-DHOOP-MANGAL', '33.33', '43.65', '120.00', '5.00', 'Pcs', '', '', 38, 5, 'Active', 0, '2026-08-02 15:22:06'),
(40, 13, 'GINGER GARLIC PASTE 5RS', 'MASALA-GINGER-GARLIC-PASTE-GINGER-GARLIC-PASTE-5RS', '2.36', '2.38', '5.00', '5.00', 'Pcs', '', '', -920, 5, 'Active', 0, '2026-08-02 15:35:24'),
(41, 14, 'TURMERIC POWDER 5KG', 'MASALA-TURMERIC-POWDER-TURMERIC-POWDER-5KG', '881.83', '946.04', '1300.00', '5.00', 'Pcs', '', '', 4, 0, 'Active', 0, '2026-08-02 15:38:12'),
(42, 15, 'TURMERIC POWDER SHEET 10RS', 'MASALA-TURMERIC-POWDER-SHEET-TURMERIC-POWDER-SHEET', '4.33', '5.00', '10.00', '5.00', 'Pcs', '', '', 50, 5, 'Active', 0, '2026-08-02 15:41:57'),
(43, 9, 'FRESH GUGGAL', 'INCENSE-STICKS-ZIPPER-PACKS-FRESH-GUGGAL', '0.00', '0.00', '72.00', '5.00', 'Pcs', '', '', 80, 5, 'Active', 0, '2026-09-07 01:57:31'),
(44, 9, 'VINAYAKA SATIN PLUS ZIPPER', 'INCENSE-STICKS-ZIPPER-PACKS-VINAYAKA-SATIN-PLUS-ZI', '35.00', '38.08', '72.00', '5.00', 'Pcs', '', '', 96, 5, 'Active', 0, '2026-09-21 04:46:42'),
(45, 16, 'VINAYAKA JAR DHOOP  STICKS  MIX', 'INCENSE-STICKS-JAR-DHOOP-VINAYAKA-JAR-DHOOP-STICKS', '31.67', '35.71', '90.00', '5.00', 'Pcs', '', '', 96, 5, 'Active', 0, '2026-09-21 04:51:19'),
(46, 17, 'VINAYAKA CONE JAR MIX', 'INCENSE-STICKS-CONE-JAR-VINAYAKA-CONE-JAR-MIX', '31.67', '35.71', '90.00', '5.00', 'Pcs', '', '', 96, 5, 'Active', 0, '2026-09-21 04:53:23');

-- --------------------------------------------------------

--
-- Table structure for table `sku_discounts`
--

CREATE TABLE `sku_discounts` (
  `id` int(11) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `discount_type` enum('Quantity Slab','Flat Rate') COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_qty` int(11) DEFAULT 0,
  `max_qty` int(11) DEFAULT 999999,
  `discount_value` decimal(10,2) NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sku_discounts`
--

INSERT INTO `sku_discounts` (`id`, `sku_id`, `discount_type`, `min_qty`, `max_qty`, `discount_value`, `status`, `created_at`) VALUES
(10, 12, 'Flat Rate', 10, 999999, '160.95', 'Active', '2026-07-24 04:45:46'),
(27, 30, 'Quantity Slab', 40, 999999, '17.86', 'Active', '2026-08-15 04:03:10'),
(28, 40, 'Quantity Slab', 100, 920, '2.23', 'Active', '2026-08-27 06:43:24'),
(33, 17, 'Quantity Slab', 10, 200, '13.00', 'Active', '2026-10-02 10:55:29'),
(34, 17, 'Quantity Slab', 1, 9, '14.00', 'Active', '2026-10-02 10:55:50'),
(35, 17, 'Quantity Slab', 200, 240, '12.50', 'Active', '2026-10-02 10:56:17');

-- --------------------------------------------------------

--
-- Table structure for table `staff_routes`
--

CREATE TABLE `staff_routes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `staff_routes`
--

INSERT INTO `staff_routes` (`id`, `user_id`, `route_id`, `created_at`) VALUES
(6, 15, 6, '2026-08-04 06:02:01'),
(7, 15, 5, '2026-08-04 06:02:01'),
(8, 15, 4, '2026-08-04 06:02:01'),
(9, 15, 3, '2026-08-04 06:02:01'),
(10, 15, 2, '2026-08-04 06:02:01'),
(11, 15, 1, '2026-08-04 06:02:01');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gst_number` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fssai_license` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acc_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_place` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acc_holder` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_mode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `gst_number`, `address`, `fssai_license`, `acc_number`, `bank_branch`, `bank_place`, `acc_holder`, `payment_mode`, `created_at`) VALUES
(1, 'SHREE KRISHNA FOODS PVT LTD', '29AANCS5185J1ZK', 'BANGALORE', '11216309000041', '', '', '', '', '', '2026-07-19 08:09:32'),
(2, 'VINAYAKA SALES AND PERFUMARY', '29AGEPH9459C1Z7', 'VIJAYAPURA- 586101', '', '', '', '', '', '', '2026-07-19 08:11:34');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_payments`
--

CREATE TABLE `supplier_payments` (
  `id` int(11) NOT NULL,
  `supplier_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `payment_mode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `supplier_payments`
--

INSERT INTO `supplier_payments` (`id`, `supplier_name`, `payment_date`, `amount`, `payment_mode`, `reference_number`, `remarks`, `created_at`) VALUES
(14, 'SHREE KRISHNA FOODS PVT LTD', '2026-09-17', '12006.30', 'Bank Transfer', '3151', 'Auto-generated for Purchase Invoice: 3151', '2026-09-18 07:43:44'),
(15, 'VINAYAKA SALES AND PERFUMARY', '2026-09-18', '27776.95', 'Bank Transfer', '22887', 'Auto-generated for Purchase Invoice: 22887', '2026-09-21 05:00:13');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fullname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `username`, `password_hash`, `fullname`, `email`, `mobile`, `photo`, `status`, `created_at`) VALUES
(1, 1, 'NAVATARA_03', '$2y$10$HvsXqP9MeobihgaDjN3oXuMw2zfXex25G0i/iQyVdDTmUyxY9uOT6', 'Shreyansh Janagouda', 'navataraenterprise@gmail.com', '6361742356', 'uploads/profile/1783847709_ChatGPT Image Jul 5, 2026, 03_50_06 PM.png', 'Active', '2026-07-07 14:34:19'),
(15, 2, 'Shreyansh_', '$2y$10$OQWiFMMoUxwU2J4BNlgCTO0H.fB96KOI3m.maERLRhyeBmIbuFIa6', 'SHREYANSH', 'shreyanshjanagouda9220@gmail.com', '6361742356', NULL, 'Active', '2026-07-13 08:02:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `fk_brands_suppliers` (`supplier_id`);

--
-- Indexes for table `business_capital`
--
ALTER TABLE `business_capital`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_ledger`
--
ALTER TABLE `customer_ledger`
  ADD PRIMARY KEY (`id`),
  ADD KEY `retailer_id` (`retailer_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `expiry_records`
--
ALTER TABLE `expiry_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `retailer_id` (`retailer_id`),
  ADD KEY `sku_id` (`sku_id`),
  ADD KEY `collected_by` (`collected_by`);

--
-- Indexes for table `inventory_history`
--
ALTER TABLE `inventory_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sku_id` (`sku_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_number` (`invoice_number`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `retailer_id` (`retailer_id`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `sku_id` (`sku_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `retailer_id` (`retailer_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `sku_id` (`sku_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `retailer_id` (`retailer_id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `fk_payments_collected_by` (`collected_by`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `brand_product` (`brand_id`,`name`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `supplier_invoice` (`supplier_invoice`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_id` (`purchase_id`),
  ADD KEY `sku_id` (`sku_id`);

--
-- Indexes for table `retailers`
--
ALTER TABLE `retailers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by_staff_id` (`created_by_staff_id`),
  ADD KEY `assigned_staff_id` (`assigned_staff_id`);

--
-- Indexes for table `retailer_timeline`
--
ALTER TABLE `retailer_timeline`
  ADD PRIMARY KEY (`id`),
  ADD KEY `retailer_id` (`retailer_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `route_retailers`
--
ALTER TABLE `route_retailers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `route_retailer_idx` (`route_id`,`retailer_id`),
  ADD KEY `retailer_id` (`retailer_id`);

--
-- Indexes for table `route_schedules`
--
ALTER TABLE `route_schedules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_route_day_staff` (`route_id`,`day_of_week`,`staff_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `salesman_routes`
--
ALTER TABLE `salesman_routes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `staff_day_idx` (`staff_id`,`day_of_week`),
  ADD KEY `route_id` (`route_id`);

--
-- Indexes for table `sales_returns`
--
ALTER TABLE `sales_returns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `return_number` (`return_number`),
  ADD UNIQUE KEY `credit_note_number` (`credit_note_number`),
  ADD KEY `idx_return_inv` (`invoice_id`),
  ADD KEY `idx_return_ret` (`retailer_id`);

--
-- Indexes for table `sales_return_items`
--
ALTER TABLE `sales_return_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ret_item_parent` (`return_id`),
  ADD KEY `idx_ret_item_sku` (`sku_id`);

--
-- Indexes for table `sales_staff_details`
--
ALTER TABLE `sales_staff_details`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key_name` (`key_name`);

--
-- Indexes for table `skus`
--
ALTER TABLE `skus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku_code` (`sku_code`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sku_discounts`
--
ALTER TABLE `sku_discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sku_id` (`sku_id`);

--
-- Indexes for table `staff_routes`
--
ALTER TABLE `staff_routes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_staff_route` (`user_id`,`route_id`),
  ADD KEY `route_id` (`route_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supplier_payments`
--
ALTER TABLE `supplier_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1819;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `business_capital`
--
ALTER TABLE `business_capital`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customer_ledger`
--
ALTER TABLE `customer_ledger`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=280;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `expiry_records`
--
ALTER TABLE `expiry_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory_history`
--
ALTER TABLE `inventory_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=587;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=279;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=299;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=260;

--
-- AUTO_INCREMENT for table `retailers`
--
ALTER TABLE `retailers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `retailer_timeline`
--
ALTER TABLE `retailer_timeline`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `route_retailers`
--
ALTER TABLE `route_retailers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `route_schedules`
--
ALTER TABLE `route_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `salesman_routes`
--
ALTER TABLE `salesman_routes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales_returns`
--
ALTER TABLE `sales_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales_return_items`
--
ALTER TABLE `sales_return_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales_staff_details`
--
ALTER TABLE `sales_staff_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT for table `skus`
--
ALTER TABLE `skus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `sku_discounts`
--
ALTER TABLE `sku_discounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `staff_routes`
--
ALTER TABLE `staff_routes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `supplier_payments`
--
ALTER TABLE `supplier_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `brands`
--
ALTER TABLE `brands`
  ADD CONSTRAINT `fk_brands_suppliers` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `customer_ledger`
--
ALTER TABLE `customer_ledger`
  ADD CONSTRAINT `customer_ledger_ibfk_1` FOREIGN KEY (`retailer_id`) REFERENCES `retailers` (`id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `expiry_records`
--
ALTER TABLE `expiry_records`
  ADD CONSTRAINT `expiry_records_ibfk_1` FOREIGN KEY (`retailer_id`) REFERENCES `retailers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `expiry_records_ibfk_2` FOREIGN KEY (`sku_id`) REFERENCES `skus` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `expiry_records_ibfk_3` FOREIGN KEY (`collected_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inventory_history`
--
ALTER TABLE `inventory_history`
  ADD CONSTRAINT `inventory_history_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `skus` (`id`);

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `invoices_ibfk_2` FOREIGN KEY (`retailer_id`) REFERENCES `retailers` (`id`);

--
-- Constraints for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD CONSTRAINT `invoice_items_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `invoice_items_ibfk_2` FOREIGN KEY (`sku_id`) REFERENCES `skus` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`retailer_id`) REFERENCES `retailers` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`sku_id`) REFERENCES `skus` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_collected_by` FOREIGN KEY (`collected_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`retailer_id`) REFERENCES `retailers` (`id`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`);

--
-- Constraints for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `purchase_items_ibfk_1` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_items_ibfk_2` FOREIGN KEY (`sku_id`) REFERENCES `skus` (`id`);

--
-- Constraints for table `retailers`
--
ALTER TABLE `retailers`
  ADD CONSTRAINT `retailers_ibfk_1` FOREIGN KEY (`created_by_staff_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `retailers_ibfk_2` FOREIGN KEY (`assigned_staff_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `retailer_timeline`
--
ALTER TABLE `retailer_timeline`
  ADD CONSTRAINT `retailer_timeline_ibfk_1` FOREIGN KEY (`retailer_id`) REFERENCES `retailers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `retailer_timeline_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `route_retailers`
--
ALTER TABLE `route_retailers`
  ADD CONSTRAINT `route_retailers_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `route_retailers_ibfk_2` FOREIGN KEY (`retailer_id`) REFERENCES `retailers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `route_schedules`
--
ALTER TABLE `route_schedules`
  ADD CONSTRAINT `route_schedules_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `route_schedules_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `salesman_routes`
--
ALTER TABLE `salesman_routes`
  ADD CONSTRAINT `salesman_routes_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `salesman_routes_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales_staff_details`
--
ALTER TABLE `sales_staff_details`
  ADD CONSTRAINT `sales_staff_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `skus`
--
ALTER TABLE `skus`
  ADD CONSTRAINT `skus_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `sku_discounts`
--
ALTER TABLE `sku_discounts`
  ADD CONSTRAINT `sku_discounts_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `skus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `staff_routes`
--
ALTER TABLE `staff_routes`
  ADD CONSTRAINT `staff_routes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_routes_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
