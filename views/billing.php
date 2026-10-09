<!-- views/billing.php -->
<!-- Invoices and Billing View -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Invoices &amp; Billing</h3>
        <p class="text-secondary mb-0">Review tax invoices, payment statuses, and print billing records</p>
    </div>
</div>

<div class="custom-card">
    <div class="custom-card-header d-flex justify-content-between align-items-center">
        <h5 class="custom-card-title mb-0"><i class="fas fa-file-invoice-dollar text-primary"></i> Generated Bills &amp; Invoices</h5>
        <div class="d-flex align-items-center gap-2">
            <select class="form-select form-control-custom form-select-sm dt-date-filter" data-table="invoices" style="width: auto;">
                <option value="all">All Dates</option>
                <option value="today">Today</option>
                <option value="yesterday">Yesterday</option>
                <option value="this_week">This Week</option>
                <option value="this_month">This Month</option>
                <option value="specific">Specific Date</option>
            </select>
            <input type="date" class="form-control form-control-custom form-control-sm dt-date-picker d-none" data-table="invoices" style="width: auto;">
        </div>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="invoices-table" class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th>Invoice No</th>
                        <th>Shop Name</th>
                        <th>Date</th>
                        <th>Type</th>
                        <th class="text-end">Grand Total</th>
                        <th class="text-end">Paid Amt</th>
                        <th class="text-end">Outstanding</th>
                        <th>Payment Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody id="invoices-rows">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Invoice View Modal -->
<div class="modal fade" id="invoiceDetailModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold" id="invoiceDetailTitle"><i class="fas fa-file-invoice text-primary"></i> Invoice Details</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <!-- Meta data row -->
                <div class="row mb-3 bg-secondary bg-opacity-10 p-3 rounded-lg border border-secondary mx-0">
                    <div class="col-md-6">
                        <p class="mb-1 text-secondary">Billed Retailer:</p>
                        <h6 class="fw-bold mb-0 text-white" id="det-inv-shop">Shop Name</h6>
                        <div class="small text-secondary mt-1" id="det-inv-address">Shop Address</div>
                        <div class="small text-white mt-1"><strong>GSTIN:</strong> <span id="det-inv-gst" class="text-info">N/A</span></div>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p class="mb-1 text-secondary">Invoice Number: <strong class="text-info" id="det-inv-number">No.</strong></p>
                        <p class="mb-1 text-secondary">Billing Date: <strong class="text-white" id="det-inv-date">Date</strong></p>
                        <p class="mb-0 text-secondary">Billing Category: <strong class="text-white" id="det-inv-type">Type</strong></p>
                    </div>
                </div>
                
                <h6 class="fw-bold text-info mb-2">Billed Items</h6>
                <div class="table-responsive mb-3">
                    <table class="table table-custom border border-secondary small" id="invoice-items-table">
                        <thead>
                            <tr>
                                <th>Item Description</th>
                                <th>Code</th>
                                <th class="text-end">Qty</th>
                                <th class="text-end">MRP (₹)</th>
                                <th class="text-end">Rate (₹)</th>
                                <th class="text-end">Discount (₹)</th>
                                <th class="text-end">GST %</th>
                                <th class="text-end">Total (₹)</th>
                            </tr>
                        </thead>
                        <tbody id="invoice-items-rows">
                            <!-- Loaded via JS -->
                        </tbody>
                    </table>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label-custom">Billing Remarks / Notes:</label>
                            <p class="p-2 border border-secondary rounded bg-secondary bg-opacity-10 small text-white-50" id="det-inv-remarks" style="white-space: pre-wrap;">None</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="p-3 bg-secondary bg-opacity-10 rounded border border-secondary small">
                            <div class="d-flex justify-content-between mb-1">
                                <span>Sub-Total Gross:</span>
                                <span id="det-inv-subtotal">₹0.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span>Discount Allowed:</span>
                                <span class="text-success" id="det-inv-disc">- ₹0.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span>GST Taxes:</span>
                                <span id="det-inv-gstamt">₹0.00</span>
                            </div>
                            <hr class="my-2 border-secondary">
                            <div class="d-flex justify-content-between fw-bold text-white mb-2">
                                <span>Grand Total:</span>
                                <span id="det-inv-grand">₹0.00</span>
                            </div>
                            <div class="d-flex justify-content-between text-secondary mb-1">
                                <span>Paid Amount:</span>
                                <span id="det-inv-paid">₹0.00</span>
                            </div>
                            <div class="d-flex justify-content-between text-warning">
                                <span>Outstanding Balance:</span>
                                <span id="det-inv-outstanding">₹0.00</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer modal-footer-custom">
                <a href="" target="_blank" class="btn btn-action primary" id="btn-print-invoice-modal"><i class="fas fa-print"></i> Open Print Window</a>
                <?php if ($_SESSION['role_name'] === 'Owner'): ?>
                    <button type="button" class="btn btn-danger" id="btn-delete-invoice-modal" data-id=""><i class="fas fa-trash"></i> Delete Invoice</button>
                <?php endif; ?>
                <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Sales Return & Credit Note Modal -->
