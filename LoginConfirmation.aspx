<%@ Page Title="Login Confirmation | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="LoginConfirmation.aspx.cs" Inherits="LoginConfirmation" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <section class="py-5" style="background-color:#faf9f6; min-height:70vh;">

            <div class="container py-5">

                <div class="row justify-content-center">

                    <div class="col-md-7 col-lg-6">

                        <div class="card shadow-sm border-0 text-center p-5 rounded-4">

                            <div class="mb-4">
                                <i class="bi bi-check-circle-fill text-success" style="font-size:70px;"></i>
                            </div>

                            <h2 class="mb-3">
                                Login Successful!
                            </h2>

                            <p class="text-muted mb-4">
                                Welcome back to Hotel Management.
                                You have signed in to your account successfully.
                            </p>

                            <asp:Label ID="lblWelcome" runat="server" CssClass="fw-semibold d-block mb-4" style="font-size:1.15rem; color:#B88E68;">
                            </asp:Label>

                            <div class="d-flex justify-content-center gap-2 mb-3">

                                <a href="index.aspx" class="btn btn-outline-secondary px-4 py-2">
                                    Go to Home
                                </a>

                                <a href="Room.aspx" class="btn btn-primary px-4 py-2">
                                    Explore Rooms
                                </a>

                            </div>

                            <small class="text-muted" id="redirectText">
                                Redirecting to home page in <span id="countdown">3</span> seconds...
                            </small>

                        </div>

                    </div>

                </div>

            </div>

        </section>

        <script src="js/login-confirmation.js"></script>

    </asp:Content>
