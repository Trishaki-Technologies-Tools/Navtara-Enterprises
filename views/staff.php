<!-- views/staff.php -->
<!-- Sales Staff Management View (Owner Only) -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Sales Staff Accounts</h3>
        <p class="text-secondary mb-0">Configure system credentials, territories, and sales targets for field staff</p>
    </div>
    <div>
        <button class="btn btn-action primary" data-bs-toggle="modal" data-bs-target="#addStaffModal">
            <i class="fas fa-user-plus"></i> Add Sales Executive
        </button>
    </div>
</div>

<div class="custom-card">
    <div class="custom-card-header">
        <h5 class="custom-card-title"><i class="fas fa-users text-primary"></i> Field Sales Force</h5>
    </div>
    <div class="custom-card-body p-0">
        <div class="table-responsive">
            <table id="staff-table" class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th style="width: 8%;">ID</th>
                        <th style="width: 10%;">Photo</th>
                        <th>Employee Details</th>
                        <th>Routes</th>
                        <th class="text-end">Salary</th>
                        <th class="text-end">Sales Target</th>
                        <th>Joining Date</th>
                        <th>Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody id="staff-rows">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Staff Modal -->
<div class="modal fade" id="addStaffModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-user-plus text-primary"></i> Create Staff Profile</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="add-staff-form" enctype="multipart/form-data">
                <div class="modal-body p-4">
                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3">Login Credentials</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="staff-username" class="form-label-custom">System Username <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="staff-username" name="username" required placeholder="e.g. amit_goa" autocomplete="username">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="staff-password" class="form-label-custom">Password <span class="text-danger">*</span></label>
                            <input type="password" class="form-control form-control-custom" id="staff-password" name="password" required placeholder="Minimum 6 characters" autocomplete="new-password">
                        </div>
                    </div>
                    
                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3 mt-4">Personal &amp; Contact Details</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="staff-fullname" class="form-label-custom">Full Employee Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="staff-fullname" name="fullname" required placeholder="e.g. Amit Fernandes">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="staff-mobile" class="form-label-custom">Mobile Number <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control form-control-custom" id="staff-mobile" name="mobile" required placeholder="e.g. 9822114422">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="staff-email" class="form-label-custom">Email Address</label>
                            <input type="email" class="form-control form-control-custom" id="staff-email" name="email" placeholder="e.g. amit@navtara.com">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="staff-photo" class="form-label-custom">Profile Photo</label>
                            <input type="file" class="form-control form-control-custom" id="staff-photo" name="photo" accept="image/*">
                        </div>
                    </div>
                    
                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3 mt-4">Employment Terms &amp; Territory</h6>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="staff-area" class="form-label-custom">Assigned Beat / Area</label>
                            <input type="text" class="form-control form-control-custom" id="staff-area" name="assigned_area" placeholder="e.g. Panaji and Miramar">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label-custom">Assigned Beat Routes</label>
                            <div class="route-multiselect-wrap" id="add-routes-wrap">
                                <button type="button" class="route-multiselect-btn" id="add-routes-btn">
                                    <span class="route-multiselect-label">Select routes...</span>
                                    <i class="fas fa-chevron-down ms-auto"></i>
                                </button>
                                <div class="route-multiselect-dropdown" id="add-routes-dropdown">
                                    <div class="route-multiselect-search">
                                        <input type="text" placeholder="Search routes..." class="route-search-input" id="add-routes-search">
                                    </div>
                                    <div class="route-multiselect-list" id="add-routes-list">
                                        <div class="text-secondary small px-3 py-2">Loading...</div>
                                    </div>
                                </div>
                            </div>
                            <!-- Hidden inputs injected by JS -->
                            <div id="add-routes-hidden"></div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="staff-target" class="form-label-custom">Monthly Sales Target (₹)</label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="staff-target" name="sales_target" value="100000.00">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="staff-salary" class="form-label-custom">Monthly Fixed Salary (₹)</label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="staff-salary" name="salary" value="20000.00">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="staff-joining" class="form-label-custom">Joining Date</label>
                            <input type="date" class="form-control form-control-custom" id="staff-joining" name="joining_date" value="<?php echo date('Y-m-d'); ?>">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="staff-status" class="form-label-custom">Status</label>
                            <select class="form-select form-control-custom" id="staff-status" name="status">
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Save Employee</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Staff Modal -->
<div class="modal fade" id="editStaffModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold"><i class="fas fa-user-edit text-warning"></i> Modify Staff Profile</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="edit-staff-form" enctype="multipart/form-data">
                <input type="hidden" id="edit-staff-id" name="id">
                <div class="modal-body p-4">
                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3">Login Credentials</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-staff-username" class="form-label-custom">System Username <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="edit-staff-username" name="username" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-staff-password" class="form-label-custom">Replace Password (Optional)</label>
                            <input type="password" class="form-control form-control-custom" id="edit-staff-password" name="password" placeholder="Leave blank to keep current">
                        </div>
                    </div>
                    
                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3 mt-4">Personal &amp; Contact Details</h6>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-staff-fullname" class="form-label-custom">Full Employee Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-custom" id="edit-staff-fullname" name="fullname" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edit-staff-mobile" class="form-label-custom">Mobile Number <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control form-control-custom" id="edit-staff-mobile" name="mobile" required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="edit-staff-email" class="form-label-custom">Email Address</label>
                            <input type="email" class="form-control form-control-custom" id="edit-staff-email" name="email">
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label for="edit-staff-photo" class="form-label-custom mb-0">Replace Photo</label>
                                <span id="current-staff-photo-preview" class="text-secondary small"></span>
                            </div>
                            <input type="file" class="form-control form-control-custom" id="edit-staff-photo" name="photo" accept="image/*">
                        </div>
                    </div>
                    
                    <h6 class="fw-bold text-info border-bottom border-secondary pb-2 mb-3 mt-4">Employment Terms &amp; Territory</h6>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="edit-staff-area" class="form-label-custom">Assigned Beat / Area</label>
                            <input type="text" class="form-control form-control-custom" id="edit-staff-area" name="assigned_area">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label-custom">Assigned Beat Routes</label>
                            <div class="route-multiselect-wrap" id="edit-routes-wrap">
                                <button type="button" class="route-multiselect-btn" id="edit-routes-btn">
                                    <span class="route-multiselect-label">Select routes...</span>
                                    <i class="fas fa-chevron-down ms-auto"></i>
                                </button>
                                <div class="route-multiselect-dropdown" id="edit-routes-dropdown">
                                    <div class="route-multiselect-search">
                                        <input type="text" placeholder="Search routes..." class="route-search-input" id="edit-routes-search">
                                    </div>
                                    <div class="route-multiselect-list" id="edit-routes-list">
                                        <div class="text-secondary small px-3 py-2">Loading...</div>
                                    </div>
                                </div>
                            </div>
                            <div id="edit-routes-hidden"></div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="edit-staff-target" class="form-label-custom">Monthly Sales Target (₹)</label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="edit-staff-target" name="sales_target">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="edit-staff-salary" class="form-label-custom">Monthly Fixed Salary (₹)</label>
                            <input type="number" step="0.01" class="form-control form-control-custom" id="edit-staff-salary" name="salary">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="edit-staff-joining" class="form-label-custom">Joining Date</label>
                            <input type="date" class="form-control form-control-custom" id="edit-staff-joining" name="joining_date">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="edit-staff-status" class="form-label-custom">Status</label>
                            <select class="form-select form-control-custom" id="edit-staff-status" name="status">
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary">Update Employee</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Staff Route Schedule Modal -->
<div class="modal fade" id="staffScheduleModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold">
                    <i class="fas fa-calendar-week text-warning me-2"></i>
                    Route Schedule — <span id="sched-staff-name" class="text-warning"></span>
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0">
                <!-- Add schedule row -->
                <div class="p-4 border-bottom border-secondary">
                    <form id="staff-schedule-form" class="row g-2 align-items-end">
                        <input type="hidden" id="staff-sched-staff-id" name="staff_id">
                        <div class="col-md-3">
                            <label class="form-label-custom mb-1">Day of Week <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" name="day_of_week" id="staff-sched-day" required>
                                <option value="">-- Select Day --</option>
                                <option>Monday</option><option>Tuesday</option><option>Wednesday</option>
                                <option>Thursday</option><option>Friday</option><option>Saturday</option><option>Sunday</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label-custom mb-1">Beat Route <span class="text-danger">*</span></label>
                            <select class="form-select form-control-custom" name="route_id" id="staff-sched-route" required>
                                <option value="">-- Select Route --</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label-custom mb-1">Notes</label>
                            <input type="text" class="form-control form-control-custom" name="notes" placeholder="e.g. Morning priority">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-action primary w-100"><i class="fas fa-plus me-1"></i> Add</button>
                        </div>
                    </form>
                </div>
                <!-- Weekly grid -->
                <div class="week-schedule-grid" id="staff-week-grid" style="min-height: 200px;"></div>
            </div>
            <div class="modal-footer modal-footer-custom d-flex justify-content-between">
                <button type="button" class="btn btn-outline-danger btn-sm" id="btn-reset-staff-schedule">
                    <i class="fas fa-trash-alt me-1"></i> Reset Schedule
                </button>
                <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Staff Audit Logs Modal -->
<div class="modal fade" id="staffLogsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold" id="staffLogsTitle"><i class="fas fa-file-invoice text-primary"></i> Employee Activity logs</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4" style="max-height: 450px; overflow-y: auto;">
                <div class="timeline-list" id="staff-logs-timeline">
                    <!-- Logs injected via JS -->
                </div>
            </div>
            <div class="modal-footer modal-footer-custom">
                <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
