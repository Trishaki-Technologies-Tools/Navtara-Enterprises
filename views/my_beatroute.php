<!-- views/my_beatroute.php -->
<!-- Staff: Today's Beat Route — retailers to visit today -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0"><i class="fas fa-route text-warning me-2"></i> My Beat Routes</h3>
        <p class="text-secondary mb-0">All retailers scheduled for your visits</p>
    </div>
    <button class="btn btn-action secondary btn-sm" id="btn-refresh-beatroute">
        <i class="fas fa-sync-alt me-1"></i> Refresh
    </button>
</div>

<!-- Day Banner -->
<div class="custom-card mb-4" id="today-day-banner">
    <div class="custom-card-body py-3 px-4 d-flex align-items-center gap-4">
        <div class="text-center" style="min-width:80px;">
            <div class="fw-bold text-warning" style="font-size:2.5rem; line-height:1;" id="br-day-name"><i class="fas fa-calendar-alt" style="font-size: 2rem;"></i></div>
            <div class="text-secondary small mt-1" id="br-day-label">All Days</div>
        </div>
        <div class="border-start border-secondary ps-4">
            <div class="text-white fw-semibold" id="br-route-names">Loading routes…</div>
            <div class="text-secondary small mt-1" id="br-retailer-count"></div>
        </div>
    </div>
</div>

<!-- Retailers Tabs -->
<ul class="nav nav-pills custom-nav-pills mb-4" id="beatrouteTab" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="pending-tab" data-bs-toggle="pill" data-bs-target="#pending-pane" type="button" role="tab" aria-controls="pending-pane" aria-selected="true">
            <i class="fas fa-clock text-warning me-2"></i> Pending Visits
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="completed-tab" data-bs-toggle="pill" data-bs-target="#completed-pane" type="button" role="tab" aria-controls="completed-pane" aria-selected="false">
            <i class="fas fa-check-circle text-success me-2"></i> Completed Visits
        </button>
    </li>
</ul>

<div class="tab-content" id="beatrouteTabContent">
    <div class="tab-pane fade show active" id="pending-pane" role="tabpanel" aria-labelledby="pending-tab" tabindex="0">
        <div id="br-retailers-grid-pending" class="row g-3 mb-4">
            <!-- Injected by JS -->
        </div>
    </div>
    
    <div class="tab-pane fade" id="completed-pane" role="tabpanel" aria-labelledby="completed-tab" tabindex="0">
        <div id="br-retailers-grid-completed" class="row g-3 mb-4">
            <!-- Injected by JS -->
        </div>
    </div>
</div>

<!-- No Routes State -->
<div id="br-no-routes" class="text-center py-5 d-none">
    <i class="fas fa-calendar-times fa-4x text-secondary mb-3"></i>
    <h5 class="text-secondary">No Beat Routes Scheduled</h5>
    <p class="text-muted small">You have no routes assigned. Contact your manager.</p>
</div>

<!-- Beat Route Collection Modal -->
<div class="modal fade" id="brCollectionModal" tabindex="-1">
    <div class="modal-dialog">
        <form id="br-collection-form">
            <div class="modal-content bg-dark text-white border-secondary">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title"><i class="fas fa-money-bill-wave text-success me-2"></i> Collect Payment</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="retailer_id" id="br-col-retailer-id">
                    <div class="mb-3">
                        <label class="form-label-custom">Retailer Shop</label>
                        <input type="text" class="form-control form-control-custom bg-secondary text-white" id="br-col-shop-name" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label-custom">Current Outstanding (₹)</label>
                        <input type="text" class="form-control form-control-custom bg-secondary text-white fw-bold" id="br-col-outstanding" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label-custom">Collection Amount (₹) <span class="text-danger">*</span></label>
                        <input type="number" step="0.01" class="form-control form-control-custom" name="amount" id="br-col-amount" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label-custom">Payment Method</label>
                        <select class="form-select form-control-custom" name="payment_method">
                            <option value="Cash">Cash</option>
                            <option value="UPI">UPI</option>
                            <option value="Cheque">Cheque</option>
                            <option value="Bank Transfer">Bank Transfer</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label-custom">Remarks (Optional)</label>
                        <textarea class="form-control form-control-custom" name="remarks" rows="2"></textarea>
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success btn-sm">Submit Payment</button>
                </div>
            </div>
        </form>
    </div>
</div>
