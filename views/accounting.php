<!-- views/accounting.php -->
<!-- Accounting Ledgers, Registers, Expenses, and P&L View (Owner Only) -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Financial Accounting &amp; Ledger</h3>
        <p class="text-secondary mb-0">Double-entry customer ledgers, cash books, operational expenses, and profit &amp; loss statements</p>
    </div>
</div>

<div class="custom-card">
    <div class="custom-card-header p-0">
        <ul class="nav nav-tabs border-bottom-0" id="accountingTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active py-3 px-4 fw-bold border-0 text-white-50" id="cust-ledger-tab" data-bs-toggle="tab" data-bs-target="#cust-ledger-pane" type="button" role="tab" aria-selected="true"><i class="fas fa-user-tag me-2"></i> Customer Ledger</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link py-3 px-4 fw-bold border-0 text-white-50" id="cash-bank-tab" data-bs-toggle="tab" data-bs-target="#cash-bank-pane" type="button" role="tab" aria-selected="false"><i class="fas fa-book me-2"></i> Cash / Bank Books</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link py-3 px-4 fw-bold border-0 text-white-50" id="daybook-tab" data-bs-toggle="tab" data-bs-target="#daybook-pane" type="button" role="tab" aria-selected="false"><i class="fas fa-calendar-day me-2"></i> Day Book</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link py-3 px-4 fw-bold border-0 text-white-50" id="expenses-tab" data-bs-toggle="tab" data-bs-target="#expenses-pane" type="button" role="tab" aria-selected="false"><i class="fas fa-wallet me-2"></i> Expense Manager</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link py-3 px-4 fw-bold border-0 text-white-50" id="pl-tab" data-bs-toggle="tab" data-bs-target="#pl-pane" type="button" role="tab" aria-selected="false"><i class="fas fa-calculator me-2"></i> Profit &amp; Loss</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link py-3 px-4 fw-bold border-0 text-white-50" id="supplier-payments-tab" data-bs-toggle="tab" data-bs-target="#supplier-payments-pane" type="button" role="tab" aria-selected="false"><i class="fas fa-hand-holding-usd me-2"></i> Supplier Payments</button>
            </li>
        </ul>
    </div>
    
    <div class="custom-card-body tab-content" id="accountingTabsContent">
        <!-- 1. Customer Ledger Pane -->
        <div class="tab-pane fade show active" id="cust-ledger-pane" role="tabpanel" aria-labelledby="cust-ledger-tab">
            <form id="ledger-filter-form" class="row align-items-end mb-4 bg-secondary bg-opacity-10 p-3 rounded-lg border border-secondary">
                <div class="col-md-4 mb-3 mb-md-0">
                    <label for="ledger-retailer" class="form-label-custom">Select Retailer Shop <span class="text-danger">*</span></label>
                    <select class="form-select form-control-custom" id="ledger-retailer" required>
                        <!-- Loaded dynamically -->
                    </select>
                </div>
                <div class="col-md-3 mb-3 mb-md-0">
                    <label for="ledger-start" class="form-label-custom">Start Date</label>
                    <input type="date" class="form-control form-control-custom" id="ledger-start" value="<?php echo date('Y-01-01'); ?>">
                </div>
                <div class="col-md-3 mb-3 mb-md-0">
                    <label for="ledger-end" class="form-label-custom">End Date</label>
                    <input type="date" class="form-control form-control-custom" id="ledger-end" value="<?php echo date('Y-12-31'); ?>">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-action primary w-100 justify-content-center"><i class="fas fa-search"></i> Get Ledger</button>
                </div>
            </form>
            
            <div id="ledger-result-area" style="display:none;">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0">Ledger Statement</h5>
                    <div>
                        <span class="badge bg-secondary py-2 px-3 fw-bold">Opening Balance: <strong class="text-info" id="ledger-opening-bal">₹0.00</strong></span>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-custom border border-secondary" id="ledger-table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Doc No / Ref</th>
                                <th>Transaction Type</th>
                                <th>Particulars / Narration</th>
                                <th class="text-end">Debit (Dr)</th>
                                <th class="text-end">Credit (Cr)</th>
                                <th class="text-end">Running Balance</th>
                            </tr>
                        </thead>
                        <tbody id="ledger-rows">
                            <!-- Injected dynamically -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- 2. Cash / Bank Book Pane -->
        <div class="tab-pane fade" id="cash-bank-pane" role="tabpanel" aria-labelledby="cash-bank-tab">
            <div class="row mb-4">
                <div class="col-md-6 mb-3 mb-md-0">
                    <div class="p-3 bg-secondary bg-opacity-10 border border-secondary rounded-lg">
                        <h5 class="fw-bold mb-3 text-info"><i class="fas fa-coins"></i> Cash Book Statement</h5>
                        <form id="cashbook-form" class="row g-2">
                            <div class="col-6">
                                <label class="form-label-custom">Start Date</label>
                                <input type="date" class="form-control form-control-custom" id="cash-start" value="<?php echo date('Y-m-d'); ?>">
                            </div>
                            <div class="col-6">
                                <label class="form-label-custom">End Date</label>
                                <input type="date" class="form-control form-control-custom" id="cash-end" value="<?php echo date('Y-m-d'); ?>">
                            </div>
                            <div class="col-12 mt-3">
                                <button type="submit" class="btn btn-action primary w-100 justify-content-center"><i class="fas fa-receipt"></i> Generate Cash Book</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 bg-secondary bg-opacity-10 border border-secondary rounded-lg">
                        <h5 class="fw-bold mb-3 text-info"><i class="fas fa-university"></i> Bank Book Statement</h5>
                        <form id="bankbook-form" class="row g-2">
                            <div class="col-6">
                                <label class="form-label-custom">Start Date</label>
                                <input type="date" class="form-control form-control-custom" id="bank-start" value="<?php echo date('Y-m-d'); ?>">
                            </div>
                            <div class="col-6">
                                <label class="form-label-custom">End Date</label>
                                <input type="date" class="form-control form-control-custom" id="bank-end" value="<?php echo date('Y-m-d'); ?>">
                            </div>
                            <div class="col-12 mt-3">
                                <button type="submit" class="btn btn-action primary w-100 justify-content-center"><i class="fas fa-receipt"></i> Generate Bank Book</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <div id="cash-bank-result-area" style="display:none;">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0" id="cash-bank-title">Cash Book</h5>
                    <span class="badge bg-secondary py-2 px-3 fw-bold">Opening Balance: <strong class="text-info" id="cash-bank-op-bal">₹0.00</strong></span>
                </div>
                <div class="table-responsive">
                    <table class="table table-custom border border-secondary" id="cash-bank-table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Type</th>
                                <th>Particulars</th>
                                <th class="text-end">Receipts (Dr)</th>
                                <th class="text-end">Payments (Cr)</th>
                                <th>Remarks</th>
                            </tr>
                        </thead>
                        <tbody id="cash-bank-rows">
                            <!-- Loaded dynamically -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- 3. Day Book Pane -->
        <div class="tab-pane fade" id="daybook-pane" role="tabpanel" aria-labelledby="daybook-tab">
            <form id="daybook-form" class="row align-items-end mb-4 bg-secondary bg-opacity-10 p-3 rounded-lg border border-secondary">
                <div class="col-md-8 mb-3 mb-md-0">
                    <label for="daybook-date" class="form-label-custom">Select Date <span class="text-danger">*</span></label>
                    <input type="date" class="form-control form-control-custom" id="daybook-date" value="<?php echo date('Y-m-d'); ?>" required>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-action primary w-100 justify-content-center"><i class="fas fa-search"></i> Fetch Day Book</button>
                </div>
            </form>
            
            <div id="daybook-result-area" style="display:none;">
                <h5 class="fw-bold mb-3">All Entries for Selected Date</h5>
                <div class="table-responsive">
                    <table class="table table-custom border border-secondary" id="daybook-table">
                        <thead>
                            <tr>
                                <th>Voucher Type</th>
                                <th>Voucher No</th>
                                <th>Particulars (Account)</th>
                                <th class="text-end">Debit (Dr)</th>
                                <th class="text-end">Credit (Cr)</th>
                                <th>Remarks / Narration</th>
                            </tr>
                        </thead>
                        <tbody id="daybook-rows">
                            <!-- Injected dynamically -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- 4. Expense Manager Pane -->
        <div class="tab-pane fade" id="expenses-pane" role="tabpanel" aria-labelledby="expenses-tab">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0">Record Business Expenses</h5>
                <button class="btn btn-action primary btn-sm" data-bs-toggle="modal" data-bs-target="#addExpenseModal"><i class="fas fa-plus"></i> Record Expense</button>
            </div>
            
            <div class="table-responsive">
                <table id="expenses-table" class="table table-custom mb-0" style="width:100%;">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Date</th>
                            <th>Category</th>
                            <th class="text-end">Amount</th>
                            <th>Payment Method</th>
                            <th>Paid To</th>
                            <th>Remarks</th>
                            <th>Recorded By</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="expenses-rows">
                        <!-- Loaded dynamically -->
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- 5. Profit & Loss Pane -->
        <div class="tab-pane fade" id="pl-pane" role="tabpanel" aria-labelledby="pl-tab">
            <form id="pl-form" class="row align-items-end mb-4 bg-secondary bg-opacity-10 p-3 rounded-lg border border-secondary">
                <div class="col-md-4 mb-3 mb-md-0">
                    <label class="form-label-custom">Start Date</label>
                    <input type="date" class="form-control form-control-custom" id="pl-start" value="<?php echo date('Y-m-01'); ?>">
                </div>
                <div class="col-md-4 mb-3 mb-md-0">
                    <label class="form-label-custom">End Date</label>
                    <input type="date" class="form-control form-control-custom" id="pl-end" value="<?php echo date('Y-m-t'); ?>">
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-action primary w-100 justify-content-center"><i class="fas fa-calculator"></i> Calculate Profit &amp; Loss</button>
                </div>
            </form>
            
            <div id="pl-result-area" style="display:none;">
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="p-4 bg-secondary bg-opacity-10 border border-secondary rounded-lg h-100">
                            <h5 class="fw-bold mb-3 text-info"><i class="fas fa-file-invoice-dollar"></i> Trading Account (Trading Profit)</h5>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-secondary">Sales Revenue (Taxable Value):</span>
                                <span class="fw-bold" id="pl-sales-rev">₹0.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2 text-danger">
                                <span class="text-secondary">Less: Cost of Goods Sold (COGS):</span>
                                <span class="fw-bold" id="pl-cogs">- ₹0.00</span>
                            </div>
                            <hr class="border-secondary">
                            <div class="d-flex justify-content-between fw-bold text-success fs-5">
                                <span>Gross Trading Profit:</span>
                                <span id="pl-gross-profit">₹0.00</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6 mb-4">
                        <div class="p-4 bg-secondary bg-opacity-10 border border-secondary rounded-lg h-100">
                            <h5 class="fw-bold mb-3 text-info"><i class="fas fa-wallet"></i> Operating Statement (Net Profit)</h5>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-secondary">Gross Profit b/f:</span>
                                <span id="pl-gross-profit-bf">₹0.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2 text-danger">
                                <span class="text-secondary">Less: Operating Expenses (Indirect):</span>
                                <span class="fw-bold" id="pl-expenses-total">- ₹0.00</span>
                            </div>
                            <hr class="border-secondary">
                            <div class="d-flex justify-content-between fw-bold fs-5" id="pl-net-div">
                                <span>Net Profit Margin:</span>
                                <span id="pl-net-profit">₹0.00</span>
                            </div>
                            <div class="text-end mt-2">
                                <span class="small text-secondary">Profit Margin Pct: <strong class="text-white" id="pl-margin-pct">0%</strong></span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="custom-card">
                    <div class="custom-card-header">
                        <h6 class="custom-card-title"><i class="fas fa-tags text-warning"></i> Operating Expenses Breakdown</h6>
                    </div>
                    <div class="custom-card-body p-0">
                        <table class="table table-custom mb-0">
                            <thead>
                                <tr>
                                    <th>Expense Category</th>
                                    <th class="text-end">Total Amount Spent (₹)</th>
                                </tr>
                            </thead>
                            <tbody id="pl-expenses-rows">
                                <!-- Loaded dynamically -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 6. Supplier Payments Pane -->
        <div class="tab-pane fade" id="supplier-payments-pane" role="tabpanel" aria-labelledby="supplier-payments-tab">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h5 class="fw-bold mb-0">Supplier Payments History</h5>
                </div>
            </div>

            <div class="row">
                <!-- Payment History -->
                <div class="col-lg-12 mb-4">
                    <div class="custom-card h-100">
                        <div class="custom-card-header d-flex justify-content-between align-items-center">
                            <h6 class="custom-card-title mb-0"><i class="fas fa-history text-primary"></i> Payment History Log</h6>
                            <div class="d-flex align-items-center gap-2">
                                <select class="form-select form-control-custom form-select-sm dt-date-filter" data-table="supplier_payments" style="width: auto;">
                                    <option value="all">All Dates</option>
                                    <option value="today">Today</option>
                                    <option value="yesterday">Yesterday</option>
                                    <option value="this_week">This Week</option>
                                    <option value="this_month">This Month</option>
                                    <option value="specific">Specific Date</option>
                                </select>
                                <input type="date" class="form-control form-control-custom form-control-sm dt-date-picker d-none" data-table="supplier_payments" style="width: auto;">
                            </div>
                        </div>
                        <div class="custom-card-body p-0">
                            <div class="table-responsive">
                                <table id="supplier-payments-table" class="table table-custom mb-0 w-100">
                                    <thead>
                                        <tr>
                                            <th>Payment ID</th>
                                            <th>Date</th>
                                            <th>Supplier</th>
                                            <th>Mode</th>
                                            <th>Ref #</th>
                                            <th class="text-end">Amount (₹)</th>
                                            <th class="text-center">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id="supplier-payments-rows">
                                        <!-- Loaded via JS -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
