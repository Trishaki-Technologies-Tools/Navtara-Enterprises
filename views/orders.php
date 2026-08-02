<!-- views/orders.php -->
<!-- Orders Management & Order Placing View -->
<?php
require_once __DIR__ . '/../config/functions.php';
checkAuth();
$roleName = $_SESSION['role_name'];
?>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Sales Orders</h3>
        <p class="text-secondary mb-0">Manage customer bookings and approval pipeline</p>
    </div>
</div>

<div class="custom-card">
    <div class="custom-card-header d-flex justify-content-between align-items-center">
        <h5 class="custom-card-title mb-0"><i class="fas fa-shopping-bag text-primary"></i> Order List</h5>
        <div class="d-flex align-items-center gap-2">
            <select class="form-select form-control-custom form-select-sm dt-date-filter" data-table="orders" style="width: auto;">
                <option value="all">All Dates</option>
                <option value="today">Today</option>
                <option value="yesterday">Yesterday</option>
                <option value="this_week">This Week</option>
                <option value="this_month">This Month</option>
                <option value="specific">Specific Date</option>
            </select>
            <input type="date" class="form-control form-control-custom form-control-sm dt-date-picker d-none" data-table="orders" style="width: auto;">
        </div>
    </div>
    <div class="custom-card-body p-0">
            <div class="table-responsive">
                <table id="orders-table" class="table table-custom mb-0">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Shop Name</th>
                            <th>Sales Executive</th>
                            <th>Order Date</th>
                            <th class="text-end">Taxable Val</th>
                            <th class="text-end">GST Amt</th>
                            <th class="text-end">Grand Total</th>
                            <th>Status</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="orders-rows">
                        <!-- Loaded via AJAX -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Order Detail and Approval Modal -->
<div class="modal fade" id="orderDetailModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold" id="orderDetailTitle"><i class="fas fa-shopping-bag text-primary"></i> Order Details</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <!-- Meta data row -->
                <div class="row mb-3 bg-secondary bg-opacity-10 p-3 rounded-lg border border-secondary mx-0">
                    <div class="col-md-6 mb-2 mb-md-0">
                        <p class="mb-1 text-secondary">Retailer Shop:</p>
                        <h6 class="fw-bold mb-0 text-white" id="det-order-shop">Shop Name</h6>
                        <span class="small text-secondary" id="det-order-gst">GSTIN</span>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p class="mb-1 text-secondary">Sales Executive: <strong class="text-white" id="det-order-staff">Name</strong></p>
                        <p class="mb-0 text-secondary">Order Date: <strong class="text-white" id="det-order-date">Date</strong></p>
                    </div>
                </div>
                
                <h6 class="fw-bold text-info mb-2">Booked Items</h6>
                <div class="table-responsive mb-3">
                    <table class="table table-custom border border-secondary small" id="detail-items-table">
                        <thead>
                            <tr>
                                <th>SKU Name</th>
                                <th>Code</th>
                                <th class="text-end">Qty</th>
                                <th class="text-end">Rate (₹)</th>
                                <th class="text-end">Discount (₹)</th>
                                <th class="text-end">GST %</th>
                                <th class="text-end">Total (₹)</th>
                            </tr>
                        </thead>
                        <tbody id="detail-items-rows">
                            <!-- Loaded via JS -->
                        </tbody>
                    </table>
                </div>
                
                <div class="row">
                    <div class="col-md-7">
                        <div class="mb-3">
                            <label class="form-label-custom">Special Remarks:</label>
                            <p class="p-2 border border-secondary rounded bg-secondary bg-opacity-10 small text-white-50" id="det-order-remarks" style="white-space: pre-wrap;">None</p>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="p-3 bg-secondary bg-opacity-10 rounded border border-secondary small">
                            <div class="d-flex justify-content-between mb-1">
                                <span>Gross Product Total:</span>
                                <span id="det-order-gross">₹0.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span>Discount Amount:</span>
                                <span class="text-success" id="det-order-disc">- ₹0.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span>GST Taxes:</span>
                                <span id="det-order-gstamt">₹0.00</span>
                            </div>
                            <hr class="my-2 border-secondary">
                            <div class="d-flex justify-content-between fw-bold text-white">
                                <span>Grand Total:</span>
                                <span id="det-order-grand">₹0.00</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Approval controls (Owner Only, shown conditionally) -->
                <?php if ($roleName === 'Owner'): ?>
                <div class="mt-4 pt-3 border-top border-secondary" id="owner-approval-area" style="display:none;">
                    <h6 class="fw-bold text-warning mb-2"><i class="fas fa-gavel"></i> Owner Review Decision</h6>
                    <div class="row">
                        <div class="col-md-8 mb-2 mb-md-0">
                            <input type="text" class="form-control form-control-custom" id="approval-notes" placeholder="Optional notes for staff / cancellation reasons">
                        </div>
                        <div class="col-md-4 d-flex gap-2">
                            <button type="button" class="btn btn-action success flex-grow-1 justify-content-center" id="btn-approve-order"><i class="fas fa-check"></i> Approve</button>
                            <button type="button" class="btn btn-action danger flex-grow-1 justify-content-center" id="btn-cancel-order"><i class="fas fa-times"></i> Cancel</button>
                        </div>
                    </div>
                </div>
                
                <div class="mt-4 pt-3 border-top border-secondary text-end" id="owner-invoice-gen-area" style="display:none;">
                    <!-- Billing action -->
                    <button type="button" class="btn btn-action primary" id="btn-open-billing-modal"><i class="fas fa-file-invoice-dollar"></i> Proceed to Generate Invoice</button>
                </div>
                <?php endif; ?>
            </div>
            <div class="modal-footer modal-footer-custom">
                <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Invoice Generation Modal (Owner Only) -->
<?php if ($roleName === 'Owner'): ?>
<div class="modal fade" id="billingModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-file-invoice text-primary"></i> Create Bill Invoice</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="generate-invoice-form">
                <input type="hidden" id="billing-order-id" name="order_id">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label-custom">Invoice Term / Type <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom" name="invoice_type" required>
                            <option value="GST Invoice" selected>GST Invoice (Tax Invoice)</option>
                            <option value="Non GST Invoice">Non GST Invoice (Retail Bill)</option>
                            <option value="Cash Invoice">Cash Invoice (Paid instantly)</option>
                            <option value="Credit Invoice">Credit Invoice (Post to Ledger)</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label-custom">Invoice Date <span class="text-danger">*</span></label>
                        <input type="date" class="form-control form-control-custom" name="invoice_date" value="<?php echo date('Y-m-d'); ?>" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label-custom">Remarks / Delivery Details</label>
                        <textarea class="form-control form-control-custom" name="remarks" rows="2" placeholder="e.g. dispatched via local delivery van"></textarea>
                    </div>
                    
                    <div class="p-3 bg-warning bg-opacity-10 border border-warning rounded text-warning small mb-1">
                        <i class="fas fa-info-circle me-1"></i> Generating an invoice reduces stock automatically and updates the retailer ledger.
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Generate &amp; Print Bill</button>
                </div>
            </form>
        </div>
    </div>
</div>
<?php endif; ?>
