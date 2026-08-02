<?php
// index.php
// Shell Template & View Router for NAVATARA ENTERPRISES ERP SPA

require_once 'config/database.php';
require_once 'config/functions.php';

// Dynamic AJAX View Router
if (isset($_GET['view'])) {
    checkAuth();
    $view = cleanInput($_GET['view']);
    
    $owner_only_views = [
        'suppliers',
        'brands',
        'products',
        'inventory',
        'purchase_entry',
        'staff',
        'accounting',
        'reports',
        'settings',
        'gst_report',
        'beatroute_master'
    ];
    
    $allowed_views = [
        'dashboard',
        'suppliers',
        'brands',
        'products',
        'skus',
        'discount_slabs',
        'inventory',
        'purchase_entry',
        'retailers',
        'staff',
        'orders',
        'billing',
        'payments',
        'accounting',
        'reports',
        'settings',
        'expiry_products',
        'gst_report',
        'beatroute_master',
        'my_beatroute',
        'place_order'
    ];
    
    if (in_array($view, $allowed_views)) {
        $roleName = $_SESSION['role_name'] ?? '';
        if (in_array($view, $owner_only_views) && $roleName !== 'Owner') {
            echo "<div class='text-center py-5'><h3 class='text-danger'><i class='fas fa-exclamation-triangle'></i> Access Denied: You do not have permission to view this page.</h3></div>";
        } else {
            include 'views/' . $view . '.php';
        }
    } else {
        echo "<div class='text-center py-5'><h3 class='text-danger'>View Not Found</h3></div>";
    }
    exit;
}

$isLoggedIn = isLoggedIn();
$roleName = $_SESSION['role_name'] ?? '';
$fullname = $_SESSION['fullname'] ?? '';
$photo = $_SESSION['photo'] ?? 'assets/images/default-avatar.png';
?>
<!DOCTYPE html>
<html lang="en" data-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navatara Enterprises</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- DataTables Bootstrap 5 CSS -->
    <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet">

    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet">
    <!-- Global Custom Styles -->
    <link href="assets/css/style.css" rel="stylesheet">
    <script>
        window.userRole = "<?php echo htmlspecialchars($roleName); ?>";
    </script>
</head>

