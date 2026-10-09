<!-- views/retailers_outstanding.php -->
<!-- Retailers Outstanding Logs View (Ranked in Descending Order) -->
<div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
    <div>
        <h3 class="fw-bold mb-1 d-flex align-items-center gap-2">
            <i class="fas fa-file-invoice-dollar text-warning"></i> Retailers Outstanding Logs
        </h3>
        <p class="text-secondary mb-0">Live tracking of customer balances, credit health, and payment collection logs in descending order</p>
    </div>
    <div class="d-flex flex-wrap gap-2">
        <button class="btn btn-outline-secondary border-secondary text-white btn-sm" id="btn-refresh-outstanding">
            <i class="fas fa-sync-alt me-1"></i> Refresh
        </button>
        <button class="btn btn-action primary" data-bs-toggle="modal" data-bs-target="#collectPaymentModal" id="btn-open-collect-payment">
            <i class="fas fa-hand-holding-usd me-1"></i> Collect Payment
        </button>
    </div>
</div>

<!-- KPI Summary Cards -->
<div class="row g-3 mb-4">
    <div class="col-12 col-sm-6 col-xl-3">
        <div class="custom-card p-3 h-100 border-start border-4 border-warning">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary small text-uppercase fw-bold">Total Outstanding</div>
                    <div class="fs-4 fw-bold text-warning mt-1" id="kpi-total-outstanding">₹0.00</div>
                    <div class="small text-muted mt-1">Pending receivable dues</div>
                </div>
                <div class="bg-warning bg-opacity-10 p-3 rounded-circle text-warning fs-4">
                    <i class="fas fa-rupee-sign"></i>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-12 col-sm-6 col-xl-3">
        <div class="custom-card p-3 h-100 border-start border-4 border-info">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary small text-uppercase fw-bold">Retailers With Dues</div>
                    <div class="fs-4 fw-bold text-info mt-1" id="kpi-total-count">0</div>
                    <div class="small text-muted mt-1">Active customer accounts</div>
                </div>
                <div class="bg-info bg-opacity-10 p-3 rounded-circle text-info fs-4">
                    <i class="fas fa-store"></i>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-12 col-sm-6 col-xl-3">
        <div class="custom-card p-3 h-100 border-start border-4 border-danger">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary small text-uppercase fw-bold">Limit Exceeded / Overdue</div>
                    <div class="fs-4 fw-bold text-danger mt-1" id="kpi-overdue-count">0</div>
                    <div class="small text-muted mt-1">Exceeding credit limit</div>
                </div>
                <div class="bg-danger bg-opacity-10 p-3 rounded-circle text-danger fs-4">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-12 col-sm-6 col-xl-3">
        <div class="custom-card p-3 h-100 border-start border-4 border-primary">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-secondary small text-uppercase fw-bold">Average Outstanding</div>
                    <div class="fs-4 fw-bold text-primary mt-1" id="kpi-avg-outstanding">₹0.00</div>
                    <div class="small text-muted mt-1">Per indebted retailer</div>
                </div>
                <div class="bg-primary bg-opacity-10 p-3 rounded-circle text-primary fs-4">
                    <i class="fas fa-chart-pie"></i>
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
                    <i class="fas fa-list-ol text-warning"></i> Outstanding Ranking (Highest to Lowest)
                </h5>
            </div>
            <div class="col-12 col-md-8 p-0">
                <div class="d-flex flex-wrap justify-content-md-end gap-2">
                    <!-- Route Filter -->
                    <select class="form-select form-control-custom form-select-sm" id="filter-out-route" style="max-width: 220px;">
                        <option value="">-- All Beat Routes --</option>
                        <!-- Loaded via JS -->
                    </select>
                    
                    <!-- Risk / Range Filter -->
                    <select class="form-select form-control-custom form-select-sm" id="filter-out-category" style="max-width: 200px;">
                        <option value="all" selected>All with Outstanding (> ₹0)</option>
                        <option value="overdue">Limit Exceeded / Overdue</option>
                        <option value="above_50k">Outstanding ≥ ₹50,000</option>
                        <option value="above_20k">Outstanding ≥ ₹20,000</option>
                        <option value="active_only">Active Retailers Only</option>
                        <option value="include_zero">Include All (incl. ₹0 dues)</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="retailers-outstanding-table" class="table table-custom mb-0 align-middle">
                <thead>
                    <tr>
                        <th class="text-center" style="width: 40px;">#</th>
                        <th>Shop &amp; Business Details</th>
                        <th>Owner &amp; Contacts</th>
                        <th>Location</th>
                        <th>Beat Route &amp; Staff</th>
                        <th class="text-end">Credit Limit</th>
                        <th class="text-end">Outstanding Amount</th>
                        <th class="text-center">Credit Health</th>
                        <th>Last Payment</th>
                        <th>Last Invoice</th>
                        <th class="text-center" style="width: 120px;">Actions</th>
                    </tr>
                </thead>
                <tbody id="retailers-outstanding-rows">
                    <!-- Loaded dynamically via AJAX in descending order -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Retailer Outstanding Details Drawer / Offcanvas -->
