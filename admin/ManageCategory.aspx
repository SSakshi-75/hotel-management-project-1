<%@ Page Title="Manage Room Categories | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="ManageCategory.aspx.cs"
    Inherits="Admin_ManageCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management - Manage Room Categories Administration" />
    <link rel="stylesheet" type="text/css" href="css/managehotel.css?v=3.0" />
    <style>
        .category-name-badge {
            display: inline-block;
            padding: 6px 14px;
            background: linear-gradient(135deg, #fdfbf7 0%, #f4ede4 100%);
            border: 1px solid rgba(154, 114, 78, 0.35);
            border-radius: 8px;
            color: #442305;
            font-weight: 700;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
        }
        .category-rooms-count {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 12px;
            border-radius: 20px;
            background: #eef2ff;
            color: #4338ca;
            font-weight: 600;
            font-size: 0.8rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <!-- Page Header & Action Bar -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <nav aria-label="breadcrumb" class="mb-1">
                <ol class="breadcrumb small text-muted mb-0">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx" class="text-decoration-none text-muted"><i class="bi bi-house-door-fill text-warning me-1"></i> Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="ManageHotel.aspx" class="text-decoration-none text-muted">Hotel Management</a></li>
                    <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Room Categories</li>
                </ol>
            </nav>
            <h2 class="fw-bold mb-1 manage-hotel-title">Manage Room Categories</h2>
            <p class="text-muted small mb-0">Overview of all hotel room category classifications, room counts, and active publishing status.</p>
        </div>
        <div class="d-flex align-items-center flex-wrap gap-2">
            <a href="../Room.aspx" target="_blank" class="btn-hotel-preview-site">
                <i class="bi bi-globe2"></i> Live Guest Rooms <i class="bi bi-box-arrow-up-right small"></i>
            </a>
            <a href="ManageHotel.aspx" class="btn btn-outline-secondary px-3 py-2 rounded-3 fw-semibold small">
                <i class="bi bi-buildings me-1"></i> Manage Rooms
            </a>
            <a href="AddCategory.aspx" class="btn-hotel-add-room">
                <i class="bi bi-plus-lg"></i> Add New Category
            </a>
        </div>
    </div>

    <!-- Alert / Toast Messages -->
    <asp:Panel ID="pnlStatusMsg" runat="server" Visible="false"
        CssClass="alert alert-dismissible fade show mb-4 shadow-sm rounded-4" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i id="msgIcon" runat="server" class="bi bi-check-circle-fill fs-4 text-success"></i>
            <div>
                <asp:Label ID="lblStatusMessage" runat="server" CssClass="fw-semibold text-dark"></asp:Label>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Luxury KPI Strip -->
    <div class="row g-3 mb-4">
        <!-- Total Categories -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Total Categories</span>
                        <div class="kpi-value mt-1" id="kpiTotalCategories" runat="server">0</div>
                        <span class="text-muted small">Configured in Database</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-gold">
                        <i class="bi bi-tags-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Active Categories -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Active Categories</span>
                        <div class="kpi-value mt-1 text-success" id="kpiActiveCategories" runat="server">0 Live</div>
                        <span class="text-muted small">Available for Rooms</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-green">
                        <i class="bi bi-check-circle-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Inactive Categories -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Inactive Categories</span>
                        <div class="kpi-value mt-1 text-secondary" id="kpiInactiveCategories" runat="server">0</div>
                        <span class="text-muted small">Archived / Hidden</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-purple">
                        <i class="bi bi-eye-slash-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Total Rooms Mapped -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Rooms in Inventory</span>
                        <div class="kpi-value mt-1 text-primary" id="kpiTotalRooms" runat="server">0 Rooms</div>
                        <span class="text-muted small">Mapped across categories</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-blue">
                        <i class="bi bi-door-open-fill"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Master Inventory Card: Categories Table -->
    <div class="manage-hotel-card">

        <!-- Header -->
        <div class="manage-hotel-header">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-collection-fill text-warning fs-5"></i>
                <h4 class="mb-0">Configured Room Categories</h4>
            </div>
            <div>
                <span class="header-count-pill" id="lblCategoryCountPill" runat="server">
                    <i class="bi bi-shield-check me-1"></i> 0 Categories Registered
                </span>
            </div>
        </div>

        <!-- Toolbar -->
        <div class="manage-hotel-toolbar">
            <div class="row g-3 align-items-center">
                <!-- Search Box -->
                <div class="col-12 col-md-6 col-lg-5">
                    <div class="search-wrap-luxury">
                        <i class="bi bi-search search-icon-luxury"></i>
                        <input type="text" id="txtCategorySearch" class="form-control form-control-luxury-search"
                            placeholder="Search category name, badge, description..." onkeyup="filterCategoryTable();" />
                    </div>
                </div>

                <div class="col-12 col-md-6 col-lg-7 text-md-end">
                    <a href="AddCategory.aspx" class="btn btn-sm btn-dark px-3 py-2 rounded-3 fw-semibold">
                        <i class="bi bi-plus-circle me-1"></i> Add Room Category
                    </a>
                </div>
            </div>
        </div>

        <!-- GridView -->
        <div class="table-responsive">
            <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="false" DataKeyNames="CategoryId"
                ClientIDMode="Static" CssClass="table table-bordered table-hover hotel-rooms-table align-middle mb-0"
                GridLines="Both" UseAccessibleHeader="true" AllowPaging="true" PageSize="10"
                OnPageIndexChanging="gvCategories_PageIndexChanging" OnRowCommand="gvCategories_RowCommand"
                EmptyDataText="No Room Categories Registered">
                <Columns>
                    <%-- CATEGORY ID --%>
                    <asp:TemplateField HeaderText="ID">
                        <HeaderStyle Width="60px" />
                        <ItemStyle CssClass="fw-bold text-muted text-center" />
                        <ItemTemplate>
                            #<%# Eval("CategoryId") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- CATEGORY NAME --%>
                    <asp:TemplateField HeaderText="Category Name">
                        <HeaderStyle Width="220px" />
                        <ItemTemplate>
                            <span class="category-name-badge">
                                <i class="bi bi-tag-fill text-warning me-1.5 small"></i>
                                <%# Eval("CategoryName") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- PUBLISHING STATUS --%>
                    <asp:TemplateField HeaderText="Category Status">
                        <ItemTemplate>
                            <span class="text-dark fw-semibold small">
                                <i class="bi bi-shield-check text-warning me-1"></i>
                                <%# Eval("PublishingStatus") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- ROOMS ASSIGNED --%>
                    <asp:TemplateField HeaderText="Rooms Assigned">
                        <HeaderStyle Width="150px" />
                        <ItemTemplate>
                            <span class="category-rooms-count">
                                <i class="bi bi-door-closed"></i>
                                <%# Eval("RoomCount") %> Room(s)
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- STATUS --%>
                    <asp:TemplateField HeaderText="Status">
                        <HeaderStyle Width="120px" />
                        <ItemTemplate>
                            <%# Convert.ToBoolean(Eval("IsActive"))
                                ? "<span class='badge-hotel-live'><span class='status-dot-pulse'></span> Active</span>"
                                : "<span class='badge bg-secondary text-white px-2.5 py-1 rounded-pill small'><i class='bi bi-eye-slash-fill me-1'></i> Inactive</span>" %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- ACTIONS --%>
                    <asp:TemplateField HeaderText="Actions">
                        <HeaderStyle Width="140px" />
                        <ItemTemplate>
                            <div class="hotel-table-actions justify-content-center">
                                <%-- Toggle Active/Inactive --%>
                                <asp:LinkButton ID="btnToggleStatus" runat="server" CommandName="ToggleStatus"
                                    CommandArgument='<%# Eval("CategoryId") %>' CssClass="btn-action-luxury btn-edit"
                                    ToolTip='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate Category" : "Activate Category" %>'>
                                    <i class='<%# Convert.ToBoolean(Eval("IsActive")) ? "bi bi-eye-slash-fill text-warning" : "bi bi-eye-fill text-success" %>'></i>
                                </asp:LinkButton>

                                <%-- Edit (Redirects to AddCategory.aspx?CategoryId=...) --%>
                                <a href='<%# "AddCategory.aspx?CategoryId=" + Eval("CategoryId") %>'
                                    class="btn-action-luxury btn-edit" title="Edit Category Details">
                                    <i class="bi bi-pencil-square"></i>
                                </a>

                                <%-- Delete --%>
                                <asp:LinkButton ID="btnDeleteCategory" runat="server" CommandName="DeleteCategory"
                                    CommandArgument='<%# Eval("CategoryId") %>' CssClass="btn-action-luxury btn-delete"
                                    ToolTip="Delete Category"
                                    OnClientClick="return confirm('Are you sure you want to delete this category?');">
                                    <i class="bi bi-trash3"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <PagerStyle CssClass="hotel-grid-pager" />
            </asp:GridView>
        </div>

        <!-- Footer -->
        <div class="manage-hotel-footer">
            <div>
                <span class="fw-semibold text-dark">Hotel Property Management</span>
                <span class="mx-2 text-muted">&bull;</span>
                <span class="text-muted">Room Category Classifications</span>
            </div>
            <div>
                <a href="AddRoom.aspx" class="text-decoration-none fw-semibold" style="color: var(--hotel-gold-dark);">
                    Proceed to Add Room <i class="bi bi-arrow-right small"></i>
                </a>
            </div>
        </div>

    </div>

    <!-- Client-side filter script -->
    <script type="text/javascript">
        function filterCategoryTable() {
            var searchInput = document.getElementById('txtCategorySearch');
            var filter = searchInput ? searchInput.value.toLowerCase().trim() : '';
            var table = document.getElementById('gvCategories');
            if (!table) return;

            var rows = table.getElementsByTagName('tr');
            // start from 1 to skip header
            for (var i = 1; i < rows.length; i++) {
                var row = rows[i];
                var text = row.textContent.toLowerCase();
                if (filter === '' || text.indexOf(filter) !== -1) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        }
    </script>

</asp:Content>
