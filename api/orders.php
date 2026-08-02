<?php
// api/orders.php
// AJAX Handler for Sales Order Creation, Statuses, and Approval workflows

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
            if ($roleName === 'Owner') {
                $stmt = $db->query("
                    SELECT o.*, r.shop_name, r.name as retailer_name, u.fullname as staff_name 
                    FROM orders o
                    JOIN retailers r ON o.retailer_id = r.id
                    JOIN users u ON o.staff_id = u.id
                    ORDER BY o.order_date DESC, o.id DESC
                ");
            } else {
                $stmt = $db->prepare("
                    SELECT o.*, r.shop_name, r.name as retailer_name, u.fullname as staff_name 
                    FROM orders o
                    JOIN retailers r ON o.retailer_id = r.id
                    JOIN users u ON o.staff_id = u.id
                    WHERE o.staff_id = ?
                    ORDER BY o.order_date DESC, o.id DESC
                ");
                $stmt->execute([$userId]);
            }
            $orders = $stmt->fetchAll();
            sendJSON('success', 'Orders loaded.', $orders);
        } catch (PDOException $e) {
            sendJSON('error', 'Failed to fetch orders: ' . $e->getMessage());
        }
    }
    
    if ($action === 'detail') {
        $id = (int)($_GET['id'] ?? 0);
        try {
            if ($roleName === 'Owner') {
                $stmt = $db->prepare("
                    SELECT o.*, r.shop_name, r.name as retailer_name, r.mobile, r.address, r.gst_number, u.fullname as staff_name 
                    FROM orders o
                    JOIN retailers r ON o.retailer_id = r.id
                    JOIN users u ON o.staff_id = u.id
                    WHERE o.id = ?
                ");
                $stmt->execute([$id]);
            } else {
                $stmt = $db->prepare("
                    SELECT o.*, r.shop_name, r.name as retailer_name, r.mobile, r.address, r.gst_number, u.fullname as staff_name 
                    FROM orders o
                    JOIN retailers r ON o.retailer_id = r.id
                    JOIN users u ON o.staff_id = u.id
                    WHERE o.id = ? AND o.staff_id = ?
                ");
                $stmt->execute([$id, $userId]);
            }
            
            $order = $stmt->fetch();
            if ($order) {
                // Fetch order items
                $stmtItems = $db->prepare("
                    SELECT oi.*, s.sku_name, s.sku_code, s.unit, s.current_stock
                    FROM order_items oi
                    JOIN skus s ON oi.sku_id = s.id
                    WHERE oi.order_id = ?
                ");
                $stmtItems->execute([$id]);
                $order['items'] = $stmtItems->fetchAll();
                
                sendJSON('success', 'Order loaded.', $order);
            } else {
                sendJSON('error', 'Order not found.');
            }
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($action === 'create') {
        $edit_order_id = (int)($_POST['edit_order_id'] ?? 0);
        $retailer_id = (int)($_POST['retailer_id'] ?? 0);
        $order_date = cleanInput($_POST['order_date'] ?? date('Y-m-d'));
        $order_mode = cleanInput($_POST['order_mode'] ?? 'By Call');
        $remarks = cleanInput($_POST['remarks'] ?? '');
        
        // Cart arrays
        $sku_ids = $_POST['sku_ids'] ?? [];
        $quantities = $_POST['quantities'] ?? [];
        $discounts = $_POST['discounts'] ?? []; // Discount percentages or flat (let's implement as flat rupee discount per line)
        
        if ($retailer_id <= 0 || empty($sku_ids) || count($sku_ids) !== count($quantities)) {
            sendJSON('error', 'Please select a retailer and add at least one item.');
        }
        
        // Basic check for assigned staff
        if ($roleName !== 'Owner') {
            $chk = $db->prepare("
                SELECT COUNT(DISTINCT r.id) 
                FROM retailers r
                JOIN route_retailers rr ON r.id = rr.retailer_id
                JOIN route_schedules rs ON rr.route_id = rs.route_id
                WHERE r.id = ? AND rs.staff_id = ?
            ");
            $chk->execute([$retailer_id, $userId]);
            if ($chk->fetchColumn() == 0) {
                sendJSON('error', 'Retailer is not assigned to you via beat routes.');
            }
        }
        
        $db->beginTransaction();
        try {
            $total_amount = 0.00;
            $discount_amount = 0.00;
            $gst_amount = 0.00;
            $grand_total = 0.00;
            
            $items_to_insert = [];
            
            for ($i = 0; $i < count($sku_ids); $i++) {
                $sku_id = (int)$sku_ids[$i];
                $qty = (int)$quantities[$i];
                $disc = (float)($discounts[$i] ?? 0.00);
                
                if ($qty <= 0) continue;
                
                // Fetch SKU price and GST details
                $stmtSku = $db->prepare("
                    SELECT s.selling_price, s.gst_percentage, s.sku_name, s.sku_code
                    FROM skus s 
                    WHERE s.id = ? AND s.status = 'Active'
                ");
                $stmtSku->execute([$sku_id]);
                $sku = $stmtSku->fetch();
                
                if (!$sku) {
                    throw new Exception("Invalid or inactive SKU selected.");
                }
                
                $price = (float)$sku['selling_price'];
                $item_subtotal = $price * $qty;
                
                // Line discount (flat amount)
                $item_disc = min($item_subtotal, $disc * $qty); 
                $taxable_value = $item_subtotal - $item_disc;
                
                // Calculate GST on top of taxable value
                $gst_pct = (float)$sku['gst_percentage'];
                $item_gst = ($taxable_value * $gst_pct) / 100;
                
                $item_total = $taxable_value + $item_gst;
                
                $total_amount += $item_subtotal;
                $discount_amount += $item_disc;
                $gst_amount += $item_gst;
                $grand_total += $item_total;
                
                $items_to_insert[] = [
                    'sku_id' => $sku_id,
                    'quantity' => $qty,
                    'price' => $price,
                    'discount_amount' => $item_disc,
                    'gst_percentage' => $gst_pct,
                    'gst_amount' => $item_gst,
                    'total_amount' => $item_total
                ];
            }
            
            if (empty($items_to_insert)) {
                throw new Exception("No valid items in the order cart.");
            }
            
            if ($edit_order_id > 0) {
                // Verify order exists and is pending
                $chkOrder = $db->prepare("SELECT status FROM orders WHERE id = ?");
                $chkOrder->execute([$edit_order_id]);
                if ($chkOrder->fetchColumn() !== 'Pending') {
                    throw new Exception("Only pending orders can be edited.");
                }
                
                $stmtDel = $db->prepare("DELETE FROM order_items WHERE order_id = ?");
                $stmtDel->execute([$edit_order_id]);
                
                $stmtOrder = $db->prepare("
                    UPDATE orders SET retailer_id = ?, staff_id = ?, order_date = ?, total_amount = ?, discount_amount = ?, gst_amount = ?, grand_total = ?, order_mode = ?, remarks = ?
                    WHERE id = ?
                ");
                $stmtOrder->execute([$retailer_id, $userId, $order_date, $total_amount, $discount_amount, $gst_amount, $grand_total, $order_mode, $remarks, $edit_order_id]);
                $orderId = $edit_order_id;
            } else {
                // Insert Order Header
                $stmtOrder = $db->prepare("
                    INSERT INTO orders (retailer_id, staff_id, order_date, total_amount, discount_amount, gst_amount, grand_total, status, order_mode, remarks)
                    VALUES (?, ?, ?, ?, ?, ?, ?, 'Pending', ?, ?)
                ");
                $stmtOrder->execute([$retailer_id, $userId, $order_date, $total_amount, $discount_amount, $gst_amount, $grand_total, $order_mode, $remarks]);
                $orderId = $db->lastInsertId();
            }
            
            // Insert Order Items
            $stmtItemInsert = $db->prepare("
                INSERT INTO order_items (order_id, sku_id, quantity, price, discount_amount, gst_percentage, gst_amount, total_amount)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ");
            
            foreach ($items_to_insert as $item) {
                $stmtItemInsert->execute([
                    $orderId, $item['sku_id'], $item['quantity'], $item['price'], 
                    $item['discount_amount'], $item['gst_percentage'], $item['gst_amount'], $item['total_amount']
                ]);
            }
            
            // Log visit history showing visit status with order creation
            $stmtTimeline = $db->prepare("
                INSERT INTO retailer_timeline (retailer_id, staff_id, visit_date, visit_status, remarks)
                VALUES (?, ?, CURDATE(), 'Visited - Order Taken', ?)
            ");
            $timelineRemarks = "Placed Order ID: {$orderId}. Total: " . formatRupees($grand_total);
            $stmtTimeline->execute([$retailer_id, $userId, $timelineRemarks]);
            
            $db->commit();
            if ($edit_order_id > 0) {
                logActivity('Update Order', "Staff updated Order ID: {$orderId} for Retailer ID: {$retailer_id}. Grand Total: {$grand_total}");
                sendJSON('success', 'Order updated successfully.', ['order_id' => $orderId]);
            } else {
                logActivity('Create Order', "Staff created Order ID: {$orderId} for Retailer ID: {$retailer_id}. Grand Total: {$grand_total}");
                sendJSON('success', 'Order created and sent for approval.', ['order_id' => $orderId]);
            }
        } catch (Exception $e) {
            $db->rollBack();
            sendJSON('error', 'Failed to save order: ' . $e->getMessage());
        }
    }
    
    // STATUS UPDATE (Owner Approves / Cancels)
    if ($action === 'update_status') {
        checkRole('Owner'); // Only the Owner can change order statuses
        
        $id = (int)($_POST['id'] ?? 0);
        $status = cleanInput($_POST['status'] ?? ''); // 'Approved', 'Cancelled', 'Processing'
        $remarks = cleanInput($_POST['remarks'] ?? '');
        
        if ($id <= 0 || !in_array($status, ['Approved', 'Cancelled', 'Processing'])) {
            sendJSON('error', 'Invalid status update parameters.');
        }
        
        try {
            $stmt = $db->prepare("UPDATE orders SET status = ?, remarks = CONCAT(COALESCE(remarks, ''), ?) WHERE id = ?");
            $appendRemarks = "\n[Status updated to {$status} by Owner. Note: {$remarks}]";
            $stmt->execute([$status, $appendRemarks, $id]);
            
            logActivity('Update Order Status', "Owner updated Order ID: {$id} to Status: {$status}");
            sendJSON('success', "Order status successfully updated to {$status}.");
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
