<?php
// api/reports.php
// AJAX / Action Handler for downloading ERP CSV reports

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkRole('Owner'); // Only the Owner can export financial and operational data reports

$db = getDBConnection();
$type = $_GET['type'] ?? '';
$start_date = cleanInput($_GET['start_date'] ?? date('Y-m-d'));
$end_date = cleanInput($_GET['end_date'] ?? date('Y-m-d'));

if (empty($type)) {
    sendJSON('error', 'Report type is required.');
}

// Function to stream CSV headers and rows
function exportToCSV($filename, $headers, $rows) {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $filename . '_' . date('Ymd_His') . '.csv"');
    
    $output = fopen('php://output', 'w');
    
    // Add UTF-8 BOM for Excel formatting
    fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF));
    
    fputcsv($output, $headers);
    foreach ($rows as $row) {
        fputcsv($output, $row);
    }
    
    fclose($output);
    exit;
}

try {
    // 1. Sales Report
    if ($type === 'sales') {
        $stmt = $db->prepare("
            SELECT i.invoice_date, i.invoice_number, r.shop_name, 
                   ii.sku_name, ii.sku_code, ii.quantity, ii.selling_price, 
                   ii.discount_amount, ii.gst_percentage, ii.gst_amount, ii.total_amount
            FROM invoice_items ii
            JOIN invoices i ON ii.invoice_id = i.id
            JOIN retailers r ON i.retailer_id = r.id
            WHERE i.invoice_date BETWEEN ? AND ?
            ORDER BY i.invoice_date ASC, i.id ASC
        ");
        $stmt->execute([$start_date, $end_date]);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $headers = ['Date', 'Invoice No', 'Retailer Shop', 'SKU Name', 'SKU Code', 'Qty Billed', 'Selling Rate (₹)', 'Line Discount (₹)', 'GST %', 'GST Tax (₹)', 'Grand Total (₹)'];
        
        logActivity('Export Report', "Exported Sales CSV Report (From: {$start_date} To: {$end_date})");
        exportToCSV('sales_report', $headers, $data);
    }
    
    // 2. Collection Report
    if ($type === 'collections') {
        $stmt = $db->prepare("
            SELECT p.payment_date, p.id as receipt_no, r.shop_name, i.invoice_number,
                   p.payment_type, p.payment_method, p.amount, p.reference_number, p.remarks
            FROM payments p
            JOIN retailers r ON p.retailer_id = r.id
            LEFT JOIN invoices i ON p.invoice_id = i.id
            WHERE p.payment_date BETWEEN ? AND ?
            ORDER BY p.payment_date ASC, p.id ASC
        ");
        $stmt->execute([$start_date, $end_date]);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $headers = ['Date', 'Receipt ID', 'Retailer Shop', 'Linked Invoice', 'Allocation Type', 'Payment Mode', 'Amount Collected (₹)', 'Reference Number', 'Remarks'];
        
        logActivity('Export Report', "Exported Collections CSV Report (From: {$start_date} To: {$end_date})");
        exportToCSV('collection_report', $headers, $data);
    }
    
    // 3. Stock Valuation Report
    if ($type === 'stock') {
        $stmt = $db->query("
            SELECT b.name as brand_name, p.name as product_name, s.sku_code, s.sku_name, 
                   s.unit, s.current_stock, s.purchase_price, s.selling_price, s.mrp,
                   (s.current_stock * s.purchase_price) as cost_valuation,
                   (s.current_stock * s.selling_price) as sales_valuation
            FROM skus s
            JOIN products p ON s.product_id = p.id
            JOIN brands b ON p.brand_id = b.id
            ORDER BY b.name ASC, p.name ASC, s.sku_name ASC
        ");
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $headers = ['Brand Name', 'Product Name', 'SKU Code', 'SKU Name', 'Unit', 'Qty In Stock', 'Purchase Cost Rate (₹)', 'Selling Rate (₹)', 'MRP (₹)', 'Cost Valuation (₹)', 'Selling Valuation (₹)'];
        
        logActivity('Export Report', 'Exported Stock Valuation CSV Report');
        exportToCSV('stock_valuation_report', $headers, $data);
    }
    
    // 4. Retailer Outstandings Report
    if ($type === 'outstandings') {
        $stmt = $db->query("
            SELECT r.shop_name, r.name as owner_name, r.city, r.mobile, 
                   r.credit_limit, r.outstanding_amount, 
                   CASE 
                     WHEN r.outstanding_amount >= r.credit_limit THEN 'BLOCKED (Limit Exceeded)'
                     WHEN r.outstanding_amount >= (r.credit_limit * 0.8) THEN 'CRITICAL (Near Limit)'
                     ELSE 'Normal'
                   END as limit_status,
                   u.fullname as assigned_executive
            FROM retailers r
            LEFT JOIN users u ON r.assigned_staff_id = u.id
            ORDER BY r.outstanding_amount DESC
        ");
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $headers = ['Shop Name', 'Retailer Owner', 'City', 'Mobile', 'Credit Limit (₹)', 'Current Outstanding (₹)', 'Credit Status', 'Assigned Executive'];
        
        logActivity('Export Report', 'Exported Retailer Outstandings CSV Report');
        exportToCSV('retailer_outstandings_report', $headers, $data);
    }
    
    // 5. Sales Staff Performance Report
    if ($type === 'staff') {
        $stmt = $db->query("
            SELECT u.fullname, u.username, ssd.assigned_area, ssd.salary, ssd.sales_target,
                   COALESCE(SUM(o.grand_total), 0) as sales_achieved,
                   (COALESCE(SUM(o.grand_total), 0) - ssd.sales_target) as variance,
                   CASE 
                     WHEN ssd.sales_target > 0 THEN ROUND((COALESCE(SUM(o.grand_total), 0) / ssd.sales_target) * 100, 2)
                     ELSE 0
                   END as progress_percentage
            FROM users u
            JOIN sales_staff_details ssd ON u.id = ssd.user_id
            LEFT JOIN orders o ON u.id = o.staff_id AND o.status = 'Completed' AND MONTH(o.order_date) = MONTH(CURDATE())
            WHERE u.status = 'Active'
            GROUP BY u.id
            ORDER BY progress_percentage DESC
        ");
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $headers = ['Employee Name', 'Username', 'Assigned beat', 'Salary (₹)', 'Sales Target (₹)', 'Achieved Sales (This Month) (₹)', 'Variance (₹)', 'Target Progress %'];
        
        logActivity('Export Report', 'Exported Sales Staff Targets CSV Report');
        exportToCSV('sales_staff_performance_report', $headers, $data);
    }

    // 6. GST Sales (Outward) Report
    if ($type === 'gst_sales') {
        $stmt = $db->prepare("
            SELECT i.invoice_date, i.invoice_number, r.shop_name, r.gst_number,
                   i.subtotal, i.gst_amount, i.grand_total
            FROM invoices i
            JOIN retailers r ON i.retailer_id = r.id
            WHERE i.invoice_date BETWEEN ? AND ?
            ORDER BY i.invoice_date ASC, i.id ASC
        ");
        $stmt->execute([$start_date, $end_date]);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $headers = ['Invoice Date', 'Invoice Number', 'Retailer Shop Name', 'Retailer GSTIN', 'Taxable Subtotal (₹)', 'GST Amount (₹)', 'Grand Total (₹)'];
        
        logActivity('Export Report', "Exported GST Sales (Outward) CSV (From: {$start_date} To: {$end_date})");
        exportToCSV('gst_outward_sales_report', $headers, $data);
    }
    
    // 7. GST Purchases (Inward Product) Report
    if ($type === 'gst_purchases') {
        $stmt = $db->prepare("
            SELECT p.purchase_date, p.supplier_invoice, p.supplier_name,
                   p.subtotal, p.gst_amount, p.grand_total, p.remarks
            FROM purchases p
            WHERE p.purchase_date BETWEEN ? AND ?
            ORDER BY p.purchase_date ASC, p.id ASC
        ");
        $stmt->execute([$start_date, $end_date]);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $headers = ['Purchase Date', 'Supplier Invoice No', 'Supplier Name', 'Taxable Subtotal (₹)', 'GST Amount (₹)', 'Grand Total (₹)', 'Remarks'];
        
        logActivity('Export Report', "Exported GST Purchases (Inward) CSV (From: {$start_date} To: {$end_date})");
        exportToCSV('gst_inward_purchases_report', $headers, $data);
    }
    
    // 8. GST Expenses (Inward General/Assets) Report
    if ($type === 'gst_expenses') {
        $stmt = $db->prepare("
            SELECT e.expense_date, e.category, e.paid_to,
                   e.amount as subtotal, e.gst_percentage, e.gst_amount,
                   (e.amount + e.gst_amount) as grand_total, e.remarks
            FROM expenses e
            WHERE e.gst_amount > 0 AND e.expense_date BETWEEN ? AND ?
            ORDER BY e.expense_date ASC, e.id ASC
        ");
        $stmt->execute([$start_date, $end_date]);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $headers = ['Expense Date', 'Expense Category', 'Paid To / Vendor', 'Taxable Subtotal (₹)', 'GST %', 'GST Amount (₹)', 'Grand Total (₹)', 'Remarks/Asset Details'];
        
        logActivity('Export Report', "Exported GST Expenses (Inward) CSV (From: {$start_date} To: {$end_date})");
        exportToCSV('gst_expenses_report', $headers, $data);
    }
    
    // Fallback if none matches
    sendJSON('error', 'Report type not recognized.');
} catch (PDOException $e) {
    sendJSON('error', 'Query execution failed: ' . $e->getMessage());
}
?>
