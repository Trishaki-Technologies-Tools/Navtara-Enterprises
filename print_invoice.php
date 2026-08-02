<?php
// print_invoice.php
// Clean, professional A4 printable layout matching the market standard sample exactly

require_once __DIR__ . '/config/database.php';
require_once __DIR__ . '/config/functions.php';

checkAuth();

$invoiceId = (int)($_GET['id'] ?? 0);
if ($invoiceId <= 0) {
    die("Error: Invalid invoice ID.");
}

$db = getDBConnection();

try {
    // Fetch Invoice Header
    $stmt = $db->prepare("
        SELECT i.*, r.name as owner_name, r.name as retailer_name, r.state as retailer_state, r.credit_limit, r.mobile as retailer_mobile
        FROM invoices i
        JOIN retailers r ON i.retailer_id = r.id
        WHERE i.id = ?
    ");
    $stmt->execute([$invoiceId]);
    $invoice = $stmt->fetch();
    
    if (!$invoice) {
        die("Error: Invoice not found.");
    }
    
    // Decode Company Details and Retailer Details
    $company = json_decode($invoice['company_details'], true);
    $retailer = json_decode($invoice['retailer_details'], true);
    
    // Fetch Invoice Items
    $stmtItems = $db->prepare("
        SELECT ii.*, p.hsn_code, s.mrp 
        FROM invoice_items ii
        JOIN skus s ON ii.sku_id = s.id
        JOIN products p ON s.product_id = p.id
        WHERE ii.invoice_id = ?
    ");
    $stmtItems->execute([$invoiceId]);
    $items = $stmtItems->fetchAll();
    
} catch (PDOException $e) {
    die("Database Error: " . $e->getMessage());
}

// Fetch dynamic settings or fall back to empty defaults
$company_name = getSetting('company_name', 'V.P.KAMAT AND COMPANY');
$company_address = getSetting('company_address', "74, Gayatri Bldg., New Goodshed Road, BELGAUM");
$company_mobile = getSetting('company_mobile', '08312424278');
$company_email = getSetting('company_email', '');
$company_gst = getSetting('company_gst', '29AAAFV7162Q1ZD');
$company_fssai = getSetting('company_fssai', '');

$bank_name = getSetting('bank_name', '');
$bank_account_no = getSetting('bank_account_no', '');
$bank_ifsc = getSetting('bank_ifsc', '');
$bank_branch = getSetting('bank_branch', '');

$invoice_footer = getSetting('invoice_footer', "Subject to Belgaum Jurisdiction\nGoods once sold will not be taken back\n-I/We hereby certify that food/foods mention in this invoice is/are warranted to be of the nature & quality which it/these purports/purport to be.");

$copyType = isset($_GET['type']) ? trim($_GET['type']) : 'customer';
$copyTitle = (strtolower($copyType) === 'office') ? 'OFFICE COPY' : 'CUSTOMER COPY';

$companyState = "Goa"; // Default state of owner company
$isInterState = (isset($invoice['retailer_state']) && strtolower($invoice['retailer_state']) !== strtolower($companyState));

// Helper function for convertNumberToWords
function getWordRepresentation($num, $words) {
    if ($num == 0) return 'Zero';
    $hundred = null;
    $digits_length = strlen($num);
    $i = 0;
    $str = array();
    
    $digits = array('', 'Hundred','Thousand','Lakh', 'Crore');
    while( $i < $digits_length ) {
        $divider = ($i == 2) ? 10 : 100;
        $current_number = floor($num % $divider);
        $num = floor($num / $divider);
        $i += $divider == 10 ? 1 : 2;
        if ($current_number) {
            $plural = (($counter = count($str)) && $current_number > 9) ? 's' : null;
            $hundred = ($counter == 1 && $str[0]) ? ' and ' : null;
            $str [] = ($current_number < 21) ? $words[$current_number].' '. $digits[$counter].$plural.' '.$hundred:$words[floor($current_number / 10) * 10].' '.$words[$current_number % 10].' '.$digits[$counter].$plural.' '.$hundred;
        } else $str [] = null;
    }
    $representation = implode('', array_reverse($str));
    return trim($representation);
}

// Helper to convert number to Indian Currency words
function convertNumberToWords($number) {
    $no = (int)floor($number);
    $decimal = (int)round(($number - $no) * 100);
    
    $words = array(
        0 => '', 1 => 'One', 2 => 'Two',
        3 => 'Three', 4 => 'Four', 5 => 'Five',
        6 => 'Six', 7 => 'Seven', 8 => 'Eight',
        9 => 'Nine', 10 => 'Ten', 11 => 'Eleven',
        12 => 'Twelve', 13 => 'Thirteen', 14 => 'Fourteen',
        15 => 'Fifteen', 16 => 'Sixteen', 17 => 'Seventeen',
        18 => 'Eighteen', 19 => 'Nineteen', 20 => 'Twenty',
        30 => 'Thirty', 40 => 'Forty', 50 => 'Fifty',
        60 => 'Sixty', 70 => 'Seventy', 80 => 'Eighty',
        90 => 'Ninety'
    );
    
    $rupeesStr = getWordRepresentation($no, $words);
    if ($decimal > 0) {
        $paiseStr = getWordRepresentation($decimal, $words);
        return $rupeesStr . " and Paise " . $paiseStr . " Only";
    }
    
    return $rupeesStr . " Only";
}

// Calculate tax summary groupings
$tax_summary = [
    '0.00' => ['sal' => 0.00, 'tax' => 0.00],
    '5.00' => ['sal' => 0.00, 'tax' => 0.00],
    '12.00' => ['sal' => 0.00, 'tax' => 0.00],
    '18.00' => ['sal' => 0.00, 'tax' => 0.00],
    '28.00' => ['sal' => 0.00, 'tax' => 0.00]
];

$totQty = 0;
$cgstTotal = 0;
$sgstTotal = 0;
$igstTotal = 0;
$totalTaxableVal = 0;

foreach ($items as $item) {
    $qty = (int)$item['quantity'];
    $rate = (float)$item['selling_price'];
    $disc = (float)$item['discount_amount'];
    $taxable = ($qty * $rate) - $disc;
    $gstPct = (float)$item['gst_percentage'];
    
    $totQty += $qty;
    $totalTaxableVal += $taxable;
    
    $gstKey = number_format($gstPct, 2);
    if (!isset($tax_summary[$gstKey])) {
        $tax_summary[$gstKey] = ['sal' => 0.00, 'tax' => 0.00];
    }
    
    $tax_summary[$gstKey]['sal'] += $taxable;
    
    // Tax calculations
    if ($isInterState) {
        $lineTax = ($taxable * $gstPct) / 100;
        $igstTotal += $lineTax;
        $tax_summary[$gstKey]['tax'] += $lineTax;
    } else {
        $lineCGST = round(($taxable * ($gstPct / 2)) / 100, 2);
        $lineSGST = round(($taxable * ($gstPct / 2)) / 100, 2);
        $cgstTotal += $lineCGST;
        $sgstTotal += $lineSGST;
        $tax_summary[$gstKey]['tax'] += ($lineCGST + $lineSGST);
    }
}

$totalTaxAmount = $isInterState ? $igstTotal : ($cgstTotal + $sgstTotal);
$rawGrandTotal = $totalTaxableVal + $totalTaxAmount;
$roundedGrandTotal = round($rawGrandTotal);

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tax Invoice - <?php echo htmlspecialchars($invoice['invoice_number']); ?></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 11px;
            color: #000;
            margin: 0;
            padding: 10px;
            background-color: #fff;
        }
        .invoice-box {
            max-width: 800px;
            margin: auto;
            border: 1px solid #000;
            padding: 15px;
        }
        .header-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 10px;
        }
        .header-table td {
            vertical-align: top;
        }
        .company-logo {
            font-size: 20px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 0;
            padding: 0;
        }
        .company-sub {
            font-size: 11px;
            font-weight: bold;
            margin-top: 3px;
        }
        .company-details {
            font-size: 10px;
            line-height: 1.3;
            margin-top: 2px;
        }
        .invoice-title-block {
            text-align: center;
        }
        .invoice-title-block h3 {
            margin: 0;
            font-size: 15px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .invoice-box-side-text {
            font-size: 9px;
            font-style: italic;
        }
        
        /* Information boxes (Billed to vs Invoice details) */
        .info-table {
            width: 100%;
            border-collapse: collapse;
            border-top: 1px solid #000;
            border-bottom: 1px solid #000;
            margin-bottom: 10px;
        }
        .info-table td {
            width: 50%;
            vertical-align: top;
            padding: 5px;
        }
        .info-table td.left-col {
            border-right: 1px solid #000;
        }
        
        /* Items Table */
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 0;
        }
        .items-table th {
            border-top: 1px solid #000;
            border-bottom: 1px solid #000;
            border-right: 1px solid #000;
            padding: 4px;
            font-weight: bold;
            text-align: left;
            font-size: 11px;
            background-color: #fff;
        }
        .items-table th:last-child {
            border-right: none;
        }
        .items-table td {
            border-right: 1px solid #000;
            padding: 4px 6px;
            font-size: 11px;
            vertical-align: top;
        }
        .items-table td:last-child {
            border-right: none;
        }
        .items-table tr.item-row {
            height: 25px;
        }
        .items-table .total-row td {
            border-top: 1px solid #000;
            border-bottom: 1px solid #000;
            font-weight: bold;
            padding: 5px;
        }
        .text-right {
            text-align: right;
        }
        .text-center {
            text-align: center;
        }

        /* Bottom Section Grid */
        .bottom-grid-table {
            width: 100%;
            border-collapse: collapse;
            border-bottom: 1px solid #000;
        }
        .bottom-grid-table td.grid-left {
            width: 60%;
            vertical-align: top;
            padding: 5px;
            border-right: 1px solid #000;
        }
        .bottom-grid-table td.grid-right {
            width: 40%;
            vertical-align: top;
            padding: 5px;
        }
        
        /* GST Summary table inside left grid */
        .gst-summary-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 8px;
        }
        .gst-summary-table th, .gst-summary-table td {
            border: 1px solid #000;
            padding: 3px;
            font-size: 10px;
            text-align: center;
        }
        .gst-summary-table th {
            font-weight: bold;
        }

        /* Bank & Words */
        .bank-details {
            font-size: 10px;
            margin-bottom: 8px;
            font-style: italic;
        }
        .words-section {
            font-size: 10px;
            font-weight: bold;
            line-height: 1.4;
        }
        
        /* Right Summary Block */
        .right-summary-table {
            width: 100%;
            border-collapse: collapse;
        }
        .right-summary-table td {
            padding: 4px;
            font-size: 11px;
        }
        .right-summary-table td.label {
            font-weight: bold;
            width: 60%;
        }
        .right-summary-table td.value {
            text-align: right;
            width: 40%;
        }
        .right-summary-table tr.net-amount-row td {
            font-size: 13px;
            font-weight: bold;
            border-top: 1px solid #000;
            padding-top: 8px;
        }

        /* Terms & Signatures */
        .terms-signature-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 5px;
        }
        .terms-signature-table td {
            vertical-align: top;
            padding: 5px;
        }
        .terms-signature-table td.terms-col {
            width: 55%;
            font-size: 9px;
            line-height: 1.3;
        }
        .terms-signature-table td.signature-col {
            width: 45%;
            text-align: center;
            font-size: 10px;
        }
        .signature-area {
            margin-top: 45px;
            font-weight: bold;
            border-top: 1px dashed #000;
            width: 80%;
            margin-left: auto;
            margin-right: auto;
            padding-top: 3px;
        }

        /* Bottom Footer */
        .page-footer-text {
            display: flex;
            justify-content: space-between;
            font-size: 9px;
            margin-top: 10px;
            border-top: 1px solid #000;
            padding-top: 5px;
        }
        .print-page-num {
            display: none;
        }
        @media print {
            .print-page-num {
                display: inline;
            }
            .print-page-num::after {
                content: "Page " counter(page);
            }
        }
        
        .btn-print-box {
            max-width: 800px;
            margin: 10px auto;
            text-align: right;
        }
        .btn-print {
            background-color: #000;
            color: #fff;
            border: 1px solid #000;
            padding: 8px 16px;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
            text-transform: uppercase;
        }
        .btn-print:hover {
            background-color: #333;
        }

        @media print {
            body {
                padding: 0;
            }
            .invoice-box {
                border: 1px solid #000;
                box-shadow: none;
                padding: 10px;
            }
            .btn-print-box {
                display: none;
            }
        }
    </style>
