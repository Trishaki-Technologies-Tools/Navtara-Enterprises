<?php
// config/setup.php
// ERP Setup / Database Installation Script

require_once __DIR__ . '/database.php';

header('Content-Type: text/plain');
echo "==================================================\n";
echo "       NAVtara ERP - Installation Setup           \n";
echo "==================================================\n\n";

try {
    // 1. Connect to MySQL Server without database to create it
    echo "Connecting to MySQL server...\n";
    $pdo = getDBConnection();
    
    // 2. Load database.sql content
    $sqlFile = __DIR__ . '/../database.sql';
    if (!file_exists($sqlFile)) {
        die("Error: database.sql not found at " . $sqlFile . "\n");
    }
    
    echo "Reading database.sql...\n";
    $sql = file_get_contents($sqlFile);
    
    echo "Creating database structure...\n";
    // We execute the SQL schema queries
    $pdo->exec($sql);
    echo "Database structure created successfully.\n\n";
    
    // Reconnect specifically to navtara_erp now that it is created
    $db = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4", DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);
    
    // 3. Seed Users
    echo "Seeding Users (with secure password hashing)...\n";
    
    // Check if seeded already
    $check = $db->query("SELECT COUNT(*) FROM users")->fetchColumn();
    if ($check == 0) {
        // Insert Admin/Owner
        $adminPassword = password_hash('admin123', PASSWORD_BCRYPT);
        $stmt = $db->prepare("INSERT INTO users (role_id, username, password_hash, fullname, email, mobile, status) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([1, 'owner', $adminPassword, 'Rajesh Naik (Owner)', 'owner@navtara.com', '9822112233', 'Active']);
        
        // Insert Sales Staff 1
        $sales1Password = password_hash('sales123', PASSWORD_BCRYPT);
        $stmt->execute([2, 'sales1', $sales1Password, 'Amit Fernandes', 'amit@navtara.com', '9855443322', 'Active']);
        $sales1UserId = $db->lastInsertId();
        
        // Insert Sales Staff 2
        $sales2Password = password_hash('sales123', PASSWORD_BCRYPT);
        $stmt->execute([2, 'sales2', $sales2Password, 'Deepak Chodankar', 'deepak@navtara.com', '9899887766', 'Active']);
        $sales2UserId = $db->lastInsertId();
        
        // Insert Sales Staff Details
        $stmtDetails = $db->prepare("INSERT INTO sales_staff_details (user_id, assigned_area, salary, sales_target, joining_date) VALUES (?, ?, ?, ?, ?)");
        $stmtDetails->execute([$sales1UserId, 'Panaji & North Goa', 25000.00, 150000.00, '2026-01-10']);
        $stmtDetails->execute([$sales2UserId, 'Margao & South Goa', 24000.00, 120000.00, '2026-02-15']);
        
        echo "Users seeded: \n";
        echo "  - Owner: Username 'owner' / Password 'admin123'\n";
        echo "  - Sales Staff 1: Username 'sales1' / Password 'sales123'\n";
        echo "  - Sales Staff 2: Username 'sales2' / Password 'sales123'\n\n";
    } else {
        echo "Users already seeded. Skipping.\n\n";
    }
    
    // 4. Seed Brands
    echo "Seeding Brands...\n";
    $checkBrands = $db->query("SELECT COUNT(*) FROM brands")->fetchColumn();
    if ($checkBrands == 0) {
        $db->exec("INSERT INTO brands (name, logo, description, status) VALUES 
            ('Nestle India', NULL, 'Nestle packaged foods, Maggi, Nescafe, etc.', 'Active'),
            ('Hindustan Unilever', NULL, 'HUL consumer goods, Surf, Dove, Knorr, etc.', 'Active'),
            ('Amul', NULL, 'Dairy products, milk, cheese, ghee, etc.', 'Active'),
            ('Tata Consumer Products', NULL, 'Tata tea, salt, pulses', 'Active')");
        echo "Brands seeded successfully.\n\n";
    } else {
        echo "Brands already seeded. Skipping.\n\n";
    }
    
    // 5. Seed Products
    echo "Seeding Products...\n";
    $checkProducts = $db->query("SELECT COUNT(*) FROM products")->fetchColumn();
    if ($checkProducts == 0) {
        // Nestle Products (Brand 1)
        $db->exec("INSERT INTO products (brand_id, name, description, gst_percentage, hsn_code, status) VALUES 
            (1, 'Maggi 2-Minute Noodles', 'Instant wheat noodles with masala taste maker', 18.00, '19023010', 'Active'),
            (1, 'Nescafe Classic Coffee', '100% pure soluble coffee powder', 18.00, '21011110', 'Active')");
            
        // HUL Products (Brand 2)
        $db->exec("INSERT INTO products (brand_id, name, description, gst_percentage, hsn_code, status) VALUES 
            (2, 'Surf Excel Easy Wash', 'Detergent powder for easy dirt removal', 18.00, '34029019', 'Active'),
            (2, 'Dove Cream Beauty Bar', 'Soap bar with moisturizing cream', 18.00, '34011110', 'Active')");
            
        // Amul Products (Brand 3)
        $db->exec("INSERT INTO products (brand_id, name, description, gst_percentage, hsn_code, status) VALUES 
            (3, 'Amul Pure Ghee', 'Traditional clarified butter', 12.00, '04059020', 'Active'),
            (3, 'Amul Salted Butter', 'Pasteurized table butter', 12.00, '04051000', 'Active')");
            
        echo "Products seeded successfully.\n\n";
    } else {
        echo "Products already seeded. Skipping.\n\n";
    }
    
    // 6. Seed SKUs
    echo "Seeding Product SKUs & Initial Inventory...\n";
    $checkSkus = $db->query("SELECT COUNT(*) FROM skus")->fetchColumn();
    if ($checkSkus == 0) {
        // Maggi SKUs (Product 1)
        $db->exec("INSERT INTO skus (product_id, sku_name, sku_code, purchase_price, selling_price, mrp, gst_percentage, unit, weight, size, current_stock, minimum_stock, status) VALUES 
            (1, 'Maggi Noodles 70g Pack', 'MAGGI-70G', 11.20, 12.50, 14.00, 18.00, 'Pcs', '70g', 'Small', 500, 50, 'Active'),
            (1, 'Maggi Noodles 280g (4-Pack)', 'MAGGI-280G', 44.50, 49.00, 56.00, 18.00, 'Pcs', '280g', 'Medium', 200, 20, 'Active')");
            
        // Nescafe SKUs (Product 2)
        $db->exec("INSERT INTO skus (product_id, sku_name, sku_code, purchase_price, selling_price, mrp, gst_percentage, unit, weight, size, current_stock, minimum_stock, status) VALUES 
            (2, 'Nescafe Classic Jar 50g', 'NESCAFE-50G', 125.00, 140.00, 160.00, 18.00, 'Pcs', '50g', 'Small', 100, 10, 'Active'),
            (2, 'Nescafe Classic Jar 100g', 'NESCAFE-100G', 230.00, 260.00, 290.00, 18.00, 'Pcs', '100g', 'Medium', 80, 10, 'Active')");
            
        // Surf Excel SKUs (Product 3)
        $db->exec("INSERT INTO skus (product_id, sku_name, sku_code, purchase_price, selling_price, mrp, gst_percentage, unit, weight, size, current_stock, minimum_stock, status) VALUES 
            (3, 'Surf Excel Easy Wash 1Kg', 'SURF-1KG', 120.00, 135.00, 150.00, 18.00, 'Pcs', '1Kg', 'Large', 150, 15, 'Active'),
            (3, 'Surf Excel Easy Wash 500g', 'SURF-500G', 65.00, 72.00, 80.00, 18.00, 'Pcs', '500g', 'Medium', 200, 15, 'Active')");
            
        // Amul Ghee SKUs (Product 5)
        $db->exec("INSERT INTO skus (product_id, sku_name, sku_code, purchase_price, selling_price, mrp, gst_percentage, unit, weight, size, current_stock, minimum_stock, status) VALUES 
            (5, 'Amul Ghee Tin 1L', 'AMULGHEE-1L', 580.00, 620.00, 680.00, 12.00, 'Pcs', '1L', '1L Tin', 120, 12, 'Active'),
            (5, 'Amul Ghee Tin 5L', 'AMULGHEE-5L', 2800.00, 3050.00, 3350.00, 12.00, 'Pcs', '5L', '5L Tin', 30, 5, 'Active')");
            
        // Log Opening Stock in Inventory History
        $skus = $db->query("SELECT id, current_stock FROM skus")->fetchAll();
        $stmtHist = $db->prepare("INSERT INTO inventory_history (sku_id, transaction_type, quantity, previous_stock, new_stock, remarks) VALUES (?, ?, ?, ?, ?, ?)");
        foreach ($skus as $sku) {
            $stmtHist->execute([$sku['id'], 'Opening Stock', $sku['current_stock'], 0, $sku['current_stock'], 'Initial seed opening stock']);
        }
        
        echo "SKUs and initial stock seeded successfully.\n\n";
    } else {
        echo "SKUs already seeded. Skipping.\n\n";
    }
    
    // 7. Seed Retailers
    echo "Seeding Retailers...\n";
    $checkRetailers = $db->query("SELECT COUNT(*) FROM retailers")->fetchColumn();
    if ($checkRetailers == 0) {
        $db->exec("INSERT INTO retailers (name, owner_name, shop_name, gst_number, mobile, alternate_mobile, email, address, area, city, state, pin_code, business_type, assigned_staff_id, credit_limit, outstanding_amount, opening_balance, status) VALUES 
            ('Varun Pai', 'Varun Pai', 'Varun General Store', '30ABCDE1234F1Z0', '9811002233', NULL, 'varun@gmail.com', 'Shop No. 4, MG Road', 'Panaji', 'Panaji', 'Goa', '403001', 'General Store', 2, 50000.00, 0.00, 0.00, 'Active'),
            ('Sylvester Dsouza', 'Sylvester Dsouza', 'Dsouza Supermarket', '30FGHIJ5678K2Z1', '9844005566', '9822334455', 'sylvester@dsouza.com', 'Near Holy Spirit Church', 'Margao', 'Margao', 'Goa', '403601', 'Super Market', 3, 75000.00, 0.00, 0.00, 'Active'),
            ('Dr. Nitin Kamat', 'Nitin Kamat', 'Kamat Medicals', NULL, '9899001122', NULL, NULL, 'Behind District Hospital', 'Mapusa', 'Mapusa', 'Goa', '403507', 'Medical', 2, 20000.00, 0.00, 0.00, 'Active')");
            
        // Log Opening Balances in Customer Ledger
        $retailers = $db->query("SELECT id, name FROM retailers")->fetchAll();
        $stmtLedger = $db->prepare("INSERT INTO customer_ledger (retailer_id, transaction_type, transaction_date, reference_id, reference_type, debit_amount, credit_amount, balance, remarks) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
        foreach ($retailers as $ret) {
            $stmtLedger->execute([$ret['id'], 'Opening Balance', date('Y-m-d'), NULL, 'None', 0.00, 0.00, 0.00, 'Opening balance set to 0']);
        }
        
        echo "Retailers seeded successfully.\n\n";
    } else {
        echo "Retailers already seeded. Skipping.\n\n";
    }
    
    echo "==================================================\n";
    echo "           SETUP COMPLETED SUCCESSFULLY           \n";
    echo "==================================================\n";

} catch (PDOException $e) {
    die("MySQL Database Error: " . $e->getMessage() . "\n");
}
?>
