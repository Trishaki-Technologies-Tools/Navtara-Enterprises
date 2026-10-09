<?php
// api/gst.php
// AJAX Handler for GST Reporting

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkAuth();
checkRole('Owner');

$db = getDBConnection();
$start_date = cleanInput($_GET['start_date'] ?? date('Y-m-01'));
$end_date = cleanInput($_GET['end_date'] ?? date('Y-m-d'));

try {
    // 1. Outward GST (Sales Invoices to Retailers)
    $stmtSales = $db->prepare("
        SELECT i.invoice_date, i.invoice_number, r.shop_name, r.gst_number, 
               i.subtotal, COALESCE(i.discount_amount, 0) as discount_amount, i.gst_amount, i.grand_total 
        FROM invoices i 
        JOIN retailers r ON i.retailer_id = r.id 
        WHERE i.invoice_date BETWEEN ? AND ? 
        ORDER BY i.invoice_date ASC, i.id ASC
    ");
    $stmtSales->execute([$start_date, $end_date]);
    $sales = $stmtSales->fetchAll(PDO::FETCH_ASSOC);

    // 2. Inward GST (Product Purchases from Suppliers)
    $stmtPurchases = $db->prepare("
        SELECT p.id, p.purchase_date, p.supplier_invoice, p.supplier_name, 
               p.subtotal, COALESCE(p.discount_amount, 0) as discount_amount, p.gst_amount, p.grand_total, p.remarks
        FROM purchases p 
        WHERE p.purchase_date BETWEEN ? AND ? 
        ORDER BY p.purchase_date ASC, p.id ASC
    ");
    $stmtPurchases->execute([$start_date, $end_date]);
    $purchases = $stmtPurchases->fetchAll(PDO::FETCH_ASSOC);

    // 3. Expense/Asset Inward GST
    $stmtExpenses = $db->prepare("
        SELECT e.expense_date, e.category, e.paid_to, 
               e.amount as subtotal, e.gst_percentage, e.gst_amount, 
               (e.amount + e.gst_amount) as grand_total, e.remarks
        FROM expenses e 
        WHERE e.gst_amount > 0 AND e.expense_date BETWEEN ? AND ? 
        ORDER BY e.expense_date ASC, e.id ASC
    ");
    $stmtExpenses->execute([$start_date, $end_date]);
    $expenses = $stmtExpenses->fetchAll(PDO::FETCH_ASSOC);

    // 4. Sales Returns / Credit Notes (GST Output Reversals)
    $stmtCreditNotes = $db->prepare("
        SELECT sr.return_date, sr.credit_note_number, sr.return_number, i.invoice_number, 
               r.shop_name, r.gst_number, sr.taxable_amount, sr.gst_amount, sr.total_amount, sr.reason 
        FROM sales_returns sr 
        JOIN retailers r ON sr.retailer_id = r.id 
        JOIN invoices i ON sr.invoice_id = i.id 
        WHERE sr.status = 'Approved' AND sr.return_date BETWEEN ? AND ? 
        ORDER BY sr.return_date ASC, sr.id ASC
    ");
    $stmtCreditNotes->execute([$start_date, $end_date]);
    $creditNotes = $stmtCreditNotes->fetchAll(PDO::FETCH_ASSOC);

    // Calculate summaries
    $gross_outward_gst = array_sum(array_column($sales, 'gst_amount'));
    $total_credit_notes_gst = array_sum(array_column($creditNotes, 'gst_amount'));
    $net_outward_gst = max(0, $gross_outward_gst - $total_credit_notes_gst);

    $total_purchase_gst = array_sum(array_column($purchases, 'gst_amount'));
    $total_expense_gst = array_sum(array_column($expenses, 'gst_amount'));
    $total_inward_gst = $total_purchase_gst + $total_expense_gst;
    $net_payable = $net_outward_gst - $total_inward_gst;

    $summary = [
        'gross_outward_gst' => $gross_outward_gst,
        'total_credit_notes_gst' => $total_credit_notes_gst,
        'total_outward_gst' => $net_outward_gst,
        'total_purchase_gst' => $total_purchase_gst,
        'total_expense_gst' => $total_expense_gst,
        'total_inward_gst' => $total_inward_gst,
        'net_payable' => $net_payable
    ];

    sendJSON('success', 'GST report loaded.', [
        'summary' => $summary,
        'sales' => $sales,
        'credit_notes' => $creditNotes,
        'purchases' => $purchases,
        'expenses' => $expenses
    ]);
} catch (PDOException $e) {
    sendJSON('error', 'Database error: ' . $e->getMessage());
}
