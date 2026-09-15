<%@ Page Title="Login | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Login" %>


    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>


    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


        <!-- ==========================================
         LOGIN SECTION
         ========================================== -->

        <section class="py-5" style="background-color: #faf9f6;">

            <div class="container py-5">

                <div class="row justify-content-center">

                    <div class="col-md-10 col-lg-5" data-aos="fade-up" data-aos-duration="1000">


                        <!-- SUCCESS CONFIRMATION MESSAGE (OUTSIDE CARD: WHITE BG & GREEN TEXT) -->
                        <asp:Panel ID="pnlSuccessMsg" runat="server" Visible="false" ClientIDMode="Static"
                            CssClass="align-items-center gap-3 p-3 rounded-4 shadow-sm mb-4"
                            style="background-color: #ffffff !important; color: #15803d !important; border: 2px solid #22c55e; border-left: 6px solid #16a34a; display: flex !important;">
                            <div class="d-flex align-items-center justify-content-center rounded-circle flex-shrink-0"
                                style="width: 42px; height: 42px; background-color: #f0fdf4;">
                                <i class="bi bi-check-circle-fill fs-4" style="color: #16a34a;"></i>
                            </div>
                            <div class="flex-grow-1">
                                <strong class="d-block fw-bold" style="color: #15803d; font-size: 1rem;">Login
                                    Successfully!</strong>
                                <span class="small" style="color: #16a34a;">Welcome back. Redirecting to your luxury
                                    stay...</span>
                            </div>
                            <div class="spinner-border spinner-border-sm ms-auto" role="status"
                                style="width: 1.2rem; height: 1.2rem; color: #16a34a;">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </asp:Panel>

                        <!-- LOGIN CARD -->

                        <div class="auth-card">


                            <!-- ==========================================
                             CARD HEADER
                             ========================================== -->

                            <div class="auth-card-header text-center">

                                <div class="auth-icon-circle mx-auto mb-3">

                                    <i class="bi bi-person-lock"></i>

                                </div>


                                <h2 class="auth-card-title">Welcome Back
                                </h2>


                                <p class="auth-card-subtitle">
                                    Sign in to continue your luxury experience
                                </p>

                            </div>



                            <!-- ==========================================
                             CARD BODY
                             ========================================== -->

                            <div class="auth-card-body">

                                <!-- Browser Autofill Trap: absorbs unwanted saved credentials from browsers -->
                                <div style="position: absolute; top: -9999px; left: -9999px; width: 1px; height: 1px; overflow: hidden; opacity: 0; pointer-events: none;" aria-hidden="true">
                                    <input type="text" name="decoy_user_check" tabindex="-1" autocomplete="username" />
                                    <input type="password" name="decoy_pass_check" tabindex="-1" autocomplete="current-password" />
                                </div>


                                <!-- ==========================================
                                 EMAIL
                                 ========================================== -->

                                <div class="mb-4">

                                    <asp:Label ID="lblEmail" runat="server" Text="Email Address" CssClass="auth-label">
                                    </asp:Label>


                                    <div class="auth-input-wrapper">

                                        <i class="bi bi-envelope auth-input-icon"></i>


                                        <asp:TextBox ID="txtEmail" runat="server" ClientIDMode="Static"
                                            CssClass="form-control auth-input shadow-none" TextMode="Email"
                                            placeholder="your@email.com" autocomplete="off">
                                        </asp:TextBox>

                                    </div>


                                    <!-- Email Validation -->

                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                        ControlToValidate="txtEmail" ErrorMessage="Email address is required."
                                        CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>


                                </div>



                                <!-- ==========================================
                                 PASSWORD
                                 ========================================== -->

                                <div class="mb-3">


                                    <div class="d-flex justify-content-between align-items-center">


                                        <asp:Label ID="lblPassword" runat="server" Text="Password"
                                            CssClass="auth-label mb-0">
                                        </asp:Label>


                                        <!-- Forgot Password -->

                                        <asp:HyperLink ID="lnkForgotPassword" runat="server"
                                            NavigateUrl="~/ForgotPassword.aspx" Text="Forgot Password?"
                                            CssClass="auth-forgot-link">
                                        </asp:HyperLink>


                                    </div>



                                    <div class="auth-input-wrapper mt-2">


                                        <i class="bi bi-lock auth-input-icon"></i>


                                        <asp:TextBox ID="txtPassword" runat="server" ClientIDMode="Static"
                                            CssClass="form-control auth-input shadow-none" TextMode="Password"
                                            placeholder="Enter your password" autocomplete="new-password">
                                        </asp:TextBox>


                                        <!-- Password Toggle -->

                                        <button type="button" class="auth-toggle-password"
                                            onclick="togglePassword('txtPassword', this)">

                                            <i class="bi bi-eye"></i>

                                        </button>


                                    </div>


                                    <!-- Password Validation -->

                                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                                        ControlToValidate="txtPassword" ErrorMessage="Password is required."
                                        CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>


                                </div>



                                <!-- ==========================================
                                 REMEMBER ME
                                 ========================================== -->

                                <div class="d-flex align-items-center mb-4">

                                    <input type="checkbox" id="chkRemember" runat="server" ClientIDMode="Static"
                                        class="auth-checkbox" style="cursor: pointer;" />

                                    <label class="auth-check-label ms-2 mb-0" for="chkRemember"
                                        style="cursor: pointer;">
                                        Remember me
                                    </label>

                                </div>



                                <!-- ==========================================
                                 LOGIN BUTTON
                                 ========================================== -->

                                <asp:Button ID="btnLogin" runat="server" Text="SIGN IN"
                                    CssClass="btn auth-btn-primary w-100 mb-4" OnClick="btnLogin_Click" />



                                <!-- ==========================================
                                 DIVIDER
                                 ========================================== -->

                                <div class="auth-divider">

                                    <span>or continue with
                                    </span>

                                </div>



                                <!-- ==========================================
                                 GOOGLE LOGIN
                                 ========================================== -->

                                <div class="mb-4">


                                    <asp:Button ID="btnGoogleLogin" runat="server" Text="Continue with Google"
                                        CssClass="btn auth-btn-google w-100"
                                        OnClientClick="alert('Google Login functionality coming soon!'); return false;" />


                                </div>



                                <!-- ==========================================
                                 REGISTER LINK
                                 ========================================== -->

                                <p class="text-center auth-register-text mb-0">
                                    Don't have an account?


                                    <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Register.aspx"
                                        Text="Create Account" CssClass="auth-register-link">
                                    </asp:HyperLink>


                                </p>



                                <!-- ==========================================
                                 SERVER MESSAGE
                                 ========================================== -->

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



        <!-- ==========================================
         PASSWORD SHOW / HIDE
         ========================================== -->

        <script>

            function togglePassword(inputId, btn) {

                var input = document.getElementById(inputId);

                if (!input) {
                    return;
                }


                var icon = btn.querySelector("i");


                if (input.type === "password") {

                    input.type = "text";

                    icon.classList.remove("bi-eye");

                    icon.classList.add("bi-eye-slash");

                }
                else {

                    input.type = "password";

                    icon.classList.remove("bi-eye-slash");

                    icon.classList.add("bi-eye");

                }
            }
        </script>


    </asp:Content>