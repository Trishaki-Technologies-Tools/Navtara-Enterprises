<!-- views/suppliers.php -->
<!-- Manage Suppliers View -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Manage Suppliers</h3>
        <p class="text-secondary mb-0">Create, view, edit and manage supplier profiles</p>
    </div>
    <div>
        <button class="btn btn-action primary" id="btn-add-supplier" data-bs-toggle="modal" data-bs-target="#supplierModal">
            <i class="fas fa-plus"></i> Add New Supplier
        </button>
    </div>
</div>

<div class="custom-card">
    <div class="custom-card-header">
        <h5 class="custom-card-title"><i class="fas fa-truck text-primary"></i> Supplier Directory</h5>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table class="table table-custom mb-0 w-100" id="suppliers-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>GST Number</th>
                        <th>FSSAI License</th>
                        <th>Address</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody id="suppliers-list-body">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Supplier Modal (Add / Edit) -->
<div class="modal fade" id="supplierModal" tabindex="-1" aria-labelledby="supplierModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark text-white border-secondary">
            <form id="supplier-form">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title" id="supplierModalLabel"><i class="fas fa-truck text-primary me-2"></i> Add New Supplier</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="supplier-id" name="id">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="sup-name" class="form-label-custom">Supplier Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="sup-name" name="name" required placeholder="e.g. Nestle India Ltd.">
                        </div>
                        <div class="col-md-6">
                            <label for="sup-gst" class="form-label-custom">GST Number</label>
                            <input type="text" class="form-control form-control-custom" id="sup-gst" name="gst_number" placeholder="e.g. 30AAAAA1111A1Z1">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="sup-address" class="form-label-custom">Address</label>
                        <textarea class="form-control form-control-custom" id="sup-address" name="address" rows="2" placeholder="Supplier business address..."></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="sup-fssai" class="form-label-custom">FSSAI License (Optional)</label>
                        <input type="text" class="form-control form-control-custom" id="sup-fssai" name="fssai_license" placeholder="e.g. 10015022000123">
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-action primary"><i class="fas fa-save me-1"></i> Save Supplier</button>
                </div>
            </form>
        </div>
    </div>
</div>
