<!-- views/purchase_entry.php -->
<!-- Supplier Purchase Entry -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Supplier Purchase Entry</h3>
        <p class="text-secondary mb-0">Record incoming stock purchases and update inventory</p>
    </div>
</div>

<div class="custom-card">
    <div class="custom-card-header d-flex justify-content-between align-items-center">
        <h5 class="custom-card-title mb-0"><i class="fas fa-history text-primary me-2"></i> Purchase History Log</h5>
        <button class="btn btn-action primary btn-sm" id="btn-add-purchase" data-bs-toggle="modal" data-bs-target="#purchaseModal"><i class="fas fa-plus me-1"></i> Add Purchase</button>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table class="table table-custom mb-0 w-100" id="purchase-history-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Invoice / Ref No.</th>
                        <th>Supplier</th>
                        <th class="text-end">Subtotal (₹)</th>
                        <th class="text-end">Discount (₹)</th>
                        <th class="text-end">GST Paid (₹)</th>
                        <th class="text-end">Grand Total (₹)</th>
                        <th>Remarks</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody id="purchase-history-body">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Purchase Entry Modal -->
<div class="modal fade" id="purchaseModal" tabindex="-1" aria-labelledby="purchaseModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content bg-dark text-white border-secondary">
            <form id="purchase-entry-form">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title" id="purchaseModalLabel"><i class="fas fa-truck-loading text-primary me-2"></i> New Purchase Entry</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="purchase-id" name="purchase_id">
                    <div class="row mb-3">
                        <div class="col-md-3">
                            <label for="pur-supplier-id" class="form-label-custom">Select Supplier <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="pur-supplier-id" name="supplier_name" required>
                                <!-- Loaded dynamically from suppliers table -->
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="pur-invoice" class="form-label-custom">Supplier Invoice / Ref Number <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="pur-invoice" name="supplier_invoice" required placeholder="e.g. Nestle/INV/9842">
                        </div>
                        <div class="col-md-3">
                            <label for="pur-date" class="form-label-custom">Purchase Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control form-control-custom" id="pur-date" name="purchase_date" value="<?php echo date('Y-m-d'); ?>" required>
                        </div>
                        <div class="col-md-3">
                            <label for="pur-payment-mode" class="form-label-custom">Payment Mode <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="pur-payment-mode" name="payment_mode" required>
                                <option value="Bank Transfer">Bank Transfer (IMPS/NEFT)</option>
                                <option value="UPI">UPI</option>
                                <option value="Cheque">Cheque</option>
                                <option value="Cash">Cash</option>
                                <option value="Unpaid">Unpaid / Credit</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Quick Selector Filters -->
                    <div class="card bg-dark border-secondary p-3 mb-4">
                        <h6 class="fw-bold text-white mb-3"><i class="fas fa-filter text-primary me-2"></i> Quick SKU Selection & Add</h6>
                        <div class="row align-items-end g-3">
                            <div class="col-md-2">
                                <label for="filter-category" class="form-label-custom">Select Category</label>
                                <select class="form-select form-control-custom" id="filter-category">
                                    <option value="">-- Choose Category --</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="filter-product" class="form-label-custom">Select Product</label>
                                <select class="form-select form-control-custom" id="filter-product" disabled>
                                    <option value="">-- Choose Category First --</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="filter-sku" class="form-label-custom">Select SKU Item</label>
                                <select class="form-select form-control-custom" id="filter-sku" disabled>
                                    <option value="">-- Choose Product First --</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="filter-qty" class="form-label-custom">Recd Quantity</label>
                                <input type="number" class="form-control form-control-custom" id="filter-qty" min="1" value="1" placeholder="Qty">
                            </div>
                            <div class="col-md-2">
                                <label for="filter-discount" class="form-label-custom">Discount (₹)</label>
                                <input type="number" step="0.01" class="form-control form-control-custom" id="filter-discount" min="0" value="0.00" placeholder="0.00">
                            </div>
                            <div class="col-md-1">
                                <button type="button" class="btn btn-action primary w-100 py-2" id="btn-quick-add-sku" title="Add SKU to list below"><i class="fas fa-plus"></i></button>
                            </div>
                        </div>
                    </div>
                    
                    <h6 class="fw-bold border-bottom border-secondary pb-2 mb-3">Items Added</h6>
                    <div id="purchase-items-container">
                        <div class="row mb-2 purchase-item-row align-items-end">
                            <div class="col-md-5">
                                <label class="form-label-custom">Select SKU Item</label>
                                <select class="form-select form-control-custom purchase-sku-select" name="sku_ids[]" required>
                                    <!-- Loaded dynamically -->
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label-custom">Recd Quantity</label>
                                <input type="number" class="form-control form-control-custom" name="quantities[]" min="1" required placeholder="Qty">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label-custom">Discount (₹)</label>
                                <input type="number" step="0.01" class="form-control form-control-custom" name="discounts[]" min="0" placeholder="0.00">
                            </div>
                            <div class="col-md-1 text-end">
                                <button type="button" class="btn btn-danger btn-sm mb-1 remove-pur-item"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-3 mb-4">
                        <button type="button" class="btn btn-action secondary btn-sm" id="add-purchase-row-btn"><i class="fas fa-plus"></i> Add Row</button>
                    </div>
                    
                    <div class="mb-0">
                        <label for="pur-remarks" class="form-label-custom">General Remarks</label>
                        <textarea class="form-control form-control-custom" id="pur-remarks" name="remarks" rows="2" placeholder="General remarks/notes about this purchase entry..."></textarea>
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-action primary"><i class="fas fa-truck-loading me-2"></i> Post Purchase Entry</button>
                </div>
            </form>
        </div>
    </div>
</div>