<div class="offcanvas offcanvas-end bg-dark text-white border-start border-secondary" tabindex="-1" id="outstandingDetailsDrawer" style="width: 550px; max-width: 100vw;">
    <div class="offcanvas-header border-bottom border-secondary p-4">
        <div>
            <h5 class="offcanvas-title fw-bold mb-1" id="drawer-shop-name">
                <i class="fas fa-store text-primary me-2"></i> Retailer Outstanding Profile
            </h5>
            <span class="small text-secondary" id="drawer-owner-info">Owner &amp; Area details</span>
        </div>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body p-4" id="drawer-content">
        <!-- Summary Box -->
        <div class="card bg-secondary bg-opacity-10 border border-secondary rounded p-3 mb-4">
            <div class="row g-3 text-center">
                <div class="col-6 border-end border-secondary">
                    <div class="text-secondary small text-uppercase">Total Outstanding</div>
                    <div class="fs-4 fw-bold text-danger mt-1" id="drawer-outstanding-val">₹0.00</div>
                </div>
                <div class="col-6">
                    <div class="text-secondary small text-uppercase">Credit Limit</div>
                    <div class="fs-4 fw-bold text-info mt-1" id="drawer-credit-limit-val">₹0.00</div>
                </div>
            </div>
            <div class="mt-3 pt-3 border-top border-secondary small d-flex justify-content-between align-items-center">
                <span class="text-secondary">Route: <strong class="text-white" id="drawer-route-val">-</strong></span>
                <span class="text-secondary">Status: <span id="drawer-status-badge"></span></span>
            </div>
        </div>

        <!-- Quick Communication & Actions -->
        <div class="d-flex gap-2 mb-4">
            <button class="btn btn-action primary flex-grow-1" id="drawer-btn-quick-collect">
                <i class="fas fa-rupee-sign me-1"></i> Collect Payment
            </button>
            <a href="#" class="btn btn-success" id="drawer-btn-whatsapp" target="_blank">
                <i class="fab fa-whatsapp me-1"></i> Send Reminder
            </a>
            <a href="#" class="btn btn-outline-info" id="drawer-btn-call">
                <i class="fas fa-phone"></i>
            </a>
        </div>

        <!-- Tabs for Invoices vs Payments -->
        <ul class="nav nav-pills nav-fill mb-3 border-bottom border-secondary pb-2" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active btn-sm" id="pills-unpaid-invoices-tab" data-bs-toggle="pill" data-bs-target="#pills-unpaid-invoices" type="button" role="tab">
                    <i class="fas fa-file-invoice me-1"></i> Invoices &amp; Bills
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link btn-sm" id="pills-recent-payments-tab" data-bs-toggle="pill" data-bs-target="#pills-recent-payments" type="button" role="tab">
                    <i class="fas fa-receipt me-1"></i> Payment Receipts
                </button>
            </li>
        </ul>

        <div class="tab-content">
            <!-- Unpaid Invoices Tab -->
            <div class="tab-pane fade show active" id="pills-unpaid-invoices" role="tabpanel">
                <div class="table-responsive">
                    <table class="table table-custom table-sm mb-0">
                        <thead>
                            <tr>
                                <th>Invoice #</th>
                                <th>Date</th>
                                <th class="text-end">Total (₹)</th>
                                <th class="text-end">Pending (₹)</th>
                                <th class="text-center">Aging / Status</th>
                            </tr>
                        </thead>
                        <tbody id="drawer-invoices-body">
                            <!-- Populated via JS -->
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Recent Payments Tab -->
            <div class="tab-pane fade" id="pills-recent-payments" role="tabpanel">
                <div class="table-responsive">
                    <table class="table table-custom table-sm mb-0">
                        <thead>
                            <tr>
                                <th>Receipt #</th>
                                <th>Date</th>
                                <th>Mode</th>
                                <th class="text-end">Amount (₹)</th>
                                <th>Collected By</th>
                            </tr>
                        </thead>
                        <tbody id="drawer-payments-body">
                            <!-- Populated via JS -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Collect Payment Modal (Integrated & Self-Contained) -->
