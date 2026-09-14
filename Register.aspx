<%@ Page Title="Register | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Register" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <!-- ==========================================
     2. REGISTRATION FORM SECTION
     ========================================== -->
        <section class="py-5" style="background-color: #faf9f6;">

            <div class="container py-5">

                <div class="row justify-content-center">

                    <div class="col-md-10 col-lg-6" data-aos="fade-up" data-aos-duration="1000">

                        <div class="auth-card">

                            <!-- Card Header -->
                            <div class="auth-card-header text-center">

                                <div class="auth-icon-circle mx-auto mb-3">
                                    <i class="bi bi-person-plus"></i>
                                </div>

                                <h2 class="auth-card-title">
                                    Create Account
                                </h2>

                                <p class="auth-card-subtitle">
                                    Join us for an unforgettable luxury experience
                                </p>

                            </div>


                            <!-- Card Body -->
                            <div class="auth-card-body">

                                <!-- First Name + Last Name -->
                                <div class="row g-3 mb-4">

                                    <!-- First Name -->
                                    <div class="col-md-6">

                                        <label class="auth-label">
                                            First Name
                                        </label>

                                        <div class="auth-input-wrapper">

                                            <i class="bi bi-person auth-input-icon"></i>

                                            <asp:TextBox ID="txtFirstName" runat="server"
                                                CssClass="form-control auth-input shadow-none" placeholder="First name">
                                            </asp:TextBox>

                                        </div>

                                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                                            ControlToValidate="txtFirstName" ErrorMessage="First name is required."
                                            CssClass="text-danger small" Display="Dynamic">
                                        </asp:RequiredFieldValidator>

                                    </div>


                                    <!-- Last Name -->
                                    <div class="col-md-6">

                                        <label class="auth-label">
                                            Last Name
                                        </label>

                                        <div class="auth-input-wrapper">

                                            <i class="bi bi-person auth-input-icon"></i>

                                            <asp:TextBox ID="txtLastName" runat="server"
                                                CssClass="form-control auth-input shadow-none" placeholder="Last name">
                                            </asp:TextBox>

                                        </div>

                                        <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                                            ControlToValidate="txtLastName" ErrorMessage="Last name is required."
                                            CssClass="text-danger small" Display="Dynamic">
                                        </asp:RequiredFieldValidator>

                                    </div>

                                </div>


                                <!-- Email -->
                                <div class="mb-4">

                                    <label class="auth-label">
                                        Email Address
                                    </label>

                                    <div class="auth-input-wrapper">

                                        <i class="bi bi-envelope auth-input-icon"></i>

                                        <asp:TextBox ID="txtEmail" runat="server"
                                            CssClass="form-control auth-input shadow-none" TextMode="Email"
                                            placeholder="your@email.com">
                                        </asp:TextBox>

                                    </div>

                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                        ControlToValidate="txtEmail" ErrorMessage="Email address is required."
                                        CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>

                                </div>


                                <!-- Phone -->
                                <div class="mb-4">

                                    <label class="auth-label">
                                        Phone Number
                                    </label>

                                    <div class="auth-input-wrapper">

                                        <i class="bi bi-telephone auth-input-icon"></i>

                                        <asp:TextBox ID="txtPhone" runat="server"
                                            CssClass="form-control auth-input shadow-none" TextMode="Phone"
                                            MaxLength="10" placeholder="+91 XXXXX XXXXX">
                                        </asp:TextBox>

                                    </div>

                                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                                        ControlToValidate="txtPhone" ErrorMessage="Phone number is required."
                                        CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>

                                </div>


                                <!-- Password -->
                                <div class="mb-4">

                                    <label class="auth-label">
                                        Password
                                    </label>

                                    <div class="auth-input-wrapper">

                                        <i class="bi bi-lock auth-input-icon"></i>

                                        <asp:TextBox ID="txtPassword" runat="server" ClientIDMode="Static"
                                            CssClass="form-control auth-input shadow-none" TextMode="Password"
                                            placeholder="Create a password">
                                        </asp:TextBox>

                                        <button type="button" class="auth-toggle-password"
                                            onclick="togglePassword('txtPassword', this)">

                                            <i class="bi bi-eye"></i>

                                        </button>

                                    </div>

                                    <small class="text-muted d-block mt-1" style="font-size: 0.75rem;">

                                        Must be at least 8 characters

                                    </small>

                                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                                        ControlToValidate="txtPassword" ErrorMessage="Password is required."
                                        CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>

                                </div>


                                <!-- Confirm Password -->
                                <div class="mb-4">

                                    <label class="auth-label">
                                        Confirm Password
                                    </label>

                                    <div class="auth-input-wrapper">

                                        <i class="bi bi-shield-lock auth-input-icon"></i>

                                        <asp:TextBox ID="txtConfirmPassword" runat="server" ClientIDMode="Static"
                                            CssClass="form-control auth-input shadow-none" TextMode="Password"
                                            placeholder="Confirm your password">
                                        </asp:TextBox>

                                        <button type="button" class="auth-toggle-password"
                                            onclick="togglePassword('txtConfirmPassword', this)">

                                            <i class="bi bi-eye"></i>

                                        </button>

                                    </div>

                                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                                        ControlToValidate="txtConfirmPassword"
                                        ErrorMessage="Please confirm your password." CssClass="text-danger small"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>

                                    <asp:CompareValidator ID="cvConfirmPassword" runat="server"
                                        ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword"
                                        ErrorMessage="Passwords do not match." CssClass="text-danger small"
                                        Display="Dynamic">
                                    </asp:CompareValidator>

                                </div>


                                <!-- Terms Agreement -->
                                <div class="form-check mb-4">

                                    <input type="checkbox" id="chkTerms" runat="server" ClientIDMode="Static"
                                        class="form-check-input auth-checkbox" />

                                    <label class="form-check-label auth-check-label" for="chkTerms">

                                        I agree to the

                                        <a href="Terms.aspx" class="auth-forgot-link">
                                            Terms & Conditions
                                        </a>

                                        and

                                        <a href="Privacy.aspx" class="auth-forgot-link">
                                            Privacy Policy
                                        </a>

                                    </label>

                                    <div>
                                        <asp:CustomValidator ID="cvTerms" runat="server"
                                            ErrorMessage="Please agree to Terms & Conditions and Privacy Policy."
                                            CssClass="text-danger small" Display="Dynamic"
                                            ClientValidationFunction="validateTerms"
                                            OnServerValidate="cvTerms_ServerValidate">
                                        </asp:CustomValidator>
                                    </div>

                                </div>


                                <!-- Register Button -->
                                <asp:Button ID="btnRegister" runat="server" CssClass="btn auth-btn-primary w-100 mb-4"
                                    Text="CREATE ACCOUNT" OnClick="btnRegister_Click" />


                                <!-- Divider -->
                                <div class="auth-divider">
                                    <span>or sign up with</span>
                                </div>


                                <!-- Google Signup -->
                                <div class="mb-4">

                                    <button type="button"
                                        class="btn auth-btn-google w-100 d-flex align-items-center justify-content-center gap-2"
                                        onclick="alert('Google Sign-up functionality coming soon!');">

                                        <!-- Aapka existing Google SVG yahan same rahega -->

                                        <span>Sign up with Google</span>

                                    </button>

                                </div>


                                <!-- Login Link -->
                                <p class="text-center auth-register-text mb-0">

                                    Already have an account?

                                    <a href="Login.aspx" class="auth-register-link">
                                        Sign In
                                    </a>

                                </p>


                                <!-- Server Message -->
                                <div class="text-center mt-3">

                                    <asp:Label ID="lblMessage" runat="server">
                                    </asp:Label>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </section>

        <script>
            function togglePassword(inputId, btn) {
                var input = document.getElementById(inputId) ||
                            (btn && btn.closest('.auth-input-wrapper') ? btn.closest('.auth-input-wrapper').querySelector('input') : null);
                if (!input) return;
                var icon = btn ? btn.querySelector('i') : null;
                if (input.type === 'password') {
                    input.type = 'text';
                    if (icon) {
                        icon.classList.remove('bi-eye');
                        icon.classList.add('bi-eye-slash');
                    }
                } else {
                    input.type = 'password';
                    if (icon) {
                        icon.classList.remove('bi-eye-slash');
                        icon.classList.add('bi-eye');
                    }
                }
            }

            function validateTerms(source, args) {
                var chk = document.getElementById('chkTerms');
                args.IsValid = chk && chk.checked;
            }
        </script>

    </asp:Content>