<!-- views/retailers.php -->
<!-- Retailers Management View -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Retailer Accounts</h3>
        <p class="text-secondary mb-0">Manage customer files, outstanding balances, and field sales logs</p>
    </div>
    <div>
        <button class="btn btn-action primary" data-bs-toggle="modal" data-bs-target="#addRetailerModal"
            id="add-retailer-btn">
            <i class="fas fa-plus"></i> Register Retailer
        </button>
    </div>
</div>

<div class="custom-card" id="retailers-card" data-role="<?php echo htmlspecialchars($_SESSION['role_name'] ?? ''); ?>">
    <div class="custom-card-header">
        <h5 class="custom-card-title"><i class="fas fa-store text-primary"></i> Registered Retailers</h5>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="retailers-table" class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th>Shop Name</th>
                        <th>Owner & Area</th>
                        <th>Mobile</th>
                        <th>GST No.</th>
                        <th class="text-end">Credit Limit</th>
                        <th class="text-end">Outstanding</th>
                        <th>Beat Route &amp; Staff</th>
                        <th>Frequency</th>
                        <th>Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody id="retailers-rows">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Retailer Modal -->
<div class="modal fade" id="addRetailerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-plus-circle text-primary"></i> Register Retailer</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <form id="add-retailer-form">
                <div class="modal-body p-4">
                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3">Shop Profile Info</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="ret-shop-name" class="form-label-custom">Shop Name <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="ret-shop-name"
                                name="shop_name" required placeholder="e.g. Varun General Store">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="ret-name" class="form-label-custom">Retailer Owner Name <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="ret-name" name="name"
                                required placeholder="e.g. Varun Pai">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="ret-business-type" class="form-label-custom">Business Type <span
                                    class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="ret-business-type" name="business_type"
                                required>
                                <option value="Retail Shop" selected>Retail Shop</option>
                                <option value="Distributor">Distributor</option>
                                <option value="Wholesaler">Wholesaler</option>
                                <option value="Medical">Medical</option>
                                <option value="Super Market">Super Market</option>
                                <option value="General Store">General Store</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="ret-gst" class="form-label-custom">GSTIN (Optional)</label>
                            <input type="text" class="form-control form-control-custom" id="ret-gst" name="gst_number"
                                placeholder="e.g. 30AAAAA1111A1Z1">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="ret-visit" class="form-label-custom">Visit Frequency</label>
                            <select class="form-select form-control-custom" id="ret-visit" name="visit_frequency">
                                <option value="Daily">Daily</option>
                                <option value="Weekly" selected>Weekly</option>
                                <option value="Bi-Weekly">Bi-Weekly</option>
                                <option value="Monthly">Monthly</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="ret-mobile" class="form-label-custom">Mobile Number <span
                                    class="text-danger">*</span></label>
                            <input type="tel" class="form-control form-control-custom" id="ret-mobile" name="mobile"
                                required placeholder="e.g. 9876543210">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="ret-alt-mobile" class="form-label-custom">Alternate Contact</label>
                            <input type="tel" class="form-control form-control-custom" id="ret-alt-mobile"
                                name="alternate_mobile" placeholder="Backup phone">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="ret-email" class="form-label-custom">Email Address</label>
                        <input type="email" class="form-control form-control-custom" id="ret-email" name="email"
                            placeholder="e.g. shop@example.com">
                    </div>

                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3 mt-4">Location Coordinates
                        &amp; Address</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="ret-area" class="form-label-custom">Area / Landmark <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="ret-area" name="area"
                                required placeholder="e.g. Miramar">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="ret-city" class="form-label-custom">City / Taluka <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="ret-city" name="city"
                                required placeholder="e.g. Panaji">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="ret-pin" class="form-label-custom">PIN Code <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="ret-pin" name="pin_code"
                                required placeholder="e.g. 403001">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="ret-gmap" class="form-label-custom">Google Map Link</label>
                            <input type="text" class="form-control form-control-custom" id="ret-gmap"
                                name="google_map_link" placeholder="Map coordinates URL">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="ret-address" class="form-label-custom">Full Shop Address <span
                                class="text-danger">*</span></label>
                        <textarea class="form-control form-control-custom" id="ret-address" name="address" rows="2"
                            required placeholder="Shop door no, street name..."></textarea>
                    </div>

                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3 mt-4">Credit Terms &amp;
                        Assignments</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="ret-credit-limit" class="form-label-custom">Credit Limit (₹)</label>
                            <input type="number" step="0.01" class="form-control form-control-custom"
                                id="ret-credit-limit" name="credit_limit" value="50000.00" <?php echo $_SESSION['role_name'] !== 'Owner' ? 'disabled' : ''; ?>>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="ret-opening-bal" class="form-label-custom">Opening Ledger Balance (₹)</label>
                            <input type="number" step="0.01" class="form-control form-control-custom"
                                id="ret-opening-bal" name="opening_balance" value="0.00" <?php echo $_SESSION['role_name'] !== 'Owner' ? 'disabled' : ''; ?>>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="ret-beat-route" class="form-label-custom">Assigned Beat Route</label>
                            <select class="form-select form-control-custom" id="ret-beat-route" name="route_id">
                                <option value="">-- No Route Assigned --</option>
                                <!-- Loaded dynamically via JS -->
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="ret-status" class="form-label-custom">Status</label>
                            <select class="form-select form-control-custom" id="ret-status" name="status">
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="ret-remarks" class="form-label-custom">Internal Remarks</label>
                        <textarea class="form-control form-control-custom" id="ret-remarks" name="remarks" rows="2"
                            placeholder="Sales staff visit directions etc."></textarea>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Register Retailer</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Retailer Modal -->
