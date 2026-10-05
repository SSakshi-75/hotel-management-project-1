<%@ Page Title="My Bookings | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="MyBookings.aspx.cs" Inherits="MyBookings" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <section class="room-compact-hero text-white text-center">
            <div class="container py-2 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
                <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                    <i class="bi bi-journal-check me-1 text-warning"></i>
                    Your Stay History
                </span>
                <h1 class="display-4 font-serif fw-bold text-white mb-2">My Bookings</h1>
                <p class="text-champagne-gold fs-5 mb-0 font-serif">
                    Manage and view your reservations
                </p>
            </div>
        </section>

        <div class="container my-5">
            <div class="row">
                <div class="col-12">
                    <h4 class="font-serif fw-bold mb-3 text-dark"><i class="bi bi-door-open-fill text-warning me-2"></i>Room Bookings</h4>
                    <asp:Repeater ID="rptBookings" runat="server">
                        <HeaderTemplate>
                            <div class="table-responsive shadow-sm rounded">
                                <table class="table table-hover align-middle mb-0 bg-white border">
                                    <thead class="table-dark text-uppercase small">
                                        <tr>
                                            <th>Ref ID</th>
                                            <th>Room</th>
                                            <th>Check-In</th>
                                            <th>Check-Out</th>
                                            <th>Amount</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="fw-bold">
                                    <%# Eval("BookingReference") %>
                                </td>
                                <td>
                                    <%# Eval("RoomName") %>
                                </td>
                                <td>
                                    <%# Convert.ToDateTime(Eval("CheckInDate")).ToString("dd MMM yyyy") %>
                                </td>
                                <td>
                                    <%# Convert.ToDateTime(Eval("CheckOutDate")).ToString("dd MMM yyyy") %>
                                </td>
                                <td>&#8377;<%# Eval("TotalAmount") %>
                                </td>
                                <td>
                                    <%# GetStatusBadge(Eval("BookingStatus")) %>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                    </tbody>
                                </table>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>

                    <h4 class="font-serif fw-bold mt-5 mb-3 text-dark"><i class="bi bi-cup-hot-fill text-warning me-2"></i>Table Reservations</h4>
                    <asp:Repeater ID="rptTableBookings" runat="server">
                        <HeaderTemplate>
                            <div class="table-responsive shadow-sm rounded">
                                <table class="table table-hover align-middle mb-0 bg-white border">
                                    <thead class="table-dark text-uppercase small">
                                        <tr>
                                            <th>Ref ID</th>
                                            <th>Table No</th>
                                            <th>Date</th>
                                            <th>Time Slot</th>
                                            <th>Guests</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="fw-bold"><%# Eval("BookingCode") %></td>
                                <td><%# Eval("TableNumber") %></td>
                                <td><%# Convert.ToDateTime(Eval("ReservationDate")).ToString("dd MMM yyyy") %></td>
                                <td><%# Eval("TimeSlot") %></td>
                                <td><%# Eval("GuestCount") %></td>
                                <td>
                                    <%# GetStatusBadge(Eval("Status")) %>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                    </tbody>
                                </table>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoBookings" runat="server" Visible="false"
                        CssClass="text-center py-5 shadow-sm rounded bg-white border mt-4">
                        <i class="bi bi-calendar-x display-1 text-muted mb-3 d-block"></i>
                        <h3 class="font-serif fw-bold">No Bookings Found</h3>
                        <p class="text-muted">You haven't made any room or table reservations yet.</p>
                        <div class="d-flex justify-content-center gap-3 mt-3">
                            <a href="Room.aspx" class="btn btn-theme px-4 py-2">Book a Room</a>
                            <a href="TableReservation.aspx" class="btn btn-outline-dark px-4 py-2">Reserve a Table</a>
                        </div>
                    </asp:Panel>
                </div>
        </div>
        </div>
    </asp:Content>