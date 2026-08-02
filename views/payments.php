<!-- views/payments.php -->
<!-- Payments Log & Collections View -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Collections &amp; Payments</h3>
        <p class="text-secondary mb-0">Record and track outstanding collections and receipts from retailers</p>
    </div>
    <div>
        <button class="btn btn-action primary" data-bs-toggle="modal" data-bs-target="#collectPaymentModal" id="collect-payment-btn">
            <i class="fas fa-plus"></i> Collect Payment
        </button>
    </div>
</div>

<div class="custom-card">
    <div class="custom-card-header d-flex justify-content-between align-items-center">
        <h5 class="custom-card-title mb-0"><i class="fas fa-rupee-sign text-primary"></i> Payment Collections Log</h5>
        <div class="d-flex align-items-center gap-2">
            <select class="form-select form-control-custom form-select-sm dt-date-filter" data-table="payments" style="width: auto;">
                <option value="all">All Dates</option>
                <option value="today">Today</option>
                <option value="yesterday">Yesterday</option>
                <option value="this_week">This Week</option>
                <option value="this_month">This Month</option>
                <option value="specific">Specific Date</option>
            </select>
            <input type="date" class="form-control form-control-custom form-control-sm dt-date-picker d-none" data-table="payments" style="width: auto;">
        </div>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="payments-table" class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th>Receipt ID</th>
                        <th>Shop Name</th>
                        <th>Invoice Linked</th>
                        <th>Payment Date</th>
                        <th>Type</th>
                        <th>Method</th>
                        <th class="text-end">Amount Paid</th>
                        <th>Ref Number</th>
                        <th>Collected By</th>
                        <th>Remarks</th>
                    </tr>
                </thead>
                <tbody id="payments-rows">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Collect Payment Modal -->
<div class="modal fade" id="collectPaymentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-hand-holding-usd text-primary"></i> Collect Retailer Payment</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="collect-payment-form">
                <div class="modal-body p-4">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="pay-route" class="form-label-custom">Select Beat Route</label>
                            <select class="form-select form-control-custom" id="pay-route" name="route_id">
                                <option value="">-- All Routes --</option>
                                <!-- Loaded dynamically via JS -->
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="pay-retailer" class="form-label-custom">Select Retailer Shop <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="pay-retailer" name="retailer_id" required disabled>
                                <option value="">-- Select Retailer --</option>
                                <!-- Loaded dynamically via JS -->
                            </select>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="pay-invoice" class="form-label-custom">Link to Specific Invoice (Optional)</label>
                        <select class="form-select form-control-custom" id="pay-invoice" name="invoice_id">
                            <option value="">-- Apply to General Outstanding Balance --</option>
                            <!-- Loaded dynamically upon retailer selection -->
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
                                <option value="UPI">UPI (GPay / PhonePe / Paytm)</option>
                                <option value="Bank Transfer">Bank Transfer (IMPS/NEFT)</option>
                                <option value="Cheque">Cheque Deposit</option>
                                <option value="Card">Credit/Debit Card</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="pay-amount" class="form-label-custom">Amount Collected (₹) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="pay-amount" name="amount" min="0.01" required placeholder="0.00">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="pay-ref" class="form-label-custom">Reference No / Txn ID</label>
                            <input type="text" class="form-control form-control-custom" id="pay-ref" name="reference_number" placeholder="UTR, Cheque No, UPI ID">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="pay-date" class="form-label-custom">Date Collected <span class="text-danger">*</span></label>
                            <input type="date" class="form-control form-control-custom" id="pay-date" name="payment_date" value="<?php echo date('Y-m-d'); ?>" required>
                        </div>
                        <div class="col-md-6 mb-3 d-flex align-items-end">
                            <div class="p-2 border border-secondary rounded w-100 bg-secondary bg-opacity-10 text-center" id="retailer-curr-outstanding-display">
                                <span class="small text-secondary">Outstanding:</span> <strong class="text-warning" id="pay-outstanding-val">₹0.00</strong>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="pay-remarks" class="form-label-custom">Remarks / Collection Notes</label>
                        <textarea class="form-control form-control-custom" id="pay-remarks" name="remarks" rows="2" placeholder="e.g. collected during weekly visit"></textarea>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Post Receipt</button>
                </div>
            </form>
        </div>
    </div>
</div>
