<?php
// print_credit_note.php
// Printable GST Credit Note matching standard ERP and statutory guidelines

require_once __DIR__ . '/config/database.php';
require_once __DIR__ . '/config/functions.php';

checkAuth();

$returnId = (int)($_GET['id'] ?? 0);
if ($returnId <= 0) {
    die("Error: Invalid return / credit note ID.");
}

$db = getDBConnection();

try {
    // Fetch Return Header
    $stmt = $db->prepare("
        SELECT sr.*, 
               i.invoice_number, 
               i.invoice_date,
               i.invoice_type,
               r.name as retailer_name, 
               r.shop_name, 
               r.state as retailer_state, 
               r.mobile as retailer_mobile, 
               r.address as retailer_address, 
               r.area as retailer_area, 
               r.city as retailer_city, 
               r.pin_code as retailer_pin_code, 
               r.gst_number as current_retailer_gst,
               u.fullname as staff_name
        FROM sales_returns sr
        JOIN invoices i ON sr.invoice_id = i.id
        JOIN retailers r ON sr.retailer_id = r.id
        JOIN users u ON sr.staff_id = u.id
        WHERE sr.id = ?
    ");
    $stmt->execute([$returnId]);
    $return = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$return) {
        die("Error: Credit note record not found.");
    }

    $shopName = !empty($return['shop_name']) ? $return['shop_name'] : $return['retailer_name'];

    // Address
    $customerAddress = trim($return['retailer_address'] ?? '');
    $extraLoc = [];
    if (!empty($return['retailer_area']) && stripos($customerAddress, $return['retailer_area']) === false) $extraLoc[] = $return['retailer_area'];
    if (!empty($return['retailer_city']) && stripos($customerAddress, $return['retailer_city']) === false) $extraLoc[] = $return['retailer_city'];
    if (!empty($return['retailer_pin_code']) && stripos($customerAddress, $return['retailer_pin_code']) === false) $extraLoc[] = $return['retailer_pin_code'];
    if (!empty($extraLoc)) {
        $customerAddress = rtrim($customerAddress, ', ') . ($customerAddress ? ', ' : '') . implode(', ', $extraLoc);
    }
    if (empty($customerAddress)) $customerAddress = 'N/A';

    $customerGst = !empty($return['current_retailer_gst']) ? trim($return['current_retailer_gst']) : 'N/A';

    // Fetch Return Items
    $stmtItems = $db->prepare("
        SELECT sri.*, s.sku_name, s.sku_code, s.unit, p.hsn_code, p.name as product_name
        FROM sales_return_items sri
        JOIN skus s ON sri.sku_id = s.id
        JOIN products p ON s.product_id = p.id
        WHERE sri.return_id = ?
        ORDER BY sri.id ASC
    ");
    $stmtItems->execute([$returnId]);
    $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    die("Database Error: " . $e->getMessage());
}

$company_name = getSetting('company_name', 'NAVTARA ENTERPRISES');
$company_address = getSetting('company_address', "Wholesale FMCG & Distribution");
$company_mobile = getSetting('company_mobile', '');
$company_email = getSetting('company_email', '');
$company_gst = getSetting('company_gst', '');
$company_fssai = getSetting('company_fssai', '');

$companyState = getCompanyState();
$isInterState = (isset($return['retailer_state']) && strcasecmp($return['retailer_state'], $companyState) !== 0);

function numToWordsCN($number) {
    $decimal = round($number - ($no = floor($number)), 2) * 100;
    $hundred = null;
    $digits_length = strlen($no);
    $i = 0;
    $str = array();
    $words = array(
        0 => '', 1 => 'One', 2 => 'Two', 3 => 'Three', 4 => 'Four', 5 => 'Five', 6 => 'Six',
        7 => 'Seven', 8 => 'Eight', 9 => 'Nine', 10 => 'Ten', 11 => 'Eleven', 12 => 'Twelve',
        13 => 'Thirteen', 14 => 'Fourteen', 15 => 'Fifteen', 16 => 'Sixteen', 17 => 'Seventeen',
        18 => 'Eighteen', 19 => 'Nineteen', 20 => 'Twenty', 30 => 'Thirty', 40 => 'Forty',
        50 => 'Fifty', 60 => 'Sixty', 70 => 'Seventy', 80 => 'Eighty', 90 => 'Ninety'
    );
    $digits = array('', 'Hundred','Thousand','Lakh', 'Crore');
    while ($i < $digits_length) {
        $divider = ($i == 2) ? 10 : 100;
        $number = floor($no % $divider);
        $no = floor($no / $divider);
        $i += $divider == 10 ? 1 : 2;
        if ($number) {
            $plural = (($counter = count($str)) && $number > 9) ? 's' : null;
            $hundred = ($counter == 1 && $str[0]) ? ' and ' : null;
            $str [] = ($number < 21) ? $words[$number].' '. $digits[$counter]. $plural.' '.$hundred:$words[floor($number / 10) * 10].' '.$words[$number % 10]. ' '.$digits[$counter].$plural.' '.$hundred;
        } else $str[] = null;
    }
    $Rupees = implode('', array_reverse($str));
    $paise = ($decimal > 0) ? " and " . ($words[$decimal / 10] . " " . $words[$decimal % 10]) . ' Paise' : '';
    return ($Rupees ? $Rupees . 'Rupees ' : '') . $paise . " Only";
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Credit Note - <?php echo htmlspecialchars($return['credit_note_number']); ?></title>
    <link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/vendor/fontawesome/css/all.min.css">
    <style>
        body {
            background-color: #f3f4f6;
            color: #1f2937;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 13px;
        }
        .page-container {
            max-width: 850px;
            margin: 20px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        .header-title {
            font-size: 22px;
            font-weight: 800;
            color: #b91c1c;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .company-name {
            font-size: 20px;
            font-weight: 800;
            color: #111827;
        }
        .info-box {
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            padding: 12px;
            height: 100%;
            background: #f9fafb;
        }
        .info-title {
            font-size: 11px;
            text-transform: uppercase;
            font-weight: 700;
            color: #6b7280;
            margin-bottom: 6px;
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 4px;
        }
        .table-custom {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        .table-custom th {
            background-color: #f3f4f6;
            color: #374151;
            font-weight: 700;
            border: 1px solid #d1d5db;
            padding: 8px;
            font-size: 12px;
        }
        .table-custom td {
            border: 1px solid #e5e7eb;
            padding: 8px;
            font-size: 12px;
        }
        .summary-box {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 6px;
            padding: 15px;
        }
        @media print {
            body {
                background: #ffffff;
                color: #000;
            }
            .page-container {
                box-shadow: none;
                margin: 0;
                padding: 0;
                max-width: 100%;
            }
            .no-print {
                display: none !important;
            }
        }
    </style>
</head>
<body>

<div class="container page-container">
    <!-- Action Bar (No Print) -->
    <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom no-print">
        <a href="index.php#return_logs" class="btn btn-outline-secondary btn-sm">
            <i class="fas fa-arrow-left me-1"></i> Back to Return Logs
        </a>
        <div class="d-flex gap-2">
            <button onclick="window.print();" class="btn btn-danger btn-sm">
                <i class="fas fa-print me-1"></i> Print Credit Note
            </button>
        </div>
    </div>

    <!-- Header Section -->
    <div class="row align-items-center mb-3">
        <div class="col-8">
            <div class="company-name"><?php echo htmlspecialchars($company_name); ?></div>
            <div class="text-secondary small"><?php echo nl2br(htmlspecialchars($company_address)); ?></div>
            <?php if ($company_mobile): ?><div class="small"><strong>Mobile:</strong> <?php echo htmlspecialchars($company_mobile); ?></div><?php endif; ?>
            <?php if ($company_gst): ?><div class="small"><strong>GSTIN:</strong> <span class="fw-bold text-dark"><?php echo htmlspecialchars($company_gst); ?></span></div><?php endif; ?>
            <?php if ($company_fssai): ?><div class="small"><strong>FSSAI Lic No:</strong> <?php echo htmlspecialchars($company_fssai); ?></div><?php endif; ?>
        </div>
        <div class="col-4 text-end">
            <div class="header-title">GST CREDIT NOTE</div>
            <div class="small text-muted">(Issued under Section 34 of CGST Act)</div>
            <div class="badge bg-danger text-white mt-1 px-2 py-1">SALES RETURN</div>
        </div>
    </div>

    <hr class="my-3">

    <!-- Meta Information Cards -->
    <div class="row g-3 mb-3">
        <!-- Retailer Details -->
        <div class="col-6">
            <div class="info-box">
                <div class="info-title">Credit Issued To (Customer Details)</div>
                <div class="fw-bold text-dark fs-6"><?php echo htmlspecialchars($shopName); ?></div>
                <div class="text-secondary small"><?php echo htmlspecialchars($return['retailer_name']); ?></div>
                <div class="small mt-1"><?php echo htmlspecialchars($customerAddress); ?></div>
                <div class="small mt-1"><strong>Mobile:</strong> <?php echo htmlspecialchars($return['retailer_mobile'] ?: 'N/A'); ?></div>
                <div class="small"><strong>GSTIN:</strong> <span class="fw-bold"><?php echo htmlspecialchars($customerGst); ?></span></div>
                <div class="small"><strong>State of Supply:</strong> <?php echo htmlspecialchars($return['retailer_state'] ?: $companyState); ?></div>
            </div>
        </div>

        <!-- Document Details -->
        <div class="col-6">
            <div class="info-box">
                <div class="info-title">Credit Note Details</div>
                <table class="w-100 small">
                    <tr>
                        <td class="text-secondary py-1">Credit Note No:</td>
                        <td class="text-end fw-bold text-danger"><?php echo htmlspecialchars($return['credit_note_number']); ?></td>
                    </tr>
                    <tr>
                        <td class="text-secondary py-1">Credit Note Date:</td>
                        <td class="text-end fw-bold"><?php echo date('d/m/Y', strtotime($return['return_date'])); ?></td>
                    </tr>
                    <tr>
                        <td class="text-secondary py-1">Return Ref No:</td>
                        <td class="text-end"><?php echo htmlspecialchars($return['return_number']); ?></td>
                    </tr>
                    <tr>
                        <td class="text-secondary py-1">Against Original Invoice:</td>
                        <td class="text-end fw-bold text-primary"><?php echo htmlspecialchars($return['invoice_number']); ?></td>
                    </tr>
                    <tr>
                        <td class="text-secondary py-1">Original Invoice Date:</td>
                        <td class="text-end"><?php echo date('d/m/Y', strtotime($return['invoice_date'])); ?></td>
                    </tr>
                    <tr>
                        <td class="text-secondary py-1">Processed By:</td>
                        <td class="text-end"><?php echo htmlspecialchars($return['staff_name']); ?></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- Items Table -->
    <table class="table-custom mb-3">
        <thead>
            <tr>
                <th class="text-center" style="width: 5%;">#</th>
                <th style="width: 35%;">Item Description &amp; SKU Code</th>
                <th class="text-center" style="width: 10%;">HSN</th>
                <th class="text-end" style="width: 10%;">Qty</th>
                <th class="text-end" style="width: 12%;">Rate (₹)</th>
                <th class="text-end" style="width: 13%;">Taxable (₹)</th>
                <th class="text-center" style="width: 8%;">GST %</th>
                <th class="text-end" style="width: 15%;">Credit Total (₹)</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($items as $idx => $it): 
                $lineTaxable = (float)$it['total_amount'] - (float)$it['gst_amount'];
            ?>
            <tr>
                <td class="text-center"><?php echo $idx + 1; ?></td>
                <td>
                    <strong><?php echo htmlspecialchars($it['sku_name']); ?></strong>
                    <br><small class="text-muted">Code: <?php echo htmlspecialchars($it['sku_code']); ?> | Reason: <?php echo htmlspecialchars($it['reason']); ?></small>
                </td>
                <td class="text-center"><?php echo htmlspecialchars($it['hsn_code'] ?: '-'); ?></td>
                <td class="text-end fw-bold"><?php echo (int)$it['quantity']; ?> <?php echo htmlspecialchars($it['unit'] ?: 'pcs'); ?></td>
                <td class="text-end"><?php echo number_format((float)$it['selling_price'], 2); ?></td>
                <td class="text-end"><?php echo number_format($lineTaxable, 2); ?></td>
                <td class="text-center"><?php echo (float)$it['gst_percentage']; ?>%</td>
                <td class="text-end fw-bold text-dark"><?php echo number_format((float)$it['total_amount'], 2); ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>

    <!-- Totals Breakdown -->
    <div class="row mb-4">
        <div class="col-7">
            <div class="small mb-2">
                <strong>Reason for Issue / Remarks:</strong>
                <p class="text-secondary bg-light p-2 rounded border mb-2"><?php echo htmlspecialchars($return['reason'] . ($return['remarks'] ? ' - ' . $return['remarks'] : '')); ?></p>
            </div>
            <div class="small">
                <strong>Amount in Words:</strong>
                <div class="fst-italic text-dark"><?php echo numToWordsCN($return['total_amount']); ?></div>
            </div>
        </div>
        <div class="col-5">
            <div class="summary-box">
                <table class="w-100 small">
                    <tr>
                        <td class="py-1">Taxable Return Value:</td>
                        <td class="text-end fw-semibold">₹<?php echo number_format((float)$return['taxable_amount'], 2); ?></td>
                    </tr>
                    <?php if (!$isInterState): ?>
                    <tr>
                        <td class="py-1">Central GST (CGST):</td>
                        <td class="text-end">₹<?php echo number_format((float)$return['gst_amount'] / 2, 2); ?></td>
                    </tr>
                    <tr>
                        <td class="py-1">State GST (SGST):</td>
                        <td class="text-end">₹<?php echo number_format((float)$return['gst_amount'] / 2, 2); ?></td>
                    </tr>
                    <?php else: ?>
                    <tr>
                        <td class="py-1">Integrated GST (IGST):</td>
                        <td class="text-end">₹<?php echo number_format((float)$return['gst_amount'], 2); ?></td>
                    </tr>
                    <?php endif; ?>
                    <tr class="border-top border-danger pt-2">
                        <td class="pt-2 fs-6 fw-bold text-danger">Total Credit Amount:</td>
                        <td class="pt-2 fs-6 fw-bold text-end text-danger">₹<?php echo number_format((float)$return['total_amount'], 2); ?></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- Signatures -->
    <div class="row pt-4 mt-4 border-top">
        <div class="col-6">
            <div class="small text-muted mb-4">Customer Acknowledgement:</div>
            <div class="border-bottom border-dark w-75 mb-1" style="height: 30px;"></div>
            <div class="small fw-semibold">Receiver's Signature &amp; Stamp</div>
        </div>
        <div class="col-6 text-end">
            <div class="small text-muted mb-4">For <?php echo htmlspecialchars($company_name); ?>:</div>
            <div class="border-bottom border-dark w-75 ms-auto mb-1" style="height: 30px;"></div>
            <div class="small fw-semibold">Authorized Signatory</div>
        </div>
    </div>
</div>

<?php if (isset($_GET['autoprint']) && $_GET['autoprint'] == '1'): ?>
<script>
    window.onload = function() {
        window.print();
    };
</script>
<?php endif; ?>

</body>
</html>
