<!-- views/counter_sale.php -->
<!-- Counter Sale / Retail Walk-in Billing POS View -->
<?php
require_once __DIR__ . '/../config/functions.php';
checkAuth();
$roleName = $_SESSION['role_name'] ?? '';
?>

<!-- Page Header -->
<div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
    <div>
        <div class="d-flex align-items-center gap-2">
            <h3 class="fw-bold mb-0 text-white">
                <i class="fas fa-cash-register text-warning me-2"></i>Counter Sale
            </h3>
            <span class="badge bg-warning text-dark fw-bold px-2 py-1 rounded-pill">Public / Retail</span>
        </div>
        <p class="text-secondary mb-0 mt-1">Instant retail billing for single units &amp; walk-in public customers</p>
    </div>

    <!-- Quick Stats Pills -->
    <div class="d-flex flex-wrap align-items-center gap-2">
        <div class="bg-secondary bg-opacity-10 border border-secondary rounded-3 px-3 py-2 text-center">
            <div class="small text-secondary text-uppercase fw-bold" style="font-size: 11px;">Today's Sales</div>
            <div class="fw-bold text-success fs-6" id="cs-today-count">0 Sales</div>
        </div>
        <div class="bg-secondary bg-opacity-10 border border-secondary rounded-3 px-3 py-2 text-center">
            <div class="small text-secondary text-uppercase fw-bold" style="font-size: 11px;">Today's Revenue</div>
            <div class="fw-bold text-info fs-6" id="cs-today-revenue">₹0.00</div>
        </div>
    </div>
</div>

<!-- Nav Tabs for POS Sale vs History -->
<ul class="nav nav-tabs nav-tabs-custom border-secondary mb-4" id="counterSaleTabs" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active fw-bold text-white px-4 py-2" id="pos-tab" data-bs-toggle="tab" data-bs-target="#pos-tab-pane" type="button" role="tab">
            <i class="fas fa-calculator text-primary me-2"></i>New Counter Sale
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link fw-bold text-secondary px-4 py-2" id="history-tab" data-bs-toggle="tab" data-bs-target="#history-tab-pane" type="button" role="tab">
            <i class="fas fa-history text-info me-2"></i>Counter Sales History
        </button>
    </li>
</ul>

