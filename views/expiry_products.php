<!-- views/expiry_products.php -->
<!-- Expiry Products Collection & Books -->
<?php
$roleName = $_SESSION['role_name'] ?? '';
?>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Expiry Products & Claims</h3>
        <p class="text-secondary mb-0">
            <?php echo $roleName === 'Owner' ? 'Monitor expired stock returns, claim amounts, and brand return lists' : 'Collect expired items from retailers and log them for credit claims'; ?>
        </p>
    </div>
    <div>
        <button class="btn btn-action primary" data-bs-toggle="modal" data-bs-target="#addExpiryModal" id="add-expiry-btn">
            <i class="fas fa-plus"></i> Collect Expiry
        </button>
    </div>
</div>

<?php if ($roleName === 'Owner'): ?>
<!-- Owner Dashboard Statistics Row -->
<div class="row g-3 mb-4">
    <div class="col-md-4">
        <div class="stats-card">
            <div class="stats-icon text-warning">
                <i class="fas fa-calendar-times"></i>
            </div>
            <div class="stats-info">
                <h3 class="fw-bold text-white mb-0" id="exp-total-qty">0</h3>
                <p class="text-secondary mb-0">Total Expiry Quantity</p>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="stats-card">
            <div class="stats-icon text-danger">
                <i class="fas fa-rupee-sign"></i>
            </div>
            <div class="stats-info">
                <h3 class="fw-bold text-white mb-0" id="exp-total-amount">₹0.00</h3>
                <p class="text-secondary mb-0">Total Claim Value</p>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="stats-card">
            <div class="stats-icon text-info">
                <i class="fas fa-cubes"></i>
            </div>
            <div class="stats-info">
                <h3 class="fw-bold text-white mb-0" id="exp-distinct-skus">0</h3>
                <p class="text-secondary mb-0">Unique SKUs Affected</p>
            </div>
        </div>
    </div>
</div>
<?php endif; ?>

<div class="row g-4">
    <!-- Left Column: Expiry Claims List (Wider for Owner, Full-width for Staff) -->
    <div class="<?php echo $roleName === 'Owner' ? 'col-lg-7 col-xl-8' : 'col-12'; ?>">
        <div class="custom-card">
            <div class="custom-card-header">
                <h5 class="custom-card-title"><i class="fas fa-book text-warning"></i> Expiry Collection Register</h5>
            </div>
            <div class="custom-card-body p-0">
                <div class="table-responsive">
                    <table id="expiry-table" class="table table-custom mb-0">
                        <thead>
                            <tr>
                                <th>Claim ID</th>
                                <th>Date</th>
                                <th>Retailer</th>
                                <th>Product Details</th>
                                <th>SKU</th>
                                <th class="text-center">Qty</th>
                                <th class="text-end">Rate</th>
                                <th class="text-end">Amount</th>
                                <th>Collected By</th>
                                <th class="text-center">Status</th>
                            </tr>
                        </thead>
                        <tbody id="expiry-rows">
                            <!-- Loaded via AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <?php if ($roleName === 'Owner'): ?>
    <!-- Right Column: Brand Returns Dashboard Summary (Owner Only) -->
    <div class="col-lg-5 col-xl-4">
        <div class="custom-card mb-4">
            <div class="custom-card-header bg-danger bg-opacity-10 border-danger border-opacity-25">
                <h5 class="custom-card-title text-danger"><i class="fas fa-shipping-fast"></i> Brand Returns Summary</h5>
            </div>
            <div class="custom-card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom mb-0" style="font-size: 0.9rem;">
                        <thead>
                            <tr>
                                <th>Brand Name</th>
                                <th class="text-center">SKUs</th>
                                <th class="text-center">Total Qty</th>
                                <th class="text-end">Claim Amt</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody id="expiry-brand-rows">
                            <!-- Loaded via AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="custom-card">
            <div class="custom-card-header">
                <h5 class="custom-card-title"><i class="fas fa-store"></i> Retailer Outstanding Expiries</h5>
            </div>
            <div class="custom-card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom mb-0" style="font-size: 0.9rem;">
                        <thead>
                            <tr>
                                <th>Retailer Shop</th>
                                <th class="text-center">Qty</th>
                                <th class="text-end">Value</th>
                            </tr>
                        </thead>
                        <tbody id="expiry-retailer-rows">
                            <!-- Loaded via AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <?php endif; ?>
</div>

<?php if ($roleName === 'Owner'): ?>
<!-- Brand Returns History Log -->
<div class="row mt-4">
    <div class="col-12">
        <div class="custom-card">
            <div class="custom-card-header bg-success bg-opacity-10 border-success border-opacity-25">
                <h5 class="custom-card-title text-success"><i class="fas fa-history"></i> Brand Returns History Log</h5>
            </div>
            <div class="custom-card-body p-0">
                <div class="table-responsive">
                    <table id="brand-returns-log-table" class="table table-custom mb-0">
                        <thead>
                            <tr>
                                <th>Log ID</th>
                                <th>Return Date</th>
                                <th>Brand</th>
                                <th>Retailer</th>
                                <th>SKU Item Details</th>
                                <th class="text-center">Qty Returned</th>
                                <th class="text-end">Refund Value</th>
                                <th class="text-center">Status</th>
                                <th>Remarks</th>
                            </tr>
                        </thead>
                        <tbody id="brand-returns-log-rows">
                            <!-- Loaded via AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<?php endif; ?>

<!-- Collect Expiry Modal -->
<div class="modal fade" id="addExpiryModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-calendar-times text-warning"></i> Log Expiry Collection</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="add-expiry-form">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label for="exp-retailer" class="form-label-custom">Retailer Shop <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom" id="exp-retailer" name="retailer_id" required>
                            <!-- Loaded dynamically via JS -->
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="exp-sku" class="form-label-custom">Select SKU Item <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom" id="exp-sku" name="sku_id" required>
                            <!-- Loaded dynamically via JS -->
                        </select>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="exp-quantity" class="form-label-custom">Expired Qty (Units) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control form-control-custom" id="exp-quantity" name="quantity" min="1" required placeholder="e.g. 10">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="exp-rate" class="form-label-custom">Credit Rate per Unit (₹) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="exp-rate" name="rate" required placeholder="0.00">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="exp-remarks" class="form-label-custom">Collection Remarks</label>
                        <textarea class="form-control form-control-custom" id="exp-remarks" name="remarks" rows="2" placeholder="Describe batch info, reason, etc."></textarea>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Log Collection</button>
                </div>
            </form>
        </div>
    </div>
</div>
