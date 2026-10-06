<%@ Page Title="Reserve A Table | The Royal Kitchen" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="TableReservation.aspx.cs" Inherits="TableReservation" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
        <meta name="description" content="Online Table Reservation - The Royal Kitchen Fine Dining Restaurant" />
        <style>
            .res-hero-section {
                background: linear-gradient(rgba(44, 23, 5, 0.8), rgba(44, 23, 5, 0.88)), url('images/dining-royal-zafran.jpg') center/cover no-repeat;
                padding: 70px 0 50px;
                color: #ffffff;
            }

            .res-card-luxury {
                background: #ffffff;
                border-radius: 20px;
                border: 1px solid rgba(184, 142, 104, 0.25);
                box-shadow: 0 15px 35px rgba(68, 35, 5, 0.08);
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .res-card-header {
                background: linear-gradient(135deg, #442305 0%, #2a1401 100%);
                padding: 24px 30px;
                color: #ffffff;
                border-bottom: 2px solid #B88E68;
            }

            .res-step-badge {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 32px;
                height: 32px;
                border-radius: 50%;
                background: #B88E68;
                color: #ffffff;
                font-weight: 700;
                font-size: 0.9rem;
                margin-right: 10px;
            }

            .table-card-select {
                border: 2px solid #e2e8f0;
                border-radius: 16px;
                padding: 20px;
                background: #ffffff;
                cursor: pointer;
                transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
                position: relative;
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .table-card-select:hover {
                border-color: #B88E68;
                transform: translateY(-4px);
                box-shadow: 0 10px 25px rgba(184, 142, 104, 0.15);
            }

            .table-card-select.selected {
                border-color: #442305;
                background: linear-gradient(135deg, #fdfbf7 0%, #f7f1e7 100%);
                box-shadow: 0 10px 25px rgba(68, 35, 5, 0.18);
            }

            .table-card-select.selected::after {
                content: "\F26B";
                font-family: "bootstrap-icons";
                position: absolute;
                top: 14px;
                right: 14px;
                font-size: 1.2rem;
                color: #198754;
                font-weight: bold;
            }

            .table-card-disabled {
                opacity: 0.55;
                background: #f8f9fa;
                cursor: not-allowed;
                pointer-events: none;
                border-style: dashed;
            }

            .table-num-pill {
                display: inline-block;
                padding: 4px 12px;
                border-radius: 8px;
                background: #442305;
                color: #f7f1e7;
                font-weight: 700;
                font-size: 1.1rem;
                font-family: 'Playfair Display', Georgia, serif;
            }

            .badge-capacity {
                background: #eef2ff;
                color: #3730a3;
                font-weight: 600;
                border-radius: 20px;
                padding: 4px 12px;
                font-size: 0.8rem;
            }

            .badge-table-type {
                background: #fff7ed;
                color: #c2410c;
                font-weight: 600;
                border-radius: 20px;
                padding: 4px 12px;
                font-size: 0.8rem;
            }

            .status-pill-available {
                background-color: #d1fae5;
                color: #065f46;
                font-size: 0.78rem;
                font-weight: 600;
                padding: 4px 12px;
                border-radius: 50rem;
                display: inline-block;
            }

            .status-pill-booked {
                background-color: #fee2e2;
                color: #991b1b;
                font-size: 0.78rem;
                font-weight: 600;
                padding: 4px 12px;
                border-radius: 50rem;
                display: inline-block;
            }

            .status-pill-reserved {
                background-color: #fef3c7;
                color: #92400e;
                font-size: 0.78rem;
                font-weight: 600;
                padding: 4px 12px;
                border-radius: 50rem;
                display: inline-block;
            }

            .status-pill-blocked {
                background-color: #f3f4f6;
                color: #6b7280;
                font-size: 0.78rem;
                font-weight: 600;
                padding: 4px 12px;
                border-radius: 50rem;
                display: inline-block;
            }

            .btn-reserve-submit {
                background: linear-gradient(135deg, #442305 0%, #69380b 100%);
                color: #ffffff;
                border: none;
                padding: 14px 36px;
                border-radius: 30px;
                font-weight: 700;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                box-shadow: 0 8px 20px rgba(68, 35, 5, 0.25);
            }

            .btn-reserve-submit:hover {
                background: linear-gradient(135deg, #B88E68 0%, #442305 100%);
                color: #ffffff;
                transform: translateY(-2px);
                box-shadow: 0 12px 25px rgba(68, 35, 5, 0.35);
            }

            .confirmation-voucher {
                background: #ffffff;
                border: 2px dashed #B88E68;
                border-radius: 20px;
                padding: 30px;
                position: relative;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <!-- Hero Banner -->
        <section class="res-hero-section text-center">
            <div class="container" data-aos="fade-down">
                <span
                    class="badge bg-warning text-dark px-3 py-1.5 rounded-pill font-monospace text-uppercase fw-bold mb-2">
                    <i class="bi bi-crown me-1"></i> Single Exclusive Restaurant
                </span>
                <h1 class="display-4 font-serif fw-bold text-white mb-2">The Royal Kitchen</h1>
                <p class="text-champagne-gold fs-5 mb-3 font-serif">
                    Fine Dining &bull; Indian, Mughlai &amp; Continental Haute Cuisine
                </p>
                <div
                    class="d-inline-flex flex-column flex-md-row align-items-center gap-2 gap-md-3 bg-dark bg-opacity-50 px-3 px-md-4 py-2 rounded-4 border border-warning border-opacity-25 small text-white">
                    <span><i class="bi bi-clock-fill text-warning me-1"></i> 11:00 AM &ndash; 11:00 PM</span>
                    <span class="d-none d-md-inline">&bull;</span>
                    <span><i class="bi bi-geo-alt-fill text-warning me-1"></i> Hotel Ground Floor</span>
                    <span class="d-none d-md-inline">&bull;</span>
                    <span class="text-success fw-bold"><i class="bi bi-check-circle-fill me-1"></i> Active for Reservations</span>
                </div>
            </div>
        </section>

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-10">

                    <!-- MAIN RESERVATION FORM CARD -->
                    <asp:Panel ID="pnlReservationForm" runat="server" ClientIDMode="Static"
                        CssClass="res-card-luxury mb-5">
                        <div class="res-card-header d-flex align-items-center justify-content-between">
                            <div>
                                <h3 class="mb-0 font-serif fw-bold text-white" style="font-size: 1.5rem;">
                                    <i class="bi bi-calendar2-check-fill text-warning me-2"></i> Table Reservation Form
                                </h3>
                                <small class="text-white-50">Reserve your dining table directly at The Royal
                                    Kitchen</small>
                            </div>
                            <span class="badge bg-gold text-dark px-3 py-1.5 rounded-pill font-monospace small fw-bold">
                                No Multi-Restaurant Selection
                            </span>
                        </div>

                        <div class="p-4 p-md-5">

                            <!-- STEP 1: DATE, TIME & GUEST COUNT -->
                            <div class="step-container" id="step1-container">
                                <div class="mb-5">
                                <h5 class="fw-bold text-dark mb-3 d-flex align-items-center">
                                    <span class="res-step-badge">1</span> Select Date, Time Slot &amp; Guest Count
                                </h5>
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <label class="form-label fw-semibold text-dark"><i
                                                class="bi bi-calendar-event text-gold me-1"></i> Reservation Date
                                            *</label>
                                        <input type="date" id="txtResDate" runat="server" clientidmode="Static"
                                            class="form-control form-control-lg rounded-3 shadow-none border-secondary-subtle"
                                            onchange="filterAvailableTables();" />
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label fw-semibold text-dark"><i
                                                class="bi bi-clock text-gold me-1"></i> Time Slot (11 AM &ndash; 11 PM)
                                            *</label>
                                        <select id="ddlTimeSlot" runat="server" clientidmode="Static"
                                            class="form-select form-select-lg rounded-3 shadow-none border-secondary-subtle"
                                            onchange="filterAvailableTables();">
                                            <option value="11:30 AM">11:30 AM (Lunch)</option>
                                            <option value="12:30 PM">12:30 PM (Lunch)</option>
                                            <option value="01:30 PM">01:30 PM (Lunch)</option>
                                            <option value="02:30 PM">02:30 PM (Lunch)</option>
                                            <option value="04:00 PM">04:00 PM (High Tea)</option>
                                            <option value="07:00 PM" selected="selected">07:00 PM (Dinner)</option>
                                            <option value="08:00 PM">08:00 PM (Dinner)</option>
                                            <option value="09:00 PM">09:00 PM (Dinner)</option>
                                            <option value="10:00 PM">10:00 PM (Late Dinner)</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label fw-semibold text-dark"><i
                                                class="bi bi-people-fill text-gold me-1"></i> Number of Guests *</label>
                                        <select id="ddlGuestCount" runat="server" clientidmode="Static"
                                            class="form-select form-select-lg rounded-3 shadow-none border-secondary-subtle"
                                            onchange="filterAvailableTables();">
                                            <option value="1">1 Guest</option>
                                            <option value="2" selected="selected">2 Guests (Couple Table)</option>
                                            <option value="4">4 Guests (Family Table)</option>
                                            <option value="6">6 Guests (Large Table)</option>
                                            <option value="8">8 Guests (VIP / Salon)</option>
                                        </select>
                                    </div>
                                </div>
                                </div>
                                <div class="text-end border-top pt-4">
                                    <button type="button" class="btn btn-dark rounded-pill px-5 py-2 fw-bold shadow-sm" onclick="goToStep(2)">Proceed to Select Table <i class="bi bi-arrow-right ms-2"></i></button>
                                </div>
                            </div>

                            <!-- STEP 2: AVAILABLE TABLES SELECTION GRID -->
                            <div class="step-container d-none" id="step2-container">
                                <div class="mb-5">
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <h5 class="fw-bold text-dark mb-0 d-flex align-items-center">
                                        <span class="res-step-badge">2</span> Select Available Table at The Royal
                                        Kitchen
                                    </h5>
                                    <span class="badge bg-light text-muted border px-3 py-1 rounded-pill small"
                                        id="lblTableMatchCount">
                                        <asp:Literal ID="litTableCount" runat="server" Text="0 Tables Available">
                                        </asp:Literal>
                                    </span>
                                </div>

                                <asp:HiddenField ID="hdnSelectedTableId" runat="server" ClientIDMode="Static" />
                                <asp:HiddenField ID="hdnSelectedTableNum" runat="server" ClientIDMode="Static" />

                                <div class="row g-3" id="tablesGridContainer">
                                    <asp:Repeater ID="rptAvailableTables" runat="server">
                                        <ItemTemplate>
                                            <div class="col-md-6 col-lg-3 table-item-box"
                                                data-capacity='<%# Eval("Capacity") %>'
                                                data-status='<%# Eval("TableStatus") %>'
                                                data-table-id='<%# Eval("TableId") %>'
                                                data-table-num='<%# Eval("TableNumber") %>'
                                                onclick="handleTableCardClick(this)">
                                                <div class='<%# GetTableCardClass(Eval("TableStatus")) %>'>
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <span class="table-num-pill">
                                                            <%# Eval("TableNumber") %>
                                                        </span>
                                                        <%# GetTableStatusBadge(Eval("TableStatus")) %>
                                                    </div>
                                                    <div class="fw-bold text-dark mb-1">
                                                        <%# Eval("TableName") %>
                                                    </div>
                                                    <div class="d-flex flex-wrap gap-1 mb-2">
                                                        <span class="badge-capacity"><i class="bi bi-person me-1"></i>
                                                            <%# Eval("Capacity") %> Guests
                                                        </span>
                                                        <span class="badge-table-type">
                                                            <%# Eval("Section") %>
                                                        </span>
                                                    </div>
                                                    <small class="text-muted d-block mt-auto"><i class="bi bi-geo me-1"></i>
                                                        <%# Eval("Location") %>
                                                            <%# GetFloorDisplay(Eval("Floor")) %>
                                                    </small>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <!-- Empty State when no tables are added by admin -->
                                    <asp:Panel ID="pnlNoTablesAvailable" runat="server" Visible="false"
                                        CssClass="col-12 text-center py-5">
                                        <div class="p-4 border rounded-4 bg-light">
                                            <i class="bi bi-inbox fs-1 d-block text-secondary mb-2"></i>
                                            <h5 class="fw-bold text-dark mb-1">No Dining Tables Currently Available</h5>
                                            <p class="text-muted small mb-0">Tables will be displayed here once added by
                                                restaurant management in Admin.</p>
                                        </div>
                                    </asp:Panel>

                                </div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center border-top pt-4">
                                    <button type="button" class="btn btn-light rounded-pill px-4 py-2 fw-bold" onclick="goToStep(1)"><i class="bi bi-arrow-left me-2"></i> Back</button>
                                    <button type="button" class="btn btn-dark rounded-pill px-5 py-2 fw-bold shadow-sm" onclick="goToStep(3)">Proceed to Details <i class="bi bi-arrow-right ms-2"></i></button>
                                </div>
                            </div>

                            <!-- STEP 3: CUSTOMER DETAILS & SPECIAL REQUEST -->
                            <div class="step-container d-none" id="step3-container">
                                <div class="mb-4">
                                    <h5 class="fw-bold text-dark mb-3 d-flex align-items-center">
                                    <span class="res-step-badge">3</span> Enter Customer Contact &amp; Special Request
                                </h5>
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <label class="form-label fw-semibold text-dark"><i
                                                class="bi bi-person-fill text-gold me-1"></i> Full Name *</label>
                                        <input type="text" id="txtCustName" runat="server" clientidmode="Static"
                                            class="form-control rounded-3 shadow-none" placeholder="Enter your full name"
                                            autocomplete="off" value="" required="required" />
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label fw-semibold text-dark"><i
                                                class="bi bi-telephone-fill text-gold me-1"></i> Mobile Number *</label>
                                        <input type="tel" id="txtCustPhone" runat="server" clientidmode="Static"
                                            class="form-control rounded-3 shadow-none" placeholder="Enter 10-digit mobile number"
                                            autocomplete="off" value="" required="required" />
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label fw-semibold text-dark"><i
                                                class="bi bi-envelope-fill text-gold me-1"></i> Email Address</label>
                                        <input type="email" id="txtCustEmail" runat="server" clientidmode="Static"
                                            class="form-control rounded-3 shadow-none" placeholder="Enter email address (optional)"
                                            autocomplete="off" value="" />
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-semibold text-dark"><i
                                                class="bi bi-chat-left-text-fill text-gold me-1"></i> Special Requests
                                            (Optional)</label>
                                        <textarea id="txtSpecialRequest" runat="server" clientidmode="Static"
                                            class="form-control rounded-3 shadow-none" rows="2"
                                            placeholder="Any special requests or dining preferences..." autocomplete="off"></textarea>
                                    </div>
                                </div>
                            </div>

                            <!-- SUBMIT BUTTON -->
                            <div class="d-flex justify-content-between align-items-center pt-4 border-top">
                                <button type="button" class="btn btn-light rounded-pill px-4 py-2 fw-bold" onclick="goToStep(2)"><i class="bi bi-arrow-left me-2"></i> Back</button>
                                <asp:LinkButton ID="btnConfirmReservation" runat="server"
                                    CssClass="btn btn-reserve-submit shadow-sm" OnClick="btnConfirmReservation_Click"
                                    OnClientClick="return validateTableReservation();">
                                    <i class="bi bi-check-circle-fill me-2"></i> Confirm Table Reservation
                                </asp:LinkButton>
                            </div>
                            </div>

                        </div>
                    </asp:Panel>

                    <!-- CONFIRMATION VOUCHER DISPLAY (Hidden by default) -->
                    <asp:Panel ID="pnlConfirmationVoucher" runat="server" ClientIDMode="Static" Visible="false"
                        CssClass="confirmation-voucher text-center">
                        <div class="mb-3">
                            <div class="d-inline-flex align-items-center justify-content-center bg-success text-white rounded-circle shadow-lg"
                                style="width: 70px; height: 70px;">
                                <i class="bi bi-check-lg fs-1"></i>
                            </div>
                        </div>
                        <span
                            class="badge bg-gold text-dark text-uppercase px-3 py-1.5 rounded-pill font-monospace fw-bold mb-2">Reservation
                            Request Received</span>
                        <h2 class="font-serif fw-bold text-dark mb-1">Table Reservation Confirmed!</h2>
                        <p class="text-muted mb-4">Your dining table at <strong>The Royal Kitchen</strong> has been
                            reserved successfully.</p>

                        <div class="row g-3 justify-content-center mb-4 text-start">
                            <div class="col-md-8">
                                <div class="p-3 bg-light rounded-4 border">
                                    <div class="row g-3">
                                        <div class="col-6">
                                            <small class="text-muted d-block">Reservation Code</small>
                                            <strong class="font-monospace text-primary fs-5" id="vouchCode">
                                                <asp:Literal ID="litVouchCode" runat="server"
                                                    Text="TAB-20260928-0001" />
                                            </strong>
                                        </div>
                                        <div class="col-6">
                                            <small class="text-muted d-block">Restaurant</small>
                                            <strong class="text-dark">The Royal Kitchen</strong>
                                        </div>
                                        <div class="col-6">
                                            <small class="text-muted d-block">Date &amp; Time Slot</small>
                                            <strong class="text-dark" id="vouchDateTime">
                                                <asp:Literal ID="litVouchDateTime" runat="server"
                                                    Text="28 Sep 2026 @ 07:00 PM" />
                                            </strong>
                                        </div>
                                        <div class="col-6">
                                            <small class="text-muted d-block">Reserved Table &amp; Guests</small>
                                            <strong class="text-dark" id="vouchTableGuests">
                                                <asp:Literal ID="litVouchTableGuests" runat="server"
                                                    Text="Table T-01 (2 Guests)" />
                                            </strong>
                                        </div>
                                        <div class="col-12 border-top pt-2">
                                            <small class="text-muted d-block">Guest Name &amp; Contact</small>
                                            <strong class="text-dark" id="vouchGuestName">
                                                <asp:Literal ID="litVouchGuestName" runat="server"
                                                    Text="Rahul Sharma (+91 98765 43210)" />
                                            </strong>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex align-items-center justify-content-center gap-3">
                            <button type="button" class="btn btn-outline-dark rounded-pill px-4 py-2 fw-bold"
                                onclick="window.print();">
                                <i class="bi bi-printer me-1"></i> Print Voucher
                            </button>
                            <a href="Dining.aspx" class="btn btn-navbar-theme rounded-pill px-4 py-2 fw-bold">
                                Return to Dining Page
                            </a>
                        </div>
                    </asp:Panel>

                </div>
            </div>
        </div>

        <!-- JAVASCRIPT LOGIC -->
        <script type="text/javascript">
            document.addEventListener('DOMContentLoaded', function () {
                var dateInput = document.getElementById('txtResDate');
                if (dateInput && !dateInput.value) {
                    var today = new Date().toISOString().split('T')[0];
                    dateInput.value = today;
                    dateInput.setAttribute('min', today);
                }
                filterAvailableTables();
            });

            function filterAvailableTables() {
                var guests = parseInt(document.getElementById('ddlGuestCount').value) || 1;
                var tableItems = document.querySelectorAll('.table-item-box');
                var matchCount = 0;

                tableItems.forEach(function (item) {
                    var status = item.getAttribute('data-status');
                    // Ensure all tables added by admin are always visible
                    item.style.display = 'block';

                    if (status && status.trim().toLowerCase() === 'available') {
                        matchCount++;
                    }
                });

                var countPill = document.getElementById('lblTableMatchCount');
                if (countPill) {
                    countPill.innerText = matchCount + (matchCount === 1 ? " Table Available" : " Tables Available");
                }
            }

            function handleTableCardClick(cardElem) {
                if (!cardElem) return;
                var status = (cardElem.getAttribute('data-status') || '').trim();
                if (status.toLowerCase() !== 'available') return;
                var tableId = cardElem.getAttribute('data-table-id') || '';
                var tableNum = cardElem.getAttribute('data-table-num') || '';
                selectTableCard(cardElem, tableId, tableNum);
            }

            function selectTableCard(cardElem, tableId, tableNum) {
                var cards = document.querySelectorAll('.table-card-select');
                cards.forEach(function (c) { c.classList.remove('selected'); });

                var selectedBox = cardElem.querySelector('.table-card-select');
                if (selectedBox) selectedBox.classList.add('selected');

                document.getElementById('hdnSelectedTableId').value = tableId;
                document.getElementById('hdnSelectedTableNum').value = tableNum;
            }

            function validateTableReservation() {
                var hdnNum = document.getElementById('hdnSelectedTableNum');
                var custName = document.getElementById('txtCustName');
                var custPhone = document.getElementById('txtCustPhone');

                var tableNum = hdnNum ? hdnNum.value.trim() : '';
                var nameVal = custName ? custName.value.trim() : '';
                var phoneVal = custPhone ? custPhone.value.trim() : '';

                if (!tableNum) {
                    alert('Please select an available table from Step 2.');
                    return false;
                }
                if (!nameVal || !phoneVal) {
                    alert('Please fill in your Full Name and Mobile Number.');
                    return false;
                }
                return true;
            }

            document.addEventListener('DOMContentLoaded', function () {
                var cName = document.getElementById('txtCustName');
                var cPhone = document.getElementById('txtCustPhone');
                var cEmail = document.getElementById('txtCustEmail');
                var cReq = document.getElementById('txtSpecialRequest');
                if (cName) cName.value = '';
                if (cPhone) cPhone.value = '';
                if (cEmail) cEmail.value = '';
                if (cReq) cReq.value = '';
            });

            function goToStep(stepNum) {
                if (stepNum === 3) {
                    var hdnNum = document.getElementById('hdnSelectedTableNum');
                    var tableNum = hdnNum ? hdnNum.value.trim() : '';
                    if (!tableNum) {
                        alert('Please select an available table from Step 2 before proceeding.');
                        return;
                    }
                }
                var containers = document.querySelectorAll('.step-container');
                for (var i = 0; i < containers.length; i++) {
                    containers[i].classList.add('d-none');
                }
                var target = document.getElementById('step' + stepNum + '-container');
                if (target) {
                    target.classList.remove('d-none');
                    target.classList.add('fade-in');
                }
                
                var card = document.querySelector('.res-card-luxury');
                if (card) {
                    var y = card.getBoundingClientRect().top + window.scrollY - 80;
                    window.scrollTo({top: y, behavior: 'smooth'});
                }
            }
        </script>
        
        <style>
            .fade-in {
                animation: fadeIn 0.4s ease-in-out;
            }
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }
        </style>

    </asp:Content>