<div class="modal fade" id="salesReturnModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content modal-content-custom border-danger">
            <div class="modal-header modal-header-custom border-bottom border-danger">
                <h5 class="modal-title fw-bold text-danger">
                    <i class="fas fa-undo-alt me-2"></i> Process Sales Return &amp; Issue Credit Note
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="sales-return-form">
                <input type="hidden" name="invoice_id" id="return-modal-invoice-id">
                <div class="modal-body p-4">
                    <!-- Invoice Summary Meta Box -->
                    <div class="row g-3 mb-3 p-3 bg-secondary bg-opacity-10 rounded-lg border border-secondary">
                        <div class="col-12 col-md-4">
                            <span class="text-secondary small">Customer / Retailer:</span>
                            <h6 class="fw-bold text-white mb-0" id="return-modal-shop">Shop Name</h6>
                            <span class="small text-secondary" id="return-modal-owner">Owner Name</span>
                        </div>
                        <div class="col-6 col-md-4">
                            <span class="text-secondary small">Original Invoice:</span>
                            <div class="fw-bold text-info" id="return-modal-inv-num">INV-0000</div>
                            <span class="small text-secondary" id="return-modal-inv-date">Date</span>
                        </div>
                        <div class="col-6 col-md-4 text-md-end">
                            <span class="text-secondary small">Current Outstanding:</span>
                            <div class="fs-5 fw-bold text-warning" id="return-modal-outstanding">₹0.00</div>
                            <span class="small text-danger">Credit note will reduce balance</span>
                        </div>
                    </div>

                    <!-- Return Settings Row -->
                    <div class="row g-3 mb-3">
                        <div class="col-12 col-md-4">
                            <label class="form-label-custom small mb-1">Return Date *</label>
                            <input type="date" name="return_date" id="return-modal-date" class="form-control form-control-custom" value="<?php echo date('Y-m-d'); ?>" required>
                        </div>
                        <div class="col-12 col-md-4">
                            <label class="form-label-custom small mb-1">General Return Reason *</label>
                            <select name="reason" id="return-modal-reason" class="form-select form-control-custom" required>
                                <option value="Damaged / Leaked Goods">Damaged / Leaked Goods</option>
                                <option value="Expired / Near Expiry Product">Expired / Near Expiry Product</option>
                                <option value="Customer Rejected / Cancelled Order">Customer Rejected / Cancelled Order</option>
                                <option value="Wrong Item Dispatched">Wrong Item Dispatched</option>
                                <option value="Excess Quantity Returned">Excess Quantity Returned</option>
                                <option value="Quality Issue">Quality Issue</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="col-12 col-md-4 d-flex align-items-end">
                            <div class="form-check form-switch pb-2">
                                <input class="form-check-input" type="checkbox" name="return_to_inventory" value="1" id="return-modal-restock" checked>
                                <label class="form-check-label text-white small" for="return-modal-restock">
                                    <strong>Restock items back into inventory</strong>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Return Items Selection Table -->
                    <h6 class="fw-bold text-white mb-2 d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-boxes text-warning me-1"></i> Specify Quantities to Return</span>
                        <span class="small text-secondary fw-normal">Enter return quantity for items being returned</span>
                    </h6>
                    <div class="table-responsive mb-3 border border-secondary rounded">
                        <table class="table table-custom mb-0" id="return-items-select-table">
                            <thead>
                                <tr>
                                    <th style="width: 30%;">Product / SKU</th>
                                    <th class="text-center" style="width: 10%;">Billed</th>
                                    <th class="text-center" style="width: 10%;">Already Ret</th>
                                    <th class="text-center" style="width: 10%;">Available</th>
                                    <th class="text-center" style="width: 12%;">Return Qty</th>
                                    <th class="text-end" style="width: 10%;">Rate (₹)</th>
                                    <th class="text-end" style="width: 8%;">GST %</th>
                                    <th class="text-end" style="width: 10%;">Credit Total</th>
                                </tr>
                            </thead>
                            <tbody id="return-items-select-rows">
                                <!-- Populated dynamically via JS -->
                            </tbody>
                        </table>
                    </div>

                    <!-- Remarks & Credit Totals Row -->
                    <div class="row g-3">
                        <div class="col-12 col-md-6">
                            <label class="form-label-custom small mb-1">Return Remarks / Notes</label>
                            <textarea name="remarks" id="return-modal-remarks" class="form-control form-control-custom" rows="3" placeholder="Enter any return audit notes or specific instructions..."></textarea>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="p-3 bg-secondary bg-opacity-10 rounded-lg border border-secondary">
                                <div class="d-flex justify-content-between mb-1 small text-secondary">
                                    <span>Selected Units to Return:</span>
                                    <strong class="text-white" id="lbl-return-total-units">0 Pcs</strong>
                                </div>
                                <div class="d-flex justify-content-between mb-1 small text-secondary">
                                    <span>Taxable Return Value:</span>
                                    <strong class="text-white" id="lbl-return-taxable">₹0.00</strong>
                                </div>
                                <div class="d-flex justify-content-between mb-1 small text-secondary">
                                    <span>Reversible GST:</span>
                                    <strong class="text-white" id="lbl-return-gst">₹0.00</strong>
                                </div>
                                <hr class="my-2 border-secondary">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-danger fs-6">Credit Note Amount:</span>
                                    <span class="fs-4 fw-bold text-danger" id="lbl-return-grand">₹0.00</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom justify-content-between">
                    <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger" id="btn-submit-sales-return">
                        <i class="fas fa-check-circle me-1"></i> Process Return &amp; Issue Credit Note
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