<div class="modal fade" id="editRetailerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-edit text-warning"></i> Modify Retailer Profile</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <form id="edit-retailer-form">
                <input type="hidden" id="edit-ret-id" name="id">
                <div class="modal-body p-4">
                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3">Shop Profile Info</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-shop-name" class="form-label-custom">Shop Name <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="edit-ret-shop-name"
                                name="shop_name" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-name" class="form-label-custom">Retailer Owner Name <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="edit-ret-name" name="name"
                                required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="edit-ret-business-type" class="form-label-custom">Business Type <span
                                    class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" id="edit-ret-business-type"
                                name="business_type" required>
                                <option value="Retail Shop">Retail Shop</option>
                                <option value="Distributor">Distributor</option>
                                <option value="Wholesaler">Wholesaler</option>
                                <option value="Medical">Medical</option>
                                <option value="Super Market">Super Market</option>
                                <option value="General Store">General Store</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="edit-ret-gst" class="form-label-custom">GSTIN (Optional)</label>
                            <input type="text" class="form-control form-control-custom" id="edit-ret-gst"
                                name="gst_number">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="edit-ret-visit" class="form-label-custom">Visit Frequency</label>
                            <select class="form-select form-control-custom" id="edit-ret-visit" name="visit_frequency">
                                <option value="Daily">Daily</option>
                                <option value="Weekly">Weekly</option>
                                <option value="Bi-Weekly">Bi-Weekly</option>
                                <option value="Monthly">Monthly</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-mobile" class="form-label-custom">Mobile Number <span
                                    class="text-danger">*</span></label>
                            <input type="tel" class="form-control form-control-custom" id="edit-ret-mobile"
                                name="mobile" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-alt-mobile" class="form-label-custom">Alternate Contact</label>
                            <input type="tel" class="form-control form-control-custom" id="edit-ret-alt-mobile"
                                name="alternate_mobile">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="edit-ret-email" class="form-label-custom">Email Address</label>
                        <input type="email" class="form-control form-control-custom" id="edit-ret-email" name="email">
                    </div>

                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3 mt-4">Location Coordinates
                        &amp; Address</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-area" class="form-label-custom">Area / Landmark <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="edit-ret-area" name="area"
                                required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-city" class="form-label-custom">City / Taluka <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="edit-ret-city" name="city"
                                required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-pin" class="form-label-custom">PIN Code <span
                                    class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="edit-ret-pin"
                                name="pin_code" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-gmap" class="form-label-custom">Google Map Link</label>
                            <input type="text" class="form-control form-control-custom" id="edit-ret-gmap"
                                name="google_map_link">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="edit-ret-address" class="form-label-custom">Full Shop Address <span
                                class="text-danger">*</span></label>
                        <textarea class="form-control form-control-custom" id="edit-ret-address" name="address" rows="2"
                            required></textarea>
                    </div>

                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3 mt-4">Credit Terms &amp;
                        Assignments</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-credit-limit" class="form-label-custom">Credit Limit (₹)</label>
                            <input type="number" step="0.01" class="form-control form-control-custom"
                                id="edit-ret-credit-limit" name="credit_limit" <?php echo $_SESSION['role_name'] !== 'Owner' ? 'disabled' : ''; ?>>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-beat-route" class="form-label-custom">Assigned Beat Route</label>
                            <select class="form-select form-control-custom" id="edit-ret-beat-route" name="route_id">
                                <option value="">-- No Route Assigned --</option>
                                <!-- Loaded dynamically via JS -->
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-ret-status" class="form-label-custom">Status</label>
                            <select class="form-select form-control-custom" id="edit-ret-status" name="status">
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="edit-ret-remarks" class="form-label-custom">Internal Remarks</label>
                        <textarea class="form-control form-control-custom" id="edit-ret-remarks" name="remarks"
                            rows="2"></textarea>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Update Retailer</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Log Visit Status Modal -->
