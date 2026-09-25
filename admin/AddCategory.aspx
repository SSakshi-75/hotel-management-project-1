<%@ Page Title="Add & Edit Room Category | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="AddCategory.aspx.cs"
    Inherits="Admin_AddCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management - Add and Edit Room Category Form" />
    <link rel="stylesheet" type="text/css" href="css/addroom.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <!-- Hidden Field for Category ID -->
    <asp:HiddenField ID="hdnCategoryId" runat="server" Value="0" />

    <!-- Page Header & Navigation matching AddRoom.aspx -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <nav aria-label="breadcrumb" class="mb-1">
                <ol class="breadcrumb small text-muted mb-0">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx" class="text-decoration-none text-muted"><i class="bi bi-house-door-fill text-warning me-1"></i> Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="ManageCategory.aspx" class="text-decoration-none text-muted">Room Categories</a></li>
                    <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">
                        <asp:Literal ID="litBreadcrumb" runat="server" Text="Add Category"></asp:Literal>
                    </li>
                </ol>
            </nav>
            <h2 id="pageTitleHeading" runat="server" class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">
                Add New Room Category
            </h2>
            <p class="text-muted small mb-0">
                Configure room category classification and publishing status for hotel inventory.
            </p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <a href="ManageCategory.aspx" class="btn-admin-secondary">
                <i class="bi bi-arrow-left"></i> Back to Manage Categories
            </a>
            <a href="AddRoom.aspx" class="btn-admin-primary">
                <i class="bi bi-plus-lg"></i> Add Room
            </a>
        </div>
    </div>

    <!-- Alert / Toast Messages -->
    <asp:Panel ID="pnlStatusMsg" runat="server" Visible="false" ClientIDMode="Static"
        CssClass="alert alert-dismissible fade show mb-4 shadow-sm rounded-4" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i id="msgIcon" runat="server" class="bi bi-check-circle-fill fs-3 text-success"></i>
            <div>
                <strong class="d-block text-dark">Notification</strong>
                <asp:Label ID="lblStatusMessage" runat="server" CssClass="small text-dark"></asp:Label>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Single Focused Category Form Card matching add-room-card -->
    <div class="add-room-card">
        
        <!-- Header matching add-room-header -->
        <div class="add-room-header">
            <h4 class="mb-0 fw-bold d-flex align-items-center gap-2" style="font-size: 1.1rem;">
                <i class="bi bi-tags-fill text-warning"></i>
                <asp:Label ID="lblFormTitle" runat="server" Text="Room Category Specification Form"></asp:Label>
            </h4>
            <span class="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">
                Category Entry Form
            </span>
        </div>

        <div class="p-4">
            <div class="row g-4">

                <div class="col-12">
                    <h6 class="fw-bold text-dark mb-3 d-flex align-items-center gap-2" style="font-size: 0.95rem;">
                        <i class="bi bi-card-heading text-gold"></i> Category Classification &amp; Publishing Status
                    </h6>
                </div>

                <!-- Category Name -->
                <div class="col-md-8">
                    <label class="form-label-custom" for="txtCategoryName">
                        Category Name <span class="text-danger">*</span>
                    </label>
                    <asp:TextBox ID="txtCategoryName" runat="server" ClientIDMode="Static"
                        CssClass="form-control form-control-admin"
                        placeholder="e.g. HERITAGE SUITE, ROYAL VILLA, CHALET" MaxLength="100"></asp:TextBox>
                    <span class="text-muted small mt-1 d-block">
                        <i class="bi bi-info-circle text-primary me-1"></i> Unique identifier used in room creation and guest filter pills.
                    </span>
                </div>

                <!-- Publishing Status -->
                <div class="col-md-4">
                    <label class="form-label-custom" for="ddlIsActive">
                        Publishing Status <span class="text-danger">*</span>
                    </label>
                    <asp:DropDownList ID="ddlIsActive" runat="server" ClientIDMode="Static"
                        CssClass="form-select form-select-admin">
                        <asp:ListItem Value="1" Selected="True">Active (Available for Rooms)</asp:ListItem>
                        <asp:ListItem Value="0">Inactive (Hidden)</asp:ListItem>
                    </asp:DropDownList>
                    <span class="text-muted small mt-1 d-block">
                        <i class="bi bi-check2-circle text-success me-1"></i> Active categories show up in the room form dropdown.
                    </span>
                </div>

            </div>

            <!-- Hidden fields to maintain backend code-behind compatibility -->
            <asp:TextBox ID="txtCategoryBadge" runat="server" ClientIDMode="Static" style="display:none;"></asp:TextBox>
            <asp:TextBox ID="txtDescription" runat="server" ClientIDMode="Static" style="display:none;"></asp:TextBox>

            <!-- Form Action Footer Buttons matching AddRoom.aspx -->
            <div class="d-flex align-items-center justify-content-between pt-4 mt-4 border-top">
                <button type="button" class="btn-admin-secondary" onclick="resetCategoryForm()">
                    <i class="bi bi-arrow-counterclockwise"></i> Clear Form
                </button>
                <div class="d-flex align-items-center gap-2">
                    <a href="ManageCategory.aspx" class="btn-admin-secondary">Cancel</a>
                    <asp:Button ID="btnSaveCategory" runat="server" Text="Save Category"
                        CssClass="btn-admin-primary" OnClick="btnSaveCategory_Click" />
                </div>
            </div>

        </div>
    </div>

    <!-- JavaScript for Form Reset and Auto-Dismiss Alert matching admin standards -->
    <script type="text/javascript">
        function resetCategoryForm() {
            var nameInput = document.getElementById('txtCategoryName');
            var statusSelect = document.getElementById('ddlIsActive');

            if (nameInput) nameInput.value = '';
            if (statusSelect) statusSelect.value = '1';
        }

        // Auto dismiss status confirmation alert without needing to click close
        document.addEventListener('DOMContentLoaded', function () {
            var statusAlert = document.getElementById('<%= pnlStatusMsg.ClientID %>') || document.querySelector('.alert.alert-dismissible');
            if (statusAlert) {
                setTimeout(function () {
                    statusAlert.style.transition = 'opacity 0.6s ease, transform 0.6s ease, max-height 0.6s ease, margin 0.6s ease, padding 0.6s ease';
                    statusAlert.style.opacity = '0';
                    statusAlert.style.transform = 'translateY(-8px)';
                    statusAlert.style.maxHeight = '0px';
                    statusAlert.style.paddingTop = '0px';
                    statusAlert.style.paddingBottom = '0px';
                    statusAlert.style.marginTop = '0px';
                    statusAlert.style.marginBottom = '0px';
                    statusAlert.style.overflow = 'hidden';
                    setTimeout(function () {
                        if (statusAlert.parentNode) {
                            statusAlert.style.display = 'none';
                        }
                    }, 600);
                }, 2000); // 2 seconds me bina cut kiye apne aap hat jayega
            }
        });
    </script>

</asp:Content>