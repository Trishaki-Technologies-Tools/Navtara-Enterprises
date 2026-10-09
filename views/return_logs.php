<!-- views/return_logs.php -->
<!-- Sales Returns & Credit Notes Audit Logs View -->
<div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
    <div>
        <h3 class="fw-bold mb-1 d-flex align-items-center gap-2">
            <i class="fas fa-undo-alt text-danger"></i> Return Logs &amp; Credit Notes
        </h3>
        <p class="text-secondary mb-0">Audit history of customer product returns, inventory restocks, and issued GST credit notes</p>
    </div>
    <div class="d-flex flex-wrap gap-2">
        <a href="#billing" class="btn btn-action primary btn-sm">
            <i class="fas fa-file-invoice-dollar me-1"></i> Go to Bills &amp; Invoices
        </a>
    </div>
</div>

<!-- KPI Summary Metrics Grid (4 Cards) -->
<div class="metrics-grid mb-4">
    <div class="metric-card danger">
        <div class="metric-info">
            <span class="label">Total Returns Logged</span>
            <h3 class="value text-danger" id="kpi-total-returns">0</h3>
            <span class="small text-secondary" id="kpi-total-units-returned">0 Units Restocked</span>
        </div>
        <div class="metric-icon" style="color: #ef4444; background: rgba(239, 68, 68, 0.15);"><i class="fas fa-undo"></i></div>
    </div>
    <div class="metric-card warning">
        <div class="metric-info">
            <span class="label">Total Return Value</span>
            <h3 class="value text-warning" id="kpi-total-return-val">₹0.00</h3>
            <span class="small text-secondary">Goods returned value</span>
        </div>
        <div class="metric-icon" style="color: #f59e0b; background: rgba(245, 158, 11, 0.15);"><i class="fas fa-coins"></i></div>
    </div>
    <div class="metric-card info">
        <div class="metric-info">
            <span class="label">Credit Notes Issued</span>
            <h3 class="value text-info" id="kpi-total-credit-notes">0</h3>
            <span class="small text-secondary">Deducted from ledgers</span>
        </div>
        <div class="metric-icon" style="color: #3b82f6; background: rgba(59, 130, 246, 0.15);"><i class="fas fa-file-contract"></i></div>
    </div>
    <div class="metric-card success">
        <div class="metric-info">
            <span class="label">Inventory Restocked</span>
            <h3 class="value text-success" id="kpi-total-restocked-units">0 Pcs</h3>
            <span class="small text-secondary">Added back to inventory</span>
        </div>
        <div class="metric-icon" style="color: #10b981; background: rgba(16, 185, 129, 0.15);"><i class="fas fa-boxes"></i></div>
    </div>
</div>

<!-- Main Table Card -->
<div class="custom-card">
    <div class="custom-card-header d-flex flex-wrap justify-content-between align-items-center gap-2">
        <h5 class="custom-card-title mb-0">
            <i class="fas fa-list-alt text-danger"></i> Sales Returns &amp; Credit Notes Registry
        </h5>
        <div class="d-flex align-items-center gap-2">
            <select class="form-select form-control-custom form-select-sm dt-date-filter" data-table="return_logs" style="width: auto;">
                <option value="all">All Dates</option>
                <option value="today">Today</option>
                <option value="yesterday">Yesterday</option>
                <option value="this_week">This Week</option>
                <option value="this_month" selected>This Month</option>
                <option value="specific">Specific Date</option>
            </select>
            <input type="date" class="form-control form-control-custom form-control-sm dt-date-picker d-none" data-table="return_logs" style="width: auto;">
        </div>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="return-logs-table" class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th>Credit Note #</th>
                        <th>Return Date</th>
                        <th>Original Invoice</th>
                        <th>Retailer / Shop</th>
                        <th>Processed By</th>
                        <th class="text-center">Items &amp; Units</th>
                        <th class="text-end">Taxable Value</th>
                        <th class="text-end">GST Amount</th>
                        <th class="text-end">Total Credit (₹)</th>
                        <th class="text-center">Restocked</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody id="return-logs-rows">
                    <!-- Populated via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Return & Credit Note Detail Modal -->
<div class="modal fade" id="returnDetailModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom border-danger">
                <h5 class="modal-title fw-bold" id="returnDetailTitle">
                    <i class="fas fa-file-invoice text-danger"></i> Sales Return &amp; Credit Note Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <!-- Meta Details Header -->
                <div class="row mb-3 bg-secondary bg-opacity-10 p-3 rounded-lg border border-secondary mx-0">
                    <div class="col-md-6 mb-2 mb-md-0">
                        <p class="mb-1 text-secondary">Credited Retailer:</p>
                        <h6 class="fw-bold mb-0 text-white" id="det-ret-shop">Shop Name</h6>
                        <div class="small text-secondary" id="det-ret-name">Owner Name</div>
                        <div class="small text-white mt-1"><strong>GSTIN:</strong> <span id="det-ret-gst" class="text-info">N/A</span></div>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p class="mb-1 text-secondary">Credit Note: <strong class="text-danger" id="det-ret-cn">CN-0000</strong></p>
                        <p class="mb-1 text-secondary">Return Date: <strong class="text-white" id="det-ret-date">Date</strong></p>
                        <p class="mb-0 text-secondary">Against Invoice: <strong class="text-info" id="det-ret-inv">INV-0000</strong></p>
                    </div>
                </div>

                <!-- Returned Items List -->
                <h6 class="fw-bold text-warning mb-2">Returned Products Breakdown</h6>
                <div class="table-responsive mb-3">
                    <table class="table table-custom border border-secondary small" id="return-detail-items-table">
                        <thead>
                            <tr>
                                <th>Item Description</th>
                                <th>Code</th>
                                <th class="text-end">Returned Qty</th>
                                <th class="text-end">Rate (₹)</th>
                                <th class="text-end">Discount (₹)</th>
                                <th class="text-end">GST %</th>
                                <th class="text-end">Credit Total (₹)</th>
                                <th>Reason</th>
                            </tr>
                        </thead>
                        <tbody id="return-detail-items-rows">
                            <!-- Populated via JS -->
                        </tbody>
                    </table>
                </div>

                <!-- Financial Summary -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label-custom">Return Notes / Reason:</label>
                            <p class="p-2 border border-secondary rounded bg-secondary bg-opacity-10 small text-white-50" id="det-ret-remarks">None</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="p-3 bg-secondary bg-opacity-10 rounded border border-secondary">
                            <div class="d-flex justify-content-between mb-1 small">
                                <span class="text-secondary">Taxable Return Value:</span>
                                <strong class="text-white" id="det-ret-taxable">₹0.00</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-1 small">
                                <span class="text-secondary">GST Reversed:</span>
                                <strong class="text-white" id="det-ret-gstamt">₹0.00</strong>
                            </div>
                            <div class="d-flex justify-content-between border-top border-secondary pt-2 mt-2">
                                <span class="fw-bold text-danger">Total Credit Issued:</span>
                                <strong class="fs-5 text-danger" id="det-ret-total">₹0.00</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer modal-footer-custom justify-content-between">
                <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                <a href="#" id="btn-print-credit-note-modal" target="_blank" class="btn btn-danger btn-sm">
                    <i class="fas fa-print me-1"></i> Print Credit Note
                </a>
            </div>
        </div>
    </div>
</div>