<div class="tab-content" id="counterSaleTabContent">
    <!-- ========================================== -->
    <!-- TAB 1: NEW COUNTER SALE (POS BILLING) -->
    <!-- ========================================== -->
    <div class="tab-pane fade show active" id="pos-tab-pane" role="tabpanel">
        <form id="counter-sale-form">
            <div class="row g-4">
                <!-- Left Column: Item Selection & Current Bill Items -->
                <div class="col-lg-8">
                    <!-- Item Selection & Calculation Card -->
                    <div class="custom-card mb-4 border border-secondary">
                        <div class="custom-card-header bg-dark border-bottom border-secondary d-flex justify-content-between align-items-center py-3">
                            <h5 class="custom-card-title mb-0 text-info">
                                <i class="fas fa-cart-plus me-2"></i>Item &amp; Pricing Selection
                            </h5>
                            <span class="badge bg-primary bg-opacity-25 text-primary border border-primary border-opacity-25 px-2 py-1">
                                <i class="fas fa-bolt me-1"></i>Quick Billing
                            </span>
                        </div>
                        <div class="custom-card-body p-4">
                            <!-- Item Search / Selection -->
                            <div class="row mb-3">
                                <div class="col-12">
                                    <label for="cs-item-select" class="form-label-custom fw-bold">
                                        Select Item / SKU <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select form-control-custom" id="cs-item-select" style="width: 100%;">
                                        <option value="">-- Choose Item / Search by Name or Code --</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Live Item Details Row: Stock, Quantity, Price (Editable without badge), Discount, Total -->
                            <div class="row g-3 align-items-end p-3 rounded-3 bg-secondary bg-opacity-10 border border-secondary mb-3">
                                <!-- Available Stock -->
                                <div class="col-6 col-md-2">
                                    <label class="form-label-custom small mb-1 text-secondary">Stock Available</label>
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-text bg-dark border-secondary text-secondary"><i class="fas fa-boxes"></i></span>
                                        <input type="text" class="form-control form-control-custom bg-dark text-center fw-bold text-info" id="cs-stock-display" value="0" readonly>
                                    </div>
                                </div>

                                <!-- Quantity -->
                                <div class="col-6 col-md-2">
                                    <label for="cs-qty-input" class="form-label-custom small mb-1">
                                        Qty (Units) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group input-group-sm">
                                        <button class="btn btn-outline-secondary btn-sm px-2" type="button" id="cs-qty-minus"><i class="fas fa-minus"></i></button>
                                        <input type="number" class="form-control form-control-custom text-center fw-bold px-1" id="cs-qty-input" min="1" value="1">
                                        <button class="btn btn-outline-secondary btn-sm px-2" type="button" id="cs-qty-plus"><i class="fas fa-plus"></i></button>
                                    </div>
                                </div>

                                <!-- Price (Editable) -->
                                <div class="col-6 col-md-3">
                                    <label for="cs-price-input" class="form-label-custom small mb-1">
                                        Price (₹) <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-text bg-dark border-secondary text-warning">₹</span>
                                        <input type="number" step="0.01" min="0" class="form-control form-control-custom fw-bold text-warning text-end" id="cs-price-input" placeholder="0.00" value="0.00" style="-moz-appearance: textfield; appearance: textfield;">
                                    </div>
                                </div>

                                <!-- Discount -->
                                <div class="col-6 col-md-2">
                                    <label for="cs-discount-input" class="form-label-custom small mb-1 text-success">
                                        Discount (₹)
                                    </label>
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-text bg-dark border-secondary text-success">-₹</span>
                                        <input type="number" step="0.01" min="0" class="form-control form-control-custom fw-bold text-success text-end" id="cs-discount-input" placeholder="0.00" value="0.00" style="-moz-appearance: textfield; appearance: textfield;">
                                    </div>
                                </div>

                                <!-- Line Total Calculation -->
                                <div class="col-12 col-md-3">
                                    <label class="form-label-custom small mb-1 text-info">Item Total (₹)</label>
                                    <div class="form-control form-control-sm form-control-custom bg-dark border-secondary text-end fw-bold text-info d-flex align-items-center justify-content-end" id="cs-line-total-display" style="height: 31px;">
                                        ₹0.00
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons to Add to Bill -->
                            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                                <span class="small text-secondary" id="cs-selected-item-info">
                                    <i class="fas fa-info-circle me-1"></i>Select an item to view details &amp; add to bill.
                                </span>
                                <button type="button" class="btn btn-action primary px-4 py-2 fw-bold" id="cs-add-item-btn">
                                    <i class="fas fa-plus-circle me-1"></i> Add to Current Bill
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Bill Items Table Card -->
                    <div class="custom-card border border-secondary">
                        <div class="custom-card-header bg-dark border-bottom border-secondary d-flex justify-content-between align-items-center py-3">
                            <h5 class="custom-card-title mb-0 text-white">
                                <i class="fas fa-receipt text-warning me-2"></i>Current Sale Bill Items
                            </h5>
                            <button type="button" class="btn btn-outline-danger btn-sm" id="cs-clear-cart-btn">
                                <i class="fas fa-trash me-1"></i> Clear Items
                            </button>
                        </div>
                        <div class="custom-card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-custom mb-0" id="cs-cart-table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Item Description</th>
                                            <th class="text-end" style="width: 100px;">Qty</th>
                                            <th class="text-end" style="width: 120px;">Price (₹)</th>
                                            <th class="text-end" style="width: 110px;">Discount (₹)</th>
                                            <th class="text-end" style="width: 80px;">GST %</th>
                                            <th class="text-end">Total (₹)</th>
                                            <th class="text-center" style="width: 50px;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id="cs-cart-rows">
                                        <tr>
                                            <td colspan="8" class="text-center text-secondary py-4">
                                                <i class="fas fa-shopping-basket fs-3 d-block mb-2 text-secondary opacity-50"></i>
                                                No items in this counter sale yet. Select an item above and click "Add to Current Bill".
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Customer Details, Payment & Final Sale Button -->
                <div class="col-lg-4">
                    <!-- Customer Information Card -->
                    <div class="custom-card mb-4 border border-secondary">
                        <div class="custom-card-header bg-dark border-bottom border-secondary py-3">
                            <h5 class="custom-card-title mb-0 text-white">
                                <i class="fas fa-user text-primary me-2"></i>Customer Information
                            </h5>
                        </div>
                        <div class="custom-card-body p-3">
                            <div class="mb-3">
                                <label for="cs-customer-name" class="form-label-custom small">Customer Name (Optional)</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-dark border-secondary text-secondary"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control form-control-custom" id="cs-customer-name" name="customer_name" placeholder="Walk-in Customer" value="Walk-in Customer">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="cs-customer-mobile" class="form-label-custom small">Mobile Number (Optional)</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-dark border-secondary text-secondary"><i class="fas fa-phone"></i></span>
                                    <input type="text" class="form-control form-control-custom" id="cs-customer-mobile" name="customer_mobile" placeholder="e.g. 9876543210">
                                </div>
                            </div>

                            <!-- Payment Method Selector -->
                            <div class="mb-3">
                                <label class="form-label-custom small mb-2">Payment Method <span class="text-danger">*</span></label>
                                <div class="d-flex gap-2">
                                    <input type="radio" class="btn-check" name="payment_method" id="cs-pay-cash" value="Cash" checked autocomplete="off">
                                    <label class="btn btn-outline-success btn-sm flex-fill fw-bold" for="cs-pay-cash">
                                        <i class="fas fa-money-bill-wave me-1"></i> Cash
                                    </label>

                                    <input type="radio" class="btn-check" name="payment_method" id="cs-pay-upi" value="UPI" autocomplete="off">
                                    <label class="btn btn-outline-info btn-sm flex-fill fw-bold" for="cs-pay-upi">
                                        <i class="fas fa-qrcode me-1"></i> UPI / QR
                                    </label>

                                    <input type="radio" class="btn-check" name="payment_method" id="cs-pay-card" value="Card" autocomplete="off">
                                    <label class="btn btn-outline-warning btn-sm flex-fill fw-bold" for="cs-pay-card">
                                        <i class="fas fa-credit-card me-1"></i> Card
                                    </label>
                                </div>
                            </div>

                            <div class="mb-3" id="cs-upi-ref-group" style="display: none;">
                                <label for="cs-payment-ref" class="form-label-custom small">UPI / Ref Number</label>
                                <input type="text" class="form-control form-control-custom form-control-sm" id="cs-payment-ref" name="payment_ref" placeholder="UPI Reference / UTR Number">
                            </div>

                            <div>
                                <label for="cs-sale-remarks" class="form-label-custom small">Remarks / Notes</label>
                                <input type="text" class="form-control form-control-custom form-control-sm" id="cs-sale-remarks" name="remarks" placeholder="Optional notes...">
                            </div>
                        </div>
                    </div>

                    <!-- Bill Summary & Add Sale CTA Card -->
                    <div class="custom-card border border-warning shadow-lg" style="background: linear-gradient(180deg, #111827 0%, #0c121e 100%);">
                        <div class="custom-card-header bg-dark border-bottom border-secondary py-3">
                            <h5 class="custom-card-title mb-0 text-warning">
                                <i class="fas fa-file-invoice-dollar me-2"></i>Bill Summary
                            </h5>
                        </div>
                        <div class="custom-card-body p-3">
                            <div class="d-flex justify-content-between text-secondary mb-2 small">
                                <span>Total Items:</span>
                                <span class="fw-bold text-white" id="cs-summary-items-count">0 items (0 units)</span>
                            </div>
                            <div class="d-flex justify-content-between text-secondary mb-2 small">
                                <span>Subtotal (Gross):</span>
                                <span class="fw-bold text-white" id="cs-summary-subtotal">₹0.00</span>
                            </div>
                            <div class="d-flex justify-content-between text-success mb-2 small">
                                <span>Total Discount:</span>
                                <span class="fw-bold" id="cs-summary-discount">-₹0.00</span>
                            </div>
                            <div class="d-flex justify-content-between text-secondary mb-2 small">
                                <span>GST Taxes:</span>
                                <span class="fw-bold text-white" id="cs-summary-gst">₹0.00</span>
                            </div>

                            <hr class="border-secondary my-3">

                            <!-- Grand Total Big Display -->
                            <div class="bg-dark bg-opacity-75 p-3 rounded-3 border border-secondary text-center mb-3">
                                <span class="text-secondary small text-uppercase font-monospace d-block mb-1">Total Amount Payable</span>
                                <h2 class="fw-extrabold text-warning mb-0" id="cs-summary-grand" style="letter-spacing: -0.5px;">
                                    ₹0.00
                                </h2>
                            </div>

                            <!-- "Add Sale" Primary CTA Button -->
                            <button type="submit" class="btn btn-success btn-lg w-100 fw-bold py-3 shadow-sm d-flex align-items-center justify-content-center gap-2" id="btn-submit-counter-sale">
                                <i class="fas fa-check-circle fs-5"></i>
                                <span class="fs-5">Add Sale</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- ========================================== -->
    <!-- TAB 2: COUNTER SALES HISTORY -->
    <!-- ========================================== -->
    <div class="tab-pane fade" id="history-tab-pane" role="tabpanel">
        <div class="custom-card border border-secondary">
            <div class="custom-card-header bg-dark border-bottom border-secondary d-flex flex-wrap justify-content-between align-items-center gap-2 py-3">
                <h5 class="custom-card-title mb-0 text-white">
                    <i class="fas fa-list text-primary me-2"></i>Recent Counter Sales Records
                </h5>
                <div class="d-flex align-items-center gap-2">
                    <label class="small text-secondary mb-0">Date:</label>
                    <input type="date" class="form-control form-control-custom form-control-sm" id="cs-history-date-filter" value="<?php echo date('Y-m-d'); ?>" style="width: auto;">
                    <button type="button" class="btn btn-action secondary btn-sm" id="cs-history-reload-btn">
                        <i class="fas fa-sync-alt"></i>
                    </button>
                </div>
            </div>
            <div class="custom-card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom mb-0" id="counter-sales-history-table">
                        <thead>
                            <tr>
                                <th>Bill No</th>
                                <th>Date</th>
                                <th>Customer Name</th>
                                <th>Items</th>
                                <th>Payment Mode</th>
                                <th class="text-end">Grand Total</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="counter-sales-history-rows">
                            <!-- Loaded via JS -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Counter Sale Success & Print Modal -->
