<!-- views/gst_report.php -->
<!-- GST Audit & Reconciliation Report (Owner Only) -->
<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
    <div>
        <h3 class="fw-bold mb-0">GST Taxation Report</h3>
        <p class="text-secondary mb-0">Track Input Tax Credit (ITC) on supplier purchases and expenses vs. Outward GST collected on retail sales</p>
    </div>
    
    <!-- Date Filters -->
    <div class="d-flex align-items-center gap-2 bg-dark-custom p-2 rounded border border-secondary shadow-sm">
        <div class="d-flex align-items-center gap-1">
            <span class="text-secondary small">From:</span>
            <input type="date" id="gst-start-date" class="form-control form-control-sm bg-dark text-white border-secondary" style="width: 130px;" value="<?php echo date('Y-m-01'); ?>">
        </div>
        <div class="d-flex align-items-center gap-1">
            <span class="text-secondary small">To:</span>
            <input type="date" id="gst-end-date" class="form-control form-control-sm bg-dark text-white border-secondary" style="width: 130px;" value="<?php echo date('Y-m-d'); ?>">
        </div>
        <button id="gst-filter-btn" class="btn btn-action primary btn-sm px-3"><i class="fas fa-filter"></i> Filter</button>
    </div>
</div>

<!-- Summary Cards Grid -->
<div class="row mb-4">
    <!-- Outward GST Card -->
    <div class="col-md-4 mb-3">
        <div class="custom-card border-left-info shadow-sm h-100">
            <div class="custom-card-body p-3 d-flex align-items-center justify-content-between">
                <div>
                    <h6 class="text-info fw-bold text-uppercase mb-1 small">Outward GST (Collected)</h6>
                    <h3 class="fw-bold mb-0 text-white" id="lbl-outward-gst">₹0.00</h3>
                    <span class="text-secondary small">From sales invoices</span>
                </div>
                <div class="fs-1 text-info opacity-50"><i class="fas fa-file-invoice-dollar"></i></div>
            </div>
        </div>
    </div>
    
    <!-- Inward GST Card -->
    <div class="col-md-4 mb-3">
        <div class="custom-card border-left-success shadow-sm h-100">
            <div class="custom-card-body p-3 d-flex align-items-center justify-content-between">
                <div>
                    <h6 class="text-success fw-bold text-uppercase mb-1 small">Inward GST (Paid / ITC)</h6>
                    <h3 class="fw-bold mb-0 text-white" id="lbl-inward-gst">₹0.00</h3>
                    <span class="text-secondary small" id="lbl-inward-breakdown">Purchases: ₹0.00 | Exp: ₹0.00</span>
                </div>
                <div class="fs-1 text-success opacity-50"><i class="fas fa-shopping-cart"></i></div>
            </div>
        </div>
    </div>
    
    <!-- Net GST Liability Card -->
    <div class="col-md-4 mb-3">
        <div class="custom-card border-left-warning shadow-sm h-100">
            <div class="custom-card-body p-3 d-flex align-items-center justify-content-between">
                <div>
                    <h6 class="text-warning fw-bold text-uppercase mb-1 small">Net GST Payable / Credit</h6>
                    <h3 class="fw-bold mb-0 text-white" id="lbl-net-gst">₹0.00</h3>
                    <span class="text-secondary small" id="lbl-gst-liability-desc">Net payable to government</span>
                </div>
                <div class="fs-1 text-warning opacity-50"><i class="fas fa-balance-scale"></i></div>
            </div>
        </div>
    </div>
</div>

<!-- Tabs for different GST ledgers -->
<ul class="nav nav-tabs custom-tabs mb-3" id="gstReportTabs" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="gst-sales-tab" data-bs-toggle="tab" data-bs-target="#gst-sales-pane" type="button" role="tab" aria-selected="true">
            <i class="fas fa-arrow-up text-info me-1"></i> Outward GST (Sales)
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="gst-purchases-tab" data-bs-toggle="tab" data-bs-target="#gst-purchases-pane" type="button" role="tab" aria-selected="false">
            <i class="fas fa-arrow-down text-success me-1"></i> Inward GST (Product Purchases)
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="gst-expenses-tab" data-bs-toggle="tab" data-bs-target="#gst-expenses-pane" type="button" role="tab" aria-selected="false">
            <i class="fas fa-receipt text-warning me-1"></i> Inward GST (Expenses &amp; Assets)
        </button>
    </li>
</ul>

