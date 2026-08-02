<!-- views/login.php -->
<!-- Glassmorphic Login Screen -->
<div class="login-body">
    <div class="login-card">
        <div class="text-center mb-4">
            <h2 class="fw-extrabold text-white mb-1" style="letter-spacing: 0.5px;">NAVtara</h2>
            <p class="text-muted small text-uppercase fw-bold">Enterprises ERP Portal</p>
        </div>
        
        <form id="login-form">
            <div class="mb-3">
                <label for="login-username" class="form-label-custom text-white-50">Username</label>
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0 border-secondary text-secondary"><i class="fas fa-user"></i></span>
                    <input type="text" id="login-username" class="form-control bg-transparent text-white border-start-0 border-secondary" placeholder="Enter username" required autocomplete="username">
                </div>
            </div>
            
            <div class="mb-4">
                <label for="login-password" class="form-label-custom text-white-50">Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0 border-secondary text-secondary"><i class="fas fa-lock"></i></span>
                    <input type="password" id="login-password" class="form-control bg-transparent text-white border-start-0 border-secondary" placeholder="Enter password" required autocomplete="current-password">
                </div>
            </div>
            
            <button type="submit" class="btn btn-action primary w-100 justify-content-center py-2 fs-5">
                Log In <i class="fas fa-sign-in-alt ms-1"></i>
            </button>
        </form>
    </div>
</div>
