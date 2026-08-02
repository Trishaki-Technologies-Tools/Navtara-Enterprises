<!-- views/skus.php -->
<!-- SKUs Management View -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <?php if ($_SESSION['role_name'] === 'Owner'): ?>
        <h3 class="fw-bold mb-0">SKU Inventory Items</h3>
        <p class="text-secondary mb-0">Configure pricing variations, units and packaging for catalog items</p>
        <?php else: ?>
        <h3 class="fw-bold mb-0">SKU Catalog</h3>
        <p class="text-secondary mb-0">View pricing, packaging and product variations</p>
        <?php endif; ?>
    </div>
    <?php if ($_SESSION['role_name'] === 'Owner'): ?>
    <div>
        <button class="btn btn-action primary" data-bs-toggle="modal" data-bs-target="#addSkuModal" id="add-sku-btn">
            <i class="fas fa-plus"></i> Add New SKU
        </button>
    </div>
    <?php endif; ?>
</div>

<div class="custom-card">
    <div class="custom-card-header">
        <h5 class="custom-card-title"><i class="fas fa-barcode text-primary"></i> <?php echo $_SESSION['role_name'] === 'Owner' ? 'Configured SKUs' : 'SKU Catalog Items'; ?></h5>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="skus-table" class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Product & Category</th>
                        <th>SKU Name</th>
                        <?php if ($_SESSION['role_name'] === 'Owner'): ?>
                        <th class="text-end">Purchase <br><small class="text-secondary fw-normal">(Excl GST)</small></th>
                        <?php endif; ?>
                        <th class="text-end">Selling <br><small class="text-secondary fw-normal">(Excl GST)</small></th>
                        <th class="text-end">Selling <br><small class="text-secondary fw-normal">(Incl GST)</small></th>
                        <th class="text-end">MRP</th>
                        <th>Unit</th>
                        <th class="text-center">Stock</th>
                        <th>Status</th>
                        <?php if ($_SESSION['role_name'] === 'Owner'): ?>
                        <th class="text-center">Actions</th>
                        <?php endif; ?>
                    </tr>
                </thead>
                <tbody id="skus-rows">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add SKU Modal -->
<div class="modal fade" id="addSkuModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-plus-circle text-primary"></i> Create Product SKU</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="add-sku-form">
                <div class="modal-body p-4">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="sku-product" class="form-label-custom">Catalog Product <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="sku-product" name="product_id" required>
                                <!-- Loaded dynamically via JS -->
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="sku-name" class="form-label-custom">SKU Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="sku-name" name="sku_name" required placeholder="e.g. Pack of 4 (4x70g)">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="sku-unit" class="form-label-custom">Billing Unit <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="sku-unit" name="unit" required>
                                <option value="Pcs" selected>Pcs (Pieces)</option>
                                <option value="Box">Box</option>
                                <option value="Case">Case</option>
                                <option value="Litre">Litre</option>
                                <option value="Kg">Kg</option>
                                <option value="Dozen">Dozen</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="sku-gst" class="form-label-custom">GST % (Auto-fetched) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom bg-secondary bg-opacity-25" id="sku-gst" name="gst_percentage" value="18.00" required readonly>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="sku-purchase" class="form-label-custom">Purchase Price (Excl. GST) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="sku-purchase" name="purchase_price" required placeholder="0.00">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="sku-selling" class="form-label-custom">Selling Price (Excl. GST) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="sku-selling" name="selling_price" required placeholder="0.00">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="sku-mrp" class="form-label-custom">MRP (₹) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="sku-mrp" name="mrp" required placeholder="0.00">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="sku-stock" class="form-label-custom">Opening Stock <span class="text-danger">*</span></label>
                            <input type="number" class="form-control form-control-custom" id="sku-stock" name="current_stock" value="0" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="sku-min-stock" class="form-label-custom">Min Stock Alert <span class="text-danger">*</span></label>
                            <input type="number" class="form-control form-control-custom" id="sku-min-stock" name="minimum_stock" value="5" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="sku-status" class="form-label-custom">Status <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom" id="sku-status" name="status" required>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Save SKU</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit SKU Modal -->
<div class="modal fade" id="editSkuModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-edit text-warning"></i> Edit SKU Configuration</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="edit-sku-form">
                <input type="hidden" id="edit-sku-id" name="id">
                <div class="modal-body p-4">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-sku-product" class="form-label-custom">Catalog Product <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="edit-sku-product" name="product_id" required>
                                <!-- Loaded dynamically -->
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-sku-name" class="form-label-custom">SKU Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="edit-sku-name" name="sku_name" required placeholder="Pack size details">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-sku-unit" class="form-label-custom">Billing Unit <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="edit-sku-unit" name="unit" required>
                                <option value="Pcs">Pcs</option>
                                <option value="Box">Box</option>
                                <option value="Case">Case</option>
                                <option value="Litre">Litre</option>
                                <option value="Kg">Kg</option>
                                <option value="Dozen">Dozen</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-sku-gst" class="form-label-custom">GST % (Auto-fetched) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom bg-secondary bg-opacity-25" id="edit-sku-gst" name="gst_percentage" required readonly>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="edit-sku-purchase" class="form-label-custom">Purchase Price (Excl. GST) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="edit-sku-purchase" name="purchase_price" required placeholder="0.00">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-sku-selling" class="form-label-custom">Selling Price (Excl. GST) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="edit-sku-selling" name="selling_price" required placeholder="0.00">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-sku-mrp" class="form-label-custom">MRP (₹) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="edit-sku-mrp" name="mrp" required placeholder="0.00">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <!-- Stock input shouldn't be edited here usually, but we left it per requested structure -->
                            <label for="edit-sku-min-stock" class="form-label-custom">Min Stock Alert <span class="text-danger">*</span></label>
                            <input type="number" class="form-control form-control-custom" id="edit-sku-min-stock" name="minimum_stock" value="5" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-sku-status" class="form-label-custom">Status <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="edit-sku-status" name="status" required>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Update SKU</button>
                </div>
            </form>
        </div>
    </div>
</div>
