================================================================================
                      THE ROYAL PALACE HOTEL & RESORT
        Enterprise Hotel Management & Hospitality Platform (ASP.NET & C#)
================================================================================

1. PROJECT OVERVIEW
--------------------------------------------------------------------------------
The Royal Palace Hotel Management System is a full-featured, enterprise-grade
hospitality and resort management platform engineered with ASP.NET Web Forms (C#),
Microsoft SQL Server, and Microsoft ASP.NET SignalR.

The platform provides a dual-surface architecture:
1. Public Luxury Guest Portal:
   An opulent, immersive guest experience for exploring luxury suites, gourmet
   dining, resort amenities, photo galleries, online room reservations, fine-dining
   table booking, and guest inquiry communication.
2. Executive Administrative Portal:
   A high-performance administrative command center for hotel managers and
   administrators featuring real-time KPI metrics, room inventory control,
   guest stay lifecycle management, tariff matrices, restaurant operations,
   and live push notifications via WebSockets.

Key Architectural Highlights:
* Bespoke Royal Heritage UI:
  Signature Royal Mahogany Brown (#442305) and Warm Gold (#B88E68 / #9A724E)
  executive theme with Playfair Display, Cormorant Upright, and Plus Jakarta Sans.
* Real-Time WebSocket Push Notifications (SignalR):
  Hub-based real-time event broadcasting notifying connected admin portals instantly
  when room bookings, table reservations, or contact inquiries occur.
* Form Resubmission Guard & PRG Architecture:
  Post-Redirect-Get (PRG) patterns and dual-token validation preventing duplicate
  database insertions or notifications upon page refresh (F5).
* Real-Time Database Synchronization:
  Live SQL Server data binding with 100% parameterized ADO.NET queries across
  rooms, reservations, dining tables, categories, and customer profiles.
* Unified Room Availability & Inventory Matrix:
  Live visual matrix tracking operational states: Available, Occupied (In-House),
  Cleaning (Housekeeping), Maintenance, and Blocked (VIP Hold).
* End-to-End Guest Stay Lifecycle Ledger:
  Automated lifecycle tracking from Search -> Suite Selection -> Double-Check Lock
  -> Actual Check-In (auto-sets Room to Occupied) -> Check-Out (auto-sends Room to
  Cleaning) -> Completed.
* Granular Single-Room Specifications Engine:
  Rich suite details with 5-photo interactive switcher gallery, highlight box,
  categorized amenities, and direct reservation deep-linking.
* Enterprise Security & Privacy Compliance:
  Strict parameterization, zero credential leakage, session role segregation,
  XSS sanitization, and CSRF mitigation.

================================================================================
2. TECHNOLOGY STACK
================================================================================
Backend Framework       : ASP.NET Web Forms (.NET Framework 4.8 / 4.8.1, C#)
Real-Time Communication : Microsoft ASP.NET SignalR (v2.4.3)
Database Engine         : Microsoft SQL Server (LocalDB / Express / Enterprise)
Data Access Layer       : ADO.NET (SqlConnection, SqlCommand, SqlDataReader, SqlDataAdapter)
Frontend Architecture   : HTML5, CSS3, JavaScript (Vanilla ES6+ & jQuery 1.6.4 / 1.11.0)
Styling & Design System : Bootstrap 5.3.2, Custom Luxury CSS (style.css, managehotel.css)
Typography              : Google Fonts (Playfair Display, Plus Jakarta Sans, Cormorant)
Iconography             : Bootstrap Icons (v1.11.3), Font Awesome (v6.5.1)
Charts & Analytics      : Chart.js 4.x (Interactive Doughnut & Spline Line Charts)
Server Environment      : Microsoft IIS 10+ / IIS Express

================================================================================
3. SYSTEM ARCHITECTURE & COMPLETE DIRECTORY MAP
================================================================================
Hotel-Management-Project-1/
│
├── MasterPage.master             # Public Master Page (Header, Nav, Auth State, Footer)
├── MasterPage.master.cs          # Public Master Controller (Session & User State Logic)
├── Logout.aspx                   # Dedicated Customer Logout Gateway
├── Logout.aspx.cs                # Session Destruction & Clean Redirect Logic
├── Web.config                    # Application Settings & Database Configuration
├── style.css                     # Public Master Luxury Stylesheet
├── readme.txt                    # Project Technical Documentation
│
├── App_Code/
│   ├── NotificationHub.cs        # SignalR Hub: Broadcasts live admin notifications
│   └── Startup.cs                # OWIN Startup: Configures SignalR pipeline (/signalr)
│
├── PUBLIC GUEST PORTAL (FRONTEND)
│   ├── index.aspx                # Resort Landing Page: Hero Showcase, Quick Booking Bar
│   ├── index.aspx.cs             # Homepage Data & Highlights Controller
│   ├── Room.aspx                 # Suite Catalog: Dynamic Category Filters & Room Cards
│   ├── Room.aspx.cs              # Database-Driven Inventory Loader
│   ├── RoomDetails.aspx          # Deep Suite Specifications, Interactive 5-Photo Gallery
│   ├── RoomDetails.aspx.cs       # Suite Details Controller & Custom Renderers
│   ├── Booking.aspx              # Multi-Room Reservation & Pricing Overview
│   ├── Booking.aspx.cs           # Booking Calculations & Real-Time SignalR Broadcast
│   ├── BookNow.aspx              # Step-by-Step Checkout, Guest Details & Confirmation
│   ├── BookNow.aspx.cs           # Reservation SQL Insertion & Double-Check Lock
│   ├── Dining.aspx               # Gourmet Dining Showcase & Table Reservations
│   ├── Dining.aspx.cs            # Dining Server Controller
│   ├── TableReservation.aspx     # Interactive Fine-Dining Table Booking Engine
│   ├── TableReservation.aspx.cs  # Table Reservation Insertion & Live SignalR Broadcast
│   ├── Amenities.aspx            # Luxury Spa, Infinity Pool, Concierge & Fitness
│   ├── Amenities.aspx.cs         # Amenities Controller
│   ├── Offers.aspx               # Seasonal Packages, Member Privileges & Promos
│   ├── Offers.aspx.cs            # Offers Catalog Controller
│   ├── OfferDetails.aspx         # Offer Package Breakdown & Validity Rules
│   ├── OfferDetails.aspx.cs      # Offer Details Controller
│   ├── About.aspx                # Resort Heritage, Architecture, Leadership & Awards
│   ├── About.aspx.cs             # About Us Controller
│   ├── Location.aspx             # Maps, Travel Distances, Airport Transfers & Directions
│   ├── Location.aspx.cs          # Location Controller
│   ├── Gallery.aspx              # Visual Media Showcase & Filterable Photo Grid
│   ├── Gallery.aspx.cs           # Gallery Controller
│   ├── Contact.aspx              # Inquiries, Concierge Desk & Contact Form
│   ├── Contact.aspx.cs           # PRG Form Handler, Anti-Refresh Guard & SignalR Push
│   ├── Login.aspx                # Customer Authentication Gateway
│   ├── Login.aspx.cs             # Verification & Customer Session Initiation
│   ├── LoginConfirmation.aspx    # Post-Login Welcome Screen
│   ├── Register.aspx             # Customer Registration Portal
│   ├── Register.aspx.cs          # Account Creation & Data Validation
│   ├── RegistrationConfirmation.aspx # Registration Success Screen
│   ├── MyBookings.aspx           # Customer Stay History & Vouchers
│   ├── MyBookings.aspx.cs        # Customer Bookings Controller
│   ├── Privacy.aspx              # Privacy Policy & Data Security Compliance
│   └── Terms.aspx                # Terms of Service, Cancellation & Refund Policies
│
├── EXECUTIVE ADMIN PORTAL
│   └── admin/
│       ├── AdminMaster.master    # Executive Layout: Real-time SignalR Bell & Nav Sidebar
│       ├── AdminMaster.master.cs # Sidebar State & Session Management
│       ├── Dashboard.aspx        # Executive Command: KPI Metrics, Charts & Quick Actions
│       ├── Dashboard.aspx.cs     # Real-Time Operational Analytics Aggregator
│       ├── ManageHotel.aspx      # Suite Inventory Ledger, Status & Average Tariff KPI
│       ├── ManageHotel.aspx.cs   # Suite Catalog Operations & Category Binding
│       ├── Availability.aspx     # Room Availability & Operational Inventory Matrix
│       ├── Availability.aspx.cs  # Housekeeping Status & Date Overlap Inspection
│       ├── Bookings.aspx         # Reservations & Guest Stay Lifecycle Ledger
│       ├── Bookings.aspx.cs      # Check-In, Check-Out & Cancel Automation Handlers
│       ├── Rooms.aspx            # Room Inventory Directory
│       ├── Rooms.aspx.cs         # Room Directory Controller
│       ├── AddRoom.aspx          # Comprehensive Room Publishing & Multi-Image Upload
│       ├── AddRoom.aspx.cs       # Suite Creation & Image Pipeline Controller
│       ├── EditRoom.aspx         # Suite Specification & Amenity Editor
│       ├── EditRoom.aspx.cs      # Suite Update Controller
│       ├── DeleteRoom.aspx       # Safe Deletion Guard & Reference Checker
│       ├── DeleteRoom.aspx.cs    # Suite Removal Controller
│       ├── ManageCategory.aspx   # Room Categories Overview & Management
│       ├── ManageCategory.aspx.cs# Category Controller
│       ├── AddCategory.aspx      # Category Creator Form
│       ├── AddCategory.aspx.cs   # Category Creation Controller
│       ├── Gallery.aspx          # Admin Media & Gallery Assets Manager
│       ├── Gallery.aspx.cs       # Gallery Management Controller
│       ├── RestaurantManagement.aspx # Dining Details & Operating Hours
│       ├── RestaurantManagement.aspx.cs # Restaurant Controller
│       ├── RestaurantTables.aspx # Table Inventory & Seating Layout
│       ├── RestaurantTables.aspx.cs # Table Setup Controller
│       ├── TableReservations.aspx# Table Booking Ledger & Guest Requests
│       ├── TableReservations.aspx.cs # Table Reservation Controller
│       ├── Menu.aspx             # Restaurant Menu Catalog & Pricing
│       ├── Menu.aspx.cs          # Menu Controller
│       ├── Offers.aspx           # Promotional Deals & Validity Controls
│       ├── Offers.aspx.cs        # Admin Offers Controller
│       ├── Packages.aspx         # Bundled Holiday Packages Manager
│       ├── Packages.aspx.cs      # Packages Controller
│       ├── RoomRates.aspx        # Tariff Adjustments & Dynamic Pricing
│       ├── RoomRates.aspx.cs     # Rate Management Controller
│       ├── Users.aspx            # Registered Customer Directory & Records
│       ├── Users.aspx.cs         # Customer Management Controller
│       ├── Reviews.aspx          # Verified Guest Feedback & Moderation
│       ├── Reviews.aspx.cs       # Reviews Controller
│       ├── Enquiries.aspx        # Contact Inquiries Inbox & Auto-Dismiss Deletions
│       ├── Enquiries.aspx.cs     # Inquiries Controller & 2-Second Notification Timer
│       ├── ContactDetails.aspx   # Hotel Location & Phone/Email Settings
│       ├── ContactDetails.aspx.cs# Contact Settings Controller
│       ├── Settings.aspx         # Hotel System Preferences & Brand Controls
│       ├── Settings.aspx.cs      # Settings Controller
│       ├── Login.aspx            # Administrative Access Gateway
│       ├── Login.aspx.cs         # Admin Authentication & Credential Verification
│       ├── Logout.aspx           # Admin Session Destruction & Redirect
│       ├── Logout.aspx.cs        # Admin Logout Controller
│       ├── css/
│       │   ├── managehotel.css   # Executive Royal Brown/Gold Luxury Theme Standard
│       │   ├── dashboard.css     # KPI Metrics & Chart Containers
│       │   ├── addroom.css       # Form Controls & Image Upload Slots
│       │   └── login.css         # Admin Login Interface
│       └── js/
│           ├── adminmaster.js    # SignalR Client: Real-Time Bell Counter & Dropdown
│           ├── dashboard.js      # Sidebar Toggles, Charts, Live Clock & Analytics
│           ├── addroom.js        # Multi-Image Preview & Form Validation
│           ├── enquiries.js      # Inquiries Real-Time Preview
│           └── managehotel.js    # Suite Inventory Interactivity & Modal Handlers
│
└── ASSETS, MEDIA & SCRIPTS
    ├── Scripts/                  # Local Libraries (SignalR 2.4.3 & jQuery 1.6.4)
    ├── images/                   # High-Res Brand Logos, Banners & Dining Photography
    │   └── rooms/                # Dynamic Primary & Gallery Suite Uploads
    ├── css/                      # Public Modular CSS & Icons
    └── js/                       # Client Helpers & UI Scripts
        ├── room.js               # Category Filter Tab Switcher
        ├── room-details.js       # Smooth Gallery Image Swapper & Modal Handlers
        ├── booking.js            # Live Date Picker & Folio Calculator
        └── script.js             # General Public Site Interactivity

================================================================================
4. CORE MODULE SPECIFICATIONS & WORKFLOWS
================================================================================

--------------------------------------------------------------------------------
MODULE 1: REAL-TIME SIGNALR NOTIFICATION ENGINE
--------------------------------------------------------------------------------
* Server Broadcast Engine (NotificationHub.cs):
  Exposes `NotificationHub.Broadcast(string message)` which safely queries
  `GlobalHost.ConnectionManager.GetHubContext<NotificationHub>()` and broadcasts
  events across all active client instances.
* Client-Side Real-Time Receiver (adminmaster.js):
  Connects to `/signalr/hubs` and listens to `receiveNotification(message)`:
  - Dynamically classifies alert categories:
    * "New Room Booking Alert"    (Blue door icon, deep-links to Bookings.aspx)
    * "New Table Booking Alert"   (Green calendar icon, deep-links to TableReservations.aspx)
    * "New Contact Message Alert" (Gold envelope icon, deep-links to Enquiries.aspx)
  - Increments topbar bell notification badge pill (`#notifBadge`) in real time.
  - Updates counter text (`#notifCountText` -> "X New").
  - Prepends formatted notification card with timestamp to `#notificationList`.
  - Hides empty-state banner (`#noNotifications`) automatically.

--------------------------------------------------------------------------------
MODULE 2: CONTACT INQUIRIES & ANTI-RESUBMISSION GUARD (Contact.aspx)
--------------------------------------------------------------------------------
* Dual-Table Persistence:
  Synchronously saves inquiries to both `ContactEnquiries` (admin inbox) and
  `ContactMessages` tables using parameterized queries.
* Live Admin Notification:
  Fires `NotificationHub.Broadcast` with guest name and subject upon submission.
* Post-Redirect-Get (PRG) Architecture:
  Saves confirmation message to Session and redirects cleanly via HTTP 302 to
  `Contact.aspx` (GET), transitioning the browser history away from POST.
* Anti-Duplicate Session Token:
  Enforces matching GUID submission tokens between Session and ViewState; replayed
  POSTs or refresh attempts with stale tokens are automatically blocked.
* Smooth 2-Second Notification Banner:
  Displays an elegant success banner with a linear 2-second countdown timer bar,
  clearing form fields and smoothly fading out after 2000ms.

--------------------------------------------------------------------------------
MODULE 3: EXECUTIVE DASHBOARD & QUICK ACTIONS (admin/Dashboard.aspx)
--------------------------------------------------------------------------------
* Real-Time Analytics & Live Clocks:
  Live IST date/time display, daily revenue counters, occupancy gauges, and
  interactive Chart.js graphs (Occupancy Trends & Room Status Distribution).
* Quick Actions Shortcuts:
  One-click navigation shortcuts to critical operational modules:
  - [+ New Booking]   -> Direct routing to Bookings.aspx?status=Confirmed
  - [+ Add Room]      -> AddRoom.aspx
  - [Check-In]        -> Bookings.aspx
  - [+ Check-Out]     -> Bookings.aspx
  - [Manage Tables]   -> RestaurantTables.aspx
  - [Tariff Matrix]   -> RoomRates.aspx
* Dining & Table Reservation Mini-Ledger:
  Tabbed switcher between active table reservations and restaurant table seating.

--------------------------------------------------------------------------------
MODULE 4: SUITE INVENTORY & AVERAGE TARIFF (admin/ManageHotel.aspx)
--------------------------------------------------------------------------------
* Dynamic KPI Calculations:
  - Total Suites & Rooms : Total room count configured in SQL database.
  - Publish Status       : Number of suites currently active on the guest portal.
  - Average Tariff       : Mathematically computes average per-night tariff
                           (Sum of PricePerNight of active rooms / Total active rooms).
  - Room Categories      : Count of distinct luxury tiers (e.g. 4 Tiers).
* Live Room Inventory Table:
  Detailed listings displaying image thumbnail, suite title, room number, guest
  capacity, square footage, view, category badge, per-night tariff, live status,
  and quick-action edit/preview controls.

--------------------------------------------------------------------------------
MODULE 5: INQUIRIES & MESSAGE MODERATION (admin/Enquiries.aspx)
--------------------------------------------------------------------------------
* Live Guest Messages Inbox:
  Displays guest name, email, subject, message body, submission timestamp, and status.
* Status Toggle:
  One-click toggle between 'Unread' and 'Read' with instant database sync.
* Silent Deletion with 2-Second Auto-Dismiss:
  Clicking the trash icon directly deletes the inquiry from both database tables
  without blocking browser popups, showing an animated 2-second green confirmation
  banner that smoothly fades out.

--------------------------------------------------------------------------------
MODULE 6: GUEST STAY LIFECYCLE LEDGER (admin/Bookings.aspx)
--------------------------------------------------------------------------------
* End-to-End Lifecycle Stages:
  [Search Dates] -> [Select Suite] -> [Confirmed] -> [Checked-In] -> [Completed]
* Lifecycle State Automation:
  - Check-In  : Advances booking status to 'Checked-In' and auto-updates room
                status in `Rooms` table to 'Occupied'.
  - Check-Out : Advances booking status to 'Completed' and auto-updates room
                status in `Rooms` table to 'Cleaning'.
  - Cancel    : Releases room back to 'Available' and updates reservation status.

--------------------------------------------------------------------------------
MODULE 7: FINE DINING & TABLE RESERVATIONS (TableReservation.aspx, admin/)
--------------------------------------------------------------------------------
* Guest Dining Reservations:
  Allows guests to select date, time slot, guest count, table number, and dietary
  notes, generating instant booking confirmation vouchers.
* Admin Dining Management:
  Includes `RestaurantManagement.aspx` (details & hours), `RestaurantTables.aspx`
  (table capacity & layout), `TableReservations.aspx` (reservations ledger), and
  `Menu.aspx` (culinary catalog).

================================================================================
5. SECURITY & PRIVACY SPECIFICATIONS
================================================================================
* Parameterized SQL Queries:
  100% of all SQL execution utilizes `SqlParameter` objects with explicit SQL types.
  Zero dynamic string concatenation is used, eliminating SQL injection threats.
* Session Segregation:
  Customer session states (`Session["UserId"]`, `Session["UserName"]`) are isolated
  from Administrative session states (`Session["AdminId"]`), preventing privilege
  escalation.
* Anti-Tampering & XSS Mitigation:
  All user-supplied and database-rendered text elements utilize HTML-encoded server
  controls or `HttpUtility.HtmlEncode`.
* Zero Credential Exposure in Public Documentation:
  No administrative passwords, connection strings with plain-text credentials, or
  private cryptographic keys are exposed in public documentation or repositories.
  Database connections are managed via standard Web.config provider references.

================================================================================
6. LOCAL SETUP & RUNNING INSTRUCTIONS
================================================================================
1. SYSTEM PREREQUISITES
   * Microsoft Windows 10 / 11 / Windows Server
   * Microsoft Visual Studio 2019 or Visual Studio 2022
   * ASP.NET and Web Development Workload
   * .NET Framework 4.8 / 4.8.1
   * Microsoft SQL Server (LocalDB / Express / Enterprise)
   * IIS Express or Local IIS Web Server

2. HOW TO LAUNCH
   Step 1: Open Visual Studio.
   Step 2: Choose "Open a Web Site" or "Open Folder" and select the project root:
           `Hotel-Management-Project-1/`
   Step 3: Ensure your local SQL Server instance is running with the hotel database.
   Step 4: Verify the connection string in `Web.config`:
           <connectionStrings>
             <add name="HotelConnection"
                  connectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\HotelDB.mdf;Integrated Security=True"
                  providerName="System.Data.SqlClient" />
           </connectionStrings>
   Step 5: Press [F5] or click [IIS Express] in the Visual Studio toolbar.
   Step 6: Access Public Guest Portal : http://localhost:PORT/index.aspx
           Access Executive Admin     : http://localhost:PORT/admin/Dashboard.aspx

================================================================================
7. VERIFICATION & QUALITY ASSURANCE STATUS
================================================================================
* Compilation Status         : 100% Clean Build verified via ASP.NET runtime
                               (0 Compilation Errors).
* SignalR Endpoints          : Verified active on /signalr/negotiate and /signalr/hubs.
* Anti-Resubmission Checks   : Form resubmission on page refresh (F5) verified blocked.
* Responsive Breakpoints     :
  - Mobile Devices  (320px - 767px)  : Single-column adaptive layouts, touch menus.
  - Tablets & iPads (768px - 1024px) : Multi-column layouts, collapsible sidebars.
  - Desktop Displays(1025px - 1920px): Full luxury widescreen grid layouts.
* Browser Compatibility      : Google Chrome, Mozilla Firefox, Microsoft Edge, Apple Safari.

================================================================================
                     (c) THE ROYAL PALACE HOTEL & RESORT
          Enterprise Hospitality Web Platform - All Rights Reserved
================================================================================