<div class="modal fade" id="collectPaymentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-hand-holding-usd text-primary me-2"></i> Collect Retailer Payment</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="collect-payment-form">
                <div class="modal-body p-4">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="pay-route" class="form-label-custom">Select Beat Route</label>
                            <select class="form-select form-control-custom" id="pay-route" name="route_id">
                                <option value="">-- All Routes --</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="pay-retailer" class="form-label-custom">Select Retailer Shop <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="pay-retailer" name="retailer_id" required>
                                <option value="">-- Select Retailer --</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="pay-invoice" class="form-label-custom">Link to Specific Invoice (Optional)</label>
                        <select class="form-select form-control-custom" id="pay-invoice" name="invoice_id">
                            <option value="">-- Apply to General Outstanding Balance --</option>
                        </select>
                        <div class="form-text text-muted">If unselected, the amount will clear the oldest outstanding bills chronologically.</div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="pay-type" class="form-label-custom">Allocation Mode <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="pay-type" name="payment_type" required>
                                <option value="Partial Payment" selected>Partial Payment</option>
                                <option value="Full Payment">Full Payment Clearance</option>
                                <option value="Advance Payment">Advance Payment</option>
                                <option value="Credit Adjustment">Credit Note / Adjustment</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="pay-method" class="form-label-custom">Payment Mode <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="pay-method" name="payment_method" required>
                                <option value="Cash" selected>Cash</option>
                                <option value="UPI">UPI / GPay / PhonePe</option>
                                <option value="Bank Transfer">Bank Transfer / NEFT</option>
                                <option value="Cheque">Cheque</option>
                                <option value="Card">Card</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="pay-amount" class="form-label-custom">Amount Received (₹) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom fw-bold text-success" id="pay-amount" name="amount" required placeholder="0.00">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="pay-date" class="form-label-custom">Payment Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control form-control-custom" id="pay-date" name="payment_date" value="<?php echo date('Y-m-d'); ?>" required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="pay-ref" class="form-label-custom">Reference / Cheque / UTR No.</label>
                            <input type="text" class="form-control form-control-custom" id="pay-ref" name="reference_number" placeholder="e.g. UTR-928372">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label-custom">Current Outstanding</label>
                            <div class="p-2 border border-secondary rounded bg-dark text-warning fw-bold text-end" id="pay-outstanding-val">₹0.00</div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="pay-remarks" class="form-label-custom">Internal Note / Remarks</label>
                        <textarea class="form-control form-control-custom" id="pay-remarks" name="remarks" rows="2" placeholder="e.g. Collected via cash on delivery, cheque clearing in 2 days"></textarea>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Save &amp; Record Receipt</button>
                </div>
            </form>
        </div>
    </div>
</div>
