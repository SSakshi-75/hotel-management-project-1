<%@ Page Title="Login | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Login" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <!-- ==========================================
         2. LOGIN FORM SECTION
         ========================================== -->
        <section class="py-5" style="background-color: #faf9f6;">
            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-5" data-aos="fade-up" data-aos-duration="1000">

                        <div class="auth-card">
                            <!-- Card Header -->
                            <div class="auth-card-header text-center">
                                <div class="auth-icon-circle mx-auto mb-3">
                                    <i class="bi bi-person-circle"></i>
                                </div>
                                <h2 class="auth-card-title">Welcome Back</h2>
                                <p class="auth-card-subtitle">Sign in to access your guest account</p>
                            </div>

                            <!-- Card Body -->
                            <div class="auth-card-body">
                                <!-- Email -->
                                <div class="mb-4">
                                    <label for="loginEmail" class="auth-label">Email Address</label>
                                    <div class="auth-input-wrapper">
                                        <i class="bi bi-envelope auth-input-icon"></i>
                                        <input type="email" class="form-control auth-input shadow-none" id="loginEmail"
                                            placeholder="your@email.com" required>
                                    </div>
                                </div>

                                <!-- Password -->
                                <div class="mb-4">
                                    <label for="loginPassword" class="auth-label">Password</label>
                                    <div class="auth-input-wrapper">
                                        <i class="bi bi-lock auth-input-icon"></i>
                                        <input type="password" class="form-control auth-input shadow-none"
                                            id="loginPassword" placeholder="Enter your password" required>
                                        <button type="button" class="auth-toggle-password"
                                            onclick="togglePassword('loginPassword', this)">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Remember Me & Forgot Password -->
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div class="form-check">
                                        <input class="form-check-input auth-checkbox" type="checkbox" id="rememberMe">
                                        <label class="form-check-label auth-check-label" for="rememberMe">Remember
                                            me</label>
                                    </div>
                                    <a href="#" class="auth-forgot-link">Forgot Password?</a>
                                </div>

                                <!-- Login Button -->
                                <button type="button" class="btn auth-btn-primary w-100 mb-4"
                                    onclick="alert('Login functionality coming soon!');">
                                    <i class="bi bi-box-arrow-in-right me-2"></i> SIGN IN
                                </button>

                                <!-- Divider -->
                                <div class="auth-divider">
                                    <span>or continue with</span>
                                </div>

                                <!-- Google / Gmail Login -->
                                <div class="mb-4">
                                    <button type="button"
                                        class="btn auth-btn-google w-100 d-flex align-items-center justify-content-center gap-2"
                                        onclick="alert('Google Sign-in functionality coming soon!');">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                            viewBox="0 0 48 48" class="me-1">
                                            <path fill="#EA4335"
                                                d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z" />
                                            <path fill="#4285F4"
                                                d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z" />
                                            <path fill="#FBBC05"
                                                d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z" />
                                            <path fill="#34A853"
                                                d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z" />
                                            <path fill="none" d="M0 0h48v48H0z" />
                                        </svg>
                                        <span>Continue with Google</span>
                                    </button>
                                </div>

                                <!-- Register Link -->
                                <p class="text-center auth-register-text mb-0">
                                    Don't have an account? <a href="Register.aspx" class="auth-register-link">Create
                                        Account</a>
                                </p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </section>

        <script>
            function togglePassword(inputId, btn) {
                var input = document.getElementById(inputId);
                var icon = btn.querySelector('i');
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            }
        </script>

    </asp:Content>