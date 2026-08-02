<!-- views/place_order.php -->
<!-- Place New Order View -->
<?php
require_once __DIR__ . '/../config/functions.php';
checkAuth();
$roleName = $_SESSION['role_name'];
if ($roleName !== 'Sales Staff') {
    echo "<div class='text-center py-5'><h3 class='text-danger'>Access Denied</h3></div>";
    return;
}
?>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Place New Order</h3>
        <p class="text-secondary mb-0">Create a new sales order for a retailer</p>
    </div>
    <button class="btn btn-action secondary btn-sm" onclick="window.location.hash='#my_beatroute'">
        <i class="fas fa-arrow-left me-1"></i> Back to Route
    </button>
</div>

<div class="custom-card">
    <div class="custom-card-body">
        <form id="place-order-form">
            <input type="hidden" name="order_mode" id="ord-mode" value="By Call">
            <input type="hidden" name="edit_order_id" id="edit-order-id" value="">
            <h5 class="fw-bold mb-3 text-info">Retailer Selection &amp; Details</h5>
            <div class="row mb-3">
                <div class="col-md-4 mb-3 mb-md-0">
                    <label for="ord-beatroute" class="form-label-custom">Select Beat Route</label>
                    <select class="form-select form-control-custom" id="ord-beatroute">
                        <!-- Loaded dynamically -->
                    </select>
                </div>
                <div class="col-md-4 mb-3 mb-md-0">
                    <label for="ord-retailer" class="form-label-custom">Select Retailer Shop <span class="text-danger">*</span></label>
                    <select class="form-select form-control-custom" id="ord-retailer" name="retailer_id" required>
                        <!-- Loaded dynamically via JS -->
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="ord-date" class="form-label-custom">Order Date <span class="text-danger">*</span></label>
                    <input type="date" class="form-control form-control-custom" id="ord-date" name="order_date" value="<?php echo date('Y-m-d'); ?>" required>
                </div>
            </div>

            <!-- Retailer Details Card -->
            <div id="retailer-details-card" class="bg-secondary bg-opacity-10 p-3 rounded-lg border border-secondary mb-4 d-none">
                <div class="row">
                    <div class="col-md-6 border-end border-secondary">
                        <h5 class="fw-bold text-white mb-1" id="rd-shop-name">--</h5>
                        <p class="text-secondary small mb-1"><i class="fas fa-map-marker-alt me-1"></i> <span id="rd-address">--</span></p>
                        <p class="text-secondary small mb-1"><i class="fas fa-phone me-1"></i> <span id="rd-mobile">--</span></p>
                        <p class="text-secondary small mb-0"><i class="fas fa-file-invoice me-1"></i> GST: <span id="rd-gst">--</span></p>
                    </div>
                    <div class="col-md-6 ps-md-4 mt-3 mt-md-0">
                        <h6 class="fw-bold text-warning mb-2"><i class="fas fa-chart-line me-1"></i> Payment Analysis</h6>
                        <p class="text-secondary small mb-0"><em>No recent payment data available.</em></p>
                        <!-- In the future, outstanding amounts or payment history can be populated here -->
                    </div>
                </div>
            </div>
            
            <h5 class="fw-bold mb-3 text-info">Add SKU to Cart</h5>
            <div class="bg-secondary bg-opacity-10 p-3 rounded-lg border border-secondary mb-4">
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label for="cart-supplier-select" class="form-label-custom">Brand (Supplier)</label>
                        <select class="form-select form-control-custom" id="cart-supplier-select">
                            <option value="">-- Select Supplier --</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="cart-category-select" class="form-label-custom">Category</label>
                        <select class="form-select form-control-custom" id="cart-category-select" disabled>
                            <option value="">-- Select Category --</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="cart-product-select" class="form-label-custom">Product</label>
                        <select class="form-select form-control-custom" id="cart-product-select" disabled>
                            <option value="">-- Select Product --</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="cart-sku-select" class="form-label-custom">SKU</label>
                        <select class="form-select form-control-custom" id="cart-sku-select" disabled>
                            <option value="">-- Select SKU --</option>
                        </select>
                    </div>
                </div>
                <div class="row align-items-end">
                    <div class="col-md-3 mb-3 mb-md-0">
                        <label class="form-label-custom">Available Stock</label>
                        <input type="text" class="form-control form-control-custom bg-dark text-white-50" id="cart-stock-count" value="0" readonly disabled>
                    </div>
                    <div class="col-md-3 mb-3 mb-md-0">
                        <label for="cart-qty" class="form-label-custom">Quantity</label>
                        <input type="number" class="form-control form-control-custom" id="cart-qty" min="1" value="1">
                    </div>
                    <div class="col-md-6 text-end">
                        <button type="button" class="btn btn-action primary w-100 justify-content-center" id="add-to-cart-btn"><i class="fas fa-cart-plus me-1"></i> Add to Cart</button>
                    </div>
                </div>
            </div>
            
            <h5 class="fw-bold mb-3 text-info">Order Cart Details</h5>
            <div class="table-responsive mb-4">
                <table class="table table-custom border border-secondary" id="cart-table">
                    <thead>
                        <tr>
                            <th>SKU Name</th>
                            <th>Code</th>
                            <th class="text-end">Qty</th>
                            <th class="text-end">Rate (₹)</th>
                            <th class="text-end">Discount (₹)</th>
                            <th class="text-end">GST %</th>
                            <th class="text-end">Total Amount (₹)</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody id="cart-rows">
                        <tr><td colspan="8" class="text-center text-secondary py-4">Your shopping cart is empty. Add items above.</td></tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Summary block -->
            <div class="row justify-content-end mb-4">
                <div class="col-lg-4 col-md-6">
                    <div class="p-3 bg-secondary bg-opacity-10 rounded-lg border border-secondary">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary">Gross Amount:</span>
                            <span id="summary-gross">₹0.00</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary">GST / Tax Amount:</span>
                            <span id="summary-gst">₹0.00</span>
                        </div>
                        <hr class="border-secondary">
                        <div class="d-flex justify-content-between fw-bold fs-5">
                            <span>Grand Total:</span>
                            <span class="text-info" id="summary-grand">₹0.00</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="ord-remarks" class="form-label-custom">Special Order Instructions / Remarks</label>
                <textarea class="form-control form-control-custom" id="ord-remarks" name="remarks" rows="2" placeholder="e.g. deliver after 4 PM, call owner before dispatch..."></textarea>
            </div>
            <div class="text-end">
                <button type="submit" class="btn btn-action success btn-lg" id="btn-submit-order"><i class="fas fa-check-circle me-1"></i> Place Sales Order</button>
            </div>
        </form>
    </div>
</div>
