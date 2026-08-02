<?php
// api/dashboard.php
// AJAX Aggregator for Dashboard KPIs, Graphs, and Lists

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();

$db = getDBConnection();
$userId = $_SESSION['user_id'];
$roleName = $_SESSION['role_name'];

function formatRupeesPHP($amount) {
    return '₹' . number_format($amount, 2);
}

try {
    $stats = [];
    
    if ($roleName === 'Owner') {
        // --- OWNER METRICS ---
        
        // Today's Orders
        $stmt = $db->prepare("SELECT COUNT(*) FROM orders WHERE order_date = CURDATE()");
        $stmt->execute();
        $today_orders_count = (int)$stmt->fetchColumn();
        
        // Today's Sales (Invoiced amount)
        $stmt = $db->prepare("SELECT COALESCE(SUM(grand_total), 0) FROM invoices WHERE invoice_date = CURDATE()");
        $stmt->execute();
        $today_sales = (float)$stmt->fetchColumn();
        
        // Monthly Sales
        $stmt = $db->prepare("SELECT COALESCE(SUM(grand_total), 0) FROM invoices WHERE MONTH(invoice_date) = MONTH(CURDATE()) AND YEAR(invoice_date) = YEAR(CURDATE())");
        $stmt->execute();
        $monthly_sales = (float)$stmt->fetchColumn();
        
        // Total Retailers Outstanding
        $stmt = $db->prepare("SELECT COALESCE(SUM(outstanding_amount), 0) FROM retailers");
        $stmt->execute();
        $outstanding_amount = (float)$stmt->fetchColumn();
        
        // Low Stock Count
        $stmt = $db->prepare("SELECT COUNT(*) FROM skus WHERE current_stock <= minimum_stock AND status = 'Active'");
        $stmt->execute();
        $low_stock_count = (int)$stmt->fetchColumn();
        
        // Build Metrics
        $stats['metrics'] = [
            'today_orders' => [
                'label' => "Today's Orders",
                'value' => $today_orders_count,
                'icon' => 'fa-shopping-cart',
                'color' => 'primary'
            ],
            'today_sales' => [
                'label' => "Today's Revenue",
                'value' => formatRupeesPHP($today_sales),
                'icon' => 'fa-file-invoice-dollar',
                'color' => 'success'
            ],
            'monthly_sales' => [
                'label' => 'Monthly Sales',
                'value' => formatRupeesPHP($monthly_sales),
                'icon' => 'fa-chart-bar',
                'color' => 'info'
            ],
            'outstanding' => [
                'label' => 'Total Outstanding',
                'value' => formatRupeesPHP($outstanding_amount),
                'icon' => 'fa-exclamation-triangle',
                'color' => 'danger'
            ],
            'low_stock' => [
                'label' => 'Low Stock Items',
                'value' => $low_stock_count,
                'icon' => 'fa-boxes',
                'color' => 'warning'
            ]
        ];
        
        // Top Selling Products (Last 30 Days)
        $stmt = $db->prepare("
            SELECT s.sku_name, s.sku_code, SUM(ii.quantity) as total_qty, SUM(ii.total_amount) as total_revenue
            FROM invoice_items ii
            JOIN invoices i ON ii.invoice_id = i.id
            JOIN skus s ON ii.sku_id = s.id
            WHERE i.invoice_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
            GROUP BY s.id, s.sku_name, s.sku_code
            ORDER BY total_qty DESC
            LIMIT 5
        ");
        $stmt->execute();
        $top_selling = $stmt->fetchAll();
        $top_selling_mapped = [];
        foreach ($top_selling as $row) {
            $top_selling_mapped[] = [
                'sku_name' => $row['sku_name'],
                'sku_code' => $row['sku_code'],
                'units_sold' => (int)$row['total_qty'],
                'revenue' => (float)$row['total_revenue']
            ];
        }
        $stats['top_selling'] = $top_selling_mapped;
        
        // Recent Orders
        $stmt = $db->prepare("
            SELECT o.id, r.shop_name, u.fullname as staff_name, o.order_date, o.grand_total, o.status 
            FROM orders o
            JOIN retailers r ON o.retailer_id = r.id
            JOIN users u ON o.staff_id = u.id
            ORDER BY o.id DESC
            LIMIT 6
        ");
        $stmt->execute();
        $stats['recent_orders'] = $stmt->fetchAll();
        
        // Chart Data - Sales Graph (Last 7 Days)
        $stmt = $db->prepare("
            SELECT DATE_FORMAT(d.date, '%b %d') as label_date, COALESCE(SUM(i.grand_total), 0) as total_sales
            FROM (
                SELECT CURDATE() as date UNION SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 4 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            ) d
            LEFT JOIN invoices i ON d.date = i.invoice_date
            GROUP BY d.date, label_date
            ORDER BY d.date ASC
        ");
        $stmt->execute();
        $sales_chart = $stmt->fetchAll();
        
        // Chart Data - Collection Graph (Last 7 Days)
        $stmt = $db->prepare("
            SELECT DATE_FORMAT(d.date, '%b %d') as label_date, COALESCE(SUM(p.amount), 0) as total_collected
            FROM (
                SELECT CURDATE() as date UNION SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 4 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            ) d
            LEFT JOIN payments p ON d.date = p.payment_date
            GROUP BY d.date, label_date
            ORDER BY d.date ASC
        ");
        $stmt->execute();
        $collection_chart = $stmt->fetchAll();
        
        // Build chart_trends
        $chart_trends = [
            'labels' => [],
            'sales' => [],
            'collections' => []
        ];
        foreach ($sales_chart as $index => $row) {
            $chart_trends['labels'][] = $row['label_date'];
            $chart_trends['sales'][] = (float)$row['total_sales'];
            
            $collected = 0.00;
            if (isset($collection_chart[$index])) {
                $collected = (float)$collection_chart[$index]['total_collected'];
            }
            $chart_trends['collections'][] = $collected;
        }
        $stats['chart_trends'] = $chart_trends;
        
        // Chart Data - Outstanding Retailers
        $stmt = $db->prepare("
            SELECT shop_name, outstanding_amount 
            FROM retailers 
            WHERE outstanding_amount > 0 
            ORDER BY outstanding_amount DESC 
            LIMIT 5
        ");
        $stmt->execute();
        $outstanding_chart = $stmt->fetchAll();
        $chart_outstanding = [
            'labels' => [],
            'values' => []
        ];
        foreach ($outstanding_chart as $row) {
            $chart_outstanding['labels'][] = $row['shop_name'];
            $chart_outstanding['values'][] = (float)$row['outstanding_amount'];
        }
        $stats['chart_outstanding'] = $chart_outstanding;
        
    } else {
        // --- SALES STAFF METRICS ---
        
        // Today's Orders (by this staff)
        $stmt = $db->prepare("SELECT COUNT(*) FROM orders WHERE staff_id = ? AND order_date = CURDATE()");
        $stmt->execute([$userId]);
        $today_orders_count = (int)$stmt->fetchColumn();
        
        // Today's Sales (Their approved orders converted to invoices today)
        $stmt = $db->prepare("
            SELECT COALESCE(SUM(i.grand_total), 0) 
            FROM invoices i
            JOIN orders o ON i.order_id = o.id
            WHERE o.staff_id = ? AND i.invoice_date = CURDATE()
        ");
        $stmt->execute([$userId]);
        $today_sales = (float)$stmt->fetchColumn();
        
        // Monthly Sales
        $stmt = $db->prepare("
            SELECT COALESCE(SUM(i.grand_total), 0) 
            FROM invoices i
            JOIN orders o ON i.order_id = o.id
            WHERE o.staff_id = ? AND MONTH(i.invoice_date) = MONTH(CURDATE()) AND YEAR(i.invoice_date) = YEAR(CURDATE())
        ");
        $stmt->execute([$userId]);
        $monthly_sales = (float)$stmt->fetchColumn();
        
        // Assigned Retailers
        $stmt = $db->prepare("SELECT COUNT(*) FROM retailers WHERE assigned_staff_id = ? AND status = 'Active'");
        $stmt->execute([$userId]);
        $total_retailers = (int)$stmt->fetchColumn();
        
        // Total Outstanding from their assigned retailers
        $stmt = $db->prepare("SELECT COALESCE(SUM(outstanding_amount), 0) FROM retailers WHERE assigned_staff_id = ?");
        $stmt->execute([$userId]);
        $outstanding_amount = (float)$stmt->fetchColumn();
        
        // Build Metrics
        $stats['metrics'] = [
            'today_orders' => [
                'label' => "Today's Orders",
                'value' => $today_orders_count,
                'icon' => 'fa-shopping-cart',
                'color' => 'primary'
            ],
            'today_sales' => [
                'label' => "Today's Revenue",
                'value' => formatRupeesPHP($today_sales),
                'icon' => 'fa-file-invoice-dollar',
                'color' => 'success'
            ],
            'monthly_sales' => [
                'label' => 'Monthly Sales',
                'value' => formatRupeesPHP($monthly_sales),
                'icon' => 'fa-chart-bar',
                'color' => 'info'
            ],
            'my_retailers' => [
                'label' => 'My Retailers',
                'value' => $total_retailers,
                'icon' => 'fa-store',
                'color' => 'warning'
            ],
            'outstanding' => [
                'label' => 'Pending Collections',
                'value' => formatRupeesPHP($outstanding_amount),
                'icon' => 'fa-exclamation-triangle',
                'color' => 'danger'
            ]
        ];
        
        // Sales Target progress
        $stmt = $db->prepare("SELECT sales_target FROM sales_staff_details WHERE user_id = ?");
        $stmt->execute([$userId]);
        $target = (float)$stmt->fetchColumn();
        $target_progress_percentage = $target > 0 ? min(100, round(($monthly_sales / $target) * 100, 1)) : 0;
        
        $stats['target_progress'] = [
            'percentage' => $target_progress_percentage,
            'achieved' => $monthly_sales,
            'target' => $target
        ];
        
        // Recent Orders
        $stmt = $db->prepare("
            SELECT o.id, r.shop_name, o.order_date, o.grand_total, o.status 
            FROM orders o
            JOIN retailers r ON o.retailer_id = r.id
            WHERE o.staff_id = ?
            ORDER BY o.id DESC
            LIMIT 5
        ");
        $stmt->execute([$userId]);
        $stats['recent_orders'] = $stmt->fetchAll();
        
        // Chart Data - My Sales Graph (Last 7 Days)
        $stmt = $db->prepare("
            SELECT DATE_FORMAT(d.date, '%b %d') as label_date, COALESCE(SUM(i.grand_total), 0) as total_sales
            FROM (
                SELECT CURDATE() as date UNION SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 4 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            ) d
            LEFT JOIN invoices i ON d.date = i.invoice_date
            LEFT JOIN orders o ON i.order_id = o.id AND o.staff_id = ?
            GROUP BY d.date, label_date
            ORDER BY d.date ASC
        ");
        $stmt->execute([$userId]);
        $sales_chart = $stmt->fetchAll();
        
        // Collection chart by this sales staff (payments collected by this staff)
        $stmt = $db->prepare("
            SELECT DATE_FORMAT(d.date, '%b %d') as label_date, COALESCE(SUM(p.amount), 0) as total_collected
            FROM (
                SELECT CURDATE() as date UNION SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 4 DAY) UNION SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY)
                UNION SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY)
            ) d
            LEFT JOIN payments p ON d.date = p.payment_date
            LEFT JOIN retailers r ON p.retailer_id = r.id AND r.assigned_staff_id = ?
            GROUP BY d.date, label_date
            ORDER BY d.date ASC
        ");
        $stmt->execute([$userId]);
        $collection_chart = $stmt->fetchAll();
        
        // Build chart_trends
        $chart_trends = [
            'labels' => [],
            'sales' => [],
            'collections' => []
        ];
        foreach ($sales_chart as $index => $row) {
            $chart_trends['labels'][] = $row['label_date'];
            $chart_trends['sales'][] = (float)$row['total_sales'];
            
            $collected = 0.00;
            if (isset($collection_chart[$index])) {
                $collected = (float)$collection_chart[$index]['total_collected'];
            }
            $chart_trends['collections'][] = $collected;
        }
        $stats['chart_trends'] = $chart_trends;
    }
    
    sendJSON('success', 'Dashboard stats retrieved successfully.', $stats);
} catch (PDOException $e) {
    sendJSON('error', 'Database error: ' . $e->getMessage());
}
?>