<div class="modal fade" id="logVisitModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-route text-primary"></i> Log Visit / Call Status</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <form id="log-visit-form">
                <input type="hidden" id="visit-retailer-id" name="retailer_id">
                <input type="hidden" id="visit-lat" name="lat">
                <input type="hidden" id="visit-lng" name="lng">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label-custom">Shop Selected</label>
                        <input type="text" class="form-control form-control-custom bg-secondary bg-opacity-20"
                            id="visit-shop-name-display" readonly>
                    </div>

                    <div class="mb-3">
                        <label for="visit-status-select" class="form-label-custom">Visit Outcome <span
                                class="text-danger">*</span></label>
                        <select class="form-select form-control-custom" id="visit-status-select" name="visit_status"
                            required>
                            <option value="Visited - Order Taken">Visited - Order Taken</option>
                            <option value="Visited - No Order">Visited - No Order</option>
                            <option value="Visited - Payment Collected">Visited - Payment Collected</option>
                            <option value="Called Retailer">Phone Call Log</option>
                            <option value="Closed">Shop Was Closed</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="visit-remarks" class="form-label-custom">Visit Discussion / Remarks <span
                                class="text-danger">*</span></label>
                        <textarea class="form-control form-control-custom" id="visit-remarks" name="remarks" rows="3"
                            required
                            placeholder="Describe visit summary (e.g. owner will order next week, collected cheque etc.)"></textarea>
                    </div>

                    <div class="mb-2" id="gps-status-area">
                        <span class="text-secondary small"><i class="fas fa-location-arrow"></i> Fetching GPS
                            coordinates...</span>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-action primary">Submit Log</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Manage Routes Modal -->
<div class="modal fade" id="manageRoutesModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-route text-info"></i> Manage Routes</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="manage-routes-form">
                <input type="hidden" id="manage-routes-retailer-id">
                <div class="modal-body p-4">
                    <p class="text-secondary mb-3">Assigning beat route for: <strong id="manage-routes-shop-name" class="text-white"></strong></p>
                    <div class="mb-3">
                        <label for="manage-routes-route-select" class="form-label-custom">Beat Route</label>
                        <select class="form-select form-control-custom" id="manage-routes-route-select" name="route_id">
                            <option value="">-- No Route --</option>
                            <!-- Loaded dynamically -->
                        </select>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Save Route</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Retailer Profile Offcanvas / Detailed Timeline View -->
<div class="offcanvas offcanvas-end bg-dark text-white border-start border-secondary" tabindex="-1"
    id="retailerTimelineDrawer" aria-labelledby="timelineTitle" style="width: 450px;">
    <div class="offcanvas-header border-bottom border-secondary p-4">
        <h5 class="offcanvas-title fw-bold" id="timelineTitle"><i class="fas fa-store text-primary"></i> Retailer Audit
            Profile</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body p-4" id="retailer-timeline-content">
        <!-- Loaded dynamically via JS -->
    </div>
</div>