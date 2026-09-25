<%@ Page Title="Dining Menu Management | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Menu.aspx.cs" Inherits="Admin_Menu" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
        <meta name="description" content="Hotel Management Dining Menu Administration">
        <link rel="stylesheet" type="text/css" href="css/addroom.css">
        <style>
            .dish-thumb-img {
                width: 68px;
                height: 52px;
                object-fit: cover;
                border-radius: 8px;
                border: 1.5px solid #cbd5e1;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
            }

            .badge-veg-pill {
                display: inline-flex;
                align-items: center;
                gap: 5px;
                font-size: 0.76rem;
                font-weight: 700;
                color: #15803d;
                background-color: #dcfce7;
                border: 1px solid #bbf7d0;
                padding: 3px 10px;
                border-radius: 50rem;
            }

            .badge-nonveg-pill {
                display: inline-flex;
                align-items: center;
                gap: 5px;
                font-size: 0.76rem;
                font-weight: 700;
                color: #b91c1c;
                background-color: #fee2e2;
                border: 1px solid #fecaca;
                padding: 3px 10px;
                border-radius: 50rem;
            }

            .badge-special-tag {
                display: inline-flex;
                align-items: center;
                gap: 4px;
                font-size: 0.74rem;
                font-weight: 600;
                color: #78350f;
                background-color: #fef3c7;
                border: 1px solid #fde68a;
                padding: 3px 8px;
                border-radius: 6px;
            }

            .btn-luxury-save {
                background: linear-gradient(135deg, #442305 0%, #6a390a 100%);
                color: #ffffff;
                border: 1px solid #7c440f;
                border-radius: 12px;
                padding: 12px 28px;
                font-size: 0.95rem;
                font-weight: 700;
                letter-spacing: 0.4px;
                box-shadow: 0 4px 14px rgba(68, 35, 5, 0.22);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: inline-flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
            }

            .btn-luxury-save:hover {
                background: linear-gradient(135deg, #5c3008 0%, #85480d 100%);
                color: #ffffff;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(68, 35, 5, 0.35);
            }

            .btn-luxury-save:active {
                transform: translateY(0);
                box-shadow: 0 2px 8px rgba(68, 35, 5, 0.2);
            }

            .menu-filter-btn {
                font-size: 0.8rem;
                font-weight: 600;
                padding: 6px 14px;
                border-radius: 50rem;
                border: 1px solid #e2e8f0;
                background-color: #ffffff;
                color: #475569;
                transition: all 0.2s ease;
                cursor: pointer;
            }

            .menu-filter-btn:hover, .menu-filter-btn.active {
                background-color: #442305;
                color: #ffffff;
                border-color: #442305;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

        <!-- Page Header & Actions -->
        <div class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-3 mb-4">
            <div>
                <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">
                    Dining Menu Management
                </h2>
                <p class="text-muted small mb-0">
                    Add new dishes, update pricing, tags, dietary options, and manage items connected directly to the database.
                </p>
            </div>
            <div class="d-flex gap-2">
                <a href="../Dining.aspx" target="_blank" class="btn btn-outline-dark btn-sm px-3 rounded-pill fw-semibold">
                    <i class="bi bi-eye me-1"></i> View Live Menu
                </a>
                <a href="Dashboard.aspx" class="btn-admin-secondary text-decoration-none">
                    <i class="bi bi-grid-fill me-1"></i> Dashboard
                </a>
            </div>
        </div>

        <!-- Success Confirmation Card (RegistrationConfirmation.aspx Style) -->
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
                        Text="The dining dish has been saved to the database successfully.">
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

        <!-- Auto-Dismiss Script for Messages (3.5s for success, 4.5s for error) -->
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

        <!-- ==========================================
             ADD NEW DISH FORM CARD
             ========================================== -->
        <div class="add-room-card mb-4">
            <asp:HiddenField ID="hdnEditMenuItemId" runat="server" Value="0" />
            <div class="add-room-header">
                <h4 class="mb-0 fw-bold d-flex align-items-center gap-2" style="font-size: 1.1rem;">
                    <i class="bi bi-cup-hot-fill text-warning"></i> <asp:Label ID="lblFormTitle" runat="server" Text="Add New Dining Menu Dish"></asp:Label>
                </h4>
                <span class="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">
                    Database Entry
                </span>
            </div>

            <div class="p-4">
                <div class="row g-3">
                    <!-- Dish Name -->
                    <div class="col-md-5">
                        <label class="form-label-custom">Dish Title / Name <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtDishName" runat="server" CssClass="form-control-admin w-100"
                            placeholder="e.g. Tandoori Paneer Tikka, Murgh Malai Tikka"></asp:TextBox>
                    </div>

                    <!-- Category -->
                    <div class="col-md-4">
                        <label class="form-label-custom">Category <span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select-admin w-100" ClientIDMode="Static" onchange="toggleNewMenuCategory(this);">
                            <asp:ListItem Value="kebabs">Tandoori Starters &amp; Kebabs</asp:ListItem>
                            <asp:ListItem Value="mains">Royal Indian Curries</asp:ListItem>
                            <asp:ListItem Value="biryani">Dum Biryani &amp; Rice</asp:ListItem>
                            <asp:ListItem Value="breads">Tandoori Breads &amp; Naan</asp:ListItem>
                            <asp:ListItem Value="desserts">Traditional Mithai &amp; Desserts</asp:ListItem>
                            <asp:ListItem Value="beverages">Chai, Lassi &amp; Beverages</asp:ListItem>
                            <asp:ListItem Value="__NEW__">+ Add New Category...</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtNewCategory" runat="server" ClientIDMode="Static" CssClass="form-control-admin w-100 mt-2"
                            placeholder="Enter new category name..." style="display:none;"></asp:TextBox>
                    </div>

                    <!-- Price -->
                    <div class="col-md-3">
                        <label class="form-label-custom">Price (&#8377;) <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control-admin w-100"
                            placeholder="e.g. 850"></asp:TextBox>
                    </div>

                    <!-- Dietary Type -->
                    <div class="col-md-4">
                        <label class="form-label-custom">Dietary Type <span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlDietaryType" runat="server" CssClass="form-select-admin w-100">
                            <asp:ListItem Value="Pure Veg">Pure Veg</asp:ListItem>
                            <asp:ListItem Value="Non-Veg">Non-Veg</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Specialty Badge / Tag -->
                    <div class="col-md-4">
                        <label class="form-label-custom">Specialty Tag / Badge</label>
                        <asp:TextBox ID="txtBadge" runat="server" CssClass="form-control-admin w-100"
                            placeholder="e.g. Clay Tandoor, Chef's Special, Palace Classic"></asp:TextBox>
                    </div>

                    <!-- Pairing Note (Optional) -->
                    <div class="col-md-4">
                        <label class="form-label-custom">Pairing Note (Optional)</label>
                        <asp:TextBox ID="txtPairingNote" runat="server" CssClass="form-control-admin w-100"
                            placeholder="e.g. Pair with: Butter Garlic Naan"></asp:TextBox>
                    </div>

                    <!-- Publishing Status -->
                    <div class="col-md-4">
                        <label class="form-label-custom">Publishing Status <span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlIsActive" runat="server" CssClass="form-select-admin w-100">
                            <asp:ListItem Value="1" Selected="True">Active (Show in Dining Menu)</asp:ListItem>
                            <asp:ListItem Value="0">Inactive (Hide from Dining Menu)</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Description -->
                    <div class="col-md-12">
                        <label class="form-label-custom">Dish Description <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3"
                            CssClass="form-control-admin w-100"
                            placeholder="Describe ingredients, cooking technique, and presentation..."></asp:TextBox>
                    </div>

                    <!-- Dish Image Upload -->
                    <div class="col-md-8">
                        <label class="form-label-custom">Dish Image File <asp:Label ID="lblImageReq" runat="server" Text="*" CssClass="text-danger"></asp:Label></label>
                        <asp:FileUpload ID="fileDishImage" runat="server" CssClass="form-control-admin w-100" />
                        <small class="text-muted d-block mt-1">Allowed formats: JPG, JPEG, PNG, WEBP (Max size: 10 MB)</small>
                    </div>

                    <!-- Submit Button -->
                    <div class="col-md-4 d-flex align-items-end gap-2">
                        <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel Edit"
                            CssClass="btn btn-outline-secondary w-50" OnClick="btnCancelEdit_Click" Visible="false" />
                        <asp:Button ID="btnSaveMenuItem" runat="server" Text="Save Menu Dish"
                            CssClass="btn btn-luxury-save w-100" OnClick="btnSaveMenuItem_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- ==========================================
             MENU ITEMS DIRECTORY TABLE CARD
             ========================================== -->
        <div class="add-room-card">
            <div class="add-room-header">
                <div class="d-flex align-items-center gap-2">
                    <h4 class="mb-0 fw-bold d-flex align-items-center gap-2" style="font-size: 1.1rem;">
                        <i class="bi bi-book-half text-warning"></i> Current Dining Menu Dishes
                    </h4>
                    <asp:Label ID="lblTotalCount" runat="server" CssClass="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">
                        0 Dishes
                    </asp:Label>
                </div>
            </div>

            <!-- Category Filter Tabs & Search -->
            <div class="p-3 bg-light border-bottom d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3">
                <div class="d-flex flex-wrap gap-2" id="adminMenuFilterGroup">
                    <button type="button" class="menu-filter-btn active" onclick="filterAdminMenu('all', this)">All</button>
                    <button type="button" class="menu-filter-btn" onclick="filterAdminMenu('kebabs', this)">Starters &amp; Kebabs</button>
                    <button type="button" class="menu-filter-btn" onclick="filterAdminMenu('mains', this)">Curries &amp; Mains</button>
                    <button type="button" class="menu-filter-btn" onclick="filterAdminMenu('biryani', this)">Biryani &amp; Rice</button>
                    <button type="button" class="menu-filter-btn" onclick="filterAdminMenu('breads', this)">Breads &amp; Naan</button>
                    <button type="button" class="menu-filter-btn" onclick="filterAdminMenu('desserts', this)">Mithai &amp; Desserts</button>
                    <button type="button" class="menu-filter-btn" onclick="filterAdminMenu('beverages', this)">Chai &amp; Beverages</button>
                </div>
                <div class="input-group" style="max-width: 260px;">
                    <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="dishSearchInput" class="form-control form-control-sm border-start-0"
                        placeholder="Search dish name..." onkeyup="searchAdminDishes()" />
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="adminMenuTable">
                    <thead class="bg-light text-muted small text-uppercase">
                        <tr>
                            <th class="ps-4 py-3">ID</th>
                            <th class="py-3">Photo</th>
                            <th class="py-3" style="min-width: 220px;">Dish Title &amp; Details</th>
                            <th class="py-3">Category</th>
                            <th class="py-3">Dietary</th>
                            <th class="py-3">Badge</th>
                            <th class="py-3">Price</th>
                            <th class="py-3">Status</th>
                            <th class="text-end pe-4 py-3">Action</th>
                        </tr>
                    </thead>
                    <tbody class="border-top-0">
                        <!-- Empty Row when no dishes exist yet -->
                        <asp:PlaceHolder ID="phEmptyState" runat="server" Visible="false">
                            <tr>
                                <td colspan="9" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-2 d-block mb-2 text-muted opacity-50"></i>
                                    <span class="fw-semibold text-dark d-block">No Dishes Added Yet</span>
                                    <span class="small text-muted">Aap upar diye gaye form se jo bhi dish add karenge, wo yahan table me list ho jayegi.</span>
                                </td>
                            </tr>
                        </asp:PlaceHolder>
                        <asp:Repeater ID="rptMenuItems" runat="server" OnItemCommand="rptMenuItems_ItemCommand">
                            <ItemTemplate>
                                <tr class="menu-row" data-cat='<%# Eval("Category") %>'>
                                    <td class="ps-4 fw-bold text-muted">
                                        #<%# Eval("MenuItemId") %>
                                    </td>
                                    <td>
                                        <img src='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>'
                                            alt='<%# Eval("ItemName") %>' class="dish-thumb-img"
                                            onerror="this.src='../images/room-placeholder.jpg';" />
                                    </td>
                                    <td>
                                        <div class="fw-bold text-dark dish-name-text"><%# Eval("ItemName") %></div>
                                        <small class="text-muted d-block text-truncate" style="max-width: 280px;" title='<%# Eval("Description") %>'>
                                            <%# Eval("Description") %>
                                        </small>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border px-2.5 py-1 rounded-pill small fw-semibold">
                                            <%# GetCategoryDisplayName(Eval("Category")) %>
                                        </span>
                                    </td>
                                    <td>
                                        <%# Eval("DietaryType").ToString() == "Pure Veg" 
                                            ? "<span class='badge-veg-pill'><i class='bi bi-circle-fill'></i> Pure Veg</span>"
                                            : "<span class='badge-nonveg-pill'><i class='bi bi-circle-fill'></i> Non-Veg</span>" %>
                                    </td>
                                    <td>
                                        <%# string.IsNullOrEmpty(Eval("Badge") as string) 
                                            ? "<span class='text-muted small'>-</span>" 
                                            : "<span class='badge-special-tag'><i class='bi bi-award-fill text-warning'></i> " + Eval("Badge") + "</span>" %>
                                    </td>
                                    <td class="fw-bold text-dark">
                                        &#8377;<%# Convert.ToDecimal(Eval("Price")).ToString("N0") %>
                                    </td>
                                    <td>
                                        <%# Convert.ToBoolean(Eval("IsActive"))
                                            ? "<span class='badge bg-success-subtle text-success border border-success-subtle px-2.5 py-1 rounded-pill small'><i class='bi bi-check-circle-fill me-1'></i> Active</span>"
                                            : "<span class='badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2.5 py-1 rounded-pill small'><i class='bi bi-eye-slash-fill me-1'></i> Inactive</span>" %>
                                    </td>
                                    <td class="text-end pe-4">
                                        <asp:LinkButton ID="btnToggleStatus" runat="server" CommandName="ToggleStatusMenuItem"
                                            CommandArgument='<%# Eval("MenuItemId") %>'
                                            CssClass="btn btn-sm btn-outline-warning px-2.5 py-1 rounded-pill fw-semibold me-1"
                                            ToolTip='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate Dish (Hide on Site)" : "Activate Dish (Show on Site)" %>'>
                                            <i class='<%# Convert.ToBoolean(Eval("IsActive")) ? "bi bi-eye-slash" : "bi bi-eye" %>'></i> Status
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditMenuItem"
                                            CommandArgument='<%# Eval("MenuItemId") %>'
                                            CssClass="btn btn-sm btn-outline-primary px-3 rounded-pill fw-semibold me-1">
                                            <i class="bi bi-pencil-square me-1"></i> Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteMenuItem"
                                            CommandArgument='<%# Eval("MenuItemId") %>'
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

        <!-- Filter & Search JavaScript -->
        <script>
            var currentCategoryFilter = 'all';

            function filterAdminMenu(cat, btn) {
                currentCategoryFilter = cat;
                var buttons = document.querySelectorAll('#adminMenuFilterGroup .menu-filter-btn');
                buttons.forEach(function (b) { b.classList.remove('active'); });
                if (btn) btn.classList.add('active');

                applyFilters();
            }

            function searchAdminDishes() {
                applyFilters();
            }

            function applyFilters() {
                var searchQuery = (document.getElementById('dishSearchInput').value || '').trim().toLowerCase();
                var rows = document.querySelectorAll('#adminMenuTable tbody tr.menu-row');

                rows.forEach(function (row) {
                    var rowCat = row.getAttribute('data-cat') || '';
                    var dishName = (row.querySelector('.dish-name-text') ? row.querySelector('.dish-name-text').textContent : '').toLowerCase();

                    var matchesCat = (currentCategoryFilter === 'all' || rowCat === currentCategoryFilter);
                    var matchesSearch = (searchQuery === '' || dishName.indexOf(searchQuery) !== -1);

                    if (matchesCat && matchesSearch) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }

            function toggleNewMenuCategory(sel) {
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