<body class="<?php echo !$isLoggedIn ? 'login-body' : ''; ?>">

    <!-- TOAST NOTIFICATION CONTAINER -->
    <div class="toast-container-custom" id="toast-container"></div>

    <?php if (!$isLoggedIn): ?>
        <!-- LOGIN WRAPPER CONTAINER -->
        <div id="login-wrapper">
            <?php include 'views/login.php'; ?>
        </div>
    <?php else: ?>
        <!-- APPLICATION MAIN SHELL LAYOUT -->
        <div id="app-layout">
            <!-- Sidebar Navigation -->
            <aside id="sidebar">


                <ul class="nav-menu">
                    <!-- Dashboard -->
                    <li class="nav-item" data-route="dashboard">
                        <a href="#dashboard"><i class="fas fa-th-large"></i> Dashboard</a>
                    </li>

                    <!-- Beat Route (Staff Only) -->
                    <?php if ($roleName !== 'Owner'): ?>
                        <li class="nav-item" data-route="my_beatroute">
                            <a href="#my_beatroute"><i class="fas fa-route"></i> My Beat Routes</a>
                        </li>
                        <li class="nav-item" data-route="place_order">
                            <a href="#place_order"><i class="fas fa-phone-volume"></i> Call Order</a>
                        </li>
                    <?php endif; ?>

                    <!-- Common Catalog / Products (Role Specific details inside) -->
                    <?php if ($roleName === 'Owner'): ?>
                        <li class="nav-item" data-route="suppliers">
                            <a href="#suppliers"><i class="fas fa-truck"></i> Manage Suppliers</a>
                        </li>
                        <li class="nav-item" data-route="brands">
                            <a href="#brands"><i class="fas fa-tags"></i> Manage Categories</a>
                        </li>
                        <li class="nav-item" data-route="products">
                            <a href="#products"><i class="fas fa-cubes"></i> Manage Products</a>
                        </li>
                        <li class="nav-item" data-route="skus">
                            <a href="#skus"><i class="fas fa-barcode"></i> View SKU's</a>
                        </li>
                        <li class="nav-item" data-route="discount_slabs">
                            <a href="#discount_slabs"><i class="fas fa-percent"></i> Discount Slabs</a>
                        </li>
                        <li class="nav-item" data-route="purchase_entry">
                            <a href="#purchase_entry"><i class="fas fa-truck-loading"></i> Purchase Entries</a>
                        </li>
                        <li class="nav-item" data-route="inventory">
                            <a href="#inventory"><i class="fas fa-boxes"></i> Inventory &amp; Stock</a>
                        </li>
                    <?php else: ?>
                        <li class="nav-item" data-route="skus">
                            <a href="#skus"><i class="fas fa-barcode"></i> View SKU's</a>
                        </li>
                    <?php endif; ?>

                    <!-- Retailers list (Available for both) -->
                    <li class="nav-item" data-route="retailers">
                        <a href="#retailers"><i class="fas fa-store"></i>
                            <?php echo $roleName === 'Owner' ? 'Retailer Profiles' : 'My Retailers'; ?></a>
                    </li>

                    <!-- Staff Accounts (Owner Only) -->
                    <?php if ($roleName === 'Owner'): ?>
                        <li class="nav-item" data-route="staff">
                            <a href="#staff"><i class="fas fa-users-cog"></i> Sales Staff</a>
                        </li>
                    <?php endif; ?>

                    <!-- Orders (Placing for Staff, reviewing for Owner) -->
                    <li class="nav-item" data-route="orders">
                        <a href="#orders"><i class="fas fa-shopping-basket"></i> Sales Orders</a>
                    </li>

                    <!-- Billing & Invoices -->
                    <li class="nav-item" data-route="billing">
                        <a href="#billing"><i class="fas fa-file-invoice-dollar"></i> Bills &amp; Invoices</a>
                    </li>

                    <!-- Payments Ledger -->
                    <li class="nav-item" data-route="payments">
                        <a href="#payments"><i class="fas fa-rupee-sign"></i> Collections</a>
                    </li>

                    <!-- Expiry Products Book -->
                    <li class="nav-item" data-route="expiry_products">
                        <a href="#expiry_products"><i class="fas fa-calendar-times"></i> Expiry Products</a>
                    </li>

                    <!-- Financial Accounting (Owner Only) -->
                    <?php if ($roleName === 'Owner'): ?>
                        <li class="nav-item" data-route="accounting">
                            <a href="#accounting"><i class="fas fa-calculator"></i> Accounting Ledger</a>
                        </li>
                        <li class="nav-item" data-route="reports">
                            <a href="#reports"><i class="fas fa-chart-bar"></i> Excel Reports</a>
                        </li>
                        <li class="nav-item" data-route="gst_report">
                            <a href="#gst_report"><i class="fas fa-percent"></i> GST Report</a>
                        </li>
                        <li class="nav-item" data-route="beatroute_master">
                            <a href="#beatroute_master"><i class="fas fa-map-marked-alt"></i> Beatroute Master</a>
                        </li>
                        <li class="nav-item" data-route="settings">
                            <a href="#settings"><i class="fas fa-cogs"></i> System Settings</a>
                        </li>
                    <?php endif; ?>
                </ul>

                <!-- User account footer status -->
                <div class="user-info-area">
                    <img src="<?php echo htmlspecialchars($photo); ?>" alt="avatar" class="user-avatar" id="sidebar-avatar">
                    <div class="user-details">
                        <div class="user-name" id="sidebar-fullname"><?php echo htmlspecialchars($fullname); ?></div>
                        <div class="user-role"><?php echo $roleName; ?></div>
                    </div>
                </div>
            </aside>

            <!-- Main Content Area Wrapper -->
            <main id="main-content">
                <!-- Sticky Glass Header Top Bar -->
                <header id="navbar" class="glass-effect">
                    <div class="d-flex align-items-center gap-3">
                        <button class="btn text-white d-lg-none" id="mobile-sidebar-toggle">
                            <i class="fas fa-bars fs-4"></i>
                        </button>
                        <h4 class="fw-bold mb-0 text-white d-none d-md-block" id="navbar-company-title">NAVATARA ENTERPRISES
                        </h4>
                    </div>

                    <div class="d-flex align-items-center gap-3">
                        <div class="dropdown">
                            <button
                                class="btn btn-outline-secondary border-secondary dropdown-toggle text-white d-flex align-items-center gap-2"
                                type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user-circle fs-5 text-primary"></i> <span
                                    class="d-none d-sm-inline"><?php echo htmlspecialchars($fullname); ?></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark border-secondary bg-dark shadow">
                                <li><a class="dropdown-item py-2" href="#retailers"><i
                                            class="fas fa-store me-2 text-info"></i> Retailers</a></li>
                                <li>
                                    <hr class="dropdown-divider border-secondary">
                                </li>
                                <li><a class="dropdown-item py-2 text-danger fw-bold" href="#" id="logout-trigger"><i
                                            class="fas fa-sign-out-alt me-2"></i> Log Out</a></li>
                            </ul>
                        </div>
                    </div>
                </header>

                <!-- Main Router View Target -->
                <div class="page-container" id="content-pane">
                    <!-- Dynamic views will load here -->
                    <div class="text-center py-5">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    <?php endif; ?>

    <!-- Central Purchase Details Modal (accessible from Purchase Entry & GST Report) -->
    <div class="modal fade" id="purchaseDetailsModal" tabindex="-1" aria-labelledby="purchaseDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content bg-dark text-white border-secondary">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title" id="purchaseDetailsModalLabel"><i class="fas fa-file-invoice text-primary me-2"></i> Purchase Receipt Details</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <p class="mb-1 text-secondary text-uppercase small font-monospace">Supplier Name</p>
                            <h5 class="fw-bold text-white mb-0" id="detail-pur-supplier">Nestle India</h5>
                        </div>
                        <div class="col-md-3">
                            <p class="mb-1 text-secondary text-uppercase small font-monospace">Invoice / Ref No.</p>
                            <h5 class="fw-bold text-white mb-0" id="detail-pur-invoice">INV-9842</h5>
                        </div>
                        <div class="col-md-3">
                            <p class="mb-1 text-secondary text-uppercase small font-monospace">Purchase Date</p>
                            <h5 class="fw-bold text-white mb-0" id="detail-pur-date">18-Jul-2026</h5>
                        </div>
                    </div>
                    
                    <h6 class="fw-bold border-bottom border-secondary pb-2 mb-3 text-primary"><i class="fas fa-boxes me-2"></i> Purchased Products List</h6>
                    <div class="table-responsive">
                        <table class="table table-custom mb-0">
                            <thead>
                                <tr>
                                    <th>Product / SKU</th>
                                    <th>SKU Code</th>
                                    <th class="text-end">Qty</th>
                                    <th class="text-end">Rate (excl. Tax) (₹)</th>
                                    <th class="text-end">Discount (₹)</th>
                                    <th class="text-center">GST %</th>
                                    <th class="text-end">GST Paid (₹)</th>
                                    <th class="text-end">Total Amount (₹)</th>
                                </tr>
                            </thead>
                            <tbody id="detail-pur-items-body">
                                <!-- Populated dynamically -->
                            </tbody>
                            <tfoot>
                                <tr class="fw-bold bg-dark text-white">
                                    <td colspan="3" class="text-end">Total Summary:</td>
                                    <td class="text-end text-info" id="detail-pur-total-subtotal">₹0.00</td>
                                    <td class="text-end text-danger" id="detail-pur-total-discount">₹0.00</td>
                                    <td></td>
                                    <td class="text-end text-warning" id="detail-pur-total-gst">₹0.00</td>
                                    <td class="text-end text-success" id="detail-pur-total-grand">₹0.00</td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    
                    <div class="mt-4 pt-3 border-top border-secondary">
                        <p class="mb-1 text-secondary text-uppercase small font-monospace">Remarks / Notes</p>
                        <p class="mb-0 text-white-50" id="detail-pur-remarks">N/A</p>
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Load jQuery & Bootstrap Bundle CDN -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- DataTables JS & ChartJS CDN -->
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    
    <!-- DataTables Export Buttons -->
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Main Application SPA JS -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="assets/js/app.js"></script>
</body>

</html>