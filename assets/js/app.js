/* assets/js/app.js */
/* Main SPA JavaScript Controller for NAVATARA ENTERPRISES ERP */

$(document).ready(function () {
    // ----------------------------------------------------
    // GLOBAL STATE & CONSTANTS
    // ----------------------------------------------------
    let currentRoute = '';
    let datatables = {};
    let charts = {};
    let orderCart = []; // Sales order placing cart state

    window.paymentMethods = ["Cash", "UPI", "Bank Transfer", "Cheque", "Card"];
    window.expenseCategories = ["Travel / Fuel", "Salaries / Commissions", "Rent & Bills", "Office / Stationery", "Marketing / Refreshments", "Miscellaneous"];

    function fetchConfigLists(callback) {
        $.get('api/settings.php?action=load', function (res) {
            if (res.status === 'success') {
                try {
                    if (res.data.payment_methods) {
                        window.paymentMethods = JSON.parse(res.data.payment_methods);
                    }
                } catch(e) {
                    console.error("Failed to parse payment methods", e);
                }
                try {
                    if (res.data.expense_categories) {
                        window.expenseCategories = JSON.parse(res.data.expense_categories);
                    }
                } catch(e) {
                    console.error("Failed to parse expense categories", e);
                }
            }
            if (callback) callback();
        });
    }

    // ----------------------------------------------------
    // CUSTOM TOAST NOTIFICATIONS
    // ----------------------------------------------------
    window.showToast = function (type, message) {
        const container = $('#toast-container');
        const id = 'toast-' + Date.now();
        let iconClass = 'fa-info-circle';
        
        if (type === 'success') iconClass = 'fa-check-circle text-success';
        if (type === 'error') iconClass = 'fa-exclamation-triangle text-danger';
        if (type === 'warning') iconClass = 'fa-exclamation-circle text-warning';
        if (type === 'info') iconClass = 'fa-info-circle text-info';

        const toastHtml = `
            <div id="${id}" class="toast-custom ${type} show">
                <i class="fas ${iconClass} fs-5"></i>
                <div class="flex-grow-1">
                    <div class="fw-bold text-white small">${type.toUpperCase()}</div>
                    <div class="small text-secondary">${message}</div>
                </div>
                <button type="button" class="btn-close btn-close-white ms-auto" onclick="$('#${id}').removeClass('show').remove()"></button>
            </div>
        `;
        
        container.append(toastHtml);
        
        // Auto-remove toast after 4 seconds
        setTimeout(() => {
            $(`#${id}`).removeClass('show');
            setTimeout(() => { $(`#${id}`).remove(); }, 300);
        }, 4000);
    };

    // ----------------------------------------------------
    // ROUTING ENGINE (SPA HASH ROUTER)
    // ----------------------------------------------------
    function router() {
        const hash = window.location.hash || '#dashboard';
        const viewName = hash.replace('#', '');
        
        // Prevent reloading if same route (except for initial load)
        if (currentRoute === viewName && $('#content-pane').html().trim().length > 100) return;
        
        // Highlights active sidebar menu
        $('.nav-menu li').removeClass('active');
        $(`.nav-menu li[data-route="${viewName}"]`).addClass('active');
        
        // Close mobile sidebar if open
        $('#sidebar').removeClass('show');
        
        // Clean up previous view states
        destroyAllDataTables();
        
        currentRoute = viewName;
        
        // Load view HTML via AJAX
        $.get(`index.php?view=${viewName}`)
            .done(function (html) {
                $('#content-pane').html(html);
                
                // Initialize specific view controllers
                switch (viewName) {
                    case 'dashboard':
                        loadDashboard();
                        break;
                    case 'suppliers':
                        loadSuppliers();
                        break;
                    case 'brands':
                        loadBrands();
                        break;
                    case 'products':
                        loadProducts();
                        break;
                    case 'skus':
                        loadSkus();
                        break;
                    case 'discount_slabs':
                        loadDiscountSlabs();
                        break;
                    case 'inventory':
                        loadInventory();
                        break;
                    case 'purchase_entry':
                        loadPurchaseEntry();
                        break;
                    case 'retailers':
                        loadRetailers();
                        break;
                    case 'staff':
                        loadStaff();
                        break;
                    case 'orders':
                        loadOrders();
                        break;
                    case 'place_order':
                        loadPlaceOrder();
                        break;
                    case 'billing':
                        loadBilling();
                        break;
                    case 'payments':
                        loadPayments();
                        break;
                    case 'accounting':
                        loadAccounting();
                        break;
                    case 'settings':
                        loadSettings();
                        break;
                    case 'expiry_products':
                        loadExpiryProducts();
                        break;
                    case 'gst_report':
                        loadGstReport();
                        break;
                    case 'beatroute_master':
                        loadBeatrouteMaster();
                        break;
                    case 'my_beatroute':
                        loadMyBeatRoute();
                        break;
                }
            })
            .fail(function () {
                $('#content-pane').html('<div class="text-center py-5"><h3 class="text-danger"><i class="fas fa-exclamation-triangle"></i> Failed to load page view.</h3></div>');
            });
    }

    // Monitor Hash modifications
    window.addEventListener('hashchange', router);
    
    // Initial router execution if logged in
    if ($('#app-layout').length > 0) {
        router();
    }

    // ----------------------------------------------------
    // AUTHENTICATION CONTROLS
    // ----------------------------------------------------
    // Handle Login Submit
    $(document).on('submit', '#login-form', function (e) {
        e.preventDefault();
        const username = $('#login-username').val();
        const password = $('#login-password').val();
        
        $.post('api/auth.php?action=login', { username, password })
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', 'Login successful. Redirecting...');
                    setTimeout(() => {
                        window.location.reload();
                    }, 1000);
                } else {
                    showToast('error', res.message);
                }
            })
            .fail(function () {
                showToast('error', 'Login connection failed. Try again.');
            });
    });

    // Handle Logout Click
    $(document).on('click', '#logout-trigger', function (e) {
        e.preventDefault();
        if (confirm('Are you sure you want to log out from NAVtara ERP?')) {
            $.post('api/auth.php?action=logout')
                .done(function () {
                    showToast('success', 'Logged out successfully.');
                    setTimeout(() => {
                        window.location.href = 'index.php';
                    }, 800);
                });
        }
    });

    // ----------------------------------------------------
    // THEME MODE (DARK ALWAYS)
    // ----------------------------------------------------
    document.documentElement.setAttribute('data-theme', 'dark');

    // Mobile Sidebar Hamburger toggle
    $(document).on('click', '#mobile-sidebar-toggle', function () {
        $('#sidebar').toggleClass('show');
    });

    // Helper: destroy all active Datatables
    function destroyAllDataTables() {
        for (let key in datatables) {
            if ($.fn.DataTable.isDataTable(datatables[key])) {
                datatables[key].destroy(true);
            }
        }
        datatables = {};
    }

    // Helper: safely destroy DataTable if it exists
    function safeDestroyTable(tableId) {
        if ($.fn.DataTable.isDataTable(tableId)) {
            $(tableId).DataTable().destroy();
        }
    }

    // Helper: format numbers to INR Rupees
    function formatRupees(amount) {
        return new Intl.NumberFormat('en-IN', {
            style: 'currency',
            currency: 'INR',
            maximumFractionDigits: 2
        }).format(amount);
    }

    // Helper: format dates to DD-MMM-YYYY
    function formatDate(dateStr) {
        if (!dateStr) return 'N/A';
        const parts = dateStr.split('-');
        if (parts.length !== 3) return dateStr;
        const year = parseInt(parts[0], 10);
        const monthIndex = parseInt(parts[1], 10) - 1;
        const day = parseInt(parts[2], 10);
        
        const date = new Date(year, monthIndex, day);
        if (isNaN(date.getTime())) return dateStr;
        
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        const dayStr = String(day).padStart(2, '0');
        const monthStr = months[monthIndex];
        return `${dayStr}-${monthStr}-${year}`;
    }

    // Helper: populate select options dynamically
    function populateDropdown(url, targetSelectId, defaultOptionText, valueField = 'id', labelField = 'name') {
        return $.get(url, function (res) {
            if (res.status === 'success') {
                const select = $(targetSelectId);
                select.empty();
                if (defaultOptionText) {
                    select.append(`<option value="">${defaultOptionText}</option>`);
                }
                res.data.forEach(item => {
                    let label = item[labelField];
                    if (url.indexOf('retailers.php') !== -1 || item.hasOwnProperty('gst_number')) {
                        const gst = item.gst_number ? item.gst_number : 'No GST';
                        label = `${item[labelField]} (${gst})`;
                    }
                    select.append(`<option value="${item[valueField]}">${label}</option>`);
                });
            }
        });
    }

    // ----------------------------------------------------
    // DASHBOARD CONTROLLER
    // ----------------------------------------------------
    function loadDashboard() {
        if (currentRoute !== 'dashboard') return;
        $.get('api/dashboard.php?action=stats')
            .done(function (res) {
                if (res.status === 'success') {
                    const data = res.data;
                    const container = $('#dashboard-metrics');
                    container.empty();
                    
                    // Render Metrics dynamically based on returned stats list
                    for (let key in data.metrics) {
                        const m = data.metrics[key];
                        let colorClass = 'primary';
                        if (m.color) colorClass = m.color;
                        
                        container.append(`
                            <div class="metric-card ${colorClass}">
                                <div class="metric-info">
                                    <span class="label">${m.label}</span>
                                    <h3 class="value">${m.value}</h3>
                                </div>
                                <div class="metric-icon"><i class="fas ${m.icon}"></i></div>
                            </div>
                        `);
                    }
                    
                    // RENDER LINE CHART FOR SALES TRENDS
                    const ctxTrends = document.getElementById('salesTrendsChart').getContext('2d');
                    if (charts['trends']) charts['trends'].destroy();
                    
                    charts['trends'] = new Chart(ctxTrends, {
                        type: 'line',
                        data: {
                            labels: data.chart_trends.labels,
                            datasets: [
                                {
                                    label: 'Sales Revenue (₹)',
                                    data: data.chart_trends.sales,
                                    borderColor: '#3b82f6',
                                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                                    fill: true,
                                    tension: 0.3
                                },
                                {
                                    label: 'Collections Credit (₹)',
                                    data: data.chart_trends.collections,
                                    borderColor: '#10b981',
                                    backgroundColor: 'rgba(16, 185, 129, 0.1)',
                                    fill: true,
                                    tension: 0.3
                                }
                            ]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { labels: { color: '#9ca3af' } }
                            },
                            scales: {
                                y: { grid: { color: '#374151' }, ticks: { color: '#9ca3af' } },
                                x: { grid: { color: '#374151' }, ticks: { color: '#9ca3af' } }
                            }
                        }
                    });

                    // Target Tracker progress for sales staff
                    if (data.target_progress) {
                        $('#staff-target-progress').text(`${data.target_progress.percentage}%`);
                        $('#staff-target-bar').css('width', `${data.target_progress.percentage}%`);
                        $('#staff-target-achieved').text(formatRupees(data.target_progress.achieved));
                        $('#staff-target-value').text(formatRupees(data.target_progress.target));
                    }
                    
                    // RENDER OUTSTANDINGS BAR CHART (Owner Only)
                    if (document.getElementById('outstandingChart')) {
                        const ctxOut = document.getElementById('outstandingChart').getContext('2d');
                        if (charts['outstandings']) charts['outstandings'].destroy();
                        
                        charts['outstandings'] = new Chart(ctxOut, {
                            type: 'bar',
                            data: {
                                labels: data.chart_outstanding.labels,
                                datasets: [{
                                    label: 'Outstanding Amt (₹)',
                                    data: data.chart_outstanding.values,
                                    backgroundColor: 'rgba(239, 68, 68, 0.75)',
                                    borderRadius: 6
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: { legend: { display: false } },
                                scales: {
                                    y: { grid: { color: '#374151' }, ticks: { color: '#9ca3af' } },
                                    x: { grid: { display: false }, ticks: { color: '#9ca3af' } }
                                }
                            }
                        });
                    }
                    
                    // Populates Top Selling list (Owner only)
                    if (data.top_selling && data.top_selling.length > 0) {
                        const topRows = $('#top-selling-rows');
                        topRows.empty();
                        data.top_selling.forEach(row => {
                            topRows.append(`
                                <tr>
                                    <td><strong>${row.sku_name}</strong><br><span class="small text-secondary">${row.sku_code}</span></td>
                                    <td class="text-end fw-bold">${row.units_sold}</td>
                                    <td class="text-end text-success">${formatRupees(row.revenue)}</td>
                                </tr>
                            `);
                        });
                    }
                    
                    // Populates Recent orders
                    if (data.recent_orders && data.recent_orders.length > 0) {
                        const recRows = $('#recent-orders-rows');
                        recRows.empty();
                        data.recent_orders.forEach(row => {
                            let statusBadge = `<span class="badge-custom info">Pending</span>`;
                            if (row.status === 'Approved') statusBadge = `<span class="badge-custom success">Approved</span>`;
                            if (row.status === 'Completed') statusBadge = `<span class="badge-custom success">Completed</span>`;
                            if (row.status === 'Cancelled') statusBadge = `<span class="badge-custom danger">Cancelled</span>`;
                            
                            recRows.append(`
                                <tr>
                                    <td>#ORD-${row.id}</td>
                                    <td><strong>${row.shop_name}</strong></td>
                                    <td>${row.order_date}</td>
                                    <td class="text-end fw-bold">${formatRupees(row.grand_total)}</td>
                                    <td>${statusBadge}</td>
                                </tr>
                            `);
                        });
                    }
                } else {
                    $('#dashboard-metrics').html(`<div class="alert alert-danger w-100">Error loading dashboard: ${res.message}</div>`);
                    showToast('error', res.message);
                }
            })
            .fail(function (xhr) {
                $('#dashboard-metrics').html(`<div class="alert alert-danger w-100">API connection failed. Could not load dashboard stats.</div>`);
                showToast('error', 'Dashboard API connection failed.');
            });
    }

    // ----------------------------------------------------
    // BRAND CONTROLLER
    // ----------------------------------------------------
    function loadBrands() {
        safeDestroyTable('#brands-table');
        populateDropdown('api/suppliers.php?action=list', '.brand-supplier-select', '-- Select Supplier --', 'id', 'name');
        $.get('api/brands.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#brands-rows');
                    rows.empty();
                    res.data.forEach(item => {
                        const img = item.logo ? `<img src="${item.logo}" style="width: 50px; height: 50px; object-fit: contain; border-radius: 8px; border: 1px solid var(--border-color);">` : '<span class="text-secondary small">No Logo</span>';
                        let badge = item.status === 'Active' ? '<span class="badge-custom success">Active</span>' : '<span class="badge-custom danger">Inactive</span>';
                        
                        rows.append(`
                            <tr>
                                <td>${item.id}</td>
                                <td>${img}</td>
                                <td><strong>${item.name}</strong></td>
                                <td><strong>${item.supplier_name || '<span class="text-muted">N/A</span>'}</strong></td>
                                <td><span class="text-secondary small">${item.description || 'N/A'}</span></td>
                                <td>${badge}</td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-warning edit-brand-btn" data-id="${item.id}" title="Edit"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-sm btn-outline-danger delete-brand-btn" data-id="${item.id}" title="Delete"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                        `);
                    });
                    
                    datatables['brands'] = $('#brands-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
    }

    // Brand submissions
    $(document).on('submit', '#add-brand-form', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        
        $.ajax({
            url: 'api/brands.php?action=create',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#addBrandModal').modal('hide');
                    $('#add-brand-form')[0].reset();
                    loadBrands();
                } else {
                    showToast('error', res.message);
                }
            }
        });
    });

    $(document).on('click', '.edit-brand-btn', function () {
        const id = $(this).data('id');
        $.get(`api/brands.php?action=detail&id=${id}`, function (res) {
            if (res.status === 'success') {
                const b = res.data;
                $('#edit-brand-id').val(b.id);
                $('#edit-brand-name').val(b.name);
                $('#edit-brand-supplier-id').val(b.supplier_id);
                $('#edit-brand-desc').val(b.description);
                $('#edit-brand-status').val(b.status);
                
                if (b.logo) {
                    $('#current-logo-preview').html(`<img src="${b.logo}" style="height:30px; object-fit:contain;">`);
                } else {
                    $('#current-logo-preview').text('');
                }
                
                $('#editBrandModal').modal('show');
            }
        });
    });

    $(document).on('submit', '#edit-brand-form', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        
        $.ajax({
            url: 'api/brands.php?action=update',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#editBrandModal').modal('hide');
                    loadBrands();
                } else {
                    showToast('error', res.message);
                }
            }
        });
    });

    $(document).on('click', '.delete-brand-btn', function () {
        const id = $(this).data('id');
        if (confirm('Delete category profile? Associated products will remain in database.')) {
            $.post('api/brands.php?action=delete', { id })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadBrands();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    // ----------------------------------------------------
    // PRODUCTS CONTROLLER
    // ----------------------------------------------------
    function loadProducts() {
        safeDestroyTable('#products-table');
        $.get('api/products.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#products-rows');
                    rows.empty();
                    const isOwner = window.userRole === 'Owner';
                    res.data.forEach(item => {
                        const img = item.image ? `<img src="${item.image}" style="width: 50px; height: 50px; object-fit: contain; border-radius: 8px; border: 1px solid var(--border-color);">` : '<span class="text-secondary small">No Image</span>';
                        let badge = item.status === 'Active' ? '<span class="badge-custom success">Active</span>' : '<span class="badge-custom danger">Inactive</span>';
                        
                        let actionsHtml = '';
                        if (isOwner) {
                            actionsHtml = `
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-warning edit-product-btn" data-id="${item.id}" title="Edit"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-sm btn-outline-danger delete-product-btn" data-id="${item.id}" title="Delete"><i class="fas fa-trash"></i></button>
                                </td>
                            `;
                        }

                        rows.append(`
                            <tr>
                                <td>${item.id}</td>
                                <td>${img}</td>
                                <td><strong>${item.brand_name}</strong></td>
                                <td><strong>${item.name}</strong></td>
                                <td>${item.gst_percentage}%</td>
                                <td><code>${item.hsn_code || 'N/A'}</code></td>
                                <td class="text-center"><span class="badge bg-secondary">${item.sku_count} SKUs</span></td>
                                <td>${badge}</td>
                                ${actionsHtml}
                            </tr>
                        `);
                    });
                    
                    datatables['products'] = $('#products-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
    }

    // Load active categories for product form modals
    $(document).on('click', '#add-product-btn', function () {
        populateDropdown('api/brands.php?action=list', '#product-brand', '-- Choose Category --', 'id', 'name');
    });

    $(document).on('submit', '#add-product-form', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        
        $.ajax({
            url: 'api/products.php?action=create',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#addProductModal').modal('hide');
                    $('#add-product-form')[0].reset();
                    loadProducts();
                } else {
                    showToast('error', res.message);
                }
            }
        });
    });

    $(document).on('click', '.edit-product-btn', function () {
        const id = $(this).data('id');
        
        // Populates Category list first
        populateDropdown('api/brands.php?action=list', '#edit-product-brand', '-- Choose Category --', 'id', 'name')
            .done(function () {
                $.get(`api/products.php?action=detail&id=${id}`, function (res) {
                    if (res.status === 'success') {
                        const p = res.data;
                        $('#edit-product-id').val(p.id);
                        $('#edit-product-brand').val(p.brand_id);
                        $('#edit-product-name').val(p.name);
                        $('#edit-product-gst').val(p.gst_percentage);
                        $('#edit-product-hsn').val(p.hsn_code);
                        $('#edit-product-desc').val(p.description);
                        $('#edit-product-status').val(p.status);
                        
                        if (p.image) {
                            $('#current-image-preview').html(`<img src="${p.image}" style="height:30px;">`);
                        } else {
                            $('#current-image-preview').text('');
                        }
                        
                        $('#editProductModal').modal('show');
                    }
                });
            });
    });

    $(document).on('submit', '#edit-product-form', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        
        $.ajax({
            url: 'api/products.php?action=update',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#editProductModal').modal('hide');
                    loadProducts();
                } else {
                    showToast('error', res.message);
                }
            }
        });
    });

    $(document).on('click', '.delete-product-btn', function () {
        const id = $(this).data('id');
        if (confirm('Delete product catalog profile? Associated SKUs will be impacted.')) {
            $.post('api/products.php?action=delete', { id })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadProducts();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    // ----------------------------------------------------
    // SKUs CONTROLLER
    // ----------------------------------------------------
    function loadSkus() {
        safeDestroyTable('#skus-table');
        $.get('api/skus.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#skus-rows');
                    rows.empty();
                    const isOwner = window.userRole === 'Owner';
                    res.data.forEach(item => {
                        let badge = item.status === 'Active' ? '<span class="badge-custom success">Active</span>' : '<span class="badge-custom danger">Inactive</span>';
                        let stockColor = 'text-white';
                        if (parseInt(item.current_stock) <= parseInt(item.minimum_stock)) {
                            stockColor = 'text-danger fw-bold';
                        }
                        
                        let purchaseHtml = '';
                        if (isOwner) {
                            purchaseHtml = `<td class="text-end text-secondary">${formatRupees(item.purchase_price)}</td>`;
                        }
                        
                        let actionsHtml = '';
                        if (isOwner) {
                            actionsHtml = `
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-warning edit-sku-btn" data-id="${item.id}" title="Edit"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-sm btn-outline-danger delete-sku-btn" data-id="${item.id}" title="Delete"><i class="fas fa-trash"></i></button>
                                </td>
                            `;
                        }

                        rows.append(`
                            <tr>
                                <td><code>${item.sku_code}</code></td>
                                <td><strong>${item.brand_name}</strong><br><span class="small text-secondary">${item.product_name}</span></td>
                                <td><strong>${item.sku_name}</strong></td>
                                ${purchaseHtml}
                                <td class="text-end fw-bold text-success">${formatRupees(item.selling_price)}</td>
                                <td class="text-end fw-bold text-primary">${formatRupees(parseFloat(item.selling_price) * (1 + parseFloat(item.gst_percentage || 0) / 100))}</td>
                                <td class="text-end text-info">${formatRupees(item.mrp)}</td>
                                <td>${item.unit}</td>
                                <td class="text-center ${stockColor}">${item.current_stock} <small class="text-secondary">/ Min:${item.minimum_stock}</small></td>
                                <td>${badge}</td>
                                ${actionsHtml}
                            </tr>
                        `);
                    });
                    
                    datatables['skus'] = $('#skus-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
    }

    $(document).on('click', '#add-sku-btn', function () {
        $('#sku-gst').val('18.00'); // default
        populateDropdown('api/products.php?action=list', '#sku-product', '-- Choose Product --', 'id', 'name');
    });



    $(document).on('change', '#sku-product', function () {
        const pid = $(this).val();
        if (pid) {
            $.get(`api/products.php?action=detail&id=${pid}`, function(res) {
                if (res.status === 'success') {
                    $('#sku-gst').val(res.data.gst_percentage);

                }
            });
        }
    });

    $(document).on('change', '#edit-sku-product', function () {
        const pid = $(this).val();
        if (pid) {
            $.get(`api/products.php?action=detail&id=${pid}`, function(res) {
                if (res.status === 'success') {
                    $('#edit-sku-gst').val(res.data.gst_percentage);

                }
            });
        }
    });

    $(document).on('submit', '#add-sku-form', function (e) {
        e.preventDefault();
        $.post('api/skus.php?action=create', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#addSkuModal').modal('hide');
                    $('#add-sku-form')[0].reset();
                    loadSkus();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    $(document).on('click', '.edit-sku-btn', function () {
        const id = $(this).data('id');
        populateDropdown('api/products.php?action=list', '#edit-sku-product', '-- Choose Product --', 'id', 'name')
            .done(function () {
                $.get(`api/skus.php?action=detail&id=${id}`, function (res) {
                    if (res.status === 'success') {
                        const s = res.data;
                        $('#edit-sku-id').val(s.id);
                        $('#edit-sku-product').val(s.product_id);
                        $('#edit-sku-name').val(s.sku_name);
                        $('#edit-sku-unit').val(s.unit);
                        $('#edit-sku-gst').val(s.gst_percentage);
                        $('#edit-sku-purchase').val(s.purchase_price);
                        $('#edit-sku-selling').val(s.selling_price);
                        $('#edit-sku-mrp').val(s.mrp);
                        $('#edit-sku-min-stock').val(s.minimum_stock);
                        $('#edit-sku-status').val(s.status);
                        

                        
                        $('#editSkuModal').modal('show');
                    }
                });
            });
    });

    $(document).on('submit', '#edit-sku-form', function (e) {
        e.preventDefault();
        $.post('api/skus.php?action=update', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#editSkuModal').modal('hide');
                    loadSkus();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    $(document).on('click', '.delete-sku-btn', function () {
        const id = $(this).data('id');
        if (confirm('Delete SKU configuration? All historical transaction stock links will remain.')) {
            $.post('api/skus.php?action=delete', { id })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadSkus();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    // ----------------------------------------------------
    // DISCOUNT SLABS CONTROLLER
    // ----------------------------------------------------
    function loadDiscountSlabs() {
        safeDestroyTable('#discount-skus-table');
        $.get('api/skus.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#discount-skus-rows');
                    rows.empty();
                    
                    if (res.data.length === 0) {
                        rows.append('<tr><td colspan="6" class="text-center">No SKUs found.</td></tr>');
                        return;
                    }
                    
                    // We need to fetch discount counts. For simplicity, we just list SKUs and have a button to manage
                    res.data.forEach(item => {
                        rows.append(`
                            <tr>
                                <td><code>${item.sku_code}</code></td>
                                <td><strong>${item.brand_name}</strong><br><span class="small text-secondary">${item.product_name}</span></td>
                                <td><strong>${item.sku_name}</strong></td>
                                <td class="text-end fw-bold text-success">${formatRupees(item.selling_price)}</td>
                                <td class="text-center"><span class="badge bg-secondary">Manage Rules</span></td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-info manage-discount-btn" data-id="${item.id}" data-name="${item.sku_name}" data-rate="${item.selling_price}">
                                        <i class="fas fa-cog"></i> Config
                                    </button>
                                </td>
                            </tr>
                        `);
                    });
                    
                    datatables['discount-skus'] = $('#discount-skus-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
    }

    $(document).on('click', '.manage-discount-btn', function () {
        const id = $(this).data('id');
        const name = $(this).data('name');
        const rate = $(this).data('rate');
        
        $('#md-sku-name').text(name);
        $('#md-base-rate').text(formatRupees(rate));
        $('#add-disc-sku-id').val(id);
        
        loadSkuDiscounts(id);
        $('#manageDiscountsModal').modal('show');
    });
    
    function loadSkuDiscounts(skuId) {
        $.get(`api/discount_slabs.php?action=list&sku_id=${skuId}`, function(res) {
            if (res.status === 'success') {
                const tbody = $('#md-rules-body');
                tbody.empty();
                if (res.data.length === 0) {
                    tbody.append('<tr><td colspan="5" class="text-center text-secondary py-3">No active discount rules.</td></tr>');
                    return;
                }
                
                res.data.forEach(d => {
                    let criteria = d.discount_type === 'Quantity Slab' 
                        ? `Qty ${d.min_qty} to ${d.max_qty === 999999 ? 'above' : d.max_qty}`
                        : `Flat on Base Rate`;
                        
                    let statusBadge = d.status === 'Active' ? '<span class="badge bg-success">Active</span>' : '<span class="badge bg-secondary">Inactive</span>';
                    
                    tbody.append(`
                        <tr>
                            <td><strong>${d.discount_type}</strong></td>
                            <td>${criteria}</td>
                            <td class="text-end fw-bold text-success">${formatRupees(d.discount_value)}</td>
                            <td class="text-center">${statusBadge}</td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-danger del-discount-btn" data-id="${d.id}"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                    `);
                });
            }
        });
    }
    
    $(document).on('change', '#add-disc-type', function() {
        if ($(this).val() === 'Flat Rate') {
            $('.disc-qty-fields').hide();
        } else {
            $('.disc-qty-fields').show();
        }
    });

    $(document).on('submit', '#add-discount-form', function(e) {
        e.preventDefault();
        const skuId = $('#add-disc-sku-id').val();
        $.post('api/discount_slabs.php?action=create', $(this).serialize(), function(res) {
            if (res.status === 'success') {
                showToast('success', res.message);
                $('#add-discount-form')[0].reset();
                $('#add-disc-type').trigger('change'); // reset UI fields
                loadSkuDiscounts(skuId);
            } else {
                showToast('error', res.message);
            }
        });
    });

    $(document).on('click', '.del-discount-btn', function() {
        const id = $(this).data('id');
        const skuId = $('#add-disc-sku-id').val();
        if (confirm('Delete this discount rule?')) {
            $.post('api/discount_slabs.php?action=delete', { id }, function(res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    loadSkuDiscounts(skuId);
                } else {
                    showToast('error', res.message);
                }
            });
        }
    });

    // Real-time calculation helpers for SKU Add/Edit price forms
    function calculateSkuPrices(modalType, triggerField) {
        const prefix = modalType === 'edit' ? '#edit-' : '#';
        const gst = parseFloat($(prefix + 'sku-gst').val()) || 0;
        
        if (triggerField === 'excl_purchase') {
            const excl = parseFloat($(prefix + 'sku-purchase-excl').val()) || 0;
            const incl = excl * (1 + gst / 100);
            $(prefix + 'sku-purchase').val(incl.toFixed(2));
        } else if (triggerField === 'incl_purchase') {
            const incl = parseFloat($(prefix + 'sku-purchase').val()) || 0;
            const excl = incl / (1 + gst / 100);
            $(prefix + 'sku-purchase-excl').val(excl.toFixed(2));
        } else if (triggerField === 'excl_selling') {
            const excl = parseFloat($(prefix + 'sku-selling').val()) || 0;
            const incl = excl * (1 + gst / 100);
            $(prefix + 'sku-selling-incl').val(incl.toFixed(2));
        } else if (triggerField === 'incl_selling') {
            const incl = parseFloat($(prefix + 'sku-selling-incl').val()) || 0;
            const excl = incl / (1 + gst / 100);
            $(prefix + 'sku-selling').val(excl.toFixed(2));
        } else if (triggerField === 'gst') {
            const exclPurch = parseFloat($(prefix + 'sku-purchase-excl').val()) || 0;
            const inclPurch = exclPurch * (1 + gst / 100);
            $(prefix + 'sku-purchase').val(inclPurch.toFixed(2));
            
            const exclSell = parseFloat($(prefix + 'sku-selling').val()) || 0;
            const inclSell = exclSell * (1 + gst / 100);
            $(prefix + 'sku-selling-incl').val(inclSell.toFixed(2));
        }
    }

    $(document).on('input', '#sku-purchase-excl', function() { calculateSkuPrices('add', 'excl_purchase'); });
    $(document).on('input', '#sku-purchase', function() { calculateSkuPrices('add', 'incl_purchase'); });
    $(document).on('input', '#sku-selling', function() { calculateSkuPrices('add', 'excl_selling'); });
    $(document).on('input', '#sku-selling-incl', function() { calculateSkuPrices('add', 'incl_selling'); });
    $(document).on('input', '#sku-gst', function() { calculateSkuPrices('add', 'gst'); });

    $(document).on('input', '#edit-sku-purchase-excl', function() { calculateSkuPrices('edit', 'excl_purchase'); });
    $(document).on('input', '#edit-sku-purchase', function() { calculateSkuPrices('edit', 'incl_purchase'); });
    $(document).on('input', '#edit-sku-selling', function() { calculateSkuPrices('edit', 'excl_selling'); });
    $(document).on('input', '#edit-sku-selling-incl', function() { calculateSkuPrices('edit', 'incl_selling'); });
    $(document).on('input', '#edit-sku-gst', function() { calculateSkuPrices('edit', 'gst'); });

    // ----------------------------------------------------
    // INVENTORY CONTROLLER
    // ----------------------------------------------------
    function loadInventory() {
        loadInventorySkusTable();
        loadInventoryHistory();
    }

    function loadInventorySkusTable() {
        safeDestroyTable('#inventory-skus-table');
        $.get('api/skus.php?action=list', function (res) {
            if (res.status === 'success') {
                const rows = $('#inventory-skus-rows');
                rows.empty();
                res.data.forEach(item => {
                    let badgeClass = 'success';
                    let badgeText = 'In Stock';
                    const current = parseInt(item.current_stock);
                    const min = parseInt(item.minimum_stock);
                    if (current <= 0) {
                        badgeClass = 'danger';
                        badgeText = 'Out of Stock';
                    } else if (current <= min) {
                        badgeClass = 'warning text-dark';
                        badgeText = 'Low Stock';
                    }
                    const badge = `<span class="badge bg-${badgeClass}">${badgeText}</span>`;
                    
                    rows.append(`
                        <tr>
                            <td><code>${item.sku_code}</code></td>
                            <td><strong>${item.sku_name}</strong></td>
                            <td>${item.product_name || 'N/A'}</td>
                            <td>${item.brand_name || 'N/A'}</td>
                            <td class="text-end">${formatRupees(item.purchase_price)}</td>
                            <td class="text-end">${formatRupees(item.selling_price)}</td>
                            <td class="text-center text-secondary">${item.minimum_stock}</td>
                            <td class="text-center fw-bold">${item.current_stock}</td>
                            <td>${badge}</td>
                        </tr>
                    `);
                });
                datatables['inv_skus'] = $('#inventory-skus-table').DataTable({
                    order: [],
                        pageLength: 10,
                    ordering: true,
                    destroy: true,
                    stateSave: true
                });
            }
        });
    }

    function loadInventoryHistory() {
        safeDestroyTable('#inventory-history-table');
        $.get('api/inventory.php?action=history', function (res) {
            if (res.status === 'success') {
                const rows = $('#inventory-history-rows');
                rows.empty();
                res.data.forEach(item => {
                    let transColor = 'badge-custom primary';
                    if (item.transaction_type.includes('Adjustment') || item.transaction_type.includes('Reduction')) {
                        transColor = 'badge-custom danger';
                    }
                    if (item.transaction_type.includes('Supplier Purchase') || item.transaction_type.includes('Addition') || item.transaction_type.includes('Purchase Entry')) {
                        transColor = 'badge-custom success';
                    }
                    
                    rows.append(`
                        <tr>
                            <td>${item.created_at}</td>
                            <td><code>${item.sku_code}</code></td>
                            <td><strong>${item.sku_name}</strong></td>
                            <td><span class="${transColor}">${item.transaction_type}</span></td>
                            <td class="text-end fw-bold">${item.quantity}</td>
                            <td class="text-end text-secondary">${item.previous_stock}</td>
                            <td class="text-end text-success">${item.new_stock}</td>
                            <td><span class="small text-white-50">${item.remarks || ''}</span></td>
                        </tr>
                    `);
                });
                datatables['inv_history'] = $('#inventory-history-table').DataTable({
                    order: [],
                        pageLength: 10,
                    ordering: false,
                    destroy: true,
                    stateSave: true
                });
            }
        });
    }

    // Low Stock Alert button handler
    $(document).on('click', '#btn-low-stock-alert', function () {
        safeDestroyTable('#modal-low-stock-table');
        $.get('api/inventory.php?action=low_stock', function (res) {
            if (res.status === 'success') {
                const rows = $('#modal-low-stock-rows');
                rows.empty();
                res.data.forEach(item => {
                    rows.append(`
                        <tr>
                            <td><code>${item.sku_code}</code></td>
                            <td><strong>${item.sku_name}</strong></td>
                            <td>${item.brand_name || 'N/A'}</td>
                            <td class="text-center text-danger fw-bold">${item.current_stock}</td>
                            <td class="text-center text-secondary">${item.minimum_stock}</td>
                            <td><span class="badge bg-danger">Critical Refill</span></td>
                        </tr>
                    `);
                });
                
                $('#lowStockModal').modal('show');
                
                if (res.data.length > 0) {
                    datatables['modal_low_stock'] = $('#modal-low-stock-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: false
                    });
                } else {
                    rows.append('<tr><td colspan="6" class="text-center text-success py-4"><i class="fas fa-check-circle me-1"></i> Excellent! All stock levels are sufficient.</td></tr>');
                }
            }
        });
    });

    // Supplier Purchase Entry Form Row addition/removal
    $(document).on('click', '#add-purchase-row-btn', function () {
        const container = $('#purchase-items-container');
        const firstRow = container.find('.purchase-item-row').first().clone();
        firstRow.find('input').val('');
        firstRow.find('select').val('');
        container.append(firstRow);
    });

    $(document).on('click', '.remove-pur-item', function () {
        if ($('.purchase-item-row').length > 1) {
            $(this).closest('.purchase-item-row').remove();
        } else {
            showToast('warning', 'Purchase entry requires at least one item.');
        }
    });

    $(document).on('submit', '#purchase-entry-form', function (e) {
        e.preventDefault();
        const id = $('#purchase-id').val();
        const actionUrl = id ? 'api/inventory.php?action=purchase_update' : 'api/inventory.php?action=purchase';
        
        $.post(actionUrl, $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#purchaseModal').modal('hide');
                    $('#purchase-id').val('');
                    $('#purchase-entry-form')[0].reset();
                    $('#purchase-items-container').find('.purchase-item-row:not(:first)').remove();
                    
                    // Clear first row inputs
                    const firstRow = $('#purchase-items-container').find('.purchase-item-row').first();
                    firstRow.find('input').val('');
                    firstRow.find('select').val('').trigger('change');
                    
                    if ($('#inventory-history-table').length) {
                        loadInventory();
                    } else {
                        loadPurchaseEntry();
                    }
                } else {
                    showToast('error', res.message);
                }
            });
    });

    function loadPurchaseEntry() {
        loadSuppliersList();
        loadPurchaseHistoryList();
        populateDropdown('api/brands.php?action=list', '#filter-category', '-- Choose Category --', 'id', 'name');
        populateDropdown('api/skus.php?action=list', '.purchase-sku-select', '-- Select Item SKU --', 'id', 'sku_name');
        
        // Reset quick filters
        $('#filter-product').empty().append('<option value="">-- Choose Category First --</option>').prop('disabled', true);
        $('#filter-sku').empty().append('<option value="">-- Choose Product First --</option>').prop('disabled', true);
        $('#filter-qty').val(1);
    }

    function loadPurchaseHistoryList() {
        safeDestroyTable('#purchase-history-table');
        $.get('api/inventory.php?action=purchases_list')
            .done(function (res) {
                if (res.status === 'success') {
                    const tbody = $('#purchase-history-body');
                    tbody.empty();
                    
                    res.data.forEach(function (pur) {
                        const sub = parseFloat(pur.subtotal) || 0;
                        const disc = parseFloat(pur.discount_amount) || 0;
                        const gst = parseFloat(pur.gst_amount) || 0;
                        const grand = parseFloat(pur.grand_total) || 0;
                        
                        tbody.append(`
                            <tr>
                                <td>${formatDate(pur.purchase_date)}</td>
                                <td><span class="badge bg-secondary px-2">${pur.supplier_invoice}</span></td>
                                <td><strong>${pur.supplier_name}</strong></td>
                                <td class="text-end font-monospace">${formatRupees(sub)}</td>
                                <td class="text-end font-monospace text-danger">${formatRupees(disc)}</td>
                                <td class="text-end font-monospace text-warning">${formatRupees(gst)}</td>
                                <td class="text-end font-monospace text-success">${formatRupees(grand)}</td>
                                <td><span class="small text-white-50">${pur.remarks || 'N/A'}</span></td>
                                <td class="text-end">
                                    <button type="button" class="btn btn-sm btn-action primary btn-view-purchase" data-id="${pur.id}" title="View Items"><i class="fas fa-eye"></i></button>
                                    <button type="button" class="btn btn-sm btn-info btn-edit-purchase" data-id="${pur.id}" title="Edit Purchase"><i class="fas fa-edit text-dark"></i></button>
                                    <button type="button" class="btn btn-sm btn-danger btn-delete-purchase" data-id="${pur.id}" title="Delete Purchase"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                        `);
                    });
                    
                    if (res.data.length > 0) {
                        datatables['purchase-history'] = $('#purchase-history-table').DataTable({
                            order: [],
                        pageLength: 10,
                            ordering: true,
                            destroy: true,
                            stateSave: true,
                            order: [[0, 'desc']] // sort by date descending
                        });
                    }
                }
            });
    }

    $(document).on('click', '.btn-view-purchase', function (e) {
        e.preventDefault();
        const id = $(this).data('id');
        $.get('api/inventory.php?action=purchase_detail&id=' + id)
            .done(function (res) {
                if (res.status === 'success') {
                    const pur = res.data;
                    $('#detail-pur-supplier').text(pur.supplier_name);
                    $('#detail-pur-invoice').text(pur.supplier_invoice);
                    $('#detail-pur-date').text(formatDate(pur.purchase_date));
                    $('#detail-pur-remarks').text(pur.remarks || 'No remarks provided.');
                    
                    const tbody = $('#detail-pur-items-body');
                    tbody.empty();
                    
                    let totalSubtotal = 0;
                    let totalDiscount = 0;
                    let totalGst = 0;
                    let totalGrand = 0;
                    
                    pur.items.forEach(function (item) {
                        const qty = parseInt(item.quantity) || 0;
                        const price = parseFloat(item.purchase_price) || 0;
                        const gstPct = parseFloat(item.gst_percentage) || 0;
                        
                        const itemSubtotal = qty * price;
                        const itemDisc = parseFloat(item.discount_amount) || 0;
                        const itemGst = parseFloat(item.gst_amount) || 0;
                        const itemTotal = parseFloat(item.total_amount) || 0;
                        
                        totalSubtotal += itemSubtotal;
                        totalDiscount += itemDisc;
                        totalGst += itemGst;
                        totalGrand += itemTotal;
                        
                        tbody.append(`
                            <tr>
                                <td><strong>${item.sku_name}</strong></td>
                                <td><span class="small font-monospace text-white-50">${item.sku_code}</span></td>
                                <td class="text-end">${qty}</td>
                                <td class="text-end font-monospace">${formatRupees(price)}</td>
                                <td class="text-end font-monospace text-danger">${formatRupees(itemDisc)}</td>
                                <td class="text-center font-monospace">${gstPct}%</td>
                                <td class="text-end font-monospace text-warning">${formatRupees(itemGst)}</td>
                                <td class="text-end font-monospace text-success">${formatRupees(itemTotal)}</td>
                            </tr>
                        `);
                    });
                    
                    $('#detail-pur-total-subtotal').text(formatRupees(totalSubtotal));
                    $('#detail-pur-total-discount').text(formatRupees(totalDiscount));
                    $('#detail-pur-total-gst').text(formatRupees(totalGst));
                    $('#detail-pur-total-grand').text(formatRupees(totalGrand));
                    
                    $('#purchaseDetailsModal').modal('show');
                } else {
                    showToast('error', res.message);
                }
            });
    });

    $(document).on('click', '#btn-add-purchase', function () {
        $('#purchase-id').val('');
        $('#purchase-entry-form')[0].reset();
        $('#filter-discount').val('0.00');
        $('#purchase-items-container').find('.purchase-item-row:not(:first)').remove();
        
        // Clear first row inputs
        const firstRow = $('#purchase-items-container').find('.purchase-item-row').first();
        firstRow.find('input').val('');
        firstRow.find('select').val('').trigger('change');
        
        // Reset quick filters
        $('#filter-category').val('').trigger('change');
        $('#filter-qty').val(1);
    });

    // Edit Purchase Entry click handler
    $(document).on('click', '.btn-edit-purchase', function () {
        const id = $(this).data('id');
        $.get('api/skus.php?action=list')
            .done(function (skuRes) {
                if (skuRes.status === 'success') {
                    let optionsHtml = '<option value="">-- Select Item SKU --</option>';
                    skuRes.data.forEach(function (sku) {
                        optionsHtml += `<option value="${sku.id}">${sku.sku_name}</option>`;
                    });
                    
                    $.get('api/inventory.php?action=purchase_detail&id=' + id)
                        .done(function (res) {
                            if (res.status === 'success') {
                                const pur = res.data;
                                $('#purchase-id').val(pur.id);
                                $('#pur-supplier-id').val(pur.supplier_name);
                                $('#pur-invoice').val(pur.supplier_invoice);
                                $('#pur-date').val(pur.purchase_date);
                                $('#pur-remarks').val(pur.remarks);
                                
                                // Clear existing item rows
                                $('#purchase-items-container').empty();
                                
                                // Populate items
                                pur.items.forEach(function (item) {
                                    const row = $(`
                                        <div class="row mb-2 purchase-item-row align-items-end">
                                            <div class="col-md-5">
                                                <label class="form-label-custom">Select SKU Item</label>
                                                <select class="form-select form-control-custom purchase-sku-select" name="sku_ids[]" required>
                                                    ${optionsHtml}
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label-custom">Recd Quantity</label>
                                                <input type="number" class="form-control form-control-custom" name="quantities[]" min="1" required placeholder="Qty" value="${item.quantity}">
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label-custom">Discount (₹)</label>
                                                <input type="number" step="0.01" class="form-control form-control-custom" name="discounts[]" min="0" placeholder="0.00" value="${item.discount_amount}">
                                            </div>
                                            <div class="col-md-1 text-end">
                                                <button type="button" class="btn btn-danger btn-sm mb-1 remove-pur-item"><i class="fas fa-trash"></i></button>
                                            </div>
                                        </div>
                                    `);
                                    
                                    row.find('.purchase-sku-select').val(item.sku_id);
                                    $('#purchase-items-container').append(row);
                                });
                                
                                $('#purchaseModalLabel').html('<i class="fas fa-edit text-primary me-2"></i> Edit Purchase Entry');
                                $('#purchaseModal').modal('show');
                            } else {
                                showToast('error', res.message);
                            }
                        });
                } else {
                    showToast('error', skuRes.message);
                }
            });
    });

    // Delete Purchase Entry click handler
    $(document).on('click', '.btn-delete-purchase', function () {
        const id = $(this).data('id');
        if (confirm('Are you sure you want to delete this purchase entry? This will subtract/reverse the quantities from the current stock of all items in this purchase.')) {
            $.post('api/inventory.php?action=purchase_delete', { id: id })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadPurchaseHistoryList();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    function loadSuppliers() {
        safeDestroyTable('#suppliers-table');
        loadSuppliersList();
    }

    function loadSuppliersList() {
        safeDestroyTable('#suppliers-table');
        $.get('api/suppliers.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    // Populate Table
                    const tbody = $('#suppliers-list-body');
                    if (tbody.length) {
                        tbody.empty();
                    }
                    
                    // Populate Select Dropdown
                    const select = $('#pur-supplier-id');
                    if (select.length) {
                        select.empty().append('<option value="">-- Select Supplier --</option>');
                    }
                    
                    res.data.forEach(function (sup) {
                        // Table row
                        if (tbody.length) {
                            tbody.append(`
                                <tr>
                                    <td><strong>${sup.name}</strong></td>
                                    <td>${sup.gst_number || '<span class="text-muted">N/A</span>'}</td>
                                    <td>${sup.fssai_license || '<span class="text-muted">N/A</span>'}</td>
                                    <td>${sup.address || '<span class="text-muted">N/A</span>'}</td>
                                    <td class="text-end">
                                        <button type="button" class="btn btn-sm btn-action primary btn-edit-supplier" data-id="${sup.id}"><i class="fas fa-edit"></i></button>
                                        <button type="button" class="btn btn-sm btn-danger btn-delete-supplier" data-id="${sup.id}"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            `);
                        }
                        
                        // Select option
                        if (select.length) {
                            select.append(`<option value="${sup.name}">${sup.name}</option>`);
                        }
                    });

                    if (res.data.length > 0 && $('#suppliers-table').length) {
                        datatables['suppliers'] = $('#suppliers-table').DataTable({
                            order: [],
                        pageLength: 10,
                            ordering: true,
                            destroy: true,
                            stateSave: true
                        });
                    }
                }
            });
    }

    // Add/Edit Supplier Form Submission
    $(document).on('submit', '#supplier-form', function (e) {
        e.preventDefault();
        const id = $('#supplier-id').val();
        const actionUrl = id ? 'api/suppliers.php?action=update' : 'api/suppliers.php?action=create';
        
        $.post(actionUrl, $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#supplierModal').modal('hide');
                    $('#supplier-form')[0].reset();
                    $('#supplier-id').val('');
                    loadSuppliersList();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // Reset Form when Add button clicked
    $(document).on('click', '#btn-add-supplier', function () {
        $('#supplier-form')[0].reset();
        $('#supplier-id').val('');
        $('#supplierModalLabel').html('<i class="fas fa-truck text-primary me-2"></i> Add New Supplier');
    });

    // Edit Supplier click handler
    $(document).on('click', '.btn-edit-supplier', function () {
        const id = $(this).data('id');
        $.get('api/suppliers.php?action=detail&id=' + id)
            .done(function (res) {
                if (res.status === 'success') {
                    const sup = res.data;
                    $('#supplier-id').val(sup.id);
                    $('#sup-name').val(sup.name);
                    $('#sup-gst').val(sup.gst_number);
                    $('#sup-address').val(sup.address);
                    $('#sup-fssai').val(sup.fssai_license);
                    
                    $('#supplierModalLabel').html('<i class="fas fa-edit text-primary me-2"></i> Edit Supplier');
                    $('#supplierModal').modal('show');
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // Delete Supplier click handler
    $(document).on('click', '.btn-delete-supplier', function () {
        const id = $(this).data('id');
        if (confirm('Are you sure you want to delete this supplier?')) {
            $.post('api/suppliers.php?action=delete', { id: id })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadSuppliersList();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    // Quick selection dependent dropdowns
    let allProducts = [];
    let allSkus = [];

    $(document).on('change', '#filter-category', function () {
        const catId = $(this).val();
        const prodSelect = $('#filter-product');
        const skuSelect = $('#filter-sku');
        
        prodSelect.empty().append('<option value="">-- Choose Product --</option>').prop('disabled', true);
        skuSelect.empty().append('<option value="">-- Choose Product First --</option>').prop('disabled', true);
        
        if (!catId) return;
        
        // Fetch products or use cached
        $.get('api/products.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    allProducts = res.data;
                    const filtered = allProducts.filter(p => parseInt(p.brand_id) === parseInt(catId));
                    prodSelect.empty().append('<option value="">-- Choose Product --</option>');
                    if (filtered.length > 0) {
                        filtered.forEach(p => {
                            prodSelect.append(`<option value="${p.id}">${p.name}</option>`);
                        });
                        prodSelect.prop('disabled', false);
                    } else {
                        prodSelect.append('<option value="">No products found in this category</option>');
                    }
                }
            });
    });

    $(document).on('change', '#filter-product', function () {
        const prodId = $(this).val();
        const skuSelect = $('#filter-sku');
        
        skuSelect.empty().append('<option value="">-- Choose SKU Item --</option>').prop('disabled', true);
        
        if (!prodId) return;
        
        // Fetch SKUs
        $.get('api/skus.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    allSkus = res.data;
                    const filtered = allSkus.filter(s => parseInt(s.product_id) === parseInt(prodId));
                    skuSelect.empty().append('<option value="">-- Choose SKU Item --</option>');
                    if (filtered.length > 0) {
                        filtered.forEach(s => {
                            skuSelect.append(`<option value="${s.id}">${s.sku_name} (${s.sku_code})</option>`);
                        });
                        skuSelect.prop('disabled', false);
                    } else {
                        skuSelect.append('<option value="">No SKUs found for this product</option>');
                    }
                }
            });
    });

    // Quick Add to items list
    $(document).on('click', '#btn-quick-add-sku', function () {
        const skuId = $('#filter-sku').val();
        const qty = parseInt($('#filter-qty').val()) || 1;
        const disc = parseFloat($('#filter-discount').val()) || 0.00;
        if (!skuId) {
            showToast('warning', 'Please select a SKU item to add.');
            return;
        }
        
        const container = $('#purchase-items-container');
        const firstRow = container.find('.purchase-item-row').first();
        
        // If there's only one row and its SKU is empty, populate it
        if (container.find('.purchase-item-row').length === 1 && !firstRow.find('.purchase-sku-select').val()) {
            firstRow.find('.purchase-sku-select').val(skuId).trigger('change');
            firstRow.find('input[name="quantities[]"]').val(qty);
            firstRow.find('input[name="discounts[]"]').val(disc);
        } else {
            // Otherwise, clone and append
            const newRow = firstRow.clone();
            newRow.find('.purchase-sku-select').val(skuId);
            newRow.find('input[name="quantities[]"]').val(qty);
            newRow.find('input[name="discounts[]"]').val(disc);
            container.append(newRow);
        }
        
        // Reset quick selection quantity to 1
        $('#filter-qty').val(1);
        showToast('success', 'Item added to purchase list.');
    });

    // ----------------------------------------------------
    // RETAILER CONTROLLER
    // ----------------------------------------------------
    function loadRetailers() {
        safeDestroyTable('#retailers-table');
        $.get('api/retailers.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#retailers-rows');
                    rows.empty();
                    const isOwner = window.userRole === 'Owner';
                    res.data.forEach(item => {
                        let badge = item.status === 'Active' ? '<span class="badge-custom success">Active</span>' : '<span class="badge-custom danger">Inactive</span>';
                        let outColor = 'text-white';
                        if (parseFloat(item.outstanding_amount) >= parseFloat(item.credit_limit)) {
                            outColor = 'text-danger fw-bold';
                        }
                        
                        rows.append(`
                            <tr>
                                <td><strong>${item.shop_name}</strong><br><span class="small text-secondary">${item.business_type}</span></td>
                                <td><strong>${item.name}</strong><br><span class="small text-secondary">${item.area}, ${item.city}</span></td>
                                <td>${item.mobile}</td>
                                <td><code>${item.gst_number || 'URP'}</code></td>
                                <td class="text-end text-secondary">${formatRupees(item.credit_limit)}</td>
                                <td class="text-end ${outColor}">${formatRupees(item.outstanding_amount)}</td>
                                <td>
                                    <span class="small text-white d-block fw-bold">${item.route_name || 'No Route'}</span>
                                    <span class="small text-white-50">${item.staff_names || 'No Staff Assigned'}</span>
                                </td>
                                <td><span class="small">${item.visit_frequency}</span></td>
                                <td>${badge}</td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-warning edit-retailer-btn" data-id="${item.id}" title="Edit"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-sm btn-outline-danger delete-retailer-btn" data-id="${item.id}" title="Delete"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                        `);
                    });
                    
                    datatables['retailers'] = $('#retailers-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
            
        // Load Staff selector in forms (Owner Only check is done in backend API response/form rendering)
        populateDropdown('api/staff.php?action=list', '#ret-staff', '-- Choose Staff --', 'id', 'fullname');
        populateDropdown('api/staff.php?action=list', '#edit-ret-staff', '-- Choose Staff --', 'id', 'fullname');
        populateDropdown('api/beatroute.php?action=my_routes', '#ret-beat-route', '-- Choose Beat Route --', 'id', 'route_name');
        populateDropdown('api/beatroute.php?action=my_routes', '#edit-ret-beat-route', '-- Choose Beat Route --', 'id', 'route_name');
        populateDropdown('api/beatroute.php?action=my_routes', '#manage-routes-route-select', '-- No Route --', 'id', 'route_name');
    }

    $(document).on('submit', '#add-retailer-form', function (e) {
        e.preventDefault();
        $.post('api/retailers.php?action=create', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#addRetailerModal').modal('hide');
                    $('#add-retailer-form')[0].reset();
                    loadRetailers();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    $(document).on('click', '.edit-retailer-btn', function () {
        const id = $(this).data('id');
        $.get(`api/retailers.php?action=detail&id=${id}`, function (res) {
            if (res.status === 'success') {
                const r = res.data;
                $('#edit-ret-id').val(r.id);
                $('#edit-ret-shop-name').val(r.shop_name);
                $('#edit-ret-name').val(r.name);
                $('#edit-ret-business-type').val(r.business_type);
                $('#edit-ret-gst').val(r.gst_number);
                $('#edit-ret-visit').val(r.visit_frequency);
                $('#edit-ret-mobile').val(r.mobile);
                $('#edit-ret-alt-mobile').val(r.alternate_mobile);
                $('#edit-ret-email').val(r.email);
                $('#edit-ret-area').val(r.area);
                $('#edit-ret-city').val(r.city);
                $('#edit-ret-pin').val(r.pin_code);
                $('#edit-ret-gmap').val(r.google_map_link);
                $('#edit-ret-address').val(r.address);
                $('#edit-ret-credit-limit').val(r.credit_limit);
                $('#edit-ret-staff').val(r.assigned_staff_id);
                $('#edit-ret-beat-route').val(r.route_id || '');
                $('#edit-ret-status').val(r.status);
                $('#edit-ret-remarks').val(r.remarks);
                
                $('#editRetailerModal').modal('show');
            }
        });
    });

    $(document).on('submit', '#edit-retailer-form', function (e) {
        e.preventDefault();
        $.post('api/retailers.php?action=update', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#editRetailerModal').modal('hide');
                    loadRetailers();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    $(document).on('click', '.delete-retailer-btn', function () {
        const id = $(this).data('id');
        if (confirm('Delete retailer record? Linked ledgers and histories will remain locked.')) {
            $.post('api/retailers.php?action=delete', { id })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadRetailers();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    $(document).on('click', '.manage-routes-btn', function () {
        const id = $(this).data('id');
        const name = $(this).data('name');
        $('#manage-routes-retailer-id').val(id);
        $('#manage-routes-shop-name').text(name);

        // Load current route assignment
        $.get(`api/retailers.php?action=detail&id=${id}`, function (res) {
            if (res.status === 'success') {
                $('#manage-routes-route-select').val(res.data.route_id || '');
            }
        });

        $('#manageRoutesModal').modal('show');
    });

    $(document).on('submit', '#manage-routes-form', function (e) {
        e.preventDefault();
        const id = $('#manage-routes-retailer-id').val();
        const route_id = $('#manage-routes-route-select').val();
        $.post('api/retailers.php?action=assign_route', { id, route_id })
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message || 'Route updated successfully.');
                    $('#manageRoutesModal').modal('hide');
                    loadRetailers();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // visit logger triggers browser geolocation API automatically!
    $(document).on('click', '.log-visit-btn', function () {
        const id = $(this).data('id');
        const name = $(this).data('name');
        
        $('#visit-retailer-id').val(id);
        $('#visit-shop-name-display').val(name);
        $('#visit-remarks').val('');
        
        // Reset GPS elements
        $('#visit-lat').val('');
        $('#visit-lng').val('');
        $('#gps-status-area').html('<span class="text-warning small"><i class="fas fa-spinner fa-spin"></i> Reading GPS coordinates...</span>');
        
        $('#logVisitModal').modal('show');
        
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function (position) {
                    const lat = position.coords.latitude;
                    const lng = position.coords.longitude;
                    $('#visit-lat').val(lat);
                    $('#visit-lng').val(lng);
                    $('#gps-status-area').html(`<span class="text-success small"><i class="fas fa-check-circle"></i> Location Captured: ${lat.toFixed(5)}, ${lng.toFixed(5)}</span>`);
                },
                function (error) {
                    $('#gps-status-area').html('<span class="text-danger small"><i class="fas fa-exclamation-triangle"></i> Location permission denied. Continuing with manual logs.</span>');
                },
                { timeout: 8000 }
            );
        } else {
            $('#gps-status-area').html('<span class="text-danger small"><i class="fas fa-exclamation-triangle"></i> Geolocation is not supported by your browser.</span>');
        }
    });

    $(document).on('submit', '#log-visit-form', function (e) {
        e.preventDefault();
        $.post('api/retailers.php?action=log_visit', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#logVisitModal').modal('hide');
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // View detailed offcanvas timeline audit logs
    $(document).on('click', '.view-retailer-timeline-btn', function () {
        const id = $(this).data('id');
        const container = $('#retailer-timeline-content');
        container.html('<div class="text-center py-5"><div class="spinner-border text-primary"></div></div>');
        
        const myOffcanvas = new bootstrap.Offcanvas(document.getElementById('retailerTimelineDrawer'));
        myOffcanvas.show();
        
        $.get(`api/retailers.php?action=timeline&id=${id}`, function (res) {
            if (res.status === 'success') {
                const data = res.data;
                const ret = data.retailer;
                const timeline = data.timeline;
                
                let html = `
                    <div class="mb-4 pb-3 border-bottom border-secondary">
                        <h4 class="fw-bold mb-1">${ret.shop_name}</h4>
                        <p class="text-secondary mb-3">${ret.name} | ${ret.mobile}</p>
                        
                        <div class="row g-2 text-center text-white small">
                            <div class="col-6">
                                <div class="p-2 bg-secondary bg-opacity-20 border border-secondary rounded">
                                    <div class="text-secondary small">Outstanding:</div>
                                    <div class="fw-bold fs-6 text-warning">${formatRupees(ret.outstanding_amount)}</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="p-2 bg-secondary bg-opacity-20 border border-secondary rounded">
                                    <div class="text-secondary small">Credit Limit:</div>
                                    <div class="fw-bold fs-6 text-info">${formatRupees(ret.credit_limit)}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <h6 class="fw-bold text-info mb-3"><i class="fas fa-route"></i> Visit &amp; Activity timeline</h6>
                `;
                
                if (timeline.length === 0) {
                    html += '<p class="text-secondary small text-center py-4">No activities logged yet.</p>';
                } else {
                    html += '<div class="timeline-list">';
                    timeline.forEach(item => {
                        let markerColor = 'info';
                        if (item.visit_status.includes('Order')) markerColor = 'success';
                        if (item.visit_status.includes('Payment')) markerColor = 'warning';
                        if (item.visit_status.includes('Closed')) markerColor = 'danger';
                        
                        let gpsLabel = '';
                        if (item.latitude && item.longitude) {
                            gpsLabel = `<br><a href="https://maps.google.com/?q=${item.latitude},${item.longitude}" target="_blank" class="small text-info text-decoration-none"><i class="fas fa-map-pin"></i> GPS coordinates (${parseFloat(item.latitude).toFixed(4)}, ${parseFloat(item.longitude).toFixed(4)})</a>`;
                        }
                        
                        html += `
                            <div class="timeline-item ${markerColor}">
                                <div class="timeline-marker"></div>
                                <div class="timeline-time">${item.visit_date}</div>
                                <div class="timeline-title text-white">${item.visit_status}</div>
                                <div class="timeline-desc text-secondary">${item.remarks}${gpsLabel}<br><span class="small text-muted">Log by: ${item.staff_name}</span></div>
                            </div>
                        `;
                    });
                    html += '</div>';
                }
                
                container.html(html);
            }
        });
    });

    // ----------------------------------------------------
    // SALES STAFF CONTROLLER
    // ----------------------------------------------------
    function loadStaff() {
        safeDestroyTable('#staff-table');
        $.get('api/staff.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#staff-rows');
                    rows.empty();
                    res.data.forEach(item => {
                        const img = item.photo ? `<img src="${item.photo}" style="width: 45px; height: 45px; object-fit: cover; border-radius: 50%; border: 2px solid var(--accent);">` : `<img src="assets/images/default-avatar.png" style="width: 45px; height: 45px; border-radius: 50%;">`;
                        let badge = item.status === 'Active' ? '<span class="badge-custom success">Active</span>' : '<span class="badge-custom danger">Inactive</span>';
                        const routeBadges = item.route_names
                            ? item.route_names.split(', ').map(r => `<span class="badge bg-secondary me-1">${r}</span>`).join('')
                            : '<span class="text-secondary small">No routes</span>';
                        
                        rows.append(`
                            <tr>
                                <td>${item.id}</td>
                                <td>${img}</td>
                                <td><strong>${item.fullname}</strong><br><span class="small text-secondary">Username: ${item.username} | Mobile: ${item.mobile}</span></td>
                                <td>${routeBadges}</td>
                                <td class="text-end">${formatRupees(item.salary)}</td>
                                <td class="text-end fw-bold text-success">${formatRupees(item.sales_target)}</td>
                                <td>${item.joining_date}</td>
                                <td>${badge}</td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-info view-staff-logs-btn" data-id="${item.id}" data-name="${item.fullname}" title="Activity Logs"><i class="fas fa-file-invoice"></i></button>
                                    <button class="btn btn-sm btn-outline-primary edit-staff-btn" data-id="${item.id}" title="Edit"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-sm btn-outline-danger delete-staff-btn" data-id="${item.id}" title="Delete"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                        `);
                    });
                    datatables['staff'] = $('#staff-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
            
        populateDropdown('api/beatroute.php?action=routes_list', '#manage-routes-route-select', '-- No Route --', 'id', 'route_name');
    }

    function initRouteMultiSelect(listId, hiddenId, btnId, searchId, selectedIds) {
        selectedIds = (selectedIds || []).map(String);
        let allRoutes = [];

        function renderLabel() {
            const checked = $(`#${hiddenId} input[type=hidden]`).map(function(){ return $(this).next ? null : this.value; }).get();
            // count checked boxes
            const count = $(`#${listId} .route-check-item input:checked`).length;
            const btn = $(`#${btnId}`);
            if (count === 0) {
                btn.removeClass('has-selection').find('.route-multiselect-label').text('Select routes...');
            } else {
                const names = [];
                $(`#${listId} .route-check-item input:checked`).each(function(){ names.push($(this).data('name')); });
                btn.addClass('has-selection').find('.route-multiselect-label').text(names.join(', '));
            }
        }

        function rebuildHidden() {
            $(`#${hiddenId}`).empty();
            $(`#${listId} .route-check-item input:checked`).each(function(){
                $(`#${hiddenId}`).append(`<input type="hidden" name="route_ids[]" value="${$(this).val()}">`);
            });
        }

        function renderList(routes, filter) {
            const $list = $(`#${listId}`);
            $list.empty();
            const filtered = routes.filter(r => !filter || r.route_name.toLowerCase().includes(filter.toLowerCase()));
            if (filtered.length === 0) {
                $list.html('<div class="no-routes">No routes found.</div>');
                return;
            }
            filtered.forEach(function(r) {
                const isChecked = selectedIds.includes(String(r.id));
                const item = $(`
                    <label class="route-check-item ${isChecked ? 'checked' : ''}">
                        <input type="checkbox" value="${r.id}" data-name="${r.route_name}" ${isChecked ? 'checked' : ''}>
                        ${r.route_name}
                    </label>
                `);
                item.find('input').on('change', function(){
                    item.toggleClass('checked', this.checked);
                    // sync selectedIds
                    if (this.checked) {
                        if (!selectedIds.includes(String(r.id))) selectedIds.push(String(r.id));
                    } else {
                        selectedIds = selectedIds.filter(x => x !== String(r.id));
                    }
                    rebuildHidden();
                    renderLabel();
                });
                $list.append(item);
            });
        }

        // Load routes
        $.get('api/beatroute.php?action=routes_list', function(res) {
            allRoutes = (res.status === 'success' && res.data) ? res.data : [];
            renderList(allRoutes, '');
            rebuildHidden();
            renderLabel();
        });

        // Search
        $(`#${searchId}`).off('input').on('input', function(){
            renderList(allRoutes, $(this).val());
        });

        // Toggle open/close
        $(`#${btnId}`).off('click').on('click', function(e){
            e.stopPropagation();
            const $dd = $(`#${btnId}`).siblings('.route-multiselect-dropdown');
            const isOpen = $dd.hasClass('open');
            // close all others
            $('.route-multiselect-dropdown.open').removeClass('open');
            $('.route-multiselect-btn.open').removeClass('open');
            if (!isOpen) {
                $dd.addClass('open');
                $(this).addClass('open');
                $(`#${searchId}`).focus();
            }
        });
    }

    // Close dropdowns on outside click
    $(document).on('click', function(e) {
        if (!$(e.target).closest('.route-multiselect-wrap').length) {
            $('.route-multiselect-dropdown.open').removeClass('open');
            $('.route-multiselect-btn.open').removeClass('open');
        }
    });

    $(document).on('show.bs.modal', '#addStaffModal', function () {
        // reset
        $('#add-routes-hidden').empty();
        initRouteMultiSelect('add-routes-list', 'add-routes-hidden', 'add-routes-btn', 'add-routes-search', []);
    });

    $(document).on('submit', '#add-staff-form', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        $.ajax({
            url: 'api/staff.php?action=create',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#addStaffModal').modal('hide');
                    $('#add-staff-form')[0].reset();
                    $('#add-routes-hidden').empty();
                    $('#add-routes-btn').removeClass('has-selection').find('.route-multiselect-label').text('Select routes...');
                    loadStaff();
                } else {
                    showToast('error', res.message);
                }
            }
        });
    });

    $(document).on('click', '.edit-staff-btn', function () {
        const id = $(this).data('id');
        $.get(`api/staff.php?action=detail&id=${id}`, function (res) {
            if (res.status === 'success') {
                const s = res.data;
                $('#edit-staff-id').val(s.id);
                $('#edit-staff-username').val(s.username);
                $('#edit-staff-password').val(''); // Keep blank initially
                $('#edit-staff-fullname').val(s.fullname);
                $('#edit-staff-mobile').val(s.mobile);
                $('#edit-staff-email').val(s.email);
                $('#edit-staff-area').val(s.assigned_area);
                initRouteMultiSelect('edit-routes-list', 'edit-routes-hidden', 'edit-routes-btn', 'edit-routes-search', s.assigned_route_ids || []);
                $('#edit-staff-target').val(s.sales_target);
                $('#edit-staff-salary').val(s.salary);
                $('#edit-staff-joining').val(s.joining_date);
                $('#edit-staff-status').val(s.status);
                
                if (s.photo) {
                    $('#current-staff-photo-preview').html(`<img src="${s.photo}" style="height:30px; border-radius:50%;">`);
                } else {
                    $('#current-staff-photo-preview').text('');
                }
                
                $('#editStaffModal').modal('show');
            }
        });
    });

    $(document).on('submit', '#edit-staff-form', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        $.ajax({
            url: 'api/staff.php?action=update',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#editStaffModal').modal('hide');
                    loadStaff();
                } else {
                    showToast('error', res.message);
                }
            }
        });
    });

    $(document).on('click', '.delete-staff-btn', function () {
        const id = $(this).data('id');
        if (confirm('Delete sales staff credentials? Historical orders linked to this profile will remain intact.')) {
            $.post('api/staff.php?action=delete', { id })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadStaff();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    $(document).on('click', '.delete-staff-btn', function () {
        const id = $(this).data('id');
        if (confirm('Delete sales staff credentials? Historical orders linked to this profile will remain intact.')) {
            $.post('api/staff.php?action=delete', { id })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadStaff();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    // View audit activity logs for specific staff
    $(document).on('click', '.view-staff-logs-btn', function () {
        const id = $(this).data('id');
        const name = $(this).data('name');
        const timeline = $('#staff-logs-timeline');
        
        $('#staffLogsTitle').text(`Activity Logs: ${name}`);
        timeline.html('<div class="text-center py-4"><div class="spinner-border text-primary"></div></div>');
        $('#staffLogsModal').modal('show');
        
        $.get(`api/staff.php?action=logs&id=${id}`, function (res) {
            if (res.status === 'success') {
                timeline.empty();
                if (res.data.length === 0) {
                    timeline.append('<p class="text-secondary small text-center py-4">No system activities recorded for this staff.</p>');
                    return;
                }
                res.data.forEach(log => {
                    timeline.append(`
                        <div class="timeline-item info">
                            <div class="timeline-marker"></div>
                            <div class="timeline-time">${log.created_at}</div>
                            <div class="timeline-title text-white">${log.action_name}</div>
                            <div class="timeline-desc text-secondary">${log.action_details}</div>
                        </div>
                    `);
                });
            }
        });
    });

    // ----------------------------------------------------
    // SALES ORDERS CONTROLLER
    // ----------------------------------------------------
    function loadOrders() {
        safeDestroyTable('#orders-table');
        $.get('api/orders.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#orders-rows');
                    rows.empty();
                    res.data.forEach(item => {
                        let badge = '<span class="badge-custom info">Pending</span>';
                        if (item.status === 'Approved') badge = '<span class="badge-custom success">Approved</span>';
                        if (item.status === 'Completed') badge = '<span class="badge bg-success">Completed</span>';
                        if (item.status === 'Cancelled') badge = '<span class="badge-custom danger">Cancelled</span>';
                        if (item.status === 'Processing') badge = '<span class="badge bg-warning text-dark">Processing</span>';
                        
                        rows.append(`
                            <tr>
                                <td>#ORD-${item.id}<br><span class="badge bg-secondary badge-sm mt-1" style="font-size: 0.65rem;">${item.order_mode || 'By Route'}</span></td>
                                <td><strong>${item.shop_name}</strong><br><span class="small text-secondary">${item.retailer_name}</span></td>
                                <td><span class="small">${item.staff_name}</span></td>
                                <td>${item.order_date}</td>
                                <td class="text-end text-secondary">${formatRupees(item.total_amount - item.discount_amount)}</td>
                                <td class="text-end text-secondary">${formatRupees(item.gst_amount)}</td>
                                <td class="text-end fw-bold text-info">${formatRupees(item.grand_total)}</td>
                                <td>${badge}</td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary view-order-details-btn" data-id="${item.id}" title="Review Order"><i class="fas fa-eye"></i> View</button>
                                    ${item.status === 'Pending' && $('#owner-approval-area').length === 0 ? `<button class="btn btn-sm btn-outline-warning ms-1 edit-order-btn" data-id="${item.id}" title="Edit Order"><i class="fas fa-edit"></i> Edit</button>` : ''}
                                </td>
                            </tr>
                        `);
                    });
                    datatables['orders'] = $('#orders-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
    }

    // Cart Management
    $(document).on('click', '#add-to-cart-btn', function () {
        const skuId = $('#cart-sku-select').val();
        const qty = parseInt($('#cart-qty').val());
        const disc = 0.00;
        
        if (!skuId || qty <= 0) {
            showToast('warning', 'Please select a product SKU and specify quantity.');
            return;
        }
        
        const skuObj = currentSkusData.find(s => s.id == skuId);
        if (skuObj) {
            let stock = parseInt(skuObj.current_stock || 0);
            let inCart = 0;
            const existIndex = orderCart.findIndex(item => item.id == skuId);
            if (existIndex > -1) {
                inCart = orderCart[existIndex].quantity;
                if (orderCart[existIndex].original_quantity) stock += orderCart[existIndex].original_quantity;
            }
            
            if (qty > (stock - inCart)) {
                showToast('error', `Insufficient stock. Only ${stock - inCart} left available to add.`);
                return;
            }
        }
        
        // Fetch SKU details to append to local cart
        $.get(`api/skus.php?action=detail&id=${skuId}`, function (res) {
            if (res.status === 'success') {
                const sku = res.data;
                
                // Check if already in cart
                const existIndex = orderCart.findIndex(item => item.id == sku.id);
                if (existIndex > -1) {
                    orderCart[existIndex].quantity += qty;
                } else {
                    orderCart.push({
                        id: sku.id,
                        name: sku.sku_name,
                        code: sku.sku_code,
                        price: parseFloat(sku.selling_price),
                        gst_pct: parseFloat(sku.gst_percentage),
                        quantity: qty,
                        original_quantity: 0,
                        discount: disc,
                        discount_rules: sku.discount_rules || []
                    });
                }
                
                // Update available stock display
                if (skuObj) {
                    let newStock = parseInt(skuObj.current_stock || 0);
                    if (existIndex > -1 && orderCart[existIndex].original_quantity) newStock += orderCart[existIndex].original_quantity;
                    const newInCart = existIndex > -1 ? orderCart[existIndex].quantity : qty;
                    $('#cart-stock-count').val(newStock - newInCart);
                }
                
                // Reset qty
                $('#cart-qty').val('1');
                
                renderOrderCartTable();
            }
        });
    });

    $(document).on('click', '.remove-cart-item', function () {
        const index = $(this).data('index');
        const removedItem = orderCart[index];
        orderCart.splice(index, 1);
        renderOrderCartTable();
        
        // Update stock display if the removed item is currently selected in dropdown
        const selectedSkuId = $('#cart-sku-select').val();
        if (selectedSkuId == removedItem.id) {
            $('#cart-sku-select').trigger('change');
        }
    });

    function renderOrderCartTable() {
        const tbody = $('#cart-rows');
        tbody.empty();
        
        if (orderCart.length === 0) {
            tbody.append('<tr><td colspan="8" class="text-center text-secondary py-4">Your shopping cart is empty. Add items above.</td></tr>');
            $('#summary-gross').text('₹0.00');
            $('#summary-gst').text('₹0.00');
            $('#summary-grand').text('₹0.00');
            return;
        }
        
        let grossTotal = 0;
        let gstTotal = 0;
        let grandTotal = 0;
        
        orderCart.forEach((item, index) => {
            // Calculate best discount
            let bestDiscount = 0;
            if (item.discount_rules && item.discount_rules.length > 0) {
                item.discount_rules.forEach(rule => {
                    const targetRate = parseFloat(rule.discount_value);
                    const deduction = item.price - targetRate;
                    if (deduction > 0) {
                        if (rule.discount_type === 'Flat Rate') {
                            if (deduction > bestDiscount) bestDiscount = deduction;
                        } else if (rule.discount_type === 'Quantity Slab') {
                            const min = parseInt(rule.min_qty);
                            const max = parseInt(rule.max_qty);
                            if (item.quantity >= min && item.quantity <= max) {
                                if (deduction > bestDiscount) bestDiscount = deduction;
                            }
                        }
                    }
                });
                // Update item discount only if rules exist
                item.discount = bestDiscount;
            }
            
            
            const itemPriceAfterDiscount = item.price - item.discount;
            const rowSubtotal = itemPriceAfterDiscount * item.quantity;
            const rowTaxable = rowSubtotal;
            const rowGst = (rowTaxable * item.gst_pct) / 100;
            const rowTotal = rowTaxable + rowGst;
            
            grossTotal += rowSubtotal;
            gstTotal += rowGst;
            grandTotal += rowTotal;
            
            let totalDiscount = item.discount * item.quantity;
            let discountText = item.discount > 0 ? `<span class="text-success fw-bold">-₹${item.discount.toFixed(2)}/pc</span><br><small class="text-success">-₹${totalDiscount.toFixed(2)}</small>` : '<span class="text-secondary">-</span>';
            let rateDisplay = item.discount > 0 
                ? `<del class="text-secondary small me-1">₹${item.price.toFixed(2)}</del>${formatRupees(itemPriceAfterDiscount)}` 
                : formatRupees(item.price);
            
            tbody.append(`
                <tr>
                    <td><strong>${item.name}</strong></td>
                    <td><code>${item.code}</code></td>
                    <td class="text-end fw-bold">${item.quantity}</td>
                    <td class="text-end">${rateDisplay}</td>
                    <td class="text-end">${discountText}</td>
                    <td class="text-end">${item.gst_pct}% <br><small class="text-secondary">(₹${rowGst.toFixed(2)})</small></td>
                    <td class="text-end fw-bold text-info">${formatRupees(rowTotal)}</td>
                    <td class="text-center">
                        <button type="button" class="btn btn-sm btn-danger remove-cart-item" data-index="${index}"><i class="fas fa-times"></i></button>
                    </td>
                </tr>
            `);
        });
        
        $('#summary-gross').text(formatRupees(grossTotal)); // Base/Taxable Value
        $('#summary-gst').text(formatRupees(gstTotal));
        $('#summary-grand').text(formatRupees(grandTotal));
    }

    // Place Order Submission
    $(document).on('submit', '#place-order-form', function (e) {
        e.preventDefault();
        if (orderCart.length === 0) {
            showToast('error', 'Cart is empty. Please add items before submitting.');
            return;
        }
        
        // Compile Cart data to form payload
        const payload = {
            edit_order_id: $('#edit-order-id').val(),
            order_mode: $('#ord-mode').val(),
            retailer_id: $('#ord-retailer').val(),
            order_date: $('#ord-date').val(),
            remarks: $('#ord-remarks').val(),
            sku_ids: orderCart.map(item => item.id),
            quantities: orderCart.map(item => item.quantity),
            discounts: orderCart.map(item => item.discount)
        };
        
        $.post('api/orders.php?action=create', payload)
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    orderCart = [];
                    $('#place-order-form')[0].reset();
                    renderOrderCartTable();
                    
                    // Navigate to orders list
                    window.location.hash = '#orders';
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // View Order details popup
    $(document).on('click', '.view-order-details-btn', function () {
        const id = $(this).data('id');
        $.get(`api/orders.php?action=detail&id=${id}`, function (res) {
            if (res.status === 'success') {
                const o = res.data;
                
                $('#det-order-shop').text(o.shop_name);
                $('#det-order-gst').text(o.gst_number ? `GSTIN: ${o.gst_number}` : 'Unregistered Retailer');
                $('#det-order-staff').text(o.staff_name);
                $('#det-order-date').text(o.order_date);
                $('#det-order-remarks').text(o.remarks || 'None');
                
                $('#det-order-gross').text(formatRupees(o.total_amount));
                $('#det-order-disc').text(`- ${formatRupees(o.discount_amount)}`);
                $('#det-order-gstamt').text(formatRupees(o.gst_amount));
                $('#det-order-grand').text(formatRupees(o.grand_total));
                
                // Populate items
                const tbody = $('#detail-items-rows');
                tbody.empty();
                o.items.forEach(item => {
                    tbody.append(`
                        <tr>
                            <td><strong>${item.sku_name}</strong></td>
                            <td><code>${item.sku_code}</code></td>
                            <td class="text-end fw-bold">${item.quantity}</td>
                            <td class="text-end">${formatRupees(item.price)}</td>
                            <td class="text-end text-success">${formatRupees(item.discount_amount)}</td>
                            <td class="text-end">${item.gst_percentage}%</td>
                            <td class="text-end fw-bold text-info">${formatRupees(item.total_amount)}</td>
                        </tr>
                    `);
                });
                
                // Show owner review decision panel if Owner is active and status is Pending
                if ($('#owner-approval-area').length > 0) {
                    $('#approval-notes').val('');
                    
                    if (o.status === 'Pending') {
                        $('#owner-approval-area').show();
                        $('#owner-invoice-gen-area').hide();
                        
                        // Set data attributes to approval buttons
                        $('#btn-approve-order').data('id', o.id);
                        $('#btn-cancel-order').data('id', o.id);
                    } else if (o.status === 'Approved') {
                        $('#owner-approval-area').hide();
                        $('#owner-invoice-gen-area').show();
                        
                        // Set data attributes to Billing triggers
                        $('#btn-open-billing-modal').data('id', o.id);
                    } else {
                        $('#owner-approval-area').hide();
                        $('#owner-invoice-gen-area').hide();
                    }
                }
                
                $('#orderDetailModal').modal('show');
            }
        });
    });

    // Owner approves or cancels order
    $(document).on('click', '#btn-approve-order, #btn-cancel-order', function () {
        const id = $(this).data('id');
        const isApprove = $(this).attr('id') === 'btn-approve-order';
        const newStatus = isApprove ? 'Approved' : 'Cancelled';
        const notes = $('#approval-notes').val();
        
        if (!isApprove && !notes) {
            showToast('warning', 'Please provide cancellation reasons in the notes field.');
            return;
        }
        
        $.post('api/orders.php?action=update_status', { id, status: newStatus, remarks: notes })
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#orderDetailModal').modal('hide');
                    loadOrders();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // Open Billing Modal from detail popup
    $(document).on('click', '#btn-open-billing-modal', function () {
        const id = $(this).data('id');
        $('#billing-order-id').val(id);
        $('#orderDetailModal').modal('hide');
        $('#billingModal').modal('show');
    });

    // Owner generates invoice bill
    $(document).on('submit', '#generate-invoice-form', function (e) {
        e.preventDefault();
        $.post('api/invoices.php?action=generate', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#billingModal').modal('hide');
                    
                    // Open printable customer copy invoice window directly with auto-print!
                    window.open(`print_invoice.php?id=${res.data.invoice_id}&type=customer&autoprint=1`, '_blank');
                    loadOrders();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // ----------------------------------------------------
    // BILLING & INVOICES CONTROLLER
    // ----------------------------------------------------
    function loadBilling() {
        safeDestroyTable('#invoices-table');
        $.get('api/invoices.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#invoices-rows');
                    rows.empty();
                    res.data.forEach(item => {
                        let statusColor = 'badge bg-secondary';
                        if (item.payment_status === 'Paid') statusColor = 'badge bg-success';
                        if (item.payment_status === 'Partially Paid') statusColor = 'badge bg-warning text-dark';
                        if (item.payment_status === 'Unpaid') statusColor = 'badge bg-danger';
                        
                        rows.append(`
                            <tr>
                                <td><strong>${item.invoice_number}</strong></td>
                                <td><strong>${item.shop_name}</strong><br><span class="small text-secondary">${item.retailer_name}</span></td>
                                <td>${item.invoice_date}</td>
                                <td><span class="badge bg-secondary">${item.invoice_type}</span></td>
                                <td class="text-end fw-bold text-info">${formatRupees(item.grand_total)}</td>
                                <td class="text-end text-success">${formatRupees(item.paid_amount)}</td>
                                <td class="text-end text-danger">${formatRupees(item.outstanding_amount)}</td>
                                <td><span class="${statusColor}">${item.payment_status}</span></td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary view-invoice-details-btn me-1" data-id="${item.id}" title="View Details"><i class="fas fa-eye"></i> View</button>
                                    <a href="print_invoice.php?id=${item.id}&type=customer&autoprint=1" target="_blank" class="btn btn-sm btn-outline-success me-1" title="Customer Copy">C</a>
                                    <a href="print_invoice.php?id=${item.id}&type=office&autoprint=1" target="_blank" class="btn btn-sm btn-outline-warning text-white me-1" title="Office Copy">O</a>
                                    <a href="print_invoice.php?id=${item.id}&type=office&download=1" target="_blank" class="btn btn-sm btn-outline-danger" title="Download PDF"><i class="fas fa-file-pdf"></i> Download</a>
                                </td>
                            </tr>
                        `);
                    });
                    datatables['invoices'] = $('#invoices-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
    }

    $(document).on('click', '.view-invoice-details-btn', function () {
        const id = $(this).data('id');
        $.get(`api/invoices.php?action=detail&id=${id}`, function (res) {
            if (res.status === 'success') {
                const i = res.data;
                const company = JSON.parse(i.company_details);
                const retailer = JSON.parse(i.retailer_details);
                
                $('#det-inv-shop').text(retailer.shop_name);
                $('#det-inv-address').text(retailer.address);
                $('#det-inv-number').text(i.invoice_number);
                $('#det-inv-date').text(i.invoice_date);
                $('#det-inv-type').text(i.invoice_type);
                $('#det-inv-remarks').text(i.remarks || 'None');
                
                $('#det-inv-subtotal').text(formatRupees(i.subtotal));
                $('#det-inv-disc').text(`- ${formatRupees(i.discount_amount)}`);
                $('#det-inv-gstamt').text(formatRupees(i.gst_amount));
                $('#det-inv-grand').text(formatRupees(i.grand_total));
                $('#det-inv-paid').text(formatRupees(i.paid_amount));
                $('#det-inv-outstanding').text(formatRupees(i.outstanding_amount));
                
                // Populate items
                const tbody = $('#invoice-items-rows');
                tbody.empty();
                i.items.forEach(item => {
                    const mrpValue = item.mrp ? formatRupees(item.mrp) : 'N/A';
                    tbody.append(`
                        <tr>
                            <td><strong>${item.sku_name}</strong></td>
                            <td><code>${item.sku_code}</code></td>
                            <td class="text-end fw-bold">${item.quantity}</td>
                            <td class="text-end">${mrpValue}</td>
                            <td class="text-end">${formatRupees(item.selling_price)}</td>
                            <td class="text-end text-success">${formatRupees(item.discount_amount)}</td>
                            <td class="text-end">${item.gst_percentage}%</td>
                            <td class="text-end fw-bold text-info">${formatRupees(item.total_amount)}</td>
                        </tr>
                    `);
                });
                
                // Update print href link
                $('#btn-print-invoice-modal').attr('href', `print_invoice.php?id=${i.id}&type=customer&autoprint=1`);
                $('#btn-delete-invoice-modal').data('id', i.id);
                
                $('#invoiceDetailModal').modal('show');
            }
        });
    });

    $(document).on('click', '#btn-delete-invoice-modal', function () {
        const id = $(this).data('id');
        const confirm1 = confirm('⚠️ DELETE INVOICE?\n\nThis will:\n✓ Restore all SKU stock\n✓ Remove from customer ledger\n✓ Reverse outstanding balance\n✓ Re-open linked order\n✓ Remove all related payment entries\n\nThis cannot be undone. Proceed?');
        if (!confirm1) return;

        const confirm2 = confirm('Final Confirmation:\n\nAre you absolutely sure you want to delete this invoice?\n\nAll financial records, stock movements, and payments will be reversed.');
        if (!confirm2) return;

        $.post('api/invoices.php?action=delete', { id })
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#invoiceDetailModal').modal('hide');
                    loadBilling();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // ----------------------------------------------------
    // PAYMENTS COLLECTION CONTROLLER
    // ----------------------------------------------------
    function loadPayments() {
        safeDestroyTable('#payments-table');
        
        fetchConfigLists(function() {
            const payMethodSelect = $('#pay-method');
            if (payMethodSelect.length) {
                payMethodSelect.empty();
                window.paymentMethods.forEach(method => {
                    payMethodSelect.append(`<option value="${method}">${method}</option>`);
                });
            }
        });

        $.get('api/payments.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#payments-rows');
                    rows.empty();
                    res.data.forEach(item => {
                        rows.append(`
                            <tr>
                                <td>#REC-${item.id}</td>
                                <td><strong>${item.shop_name}</strong></td>
                                <td><code>${item.invoice_number || 'General Outstanding'}</code></td>
                                <td>${item.payment_date}</td>
                                <td><span class="small">${item.payment_type}</span></td>
                                <td><span class="badge bg-secondary">${item.payment_method}</span></td>
                                <td class="text-end fw-bold text-success">${formatRupees(item.amount)}</td>
                                <td><span class="small text-white-50">${item.reference_number || 'N/A'}</span></td>
                                <td><strong>${item.collector_name || 'Owner'}</strong></td>
                                <td><span class="small text-secondary">${item.remarks || ''}</span></td>
                            </tr>
                        `);
                    });
                    datatables['payments'] = $('#payments-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
            
        // Collect payment modal triggers
        if ($('#collect-payment-form').length > 0) {
            populateDropdown('api/beatroute.php?action=my_routes', '#pay-route', '-- Select Route --', 'id', 'route_name');
            $('#pay-retailer').html('<option value="">-- Select Retailer --</option>').prop('disabled', true);
            $('#pay-invoice').empty().append('<option value="">-- Apply to General Outstanding Balance --</option>');
            $('#pay-outstanding-val').text('₹0.00');
        }
    }

    // Route -> Retailer dependency
    $(document).on('change', '#pay-route', function () {
        const routeId = $(this).val();
        $('#pay-retailer').html('<option value="">-- Select Retailer --</option>').prop('disabled', true);
        $('#pay-invoice').empty().append('<option value="">-- Apply to General Outstanding Balance --</option>');
        $('#pay-outstanding-val').text('₹0.00');
        
        if (routeId) {
            populateDropdown(`api/retailers.php?action=list&route_id=${routeId}`, '#pay-retailer', '-- Select Retailer --', 'id', 'shop_name');
            $('#pay-retailer').prop('disabled', false);
        }
    });

    // Dynamic invoice loading upon retailer selection
    $(document).on('change', '#pay-retailer', function () {
        const retailerId = $(this).val();
        if (!retailerId) {
            $('#pay-invoice').empty().append('<option value="">-- Apply to General Outstanding Balance --</option>');
            $('#pay-outstanding-val').text('₹0.00');
            return;
        }
        
        // Fetch current outstanding first
        $.get(`api/retailers.php?action=detail&id=${retailerId}`, function (res) {
            if (res.status === 'success') {
                $('#pay-outstanding-val').text(formatRupees(res.data.outstanding_amount));
            }
        });
        
        // Load unpaid invoices list
        $.get('api/invoices.php?action=list', function (res) {
            if (res.status === 'success') {
                const select = $('#pay-invoice');
                select.empty().append('<option value="">-- Apply to General Outstanding Balance --</option>');
                
                // Filter only unpaid invoices for selected retailer
                const invoices = res.data.filter(inv => inv.retailer_id == retailerId && inv.payment_status !== 'Paid');
                
                invoices.forEach(inv => {
                    select.append(`<option value="${inv.id}">${inv.invoice_number} (Outstanding: ${formatRupees(inv.outstanding_amount)})</option>`);
                });
            }
        });
    });

    $(document).on('submit', '#collect-payment-form', function (e) {
        e.preventDefault();
        $.post('api/payments.php?action=collect', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#collectPaymentModal').modal('hide');
                    $('#collect-payment-form')[0].reset();
                    loadPayments();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // ----------------------------------------------------
    // ACCOUNTING CONTROLLER
    // ----------------------------------------------------
    function loadAccounting() {
        populateDropdown('api/retailers.php?action=list', '#ledger-retailer', '-- Choose Retailer shop --', 'id', 'shop_name');
        
        fetchConfigLists(function() {
            const catSelects = $('.expense-category-select');
            if (catSelects.length) {
                catSelects.empty();
                window.expenseCategories.forEach(cat => {
                    catSelects.append(`<option value="${cat}">${cat}</option>`);
                });
            }
            
            const methodSelects = $('.exp-payment-method-select');
            if (methodSelects.length) {
                methodSelects.empty();
                window.paymentMethods.forEach(method => {
                    methodSelects.append(`<option value="${method}">${method}</option>`);
                });
            }
        });

        // Load initial Expenses
        loadExpenses();
    }

    // Customer ledger statement calculator
    $(document).on('submit', '#ledger-filter-form', function (e) {
        e.preventDefault();
        const retailerId = $('#ledger-retailer').val();
        const start = $('#ledger-start').val();
        const end = $('#ledger-end').val();
        
        $.get(`api/accounting.php?action=customer_ledger&retailer_id=${retailerId}&start_date=${start}&end_date=${end}`, function (res) {
            if (res.status === 'success') {
                const data = res.data;
                $('#ledger-opening-bal').text(formatRupees(data.opening_balance));
                
                const tbody = $('#ledger-rows');
                tbody.empty();
                
                let balance = data.opening_balance;
                
                // Print Opening balance line
                tbody.append(`
                    <tr class="table-info bg-opacity-10 text-white-50">
                        <td>${start}</td>
                        <td>--</td>
                        <td>--</td>
                        <td><strong>OPENING BALANCE FORWARDED</strong></td>
                        <td class="text-end">--</td>
                        <td class="text-end">--</td>
                        <td class="text-end fw-bold">${formatRupees(balance)}</td>
                    </tr>
                `);
                
                if (data.entries.length === 0) {
                    tbody.append(`
                        <tr>
                            <td colspan="7" class="text-center text-secondary py-4">No transactions recorded in this period.</td>
                        </tr>
                    `);
                    $('#ledger-result-area').fadeIn();
                    return;
                }
                
                data.entries.forEach(entry => {
                    const dr = parseFloat(entry.debit_amount);
                    const cr = parseFloat(entry.credit_amount);
                    balance = balance + dr - cr;
                    
                    const drStr = dr > 0 ? formatRupees(dr) : '--';
                    const crStr = cr > 0 ? formatRupees(cr) : '--';
                    
                    let transColor = '';
                    if (entry.transaction_type === 'Invoice') transColor = 'text-danger';
                    if (entry.transaction_type === 'Payment') transColor = 'text-success';
                    
                    tbody.append(`
                        <tr>
                            <td>${entry.transaction_date}</td>
                            <td><code>${entry.doc_no || 'N/A'}</code></td>
                            <td><span class="badge bg-secondary">${entry.transaction_type}</span></td>
                            <td><span class="small">${entry.remarks || ''}</span></td>
                            <td class="text-end ${transColor}">${drStr}</td>
                            <td class="text-end text-success">${crStr}</td>
                            <td class="text-end fw-bold text-info">${formatRupees(balance)}</td>
                        </tr>
                    `);
                });
                
                $('#ledger-result-area').fadeIn();
            }
        });
    });

    // Cash / Bank book statement loader
    $(document).on('submit', '#cashbook-form, #bankbook-form', function (e) {
        e.preventDefault();
        const isCash = $(this).attr('id') === 'cashbook-form';
        const start = isCash ? $('#cash-start').val() : $('#bank-start').val();
        const end = isCash ? $('#cash-end').val() : $('#bank-end').val();
        const action = isCash ? 'cash_book' : 'bank_book';
        
        $.get(`api/accounting.php?action=${action}&start_date=${start}&end_date=${end}`, function (res) {
            if (res.status === 'success') {
                const data = res.data;
                const title = isCash ? '<i class="fas fa-coins text-warning"></i> Cash Ledger Book' : '<i class="fas fa-university text-info"></i> Bank &amp; Digital Book';
                const opening = isCash ? data.opening_cash : data.opening_bank;
                
                $('#cash-bank-title').html(title);
                $('#cash-bank-op-bal').text(formatRupees(opening));
                
                const tbody = $('#cash-bank-rows');
                tbody.empty();
                
                let balance = opening;
                
                tbody.append(`
                    <tr class="table-info bg-opacity-10 text-white-50">
                        <td>${start}</td>
                        <td>--</td>
                        <td><strong>OPENING POSITION</strong></td>
                        <td class="text-end">--</td>
                        <td class="text-end">--</td>
                        <td>--</td>
                    </tr>
                `);
                
                if (data.entries.length === 0) {
                    tbody.append('<tr><td colspan="6" class="text-center text-secondary py-4">No cash/bank flows recorded in this period.</td></tr>');
                    $('#cash-bank-result-area').fadeIn();
                    return;
                }
                
                data.entries.forEach(entry => {
                    const deb = parseFloat(entry.debit);
                    const cred = parseFloat(entry.credit);
                    balance = balance + deb - cred;
                    
                    const debStr = deb > 0 ? formatRupees(deb) : '--';
                    const credStr = cred > 0 ? formatRupees(cred) : '--';
                    
                    tbody.append(`
                        <tr>
                            <td>${entry.trans_date}</td>
                            <td><span class="small">${entry.type || entry.payment_method}</span></td>
                            <td><strong>${entry.particulars}</strong></td>
                            <td class="text-end text-success">${debStr}</td>
                            <td class="text-end text-danger">${credStr}</td>
                            <td><span class="small text-white-50">${entry.remarks || ''}</span></td>
                        </tr>
                    `);
                });
                
                $('#cash-bank-result-area').fadeIn();
            }
        });
    });

    // Day Book Loader
    $(document).on('submit', '#daybook-form', function (e) {
        e.preventDefault();
        const date = $('#daybook-date').val();
        
        $.get(`api/accounting.php?action=day_book&date=${date}`, function (res) {
            if (res.status === 'success') {
                const tbody = $('#daybook-rows');
                tbody.empty();
                
                if (res.data.length === 0) {
                    tbody.append('<tr><td colspan="6" class="text-center text-secondary py-4">No ledger vouchers filed on this date.</td></tr>');
                    $('#daybook-result-area').fadeIn();
                    return;
                }
                
                res.data.forEach(entry => {
                    const dr = parseFloat(entry.debit);
                    const cr = parseFloat(entry.credit);
                    
                    const drStr = dr > 0 ? formatRupees(dr) : '--';
                    const crStr = cr > 0 ? formatRupees(cr) : '--';
                    
                    tbody.append(`
                        <tr>
                            <td><span class="badge bg-secondary">${entry.entry_type}</span></td>
                            <td><code>${entry.doc_no}</code></td>
                            <td><strong>${entry.particulars}</strong></td>
                            <td class="text-end text-danger">${drStr}</td>
                            <td class="text-end text-success">${crStr}</td>
                            <td><span class="small text-white-50">${entry.remarks || ''}</span></td>
                        </tr>
                    `);
                });
                
                $('#daybook-result-area').fadeIn();
            }
        });
    });

    // EXPENSE CRUD
    function loadExpenses() {
        safeDestroyTable('#expenses-table');
        $.get('api/expenses.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#expenses-rows');
                    rows.empty();
                    res.data.forEach(item => {
                        rows.append(`
                            <tr>
                                <td>#EXP-${item.id}</td>
                                <td>${item.expense_date}</td>
                                <td><strong>${item.category}</strong></td>
                                <td class="text-end fw-bold text-danger">${formatRupees(item.amount)}</td>
                                <td><span class="badge bg-secondary">${item.payment_method || 'Cash'}</span></td>
                                <td><span class="small">${item.paid_to || 'N/A'}</span></td>
                                <td><span class="small text-secondary">${item.remarks || ''}</span></td>
                                <td><span class="small text-white-50">${item.creator_name || 'System'}</span></td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-warning edit-expense-btn" data-id="${item.id}" title="Edit"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-sm btn-outline-danger delete-expense-btn" data-id="${item.id}" title="Delete"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                        `);
                    });
                    
                    datatables['expenses'] = $('#expenses-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
    }

    $(document).on('submit', '#add-expense-form', function (e) {
        e.preventDefault();
        $.post('api/expenses.php?action=create', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#addExpenseModal').modal('hide');
                    $('#add-expense-form')[0].reset();
                    loadExpenses();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // Auto-calculate GST Amount in Add Expense Modal
    $(document).on('input', '#exp-amount, #exp-gst-pct', function () {
        const amount = parseFloat($('#exp-amount').val()) || 0;
        const gstPct = parseFloat($('#exp-gst-pct').val()) || 0;
        const gstAmt = (amount * gstPct) / 100;
        $('#exp-gst-amt').val(gstAmt.toFixed(2));
    });

    // Auto-calculate GST Amount in Edit Expense Modal
    $(document).on('input', '#edit-exp-amount, #edit-exp-gst-pct', function () {
        const amount = parseFloat($('#edit-exp-amount').val()) || 0;
        const gstPct = parseFloat($('#edit-exp-gst-pct').val()) || 0;
        const gstAmt = (amount * gstPct) / 100;
        $('#edit-exp-gst-amt').val(gstAmt.toFixed(2));
    });

    $(document).on('click', '.edit-expense-btn', function () {
        const id = $(this).data('id');
        $.get(`api/expenses.php?action=detail&id=${id}`, function (res) {
            if (res.status === 'success') {
                const e = res.data;
                $('#edit-exp-id').val(e.id);
                $('#edit-exp-category').val(e.category);
                $('#edit-exp-amount').val(e.amount);
                $('#edit-exp-gst-pct').val(e.gst_percentage || 0);
                $('#edit-exp-gst-amt').val(e.gst_amount || 0.00);
                $('#edit-exp-payment-method').val(e.payment_method);
                $('#edit-exp-date').val(e.expense_date);
                $('#edit-exp-to').val(e.paid_to);
                $('#edit-exp-remarks').val(e.remarks);
                
                $('#editExpenseModal').modal('show');
            }
        });
    });

    $(document).on('submit', '#edit-expense-form', function (e) {
        e.preventDefault();
        $.post('api/expenses.php?action=update', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#editExpenseModal').modal('hide');
                    loadExpenses();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    $(document).on('click', '.delete-expense-btn', function () {
        const id = $(this).data('id');
        if (confirm('Delete expense voucher?')) {
            $.post('api/expenses.php?action=delete', { id })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadExpenses();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    // Profit & Loss Calculator Form
    $(document).on('submit', '#pl-form', function (e) {
        e.preventDefault();
        const start = $('#pl-start').val();
        const end = $('#pl-end').val();
        
        $.get(`api/accounting.php?action=profit_loss&start_date=${start}&end_date=${end}`, function (res) {
            if (res.status === 'success') {
                const pl = res.data;
                
                // Populate Trading Account
                $('#pl-sales-rev').text(formatRupees(pl.taxable_revenue));
                $('#pl-cogs').text(`- ${formatRupees(pl.cogs)}`);
                
                const gp = pl.gross_profit;
                $('#pl-gross-profit').text(formatRupees(gp));
                $('#pl-gross-profit-bf').text(formatRupees(gp));
                
                // Operating Statement
                $('#pl-expenses-total').text(`- ${formatRupees(pl.total_expenses)}`);
                
                const np = pl.net_profit;
                const npSpan = $('#pl-net-profit');
                const plNetDiv = $('#pl-net-div');
                
                npSpan.text(formatRupees(np));
                $('#pl-margin-pct').text(`${pl.margin_percentage}%`);
                
                if (np >= 0) {
                    plNetDiv.removeClass('text-danger').addClass('text-success');
                } else {
                    plNetDiv.removeClass('text-success').addClass('text-danger');
                }
                
                // Expense breakdown list
                const expRows = $('#pl-expenses-rows');
                expRows.empty();
                if (pl.expenses.length === 0) {
                    expRows.append('<tr><td colspan="2" class="text-center text-secondary py-3">No expenses recorded in this period.</td></tr>');
                } else {
                    pl.expenses.forEach(row => {
                        expRows.append(`
                            <tr>
                                <td><strong>${row.category}</strong></td>
                                <td class="text-end text-danger fw-bold">${formatRupees(row.total_amount)}</td>
                            </tr>
                        `);
                    });
                }
                
                $('#pl-result-area').fadeIn();
            }
        });
    });

    // ----------------------------------------------------
    // SETTINGS CONTROLLER
    // ----------------------------------------------------
    function loadSettings() {
        $.get('api/settings.php?action=load', function (res) {
            if (res.status === 'success') {
                const s = res.data;
                $('#set-company-name').val(s.company_name || '');
                $('#set-company-fy').val(s.financial_year || '');
                $('#set-company-mobile').val(s.company_mobile || '');
                $('#set-company-email').val(s.company_email || '');
                $('#set-company-gst').val(s.company_gst || '');
                $('#set-invoice-prefix').val(s.invoice_prefix || '');
                $('#set-default-limit').val(s.default_credit_limit || '50000.00');
                $('#set-company-address').val(s.company_address || '');
                $('#set-invoice-footer').val(s.invoice_footer || '');
                $('#set-company-fssai').val(s.company_fssai || '');
                $('#set-bank-name').val(s.bank_name || '');
                $('#set-bank-acc').val(s.bank_account_no || '');
                $('#set-bank-ifsc').val(s.bank_ifsc || '');
                $('#set-bank-branch').val(s.bank_branch || '');

                try {
                    if (s.payment_methods) {
                        window.paymentMethods = JSON.parse(s.payment_methods);
                    }
                } catch(e) {
                    console.error(e);
                }
                try {
                    if (s.expense_categories) {
                        window.expenseCategories = JSON.parse(s.expense_categories);
                    }
                } catch(e) {
                    console.error(e);
                }

                renderSettingsPaymentMethods();
                renderSettingsExpenseCategories();
                loadOwnerProfile();
            }
        });
    }

    function loadOwnerProfile() {
        $.get('api/settings.php?action=load-owner', function (res) {
            if (res.status === 'success') {
                const u = res.data;
                $('#owner-fullname').val(u.fullname || '');
                $('#owner-username').val(u.username || '');
                $('#owner-email').val(u.email || '');
                $('#owner-mobile').val(u.mobile || '');
                $('#owner-password').val('');
                $('#owner-password-confirm').val('');
                if (u.photo) {
                    $('#owner-photo-preview').attr('src', u.photo);
                } else {
                    $('#owner-photo-preview').attr('src', 'assets/images/default-avatar.png');
                }
            }
        });
    }

    function renderSettingsPaymentMethods() {
        const rows = $('#payment-methods-list-rows');
        if (!rows.length) return;
        rows.empty();
        window.paymentMethods.forEach((method, idx) => {
            rows.append(`
                <tr>
                    <td><strong>${method}</strong></td>
                    <td class="text-center">
                        <button class="btn btn-sm btn-outline-danger delete-setting-pm-btn py-0 px-2" data-index="${idx}">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
            `);
        });
    }

    function renderSettingsExpenseCategories() {
        const rows = $('#expense-categories-list-rows');
        if (!rows.length) return;
        rows.empty();
        window.expenseCategories.forEach((cat, idx) => {
            rows.append(`
                <tr>
                    <td><strong>${cat}</strong></td>
                    <td class="text-center">
                        <button class="btn btn-sm btn-outline-danger delete-setting-ec-btn py-0 px-2" data-index="${idx}">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
            `);
        });
    }

    function saveConfigList(key, arr, callback) {
        const data = {};
        data[key] = JSON.stringify(arr);
        $.post('api/settings.php?action=save', data)
            .done(function (res) {
                if (res.status === 'success') {
                    if (callback) callback();
                } else {
                    showToast('error', res.message);
                }
            });
    }

    $(document).on('submit', '#add-payment-method-form', function (e) {
        e.preventDefault();
        const newVal = $('#new-payment-method').val().trim();
        if (!newVal) return;
        
        if (window.paymentMethods.includes(newVal)) {
            showToast('warning', 'Payment method already exists.');
            return;
        }
        
        window.paymentMethods.push(newVal);
        saveConfigList('payment_methods', window.paymentMethods, function() {
            $('#new-payment-method').val('');
            renderSettingsPaymentMethods();
            showToast('success', 'Payment method added successfully.');
        });
    });

    $(document).on('click', '.delete-setting-pm-btn', function () {
        const idx = parseInt($(this).data('index'));
        const method = window.paymentMethods[idx];
        if (confirm(`Remove "${method}" from payment methods?`)) {
            window.paymentMethods.splice(idx, 1);
            saveConfigList('payment_methods', window.paymentMethods, function() {
                renderSettingsPaymentMethods();
                showToast('success', 'Payment method removed.');
            });
        }
    });

    $(document).on('submit', '#add-expense-category-form', function (e) {
        e.preventDefault();
        const newVal = $('#new-expense-category').val().trim();
        if (!newVal) return;
        
        if (window.expenseCategories.includes(newVal)) {
            showToast('warning', 'Expense category already exists.');
            return;
        }
        
        window.expenseCategories.push(newVal);
        saveConfigList('expense_categories', window.expenseCategories, function() {
            $('#new-expense-category').val('');
            renderSettingsExpenseCategories();
            showToast('success', 'Expense category added successfully.');
        });
    });

    $(document).on('click', '.delete-setting-ec-btn', function () {
        const idx = parseInt($(this).data('index'));
        const cat = window.expenseCategories[idx];
        if (confirm(`Remove "${cat}" from expense categories?`)) {
            window.expenseCategories.splice(idx, 1);
            saveConfigList('expense_categories', window.expenseCategories, function() {
                renderSettingsExpenseCategories();
                showToast('success', 'Expense category removed.');
            });
        }
    });

    $(document).on('submit', '#settings-profile-form', function (e) {
        e.preventDefault();
        $.post('api/settings.php?action=save', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    
                    // Updates navbar company title immediately
                    $('#navbar-company-title').text($('#set-company-name').val());
                    loadSettings();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    $(document).on('change', '#owner-photo-input', function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                $('#owner-photo-preview').attr('src', e.target.result);
            };
            reader.readAsDataURL(file);
        }
    });

    $(document).on('submit', '#owner-profile-form', function (e) {
        e.preventDefault();
        
        const pwd = $('#owner-password').val();
        const pwdConfirm = $('#owner-password-confirm').val();
        if (pwd && pwd !== pwdConfirm) {
            showToast('error', 'New password and confirmation do not match.');
            return;
        }
        
        const formData = new FormData(this);
        $.ajax({
            url: 'api/settings.php?action=save-owner',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    loadOwnerProfile();
                    
                    // Update layouts immediately
                    $('#sidebar-fullname').text($('#owner-fullname').val());
                    if (res.data && res.data.photo) {
                        $('#sidebar-avatar').attr('src', res.data.photo);
                    }
                } else {
                    showToast('error', res.message);
                }
            }
        });
    });

    $(document).on('submit', '#settings-restore-form', function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        
        if (confirm('RESTORE WARNING: Overwrite current database with backup file? Current changes will be deleted!')) {
            $.ajax({
                url: 'api/settings.php?action=restore',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        $('#settings-restore-form')[0].reset();
                        setTimeout(() => { window.location.reload(); }, 1500);
                    } else {
                        showToast('error', res.message);
                    }
                }
            });
        }
    });

    // ==========================================
    // EXPIRY PRODUCTS CONTROLLER & EVENTS
    // ==========================================
    let expirySkuList = [];

    function loadExpiryProducts() {
        safeDestroyTable('#expiry-table');
        
        // 1. Fetch summary if Owner
        if (window.userRole === 'Owner') {
            $.get('api/expiry.php?action=summary')
                .done(function (res) {
                    if (res.status === 'success') {
                        $('#exp-total-qty').text(res.data.stats.total_qty);
                        $('#exp-total-amount').text(formatRupees(res.data.stats.total_amount));
                        $('#exp-distinct-skus').text(res.data.stats.total_distinct_skus);
                        
                        // Brand-wise return summary list
                        const brandRows = $('#expiry-brand-rows');
                        brandRows.empty();
                        if (res.data.brands.length === 0) {
                            brandRows.append('<tr><td colspan="5" class="text-center text-secondary py-3">No pending returns</td></tr>');
                        } else {
                            res.data.brands.forEach(b => {
                                brandRows.append(`
                                    <tr>
                                        <td><strong>${b.brand_name}</strong></td>
                                        <td class="text-center fw-bold">${b.products_count}</td>
                                        <td class="text-center">${b.total_qty} units</td>
                                        <td class="text-end fw-bold text-danger">${formatRupees(b.total_amount)}</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-outline-danger return-brand-btn py-0 px-2" data-brand="${b.brand_name}" style="font-size:0.8rem;">
                                                Return
                                            </button>
                                        </td>
                                    </tr>
                                `);
                            });
                        }

                        // Retailer-wise summary list
                        const retailerRows = $('#expiry-retailer-rows');
                        retailerRows.empty();
                        if (res.data.retailers.length === 0) {
                            retailerRows.append('<tr><td colspan="3" class="text-center text-secondary py-3">No outstanding expiries</td></tr>');
                        } else {
                            res.data.retailers.forEach(r => {
                                retailerRows.append(`
                                    <tr>
                                        <td><strong>${r.shop_name}</strong></td>
                                        <td class="text-center">${r.total_qty} units</td>
                                        <td class="text-end fw-bold text-warning">${formatRupees(r.total_amount)}</td>
                                    </tr>
                                `);
                            });
                        }
                    }
                });

            // Fetch Brand Returns History Log
            safeDestroyTable('#brand-returns-log-table');
            $.get('api/expiry.php?action=returns_log')
                .done(function (res) {
                    if (res.status === 'success') {
                        const logRows = $('#brand-returns-log-rows');
                        logRows.empty();
                        res.data.forEach(item => {
                            let badgeClass = 'secondary';
                            if (item.status === 'Returned to Brand') badgeClass = 'success';
                            else if (item.status === 'Written Off') badgeClass = 'danger';
                            
                            let badge = `<span class="badge-custom ${badgeClass}">${item.status}</span>`;
                            
                            logRows.append(`
                                <tr>
                                    <td><code>LOG-${String(item.id).padStart(4, '0')}</code></td>
                                    <td>${item.created_at.substring(0, 10)}</td>
                                    <td><strong>${item.brand_name}</strong></td>
                                    <td><strong>${item.shop_name}</strong></td>
                                    <td>${item.sku_name} (<code>${item.sku_code}</code>)</td>
                                    <td class="text-center fw-bold">${item.quantity}</td>
                                    <td class="text-end text-success">${formatRupees(item.amount)}</td>
                                    <td class="text-center">${badge}</td>
                                    <td><span class="small text-secondary">${item.remarks || '--'}</span></td>
                                </tr>
                            `);
                        });
                        
                        datatables['brand-returns-log'] = $('#brand-returns-log-table').DataTable({
                            pageLength: 5,
                            ordering: true,
                            destroy: true,
                            stateSave: true
                        });
                    }
                });
        }
        
        // 2. Fetch main table
        $.get('api/expiry.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    const rows = $('#expiry-rows');
                    rows.empty();
                    
                    const isOwner = window.userRole === 'Owner';
                    
                    res.data.forEach(item => {
                        let badgeClass = 'secondary';
                        if (item.status === 'Collected') badgeClass = 'warning';
                        else if (item.status === 'Returned to Brand') badgeClass = 'success';
                        else if (item.status === 'Written Off') badgeClass = 'danger';
                        
                        let badge = `<span class="badge-custom ${badgeClass}">${item.status}</span>`;
                        
                        let statusAction = '';
                        if (isOwner && item.status === 'Collected') {
                            statusAction = `
                                <div class="dropdown d-inline ms-1">
                                    <button class="btn btn-sm btn-outline-info dropdown-toggle py-0 px-1" style="font-size:0.75rem;" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Status
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-dark">
                                        <li><a class="dropdown-item update-exp-status-btn" href="#" data-id="${item.id}" data-status="Returned to Brand">Mark Returned to Brand</a></li>
                                        <li><a class="dropdown-item update-exp-status-btn" href="#" data-id="${item.id}" data-status="Written Off">Mark Written Off</a></li>
                                    </ul>
                                </div>
                            `;
                        }

                        rows.append(`
                            <tr>
                                <td><code>EXP-${String(item.id).padStart(4, '0')}</code></td>
                                <td>${item.created_at.substring(0, 10)}</td>
                                <td><strong>${item.shop_name}</strong></td>
                                <td><strong>${item.brand_name}</strong><br><span class="small text-secondary">${item.product_name}</span></td>
                                <td>${item.sku_name} (<code>${item.sku_code}</code>)</td>
                                <td class="text-center fw-bold">${item.quantity}</td>
                                <td class="text-end">${formatRupees(item.rate)}</td>
                                <td class="text-end fw-bold text-warning">${formatRupees(item.amount)}</td>
                                <td>${item.collector_name}</td>
                                <td class="text-center">${badge} ${statusAction}</td>
                            </tr>
                        `);
                    });
                    
                    datatables['expiry'] = $('#expiry-table').DataTable({
                        order: [],
                        pageLength: 10,
                        ordering: true,
                        destroy: true,
                        stateSave: true
                    });
                }
            });
    }

    $(document).on('click', '#add-expiry-btn', function () {
        // Populate retailers
        populateDropdown('api/retailers.php?action=list', '#exp-retailer', '-- Choose Retailer --', 'id', 'shop_name');
        
        // Populate SKUs via custom call to display more info
        $.get('api/skus.php?action=list')
            .done(function (res) {
                if (res.status === 'success') {
                    expirySkuList = res.data;
                    const select = $('#exp-sku');
                    select.empty();
                    select.append('<option value="">-- Choose SKU --</option>');
                    expirySkuList.forEach(sku => {
                        select.append(`<option value="${sku.id}">${sku.brand_name} - ${sku.product_name} (${sku.sku_name})</option>`);
                    });
                }
            });
    });

    $(document).on('change', '#exp-sku', function () {
        const skuId = parseInt($(this).val());
        const selectedSku = expirySkuList.find(s => s.id === skuId);
        if (selectedSku) {
            $('#exp-rate').val(selectedSku.selling_price);
        } else {
            $('#exp-rate').val('');
        }
    });

    $(document).on('submit', '#add-expiry-form', function (e) {
        e.preventDefault();
        const data = $(this).serialize();
        $.post('api/expiry.php?action=create', data)
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#addExpiryModal').modal('hide');
                    $('#add-expiry-form')[0].reset();
                    loadExpiryProducts();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    $(document).on('click', '.update-exp-status-btn', function (e) {
        e.preventDefault();
        const id = $(this).data('id');
        const status = $(this).data('status');
        
        if (confirm(`Are you sure you want to mark this expiry claim as "${status}"?`)) {
            $.post('api/expiry.php?action=update_status', { id: id, status: status })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadExpiryProducts();
                    }
                });
        }
    });

    $(document).on('click', '.return-brand-btn', function (e) {
        e.preventDefault();
        const brandName = $(this).data('brand');
        
        if (confirm(`Are you sure you want to process returns for all collected ${brandName} items?`)) {
            $.post('api/expiry.php?action=return_brand', { brand_name: brandName })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadExpiryProducts();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    // Auto-refresh Dashboard every 30 seconds when active
    setInterval(function () {
        if (currentRoute === 'dashboard') {
            loadDashboard();
        }
    }, 30000);

    // ----------------------------------------------------
    // GST REPORT CONTROLLER
    // ----------------------------------------------------
    function loadGstReport() {
        const startDate = $('#gst-start-date').val() || '';
        const endDate = $('#gst-end-date').val() || '';
        
        $.get(`api/gst.php?start_date=${startDate}&end_date=${endDate}`, function (res) {
            if (res.status === 'success') {
                const data = res.data;
                const summary = data.summary;
                
                // Update KPI values
                $('#lbl-outward-gst').text(formatRupees(summary.total_outward_gst));
                $('#lbl-inward-gst').text(formatRupees(summary.total_inward_gst));
                $('#lbl-inward-breakdown').text(`Purchases: ${formatRupees(summary.total_purchase_gst)} | Exp: ${formatRupees(summary.total_expense_gst)}`);
                
                const net = summary.net_payable;
                $('#lbl-net-gst').text(formatRupees(Math.abs(net)));
                if (net >= 0) {
                    $('#lbl-net-gst').addClass('text-white').removeClass('text-success');
                    $('#lbl-gst-liability-desc').text('Net payable to government');
                } else {
                    $('#lbl-net-gst').addClass('text-success').removeClass('text-white');
                    $('#lbl-gst-liability-desc').text('Excess Input Credit (Refundable)');
                }
                
                // Populate Sales Table
                safeDestroyTable('#gst-sales-table');
                let salesRows = '';
                let salesSubtotal = 0, salesGst = 0, salesGrand = 0;
                
                data.sales.forEach(item => {
                    const sub = parseFloat(item.subtotal) || 0;
                    const gst = parseFloat(item.gst_amount) || 0;
                    const grand = parseFloat(item.grand_total) || 0;
                    
                    salesSubtotal += sub;
                    salesGst += gst;
                    salesGrand += grand;
                    
                    salesRows += `
                        <tr>
                            <td>${formatDate(item.invoice_date)}</td>
                            <td><span class="badge bg-secondary px-2">${item.invoice_number}</span></td>
                            <td>${item.shop_name}</td>
                            <td><span class="small text-white-50">${item.gst_number || 'N/A'}</span></td>
                            <td class="text-end font-monospace">${formatRupees(sub)}</td>
                            <td class="text-end font-monospace text-warning">${formatRupees(gst)}</td>
                            <td class="text-end font-monospace text-success">${formatRupees(grand)}</td>
                        </tr>
                    `;
                });
                $('#gst-sales-body').html(salesRows || '<tr><td colspan="7" class="text-center text-muted">No sales invoices found for the selected range.</td></tr>');
                $('#gst-sales-total-subtotal').text(formatRupees(salesSubtotal));
                $('#gst-sales-total-gst').text(formatRupees(salesGst));
                $('#gst-sales-total-grand').text(formatRupees(salesGrand));
                
                if (salesRows) {
                    datatables['gst-sales'] = $('#gst-sales-table').DataTable({ order: [],
                        pageLength: 10, ordering: true, destroy: true, stateSave: true });
                }
                
                // Populate Purchases Table
                safeDestroyTable('#gst-purchases-table');
                let purchaseRows = '';
                let purSubtotal = 0, purGst = 0, purGrand = 0;
                
                data.purchases.forEach(item => {
                    const sub = parseFloat(item.subtotal) || 0;
                    const gst = parseFloat(item.gst_amount) || 0;
                    const grand = parseFloat(item.grand_total) || 0;
                    
                    purSubtotal += sub;
                    purGst += gst;
                    purGrand += grand;
                    
                    purchaseRows += `
                        <tr>
                            <td>${formatDate(item.purchase_date)}</td>
                            <td>
                                <a href="#" class="btn-view-purchase text-decoration-none" data-id="${item.id}">
                                    <span class="badge bg-info px-2">${item.supplier_invoice} <i class="fas fa-eye small ms-1"></i></span>
                                </a>
                            </td>
                            <td><strong>${item.supplier_name}</strong></td>
                            <td class="text-end font-monospace">${formatRupees(sub)}</td>
                            <td class="text-end font-monospace text-warning">${formatRupees(gst)}</td>
                            <td class="text-end font-monospace text-success">${formatRupees(grand)}</td>
                            <td><span class="small text-white-50">${item.remarks || 'N/A'}</span></td>
                        </tr>
                    `;
                });
                $('#gst-purchases-body').html(purchaseRows || '<tr><td colspan="7" class="text-center text-muted">No purchases found for the selected range.</td></tr>');
                $('#gst-pur-total-subtotal').text(formatRupees(purSubtotal));
                $('#gst-pur-total-gst').text(formatRupees(purGst));
                $('#gst-pur-total-grand').text(formatRupees(purGrand));
                
                if (purchaseRows) {
                    datatables['gst-purchases'] = $('#gst-purchases-table').DataTable({ order: [],
                        pageLength: 10, ordering: true, destroy: true, stateSave: true });
                }
                
                // Populate Expenses/Assets Table
                safeDestroyTable('#gst-expenses-table');
                let expRows = '';
                let expSubtotal = 0, expGst = 0, expGrand = 0;
                
                data.expenses.forEach(item => {
                    const sub = parseFloat(item.subtotal) || 0;
                    const gst = parseFloat(item.gst_amount) || 0;
                    const grand = parseFloat(item.grand_total) || 0;
                    
                    expSubtotal += sub;
                    expGst += gst;
                    expGrand += grand;
                    
                    expRows += `
                        <tr>
                            <td>${formatDate(item.expense_date)}</td>
                            <td><span class="badge bg-info text-dark px-2">${item.category}</span></td>
                            <td>${item.paid_to || 'N/A'}</td>
                            <td class="text-end font-monospace">${formatRupees(sub)}</td>
                            <td class="text-center font-monospace">${item.gst_percentage}%</td>
                            <td class="text-end font-monospace text-warning">${formatRupees(gst)}</td>
                            <td class="text-end font-monospace text-success">${formatRupees(grand)}</td>
                            <td><span class="small text-white-50">${item.remarks || 'N/A'}</span></td>
                        </tr>
                    `;
                });
                $('#gst-expenses-body').html(expRows || '<tr><td colspan="8" class="text-center text-muted">No GST expenses found for the selected range.</td></tr>');
                $('#gst-exp-total-subtotal').text(formatRupees(expSubtotal));
                $('#gst-exp-total-gst').text(formatRupees(expGst));
                $('#gst-exp-total-grand').text(formatRupees(expGrand));
                
                if (expRows) {
                    datatables['gst-expenses'] = $('#gst-expenses-table').DataTable({ order: [],
                        pageLength: 10, ordering: true, destroy: true, stateSave: true });
                }
            } else {
                showToast('error', res.message);
            }
        });
    }

    // Filter button trigger
    $(document).on('click', '#gst-filter-btn', function () {
        loadGstReport();
    });

    // Export Outward GST CSV
    $(document).on('click', '#btn-export-gst-sales', function () {
        const start = $('#gst-start-date').val();
        const end = $('#gst-end-date').val();
        window.open(`api/reports.php?type=gst_sales&start_date=${start}&end_date=${end}`, '_blank');
    });

    // Export Inward Purchases GST CSV
    $(document).on('click', '#btn-export-gst-purchases', function () {
        const start = $('#gst-start-date').val();
        const end = $('#gst-end-date').val();
        window.open(`api/reports.php?type=gst_purchases&start_date=${start}&end_date=${end}`, '_blank');
    });

    // Export Expenses GST CSV
    $(document).on('click', '#btn-export-gst-expenses', function () {
        const start = $('#gst-start-date').val();
        const end = $('#gst-end-date').val();
        window.open(`api/reports.php?type=gst_expenses&start_date=${start}&end_date=${end}`, '_blank');
    });

    // ----------------------------------------------------
    // BEATROUTE MASTER CONTROLLER
    // ----------------------------------------------------
    function loadBeatrouteMaster() {
        loadBeatroutesList();
        loadWeekSchedule();
    }

    function loadBeatroutesList() {
        safeDestroyTable('#routes-table');
        $.get('api/beatroute.php?action=routes_list')
            .done(function (res) {
                if (res.status === 'success') {
                    const tbody = $('#routes-list-body');
                    tbody.empty();
                    
                    res.data.forEach(function (route) {
                        tbody.append(`
                            <tr>
                                <td><strong>${route.route_name}</strong></td>
                                <td><span class="badge bg-info px-2">${route.retailer_count} Retailers</span></td>
                                <td>${route.staff_names ? `<span class="small text-secondary">${route.staff_names}</span>` : '<span class="small text-muted">Unassigned</span>'}</td>
                                <td>${formatDate(route.created_at)}</td>
                                <td class="text-end">
                                    <button type="button" class="btn btn-sm btn-action primary btn-edit-route" data-id="${route.id}" data-name="${route.route_name}"><i class="fas fa-edit me-1"></i> Edit</button>
                                    ${parseInt(route.staff_count) > 0 ? '' : `<button type="button" class="btn btn-sm btn-danger btn-delete-route" data-id="${route.id}"><i class="fas fa-trash"></i></button>`}
                                </td>
                            </tr>
                        `);
                    });
                    
                    if (res.data.length > 0) {
                        datatables['routes'] = $('#routes-table').DataTable({
                            order: [],
                        pageLength: 10,
                            ordering: true,
                            destroy: true,
                            stateSave: true
                        });
                    }
                }
            });
    }

    // ── Weekly Schedule ──────────────────────────────────
    const WEEK_DAYS = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];

    function loadWeekSchedule() {
        $.get('api/beatroute.php?action=schedule_list', function (res) {
            const data = res.status === 'success' ? res.data : [];
            // group by day
            const byDay = {};
            WEEK_DAYS.forEach(d => byDay[d] = []);
            data.forEach(e => { if (byDay[e.day_of_week]) byDay[e.day_of_week].push(e); });

            const today = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][new Date().getDay()];
            const grid = $('#week-schedule-grid');
            grid.empty();

            WEEK_DAYS.forEach(function (day) {
                const isToday = day === today;
                const entries = byDay[day];

                let chipsHtml = entries.map(e => `
                    <div class="schedule-chip">
                        <div>
                            <div class="chip-route"><i class="fas fa-route me-1" style="font-size:.7rem"></i>${e.route_name}</div>
                            ${e.staff_name ? `<div class="chip-staff"><i class="fas fa-user me-1" style="font-size:.65rem"></i>${e.staff_name}</div>` : ''}
                            ${e.notes ? `<div class="chip-notes">${e.notes}</div>` : ''}
                        </div>
                        <button class="schedule-chip-remove" data-id="${e.id}" title="Remove"><i class="fas fa-times"></i></button>
                    </div>
                `).join('');

                grid.append(`
                    <div class="week-day-col">
                        <div class="week-day-header ${isToday ? 'today' : ''}">
                            <span>${day.substring(0,3).toUpperCase()}</span>
                            ${isToday ? '<span class="week-day-today-dot"></span>' : ''}
                        </div>
                        <div class="week-day-body">${chipsHtml}</div>
                        <button class="week-day-add-btn btn-open-schedule-modal" data-day="${day}">
                            <i class="fas fa-plus me-1"></i> Add Route
                        </button>
                    </div>
                `);
            });
        });
    }

    // Open schedule modal from + button on day column or Schedule button on route row
    $(document).on('click', '.btn-open-schedule-modal', function () {
        const day = $(this).data('day');
        openScheduleModal(day, null);
    });



    // Reset entire weekly schedule
    $(document).on('click', '#btn-reset-schedule', function () {
        if (!confirm('⚠️ This will permanently remove ALL entries from the weekly schedule.\n\nAre you sure you want to reset the entire schedule?')) return;
        $.post('api/beatroute.php?action=schedule_reset')
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', 'Weekly schedule has been reset.');
                    loadWeekSchedule();
                } else {
                    showToast('error', res.message);
                }
            })
            .fail(function () {
                showToast('error', 'Server error while resetting schedule.');
            });
    });

    function openScheduleModal(preselectedDay, preselectedRoute) {
        const $form = $('#schedule-add-form')[0];
        $form.reset();

        // Populate routes dropdown
        $.get('api/beatroute.php?action=routes_list', function (res) {
            const $sel = $('#sched-route-select');
            $sel.empty().append('<option value="">-- Select Route --</option>');
            if (res.status === 'success') {
                res.data.forEach(r => $sel.append(`<option value="${r.id}">${r.route_name}</option>`));
            }
            if (preselectedRoute) $sel.val(preselectedRoute.id);
        });



        if (preselectedDay) {
            $('#sched-day-input').val(preselectedDay);
            $('#schedule-day-label').text(preselectedDay);
        } else {
            // show a day picker inside the modal
            const $dayRow = $('<div class="mb-3"></div>');
            const $label  = $('<label class="form-label-custom">Day of Week <span class="text-danger">*</span></label>');
            const $sel    = $('<select class="form-select form-control-custom" id="sched-day-picker" required></select>');
            $sel.append('<option value="">-- Select Day --</option>');
            WEEK_DAYS.forEach(d => $sel.append(`<option value="${d}">${d}</option>`));
            $sel.on('change', function () {
                $('#sched-day-input').val($(this).val());
                $('#schedule-day-label').text($(this).val() || '');
            });
            $dayRow.append($label).append($sel);
            // inject before first field if not already there
            if (!$('#sched-day-picker').length) {
                $('#schedule-add-form .modal-body').prepend($dayRow);
            }
            $('#sched-day-input').val('');
            $('#schedule-day-label').text('');
        }

        $('#scheduleAddModal').modal('show');
    }

    $(document).on('submit', '#schedule-add-form', function (e) {
        e.preventDefault();
        if (!$('#sched-day-input').val()) {
            showToast('error', 'Please select a day.');
            return;
        }
        $.post('api/beatroute.php?action=schedule_add', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#scheduleAddModal').modal('hide');
                    loadWeekSchedule();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    $(document).on('click', '.schedule-chip-remove', function () {
        const id = $(this).data('id');
        if (!confirm('Remove this route from the schedule?')) return;
        $.post('api/beatroute.php?action=schedule_remove', { id })
            .done(function (res) {
                if (res.status === 'success') {
                    loadWeekSchedule();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // Add Route Button Trigger
    $(document).on('click', '#btn-add-route', function () {
        $('#route-id-input').val('');
        $('#route-name-input').val('');
        $('#route-modal-action-text').text('Create');
        $('#routeModal').modal('show');
    });

    // Edit Route Button Trigger
    $(document).on('click', '.btn-edit-route', function () {
        const id = $(this).data('id');
        const name = $(this).data('name');
        $('#route-id-input').val(id);
        $('#route-name-input').val(name);
        $('#route-modal-action-text').text('Edit');
        $('#routeModal').modal('show');
    });

    // Add/Edit Route Form Submission
    $(document).on('submit', '#route-form', function (e) {
        e.preventDefault();
        const id = $('#route-id-input').val();
        const action = id ? 'route_update' : 'route_create';
        $.post('api/beatroute.php?action=' + action, $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#routeModal').modal('hide');
                    $('#route-form')[0].reset();
                    loadBeatroutesList();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    // Delete Route
    $(document).on('click', '.btn-delete-route', function (e) {
        e.preventDefault();
        const id = $(this).data('id');
        if (confirm('Are you sure you want to delete this route? This will clear all retailer assignments for this route.')) {
            $.post('api/beatroute.php?action=route_delete', { id: id })
                .done(function (res) {
                    if (res.status === 'success') {
                        showToast('success', res.message);
                        loadBeatroutesList();
                    } else {
                        showToast('error', res.message);
                    }
                });
        }
    });

    // ----------------------------------------------------
    // MY BEAT ROUTE CONTROLLER (Staff Only)
    // ----------------------------------------------------
    function loadMyBeatRoute() {
        const grid       = $('#br-retailers-grid');
        const noRoute    = $('#br-no-routes');
        const dayName    = $('#br-day-name');
        const routeNames = $('#br-route-names');
        const retCount   = $('#br-retailer-count');

        $('#br-retailers-grid-pending').html('<div class="col-12 text-center py-5"><div class="spinner-border text-warning"></div><p class="text-secondary mt-2">Loading today\'s routes…</p></div>');
        $('#br-retailers-grid-completed').empty();
        noRoute.addClass('d-none');

        $.get('api/beatroute.php?action=staff_today_route', function (res) {
            $('#br-retailers-grid-pending').empty();
            $('#br-retailers-grid-completed').empty();

            if (res.status !== 'success') {
                showToast('error', res.message);
                return;
            }

            const day       = res.data.day;
            const schedules = res.data.schedules;
            const retailers = res.data.retailers;

            $('#br-day-label').text(day || '—');

            const gridPending = $('#br-retailers-grid-pending');
            const gridCompleted = $('#br-retailers-grid-completed');
            gridPending.empty();
            gridCompleted.empty();

            if (!schedules || schedules.length === 0) {
                routeNames.text('No routes scheduled');
                retCount.text('');
                noRoute.removeClass('d-none');
                return;
            }

            const rNames = [...new Set(schedules.map(s => s.route_name))].join(', ');
            routeNames.text(rNames);
            retCount.text(`${retailers.length} retailer${retailers.length !== 1 ? 's' : ''} to visit`);

            if (retailers.length === 0) {
                gridPending.html('<div class="col-12 text-center py-4 text-secondary"><i class="fas fa-store-slash fa-3x mb-3"></i><p>No active retailers found on your routes.</p></div>');
                gridCompleted.html('<div class="col-12 text-center py-4 text-secondary">No active retailers found.</div>');
                return;
            }

            retailers.forEach(function (r) {
                const outstanding = parseFloat(r.outstanding_amount || 0);
                const outBadge = outstanding > 0
                    ? `<span class="badge bg-danger ms-2">₹${outstanding.toLocaleString('en-IN')}</span>`
                    : `<span class="badge bg-success ms-2">Clear</span>`;
                    
                const isCompleted = r.today_order_id ? true : false;
                
                const orderBtnHtml = isCompleted 
                    ? `<button class="btn btn-sm btn-outline-warning flex-fill" onclick="window.location.hash='#orders'">
                           <i class="fas fa-eye me-1"></i> Edit / View Order
                       </button>`
                    : `<button class="btn btn-sm btn-outline-primary flex-fill br-new-order-btn" data-id="${r.id}" data-name="${r.shop_name}" data-route-id="${r.route_id}">
                           <i class="fas fa-shopping-basket me-1"></i> Order
                       </button>`;

                const cardHtml = `
                    <div class="col-md-6 col-lg-4">
                        <div class="custom-card h-100" style="border-left:3px solid ${isCompleted ? '#198754' : 'var(--accent)'}; opacity: ${isCompleted ? '0.8' : '1'};">
                            <div class="custom-card-body p-3">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div>
                                        <h6 class="fw-bold text-white mb-0">${r.shop_name}</h6>
                                        <small class="text-secondary">${r.owner_name}</small>
                                    </div>
                                    ${outBadge}
                                </div>
                                <div class="text-secondary small mb-1"><i class="fas fa-map-marker-alt me-1 text-warning"></i>${r.area}, ${r.city}</div>
                                <div class="text-secondary small mb-1"><i class="fas fa-road me-1 text-info"></i>${r.route_name}</div>
                                <div class="text-secondary small"><i class="fas fa-phone me-1 text-success"></i>${r.mobile || 'N/A'}</div>
                                <div class="mt-3 d-flex gap-2">
                                    <button class="btn btn-sm btn-outline-success flex-fill br-collection-btn" data-id="${r.id}" data-name="${r.shop_name}" data-outstanding="${outstanding}">
                                        <i class="fas fa-money-bill-wave me-1"></i> Collection
                                    </button>
                                    ${orderBtnHtml}
                                </div>
                            </div>
                        </div>
                    </div>
                `;
                
                if (isCompleted) {
                    gridCompleted.append(cardHtml);
                } else {
                    gridPending.append(cardHtml);
                }
            });
            
            if (gridPending.children().length === 0) {
                gridPending.html('<div class="col-12 text-center py-3 text-secondary">No pending visits!</div>');
            }
            if (gridCompleted.children().length === 0) {
                gridCompleted.html('<div class="col-12 text-center py-3 text-secondary">No completed visits today.</div>');
            }
            
        }).fail(function () {
            $('#br-retailers-grid-pending').html('<div class="col-12 text-center py-4 text-danger"><i class="fas fa-exclamation-triangle fa-2x mb-2"></i><p>Failed to load beat route data.</p></div>');
        });
    }

    $(document).on('click', '#btn-refresh-beatroute', function () {
        loadMyBeatRoute();
    });

    $(document).on('click', '.br-collection-btn', function () {
        const id = $(this).data('id');
        const name = $(this).data('name');
        const outstanding = $(this).data('outstanding');

        $('#br-col-retailer-id').val(id);
        $('#br-col-shop-name').val(name);
        $('#br-col-outstanding').val(outstanding);
        $('#br-col-amount').val(outstanding > 0 ? outstanding : 0);
        $('#br-collection-form')[0].reset();
        
        // Preserve values populated above
        $('#br-col-retailer-id').val(id);
        $('#br-col-shop-name').val(name);
        $('#br-col-outstanding').val(outstanding);
        $('#br-col-amount').val(outstanding > 0 ? outstanding : 0);

        $('#brCollectionModal').modal('show');
    });

    $(document).on('submit', '#br-collection-form', function (e) {
        e.preventDefault();
        $.post('api/payments.php?action=collect', $(this).serialize())
            .done(function (res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    $('#brCollectionModal').modal('hide');
                    loadMyBeatRoute();
                } else {
                    showToast('error', res.message);
                }
            })
            .fail(function () {
                showToast('error', 'Server error while processing payment.');
            });
    });

    $(document).on('click', '.br-new-order-btn', function () {
        const id = $(this).data('id');
        const routeId = $(this).data('route-id');
        window.pendingOrderRetailerId = id;
        window.pendingOrderRouteId = routeId;
        window.orderModeContext = 'By Route';
        window.location.hash = '#place_order';
    });

    $(document).on('click', '.edit-order-btn', function () {
        window.editOrderId = $(this).data('id');
        window.location.hash = '#place_order';
    });

    // ----------------------------------------------------
    // PLACE ORDER CONTROLLER (Staff Only)
    // ----------------------------------------------------
    let currentSkusData = [];

    function loadPlaceOrder() {
        if ($('#place-order-form').length > 0) {
            let isEditMode = false;
            let editId = null;
            if (window.editOrderId) {
                isEditMode = true;
                editId = window.editOrderId;
                window.editOrderId = null;
                $('#edit-order-id').val(editId);
                $('#btn-submit-order').html('<i class="fas fa-edit me-1"></i> Update Sales Order');
            } else {
                $('#edit-order-id').val('');
                $('#btn-submit-order').html('<i class="fas fa-check-circle me-1"></i> Place Sales Order');
                orderCart = [];
                renderOrderCartTable();
            }

            if (window.orderModeContext) {
                $('#ord-mode').val(window.orderModeContext);
                window.orderModeContext = null;
            } else {
                $('#ord-mode').val('By Call');
            }

            const isByRoute = $('#ord-mode').val() === 'By Route';
            
            // disable fields if By Route
            $('#ord-beatroute').prop('disabled', isByRoute);
            $('#ord-retailer').prop('disabled', isByRoute);
            
            $('#ord-retailer').empty().append('<option value="">-- Select Retailer Shop --</option>');

            populateDropdown('api/beatroute.php?action=my_routes', '#ord-beatroute', '-- All Routes --', 'id', 'route_name').done(function() {
                if (isByRoute && window.pendingOrderRouteId) {
                    $('#ord-beatroute').val(window.pendingOrderRouteId);
                    window.pendingOrderRouteId = null;
                    
                    let url = 'api/retailers.php?action=list&route_id=' + $('#ord-beatroute').val();
                    populateDropdown(url, '#ord-retailer', '-- Select Retailer Shop --', 'id', 'shop_name').done(function() {
                        if (window.pendingOrderRetailerId) {
                            $('#ord-retailer').val(window.pendingOrderRetailerId).trigger('change');
                            window.pendingOrderRetailerId = null;
                        }
                    });
                } else if (isEditMode) {
                    $.get(`api/orders.php?action=detail&id=${editId}`, function(res) {
                        if (res.status === 'success') {
                            const order = res.data;
                            const items = res.data.items || [];
                            
                            populateDropdown('api/retailers.php?action=list', '#ord-retailer', '-- Select Retailer Shop --', 'id', 'shop_name').done(function() {
                                $('#ord-retailer').val(order.retailer_id).trigger('change');
                            });
                            
                            $('#ord-remarks').val(order.remarks);
                            
                            orderCart = items.map(i => ({
                                id: i.sku_id,
                                name: i.sku_name || 'Item',
                                code: i.sku_code || '---',
                                price: parseFloat(i.price),
                                gst_pct: parseFloat(i.gst_percentage),
                                quantity: parseInt(i.quantity),
                                original_quantity: parseInt(i.quantity),
                                discount: parseInt(i.quantity) > 0 ? parseFloat(i.discount_amount) / parseInt(i.quantity) : 0,
                                discount_rules: []
                            }));
                            renderOrderCartTable();
                        }
                    });
                }
            });
            populateDropdown('api/suppliers.php?action=list', '#cart-supplier-select', '-- Select Supplier --', 'id', 'name');
            
            // Reset Cascading Drops
            $('#cart-category-select').html('<option value="">-- Select Category --</option>').prop('disabled', true);
            $('#cart-product-select').html('<option value="">-- Select Product --</option>').prop('disabled', true);
            $('#cart-sku-select').html('<option value="">-- Select SKU --</option>').prop('disabled', true);
            $('#cart-stock-count').val('0');
            $('#retailer-details-card').addClass('d-none');
            
            orderCart = [];
            currentSkusData = [];
            renderOrderCartTable();
        }
    }

    // Beat Route selection changed -> filter retailers
    $(document).on('change', '#ord-beatroute', function() {
        const routeId = $(this).val();
        let url = 'api/retailers.php?action=list';
        if (routeId) {
            url += '&route_id=' + routeId;
        }
        $('#ord-retailer').html('<option value="">Loading...</option>');
        populateDropdown(url, '#ord-retailer', '-- Select Retailer Shop --', 'id', 'shop_name');
        $('#retailer-details-card').addClass('d-none');
    });

    // Retailer selection changed -> load details
    $(document).on('change', '#ord-retailer', function() {
        const id = $(this).val();
        if (!id) {
            $('#retailer-details-card').addClass('d-none');
            return;
        }
        $.get(`api/retailers.php?action=detail&id=${id}`, function(res) {
            if(res.status === 'success') {
                const r = res.data;
                $('#rd-shop-name').text(r.shop_name);
                $('#rd-address').text(`${r.address}, ${r.area}, ${r.city}`);
                $('#rd-mobile').text(r.mobile || 'N/A');
                $('#rd-gst').text(r.gst_number || 'Unregistered');
                $('#retailer-details-card').removeClass('d-none');
            }
        });
    });

    // Supplier -> Category
    $(document).on('change', '#cart-supplier-select', function() {
        const sid = $(this).val();
        $('#cart-category-select').html('<option value="">-- Select Category --</option>').prop('disabled', true);
        $('#cart-product-select').html('<option value="">-- Select Product --</option>').prop('disabled', true);
        $('#cart-sku-select').html('<option value="">-- Select SKU --</option>').prop('disabled', true);
        $('#cart-stock-count').val('0');
        
        if (sid) {
            populateDropdown(`api/brands.php?action=list&supplier_id=${sid}`, '#cart-category-select', '-- Select Category --', 'id', 'name');
            $('#cart-category-select').prop('disabled', false);
        }
    });

    // Category -> Product
    $(document).on('change', '#cart-category-select', function() {
        const cid = $(this).val();
        $('#cart-product-select').html('<option value="">-- Select Product --</option>').prop('disabled', true);
        $('#cart-sku-select').html('<option value="">-- Select SKU --</option>').prop('disabled', true);
        $('#cart-stock-count').val('0');
        
        if (cid) {
            populateDropdown(`api/products.php?action=list&brand_id=${cid}`, '#cart-product-select', '-- Select Product --', 'id', 'name');
            $('#cart-product-select').prop('disabled', false);
        }
    });

    // Product -> SKU
    $(document).on('change', '#cart-product-select', function() {
        const pid = $(this).val();
        $('#cart-sku-select').html('<option value="">-- Select SKU --</option>').prop('disabled', true);
        $('#cart-stock-count').val('0');
        
        if (pid) {
            $.get(`api/skus.php?action=list&product_id=${pid}`, function(res) {
                if (res.status === 'success') {
                    currentSkusData = res.data;
                    let opts = '<option value="">-- Select SKU --</option>';
                    res.data.forEach(sku => {
                        opts += `<option value="${sku.id}">${sku.sku_name} (${sku.sku_code})</option>`;
                    });
                    $('#cart-sku-select').html(opts).prop('disabled', false);
                }
            });
        }
    });

    // SKU -> Stock count
    $(document).on('change', '#cart-sku-select', function() {
        const skuId = $(this).val();
        if (skuId) {
            const skuObj = currentSkusData.find(s => s.id == skuId);
            if (skuObj) {
                let stock = parseInt(skuObj.current_stock || 0);
                let inCart = 0;
                const existItem = orderCart.find(item => item.id == skuId);
                if (existItem) {
                    inCart = existItem.quantity;
                    if (existItem.original_quantity) stock += existItem.original_quantity;
                }
                $('#cart-stock-count').val(stock - inCart);
            }
        } else {
            $('#cart-stock-count').val('0');
        }
    });

    // Global Date Filter Extension for DataTables
    $.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
        const tableId = settings.nTable.id.replace('-table', '');
        
        const filterSelect = $('.dt-date-filter[data-table="' + tableId + '"]');
        if (filterSelect.length === 0) return true;
        
        const filterType = filterSelect.val();
        if (filterType === 'all') return true;
        
        const datePicker = $('.dt-date-picker[data-table="' + tableId + '"]');
        
        const dateColIndexes = {
            'orders': 3,
            'invoices': 2,
            'payments': 3,
            'supplier-payments': 1
        };
        
        const colIdx = dateColIndexes[tableId];
        if (colIdx === undefined) return true;
        
        let cellData = data[colIdx] || '';
        // Strip out any HTML tags if present
        cellData = cellData.replace(/(<([^>]+)>)/gi, "").trim();
        
        let rowDate = new Date(cellData);
        if (isNaN(rowDate.getTime())) {
            const parts = cellData.split('-');
            if (parts.length === 3) {
                if (parts[0].length === 4) { // YYYY-MM-DD
                    rowDate = new Date(parseInt(parts[0]), parseInt(parts[1])-1, parseInt(parts[2]));
                } else if (parts[2].length === 4) { // DD-MMM-YYYY or DD-MM-YYYY
                    const months = { 'Jan':0, 'Feb':1, 'Mar':2, 'Apr':3, 'May':4, 'Jun':5, 'Jul':6, 'Aug':7, 'Sep':8, 'Oct':9, 'Nov':10, 'Dec':11 };
                    const day = parseInt(parts[0], 10);
                    const month = months[parts[1]] !== undefined ? months[parts[1]] : parseInt(parts[1], 10) - 1;
                    const year = parseInt(parts[2], 10);
                    rowDate = new Date(year, month, day);
                }
            }
        }
        
        if (isNaN(rowDate.getTime())) return true;
        
        const today = new Date();
        today.setHours(0,0,0,0);
        
        const rowDateOnly = new Date(rowDate);
        rowDateOnly.setHours(0,0,0,0);
        
        if (filterType === 'today') {
            return rowDateOnly.getTime() === today.getTime();
        } else if (filterType === 'yesterday') {
            const yesterday = new Date(today);
            yesterday.setDate(yesterday.getDate() - 1);
            return rowDateOnly.getTime() === yesterday.getTime();
        } else if (filterType === 'this_week') {
            const firstDayOfWeek = new Date(today);
            const day = today.getDay() || 7;
            if (day !== 1) {
                firstDayOfWeek.setHours(-24 * (day - 1));
            } 
            return rowDateOnly >= firstDayOfWeek && rowDateOnly <= today;
        } else if (filterType === 'this_month') {
            return rowDateOnly.getMonth() === today.getMonth() && rowDateOnly.getFullYear() === today.getFullYear();
        } else if (filterType === 'specific') {
            const specificDateStr = datePicker.val();
            if (!specificDateStr) return true;
            const specificDate = new Date(specificDateStr);
            specificDate.setHours(0,0,0,0);
            return rowDateOnly.getTime() === specificDate.getTime();
        }
        
        return true;
    });

    $(document).on('change', '.dt-date-filter', function() {
        const tableId = $(this).data('table');
        const val = $(this).val();
        const datePicker = $('.dt-date-picker[data-table="' + tableId + '"]');
        if (val === 'specific') {
            datePicker.removeClass('d-none');
            if (!datePicker.val()) return; // Wait for user to select
        } else {
            datePicker.addClass('d-none');
        }
        if (datatables[tableId]) {
            datatables[tableId].draw();
        }
    });
    
    $(document).on('change', '.dt-date-picker', function() {
        const tableId = $(this).data('table');
        if (datatables[tableId]) {
            datatables[tableId].draw();
        }
    });
    
    // ======== SUPPLIER PAYMENTS LOGIC ========
    
    window.loadSupplierPayments = function() {
        $.get('api/supplier_payments.php?action=list')
            .done(function(res) {
                if (res.status === 'success') {
                    let html = '';
                    res.data.forEach(p => {
                        html += `
                            <tr>
                                <td>SP-${p.id}</td>
                                <td>${formatDate(p.payment_date)}</td>
                                <td>${p.supplier_name}</td>
                                <td>${p.payment_mode}</td>
                                <td>${p.reference_number || 'N/A'}</td>
                                <td class="text-end text-success fw-bold">${formatRupees(p.amount)}</td>
                                <td class="text-center">
                                    <button class="btn btn-danger btn-sm btn-delete-sp" data-id="${p.id}" title="Delete"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                        `;
                    });
                    
                    safeDestroyTable('supplier-payments-table');
                    $('#supplier-payments-rows').html(html);
                    datatables['supplier-payments-table'] = $('#supplier-payments-table').DataTable({
                        pageLength: 20,
                        order: [],
                        dom: 'Bfrtip',
                        buttons: [
                            {
                                extend: 'excelHtml5',
                                className: 'btn btn-action secondary btn-sm me-2',
                                text: '<i class="fas fa-file-excel"></i> Excel'
                            },
                            {
                                extend: 'pdfHtml5',
                                className: 'btn btn-action secondary btn-sm',
                                text: '<i class="fas fa-file-pdf"></i> PDF',
                                orientation: 'portrait',
                                pageSize: 'A4'
                            }
                        ]
                    });
                }
            });
    };

    $(document).on('click', '.btn-delete-sp', function() {
        if (!confirm("Are you sure you want to delete this payment?")) return;
        const id = $(this).data('id');
        
        $.post('api/supplier_payments.php?action=delete', { id: id })
            .done(function(res) {
                if (res.status === 'success') {
                    showToast('success', res.message);
                    loadSupplierPayments();
                } else {
                    showToast('error', res.message);
                }
            });
    });

    $(document).on('shown.bs.tab', '#supplier-payments-tab', function () {
        loadSupplierPayments();
    });

});
