<%@ Page Title="Photo Gallery Management | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Gallery.aspx.cs" Inherits="Admin_Gallery" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
        <meta name="description" content="Hotel Management Photo Gallery Administration">
        <link rel="stylesheet" type="text/css" href="css/addroom.css">
        <link rel="stylesheet" type="text/css" href="css/managehotel.css?v=2.0">
        <link rel="stylesheet" type="text/css" href="css/gallery.css">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

        <!-- Page Header & Action Bar -->
        <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
            <div>
                <h2 class="fw-bold mb-1 manage-hotel-title">Photo Gallery Management</h2>
                <p class="text-muted small mb-0">Overview of all resort photo galleries, category tags, guest portal
                    publishing, and media uploads.</p>
            </div>
            <div class="d-flex align-items-center flex-wrap gap-2">
                <a href="../Gallery.aspx" target="_blank" class="btn-hotel-preview-site">
                    <i class="bi bi-globe2"></i> Live Guest Gallery <i class="bi bi-box-arrow-up-right small"></i>
                </a>
                <a href="#uploadPhotoCard" class="btn-hotel-add-room">
                    <i class="bi bi-plus-lg"></i> Upload New Photo
                </a>
            </div>
        </div>

        <!-- Luxury KPI Strip (Matching ManageHotel.aspx) -->
        <div class="row g-3 mb-4">
            <!-- Total Photos -->
            <div class="col-6 col-lg-3">
                <div class="hotel-kpi-card">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <span class="kpi-label">Total Gallery Photos</span>
                            <div class="kpi-value mt-1" id="kpiTotalPhotos" runat="server">0</div>
                            <span class="text-muted small">Configured in Database</span>
                        </div>
                        <div class="kpi-icon-wrap kpi-icon-gold">
                            <i class="bi bi-images"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Published Status -->
            <div class="col-6 col-lg-3">
                <div class="hotel-kpi-card">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <span class="kpi-label">Publish Status</span>
                            <div class="kpi-value mt-1 text-success" id="kpiLivePhotos" runat="server">0 Active</div>
                            <span class="text-muted small">Visible on Guest Site</span>
                        </div>
                        <div class="kpi-icon-wrap kpi-icon-green">
                            <i class="bi bi-broadcast"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Top Category -->
            <div class="col-6 col-lg-3">
                <div class="hotel-kpi-card">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <span class="kpi-label">Top Category</span>
                            <div class="kpi-value mt-1" id="kpiTopCategory" runat="server">None</div>
                            <span class="text-muted small">Highest Photo Count</span>
                        </div>
                        <div class="kpi-icon-wrap kpi-icon-blue">
                            <i class="bi bi-folder-check"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Distinct Categories -->
            <div class="col-6 col-lg-3">
                <div class="hotel-kpi-card">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <span class="kpi-label">Photo Categories</span>
                            <div class="kpi-value mt-1" id="kpiTotalCategories" runat="server">0 Categories</div>
                            <span class="text-muted small">Rooms, Dining, Exterior...</span>
                        </div>
                        <div class="kpi-icon-wrap kpi-icon-purple">
                            <i class="bi bi-stars"></i>
                        </div>
                    </div>
                </div>
            </div>
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



        <!-- Upload Photo Form Card (Matching Executive Theme) -->
        <asp:HiddenField ID="hdnEditGalleryId" runat="server" Value="0" />
        <div class="add-room-card mb-4" id="uploadPhotoCard">
            <div class="add-room-header">
                <h4 class="mb-0 fw-bold d-flex align-items-center gap-2" style="font-size: 1.1rem;">
                    <i class="bi bi-cloud-arrow-up-fill text-warning"></i>
                    <asp:Label ID="lblFormTitle" runat="server" Text="Upload Gallery Photo Form"></asp:Label>
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
                    <div class="col-md-4">
                        <label class="form-label-custom">Category</label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select-admin w-100" ClientIDMode="Static" onchange="toggleNewCategoryGallery(this);">
                            <asp:ListItem Value="Rooms">Rooms</asp:ListItem>
                            <asp:ListItem Value="Amenities">Amenities</asp:ListItem>
                            <asp:ListItem Value="Dining">Dining</asp:ListItem>
                            <asp:ListItem Value="Exterior">Exterior</asp:ListItem>
                            <asp:ListItem Value="__NEW__">+ Add New Category...</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtNewCategory" runat="server" ClientIDMode="Static" CssClass="form-control-admin w-100 mt-2"
                            placeholder="Enter new category name..." style="display:none;"></asp:TextBox>
                    </div>

                    <!-- Status -->
                    <div class="col-md-4">
                        <label class="form-label-custom">Publishing Status</label>
                        <asp:DropDownList ID="ddlIsActive" runat="server" CssClass="form-select-admin w-100">
                            <asp:ListItem Value="1" Selected="True">Active (Show in Gallery)</asp:ListItem>
                            <asp:ListItem Value="0">Inactive (Hide from Gallery)</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Select Photo -->
                    <div class="col-md-4">
                        <label class="form-label-custom">Select Photo File</label>
                        <asp:FileUpload ID="fileImage" runat="server" CssClass="form-control-admin w-100" />
                        <small class="text-muted d-block mt-1">Allowed formats: JPG, JPEG, PNG, WEBP (Max size: 10
                            MB)</small>
                    </div>

                    <!-- Upload & Cancel Buttons -->
                    <div class="col-md-4 d-flex align-items-end gap-2">
                        <asp:Button ID="btnUploadGallery" runat="server" Text="Upload Photo"
                            CssClass="btn btn-luxury-upload flex-grow-1" OnClick="btnUploadGallery_Click" />
                        <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel Edit"
                            CssClass="btn btn-outline-secondary rounded-3 px-3 py-2.5 fw-semibold" Visible="false"
                            OnClick="btnCancelEdit_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Gallery Management Table Card (Matching ManageHotel Theme) -->
        <div class="manage-hotel-card">

            <!-- Header -->
            <div class="manage-hotel-header">
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-images text-warning fs-5"></i>
                    <h4 class="mb-0">Uploaded Gallery Photos Directory</h4>
                </div>
                <div>
                    <span class="header-count-pill" id="lblGalleryCountPill" runat="server">
                        <i class="bi bi-shield-check me-1"></i> 0 Photos Active
                    </span>
                </div>
            </div>

            <!-- Toolbar -->
            <div class="manage-hotel-toolbar">
                <div class="row g-3 align-items-center">
                    <!-- Search Box -->
                    <div class="col-12 col-md-5 col-lg-4">
                        <div class="search-wrap-luxury">
                            <i class="bi bi-search search-icon-luxury"></i>
                            <input type="text" id="txtGallerySearch" class="form-control form-control-luxury-search"
                                placeholder="Search photo title, category, ID..." onkeyup="filterGalleryTable();" />
                        </div>
                    </div>

                    <!-- Category Filter Pills -->
                    <div class="col-12 col-md-7 col-lg-6">
                        <div class="d-flex align-items-center flex-wrap gap-2">
                            <button type="button" class="filter-pill-btn active"
                                onclick="setGalleryCategoryFilter('ALL', this); return false;">
                                All Photos
                            </button>
                            <button type="button" class="filter-pill-btn"
                                onclick="setGalleryCategoryFilter('ROOMS', this); return false;">
                                Rooms
                            </button>
                            <button type="button" class="filter-pill-btn"
                                onclick="setGalleryCategoryFilter('AMENITIES', this); return false;">
                                Amenities
                            </button>
                            <button type="button" class="filter-pill-btn"
                                onclick="setGalleryCategoryFilter('DINING', this); return false;">
                                Dining
                            </button>
                            <button type="button" class="filter-pill-btn"
                                onclick="setGalleryCategoryFilter('EXTERIOR', this); return false;">
                                Exterior
                            </button>
                        </div>
                    </div>

                    <!-- Bulk Delete Action -->
                    <div class="col-12 col-lg-2 text-lg-end">
                        <asp:Button ID="btnBulkDeletePhotos" runat="server" CssClass="btn-hotel-delete-selected"
                            Text="Delete Selected" OnClick="btnBulkDeletePhotos_Click"
                            OnClientClick="return confirmBulkDeletePhotos();" />
                    </div>
                </div>
            </div>

            <!-- GridView -->
            <div class="table-responsive">
                <asp:GridView ID="gvAdminGallery" runat="server" AutoGenerateColumns="false" DataKeyNames="GalleryId"
                    ClientIDMode="Static"
                    CssClass="table table-bordered table-hover hotel-rooms-table align-middle mb-0" GridLines="Both"
                    UseAccessibleHeader="true" AllowPaging="true" PageSize="10" OnPreRender="gvAdminGallery_PreRender"
                    OnPageIndexChanging="gvAdminGallery_PageIndexChanging" OnRowDataBound="gvAdminGallery_RowDataBound"
                    OnRowCommand="gvAdminGallery_RowCommand">
                    <Columns>
                        <%-- SELECT CHECKBOX --%>
                            <asp:TemplateField HeaderText="#">
                                <HeaderTemplate>
                                    <div class="text-center">
                                        <asp:CheckBox ID="chkSelectAll" runat="server" CssClass="hotel-chk-custom"
                                            onclick="toggleSelectAllPhotos(this);" ToolTip="Select All" />
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <div class="text-center">
                                        <asp:CheckBox ID="chkPhotoSelect" runat="server"
                                            CssClass="hotel-chk-custom photo-row-chk" />
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle Width="46px" />
                            </asp:TemplateField>

                            <%-- PHOTO ID --%>
                                <asp:TemplateField HeaderText="Photo ID">
                                    <HeaderStyle Width="90px" />
                                    <ItemStyle CssClass="fw-bold text-muted" />
                                    <ItemTemplate>
                                        #<%# Eval("GalleryId") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <%-- THUMBNAIL PREVIEW --%>
                                    <asp:TemplateField HeaderText="Thumbnail">
                                        <HeaderStyle Width="100px" />
                                        <ItemTemplate>
                                            <div class="room-thumb-wrap">
                                                <img src='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>'
                                                    alt='<%# Eval("PhotoTitle") %>' class="hotel-room-thumb"
                                                    onerror="this.src='../images/room-placeholder.jpg';" />
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <%-- PHOTO TITLE --%>
                                        <asp:TemplateField HeaderText="Photo Title">
                                            <ItemTemplate>
                                                <span class="room-name-heading">
                                                    <%# Eval("PhotoTitle") %>
                                                </span>
                                                <div class="room-specs-list">
                                                    <span class="room-spec-item" title="Photo ID">
                                                        <i class="bi bi-hash"></i> Gallery #<%# Eval("GalleryId") %>
                                                    </span>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <%-- CATEGORY --%>
                                            <asp:TemplateField HeaderText="Category">
                                                <HeaderStyle Width="140px" />
                                                <ItemTemplate>
                                                    <span
                                                        class="badge bg-light text-dark border px-3 py-1.5 rounded-pill fw-semibold">
                                                        <%# GetCategoryDisplayName(Eval("Category")) %>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <%-- STATUS --%>
                                                <asp:TemplateField HeaderText="Status">
                                                    <HeaderStyle Width="130px" />
                                                    <ItemTemplate>
                                                        <%# Convert.ToBoolean(Eval("IsActive")) 
                                                            ? "<span class='badge-hotel-live'><span class='status-dot-pulse'></span> Active</span>" 
                                                            : "<span class='badge bg-secondary text-white px-2.5 py-1 rounded-pill small'><i class='bi bi-eye-slash-fill me-1'></i> Inactive</span>" %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <%-- ACTIONS --%>
                                                    <asp:TemplateField HeaderText="Actions">
                                                        <HeaderStyle Width="130px" CssClass="text-center" />
                                                        <ItemStyle CssClass="text-center" />
                                                        <ItemTemplate>
                                                            <div class="hotel-table-actions justify-content-center">
                                                                <asp:LinkButton ID="btnToggleStatus" runat="server"
                                                                    CommandName="ToggleStatus"
                                                                    CommandArgument='<%# Eval("GalleryId") %>'
                                                                    CssClass="btn-action-luxury btn-edit"
                                                                    ToolTip='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate Photo (Hide from Site)" : "Activate Photo (Show on Site)" %>'>
                                                                    <i class='<%# Convert.ToBoolean(Eval("IsActive")) ? "bi bi-eye-slash-fill text-warning" : "bi bi-eye-fill text-success" %>'></i>
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnEdit" runat="server"
                                                                    CommandName="EditPhoto"
                                                                    CommandArgument='<%# Eval("GalleryId") %>'
                                                                    CssClass="btn-action-luxury btn-edit"
                                                                    ToolTip="Edit Photo">
                                                                    <i class="bi bi-pencil-square"></i>
                                                                </asp:LinkButton>
                                                                <a href='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>'
                                                                    target="_blank" class="btn-action-luxury btn-view"
                                                                    title="View Full Image">
                                                                    <i class="bi bi-box-arrow-up-right"></i>
                                                                </a>
                                                                <asp:LinkButton ID="btnDelete" runat="server"
                                                                    CommandName="DeletePhoto"
                                                                    CommandArgument='<%# Eval("GalleryId") %>'
                                                                    CssClass="btn-action-luxury btn-delete"
                                                                    ToolTip="Delete Photo"
                                                                    OnClientClick="return confirm('Are you sure you want to delete this photo?');">
                                                                    <i class="bi bi-trash3"></i>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                    </Columns>

                    <%-- EMPTY DATA TEMPLATE --%>
                        <EmptyDataTemplate>
                            <div class="empty-hotel-state">
                                <div class="empty-hotel-icon">
                                    <i class="bi bi-images"></i>
                                </div>
                                <h4 class="fw-bold text-dark mb-1">
                                    No Gallery Photos Registered
                                </h4>
                                <p class="text-muted small mb-0">
                                    Upload your first photo using the form above.
                                </p>
                            </div>
                        </EmptyDataTemplate>

                        <PagerStyle CssClass="hotel-grid-pager" />
                </asp:GridView>
            </div>

            <!-- Footer -->
            <div class="manage-hotel-footer">
                <div>
                    <span class="fw-semibold text-dark">Photo Gallery Management</span>
                    <span class="mx-2 text-muted">•</span>
                    <span class="text-muted">Real-time resort photo directory synchronization</span>
                </div>
            </div>
        </div>

        <!-- JavaScript Interactivity -->
        <script src="js/gallery.js" type="text/javascript"></script>
        <script type="text/javascript">
            function toggleNewCategoryGallery(sel) {
                var txt = document.getElementById('txtNewCategory');
                if (!txt) return;
                if (sel.value === '__NEW__' || sel.value === 'NEW') {
                    txt.style.display = 'block';
                    txt.focus();
                } else {
                    txt.style.display = 'none';
                }
            }
            window.addEventListener('DOMContentLoaded', function () {
                var sel = document.getElementById('ddlCategory');
                if (sel && (sel.value === '__NEW__' || sel.value === 'NEW')) {
                    var txt = document.getElementById('txtNewCategory');
                    if (txt) txt.style.display = 'block';
                }
            });
        </script>
    </asp:Content>