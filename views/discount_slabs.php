<?php
// views/discount_slabs.php
// Discount Slabs View
require_once __DIR__ . '/../config/functions.php';
checkAuth();
checkRole('Owner');
?>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Discount Slabs & Rules</h3>
        <p class="text-secondary mb-0">Manage bulk discounts and flat price deductions for SKUs.</p>
    </div>
</div>

<!-- All SKUs Table to Manage Discounts -->
<div class="custom-card mb-4">
    <div class="custom-card-header d-flex justify-content-between align-items-center">
        <h5 class="custom-card-title mb-0"><i class="fas fa-tags text-warning"></i> SKU Discount Configurations</h5>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table class="table custom-table mb-0" id="discount-skus-table">
                <thead>
                    <tr>
                        <th>SKU Code</th>
                        <th>Product & Brand</th>
                        <th>SKU Name</th>
                        <th class="text-end">Base Selling Rate</th>
                        <th class="text-center">Active Discounts</th>
                        <th class="text-center">Action</th>
                    </tr>
                </thead>
                <tbody id="discount-skus-rows">
                    <tr><td colspan="6" class="text-center py-4">Loading SKUs...</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Manage Discounts Modal -->
<div class="modal fade" id="manageDiscountsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-percent text-primary"></i> Manage Discounts: <span id="md-sku-name" class="text-warning"></span></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                
                <div class="row mb-4">
                    <div class="col-md-6 border-end border-secondary">
                        <h6 class="fw-bold text-secondary mb-2">Base Rate (Excl GST)</h6>
                        <h4 class="text-white fw-bold mb-0" id="md-base-rate">₹0.00</h4>
                    </div>
                    <div class="col-md-6 ps-md-4">
                        <p class="small text-secondary mb-1">You can add multiple discount rules for this SKU. The best applicable discount will be used at checkout.</p>
                    </div>
                </div>

                <!-- Add New Discount Form -->
                <div class="bg-secondary bg-opacity-10 p-3 rounded border border-secondary mb-4">
                    <h6 class="fw-bold text-info mb-3">Add New Discount Rule</h6>
                    <form id="add-discount-form">
                        <input type="hidden" id="add-disc-sku-id" name="sku_id">
                        
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label-custom">Discount Type</label>
                                <select class="form-select form-control-custom" id="add-disc-type" name="discount_type" required>
                                    <option value="Quantity Slab">Quantity Slab</option>
                                    <option value="Flat Rate">Flat Discounted Rate</option>
                                </select>
                            </div>
                            
                            <div class="col-md-3 mb-3 disc-qty-fields">
                                <label class="form-label-custom">Min Quantity</label>
                                <input type="number" class="form-control form-control-custom" id="add-disc-min" name="min_qty" value="10" required>
                            </div>
                            
                            <div class="col-md-3 mb-3 disc-qty-fields">
                                <label class="form-label-custom">Max Quantity</label>
                                <input type="number" class="form-control form-control-custom" name="max_qty" value="999999" required>
                            </div>
                            
                            <div class="col-md-3 mb-3">
                                <label class="form-label-custom">Target Discounted Rate (₹)</label>
                                <input type="number" step="0.01" class="form-control form-control-custom" name="discount_value" required placeholder="0.00">
                            </div>
                        </div>
                        
                        <div class="text-end mt-2">
                            <button type="submit" class="btn btn-sm btn-action primary"><i class="fas fa-plus"></i> Add Rule</button>
                        </div>
                    </form>
                </div>
                
                <!-- Active Rules Table -->
                <h6 class="fw-bold text-white mb-2">Active Rules for this SKU</h6>
                <div class="table-responsive">
                    <table class="table custom-table table-sm mb-0">
                        <thead>
                            <tr>
                                <th>Type</th>
                                <th>Criteria</th>
                                <th class="text-end">Target Rate (₹)</th>
                                <th class="text-center">Status</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody id="md-rules-body">
                            <!-- Populated via JS -->
                        </tbody>
                    </table>
                </div>
                
            </div>
        </div>
    </div>
</div>
