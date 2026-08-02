<!-- views/brands.php -->
<!-- Categories Management View -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Category Management</h3>
        <p class="text-secondary mb-0">Create and organize product categories</p>
    </div>
    <div>
        <button class="btn btn-action primary" data-bs-toggle="modal" data-bs-target="#addBrandModal">
            <i class="fas fa-plus"></i> Add New Category
        </button>
    </div>
</div>

<div class="custom-card">
    <div class="custom-card-header">
        <h5 class="custom-card-title"><i class="fas fa-tags text-primary"></i> Registered Categories</h5>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="brands-table" class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th style="width: 10%;">ID</th>
                        <th style="width: 10%;">Logo</th>
                        <th style="width: 20%;">Category Name</th>
                        <th style="width: 20%;">Supplier</th>
                        <th style="width: 20%;">Description</th>
                        <th style="width: 10%;">Status</th>
                        <th style="width: 10%;" class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody id="brands-rows">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Brand Modal -->
<div class="modal fade" id="addBrandModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-plus-circle text-primary"></i> Add Category Profile</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="add-brand-form" enctype="multipart/form-data">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label for="brand-name" class="form-label-custom">Category Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-custom" id="brand-name" name="name" required placeholder="e.g. Packaged Foods">
                    </div>
                    
                    <div class="mb-3">
                        <label for="brand-supplier-id" class="form-label-custom">Supplier <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom brand-supplier-select" id="brand-supplier-id" name="supplier_id" required>
                            <!-- Loaded via AJAX -->
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="brand-logo" class="form-label-custom">Category Logo (Image)</label>
                        <input type="file" class="form-control form-control-custom" id="brand-logo" name="logo" accept="image/*">
                        <div class="form-text text-muted">Supports JPG, PNG, WEBP formats. Max 2MB.</div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="brand-desc" class="form-label-custom">Description</label>
                        <textarea class="form-control form-control-custom" id="brand-desc" name="description" rows="3" placeholder="Brief details about products of this category"></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="brand-status" class="form-label-custom">Status</label>
                        <select class="form-select form-control-custom" id="brand-status" name="status">
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Save Category</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Brand Modal -->
<div class="modal fade" id="editBrandModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-edit text-warning"></i> Edit Category Profile</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="edit-brand-form" enctype="multipart/form-data">
                <input type="hidden" id="edit-brand-id" name="id">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label for="edit-brand-name" class="form-label-custom">Category Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-custom" id="edit-brand-name" name="name" required placeholder="e.g. Packaged Foods">
                    </div>
                    
                    <div class="mb-3">
                        <label for="edit-brand-supplier-id" class="form-label-custom">Supplier <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom brand-supplier-select" id="edit-brand-supplier-id" name="supplier_id" required>
                            <!-- Loaded via AJAX -->
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label for="edit-brand-logo" class="form-label-custom mb-0">Replace Logo (Optional)</label>
                            <span id="current-logo-preview" class="text-secondary small"></span>
                        </div>
                        <input type="file" class="form-control form-control-custom" id="edit-brand-logo" name="logo" accept="image/*">
                    </div>
                    
                    <div class="mb-3">
                        <label for="edit-brand-desc" class="form-label-custom">Description</label>
                        <textarea class="form-control form-control-custom" id="edit-brand-desc" name="description" rows="3" placeholder="Brief details"></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="edit-brand-status" class="form-label-custom">Status</label>
                        <select class="form-select form-control-custom" id="edit-brand-status" name="status">
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Update Category</button>
                </div>
            </form>
        </div>
    </div>
</div>
