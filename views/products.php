<!-- views/products.php -->
<!-- Products Management View -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Product Catalog</h3>
        <p class="text-secondary mb-0">Manage general items catalog linked to categories</p>
    </div>
    <?php if ($_SESSION['role_name'] === 'Owner'): ?>
    <div>
        <button class="btn btn-action primary" data-bs-toggle="modal" data-bs-target="#addProductModal" id="add-product-btn">
            <i class="fas fa-plus"></i> Add New Product
        </button>
    </div>
    <?php endif; ?>
</div>

<div class="custom-card" id="products-card" data-role="<?php echo htmlspecialchars($_SESSION['role_name'] ?? ''); ?>">
    <div class="custom-card-header">
        <h5 class="custom-card-title"><i class="fas fa-cubes text-primary"></i> Catalog Products</h5>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="products-table" class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th style="width: 8%;">ID</th>
                        <th style="width: 15%;">Image</th>
                        <th style="width: 20%;">Category</th>
                        <th style="width: 25%;">Product Name</th>
                        <th style="width: 10%;">GST %</th>
                        <th style="width: 10%;">HSN Code</th>
                        <th style="width: 12%;">SKUs</th>
                        <th style="width: 10%;">Status</th>
                        <?php if ($_SESSION['role_name'] === 'Owner'): ?>
                        <th style="width: 10%;" class="text-center">Actions</th>
                        <?php endif; ?>
                    </tr>
                </thead>
                <tbody id="products-rows">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Product Modal -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-plus-circle text-primary"></i> Add Product</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="add-product-form" enctype="multipart/form-data">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label for="product-brand" class="form-label-custom">Select Category <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom" id="product-brand" name="brand_id" required>
                            <!-- Loaded dynamically via JS -->
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="product-name" class="form-label-custom">Product Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-custom" id="product-name" name="name" required placeholder="e.g. Maggi 2-Minute Noodles">
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="product-gst" class="form-label-custom">Default GST % <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="product-gst" name="gst_percentage" required>
                                <option value="0">0% (Nil)</option>
                                <option value="5">5%</option>
                                <option value="12">12%</option>
                                <option value="18" selected>18%</option>
                                <option value="28">28%</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="product-hsn" class="form-label-custom">HSN Code</label>
                            <input type="text" class="form-control form-control-custom" id="product-hsn" name="hsn_code" placeholder="e.g. 19023010">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="product-image" class="form-label-custom">Product Image</label>
                        <input type="file" class="form-control form-control-custom" id="product-image" name="image" accept="image/*">
                    </div>
                    
                    <div class="mb-3">
                        <label for="product-desc" class="form-label-custom">Description</label>
                        <textarea class="form-control form-control-custom" id="product-desc" name="description" rows="3" placeholder="Additional specifications"></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="product-status" class="form-label-custom">Status</label>
                        <select class="form-select form-control-custom" id="product-status" name="status">
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Save Product</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Product Modal -->
<div class="modal fade" id="editProductModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-edit text-warning"></i> Edit Product</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="edit-product-form" enctype="multipart/form-data">
                <input type="hidden" id="edit-product-id" name="id">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label for="edit-product-brand" class="form-label-custom">Select Category <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom" id="edit-product-brand" name="brand_id" required>
                            <!-- Loaded dynamically -->
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="edit-product-name" class="form-label-custom">Product Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-custom" id="edit-product-name" name="name" required placeholder="e.g. Maggi Noodles">
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-product-gst" class="form-label-custom">Default GST % <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="edit-product-gst" name="gst_percentage" required>
                                <option value="0">0%</option>
                                <option value="5">5%</option>
                                <option value="12">12%</option>
                                <option value="18">18%</option>
                                <option value="28">28%</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-product-hsn" class="form-label-custom">HSN Code</label>
                            <input type="text" class="form-control form-control-custom" id="edit-product-hsn" name="hsn_code" placeholder="e.g. 19023010">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label for="edit-product-image" class="form-label-custom mb-0">Replace Image (Optional)</label>
                            <span id="current-image-preview" class="text-secondary small"></span>
                        </div>
                        <input type="file" class="form-control form-control-custom" id="edit-product-image" name="image" accept="image/*">
                    </div>
                    
                    <div class="mb-3">
                        <label for="edit-product-desc" class="form-label-custom">Description</label>
                        <textarea class="form-control form-control-custom" id="edit-product-desc" name="description" rows="3"></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="edit-product-status" class="form-label-custom">Status</label>
                        <select class="form-select form-control-custom" id="edit-product-status" name="status">
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Update Product</button>
                </div>
            </form>
        </div>
    </div>
</div>
