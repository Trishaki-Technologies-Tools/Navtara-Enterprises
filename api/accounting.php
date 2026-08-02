<?php
// api/accounting.php
// AJAX Handler for Accounting Ledgers, Registers, Books and Profit & Loss summaries

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/functions.php';

checkRole('Owner'); // Only the Owner has access to financial accounting records

$db = getDBConnection();
$action = $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    
    // 1. Customer Ledger
    if ($action === 'customer_ledger') {
        $retailer_id = (int)($_GET['retailer_id'] ?? 0);
        $start_date = cleanInput($_GET['start_date'] ?? date('Y-01-01'));
        $end_date = cleanInput($_GET['end_date'] ?? date('Y-12-31'));
        
        if ($retailer_id <= 0) {
            sendJSON('error', 'Please select a retailer.');
        }
        
        try {
            // Fetch ledger entries
            $stmt = $db->prepare("
                SELECT cl.*, 
                       CASE 
                         WHEN cl.transaction_type = 'Invoice' THEN (SELECT invoice_number FROM invoices WHERE id = cl.reference_id)
                         WHEN cl.transaction_type = 'Payment' THEN (SELECT reference_number FROM payments WHERE id = cl.reference_id)
                         ELSE ''
                       END as doc_no
                FROM customer_ledger cl
                WHERE cl.retailer_id = ? AND cl.transaction_date BETWEEN ? AND ?
                ORDER BY cl.transaction_date ASC, cl.id ASC
            ");
            $stmt->execute([$retailer_id, $start_date, $end_date]);
            $entries = $stmt->fetchAll();
            
            // Get opening balance before start_date
            $stmtOp = $db->prepare("
                SELECT COALESCE(SUM(debit_amount - credit_amount), 0) 
                FROM customer_ledger 
                WHERE retailer_id = ? AND transaction_date < ?
            ");
            $stmtOp->execute([$retailer_id, $start_date]);
            $opening_balance = (float)$stmtOp->fetchColumn();
            
            sendJSON('success', 'Customer ledger loaded.', [
                'opening_balance' => $opening_balance,
                'entries' => $entries
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    // 2. Cash Book (Cash Payments & Expenses)
    if ($action === 'cash_book') {
        $start_date = cleanInput($_GET['start_date'] ?? date('Y-m-d'));
        $end_date = cleanInput($_GET['end_date'] ?? date('Y-m-d'));
        
        try {
            // Cash Collections (Credits to Cash book)
            $stmtIn = $db->prepare("
                SELECT p.payment_date as trans_date, 'Collection' as type, 
                       r.shop_name as particulars, p.amount as debit, 0.00 as credit, 
                       CONCAT('Ref: ', COALESCE(p.reference_number, 'N/A'), ' - ', COALESCE(p.remarks, '')) as remarks
                FROM payments p
                JOIN retailers r ON p.retailer_id = r.id
                WHERE p.payment_method = 'Cash' AND p.payment_date BETWEEN ? AND ?
            ");
            $stmtIn->execute([$start_date, $end_date]);
            $cashIn = $stmtIn->fetchAll();
            
            // Cash Expenses (Debits from Cash book)
            $stmtOut = $db->prepare("
                SELECT expense_date as trans_date, 'Expense' as type, 
                       category as particulars, 0.00 as debit, (amount + gst_amount) as credit, 
                       CONCAT('Paid to: ', COALESCE(paid_to, 'N/A'), ' - ', COALESCE(remarks, '')) as remarks
                FROM expenses
                WHERE payment_method = 'Cash' AND expense_date BETWEEN ? AND ?
            ");
            $stmtOut->execute([$start_date, $end_date]);
            $cashOut = $stmtOut->fetchAll();
            
            // Merge & Sort
            $cashBook = array_merge($cashIn, $cashOut);
            usort($cashBook, function($a, $b) {
                return strcmp($a['trans_date'], $b['trans_date']);
            });
            
            // Calculate Opening Cash balance (payments in cash - expenses before start_date)
            $stmtOpIn = $db->prepare("SELECT COALESCE(SUM(amount), 0) FROM payments WHERE payment_method = 'Cash' AND payment_date < ?");
            $stmtOpIn->execute([$start_date]);
            $opIn = (float)$stmtOpIn->fetchColumn();
            
            $stmtOpOut = $db->prepare("SELECT COALESCE(SUM(amount + gst_amount), 0) FROM expenses WHERE payment_method = 'Cash' AND expense_date < ?");
            $stmtOpOut->execute([$start_date]);
            $opOut = (float)$stmtOpOut->fetchColumn();
            
            $opening_cash = $opIn - $opOut;
            
            sendJSON('success', 'Cash book retrieved.', [
                'opening_cash' => $opening_cash,
                'entries' => $cashBook
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    // 3. Bank Book (Digital payments & expenses collected)
    if ($action === 'bank_book') {
        $start_date = cleanInput($_GET['start_date'] ?? date('Y-m-d'));
        $end_date = cleanInput($_GET['end_date'] ?? date('Y-m-d'));
        
        try {
            // Bank Inflows (Receipts)
            $stmtIn = $db->prepare("
                SELECT p.payment_date as trans_date, p.payment_method as type, 
                       r.shop_name as particulars, p.amount as debit, 0.00 as credit, 
                       CONCAT('Ref: ', COALESCE(p.reference_number, 'N/A'), ' (', p.payment_type, ')') as remarks
                FROM payments p
                JOIN retailers r ON p.retailer_id = r.id
                WHERE p.payment_method != 'Cash' AND p.payment_date BETWEEN ? AND ?
            ");
            $stmtIn->execute([$start_date, $end_date]);
            $bankIn = $stmtIn->fetchAll();
            
            // Bank Outflows (Expenses)
            $stmtOut = $db->prepare("
                SELECT expense_date as trans_date, payment_method as type, 
                       category as particulars, 0.00 as debit, (amount + gst_amount) as credit, 
                       CONCAT('Paid to: ', COALESCE(paid_to, 'N/A'), ' - ', COALESCE(remarks, '')) as remarks
                FROM expenses
                WHERE payment_method != 'Cash' AND expense_date BETWEEN ? AND ?
            ");
            $stmtOut->execute([$start_date, $end_date]);
            $bankOut = $stmtOut->fetchAll();
            
            // Merge & Sort
            $bankBook = array_merge($bankIn, $bankOut);
            usort($bankBook, function($a, $b) {
                return strcmp($a['trans_date'], $b['trans_date']);
            });
            
            // Calculate Opening bank balance
            $stmtOpIn = $db->prepare("SELECT COALESCE(SUM(amount), 0) FROM payments WHERE payment_method != 'Cash' AND payment_date < ?");
            $stmtOpIn->execute([$start_date]);
            $opIn = (float)$stmtOpIn->fetchColumn();
            
            $stmtOpOut = $db->prepare("SELECT COALESCE(SUM(amount + gst_amount), 0) FROM expenses WHERE payment_method != 'Cash' AND expense_date < ?");
            $stmtOpOut->execute([$start_date]);
            $opOut = (float)$stmtOpOut->fetchColumn();
            
            $opening_bank = $opIn - $opOut;
            
            sendJSON('success', 'Bank book retrieved.', [
                'opening_bank' => $opening_bank,
                'entries' => $bankBook
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    // 4. Day Book (Combined day register)
    if ($action === 'day_book') {
        $date = cleanInput($_GET['date'] ?? date('Y-m-d'));
        
        try {
            // Invoices
            $stmtInv = $db->prepare("
                SELECT 'Invoice' as entry_type, invoice_number as doc_no, r.shop_name as particulars, 
                       grand_total as debit, 0.00 as credit, remarks 
                FROM invoices i
                JOIN retailers r ON i.retailer_id = r.id
                WHERE i.invoice_date = ?
            ");
            $stmtInv->execute([$date]);
            $invoices = $stmtInv->fetchAll();
            
            // Payments
            $stmtPay = $db->prepare("
                SELECT 'Receipt' as entry_type, COALESCE(p.reference_number, 'REC') as doc_no, r.shop_name as particulars, 
                       0.00 as debit, p.amount as credit, CONCAT(p.payment_method, ' - ', COALESCE(p.remarks, '')) as remarks 
                FROM payments p
                JOIN retailers r ON p.retailer_id = r.id
                WHERE p.payment_date = ?
            ");
            $stmtPay->execute([$date]);
            $payments = $stmtPay->fetchAll();
            
            // Expenses
            $stmtExp = $db->prepare("
                SELECT 'Expense' as entry_type, 'EXP' as doc_no, category as particulars, 
                       0.00 as debit, (amount + gst_amount) as credit, CONCAT('Paid to: ', COALESCE(paid_to, ''), ' - ', COALESCE(remarks, '')) as remarks 
                FROM expenses 
                WHERE expense_date = ?
            ");
            $stmtExp->execute([$date]);
            $expenses = $stmtExp->fetchAll();
            
            $dayBook = array_merge($invoices, $payments, $expenses);
            
            sendJSON('success', 'Day book retrieved.', $dayBook);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
    
    // 5. Profit & Loss Summary
    if ($action === 'profit_loss') {
        $start_date = cleanInput($_GET['start_date'] ?? date('Y-m-01'));
        $end_date = cleanInput($_GET['end_date'] ?? date('Y-m-t'));
        
        try {
            // Total Revenue (Sales)
            $stmtRev = $db->prepare("
                SELECT COALESCE(SUM(grand_total), 0) as total_sales, 
                       COALESCE(SUM(subtotal), 0) as taxable_sales, 
                       COALESCE(SUM(gst_amount), 0) as tax_collected
                FROM invoices 
                WHERE invoice_date BETWEEN ? AND ?
            ");
            $stmtRev->execute([$start_date, $end_date]);
            $salesSummary = $stmtRev->fetch();
            
            // Cost of Goods Sold (COGS) based on purchase price recorded in invoice_items
            $stmtCogs = $db->prepare("
                SELECT COALESCE(SUM(ii.purchase_price * ii.quantity), 0) as cogs
                FROM invoice_items ii
                JOIN invoices i ON ii.invoice_id = i.id
                WHERE i.invoice_date BETWEEN ? AND ?
            ");
            $stmtCogs->execute([$start_date, $end_date]);
            $cogs = (float)$stmtCogs->fetchColumn();
            
            // Total Expenses
            $stmtExp = $db->prepare("
                SELECT category, SUM(amount) as total_amount 
                FROM expenses 
                WHERE expense_date BETWEEN ? AND ?
                GROUP BY category
            ");
            $stmtExp->execute([$start_date, $end_date]);
            $expenses = $stmtExp->fetchAll();
            
            $totalExpenses = array_sum(array_column($expenses, 'total_amount'));
            
            // Calculations
            $grossProfit = (float)$salesSummary['taxable_sales'] - $cogs;
            $netProfit = $grossProfit - $totalExpenses;
            
            sendJSON('success', 'Profit & Loss calculated.', [
                'sales_revenue' => (float)$salesSummary['total_sales'],
                'taxable_revenue' => (float)$salesSummary['taxable_sales'],
                'gst_collected' => (float)$salesSummary['gst_amount'],
                'cogs' => $cogs,
                'gross_profit' => $grossProfit,
                'expenses' => $expenses,
                'total_expenses' => $totalExpenses,
                'net_profit' => $netProfit,
                'margin_percentage' => $salesSummary['taxable_sales'] > 0 ? round(($netProfit / $salesSummary['taxable_sales']) * 100, 2) : 0
            ]);
        } catch (PDOException $e) {
            sendJSON('error', 'Database error: ' . $e->getMessage());
        }
    }
}
?>
