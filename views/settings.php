<!-- views/settings.php -->
<!-- Settings View (Owner Only) -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">System Settings</h3>
        <p class="text-secondary mb-0">Manage company profile details and invoice printing parameters</p>
    </div>
</div>

<div class="row">
    <!-- 1. Company Profile & Printing Config -->
    <div class="col-lg-12">
        <div class="custom-card">
            <div class="custom-card-header">
                <h5 class="custom-card-title"><i class="fas fa-store-alt text-primary"></i> Company Profile &amp; Invoice Metadata</h5>
            </div>
            <div class="custom-card-body">
                <form id="settings-profile-form">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="set-company-name" class="form-label-custom">Company Display Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="set-company-name" name="company_name" required placeholder="e.g. NAVATARA ENTERPRISES">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="set-company-fy" class="form-label-custom">Current Financial Year <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="set-company-fy" name="financial_year" required placeholder="e.g. 2026-27">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="set-company-mobile" class="form-label-custom">Contact Mobile <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control form-control-custom" id="set-company-mobile" name="company_mobile" required placeholder="e.g. 9174800000">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="set-company-email" class="form-label-custom">Company Email Address</label>
                            <input type="email" class="form-control form-control-custom" id="set-company-email" name="company_email" placeholder="e.g. billing@navtara.com">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="set-company-gst" class="form-label-custom">GSTIN Registration <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="set-company-gst" name="company_gst" required placeholder="e.g. 30ABCDE1234F1Z0">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="set-invoice-prefix" class="form-label-custom">Invoice Prefix <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="set-invoice-prefix" name="invoice_prefix" required placeholder="e.g. NE/2026-27/">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="set-default-limit" class="form-label-custom">Default Retailer Credit Limit (₹)</label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="set-default-limit" name="default_credit_limit" placeholder="50000.00">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="set-company-fssai" class="form-label-custom">FSSAI License Number</label>
                            <input type="text" class="form-control form-control-custom" id="set-company-fssai" name="company_fssai" placeholder="e.g. 11220304000116">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="set-bank-name" class="form-label-custom">Bank Name</label>
                            <input type="text" class="form-control form-control-custom" id="set-bank-name" name="bank_name" placeholder="e.g. UNION BANK OF INDIA">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="set-bank-acc" class="form-label-custom">Bank Account Number</label>
                            <input type="text" class="form-control form-control-custom" id="set-bank-acc" name="bank_account_no" placeholder="e.g. 374001010036235">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="set-bank-ifsc" class="form-label-custom">Bank IFSC Code</label>
                            <input type="text" class="form-control form-control-custom" id="set-bank-ifsc" name="bank_ifsc" placeholder="e.g. UBIN0537403">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="set-bank-branch" class="form-label-custom">Bank Branch &amp; City</label>
                            <input type="text" class="form-control form-control-custom" id="set-bank-branch" name="bank_branch" placeholder="e.g. SHAHA PUR BELAGAVI">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="set-company-address" class="form-label-custom">Company Address <span class="text-danger">*</span></label>
                        <textarea class="form-control form-control-custom" id="set-company-address" name="company_address" rows="3" required placeholder="Full registered billing address"></textarea>
                    </div>
                    
                    <div class="mb-4">
                        <label for="set-invoice-footer" class="form-label-custom">Invoice Terms &amp; Conditions (Footer)</label>
                        <textarea class="form-control form-control-custom" id="set-invoice-footer" name="invoice_footer" rows="3" placeholder="Disputes and terms..."></textarea>
                    </div>
                    
                    <button type="submit" class="btn btn-action primary"><i class="fas fa-save"></i> Save Settings Profile</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <!-- Owner Profile & Credentials -->
    <div class="col-lg-12">
        <div class="custom-card">
            <div class="custom-card-header">
                <h5 class="custom-card-title"><i class="fas fa-user-cog text-success"></i> Owner Account Profile &amp; Credentials</h5>
            </div>
            <div class="custom-card-body">
                <form id="owner-profile-form" enctype="multipart/form-data">
                    <div class="row align-items-center mb-3">
                        <div class="col-md-3 text-center mb-3 mb-md-0">
                            <div class="mb-2">
                                <img id="owner-photo-preview" src="assets/images/default-avatar.png" alt="Profile Photo" class="img-thumbnail rounded-circle" style="width: 120px; height: 120px; object-fit: cover;">
                            </div>
                            <label for="owner-photo-input" class="btn btn-sm btn-outline-primary" style="cursor: pointer;">
                                <i class="fas fa-upload me-1"></i> Upload Photo
                            </label>
                            <input type="file" class="form-control d-none" id="owner-photo-input" name="photo" accept="image/*">
                        </div>
                        <div class="col-md-9">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="owner-fullname" class="form-label-custom">Full Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control form-control-custom" id="owner-fullname" name="fullname" required placeholder="e.g. John Doe">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="owner-username" class="form-label-custom">Username <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control form-control-custom" id="owner-username" name="username" required placeholder="e.g. owner_admin">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="owner-email" class="form-label-custom">Email Address</label>
                                    <input type="email" class="form-control form-control-custom" id="owner-email" name="email" placeholder="e.g. owner@navtara.com">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="owner-mobile" class="form-label-custom">Mobile Number</label>
                                    <input type="tel" class="form-control form-control-custom" id="owner-mobile" name="mobile" placeholder="e.g. 9876543210">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row border-top pt-3 mt-3">
                        <div class="col-md-6 mb-3">
                            <label for="owner-password" class="form-label-custom">New Password</label>
                            <input type="password" class="form-control form-control-custom" id="owner-password" name="password" placeholder="Leave blank to keep current">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="owner-password-confirm" class="form-label-custom">Confirm New Password</label>
                            <input type="password" class="form-control form-control-custom" id="owner-password-confirm" name="password_confirm" placeholder="Confirm new password">
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-action success"><i class="fas fa-save"></i> Save Profile Details</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <!-- 2. Payment Methods -->
    <div class="col-lg-6 mb-4">
        <div class="custom-card">
            <div class="custom-card-header d-flex justify-content-between align-items-center">
                <h5 class="custom-card-title mb-0"><i class="fas fa-credit-card text-info"></i> Manage Payment Methods</h5>
            </div>
            <div class="custom-card-body">
                <form id="add-payment-method-form" class="d-flex mb-3">
                    <input type="text" class="form-control form-control-custom me-2" id="new-payment-method" placeholder="e.g. PhonePe, HDFC, Card" required>
                    <button type="submit" class="btn btn-action primary px-3"><i class="fas fa-plus"></i> Add</button>
                </form>
                <div class="table-responsive">
                    <table class="table table-custom border border-secondary mb-0">
                        <thead>
                            <tr>
                                <th>Method Name</th>
                                <th class="text-center" style="width: 80px;">Action</th>
                            </tr>
                        </thead>
                        <tbody id="payment-methods-list-rows">
                            <!-- Loaded dynamically -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- 3. Expense Categories -->
    <div class="col-lg-6 mb-4">
        <div class="custom-card">
            <div class="custom-card-header d-flex justify-content-between align-items-center">
                <h5 class="custom-card-title mb-0"><i class="fas fa-tags text-warning"></i> Manage Expense Categories</h5>
            </div>
            <div class="custom-card-body">
                <form id="add-expense-category-form" class="d-flex mb-3">
                    <input type="text" class="form-control form-control-custom me-2" id="new-expense-category" placeholder="e.g. Electricity, Internet, Maintenance" required>
                    <button type="submit" class="btn btn-action primary px-3"><i class="fas fa-plus"></i> Add</button>
                </form>
                <div class="table-responsive">
                    <table class="table table-custom border border-secondary mb-0">
                        <thead>
                            <tr>
                                <th>Category Name</th>
                                <th class="text-center" style="width: 80px;">Action</th>
                            </tr>
                        </thead>
                        <tbody id="expense-categories-list-rows">
                            <!-- Loaded dynamically -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