<div class="modal fade" id="counterSaleSuccessModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom border-success shadow-lg">
            <div class="modal-header bg-success bg-opacity-25 border-success py-3">
                <h5 class="modal-title fw-bold text-success">
                    <i class="fas fa-check-circle me-2"></i>Counter Sale Successful!
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center p-4">
                <div class="mb-3">
                    <div class="d-inline-flex align-items-center justify-content-center bg-success bg-opacity-20 text-success rounded-circle" style="width: 70px; height: 70px;">
                        <i class="fas fa-check fs-1"></i>
                    </div>
                </div>
                <h4 class="fw-bold text-white mb-1" id="modal-cs-invoice-num">CS-20261004-0001</h4>
                <p class="text-secondary small mb-3">Counter Sale bill generated and stock deducted</p>

                <div class="bg-dark p-3 rounded-3 border border-secondary mb-4 text-start">
                    <div class="d-flex justify-content-between mb-1 small">
                        <span class="text-secondary">Customer:</span>
                        <strong class="text-white" id="modal-cs-customer">Walk-in Customer</strong>
                    </div>
                    <div class="d-flex justify-content-between mb-1 small">
                        <span class="text-secondary">Payment Method:</span>
                        <strong class="text-info" id="modal-cs-payment">Cash</strong>
                    </div>
                    <hr class="border-secondary my-2">
                    <div class="d-flex justify-content-between">
                        <span class="fw-bold text-secondary">Total Amount Paid:</span>
                        <strong class="text-warning fs-5" id="modal-cs-total">₹0.00</strong>
                    </div>
                </div>

                <div class="d-grid gap-2">
                    <a href="#" target="_blank" class="btn btn-action primary btn-lg justify-content-center fw-bold" id="modal-cs-print-btn">
                        <i class="fas fa-print me-2"></i> Print Bill / Receipt
                    </a>
                    <button type="button" class="btn btn-outline-secondary btn-lg" data-bs-dismiss="modal" id="modal-cs-next-btn">
                        <i class="fas fa-plus me-2"></i> Start Next Sale
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
