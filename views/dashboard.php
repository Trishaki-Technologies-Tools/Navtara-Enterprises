<?php
// views/dashboard.php
// Dashboard Content template

require_once __DIR__ . '/../config/functions.php';
checkAuth();

$roleName = $_SESSION['role_name'];
$fullname = $_SESSION['fullname'];
?>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Dashboard Summary</h3>
        <p class="text-secondary mb-0">Welcome back, <strong class="text-primary"><?php echo htmlspecialchars($fullname); ?></strong> (<?php echo $roleName; ?>)</p>
    </div>
    <div>
        <span class="badge bg-secondary py-2 px-3 fw-bold"><i class="far fa-calendar-alt me-2"></i><?php echo date('d M Y'); ?></span>
    </div>
</div>

<!-- QUICK ACTIONS BAR -->
<div class="custom-card mb-4">
    <div class="custom-card-header">
        <h5 class="custom-card-title"><i class="fas fa-bolt text-warning"></i> Quick Actions</h5>
    </div>
    <div class="custom-card-body py-3">
        <div class="quick-action-row">
            <?php if ($roleName === 'Owner'): ?>
                <a href="#retailers" class="btn btn-action secondary"><i class="fas fa-plus"></i> Add Retailer</a>
                <a href="#skus" class="btn btn-action secondary"><i class="fas fa-barcode"></i> Manage SKUs</a>
                <a href="#inventory" class="btn btn-action secondary"><i class="fas fa-boxes"></i> Inventory Ledger</a>
                <a href="#orders" class="btn btn-action secondary"><i class="fas fa-check-double"></i> Review Orders</a>
                <a href="#accounting" class="btn btn-action secondary"><i class="fas fa-calculator"></i> Cash Book</a>
                <a href="#settings" class="btn btn-action secondary"><i class="fas fa-cogs"></i> ERP Settings</a>
            <?php else: ?>
                <a href="#retailers" class="btn btn-action primary"><i class="fas fa-user-plus"></i> New Retailer</a>
                <a href="#orders" class="btn btn-action primary"><i class="fas fa-shopping-basket"></i> Create Order</a>
                <a href="#payments" class="btn btn-action primary"><i class="fas fa-rupee-sign"></i> Collect Payment</a>
                <a href="#retailers" class="btn btn-action secondary"><i class="fas fa-map-marker-alt"></i> Visit Status</a>
            <?php endif; ?>
        </div>
    </div>
</div>

<!-- STATS CARDS GRID -->
<div class="metrics-grid" id="dashboard-metrics">
    <!-- Dynamic Content injected via JS based on API response -->
    <div class="text-center w-100 py-5">
        <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>
</div>

<!-- CHARTS SECTION -->
<div class="row mb-4">
    <div class="col-lg-8 mb-4 mb-lg-0">
        <div class="custom-card h-100">
            <div class="custom-card-header">
                <h5 class="custom-card-title"><i class="fas fa-chart-line text-primary"></i> Sales & Collection Trends (Last 7 Days)</h5>
            </div>
            <div class="custom-card-body">
                <div class="chart-container-custom">
                    <canvas id="salesTrendsChart"></canvas>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-lg-4">
        <div class="custom-card h-100">
            <div class="custom-card-header">
                <h5 class="custom-card-title">
                    <?php if ($roleName === 'Owner'): ?>
                        <i class="fas fa-chart-bar text-danger"></i> Top Outstanding Accounts
                    <?php else: ?>
                        <i class="fas fa-bullseye text-success"></i> Sales Target Tracker
                    <?php endif; ?>
                </h5>
            </div>
            <div class="custom-card-body d-flex flex-column justify-content-center">
                <?php if ($roleName === 'Owner'): ?>
                    <div class="chart-container-custom">
                        <canvas id="outstandingChart"></canvas>
                    </div>
                <?php else: ?>
                    <div class="text-center mb-4">
                        <h1 class="fw-bold mb-0 text-success" id="staff-target-progress">0%</h1>
                        <p class="text-secondary small text-uppercase fw-bold">Target Completed</p>
                    </div>
                    <div class="progress mb-3" style="height: 12px; border-radius: 6px; background-color: var(--border-color);">
                        <div class="progress-bar progress-bar-striped progress-bar-animated bg-success" id="staff-target-bar" role="progressbar" style="width: 0%"></div>
                    </div>
                    <div class="d-flex justify-content-between text-secondary small">
                        <span>Achieved: <strong class="text-white" id="staff-target-achieved">₹0.00</strong></span>
                        <span>Target: <strong class="text-white" id="staff-target-value">₹0.00</strong></span>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<!-- SECONDARY GRID -->
<div class="row">
    <?php if ($roleName === 'Owner'): ?>
    <div class="col-lg-5 mb-4 mb-lg-0">
        <div class="custom-card h-100">
            <div class="custom-card-header">
                <h5 class="custom-card-title"><i class="fas fa-trophy text-warning"></i> Top Selling SKUs (30 Days)</h5>
            </div>
            <div class="custom-card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom mb-0">
                        <thead>
                            <tr>
                                <th>SKU Product Name</th>
                                <th class="text-end">Units Sold</th>
                                <th class="text-end">Revenue</th>
                            </tr>
                        </thead>
                        <tbody id="top-selling-rows">
                            <tr><td colspan="3" class="text-center text-secondary py-4">No sales recorded yet.</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <?php endif; ?>
    
    <div class="<?php echo $roleName === 'Owner' ? 'col-lg-7' : 'col-12'; ?>">
        <div class="custom-card h-100">
            <div class="custom-card-header">
                <h5 class="custom-card-title"><i class="fas fa-shopping-bag text-info"></i> Recent Orders Log</h5>
                <a href="#orders" class="btn btn-action secondary py-1 px-3 fs-7">View All</a>
            </div>
            <div class="custom-card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom mb-0">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Shop Name</th>
                                <th>Order Date</th>
                                <th class="text-end">Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody id="recent-orders-rows">
                            <tr><td colspan="5" class="text-center text-secondary py-4">No recent orders.</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
