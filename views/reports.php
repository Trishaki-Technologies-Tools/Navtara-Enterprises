<!-- views/reports.php -->
<!-- Reports Export Portal View (Owner Only) -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Management Reports</h3>
        <p class="text-secondary mb-0">Export company operations, ledger, inventory and sales metrics directly to Excel / CSV spreadsheets</p>
    </div>
</div>

<div class="row">
    <!-- 1. Sales Report Card -->
    <div class="col-lg-4 col-md-6 mb-4">
        <div class="custom-card h-100 d-flex flex-column">
            <div class="custom-card-header">
                <h5 class="custom-card-title text-info"><i class="fas fa-file-invoice-dollar"></i> Sales Register Report</h5>
            </div>
            <div class="custom-card-body d-flex flex-column justify-content-between flex-grow-1">
                <p class="text-secondary small mb-4">Generates a detailed line-by-line report of all billed invoices, item quantities, discounts, and GST breakdowns for a selected date range.</p>
                <form action="api/reports.php" method="GET" target="_blank">
                    <input type="hidden" name="type" value="sales">
                    <div class="row mb-3">
                        <div class="col-6">
                            <label class="form-label-custom small">From Date</label>
                            <input type="date" class="form-control form-control-custom py-1 fs-7" name="start_date" value="<?php echo date('Y-m-01'); ?>" required>
                        </div>
                        <div class="col-6">
                            <label class="form-label-custom small">To Date</label>
                            <input type="date" class="form-control form-control-custom py-1 fs-7" name="end_date" value="<?php echo date('Y-m-d'); ?>" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-action primary w-100 justify-content-center"><i class="fas fa-file-download"></i> Download CSV</button>
                </form>
            </div>
        </div>
    </div>
    
    <!-- 2. Collection Report Card -->
    <div class="col-lg-4 col-md-6 mb-4">
        <div class="custom-card h-100 d-flex flex-column">
            <div class="custom-card-header">
                <h5 class="custom-card-title text-success"><i class="fas fa-hand-holding-usd"></i> Payment Collections Report</h5>
            </div>
            <div class="custom-card-body d-flex flex-column justify-content-between flex-grow-1">
                <p class="text-secondary small mb-4">Logs all cash, UPI, bank, or cheque receipts collected from retail shops, showing transaction date, method, and reference keys.</p>
                <form action="api/reports.php" method="GET" target="_blank">
                    <input type="hidden" name="type" value="collections">
                    <div class="row mb-3">
                        <div class="col-6">
                            <label class="form-label-custom small">From Date</label>
                            <input type="date" class="form-control form-control-custom py-1 fs-7" name="start_date" value="<?php echo date('Y-m-01'); ?>" required>
                        </div>
                        <div class="col-6">
                            <label class="form-label-custom small">To Date</label>
                            <input type="date" class="form-control form-control-custom py-1 fs-7" name="end_date" value="<?php echo date('Y-m-d'); ?>" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-action success w-100 justify-content-center"><i class="fas fa-file-download"></i> Download CSV</button>
                </form>
            </div>
        </div>
    </div>
    
    <!-- 3. Stock Valuation Report Card -->
    <div class="col-lg-4 col-md-6 mb-4">
        <div class="custom-card h-100 d-flex flex-column">
            <div class="custom-card-header">
                <h5 class="custom-card-title text-warning"><i class="fas fa-boxes"></i> Warehouse Stock Valuation</h5>
            </div>
            <div class="custom-card-body d-flex flex-column justify-content-between flex-grow-1">
                <p class="text-secondary small mb-4">Exports current physical inventory levels for all active SKUs. Provides real-time asset calculations under both purchase price (cost value) and selling price.</p>
                <a href="api/reports.php?type=stock" target="_blank" class="btn btn-action warning w-100 justify-content-center text-white"><i class="fas fa-file-download"></i> Export Valuation CSV</a>
            </div>
        </div>
    </div>
    
    <!-- 4. Retailer Outstandings Card -->
    <div class="col-lg-4 col-md-6 mb-4">
        <div class="custom-card h-100 d-flex flex-column">
            <div class="custom-card-header">
                <h5 class="custom-card-title text-danger"><i class="fas fa-store-slash"></i> Retailer Outstanding Ledgers</h5>
            </div>
            <div class="custom-card-body d-flex flex-column justify-content-between flex-grow-1">
                <p class="text-secondary small mb-4">Compiles credit profiles of all registered retailers. Evaluates current outstanding balances against limits and marks accounts that are over-limit.</p>
                <a href="api/reports.php?type=outstandings" target="_blank" class="btn btn-action danger w-100 justify-content-center"><i class="fas fa-file-download"></i> Export Outstandings CSV</a>
            </div>
        </div>
    </div>
    
    <!-- 5. Staff Targets & Progress Card -->
    <div class="col-lg-4 col-md-6 mb-4">
        <div class="custom-card h-100 d-flex flex-column">
            <div class="custom-card-header">
                <h5 class="custom-card-title text-primary"><i class="fas fa-chart-bar"></i> Sales Staff Target Variance</h5>
            </div>
            <div class="custom-card-body d-flex flex-column justify-content-between flex-grow-1">
                <p class="text-secondary small mb-4">Generates monthly performance matrices showing fixed salaries, sales targets, actual achieved completed invoicing volumes, variance amount, and percentage scores.</p>
                <a href="api/reports.php?type=staff" target="_blank" class="btn btn-action primary w-100 justify-content-center"><i class="fas fa-file-download"></i> Export Staff KPIs CSV</a>
            </div>
        </div>
    </div>
</div>