</head>
<body>

    <div class="btn-print-box">
        <button class="btn-print" onclick="window.print()">Print Invoice (A4)</button>
    </div>

    <div class="invoice-box">
        <!-- Top Header Grid -->
        <table class="header-table">
            <tr>
                <td style="width: 25%;">
                    <div style="font-weight: bold;">GSTIN : <?php echo htmlspecialchars($company_gst); ?></div>
                    <div style="font-weight: bold; margin-top: 5px; font-size: 13px;">
                        <?php echo $copyTitle; ?>
                    </div>
                </td>
                <td style="width: 50%; text-align: center;">
                    <div class="invoice-title-block">
                        <h3>Tax Invoice</h3>
                        <div class="company-logo"><?php echo htmlspecialchars($company_name); ?></div>
                        <div class="company-sub">
                            STOCKIST &amp; DISTRIBUTOR 
                            <?php if (!empty($company_fssai)): ?>
                                [FSSAI-<?php echo htmlspecialchars($company_fssai); ?>]
                            <?php endif; ?>
                        </div>
                        <div class="company-details">
                            <?php echo nl2br(htmlspecialchars($company_address)); ?><br>
                            Ph : <?php echo htmlspecialchars($company_mobile); ?> 
                            <?php if (!empty($company_email)): ?>
                                | Email: <?php echo htmlspecialchars($company_email); ?>
                            <?php endif; ?>
                        </div>
                    </div>
                </td>
                <td style="width: 25%; text-align: right;" class="invoice-box-side-text">
                    Original For Recipient
                </td>
            </tr>
        </table>

        <!-- Billing details and Invoice numbers info -->
        <table class="info-table">
            <tr>
                <td class="left-col">
                    <div style="font-size: 9px; text-transform: uppercase; color: #555; margin-bottom: 2px; font-weight: bold;">Billed To:</div>
                    <div style="font-size: 12px; font-weight: bold;"><?php echo htmlspecialchars($retailer['shop_name']); ?></div>
                    <div style="margin-top: 3px; line-height: 1.3;">
                        <?php echo nl2br(htmlspecialchars($retailer['address'])); ?><br>
                        <?php if (!empty($invoice['retailer_mobile'])): ?>
                            Ph : <?php echo htmlspecialchars($invoice['retailer_mobile']); ?><br>
                        <?php endif; ?>
                        <?php if (!empty($retailer['gst_number'])): ?>
                            <strong>GSTIN:</strong> <?php echo htmlspecialchars($retailer['gst_number']); ?><br>
                        <?php endif; ?>
                    </div>
                </td>
                <td>
                    <table style="width: 100%; border-collapse: collapse;">
                        <tr>
                            <td style="padding: 2px 0; font-weight: bold; width: 40%;">Invoice No</td>
                            <td style="padding: 2px 0; width: 60%;">: <?php echo htmlspecialchars($invoice['invoice_number']); ?></td>
                        </tr>
                        <tr>
                            <td style="padding: 2px 0; font-weight: bold;">Date</td>
                            <td style="padding: 2px 0;">: <?php echo date('d/m/Y', strtotime($invoice['invoice_date'])); ?></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <!-- Items table -->
        <table class="items-table">
            <thead>
                <tr>
                    <th style="width: 5%; text-align: center;">No.</th>
                    <th style="width: 40%;">Description</th>
                    <th style="width: 10%; text-align: center;">HSN</th>
                    <th style="width: 8%; text-align: center;">Tax%</th>
                    <th style="width: 9%; text-align: right;">MRP</th>
                    <th style="width: 9%; text-align: right;">Rate</th>
                    <th style="width: 8%; text-align: right;">Qty</th>
                    <th style="width: 8%; text-align: right;">Dis</th>
                    <th style="width: 10%; text-align: right;">Value</th>
                </tr>
            </thead>
            <tbody>
                <?php 
                $count = 1;
                foreach ($items as $item): 
                    $qty = (int)$item['quantity'];
                    $rate = (float)$item['selling_price'];
                    $mrp = (float)($item['mrp'] ?? 0);
                    $disc = (float)$item['discount_amount'];
                    $taxable = ($qty * $rate) - $disc;
                    $gstPct = (float)$item['gst_percentage'];
                ?>
                <tr class="item-row">
                    <td class="text-center"><?php echo $count++; ?></td>
                    <td><strong><?php echo htmlspecialchars($item['sku_name']); ?></strong></td>
                    <td class="text-center"><?php echo htmlspecialchars($item['hsn_code'] ?: 'N/A'); ?></td>
                    <td class="text-center"><?php echo $gstPct; ?></td>
                    <td class="text-right"><?php echo number_format($mrp, 2); ?></td>
                    <td class="text-right"><?php echo number_format($rate, 2); ?></td>
                    <td class="text-right"><?php echo $qty; ?></td>
                    <td class="text-right"><?php echo $disc > 0 ? number_format($disc, 2) : ''; ?></td>
                    <td class="text-right"><?php echo number_format($taxable, 2); ?></td>
                </tr>
                <?php endforeach; ?>
                
                <!-- Spacer rows to give dot-matrix standard height -->
                <?php 
                $remainingRows = 8 - count($items);
                for ($i = 0; $i < $remainingRows; $i++): 
                ?>
                <tr class="item-row">
                    <td class="text-center"></td>
                    <td></td>
                    <td class="text-center"></td>
                    <td class="text-center"></td>
                    <td class="text-right"></td>
                    <td class="text-right"></td>
                    <td class="text-right"></td>
                    <td class="text-right"></td>
                    <td class="text-right"></td>
                </tr>
                <?php endfor; ?>

                <!-- Totals row -->
                <tr class="total-row">
                    <td colspan="6" style="text-align: right;">Total:</td>
                    <td class="text-right"><?php echo $totQty; ?></td>
                    <td></td>
                    <td class="text-right"><?php echo number_format($totalTaxableVal, 2); ?></td>
                </tr>
            </tbody>
        </table>

        <!-- Grid block for calculations summary, bank credentials, terms, signature -->
        <table class="bottom-grid-table">
            <tr>
                <td class="grid-left">
                    <!-- GST Tax Summary matrix -->
                    <table class="gst-summary-table">
                        <thead>
                            <tr>
                                <th>Gst%</th>
                                <th>0.00</th>
                                <th>5.00</th>
                                <th>12.00</th>
                                <th>18.00</th>
                                <th>28.00</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style="font-weight: bold;">Sal</td>
                                <td><?php echo $tax_summary['0.00']['sal'] > 0 ? number_format($tax_summary['0.00']['sal'], 2) : ''; ?></td>
                                <td><?php echo $tax_summary['5.00']['sal'] > 0 ? number_format($tax_summary['5.00']['sal'], 2) : ''; ?></td>
                                <td><?php echo $tax_summary['12.00']['sal'] > 0 ? number_format($tax_summary['12.00']['sal'], 2) : ''; ?></td>
                                <td><?php echo $tax_summary['18.00']['sal'] > 0 ? number_format($tax_summary['18.00']['sal'], 2) : ''; ?></td>
                                <td><?php echo $tax_summary['28.00']['sal'] > 0 ? number_format($tax_summary['28.00']['sal'], 2) : ''; ?></td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold;">Tax</td>
                                <td><?php echo $tax_summary['0.00']['tax'] > 0 ? number_format($tax_summary['0.00']['tax'], 2) : ''; ?></td>
                                <td><?php echo $tax_summary['5.00']['tax'] > 0 ? number_format($tax_summary['5.00']['tax'], 2) : ''; ?></td>
                                <td><?php echo $tax_summary['12.00']['tax'] > 0 ? number_format($tax_summary['12.00']['tax'], 2) : ''; ?></td>
                                <td><?php echo $tax_summary['18.00']['tax'] > 0 ? number_format($tax_summary['18.00']['tax'], 2) : ''; ?></td>
                                <td><?php echo $tax_summary['28.00']['tax'] > 0 ? number_format($tax_summary['28.00']['tax'], 2) : ''; ?></td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Banker credentials -->
                    <?php if (!empty($bank_name)): ?>
                    <div class="bank-details">
                        Our Banker : <strong><?php echo htmlspecialchars($bank_name); ?></strong> A/C NO: <strong><?php echo htmlspecialchars($bank_account_no); ?></strong><br>
                        IFSC CODE : <strong><?php echo htmlspecialchars($bank_ifsc); ?></strong> BRANCH: <strong><?php echo htmlspecialchars($bank_branch); ?></strong>
                    </div>
                    <?php endif; ?>

                    <!-- Invoice total figures spelled out in words -->
                    <div class="words-section">
                        Total Tax Value Rupees : <span style="font-weight: normal; font-style: italic;"><?php echo convertNumberToWords($totalTaxAmount); ?></span><br>
                        Total Invoice Value Rupees : <span style="font-weight: normal; font-style: italic;"><?php echo convertNumberToWords($roundedGrandTotal); ?></span>
                    </div>
                </td>
                <td class="grid-right">
                    <table class="right-summary-table">
                        <?php if (!$isInterState): ?>
                        <tr>
                            <td class="label">CGST</td>
                            <td class="value">: <?php echo number_format($cgstTotal, 2); ?></td>
                        </tr>
                        <tr>
                            <td class="label">SGST</td>
                            <td class="value">: <?php echo number_format($sgstTotal, 2); ?></td>
                        </tr>
                        <?php else: ?>
                        <tr>
                            <td class="label">IGST</td>
                            <td class="value">: <?php echo number_format($igstTotal, 2); ?></td>
                        </tr>
                        <?php endif; ?>
                        <tr class="net-amount-row">
                            <td class="label">NET AMOUNT</td>
                            <td class="value" style="font-size: 15px;">: <?php echo number_format($roundedGrandTotal, 2); ?></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <!-- Terms and Conditions + Signature footer panel -->
        <table class="terms-signature-table">
            <tr>
                <td class="terms-col">
                    <strong>Terms &amp; Conditions</strong><br>
                    - E. &amp; O.E.<br>
                    <?php echo nl2br(htmlspecialchars($invoice_footer)); ?>
                </td>
                <td class="signature-col">
                    For <strong><?php echo htmlspecialchars($company_name); ?></strong>
                    <div class="signature-area">
                        Authorised Signatory
                    </div>
                </td>
            </tr>
        </table>

        <!-- Bottom Page Footer markers -->
        <div class="page-footer-text">
            <span class="print-page-num"></span>
            <strong>Thank You Order Again</strong>
        </div>
    </div>

    <?php if (isset($_GET['autoprint']) && $_GET['autoprint'] == 1): ?>
    <script>
    window.onload = function() {
        window.print();
        window.onafterprint = function() {
            window.close();
        }
    }
    </script>
    <?php endif; ?>

    <?php if (isset($_GET['download']) && $_GET['download'] == 1): ?>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <script>
    window.onload = function() {
        const printBtn = document.querySelector('.btn-print-box');
        if (printBtn) printBtn.style.display = 'none';
        
        const element = document.querySelector('.invoice-box');
        const invoiceNumber = '<?php echo htmlspecialchars($invoice['invoice_number']); ?>';
        
        const opt = {
            margin:       [5, 5, 5, 5],
            filename:     invoiceNumber.replace(/[\/\\:]/g, '_') + '.pdf',
            image:        { type: 'jpeg', quality: 1.0 },
            html2canvas:  { scale: 2, useCORS: true, letterRendering: true },
            jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait' }
        };
        
        html2pdf().set(opt).from(element).save().then(() => {
            setTimeout(() => {
                window.close();
            }, 1000);
        });
    }
    </script>
    <?php endif; ?>
</body>
</html>
