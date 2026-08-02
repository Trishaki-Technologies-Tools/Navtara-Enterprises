<!-- views/beatroute_master.php -->
<!-- Beatroute Master Management View -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Beatroute Master</h3>
        <p class="text-secondary mb-0">Define geographic beat routes and plan day-wise schedules for your sales team</p>
    </div>
    <div>
        <button class="btn btn-action primary" id="btn-add-route"><i class="fas fa-plus me-1"></i> Add New Route</button>
    </div>
</div>

<!-- Routes Table -->
<div class="custom-card mb-4">
    <div class="custom-card-header">
        <h5 class="fw-bold mb-0"><i class="fas fa-route text-primary me-2"></i> Active Beat Routes</h5>
    </div>
    <div class="custom-card-body">
        <div class="table-responsive">
            <table class="table table-custom mb-0 w-100" id="routes-table">
                <thead>
                    <tr>
                        <th>Route Name</th>
                        <th>Assigned Retailers</th>
                        <th>Created On</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody id="routes-list-body">
                    <!-- Loaded via AJAX -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Weekly Schedule Card -->
<div class="custom-card">
    <div class="custom-card-header d-flex justify-content-between align-items-center">
        <h5 class="fw-bold mb-0"><i class="fas fa-calendar-week text-warning me-2"></i> Weekly Route Schedule</h5>
        <div class="d-flex align-items-center gap-3">
            <span class="text-secondary small">Click a day to add routes</span>
            <button class="btn btn-sm btn-outline-danger" id="btn-reset-schedule" title="Clear all schedule entries">
                <i class="fas fa-trash-alt me-1"></i> Reset Schedule
            </button>
        </div>
    </div>
    <div class="custom-card-body p-0">
        <div class="week-schedule-grid" id="week-schedule-grid">
            <!-- Rendered by JS -->
        </div>
    </div>
</div>

<!-- Route Add/Edit Modal -->
<div class="modal fade" id="routeModal" tabindex="-1" aria-labelledby="routeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-dark text-white border-secondary">
            <form id="route-form">
                <input type="hidden" id="route-id-input" name="id">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title" id="routeModalLabel"><i class="fas fa-route text-primary me-2"></i> <span id="route-modal-action-text">Create</span> Beat Route</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="route-name-input" class="form-label-custom">Route Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-custom" id="route-name-input" name="route_name" required placeholder="e.g. Panjim City & Miramar Route">
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-action primary"><i class="fas fa-save me-1"></i> Save Route</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Schedule Add Modal -->
<div class="modal fade" id="scheduleAddModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content modal-content-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title fw-bold">
                    <i class="fas fa-calendar-plus text-warning me-2"></i>
                    Schedule Route — <span id="schedule-day-label" class="text-warning"></span>
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="schedule-add-form">
                <input type="hidden" id="sched-day-input" name="day_of_week">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label-custom">Beat Route <span class="text-danger">*</span></label>
                        <select class="form-select form-control-custom" id="sched-route-select" name="route_id" required>
                            <option value="">-- Select Route --</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label-custom">Assign Sales Staff</label>
                        <select class="form-select form-control-custom" id="sched-staff-select" name="staff_id">
                            <option value="">-- Any / Unassigned --</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label-custom">Notes <span class="text-secondary small">(optional)</span></label>
                        <input type="text" class="form-control form-control-custom" name="notes" placeholder="e.g. Priority area visit">
                    </div>
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-action primary"><i class="fas fa-check me-1"></i> Add to Schedule</button>
                </div>
            </form>
        </div>
    </div>
</div>
