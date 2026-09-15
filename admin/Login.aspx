<%@ Page Title="Admin Portal Login | Hotel Management" Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Admin_Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Portal Login | Hotel Management System</title>
    <meta name="description" content="Hotel Management System Executive Administrative Portal Sign In. Authorized personnel access only.">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Upright:wght@400;500;600;700&family=Plus+Jakarta+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 CSS CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    
    <!-- Bootstrap Icons CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Admin Login Custom CSS -->
    <link rel="stylesheet" type="text/css" href="css/login.css?v=9.0">
</head>
<body class="admin-login-body">
    <form id="formAdminLogin" runat="server" autocomplete="off">
        <!-- Browser Autofill Trap: absorbs unwanted saved credentials from browsers -->
        <div style="position: absolute; top: -9999px; left: -9999px; width: 1px; height: 1px; overflow: hidden; opacity: 0; pointer-events: none;" aria-hidden="true">
            <input type="text" name="decoy_user_field" tabindex="-1" autocomplete="username" />
            <input type="password" name="decoy_pass_field" tabindex="-1" autocomplete="current-password" />
        </div>

        <!-- ==========================================
             DEDICATED ADMIN LOGIN PORTAL
             ========================================== -->
        <div class="admin-login-viewport">
            <div class="container py-4">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-10 col-lg-8 col-xl-7 d-flex flex-column align-items-center">

                        <!-- Success Confirmation Message (Outside Card: White BG & Green Text) -->
                        <div id="adminSuccessMsg" class="d-none align-items-center gap-3 p-3 rounded-3 shadow-lg mb-3" role="alert"
                             style="width: 100%; max-width: 640px; background-color: #ffffff !important; color: #15803d !important; border: 2px solid #22c55e; border-left: 6px solid #16a34a;">
                            <div class="d-flex align-items-center justify-content-center rounded-circle flex-shrink-0" style="width: 40px; height: 40px; background-color: #f0fdf4;">
                                <i class="bi bi-check-circle-fill fs-4" style="color: #16a34a;"></i>
                            </div>
                            <div class="flex-grow-1">
                                <strong class="d-block fw-bold" style="color: #15803d; font-size: 1rem;">Admin Login Successfully!</strong>
                                <span class="small" style="color: #16a34a;">Authentication confirmed. Redirecting to Executive Dashboard...</span>
                            </div>
                            <div class="spinner-border spinner-border-sm ms-auto" role="status" style="width: 1.2rem; height: 1.2rem; color: #16a34a;">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </div>

                        <!-- Luxury Admin Login Card -->
                        <div class="admin-login-card shadow-lg">

                            <!-- Header -->
                            <div class="card-header-luxury">
                                <a href="../index.aspx" title="Hotel Management" class="d-inline-block">
                                    <img src="../images/logo.png" alt="Hotel Logo" class="card-logo"
                                        onerror="this.onerror=null; this.src='../images/main-logo.png';">
                                </a>
                                <div>
                                    <span class="security-badge">
                                        <i class="bi bi-shield-lock-fill"></i> Restricted &bull; Admin Portal
                                    </span>
                                </div>
                                <h1 class="card-title-text">Admin Sign In</h1>
                                <p class="card-subtitle-text">Hotel Management Executive Console Access</p>
                            </div>

                            <!-- Body (Login Form) -->
                            <div class="card-body-luxury">

                                <!-- Alert Message (Error) -->
                                <div id="adminAlertMsg" class="alert alert-danger py-2 px-3 small d-none mb-3" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-1"></i>
                                    <span id="adminAlertText">Please enter your credentials.</span>
                                </div>

                                <!-- Email or Staff ID -->
                                <div class="mb-3">
                                    <label for="adminEmail" class="input-label">Email or Staff ID</label>
                                    <div class="input-wrapper">
                                        <i class="bi bi-person-badge input-icon"></i>
                                        <input type="text" class="custom-form-control shadow-none" id="adminEmail"
                                            placeholder="Enter your Email or Staff ID" autocomplete="off" required>
                                    </div>
                                </div>

                                <!-- Password -->
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <label for="adminPassword" class="input-label mb-0">Password</label>
                                        <a href="javascript:void(0);"
                                            onclick="alert('For security, administrator password resets require IT authorization. Please contact the IT Administration Department.');"
                                            class="forgot-link">
                                            Forgot password?
                                        </a>
                                    </div>
                                    <div class="input-wrapper">
                                        <i class="bi bi-key-fill input-icon"></i>
                                        <input type="password" class="custom-form-control shadow-none"
                                            id="adminPassword" placeholder="Enter security key / password"
                                            autocomplete="new-password" required>
                                        <button type="button" class="toggle-pw-btn"
                                            onclick="toggleAdminPasswordVisibility('adminPassword', this)"
                                            title="Show/Hide Password">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Remember Terminal & SSL Badge -->
                                <div class="mb-4 d-flex justify-content-between align-items-center">
                                    <div class="form-check mb-0">
                                        <input class="form-check-input custom-checkbox shadow-none" type="checkbox"
                                            id="rememberWorkstation" checked>
                                        <label class="form-check-label text-muted small ms-1" for="rememberWorkstation">
                                            Remember this terminal
                                        </label>
                                    </div>
                                    <span class="badge bg-light text-success border py-1 px-2 small">
                                        <i class="bi bi-check-circle-fill me-1"></i>SSL Encrypted
                                    </span>
                                </div>

                                <!-- Submit Button -->
                                <button type="button" id="btnAdminSubmit" class="btn-theme-submit mb-3"
                                    onclick="handleAdminLoginSubmit();">
                                    <i class="bi bi-box-arrow-in-right fs-5"></i>
                                    <span>Sign In to Console</span>
                                </button>

                                <!-- Security Compliance Footer -->
                                <div class="security-footer-note">
                                    <div class="mb-2 small text-muted">
                                        <i class="bi bi-shield-check text-success me-1"></i>
                                        <span>256-Bit SSL Encrypted Connection &bull; Authorized Personnel Only</span>
                                    </div>
                                    <a href="../index.aspx" class="back-link">
                                        <i class="bi bi-arrow-left me-1"></i> Return to Public Website
                                    </a>
                                </div>

                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>

    </form>

    <!-- Bootstrap 5 JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Admin Custom JS -->
    <script src="js/login.js?v=5.0"></script>
</body>
</html>