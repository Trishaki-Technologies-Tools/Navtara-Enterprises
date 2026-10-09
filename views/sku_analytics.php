<!-- views/sku_analytics.php -->
<!-- SKU Sales & Performance Analytics View -->
<div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
    <div>
        <h3 class="fw-bold mb-1 d-flex align-items-center gap-2">
            <i class="fas fa-chart-line text-info"></i> SKU Sales &amp; Performance Analytics
        </h3>
        <p class="text-secondary mb-0">Track high-selling SKUs, monthly sales velocity, category share, and stock health</p>
    </div>
    <div class="d-flex flex-wrap align-items-center gap-2">
        <!-- Month Selector -->
        <select class="form-select form-control-custom form-select-sm" id="analytics-month-select" style="width: auto;">
            <?php
            $currentMonth = (int)date('m');
            for ($m = 1; $m <= 12; $m++):
                $mName = date('F', mktime(0, 0, 0, $m, 10));
                $selected = ($m === $currentMonth) ? 'selected' : '';
                echo "<option value='{$m}' {$selected}>{$mName}</option>";
            endfor;
            ?>
        </select>
        
        <!-- Year Selector -->
        <select class="form-select form-control-custom form-select-sm" id="analytics-year-select" style="width: auto;">
            <?php
            $currentYear = (int)date('Y');
            for ($y = $currentYear; $y >= $currentYear - 3; $y--):
                echo "<option value='{$y}'>{$y}</option>";
            endfor;
            ?>
        </select>

        <!-- Brand Filter -->
        <select class="form-select form-control-custom form-select-sm" id="analytics-brand-select" style="width: auto; max-width: 180px;">
            <option value="">-- All Brands --</option>
            <!-- Loaded via JS -->
        </select>

        <button class="btn btn-outline-secondary border-secondary text-white btn-sm" id="btn-refresh-sku-analytics">
            <i class="fas fa-sync-alt me-1"></i> Refresh
        </button>
    </div>
</div>

<!-- KPI Cards Header -->
<div class="row g-3 mb-4">
    <!-- Top SKU by Volume -->
    <div class="col-12 col-sm-6 col-xl-3">
        <div class="custom-card p-3 h-100 border-start border-4 border-info">
            <div class="d-flex justify-content-between align-items-center">
                <div class="w-100 pe-2">
                    <div class="text-secondary small text-uppercase fw-bold">Top Volume SKU</div>
                    <div class="fs-5 fw-bold text-info text-truncate mt-1" id="kpi-top-sku-qty-name">Loading...</div>
                    <div class="small text-white-50 mt-1 d-flex justify-content-between">
                        <span>Units: <strong class="text-white" id="kpi-top-sku-qty-val">0</strong></span>
                        <span class="text-info" id="kpi-top-sku-qty-rev">₹0.00</span>
                    </div>
                </div>
                <div class="bg-info bg-opacity-10 p-3 rounded-circle text-info fs-4 flex-shrink-0">
                    <i class="fas fa-trophy"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Top SKU by Revenue -->
    <div class="col-12 col-sm-6 col-xl-3">
        <div class="custom-card p-3 h-100 border-start border-4 border-success">
            <div class="d-flex justify-content-between align-items-center">
                <div class="w-100 pe-2">
                    <div class="text-secondary small text-uppercase fw-bold">Top Revenue SKU</div>
                    <div class="fs-5 fw-bold text-success text-truncate mt-1" id="kpi-top-sku-rev-name">Loading...</div>
                    <div class="small text-white-50 mt-1 d-flex justify-content-between">
                        <span>Sales: <strong class="text-success" id="kpi-top-sku-rev-val">₹0.00</strong></span>
                        <span class="text-white" id="kpi-top-sku-rev-qty">0 units</span>
                    </div>
                </div>
                <div class="bg-success bg-opacity-10 p-3 rounded-circle text-success fs-4 flex-shrink-0">
                    <i class="fas fa-crown"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Total Units Sold -->
    <div class="col-12 col-sm-6 col-xl-3">
        <div class="custom-card p-3 h-100 border-start border-4 border-warning">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary small text-uppercase fw-bold">Total Units Sold</div>
                    <div class="fs-4 fw-bold text-warning mt-1" id="kpi-total-units">0</div>
                    <div class="small text-muted mt-1" id="kpi-period-label-units">In selected month</div>
                </div>
                <div class="bg-warning bg-opacity-10 p-3 rounded-circle text-warning fs-4">
                    <i class="fas fa-cubes"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Total Gross SKU Revenue -->
    <div class="col-12 col-sm-6 col-xl-3">
        <div class="custom-card p-3 h-100 border-start border-4 border-primary">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary small text-uppercase fw-bold">Gross SKU Sales</div>
                    <div class="fs-4 fw-bold text-primary mt-1" id="kpi-total-revenue">₹0.00</div>
                    <div class="small text-muted mt-1" id="kpi-period-label-rev">In selected month</div>
                </div>
                <div class="bg-primary bg-opacity-10 p-3 rounded-circle text-primary fs-4">
                    <i class="fas fa-coins"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Interactive Charts Section -->
