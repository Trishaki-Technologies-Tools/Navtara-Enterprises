<!-- views/inventory.php -->
<!-- Inventory and Stock Management View -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Inventory &amp; Stock Ledger</h3>
        <p class="text-secondary mb-0">Monitor stock levels, status, and track overall stock movement history</p>
    </div>
    <div>
        <button class="btn btn-action warning" id="btn-low-stock-alert">
            <i class="fas fa-exclamation-triangle me-2"></i> Low Stock Alerts
        </button>
    </div>
</div>

<div class="custom-card">
    <div class="custom-card-header p-0">
        <ul class="nav nav-tabs border-bottom-0" id="inventoryTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active py-3 px-4 fw-bold border-0 text-white-50" id="skus-tab" data-bs-toggle="tab" data-bs-target="#skus-pane" type="button" role="tab" aria-selected="true"><i class="fas fa-barcode me-2"></i> SKU Inventory Directory</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link py-3 px-4 fw-bold border-0 text-white-50" id="history-tab" data-bs-toggle="tab" data-bs-target="#history-pane" type="button" role="tab" aria-selected="false"><i class="fas fa-history me-2"></i> Stock Movement History</button>
            </li>
        </ul>
    </div>
    
    <div class="custom-card-body tab-content" id="inventoryTabsContent">
        <!-- 1. SKU Inventory Directory Pane -->
        <div class="tab-pane fade show active" id="skus-pane" role="tabpanel" aria-labelledby="skus-tab">
            <div class="table-responsive">
                <table id="inventory-skus-table" class="table table-custom mb-0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>SKU Code</th>
                            <th>SKU Name</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th class="text-end">Purchase Price</th>
                            <th class="text-end">Selling Price</th>
                            <th class="text-center">Min Stock</th>
                            <th class="text-center">Current Stock</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody id="inventory-skus-rows">
                        <!-- Loaded via AJAX -->
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- 2. Stock Movement History Pane -->
        <div class="tab-pane fade" id="history-pane" role="tabpanel" aria-labelledby="history-tab">
            <div class="table-responsive">
                <table id="inventory-history-table" class="table table-custom mb-0" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>Date / Time</th>
                            <th>SKU Code</th>
                            <th>SKU Name</th>
                            <th>Transaction Type</th>
                            <th class="text-end">Qty</th>
                            <th class="text-end">Prev Stock</th>
                            <th class="text-end">New Stock</th>
                            <th>Details / User Notes</th>
                        </tr>
                    </thead>
                    <tbody id="inventory-history-rows">
                        <!-- Loaded via AJAX -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Low Stock Alert Modal -->
<div class="modal fade" id="lowStockModal" tabindex="-1" aria-labelledby="lowStockModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content bg-dark border-secondary text-white">
            <div class="modal-header border-secondary">
                <h5 class="modal-title fw-bold text-warning" id="lowStockModalLabel">
                    <i class="fas fa-exclamation-triangle me-2"></i> Low Stock Alerts
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table id="modal-low-stock-table" class="table table-custom mb-0" style="width:100%;">
                        <thead>
                            <tr>
                                <th>SKU Code</th>
                                <th>SKU Name</th>
                                <th>Category</th>
                                <th class="text-center">Current Stock</th>
                                <th class="text-center">Min Stock</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody id="modal-low-stock-rows">
                            <!-- Loaded via AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer border-secondary">
                <button type="button" class="btn btn-action secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
