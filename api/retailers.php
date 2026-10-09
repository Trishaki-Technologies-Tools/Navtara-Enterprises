<?php
// api/retailers.php
// AJAX Handler for Retailer Management (CRUD, Timelines & Visits)

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$action = $_GET['action'] ?? '';
$userId = $_SESSION['user_id'];
$roleName = $_SESSION['role_name'];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if ($action === 'list') {
        try {
            $route_id = !empty($_GET['route_id']) ? (int)$_GET['route_id'] : null;
            $status = !empty($_GET['status']) ? cleanInput($_GET['status']) : null;
            
            // Owner can see all retailers, Sales Staff can see only their assigned retailers
            if ($roleName === 'Owner') {
                $sql = "
                    SELECT r.*, 
                           rt.route_name, 
                           (SELECT GROUP_CONCAT(DISTINCT u.fullname SEPARATOR ', ') 
                            FROM staff_routes sr JOIN users u ON sr.user_id = u.id 
                            WHERE sr.route_id = rt.id) as staff_names
                    FROM retailers r 
                    LEFT JOIN route_retailers rr ON r.id = rr.retailer_id
                    LEFT JOIN routes rt ON rr.route_id = rt.id
                    WHERE 1=1
                ";
                $params = [];
                if ($route_id) {
                    $sql .= " AND rr.route_id = ?";
                    $params[] = $route_id;
                }
                if ($status) {
                    $sql .= " AND r.status = ?";
                    $params[] = $status;
                }
                $sql .= " ORDER BY r.id DESC";
                $stmt = $db->prepare($sql);
                $stmt->execute($params);
            } else {
                $sql = "
                    SELECT DISTINCT r.*, 
                           rt.route_name, 
                           (SELECT GROUP_CONCAT(DISTINCT u.fullname SEPARATOR ', ') 
                            FROM staff_routes sr2 JOIN users u ON sr2.user_id = u.id 
                            WHERE sr2.route_id = rt.id) as staff_names
                    FROM retailers r 
                    JOIN route_retailers rr ON r.id = rr.retailer_id
                    JOIN routes rt ON rr.route_id = rt.id
                    JOIN staff_routes sr ON rr.route_id = sr.route_id
                    WHERE sr.user_id = ?
                ";
                $params = [$userId];
                if ($route_id) {
                    $sql .= " AND rr.route_id = ?";
                    $params[] = $route_id;
                }
                if ($status) {
                    $sql .= " AND r.status = ?";
                    $params[] = $status;
                }
                $sql .= " ORDER BY r.id DESC";
                $stmt = $db->prepare($sql);
                $stmt->execute($params);
            }
            $retailers = $stmt->fetchAll();
            sendJSON('success', 'Retailers loaded.', $retailers);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch retailers: ' . $e->getMessage());
        }
    }
    
    if ($action === 'top_purchasers') {
        try {
            $period = cleanInput($_GET['period'] ?? 'all'); // 'all', 'this_month', 'last_month', 'this_quarter', 'this_year', 'custom'
            $route_id = !empty($_GET['route_id']) ? (int)$_GET['route_id'] : null;
            $sort_by = cleanInput($_GET['sort_by'] ?? 'purchase_desc'); // 'purchase_desc', 'orders_desc', 'units_desc'
            $start_date = cleanInput($_GET['start_date'] ?? '');
            $end_date = cleanInput($_GET['end_date'] ?? '');
            
            // Build date conditions for invoices and orders
            $dateWhereInv = "1=1";
            $dateWhereOrd = "1=1";
            
            if ($period === 'this_month') {
                $start = date('Y-m-01');
                $end = date('Y-m-t');
                $dateWhereInv = "i.invoice_date BETWEEN '{$start}' AND '{$end}'";
                $dateWhereOrd = "o.order_date BETWEEN '{$start}' AND '{$end}'";
            } elseif ($period === 'last_month') {
                $start = date('Y-m-01', strtotime('first day of last month'));
                $end = date('Y-m-t', strtotime('last day of last month'));
                $dateWhereInv = "i.invoice_date BETWEEN '{$start}' AND '{$end}'";
                $dateWhereOrd = "o.order_date BETWEEN '{$start}' AND '{$end}'";
            } elseif ($period === 'this_quarter') {
                $curMonth = date('n');
                $qStartMonth = floor(($curMonth - 1) / 3) * 3 + 1;
                $start = sprintf('%04d-%02d-01', date('Y'), $qStartMonth);
                $end = date('Y-m-d');
                $dateWhereInv = "i.invoice_date BETWEEN '{$start}' AND '{$end}'";
                $dateWhereOrd = "o.order_date BETWEEN '{$start}' AND '{$end}'";
            } elseif ($period === 'this_year') {
                $start = date('Y-01-01');
                $end = date('Y-12-31');
                $dateWhereInv = "i.invoice_date BETWEEN '{$start}' AND '{$end}'";
                $dateWhereOrd = "o.order_date BETWEEN '{$start}' AND '{$end}'";
            } elseif ($period === 'custom' && !empty($start_date) && !empty($end_date)) {
                $dateWhereInv = "i.invoice_date BETWEEN '{$start_date}' AND '{$end_date}'";
                $dateWhereOrd = "o.order_date BETWEEN '{$start_date}' AND '{$end_date}'";
            }

            $baseFilter = "1=1";
            $params = [];
            
            if ($roleName !== 'Owner') {
                $baseFilter .= " AND r.id IN (
                    SELECT DISTINCT rr2.retailer_id 
                    FROM route_retailers rr2 
                    JOIN staff_routes sr2 ON rr2.route_id = sr2.route_id 
                    WHERE sr2.user_id = ?
                )";
                $params[] = $userId;
            }
            
            if ($route_id) {
                $baseFilter .= " AND rr.route_id = ?";
                $params[] = $route_id;
            }
            
            $orderBy = "total_purchased DESC, order_frequency DESC, r.id ASC";
            if ($sort_by === 'orders_desc') {
                $orderBy = "order_frequency DESC, total_purchased DESC, r.id ASC";
            } elseif ($sort_by === 'units_desc') {
                $orderBy = "total_units_bought DESC, total_purchased DESC, r.id ASC";
            }
            
            $sql = "
                SELECT 
                    r.id,
                    r.shop_name,
                    r.name as owner_name,
                    r.mobile,
                    r.area,
                    r.city,
                    r.gst_number,
                    r.is_special,
                    r.status,
                    r.outstanding_amount,
                    r.credit_limit,
                    r.visit_frequency,
                    rt.route_name,
                    rt.id as route_id,
                    (SELECT GROUP_CONCAT(DISTINCT u.fullname SEPARATOR ', ') 
                     FROM staff_routes sr JOIN users u ON sr.user_id = u.id 
                     WHERE sr.route_id = rt.id) as staff_names,
                    COALESCE(inv_agg.total_grand, 0) as total_purchased,
                    COALESCE(inv_agg.inv_count, 0) as invoice_count,
                    COALESCE(units_agg.total_units, 0) as total_units_bought,
                    COALESCE(ord_agg.ord_count, 0) as total_orders_placed,
                    GREATEST(COALESCE(inv_agg.inv_count, 0), COALESCE(ord_agg.ord_count, 0)) as order_frequency,
                    COALESCE(inv_agg.last_inv_date, ord_agg.last_ord_date) as last_purchase_date,
                    COALESCE(inv_agg.first_inv_date, ord_agg.first_ord_date) as first_purchase_date,
                    (SELECT p.payment_date FROM payments p WHERE p.retailer_id = r.id ORDER BY p.payment_date DESC, p.id DESC LIMIT 1) as last_payment_date
                FROM retailers r
                LEFT JOIN route_retailers rr ON r.id = rr.retailer_id
                LEFT JOIN routes rt ON rr.route_id = rt.id
                LEFT JOIN (
                    SELECT 
                        i.retailer_id,
                        SUM(i.grand_total) as total_grand,
                        COUNT(DISTINCT i.id) as inv_count,
                        MAX(i.invoice_date) as last_inv_date,
                        MIN(i.invoice_date) as first_inv_date
                    FROM invoices i
                    WHERE {$dateWhereInv}
                    GROUP BY i.retailer_id
                ) inv_agg ON r.id = inv_agg.retailer_id
                LEFT JOIN (
                    SELECT 
                        i.retailer_id,
                        COALESCE(SUM(ii.quantity), 0) as total_units
                    FROM invoices i
                    JOIN invoice_items ii ON i.id = ii.invoice_id
                    WHERE {$dateWhereInv}
                    GROUP BY i.retailer_id
                ) units_agg ON r.id = units_agg.retailer_id
                LEFT JOIN (
                    SELECT 
                        o.retailer_id,
                        COUNT(DISTINCT o.id) as ord_count,
                        MAX(o.order_date) as last_ord_date,
                        MIN(o.order_date) as first_ord_date
                    FROM orders o
                    WHERE {$dateWhereOrd}
                    GROUP BY o.retailer_id
                ) ord_agg ON r.id = ord_agg.retailer_id
                WHERE {$baseFilter}
                ORDER BY {$orderBy}
            ";
            
            $stmt = $db->prepare($sql);
            $stmt->execute($params);
            $retailers = $stmt->fetchAll();
            
            // Calculate aggregates & tiers
            $totalPurchases = 0;
            $totalOrders = 0;
            $totalUnits = 0;
            $activeBuyersCount = 0;
            
            foreach ($retailers as &$ret) {
                $purchased = (float)$ret['total_purchased'];
                $freq = (int)$ret['order_frequency'];
                $units = (int)$ret['total_units_bought'];
                
                $totalPurchases += $purchased;
                $totalOrders += $freq;
                $totalUnits += $units;
                
                if ($purchased > 0 || $freq > 0) {
                    $activeBuyersCount++;
                }
                
                // Assign loyalty tier based on purchase volume & frequency
                if ($purchased >= 100000 || $freq >= 12) {
                    $ret['tier'] = 'Diamond';
                    $ret['tier_badge'] = '<span class="badge bg-primary text-white"><i class="fas fa-gem me-1"></i> Diamond</span>';
                } elseif ($purchased >= 50000 || $freq >= 6) {
                    $ret['tier'] = 'Gold';
                    $ret['tier_badge'] = '<span class="badge bg-warning text-dark"><i class="fas fa-crown me-1"></i> Gold</span>';
                } elseif ($purchased >= 20000 || $freq >= 3) {
                    $ret['tier'] = 'Silver';
                    $ret['tier_badge'] = '<span class="badge bg-secondary text-white"><i class="fas fa-medal me-1"></i> Silver</span>';
                } elseif ($purchased > 0 || $freq >= 1) {
                    $ret['tier'] = 'Bronze';
                    $ret['tier_badge'] = '<span class="badge bg-info text-dark"><i class="fas fa-award me-1"></i> Bronze</span>';
                } else {
                    $ret['tier'] = 'Starter';
                    $ret['tier_badge'] = '<span class="badge bg-dark text-secondary"><i class="fas fa-user-clock me-1"></i> Starter</span>';
                }
                
                $ret['avg_order_value'] = $freq > 0 ? ($purchased / $freq) : 0;
            }
            unset($ret);
            
            sendJSON('success', 'Top purchasing retailers loaded.', [
                'retailers' => $retailers,
                'summary' => [
                    'total_purchases' => $totalPurchases,
                    'total_orders' => $totalOrders,
                    'total_units' => $totalUnits,
                    'active_buyers_count' => $activeBuyersCount,
                    'total_retailers' => count($retailers),
                    'top_buyer' => !empty($retailers) ? $retailers[0] : null,
                    'avg_purchase_per_buyer' => $activeBuyersCount > 0 ? ($totalPurchases / $activeBuyersCount) : 0
                ]
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch top purchasing retailers: ' . $e->getMessage());
        }
    }
    
    if ($action === 'outstanding_logs') {
        try {
            $route_id = !empty($_GET['route_id']) ? (int)$_GET['route_id'] : null;
            $filter = cleanInput($_GET['filter'] ?? 'all'); // 'all', 'overdue', 'above_50k', 'above_20k', 'active_only', 'include_zero'
            
            if ($roleName === 'Owner') {
                $sql = "
                    SELECT r.*, 
                           rt.route_name,
                           rt.id as route_id,
                           (SELECT GROUP_CONCAT(DISTINCT u.fullname SEPARATOR ', ') 
                            FROM staff_routes sr JOIN users u ON sr.user_id = u.id 
                            WHERE sr.route_id = rt.id) as staff_names,
                           (SELECT p.payment_date FROM payments p WHERE p.retailer_id = r.id ORDER BY p.payment_date DESC, p.id DESC LIMIT 1) as last_payment_date,
                           (SELECT p.amount FROM payments p WHERE p.retailer_id = r.id ORDER BY p.payment_date DESC, p.id DESC LIMIT 1) as last_payment_amount,
                           (SELECT p.payment_method FROM payments p WHERE p.retailer_id = r.id ORDER BY p.payment_date DESC, p.id DESC LIMIT 1) as last_payment_method,
                           (SELECT i.invoice_date FROM invoices i WHERE i.retailer_id = r.id ORDER BY i.invoice_date DESC, i.id DESC LIMIT 1) as last_invoice_date,
                           (SELECT i.invoice_number FROM invoices i WHERE i.retailer_id = r.id ORDER BY i.invoice_date DESC, i.id DESC LIMIT 1) as last_invoice_number,
                           (SELECT i.grand_total FROM invoices i WHERE i.retailer_id = r.id ORDER BY i.invoice_date DESC, i.id DESC LIMIT 1) as last_invoice_amount,
                           (SELECT COUNT(*) FROM invoices i WHERE i.retailer_id = r.id AND i.payment_status != 'Paid' AND i.outstanding_amount > 0) as unpaid_invoices_count,
                           (SELECT COALESCE(SUM(i.outstanding_amount), 0) FROM invoices i WHERE i.retailer_id = r.id AND i.payment_status != 'Paid') as invoice_pending_total
                    FROM retailers r 
                    LEFT JOIN route_retailers rr ON r.id = rr.retailer_id
                    LEFT JOIN routes rt ON rr.route_id = rt.id
                    WHERE 1=1
                ";
                $params = [];
                if ($filter !== 'include_zero') {
                    $sql .= " AND r.outstanding_amount > 0";
                }
                if ($route_id) {
                    $sql .= " AND rr.route_id = ?";
                    $params[] = $route_id;
                }
                if ($filter === 'overdue') {
                    $sql .= " AND r.outstanding_amount > r.credit_limit";
                } elseif ($filter === 'above_50k') {
                    $sql .= " AND r.outstanding_amount >= 50000";
                } elseif ($filter === 'above_20k') {
                    $sql .= " AND r.outstanding_amount >= 20000";
                } elseif ($filter === 'active_only') {
                    $sql .= " AND r.status = 'Active'";
                }
                $sql .= " ORDER BY r.outstanding_amount DESC, r.id DESC";
                $stmt = $db->prepare($sql);
                $stmt->execute($params);
            } else {
                $sql = "
                    SELECT DISTINCT r.*, 
                           rt.route_name,
                           rt.id as route_id,
                           (SELECT GROUP_CONCAT(DISTINCT u.fullname SEPARATOR ', ') 
                            FROM staff_routes sr2 JOIN users u ON sr2.user_id = u.id 
                            WHERE sr2.route_id = rt.id) as staff_names,
                           (SELECT p.payment_date FROM payments p WHERE p.retailer_id = r.id ORDER BY p.payment_date DESC, p.id DESC LIMIT 1) as last_payment_date,
                           (SELECT p.amount FROM payments p WHERE p.retailer_id = r.id ORDER BY p.payment_date DESC, p.id DESC LIMIT 1) as last_payment_amount,
                           (SELECT p.payment_method FROM payments p WHERE p.retailer_id = r.id ORDER BY p.payment_date DESC, p.id DESC LIMIT 1) as last_payment_method,
                           (SELECT i.invoice_date FROM invoices i WHERE i.retailer_id = r.id ORDER BY i.invoice_date DESC, i.id DESC LIMIT 1) as last_invoice_date,
                           (SELECT i.invoice_number FROM invoices i WHERE i.retailer_id = r.id ORDER BY i.invoice_date DESC, i.id DESC LIMIT 1) as last_invoice_number,
                           (SELECT i.grand_total FROM invoices i WHERE i.retailer_id = r.id ORDER BY i.invoice_date DESC, i.id DESC LIMIT 1) as last_invoice_amount,
                           (SELECT COUNT(*) FROM invoices i WHERE i.retailer_id = r.id AND i.payment_status != 'Paid' AND i.outstanding_amount > 0) as unpaid_invoices_count,
                           (SELECT COALESCE(SUM(i.outstanding_amount), 0) FROM invoices i WHERE i.retailer_id = r.id AND i.payment_status != 'Paid') as invoice_pending_total
                    FROM retailers r 
                    JOIN route_retailers rr ON r.id = rr.retailer_id
                    JOIN routes rt ON rr.route_id = rt.id
                    JOIN staff_routes sr ON rr.route_id = sr.route_id
                    WHERE sr.user_id = ?
                ";
                $params = [$userId];
                if ($filter !== 'include_zero') {
                    $sql .= " AND r.outstanding_amount > 0";
                }
                if ($route_id) {
                    $sql .= " AND rr.route_id = ?";
                    $params[] = $route_id;
                }
                if ($filter === 'overdue') {
                    $sql .= " AND r.outstanding_amount > r.credit_limit";
                } elseif ($filter === 'above_50k') {
                    $sql .= " AND r.outstanding_amount >= 50000";
                } elseif ($filter === 'above_20k') {
                    $sql .= " AND r.outstanding_amount >= 20000";
                } elseif ($filter === 'active_only') {
                    $sql .= " AND r.status = 'Active'";
                }
                $sql .= " ORDER BY r.outstanding_amount DESC, r.id DESC";
                $stmt = $db->prepare($sql);
                $stmt->execute($params);
            }
            $retailers = $stmt->fetchAll();
            
            // Calculate KPI aggregates
            $totalOutstanding = 0;
            $totalCreditLimit = 0;
            $overdueCount = 0;
            $totalRetailers = count($retailers);
            
            foreach ($retailers as $r) {
                $out = (float)$r['outstanding_amount'];
                $cred = (float)$r['credit_limit'];
                $totalOutstanding += $out;
                $totalCreditLimit += $cred;
                if ($out > $cred) {
                    $overdueCount++;
                }
            }
            
            sendJSON('success', 'Outstanding logs loaded.', [
                'retailers' => $retailers,
                'summary' => [
                    'total_outstanding' => $totalOutstanding,
                    'total_credit_limit' => $totalCreditLimit,
                    'total_count' => $totalRetailers,
                    'overdue_count' => $overdueCount,
                    'avg_outstanding' => $totalRetailers > 0 ? ($totalOutstanding / $totalRetailers) : 0
                ]
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch outstanding logs: ' . $e->getMessage());
        }
    }
    
    if ($action === 'outstanding_detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            // Verify access
            if ($roleName === 'Owner') {
                $stmt = $db->prepare("
                    SELECT r.*, rt.route_name, rr.route_id 
                    FROM retailers r 
                    LEFT JOIN route_retailers rr ON r.id = rr.retailer_id 
                    LEFT JOIN routes rt ON rr.route_id = rt.id
                    WHERE r.id = ?
                ");
                $stmt->execute([$id]);
            } else {
                $stmt = $db->prepare("
                    SELECT DISTINCT r.*, rt.route_name, rr.route_id 
                    FROM retailers r 
                    JOIN route_retailers rr ON r.id = rr.retailer_id 
                    JOIN routes rt ON rr.route_id = rt.id
                    JOIN staff_routes sr ON rr.route_id = sr.route_id
                    WHERE r.id = ? AND sr.user_id = ?
                ");
                $stmt->execute([$id, $userId]);
            }
            
            $retailer = $stmt->fetch();
            if ($retailer) {
                // Fetch all invoices with payment status & days aging
                $stmtInv = $db->prepare("
                    SELECT id, invoice_number, invoice_type, invoice_date, grand_total, paid_amount, outstanding_amount, payment_status, DATEDIFF(CURDATE(), invoice_date) as days_old 
                    FROM invoices 
                    WHERE retailer_id = ? 
                    ORDER BY invoice_date DESC, id DESC
                ");
                $stmtInv->execute([$id]);
                $retailer['invoices'] = $stmtInv->fetchAll();
                
                // Fetch recent payments
                $stmtPay = $db->prepare("
                    SELECT p.*, u.fullname as collector_name, i.invoice_number 
                    FROM payments p 
                    LEFT JOIN users u ON p.collected_by = u.id 
                    LEFT JOIN invoices i ON p.invoice_id = i.id 
                    WHERE p.retailer_id = ? 
                    ORDER BY p.payment_date DESC, p.id DESC 
                    LIMIT 20
                ");
                $stmtPay->execute([$id]);
                $retailer['payments'] = $stmtPay->fetchAll();
                
                sendJSON('success', 'Retailer outstanding details loaded.', $retailer);
            } else {
                sendJSON('error', 'Retailer not found or access denied.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            // Verify access
            if ($roleName === 'Owner') {
                $stmt = $db->prepare("
                    SELECT r.*, rr.route_id 
                    FROM retailers r 
                    LEFT JOIN route_retailers rr ON r.id = rr.retailer_id 
                    WHERE r.id = ?
                ");
                $stmt->execute([$id]);
            } else {
                $stmt = $db->prepare("
                    SELECT DISTINCT r.*, rr.route_id 
                    FROM retailers r 
                    JOIN route_retailers rr ON r.id = rr.retailer_id 
                    JOIN staff_routes sr ON rr.route_id = sr.route_id
                    WHERE r.id = ? AND sr.user_id = ?
                ");
                $stmt->execute([$id, $userId]);
            }
            
            $retailer = $stmt->fetch();
            if ($retailer) {
                // Fetch timeline logs too
                $stmtTimeline = $db->prepare("
                    SELECT t.*, u.fullname as staff_name 
                    FROM retailer_timeline t 
                    JOIN users u ON t.staff_id = u.id 
                    WHERE t.retailer_id = ? 
                    ORDER BY t.id DESC
                ");
                $stmtTimeline->execute([$id]);
                $retailer['timeline'] = $stmtTimeline->fetchAll();
                
                sendJSON('success', 'Retailer details loaded.', $retailer);
            } else {
                sendJSON('error', 'Retailer not found or access denied.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($action === 'create') {
        $name = cleanInput($_POST['name'] ?? '');
        $owner_name = cleanInput($_POST['owner_name'] ?? '');
        $shop_name = cleanInput($_POST['shop_name'] ?? '');
        $gst_number = cleanInput($_POST['gst_number'] ?? '');
        $mobile = cleanInput($_POST['mobile'] ?? '');
        $alternate_mobile = cleanInput($_POST['alternate_mobile'] ?? '');
        $email = cleanInput($_POST['email'] ?? '');
        $address = cleanInput($_POST['address'] ?? '');
        $area = cleanInput($_POST['area'] ?? '');
        $city = cleanInput($_POST['city'] ?? '');
        $state = cleanInput($_POST['state'] ?? 'Goa');
        $pin_code = cleanInput($_POST['pin_code'] ?? '');
        $google_map_link = cleanInput($_POST['google_map_link'] ?? '');
        $business_type = cleanInput($_POST['business_type'] ?? 'Retail Shop');
        $visit_frequency = cleanInput($_POST['visit_frequency'] ?? 'Weekly');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        
        // Owner sets assignment, credit limit, opening balance, and special retailer status
        if ($roleName === 'Owner') {
            $assigned_staff_id = !empty($_POST['assigned_staff_id']) ? (int)$_POST['assigned_staff_id'] : null;
            $credit_limit = (float)($_POST['credit_limit'] ?? 50000.00);
            $opening_balance = (float)($_POST['opening_balance'] ?? 0.00);
            $is_special = !empty($_POST['is_special']) ? 1 : 0;
        } else {
            $assigned_staff_id = $userId; // Auto-assign to creating staff
            $credit_limit = 50000.00; // Default
            $opening_balance = 0.00;
            $is_special = 0; // Sales staff cannot mark retailer as special
        }
        
        $status = cleanInput($_POST['status'] ?? 'Active');
        $route_id = !empty($_POST['route_id']) ? (int)$_POST['route_id'] : null;
        
        if (empty($name) || empty($shop_name) || empty($mobile) || empty($address) || empty($area) || empty($city) || empty($pin_code)) {
            sendJSON('error', 'All fields marked with * are required.');
        }

        // Validate staff can only assign routes assigned to them
        if ($route_id && $roleName !== 'Owner') {
            $chkRoute = $db->prepare("SELECT COUNT(*) FROM staff_routes WHERE user_id = ? AND route_id = ?");
            $chkRoute->execute([$userId, $route_id]);
            if ($chkRoute->fetchColumn() == 0) {
                sendJSON('error', 'You can only assign routes that are scheduled to you.');
            }
        }
        
        $db->beginTransaction();
        try {
            $stmt = $db->prepare("
                INSERT INTO retailers 
                (name, owner_name, shop_name, gst_number, mobile, alternate_mobile, email, address, area, city, state, pin_code, google_map_link, business_type, created_by_staff_id, credit_limit, outstanding_amount, opening_balance, status, is_special, visit_frequency, remarks) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ");
            $stmt->execute([
                $name, $owner_name, $shop_name, $gst_number, $mobile, $alternate_mobile, $email, $address, $area, $city, $state, $pin_code, $google_map_link, $business_type, $userId, $credit_limit, $opening_balance, $opening_balance, $status, $is_special, $visit_frequency, $remarks
            ]);
            $retailerId = $db->lastInsertId();
            
            // Log in customer ledger
            $stmtLedger = $db->prepare("
                INSERT INTO customer_ledger (retailer_id, transaction_type, transaction_date, reference_id, reference_type, debit_amount, credit_amount, balance, remarks) 
                VALUES (?, 'Opening Balance', CURDATE(), ?, 'None', ?, 0.00, ?, 'Retailer created with opening balance')
            ");
            $stmtLedger->execute([$retailerId, $retailerId, $opening_balance, $opening_balance]);
            
            if ($route_id) {
                $stmtRoute = $db->prepare("
                    INSERT INTO route_retailers (route_id, retailer_id, sequence_order) 
                    VALUES (?, ?, 0)
                ");
                $stmtRoute->execute([$route_id, $retailerId]);
            }
            
            $db->commit();
            logActivity('Create Retailer', "Created retailer {$shop_name} (Owner: {$owner_name})");
            sendJSON('success', 'Retailer registered successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'update') {
        $id = (int)($_POST['id'] ?? 0);
        $name = cleanInput($_POST['name'] ?? '');
        $owner_name = cleanInput($_POST['owner_name'] ?? '');
        $shop_name = cleanInput($_POST['shop_name'] ?? '');
        $gst_number = cleanInput($_POST['gst_number'] ?? '');
        $mobile = cleanInput($_POST['mobile'] ?? '');
        $alternate_mobile = cleanInput($_POST['alternate_mobile'] ?? '');
        $email = cleanInput($_POST['email'] ?? '');
        $address = cleanInput($_POST['address'] ?? '');
        $area = cleanInput($_POST['area'] ?? '');
        $city = cleanInput($_POST['city'] ?? '');
        $state = cleanInput($_POST['state'] ?? 'Goa');
        $pin_code = cleanInput($_POST['pin_code'] ?? '');
        $google_map_link = cleanInput($_POST['google_map_link'] ?? '');
        $business_type = cleanInput($_POST['business_type'] ?? 'Retail Shop');
        $visit_frequency = cleanInput($_POST['visit_frequency'] ?? 'Weekly');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        $status = cleanInput($_POST['status'] ?? 'Active');
        $route_id = !empty($_POST['route_id']) ? (int)$_POST['route_id'] : null;
        
        if ($id <= 0 || empty($name) || empty($shop_name) || empty($mobile)) {
            sendJSON('error', 'Required fields are missing.');
        }
        
        // Authorization check: Sales staff can only update their assigned retailers
        if ($roleName !== 'Owner') {
            $chk = $db->prepare("
                SELECT COUNT(*) 
                FROM route_retailers rr 
                JOIN staff_routes sr ON rr.route_id = sr.route_id 
                WHERE rr.retailer_id = ? AND sr.user_id = ?
            ");
            $chk->execute([$id, $userId]);
            if ($chk->fetchColumn() == 0) {
                sendJSON('error', 'Unauthorized operation.');
            }
            // Also validate route belongs to this staff member
            if ($route_id) {
                $chkRoute = $db->prepare("SELECT COUNT(*) FROM staff_routes WHERE user_id = ? AND route_id = ?");
                $chkRoute->execute([$userId, $route_id]);
                if ($chkRoute->fetchColumn() == 0) {
                    sendJSON('error', 'You can only assign routes that are scheduled to you.');
                }
            }
        }
        
        $db->beginTransaction();
        try {
            if ($roleName === 'Owner') {
                $credit_limit = (float)($_POST['credit_limit'] ?? 50000.00);
                $is_special = !empty($_POST['is_special']) ? 1 : 0;
                
                $stmt = $db->prepare("
                    UPDATE retailers 
                    SET name = ?, owner_name = ?, shop_name = ?, gst_number = ?, mobile = ?, alternate_mobile = ?, email = ?, address = ?, area = ?, city = ?, state = ?, pin_code = ?, google_map_link = ?, business_type = ?, credit_limit = ?, status = ?, is_special = ?, visit_frequency = ?, remarks = ?
                    WHERE id = ?
                ");
                $stmt->execute([
                    $name, $owner_name, $shop_name, $gst_number, $mobile, $alternate_mobile, $email, $address, $area, $city, $state, $pin_code, $google_map_link, $business_type, $credit_limit, $status, $is_special, $visit_frequency, $remarks, $id
                ]);
            } else {
                // Sales staff cannot change assignments, credit limits, or special retailer status
                $stmt = $db->prepare("
                    UPDATE retailers 
                    SET name = ?, owner_name = ?, shop_name = ?, gst_number = ?, mobile = ?, alternate_mobile = ?, email = ?, address = ?, area = ?, city = ?, state = ?, pin_code = ?, google_map_link = ?, business_type = ?, status = ?, visit_frequency = ?, remarks = ?
                    WHERE id = ?
                ");
                $stmt->execute([
                    $name, $owner_name, $shop_name, $gst_number, $mobile, $alternate_mobile, $email, $address, $area, $city, $state, $pin_code, $google_map_link, $business_type, $status, $visit_frequency, $remarks, $id
                ]);
            }
            
            // Update route assignment
            $stmtDelRoute = $db->prepare("DELETE FROM route_retailers WHERE retailer_id = ?");
            $stmtDelRoute->execute([$id]);
            
            if ($route_id) {
                $stmtRoute = $db->prepare("
                    INSERT INTO route_retailers (route_id, retailer_id, sequence_order) 
                    VALUES (?, ?, 0)
                ");
                $stmtRoute->execute([$route_id, $id]);
            }
            
            $db->commit();
            logActivity('Update Retailer', "Updated retailer profile: {$shop_name} (ID: {$id})");
            sendJSON('success', 'Retailer updated successfully.');
        } catch (PDOException $e) {
            $db->rollBack();
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'toggle_special') {
        checkRole('Owner'); // Only the Owner can star / unstar a retailer
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid retailer ID.');
        }
        
        try {
            $stmt = $db->prepare("UPDATE retailers SET is_special = NOT is_special WHERE id = ?");
            $stmt->execute([$id]);
            
            $stmtGet = $db->prepare("SELECT is_special, shop_name FROM retailers WHERE id = ?");
            $stmtGet->execute([$id]);
            $row = $stmtGet->fetch();
            
            $isSpecial = (int)$row['is_special'];
            $statusText = ($isSpecial === 1) ? 'marked as Special Retailer (Dynamic SKU Pricing Enabled)' : 'unmarked from Special Retailers (Standard Fixed Rates)';
            logActivity('Toggle Special Retailer', "Retailer {$row['shop_name']} {$statusText}");
            sendJSON('success', "Retailer '{$row['shop_name']}' {$statusText}.", ['is_special' => $isSpecial]);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    if ($action === 'delete') {
        checkRole('Owner'); // Only owner can delete a retailer
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) {
            sendJSON('error', 'Invalid retailer ID.');
        }
        
        try {
            // Delete customer ledger entries first if cascade not configured
            $stmt = $db->prepare("DELETE FROM customer_ledger WHERE retailer_id = ?");
            $stmt->execute([$id]);
            
            $stmt = $db->prepare("DELETE FROM retailers WHERE id = ?");
            $stmt->execute([$id]);
            
            logActivity('Delete Retailer', "Deleted retailer ID: {$id}");
            sendJSON('success', 'Retailer profile deleted successfully.');
        } catch (PDOException $e) {
            if ($e->errorInfo[1] == 1451) {
                sendJSON('error', 'Cannot delete retailer. It has transaction, invoice, or order references.');
            }
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    // ASSIGN BEAT ROUTE
    if ($action === 'assign_route') {
        $id = (int)($_POST['id'] ?? 0);
        $route_id = !empty($_POST['route_id']) ? (int)$_POST['route_id'] : null;
        if ($id <= 0) {
            sendJSON('error', 'Invalid retailer ID.');
        }
        try {
            $db->beginTransaction();
            $stmtDel = $db->prepare("DELETE FROM route_retailers WHERE retailer_id = ?");
            $stmtDel->execute([$id]);
            
            if ($route_id) {
                $stmtIns = $db->prepare("INSERT INTO route_retailers (route_id, retailer_id, sequence_order) VALUES (?, ?, 0)");
                $stmtIns->execute([$route_id, $id]);
            }
            $db->commit();
            
            logActivity('Assign Route', "Retailer ID {$id} route set to " . ($route_id ?? 'None'));
            sendJSON('success', 'Route assignment updated.');
        } catch (PDOException $e) {
            $db->rollBack();
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }

    // SALES VISITS / TIMELINE LOGGING
    if ($action === 'log_visit') {
        $retailer_id = (int)($_POST['retailer_id'] ?? 0);
        $visit_status = cleanInput($_POST['visit_status'] ?? 'Visited - No Order');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        $lat = !empty($_POST['lat']) ? (float)$_POST['lat'] : null;
        $lng = !empty($_POST['lng']) ? (float)$_POST['lng'] : null;
        
        if ($retailer_id <= 0 || empty($remarks)) {
            sendJSON('error', 'Remarks are required to register a visit.');
        }
        
        // Verify staff access to retailer
        if ($roleName !== 'Owner') {
            $chk = $db->prepare("SELECT COUNT(*) FROM route_retailers rr JOIN staff_routes sr ON rr.route_id = sr.route_id WHERE rr.retailer_id = ? AND sr.user_id = ?");
            $chk->execute([$retailer_id, $userId]);
            if ($chk->fetchColumn() == 0) {
                sendJSON('error', 'Access denied.');
            }
        }
        
        try {
            $stmt = $db->prepare("
                INSERT INTO retailer_timeline (retailer_id, staff_id, visit_date, visit_status, remarks, location_lat, location_lng)
                VALUES (?, ?, CURDATE(), ?, ?, ?, ?)
            ");
            $stmt->execute([$retailer_id, $userId, $visit_status, $remarks, $lat, $lng]);
            
            logActivity('Log Visit', "Logged visit status '{$visit_status}' for Retailer ID: {$retailer_id}");
            sendJSON('success', 'Visit details logged successfully.');
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
