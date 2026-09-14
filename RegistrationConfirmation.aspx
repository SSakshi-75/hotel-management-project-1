<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="RegistrationConfirmation.aspx.cs" Inherits="RegistrationConfirmation" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <section class="py-5" style="background-color:#faf9f6; min-height:70vh;">

            <div class="container py-5">

                <div class="row justify-content-center">

                    <div class="col-md-7 col-lg-6">

                        <div class="card shadow-sm border-0 text-center p-5">

                            <div class="mb-4">
                                <i class="bi bi-check-circle-fill text-success" style="font-size:70px;"></i>
                            </div>

                            <h2 class="mb-3">
                                Registration Successful!
                            </h2>

                            <p class="text-muted mb-4">
                                Welcome to Hotel Management.
                                Your account has been created successfully.
                            </p>

                            <asp:Label ID="lblWelcome" runat="server" CssClass="fw-semibold d-block mb-4">
                            </asp:Label>

                            <div class="d-flex justify-content-center gap-2">

                                <a href="index.aspx" class="btn btn-outline-secondary">
                                    Go to Home
                                </a>

                                <a href="Room.aspx" class="btn btn-primary">
                                    Explore Rooms
                                </a>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </section>


    </asp:Content>