<div class="row g-3 mb-4">
    <!-- Top 10 High Selling SKUs Bar Chart -->
    <div class="col-12 col-lg-8">
        <div class="custom-card h-100">
            <div class="custom-card-header d-flex justify-content-between align-items-center">
                <h5 class="custom-card-title mb-0 d-flex align-items-center gap-2">
                    <i class="fas fa-chart-bar text-info"></i> Top 10 Best Selling SKUs
                </h5>
                <div class="btn-group btn-group-sm" role="group">
                    <button type="button" class="btn btn-outline-secondary active btn-chart-metric" data-metric="qty">By Volume (Units)</button>
                    <button type="button" class="btn btn-outline-secondary btn-chart-metric" data-metric="revenue">By Value (₹)</button>
                </div>
            </div>
            <div class="custom-card-body">
                <div style="position: relative; height: 280px; width: 100%;">
                    <canvas id="chart-top-skus"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Category / Brand Share Donut Chart -->
    <div class="col-12 col-lg-4">
        <div class="custom-card h-100">
            <div class="custom-card-header">
                <h5 class="custom-card-title mb-0 d-flex align-items-center gap-2">
                    <i class="fas fa-chart-pie text-warning"></i> Brand / Category Sales Share
                </h5>
            </div>
            <div class="custom-card-body">
                <div style="position: relative; height: 280px; width: 100%;">
                    <canvas id="chart-category-share"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Comprehensive SKU Performance Table -->
<div class="custom-card">
    <div class="custom-card-header d-flex flex-wrap justify-content-between align-items-center gap-2">
        <h5 class="custom-card-title mb-0 d-flex align-items-center gap-2">
            <i class="fas fa-list-ol text-primary"></i> SKU Sales Rankings &amp; Stock Velocity
        </h5>
        <div class="d-flex align-items-center gap-2">
            <span class="badge bg-secondary bg-opacity-50 text-white font-monospace" id="table-period-badge">Selected Month</span>
        </div>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="sku-analytics-table" class="table table-custom mb-0 align-middle">
                <thead>
                    <tr>
                        <th class="text-center" style="width: 40px;">#</th>
                        <th>SKU Description</th>
                        <th>Brand / Category</th>
                        <th class="text-end">Units Sold</th>
                        <th class="text-end">Gross Revenue (₹)</th>
                        <th class="text-end">Selling Price</th>
                        <?php if ($_SESSION['role_name'] === 'Owner'): ?>
                        <th class="text-end">Est. Profit (₹)</th>
                        <th class="text-center">Margin</th>
                        <?php endif; ?>
                        <th class="text-center">Current Stock</th>
                        <th class="text-center">Sales Invoices</th>
                        <th class="text-center" style="width: 90px;">History</th>
                    </tr>
                </thead>
                <tbody id="sku-analytics-rows">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Offcanvas Drawer: SKU Sales History & Month-by-Month Trend -->
<div class="offcanvas offcanvas-end bg-dark text-white border-start border-secondary" tabindex="-1" id="skuHistoryDrawer" style="width: 600px; max-width: 100vw;">
    <div class="offcanvas-header border-bottom border-secondary p-4">
        <div>
            <h5 class="offcanvas-title fw-bold mb-1" id="sku-drawer-title">
                <i class="fas fa-barcode text-primary me-2"></i> SKU Performance History
            </h5>
            <span class="small text-secondary" id="sku-drawer-subtitle">Product details</span>
        </div>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body p-4" id="sku-drawer-content">
        <!-- SKU Meta Banner -->
        <div class="card bg-secondary bg-opacity-10 border border-secondary rounded p-3 mb-4">
            <div class="row g-2 text-center">
                <div class="col-4 border-end border-secondary">
                    <div class="text-secondary small text-uppercase">Selling Price</div>
                    <div class="fs-6 fw-bold text-white mt-1" id="sku-drawer-sp">₹0.00</div>
                </div>
                <div class="col-4 border-end border-secondary">
                    <div class="text-secondary small text-uppercase">MRP</div>
                    <div class="fs-6 fw-bold text-info mt-1" id="sku-drawer-mrp">₹0.00</div>
                </div>
                <div class="col-4">
                    <div class="text-secondary small text-uppercase">In Stock</div>
                    <div class="fs-6 fw-bold text-success mt-1" id="sku-drawer-stock">0 Units</div>
                </div>
            </div>
        </div>

        <!-- 12-Month Sales Breakdown Chart -->
        <div class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <h6 class="fw-bold text-info mb-0"><i class="fas fa-calendar-alt me-1"></i> Monthly Sales Volume Trend (<span id="sku-drawer-year">2026</span>)</h6>
            </div>
            <div style="position: relative; height: 200px; width: 100%;">
                <canvas id="chart-sku-monthly-trend"></canvas>
            </div>
        </div>

        <!-- Recent Invoices / Sales Table -->
        <h6 class="fw-bold text-warning mb-2"><i class="fas fa-receipt me-1"></i> Recent Retailer Sales Entries</h6>
        <div class="table-responsive">
            <table class="table table-custom table-sm mb-0">
                <thead>
                    <tr>
                        <th>Invoice #</th>
                        <th>Date</th>
                        <th>Retailer Shop</th>
                        <th class="text-end">Qty</th>
                        <th class="text-end">Rate (₹)</th>
                        <th class="text-end">Total (₹)</th>
                    </tr>
                </thead>
                <tbody id="sku-drawer-recent-sales-body">
                    <!-- Populated via JS -->
                </tbody>
            </table>
        </div>
    </div>
</div>