</div>

<!-- Add Expense Modal -->
<div class="modal fade" id="addExpenseModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-plus-circle text-primary"></i> Record Expense Voucher</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="add-expense-form">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label for="exp-category" class="form-label-custom">Expense Category <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom expense-category-select" id="exp-category" name="category" required>
                            <!-- Loaded dynamically -->
                        </select>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="exp-amount" class="form-label-custom">Amount Spent (Base) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="exp-amount" name="amount" min="0.01" required placeholder="0.00">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="exp-payment-method" class="form-label-custom">Payment Method <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom exp-payment-method-select" id="exp-payment-method" name="payment_method" required>
                                <!-- Loaded dynamically -->
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="exp-gst-pct" class="form-label-custom">GST Rate (%)</label>
                            <input type="number" step="0.1" class="form-control form-control-custom" id="exp-gst-pct" name="gst_percentage" min="0" value="0" placeholder="0">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="exp-gst-amt" class="form-label-custom">GST Amount (₹)</label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="exp-gst-amt" name="gst_amount" min="0" value="0.00" readonly>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="exp-date" class="form-label-custom">Expense Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control form-control-custom" id="exp-date" name="expense_date" value="<?php echo date('Y-m-d'); ?>" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="exp-to" class="form-label-custom">Paid To / Recipient</label>
                            <input type="text" class="form-control form-control-custom" id="exp-to" name="paid_to" placeholder="e.g. Fuel Station Manager">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="exp-remarks" class="form-label-custom">Narration / Remarks</label>
                        <textarea class="form-control form-control-custom" id="exp-remarks" name="remarks" rows="2" placeholder="Describe the purpose of this payment"></textarea>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Post Voucher</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Expense Modal -->
