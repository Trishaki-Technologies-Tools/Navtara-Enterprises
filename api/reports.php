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
function exportToCSV($filename, $headers, $rows, $title = null) {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $filename . '_' . date('Ymd_His') . '.csv"');
    
    $output = fopen('php://output', 'w');
    
    // Add UTF-8 BOM for Excel formatting
    fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF));
    
    if ($title !== null) {
        fputcsv($output, [$title]);
    }
    
    fputcsv($output, $headers);
    foreach ($rows as $row) {
        fputcsv($output, $row);
    }
    
    fclose($output);
    exit;
}

try {
    // ----------------------------------------------------
    // 1. GROSS MONTHLY EARNING FROM PRODUCT
    // ----------------------------------------------------
    if ($type === 'product_gross_earning') {
        $month = cleanInput($_GET['month'] ?? date('Y-m'));
        $productId = (int)($_GET['product_id'] ?? 0);
        $format = cleanInput($_GET['format'] ?? 'json');

        $startDate = date('Y-m-01', strtotime($month . '-01'));
        $endDate = date('Y-m-t', strtotime($month . '-01'));

        $sql = "
            SELECT 
                p.id as product_id,
                p.name as product_name,
                p.hsn_code,
                COALESCE(b.name, 'Unbranded') as brand_name,
                s.id as sku_id,
                s.sku_name,
                s.sku_code,
                s.unit,
                COALESCE(s.purchase_price, 0) as sku_purchase_price,
                COALESCE(SUM(ii.quantity), 0) as total_units_sold,
                COUNT(DISTINCT i.id) as total_invoices_count,
                COALESCE(SUM((ii.quantity * ii.selling_price) - ii.discount_amount), 0) as total_taxable_sales,
                COALESCE(SUM(ii.gst_amount), 0) as total_gst_amount,
                COALESCE(SUM(ii.total_amount), 0) as total_gross_sales,
                COALESCE(SUM(ii.quantity * COALESCE(ii.purchase_price, s.purchase_price, 0)), 0) as total_cost_of_goods,
                COALESCE(SUM(((ii.quantity * ii.selling_price) - ii.discount_amount) - (ii.quantity * COALESCE(ii.purchase_price, s.purchase_price, 0))), 0) as gross_earning
            FROM invoice_items ii
            JOIN invoices i ON ii.invoice_id = i.id
            JOIN skus s ON ii.sku_id = s.id
            JOIN products p ON s.product_id = p.id
            LEFT JOIN brands b ON p.brand_id = b.id
            WHERE i.invoice_date BETWEEN ? AND ?
              AND (? = 0 OR p.id = ?)
            GROUP BY s.id
            ORDER BY gross_earning DESC, total_units_sold DESC
        ";

        $stmt = $db->prepare($sql);
        $stmt->execute([$startDate, $endDate, $productId, $productId]);
        $items = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $totalUnits = 0;
        $totalTaxable = 0;
        $totalGrossSales = 0;
        $totalCost = 0;
        $totalGrossEarning = 0;

        foreach ($items as &$row) {
            $units = (int)$row['total_units_sold'];
            $taxable = (float)$row['total_taxable_sales'];
            $grossSales = (float)$row['total_gross_sales'];
            $cost = (float)$row['total_cost_of_goods'];
            $earning = (float)$row['gross_earning'];

            $row['avg_selling_rate'] = $units > 0 ? round($taxable / $units, 2) : 0;
            $row['avg_cost_rate'] = $units > 0 ? round($cost / $units, 2) : (float)$row['sku_purchase_price'];
            $row['margin_percentage'] = $taxable > 0 ? round(($earning / $taxable) * 100, 2) : 0;

            $totalUnits += $units;
            $totalTaxable += $taxable;
            $totalGrossSales += $grossSales;
            $totalCost += $cost;
            $totalGrossEarning += $earning;
        }
        unset($row);

        $overallMarginPct = $totalTaxable > 0 ? round(($totalGrossEarning / $totalTaxable) * 100, 2) : 0;

        if ($format === 'csv') {
            $headers = ['Month', 'Product', 'Brand', 'SKU Name', 'SKU Code', 'HSN Code', 'Units Sold', 'Invoices Count', 'Avg Selling Rate', 'Purchase Rate', 'Taxable Sales (INR)', 'Gross Sales (INR)', 'Total Cost (INR)', 'Gross Earning (INR)', 'Margin (%)'];
            $csvRows = [];
            foreach ($items as $item) {
                $csvRows[] = [
                    'Month'            => date('F Y', strtotime($startDate)),
                    'Product'          => $item['product_name'],
                    'Brand'            => $item['brand_name'],
                    'SKU Name'         => $item['sku_name'],
                    'SKU Code'         => $item['sku_code'],
                    'HSN Code'         => $item['hsn_code'] ?: '-',
                    'Units Sold'       => $item['total_units_sold'],
                    'Invoices Count'   => $item['total_invoices_count'],
                    'Avg Selling Rate' => number_format((float)$item['avg_selling_rate'], 2, '.', ''),
                    'Purchase Rate'    => number_format((float)$item['avg_cost_rate'], 2, '.', ''),
                    'Taxable Sales'    => number_format((float)$item['total_taxable_sales'], 2, '.', ''),
                    'Gross Sales'      => number_format((float)$item['total_gross_sales'], 2, '.', ''),
                    'Total Cost'       => number_format((float)$item['total_cost_of_goods'], 2, '.', ''),
                    'Gross Earning'    => number_format((float)$item['gross_earning'], 2, '.', ''),
                    'Margin (%)'       => $item['margin_percentage'] . '%'
                ];
            }
            logActivity('Export Report', "Exported Product Gross Monthly Earning CSV (Month: {$month})");
            exportToCSV('product_gross_monthly_earning_' . str_replace('-', '_', $month), $headers, $csvRows, 'Product Gross Monthly Earning Report');
        }

        sendJSON('success', 'Product gross monthly earnings loaded.', [
            'period' => [
                'month' => $month,
                'month_label' => date('F Y', strtotime($startDate)),
                'start_date' => $startDate,
                'end_date' => $endDate
            ],
            'summary' => [
                'total_units' => $totalUnits,
                'total_taxable_sales' => $totalTaxable,
                'total_gross_sales' => $totalGrossSales,
                'total_cost' => $totalCost,
                'gross_earning' => $totalGrossEarning,
                'margin_percentage' => $overallMarginPct,
                'items_count' => count($items)
            ],
            'items' => $items
        ]);
    }

    // ----------------------------------------------------
    // 2. GROSS MONTHLY EARNING FROM RETAILER
    // ----------------------------------------------------
    if ($type === 'retailer_gross_earning') {
        $month = cleanInput($_GET['month'] ?? date('Y-m'));
        $retailerId = (int)($_GET['retailer_id'] ?? 0);
        $format = cleanInput($_GET['format'] ?? 'json');

        $startDate = date('Y-m-01', strtotime($month . '-01'));
        $endDate = date('Y-m-t', strtotime($month . '-01'));

        $sql = "
            SELECT 
                r.id as retailer_id,
                r.shop_name,
                r.name as owner_name,
                r.mobile,
                r.area,
                r.city,
                r.gst_number,
                COALESCE(rt.route_name, 'No Route') as route_name,
                COUNT(DISTINCT i.id) as invoices_count,
                COALESCE(SUM(ii.quantity), 0) as total_units_bought,
                COALESCE(SUM((ii.quantity * ii.selling_price) - ii.discount_amount), 0) as total_taxable_sales,
                COALESCE(SUM(ii.total_amount), 0) as total_gross_sales,
                COALESCE(SUM(ii.quantity * COALESCE(ii.purchase_price, s.purchase_price, 0)), 0) as total_cost_of_goods,
                COALESCE(SUM(((ii.quantity * ii.selling_price) - ii.discount_amount) - (ii.quantity * COALESCE(ii.purchase_price, s.purchase_price, 0))), 0) as gross_earning,
                COALESCE((
                    SELECT SUM(p.amount)
                    FROM payments p
                    WHERE p.retailer_id = r.id
                      AND p.payment_date BETWEEN ? AND ?
                ), 0) as total_collections
            FROM retailers r
            LEFT JOIN route_retailers rr ON r.id = rr.retailer_id
            LEFT JOIN routes rt ON rr.route_id = rt.id
            LEFT JOIN invoices i ON r.id = i.retailer_id AND i.invoice_date BETWEEN ? AND ?
            LEFT JOIN invoice_items ii ON i.id = ii.invoice_id
            LEFT JOIN skus s ON ii.sku_id = s.id
            WHERE (? = 0 OR r.id = ?)
            GROUP BY r.id
            HAVING (invoices_count > 0 OR total_collections > 0 OR ? > 0)
            ORDER BY gross_earning DESC, total_gross_sales DESC
        ";

        $stmt = $db->prepare($sql);
        $stmt->execute([$startDate, $endDate, $startDate, $endDate, $retailerId, $retailerId, $retailerId]);
        $items = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $totalInvoices = 0;
        $totalUnits = 0;
        $totalTaxable = 0;
        $totalGrossSales = 0;
        $totalCost = 0;
        $totalGrossEarning = 0;
        $totalCollections = 0;

        foreach ($items as &$row) {
            $invs = (int)$row['invoices_count'];
            $units = (int)$row['total_units_bought'];
            $taxable = (float)$row['total_taxable_sales'];
            $grossSales = (float)$row['total_gross_sales'];
            $cost = (float)$row['total_cost_of_goods'];
            $earning = (float)$row['gross_earning'];
            $colls = (float)$row['total_collections'];

            $row['margin_percentage'] = $taxable > 0 ? round(($earning / $taxable) * 100, 2) : 0;

            $totalInvoices += $invs;
            $totalUnits += $units;
            $totalTaxable += $taxable;
            $totalGrossSales += $grossSales;
            $totalCost += $cost;
            $totalGrossEarning += $earning;
            $totalCollections += $colls;
        }
        unset($row);

        $overallMarginPct = $totalTaxable > 0 ? round(($totalGrossEarning / $totalTaxable) * 100, 2) : 0;

        if ($format === 'csv') {
            $headers = ['Month', 'Shop Name', 'Owner Name', 'Mobile', 'Route', 'Area', 'City', 'GSTIN', 'Invoices Count', 'Units Bought', 'Taxable Sales (INR)', 'Gross Invoiced Sales (INR)', 'Total COGS (INR)', 'Gross Earning (INR)', 'Margin (%)', 'Collections Received (INR)'];
            $csvRows = [];
            foreach ($items as $item) {
                $csvRows[] = [
                    'Month'               => date('F Y', strtotime($startDate)),
                    'Shop Name'           => $item['shop_name'],
                    'Owner Name'          => $item['owner_name'],
                    'Mobile'              => $item['mobile'],
                    'Route'               => $item['route_name'],
                    'Area'                => $item['area'] ?: '-',
                    'City'                => $item['city'] ?: '-',
                    'GSTIN'               => $item['gst_number'] ?: '-',
                    'Invoices Count'      => $item['invoices_count'],
                    'Units Bought'        => $item['total_units_bought'],
                    'Taxable Sales'       => number_format((float)$item['total_taxable_sales'], 2, '.', ''),
                    'Gross Invoiced Sales'=> number_format((float)$item['total_gross_sales'], 2, '.', ''),
                    'Total COGS'          => number_format((float)$item['total_cost_of_goods'], 2, '.', ''),
                    'Gross Earning'       => number_format((float)$item['gross_earning'], 2, '.', ''),
                    'Margin (%)'          => $item['margin_percentage'] . '%',
                    'Collections'         => number_format((float)$item['total_collections'], 2, '.', '')
                ];
            }
            logActivity('Export Report', "Exported Retailer Gross Monthly Earning CSV (Month: {$month})");
            exportToCSV('retailer_gross_monthly_earning_' . str_replace('-', '_', $month), $headers, $csvRows, 'Retailer Gross Monthly Earning Report');
        }

        sendJSON('success', 'Retailer gross monthly earnings loaded.', [
            'period' => [
                'month' => $month,
                'month_label' => date('F Y', strtotime($startDate)),
                'start_date' => $startDate,
                'end_date' => $endDate
            ],
            'summary' => [
                'total_invoices' => $totalInvoices,
                'total_units' => $totalUnits,
                'total_taxable_sales' => $totalTaxable,
                'total_gross_sales' => $totalGrossSales,
                'total_cost' => $totalCost,
                'gross_earning' => $totalGrossEarning,
                'margin_percentage' => $overallMarginPct,
                'total_collections' => $totalCollections,
                'retailers_count' => count($items)
            ],
            'items' => $items
        ]);
    }

    // ----------------------------------------------------
    // Legacy / General Reports (Optional)
    // ----------------------------------------------------
    if ($type === 'sales') {
        $companyState = getCompanyState();

        $stmt = $db->prepare("
            SELECT 
                i.invoice_number,
                r.shop_name,
                r.name as retailer_name,
                r.gst_number,
                i.invoice_date,
                i.grand_total as invoice_value,
                ii.gst_percentage,
                ii.discount_amount,
                ((ii.quantity * ii.selling_price) - ii.discount_amount) as taxable_value,
                ii.gst_amount,
                r.state as retailer_state,
                p.hsn_code,
                ii.quantity
            FROM invoice_items ii
            JOIN invoices i ON ii.invoice_id = i.id
            JOIN retailers r ON i.retailer_id = r.id
            JOIN skus s ON ii.sku_id = s.id
            JOIN products p ON s.product_id = p.id
            WHERE i.invoice_date BETWEEN ? AND ?
            ORDER BY i.invoice_date ASC, i.id ASC, ii.id ASC
        ");
        $stmt->execute([$start_date, $end_date]);
        $rawSales = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $rows = [];
        foreach ($rawSales as $item) {
            $isInterState = (!empty($item['retailer_state']) && strcasecmp(trim($item['retailer_state']), trim($companyState)) !== 0);
            $gstAmount = (float)$item['gst_amount'];
            
            $igst = $isInterState ? number_format($gstAmount, 2, '.', '') : '0';
            $cgst = !$isInterState ? number_format($gstAmount / 2, 2, '.', '') : '0';
            $sgst = !$isInterState ? number_format($gstAmount / 2, 2, '.', '') : '0';
            
            $gstin = trim($item['gst_number'] ?? '');
            $b2b_b2c = !empty($gstin) ? 'B2B' : 'B2C';
            $stateOfSupply = !empty($item['retailer_state']) ? strtoupper(trim($item['retailer_state'])) : strtoupper($companyState);
            $hsn = !empty($item['hsn_code']) ? trim($item['hsn_code']) : '33074100';
            
            $rows[] = [
                'Invoice No.'      => $item['invoice_number'],
                'Customer Name'    => $item['shop_name'] ?: ($item['retailer_name'] ?: 'COUNTER SALE'),
                'GSTIN'            => $gstin,
                'Invoice Date'     => date('d/m/Y', strtotime($item['invoice_date'])),
                'Invoice Value'    => number_format((float)$item['invoice_value'], 2, '.', ''),
                'Tax Rate(%)'      => (float)$item['gst_percentage'],
                'Discount'         => number_format((float)$item['discount_amount'], 2, '.', ''),
                'Taxable value'    => number_format((float)$item['taxable_value'], 2, '.', ''),
                'IGST'             => $igst,
                'Central Tax'      => $cgst,
                'State Tax'        => $sgst,
                'Cess'             => '0',
                'State of supply'  => $stateOfSupply,
                'Reverse Charge'   => 'N',
                'HSN/SAC Code'     => $hsn,
                'Qty'              => (int)$item['quantity'],
                'B2B/B2C'          => $b2b_b2c
            ];
        }
        
        $headers = ['Invoice No.', 'Customer Name', 'GSTIN', 'Invoice Date', 'Invoice Value', 'Tax Rate(%)', 'Discount', 'Taxable value', 'IGST', 'Central Tax', 'State Tax', 'Cess', 'State of supply', 'Reverse Charge', 'HSN/SAC Code', 'Qty', 'B2B/B2C'];
        
        logActivity('Export Report', "Exported Sales CSV Report (From: {$start_date} To: {$end_date})");
        exportToCSV('sales_report', $headers, $rows, 'Sales');
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
        $companyState = getCompanyState();

        $stmt = $db->prepare("
            SELECT 
                i.invoice_number,
                r.shop_name,
                r.name as retailer_name,
                r.gst_number,
                i.invoice_date,
                i.grand_total as invoice_value,
                ii.gst_percentage,
                ii.discount_amount,
                ((ii.quantity * ii.selling_price) - ii.discount_amount) as taxable_value,
                ii.gst_amount,
                r.state as retailer_state,
                p.hsn_code,
                ii.quantity
            FROM invoice_items ii
            JOIN invoices i ON ii.invoice_id = i.id
            JOIN retailers r ON i.retailer_id = r.id
            JOIN skus s ON ii.sku_id = s.id
            JOIN products p ON s.product_id = p.id
            WHERE i.invoice_date BETWEEN ? AND ?
            ORDER BY i.invoice_date ASC, i.id ASC, ii.id ASC
        ");
        $stmt->execute([$start_date, $end_date]);
        $rawSales = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $rows = [];
        foreach ($rawSales as $item) {
            $isInterState = (!empty($item['retailer_state']) && strcasecmp(trim($item['retailer_state']), trim($companyState)) !== 0);
            $gstAmount = (float)$item['gst_amount'];
            
            $igst = $isInterState ? number_format($gstAmount, 2, '.', '') : '0';
            $cgst = !$isInterState ? number_format($gstAmount / 2, 2, '.', '') : '0';
            $sgst = !$isInterState ? number_format($gstAmount / 2, 2, '.', '') : '0';
            
            $gstin = trim($item['gst_number'] ?? '');
            $b2b_b2c = !empty($gstin) ? 'B2B' : 'B2C';
            $stateOfSupply = !empty($item['retailer_state']) ? strtoupper(trim($item['retailer_state'])) : strtoupper($companyState);
            $hsn = !empty($item['hsn_code']) ? trim($item['hsn_code']) : '33074100';
            
            $rows[] = [
                'Invoice No.'      => $item['invoice_number'],
                'Customer Name'    => $item['shop_name'] ?: ($item['retailer_name'] ?: 'COUNTER SALE'),
                'GSTIN'            => $gstin,
                'Invoice Date'     => date('d/m/Y', strtotime($item['invoice_date'])),
                'Invoice Value'    => number_format((float)$item['invoice_value'], 2, '.', ''),
                'Tax Rate(%)'      => (float)$item['gst_percentage'],
                'Discount'         => number_format((float)$item['discount_amount'], 2, '.', ''),
                'Taxable value'    => number_format((float)$item['taxable_value'], 2, '.', ''),
                'IGST'             => $igst,
                'Central Tax'      => $cgst,
                'State Tax'        => $sgst,
                'Cess'             => '0',
                'State of supply'  => $stateOfSupply,
                'Reverse Charge'   => 'N',
                'HSN/SAC Code'     => $hsn,
                'Qty'              => (int)$item['quantity'],
                'B2B/B2C'          => $b2b_b2c
            ];
        }
        
        $headers = ['Invoice No.', 'Customer Name', 'GSTIN', 'Invoice Date', 'Invoice Value', 'Tax Rate(%)', 'Discount', 'Taxable value', 'IGST', 'Central Tax', 'State Tax', 'Cess', 'State of supply', 'Reverse Charge', 'HSN/SAC Code', 'Qty', 'B2B/B2C'];
        
        logActivity('Export Report', "Exported GST Sales (Outward) CSV (From: {$start_date} To: {$end_date})");
        exportToCSV('gst_outward_sales_report', $headers, $rows, 'Sales');
    }
    
    // 7. GST Purchases (Inward Product) Report
    if ($type === 'gst_purchases') {
        $companyState = getCompanyState();
        $companyGst = trim(getSetting('company_gst', ''));
        $myStatePrefix = !empty($companyGst) && strlen($companyGst) >= 2 ? substr($companyGst, 0, 2) : '29';

        $stmt = $db->prepare("
            SELECT 
                p.supplier_invoice as invoice_number,
                p.supplier_name,
                sup.gst_number,
                p.purchase_date as invoice_date,
                p.grand_total as invoice_value,
                pi.gst_percentage,
                pi.discount_amount,
                ((pi.quantity * pi.purchase_price) - pi.discount_amount) as taxable_value,
                pi.gst_amount,
                p.remarks,
                pr.hsn_code,
                pi.quantity
            FROM purchase_items pi
            JOIN purchases p ON pi.purchase_id = p.id
            LEFT JOIN suppliers sup ON p.supplier_name = sup.name
            JOIN skus s ON pi.sku_id = s.id
            JOIN products pr ON s.product_id = pr.id
            WHERE p.purchase_date BETWEEN ? AND ?
            ORDER BY p.purchase_date ASC, p.id ASC, pi.id ASC
        ");
        $stmt->execute([$start_date, $end_date]);
        $rawPurchases = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $rows = [];
        foreach ($rawPurchases as $item) {
            $gstAmount = (float)$item['gst_amount'];
            $gstin = trim($item['gst_number'] ?? '');
            
            $isInterState = false;
            if (!empty($gstin) && strlen($gstin) >= 2) {
                $gstPrefix = substr($gstin, 0, 2);
                if ($gstPrefix !== $myStatePrefix) {
                    $isInterState = true;
                }
            }
            
            $igst = $isInterState ? number_format($gstAmount, 2, '.', '') : '0';
            $cgst = !$isInterState ? number_format($gstAmount / 2, 2, '.', '') : '0';
            $sgst = !$isInterState ? number_format($gstAmount / 2, 2, '.', '') : '0';
            
            $stateOfSupply = strtoupper($companyState);
            $hsn = !empty($item['hsn_code']) ? trim($item['hsn_code']) : '33074100';
            
            $rows[] = [
                'Invoice No.'      => $item['invoice_number'],
                'Customer Name'    => $item['supplier_name'],
                'GSTIN'            => $gstin,
                'Invoice Date'     => date('d/m/Y', strtotime($item['invoice_date'])),
                'Invoice Value'    => number_format((float)$item['invoice_value'], 2, '.', ''),
                'Tax Rate(%)'      => (float)$item['gst_percentage'],
                'Discount'         => number_format((float)$item['discount_amount'], 2, '.', ''),
                'Taxable value'    => number_format((float)$item['taxable_value'], 2, '.', ''),
                'IGST'             => $igst,
                'Central Tax'      => $cgst,
                'State Tax'        => $sgst,
                'Cess'             => '0',
                'State of supply'  => $stateOfSupply,
                'Reverse Charge'   => 'N',
                'HSN/SAC Code'     => $hsn,
                'Qty'              => (int)$item['quantity'],
                'B2B/B2C'          => 'B2B'
            ];
        }
        
        $headers = ['Invoice No.', 'Customer Name', 'GSTIN', 'Invoice Date', 'Invoice Value', 'Tax Rate(%)', 'Discount', 'Taxable value', 'IGST', 'Central Tax', 'State Tax', 'Cess', 'State of supply', 'Reverse Charge', 'HSN/SAC Code', 'Qty', 'B2B/B2C'];
        
        logActivity('Export Report', "Exported GST Purchases (Inward) CSV (From: {$start_date} To: {$end_date})");
        exportToCSV('gst_inward_purchases_report', $headers, $rows, 'Purchases');
    }
    
    // 8. GST Expenses (Inward General/Assets) Report
    if ($type === 'gst_expenses') {
        $companyState = getCompanyState();

        $stmt = $db->prepare("
            SELECT 
                e.id,
                e.expense_date,
                e.category,
                e.paid_to,
                e.amount as taxable_value,
                e.gst_percentage,
                e.gst_amount,
                (e.amount + e.gst_amount) as invoice_value,
                e.remarks
            FROM expenses e
            WHERE e.gst_amount > 0 AND e.expense_date BETWEEN ? AND ?
            ORDER BY e.expense_date ASC, e.id ASC
        ");
        $stmt->execute([$start_date, $end_date]);
        $rawExpenses = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $rows = [];
        foreach ($rawExpenses as $item) {
            $gstAmount = (float)$item['gst_amount'];
            $cgst = number_format($gstAmount / 2, 2, '.', '');
            $sgst = number_format($gstAmount / 2, 2, '.', '');
            
            $rows[] = [
                'Invoice No.'      => 'EXP-' . str_pad($item['id'], 5, '0', STR_PAD_LEFT),
                'Customer Name'    => $item['paid_to'] ?: $item['category'],
                'GSTIN'            => '',
                'Invoice Date'     => date('d/m/Y', strtotime($item['expense_date'])),
                'Invoice Value'    => number_format((float)$item['invoice_value'], 2, '.', ''),
                'Tax Rate(%)'      => (float)$item['gst_percentage'],
                'Discount'         => '0.00',
                'Taxable value'    => number_format((float)$item['taxable_value'], 2, '.', ''),
                'IGST'             => '0',
                'Central Tax'      => $cgst,
                'State Tax'        => $sgst,
                'Cess'             => '0',
                'State of supply'  => strtoupper($companyState),
                'Reverse Charge'   => 'N',
                'HSN/SAC Code'     => '9983',
                'Qty'              => 1,
                'B2B/B2C'          => 'B2B'
            ];
        }
        
        $headers = ['Invoice No.', 'Customer Name', 'GSTIN', 'Invoice Date', 'Invoice Value', 'Tax Rate(%)', 'Discount', 'Taxable value', 'IGST', 'Central Tax', 'State Tax', 'Cess', 'State of supply', 'Reverse Charge', 'HSN/SAC Code', 'Qty', 'B2B/B2C'];
        
        logActivity('Export Report', "Exported GST Expenses (Inward) CSV (From: {$start_date} To: {$end_date})");
        exportToCSV('gst_expenses_report', $headers, $rows, 'Expenses');
    }
    
    // Fallback if none matches
    sendJSON('error', 'Report type not recognized.');
} catch (PDOException $e) {
    sendJSON('error', 'Query execution failed: ' . $e->getMessage());
}
?>
