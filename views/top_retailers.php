<!-- views/top_retailers.php -->
<!-- Top Purchasing Retailers Analytics & Leaderboard View -->
<div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
    <div>
        <h3 class="fw-bold mb-1 d-flex align-items-center gap-2">
            <i class="fas fa-trophy text-warning"></i> Top Purchasing Retailers
        </h3>
        <p class="text-secondary mb-0">Rank customer accounts by purchase volume, order frequency, and repeat buyer consistency</p>
    </div>
    <div class="d-flex flex-wrap gap-2">
        <a href="#place_order" class="btn btn-action primary btn-sm">
            <i class="fas fa-plus-circle me-1"></i> New Sales Order
        </a>
    </div>
</div>

<!-- KPI Summary Cards (3 Cards) -->
<div class="row g-3 mb-4">
    <div class="col-12 col-md-4">
        <div class="custom-card p-3 h-100 border-start border-4 border-warning">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary small text-uppercase fw-bold">Total Sales</div>
                    <div class="fs-4 fw-bold text-warning mt-1" id="kpi-top-total-purchases">₹0.00</div>
                    <div class="small text-muted mt-1" id="kpi-active-buyers-count">0 Buying Accounts</div>
                </div>
                <div class="bg-warning bg-opacity-10 p-3 rounded-circle text-warning fs-4">
                    <i class="fas fa-wallet"></i>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-12 col-md-4">
        <div class="custom-card p-3 h-100 border-start border-4 border-success">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary small text-uppercase fw-bold">Orders</div>
                    <div class="fs-4 fw-bold text-success mt-1" id="kpi-top-total-orders">0</div>
                    <div class="small text-muted mt-1">Total order transactions</div>
                </div>
                <div class="bg-success bg-opacity-10 p-3 rounded-circle text-success fs-4">
                    <i class="fas fa-shopping-bag"></i>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-12 col-md-4">
        <div class="custom-card p-3 h-100 border-start border-4 border-info">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary small text-uppercase fw-bold">Total Units Sold</div>
                    <div class="fs-4 fw-bold text-info mt-1" id="kpi-top-total-units">0</div>
                    <div class="small text-muted mt-1">Total quantity sold</div>
                </div>
                <div class="bg-info bg-opacity-10 p-3 rounded-circle text-info fs-4">
                    <i class="fas fa-boxes"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Main Table Card with Filter Bar -->
<div class="custom-card">
    <div class="custom-card-header">
        <div class="row g-3 align-items-center justify-content-between w-100 m-0">
            <div class="col-12 col-md-4 p-0">
                <h5 class="custom-card-title mb-0 d-flex align-items-center gap-2">
                    <i class="fas fa-list-ol text-warning"></i> Purchasing Leaderboard
                </h5>
            </div>
            <div class="col-12 col-md-8 p-0">
                <div class="d-flex flex-wrap justify-content-md-end gap-2">
                    <!-- Period Filter -->
                    <select class="form-select form-control-custom form-select-sm" id="filter-top-period" style="max-width: 170px;">
                        <option value="all" selected>All Time</option>
                        <option value="this_month">This Month</option>
                        <option value="last_month">Last Month</option>
                        <option value="this_quarter">This Quarter</option>
                        <option value="this_year">This Year</option>
                    </select>

                    <!-- Route Filter -->
                    <select class="form-select form-control-custom form-select-sm" id="filter-top-route" style="max-width: 200px;">
                        <option value="">-- All Beat Routes --</option>
                        <!-- Loaded via JS -->
                    </select>
                    
                    <!-- Ranking Criterion Filter -->
                    <select class="form-select form-control-custom form-select-sm" id="filter-top-sort" style="max-width: 200px;">
                        <option value="purchase_desc" selected>Highest Purchase Value</option>
                        <option value="orders_desc">Most Frequent Orders</option>
                        <option value="units_desc">Highest Units Bought</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="top-retailers-table" class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th class="text-center" style="width: 60px;">Rank</th>
                        <th>Shop &amp; Retailer</th>
                        <th>Beat Route &amp; Staff</th>
                        <th class="text-end">Total Purchased (₹)</th>
                        <th class="text-center">Order Frequency</th>
                        <th class="text-end">Units Bought</th>
                        <th class="text-end">Avg Order (₹)</th>
                        <th class="text-center">Loyalty Tier</th>
                        <th>Last Purchase</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody id="top-retailers-rows">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>