<div class="modal fade" id="editExpenseModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-edit text-warning"></i> Edit Expense Voucher</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="edit-expense-form">
                <input type="hidden" id="edit-exp-id" name="id">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label for="edit-exp-category" class="form-label-custom">Expense Category <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom expense-category-select" id="edit-exp-category" name="category" required>
                            <!-- Loaded dynamically -->
                        </select>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-exp-amount" class="form-label-custom">Amount Spent (Base) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="edit-exp-amount" name="amount" min="0.01" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-exp-payment-method" class="form-label-custom">Payment Method <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom exp-payment-method-select" id="edit-exp-payment-method" name="payment_method" required>
                                <!-- Loaded dynamically -->
                            </select>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-exp-gst-pct" class="form-label-custom">GST Rate (%)</label>
                            <input type="number" step="0.1" class="form-control form-control-custom" id="edit-exp-gst-pct" name="gst_percentage" min="0" value="0">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-exp-gst-amt" class="form-label-custom">GST Amount (₹)</label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="edit-exp-gst-amt" name="gst_amount" min="0" value="0.00" readonly>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-exp-date" class="form-label-custom">Expense Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control form-control-custom" id="edit-exp-date" name="expense_date" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-exp-to" class="form-label-custom">Paid To / Recipient</label>
                            <input type="text" class="form-control form-control-custom" id="edit-exp-to" name="paid_to">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="edit-exp-remarks" class="form-label-custom">Narration / Remarks</label>
                        <textarea class="form-control form-control-custom" id="edit-exp-remarks" name="remarks" rows="2"></textarea>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Update Voucher</button>
                </div>
            </form>
        </div>
    </div>
</div>