<div class="tab-content" id="gstReportTabsContent">
    <!-- 1. Outward GST Pane -->
    <div class="tab-pane fade show active" id="gst-sales-pane" role="tabpanel">
        <div class="custom-card">
            <div class="custom-card-header d-flex justify-content-between align-items-center py-3">
                <h5 class="custom-card-title mb-0"><i class="fas fa-file-invoice me-1 text-info"></i> Sales Invoices Outward GST Registry</h5>
                <button id="btn-export-gst-sales" class="btn btn-action primary btn-sm"><i class="fas fa-file-download me-1"></i> Export Outward CSV</button>
            </div>
            <div class="custom-card-body">
                <div class="table-responsive">
                    <table class="table table-custom table-hover w-100" id="gst-sales-table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Invoice No.</th>
                                <th>Retailer Shop</th>
                                <th>GSTIN</th>
                                <th class="text-end">Taxable Subtotal (₹)</th>
                                <th class="text-end">GST Collected (₹)</th>
                                <th class="text-end">Grand Total (₹)</th>
                            </tr>
                        </thead>
                        <tbody id="gst-sales-body">
                            <!-- Populated dynamically -->
                        </tbody>
                        <tfoot>
                            <tr class="fw-bold bg-dark text-white">
                                <td colspan="4" class="text-end">Grand Total:</td>
                                <td class="text-end text-info" id="gst-sales-total-subtotal">₹0.00</td>
                                <td class="text-end text-warning" id="gst-sales-total-gst">₹0.00</td>
                                <td class="text-end text-success" id="gst-sales-total-grand">₹0.00</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 2. Inward GST (Product Purchases) Pane -->
    <div class="tab-pane fade" id="gst-purchases-pane" role="tabpanel">
        <div class="custom-card">
            <div class="custom-card-header d-flex justify-content-between align-items-center py-3">
                <h5 class="custom-card-title mb-0"><i class="fas fa-truck-loading me-1 text-success"></i> Stock Purchases Inward GST Registry</h5>
                <button id="btn-export-gst-purchases" class="btn btn-action success btn-sm"><i class="fas fa-file-download me-1"></i> Export Inward CSV</button>
            </div>
            <div class="custom-card-body">
                <div class="table-responsive">
                    <table class="table table-custom table-hover w-100" id="gst-purchases-table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Supplier Invoice No.</th>
                                <th>Supplier Name</th>
                                <th class="text-end">Taxable Subtotal (₹)</th>
                                <th class="text-end">GST Paid (₹)</th>
                                <th class="text-end">Grand Total (₹)</th>
                                <th>Remarks</th>
                            </tr>
                        </thead>
                        <tbody id="gst-purchases-body">
                            <!-- Populated dynamically -->
                        </tbody>
                        <tfoot>
                            <tr class="fw-bold bg-dark text-white">
                                <td colspan="3" class="text-end">Grand Total:</td>
                                <td class="text-end text-info" id="gst-pur-total-subtotal">₹0.00</td>
                                <td class="text-end text-warning" id="gst-pur-total-gst">₹0.00</td>
                                <td class="text-end text-success" id="gst-pur-total-grand">₹0.00</td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 3. Inward GST (Expenses & Assets) Pane -->
    <div class="tab-pane fade" id="gst-expenses-pane" role="tabpanel">
        <div class="custom-card">
            <div class="custom-card-header d-flex justify-content-between align-items-center py-3">
                <h5 class="custom-card-title mb-0"><i class="fas fa-receipt me-1 text-warning"></i> Company Assets &amp; Expenses GST Registry</h5>
                <button id="btn-export-gst-expenses" class="btn btn-action warning btn-sm text-white"><i class="fas fa-file-download me-1"></i> Export Expenses CSV</button>
            </div>
            <div class="custom-card-body">
                <div class="table-responsive">
                    <table class="table table-custom table-hover w-100" id="gst-expenses-table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Expense Category</th>
                                <th>Paid To / Vendor</th>
                                <th class="text-end">Taxable Subtotal (₹)</th>
                                <th class="text-center">GST %</th>
                                <th class="text-end">GST Paid (₹)</th>
                                <th class="text-end">Grand Total (₹)</th>
                                <th>Remarks/Asset Details</th>
                            </tr>
                        </thead>
                        <tbody id="gst-expenses-body">
                            <!-- Populated dynamically -->
                        </tbody>
                        <tfoot>
                            <tr class="fw-bold bg-dark text-white">
                                <td colspan="3" class="text-end">Grand Total:</td>
                                <td class="text-end text-info" id="gst-exp-total-subtotal">₹0.00</td>
                                <td></td>
                                <td class="text-end text-warning" id="gst-exp-total-gst">₹0.00</td>
                                <td class="text-end text-success" id="gst-exp-total-grand">₹0.00</td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
