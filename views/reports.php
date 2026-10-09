<!-- views/reports.php -->
<!-- Management Reports View (Owner Only) -->
<div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
    <div>
        <h3 class="fw-bold mb-1 d-flex align-items-center gap-2">
            <i class="fas fa-chart-line text-warning"></i> Reports
        </h3>
        <p class="text-secondary mb-0">Financial analytics and gross monthly earnings by product and by retailer</p>
    </div>
</div>

<!-- Report Navigation Tabs -->
<ul class="nav nav-pills mb-4 gap-2" id="reports-tab-nav" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active px-4 py-2 fw-semibold" id="tab-product-earnings-btn" data-bs-toggle="pill" data-bs-target="#tab-product-earnings" type="button" role="tab">
            <i class="fas fa-box-open me-2"></i> Gross Monthly Earning by Product
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link px-4 py-2 fw-semibold" id="tab-retailer-earnings-btn" data-bs-toggle="pill" data-bs-target="#tab-retailer-earnings" type="button" role="tab">
            <i class="fas fa-store me-2"></i> Gross Monthly Earning by Retailer
        </button>
    </li>
</ul>

<div class="tab-content" id="reports-tab-content">
    <!-- ======================================================== -->
    <!-- REPORT 1: GROSS MONTHLY EARNING FROM PRODUCT -->
    <!-- ======================================================== -->
    <div class="tab-pane fade show active" id="tab-product-earnings" role="tabpanel">
        <!-- Filter Card -->
        <div class="custom-card mb-4">
            <div class="custom-card-body p-3">
                <div class="row g-3 align-items-end">
                    <div class="col-12 col-md-3">
                        <label class="form-label-custom small mb-1">Select Month</label>
                        <input type="month" class="form-control form-control-custom" id="filter-product-report-month" value="<?php echo date('Y-m'); ?>">
                    </div>
                    <div class="col-12 col-md-4">
                        <label class="form-label-custom small mb-1">Select Product</label>
                        <select class="form-select form-control-custom" id="filter-product-report-id">
                            <option value="0">-- All Products --</option>
                            <!-- Populated via AJAX -->
                        </select>
                    </div>
                    <div class="col-12 col-md-5">
                        <div class="d-flex flex-wrap gap-2 justify-content-md-end">
                            <button type="button" class="btn btn-action primary" id="btn-generate-product-report">
                                <i class="fas fa-search me-1"></i> Generate Report
                            </button>
                            <button type="button" class="btn btn-outline-success border-success text-white" id="btn-export-product-csv">
                                <i class="fas fa-file-excel me-1"></i> Export Excel/CSV
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- KPI Metrics Grid for Product Report -->
        <div class="metrics-grid mb-4">
            <div class="metric-card info">
                <div class="metric-info">
                    <span class="label">Units Sold</span>
                    <h3 class="value" id="kpi-product-total-units">0</h3>
                </div>
                <div class="metric-icon"><i class="fas fa-boxes"></i></div>
            </div>
            <div class="metric-card primary">
                <div class="metric-info">
                    <span class="label">Total Sales Revenue</span>
                    <h3 class="value" id="kpi-product-total-sales">₹0.00</h3>
                </div>
                <div class="metric-icon"><i class="fas fa-receipt"></i></div>
            </div>
            <div class="metric-card danger">
                <div class="metric-info">
                    <span class="label">Purchase Cost (COGS)</span>
                    <h3 class="value" id="kpi-product-total-cost">₹0.00</h3>
                </div>
                <div class="metric-icon"><i class="fas fa-shopping-cart"></i></div>
            </div>
            <div class="metric-card success">
                <div class="metric-info">
                    <span class="label">Gross Earning (Profit)</span>
                    <h3 class="value text-success" id="kpi-product-gross-earning">₹0.00</h3>
                    <span class="small text-white-50" id="kpi-product-margin-pct">Margin: 0.00%</span>
                </div>
                <div class="metric-icon"><i class="fas fa-hand-holding-usd"></i></div>
            </div>
        </div>

        <!-- Main Product Table -->
        <div class="custom-card">
            <div class="custom-card-header d-flex justify-content-between align-items-center">
                <h5 class="custom-card-title mb-0">
                    <i class="fas fa-table text-info"></i> Product Gross Earnings Breakdown
                </h5>
                <span class="badge bg-secondary" id="product-report-period-badge"><?php echo date('F Y'); ?></span>
            </div>
            <div class="custom-card-body p-0">
                <div class="table-responsive">
                    <table id="product-earnings-table" class="table table-custom mb-0">
                        <thead>
                            <tr>
                                <th>Product / Brand</th>
                                <th>SKU Name &amp; Code</th>
                                <th class="text-center">HSN</th>
                                <th class="text-end">Units Sold</th>
                                <th class="text-end">Avg Selling Rate</th>
                                <th class="text-end">Purchase Rate</th>
                                <th class="text-end">Total Sales</th>
                                <th class="text-end">Total Cost</th>
                                <th class="text-end">Gross Earning</th>
                                <th class="text-center">Margin %</th>
                            </tr>
                        </thead>
                        <tbody id="product-earnings-rows">
                            <!-- Populated via AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- ======================================================== -->
    <!-- REPORT 2: GROSS MONTHLY EARNING FROM RETAILER -->
    <!-- ======================================================== -->
    <div class="tab-pane fade" id="tab-retailer-earnings" role="tabpanel">
        <!-- Filter Card -->
        <div class="custom-card mb-4">
            <div class="custom-card-body p-3">
                <div class="row g-3 align-items-end">
                    <div class="col-12 col-md-3">
                        <label class="form-label-custom small mb-1">Select Month</label>
                        <input type="month" class="form-control form-control-custom" id="filter-retailer-report-month" value="<?php echo date('Y-m'); ?>">
                    </div>
                    <div class="col-12 col-md-4">
                        <label class="form-label-custom small mb-1">Select Retailer</label>
                        <select class="form-select form-control-custom" id="filter-retailer-report-id">
                            <option value="0">-- All Retailers --</option>
                            <!-- Populated via AJAX -->
                        </select>
                    </div>
                    <div class="col-12 col-md-5">
                        <div class="d-flex flex-wrap gap-2 justify-content-md-end">
                            <button type="button" class="btn btn-action success" id="btn-generate-retailer-report">
                                <i class="fas fa-search me-1"></i> Generate Report
                            </button>
                            <button type="button" class="btn btn-outline-success border-success text-white" id="btn-export-retailer-csv">
                                <i class="fas fa-file-excel me-1"></i> Export Excel/CSV
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- KPI Metrics Grid for Retailer Report -->
        <div class="metrics-grid mb-4">
            <div class="metric-card info">
                <div class="metric-info">
                    <span class="label">Invoices / Units</span>
                    <h3 class="value" id="kpi-retailer-total-invoices">0 Invoices</h3>
                    <span class="small text-white-50" id="kpi-retailer-total-units">0 Units Bought</span>
                </div>
                <div class="metric-icon"><i class="fas fa-file-invoice"></i></div>
            </div>
            <div class="metric-card primary">
                <div class="metric-info">
                    <span class="label">Gross Invoiced Sales</span>
                    <h3 class="value" id="kpi-retailer-total-sales">₹0.00</h3>
                </div>
                <div class="metric-icon"><i class="fas fa-wallet"></i></div>
            </div>
            <div class="metric-card danger">
                <div class="metric-info">
                    <span class="label">Total COGS (Cost)</span>
                    <h3 class="value" id="kpi-retailer-total-cost">₹0.00</h3>
                </div>
                <div class="metric-icon"><i class="fas fa-shopping-cart"></i></div>
            </div>
            <div class="metric-card success">
                <div class="metric-info">
                    <span class="label">Gross Earning Generated</span>
                    <h3 class="value text-success" id="kpi-retailer-gross-earning">₹0.00</h3>
                    <span class="small text-white-50" id="kpi-retailer-margin-pct">Margin: 0.00%</span>
                </div>
                <div class="metric-icon"><i class="fas fa-hand-holding-usd"></i></div>
            </div>
        </div>

        <!-- Main Retailer Table -->
        <div class="custom-card">
            <div class="custom-card-header d-flex justify-content-between align-items-center">
                <h5 class="custom-card-title mb-0">
                    <i class="fas fa-table text-success"></i> Retailer Gross Earnings Breakdown
                </h5>
                <span class="badge bg-secondary" id="retailer-report-period-badge"><?php echo date('F Y'); ?></span>
            </div>
            <div class="custom-card-body p-0">
                <div class="table-responsive">
                    <table id="retailer-earnings-table" class="table table-custom mb-0">
                        <thead>
                            <tr>
                                <th>Retailer / Shop</th>
                                <th>Owner &amp; Mobile</th>
                                <th>Route / Area</th>
                                <th class="text-center">Invoices</th>
                                <th class="text-end">Units</th>
                                <th class="text-end">Total Sales</th>
                                <th class="text-end">Cost (COGS)</th>
                                <th class="text-end">Gross Earning</th>
                                <th class="text-center">Margin %</th>
                                <th class="text-end">Collections</th>
                            </tr>
                        </thead>
                        <tbody id="retailer-earnings-rows">
                            <!-- Populated via AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
