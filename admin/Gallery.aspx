<%@ Page Title="Photo Gallery Management | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Gallery.aspx.cs" Inherits="Admin_Gallery" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
        <meta name="description" content="Hotel Management Photo Gallery Administration">
        <link rel="stylesheet" type="text/css" href="css/addroom.css">
        <style>
            .gallery-thumb-img {
                width: 75px;
                height: 52px;
                object-fit: cover;
                border-radius: 8px;
                border: 1.5px solid #cbd5e1;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
            }

            .btn-luxury-upload {
                background: linear-gradient(135deg, #442305 0%, #6a390a 100%);
                color: #ffffff;
                border: 1px solid #7c440f;
                border-radius: 12px;
                padding: 12px 24px;
                font-size: 0.92rem;
                font-weight: 700;
                letter-spacing: 0.5px;
                box-shadow: 0 4px 14px rgba(68, 35, 5, 0.22);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: inline-flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
            }

            .btn-luxury-upload:hover {
                background: linear-gradient(135deg, #5c3008 0%, #85480d 100%);
                color: #ffffff;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(68, 35, 5, 0.35);
            }

            .btn-luxury-upload:active {
                transform: translateY(0);
                box-shadow: 0 2px 8px rgba(68, 35, 5, 0.2);
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

        <!-- Page Header & Navigation -->
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">
                    Photo Gallery Management
                </h2>
                <p class="text-muted small mb-0">
                    Upload new resort photos, organize by category, and delete existing gallery images in a unified
                    dashboard form.
                </p>
            </div>
            <a href="Dashboard.aspx" class="btn-admin-secondary text-decoration-none">
                <i class="bi bi-grid-fill me-1"></i> Back to Dashboard
            </a>
        </div>
        <!-- RegistrationConfirmation.aspx Style Success Confirmation Card -->
        <asp:Panel ID="pnlSuccessMessage" runat="server" Visible="false" CssClass="mb-4">
            <div class="card shadow-sm border-0 text-center p-4 rounded-4 bg-white">
                <div class="mb-3">
                    <i class="bi bi-check-circle-fill text-success" style="font-size:60px;"></i>
                </div>
                <h3 class="fw-bold text-dark mb-2" style="font-family: 'Playfair Display', Georgia, serif;">
                    <asp:Label ID="lblSuccessTitle" runat="server" Text="Action Successful!"></asp:Label>
                </h3>
                <p class="text-muted mb-3">
                    <asp:Label ID="lblSuccessMessage" runat="server"
                        Text="Your gallery photo has been saved to the database and published successfully.">
                    </asp:Label>
                </p>
                <div>
                    <button type="button" class="btn btn-sm btn-outline-secondary px-4 rounded-pill fw-semibold"
                        onclick="this.closest('.card').style.display='none';">
                        <i class="bi bi-x-lg me-1"></i> Close Confirmation
                    </button>
                </div>
            </div>
        </asp:Panel>

        <!-- Error Alert Message -->
        <asp:Panel ID="pnlErrorMessage" runat="server" Visible="false"
            CssClass="alert alert-danger alert-dismissible fade show rounded-4 mb-4 shadow-sm" role="alert">
            <div class="d-flex align-items-center gap-3">
                <i class="bi bi-exclamation-triangle-fill fs-3 text-danger"></i>
                <div>
                    <strong class="d-block text-dark">Notice / Error</strong>
                    <asp:Label ID="lblErrorMessage" runat="server" CssClass="small text-danger"></asp:Label>
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <!-- Auto-Dismiss Script for Confirmation and Error Messages -->
        <script>
            (function () {
                function setupAutoDismiss(elemId, delayMs) {
                    var elem = document.getElementById(elemId);
                    if (elem) {
                        setTimeout(function () {
                            elem.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                            elem.style.opacity = '0';
                            elem.style.transform = 'translateY(-10px)';
                            setTimeout(function () {
                                elem.style.display = 'none';
                            }, 600);
                        }, delayMs);
                    }
                }
                function triggerDismiss() {
                    setupAutoDismiss('<%= pnlSuccessMessage.ClientID %>', 3500);
                    setupAutoDismiss('<%= pnlErrorMessage.ClientID %>', 4500);
                }
                if (document.readyState === 'loading') {
                    document.addEventListener('DOMContentLoaded', triggerDismiss);
                } else {
                    triggerDismiss();
                }
            })();
        </script>

        <!-- Upload Photo Form Card (Matching Executive Theme) -->
        <div class="add-room-card mb-4">
            <div class="add-room-header">
                <h4 class="mb-0 fw-bold d-flex align-items-center gap-2" style="font-size: 1.1rem;">
                    <i class="bi bi-cloud-arrow-up-fill text-warning"></i> Upload Gallery Photo Form
                </h4>
                <span class="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">
                    Upload Entry
                </span>
            </div>

            <div class="p-4">
                <div class="row g-3">
                    <!-- Photo Title -->
                    <div class="col-md-6">
                        <label class="form-label-custom">Photo Title</label>
                        <asp:TextBox ID="txtPhotoTitle" runat="server" CssClass="form-control-admin w-100"
                            placeholder="Example: Executive Suite Sunset View"></asp:TextBox>
                    </div>

                    <!-- Category -->
                    <div class="col-md-6">
                        <label class="form-label-custom">Category</label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select-admin w-100">
                            <asp:ListItem Value="Rooms">Rooms</asp:ListItem>
                            <asp:ListItem Value="Amenities">Amenities</asp:ListItem>
                            <asp:ListItem Value="Dining">Dining</asp:ListItem>
                            <asp:ListItem Value="Exterior">Exterior</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Select Photo -->
                    <div class="col-md-8">
                        <label class="form-label-custom">Select Photo File</label>
                        <asp:FileUpload ID="fileImage" runat="server" CssClass="form-control-admin w-100" />
                        <small class="text-muted d-block mt-1">Allowed formats: JPG, JPEG, PNG, WEBP (Max size: 10
                            MB)</small>
                    </div>

                    <!-- Upload Button -->
                    <div class="col-md-4 d-flex align-items-end">
                        <asp:Button ID="btnUploadGallery" runat="server" Text="Upload Photo"
                            CssClass="btn btn-luxury-upload w-100" OnClick="btnUploadGallery_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Gallery Management Table Card (Matching Executive Theme) -->
        <div class="add-room-card">
            <div class="add-room-header">
                <h4 class="mb-0 fw-bold d-flex align-items-center gap-2" style="font-size: 1.1rem;">
                    <i class="bi bi-images text-warning"></i> Uploaded Gallery Photos Directory
                </h4>
                <span class="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">
                    Manage Directory
                </span>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light text-muted small text-uppercase">
                        <tr>
                            <th class="ps-4 py-3">Photo ID</th>
                            <th class="py-3">Thumbnail</th>
                            <th class="py-3">Photo Title</th>
                            <th class="py-3">Category</th>
                            <th class="py-3">Status</th>
                            <th class="text-end pe-4 py-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="border-top-0">
                        <asp:Repeater ID="rptAdminGallery" runat="server" OnItemCommand="rptAdminGallery_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td class="ps-4 fw-bold text-muted">#<%# Eval("GalleryId") %>
                                    </td>
                                    <td>
                                        <img src='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>'
                                            alt='<%# Eval("PhotoTitle") %>' class="gallery-thumb-img"
                                            onerror="this.src='../images/room-placeholder.jpg';" />
                                    </td>
                                    <td>
                                        <span class="fw-bold text-dark">
                                            <%# Eval("PhotoTitle") %>
                                        </span>
                                    </td>
                                    <td>
                                        <span
                                            class="badge bg-light text-dark border px-3 py-1.5 rounded-pill fw-semibold">
                                            <%# GetCategoryDisplayName(Eval("Category")) %>
                                        </span>
                                    </td>
                                    <td>
                                        <span
                                            class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1.5 rounded-pill"><i
                                                class="bi bi-check-circle-fill me-1"></i> Active</span>
                                    </td>
                                    <td class="text-end pe-4">
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeletePhoto"
                                            CommandArgument='<%# Eval("GalleryId") %>'
                                            CssClass="btn btn-sm btn-outline-danger px-3 rounded-pill fw-semibold">
                                            <i class="bi bi-trash me-1"></i> Delete
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>

    </asp:Content>