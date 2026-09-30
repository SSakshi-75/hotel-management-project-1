================================================================================
                      THE ROYAL PALACE HOTEL & RESORT
        Enterprise Hotel Management & Reservation System (ASP.NET & C#)
================================================================================

1. PROJECT OVERVIEW
--------------------------------------------------------------------------------
The Royal Palace Hotel Management System is a comprehensive, enterprise-grade,
full-stack hospitality platform engineered using ASP.NET Web Forms (C#) and
Microsoft SQL Server.

The system delivers an opulent, luxury guest-facing experience coupled with an
executive administrative suite for end-to-end hotel operations, live room
availability synchronization, guest stay lifecycle management, fine dining table
reservations, and verified guest portfolios.

Key System Highlights:
* Bespoke Royal Heritage UI:
  Signature Royal Mahogany Brown (#442305) and Warm Gold (#B88E68 / #9A724E) 
  executive theme with Playfair Display, Cormorant Upright, and Plus Jakarta Sans.
* Real-Time Database Synchronization:
  Live SQL Server data binding with 100% parameterized ADO.NET queries across
  rooms, reservations, dining tables, categories, and customer profiles.
* Unified Room Availability & Inventory Engine:
  Live visual matrix tracking operational states: Available, Occupied (In-House),
  Cleaning (Housekeeping), Maintenance, and Blocked (VIP Hold), alongside date
  range search and automatic reservation overlap detection.
* End-to-End Guest Stay Lifecycle Ledger:
  Automated lifecycle tracking from Search -> Suite Selection -> Double-Check Lock
  -> Actual Check-In (auto-sets Room to Occupied) -> Check-Out (auto-sends Room to
  Cleaning) -> Completed.
* Granular Single-Room Specifications Engine:
  High-performance ASP.NET repeater rendering rich suite details, 5-photo
  interactive switcher gallery, highlight box, categorized amenities, and direct
  reservation deep-linking.
* Customer Account & Session Management:
  Complete guest registration, secure authentication, dynamic personalized master
  navigation with user greeting, and dedicated one-click Customer Logout.
* Dining & Restaurant Management:
  Multi-table reservation engine with capacity controls, menu catalogs, and
  guest reservation tracking.
* Zero-Tolerance Enterprise Security:
  100% Parameterized SQL queries to eliminate SQL injection, segregated session
  privileges, output encoding against XSS, and zero credential leakage.

================================================================================
2. TECHNOLOGY STACK
================================================================================
Backend Framework       : ASP.NET Web Forms (.NET Framework 4.8 / 4.8.1, C#)
Architecture Pattern    : Code-Behind (ASPX + C#), Modular Master Pages
Database Engine         : Microsoft SQL Server (LocalDB / Express / Enterprise)
Data Access Layer       : ADO.NET (SqlConnection, SqlCommand, SqlDataAdapter, DataTable)
Frontend Architecture   : HTML5, CSS3, JavaScript (Vanilla ES6+)
Styling & Design System : Bootstrap 5.3.2, Custom Luxury CSS (style.css, managehotel.css)
Typography              : Google Fonts (Playfair Display, Cormorant Upright, Plus Jakarta Sans)
Iconography             : Bootstrap Icons (v1.11.3), Font Awesome (v6.5.1)
Server Environment      : Microsoft IIS 10+ / IIS Express

================================================================================
3. SYSTEM ARCHITECTURE & COMPLETE DIRECTORY MAP
================================================================================
Hotel-Management-Project-1/
│
├── MasterPage.master             # Public Master Page (Header, Nav, Auth State, Footer)
├── MasterPage.master.cs          # Public Master Code-Behind (Session & User State Logic)
├── Logout.aspx                   # Dedicated Customer Logout Gateway
├── Logout.aspx.cs                # Session Destruction & Clean Redirect Logic
├── Web.config                    # Application Settings & Database Configuration
├── style.css                     # Public Master Luxury Stylesheet
├── readme.txt                    # Project Technical Documentation
│
├── PUBLIC GUEST PORTAL (FRONTEND)
│   ├── index.aspx                # Resort Landing Page: Hero Showcase, Quick Booking Bar
│   ├── index.aspx.cs             # Homepage Data & Highlights Controller
│   ├── Room.aspx                 # Suite Catalog: Dynamic Category Filters & Room Cards
│   ├── Room.aspx.cs              # Database-Driven Inventory Loader
│   ├── RoomDetails.aspx          # Deep Suite Specifications, Interactive 5-Photo Gallery
│   ├── RoomDetails.aspx.cs       # Suite Details Controller & Custom Renderers
│   ├── Booking.aspx              # Multi-Room Reservation & Pricing Overview
│   ├── Booking.aspx.cs           # Booking Server Calculations
│   ├── BookNow.aspx              # Step-by-Step Checkout, Guest Details & Confirmation
│   ├── BookNow.aspx.cs           # Reservation SQL Insertion & Double-Check Lock
│   ├── Dining.aspx               # Gourmet Dining Showcase & Table Reservations
│   ├── Dining.aspx.cs            # Dining Server Controller
│   ├── Amenities.aspx            # Luxury Spa, Infinity Pool, Concierge & Fitness
│   ├── Amenities.aspx.cs         # Amenities Controller
│   ├── Offers.aspx               # Seasonal Packages, Member Privileges & Promos
│   ├── Offers.aspx.cs            # Offers Catalog Controller
│   ├── OfferDetails.aspx         # Offer Package Breakdown & Validity Rules
│   ├── OfferDetails.aspx.cs      # Offer Details Controller
│   ├── About.aspx                # Resort Heritage, Royal Architecture, Leadership & Awards
│   ├── About.aspx.cs             # About Us Controller
│   ├── Location.aspx             # Maps, Travel Distances, Airport Transfers & Directions
│   ├── Location.aspx.cs          # Location Controller
│   ├── Gallery.aspx              # Visual Media Showcase & Filterable Photo Grid
│   ├── Gallery.aspx.cs           # Gallery Controller
│   ├── Contact.aspx              # Inquiries, Concierge Desk & Contact Form
│   ├── Contact.aspx.cs           # Inquiry Submission Handler
│   ├── Login.aspx                # Customer Authentication Gateway
│   ├── Login.aspx.cs             # Verification & Customer Session Initiation
│   ├── LoginConfirmation.aspx    # Post-Login Welcome Screen
│   ├── Register.aspx             # Customer Registration Portal
│   ├── Register.aspx.cs          # Account Creation & Data Validation
│   ├── RegistrationConfirmation.aspx # Registration Success Screen
│   ├── Privacy.aspx              # Privacy Policy & Data Security Compliance
│   └── Terms.aspx                # Terms of Service, Cancellation & Refund Policies
│
├── EXECUTIVE ADMIN PORTAL
│   └── admin/
│       ├── AdminMaster.master    # Executive Layout: Collapsible Sidebar & Topbar
│       ├── AdminMaster.master.cs # Navigation Active-State & Notification Engine
│       ├── Dashboard.aspx        # Executive Command: KPI Metrics & Performance Analytics
│       ├── Dashboard.aspx.cs     # Real-Time Operational Analytics Aggregator
│       ├── ManageHotel.aspx      # Gold Standard Suite Management & Grid View
│       ├── ManageHotel.aspx.cs   # Suite Catalog Operations & Category Binding
│       ├── Availability.aspx     # Room Availability & Operational Inventory Matrix
│       ├── Availability.aspx.cs  # Housekeeping Status & Date Overlap Inspection
│       ├── Bookings.aspx         # Reservations & Guest Stay Lifecycle Ledger
│       ├── Bookings.aspx.cs      # Check-In, Check-Out & Cancel Automation Handlers
│       ├── Rooms.aspx            # Room Inventory Overview & Operations
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
│       ├── Enquiries.aspx        # General Inquiries & Contact Submissions
│       ├── Enquiries.aspx.cs     # Inquiry Management Controller
│       ├── Settings.aspx         # Hotel System Preferences & Brand Controls
│       ├── Settings.aspx.cs      # Settings Controller
│       ├── Login.aspx            # Administrative Access Gateway
│       ├── Login.aspx.cs         # Admin Authentication & Credential Verification
│       ├── css/
│       │   ├── managehotel.css   # Executive Royal Brown/Gold Luxury Theme Standard
│       │   ├── dashboard.css     # KPI Metrics & Chart Containers
│       │   ├── addroom.css       # Form Controls & Image Upload Slots
│       │   └── login.css         # Admin Login Interface
│       └── js/
│           ├── dashboard.js      # Sidebar Toggles, Charts & Live Clocks
│           └── addroom.js        # Multi-Image Preview & Form Validation
│
└── ASSETS, MEDIA & SCRIPTS
    ├── images/                   # High-Res Brand Logos, Banners & Dining Photography
    │   └── rooms/                # Dynamic Primary & Gallery Suite Uploads
    ├── css/                      # Public Modular CSS & Icons
    └── js/                       # Client Helpers & UI Scripts
        ├── room.js               # Category Filter Tab Switcher
        ├── room-details.js       # Smooth Gallery Image Swapper & Modal Handlers
        └── booking.js            # Live Date Picker & Folio Calculator

================================================================================
4. DETAILED FUNCTIONAL MODULES & FEATURES
================================================================================

--------------------------------------------------------------------------------
MODULE 1: PUBLIC ROOM CATALOG & DYNAMIC FILTERING (Room.aspx)
--------------------------------------------------------------------------------
* Data-Driven Repeater: Automatically streams all active suites from SQL Server
  `Rooms` table ordered by publication date.
* Category Tabs: Seamless switching across All Accommodations, Executive Suites,
  Deluxe Rooms, Family Suites, Royal King Chambers, and Penthouse Havens.
* Rich Suite Cards: Displays primary suite image, category badge, suite name,
  per-night tariff in INR, maximum guest capacity, area in m², view orientation,
  and checkmark amenities.
* Deep Linking: "View Details" button automatically routes guests directly to
  `RoomDetails.aspx?RoomId={ID}`.

--------------------------------------------------------------------------------
MODULE 2: SINGLE SUITE SPECIFICATIONS ENGINE (RoomDetails.aspx)
--------------------------------------------------------------------------------
* Precision Loading: Reads `RoomId` via QueryString and loads specific suite data
  using parameterized ADO.NET SQL adapter.
* Luxury 5-Image Gallery:
  - 1 Primary Large Feature Viewport on the left (360px height).
  - 4 High-Resolution Thumbnails on the right in a 2x2 grid.
  - Interactive Swap: Clicking any thumbnail instantly swaps it into the main
    viewport smoothly without reloading the page (`swapGallery(this)`).
* Highlight Testimonial Box: Soft gradient card, 1px gold border, circular gold
  star icon, "Premium Experience" badge, quoted review, and verified guest author.
* Categorized 4-Column Amenities:
  1. Sleeping   : King bed, Egyptian cotton linens, memory foam pillows, drapes.
  2. Technology : High-speed Wi-Fi, 55" 4K Smart OLED TV, Bluetooth soundbar.
  3. Comfort    : Touch climate control, gourmet minibar, coffee machine, safe.
  4. Bathroom   : Italian marble bath, rain glass shower, luxury bathrobes.
* Stay Policies & Enhance Your Stay: Check-in/out times, free cancellation terms,
  breakfast package add-ons, and quick booking inquiry modal.

--------------------------------------------------------------------------------
MODULE 3: CUSTOMER AUTHENTICATION & DYNAMIC HEADER (Login.aspx, Logout.aspx)
--------------------------------------------------------------------------------
* Guest Login & Registration: Validates guest credentials, initializes secure
  `Session["UserEmail"]` and `Session["UserName"]`.
* Personalized Header State: When logged in, [MasterPage.master] dynamically:
  - Replaces "Login" button with customer greeting (e.g. "Hi, Sakshi").
  - Displays direct "My Bookings" button.
  - Displays dedicated "Logout" button.
* Dedicated Logout Handler: [Logout.aspx] cleanly flushes session keys, abandons
  the session, clears authentication cookies, and returns the guest to the homepage.

--------------------------------------------------------------------------------
MODULE 4: EXECUTIVE ADMIN MASTER & THEME (admin/AdminMaster.master)
--------------------------------------------------------------------------------
* Unified Executive Layout: Fixed responsive sidebar, branded header with
  gold accents, live date/time display, and breadcrumbs.
* Navigation Menu Structure:
  - Dashboard
  - Hotel Management (Manage Hotel, Add Room, Manage Category, Add Category, Gallery)
  - Reservations (All Bookings, New Booking, Check-in / Out)
  - Rates & Availability (Room Rates, Room Availability)
  - Offers & Packages (Offers, Packages)
  - Dining & Restaurant (Restaurant Details, Manage Tables, Table Reservations, Menu)
  - Customers (Registered Users)
  - Reviews (Guest Feedback)
  - Enquiries (Contact Submissions)
  - Settings (System Preferences)
* Matching Royal Brown & Gold Theme: All admin pages standardized using
  `managehotel.css` with Playfair Display titles, gradient cards, and gold accents.

--------------------------------------------------------------------------------
MODULE 5: ROOM AVAILABILITY & INVENTORY MATRIX (admin/Availability.aspx)
--------------------------------------------------------------------------------
* Luxury KPI Overview:
  1. Total Suites & Rooms : Total rooms configured in SQL database.
  2. Available            : Rooms currently ready for incoming guests.
  3. Occupied (In-House)  : Rooms with currently checked-in guests.
  4. Cleaning             : Rooms undergoing housekeeping turnover.
  5. Maintenance / Blocked: Rooms placed on maintenance or VIP admin hold.
* Date Range Inspection Toolbar:
  Allows staff to enter Target Check-In and Target Check-Out dates to evaluate
  future inventory and detect booking overlaps in real-time.
* Inventory Ledger & Status Controls:
  Displays room preview, specs, category, tariff, capacity, Current Status,
  Date Availability, and one-click lifecycle buttons:
  - [Available]   : Marks room as clean and ready for occupancy.
  - [Cleaning]    : Sends room to housekeeping queue.
  - [Maintenance] : Places room on out-of-order maintenance hold.
  - [Block]       : Locks room under administrative VIP block.

--------------------------------------------------------------------------------
MODULE 6: RESERVATIONS & GUEST STAY LIFECYCLE (admin/Bookings.aspx)
--------------------------------------------------------------------------------
* Automated 6-Step Lifecycle Progress Flow:
  [1. Search Dates] -> [2. Select Suite] -> [3. Reservation] ->
  [4. Check-In]     -> [5. Check-Out]    -> [6. Completed]
* Executive KPI Summary:
  - Total Reservations   : All-time reservation ledger count.
  - Confirmed (Upcoming) : Bookings secured and awaiting guest arrival.
  - In-House Guests      : Currently checked-in guests residing in suites.
  - Completed Stays      : Successfully completed and billed stays.
  - Total Revenue        : Gross secured revenue in INR.
* Search & Status Filter:
  Instant filtering across guest names, email, phone, reference numbers, suite
  names, and booking statuses (Confirmed, Checked-In, Completed, Cancelled).
* Automated Stay Actions:
  - Actual Check-In  : Advances booking to 'Checked-In' and automatically sets
                       the assigned room status in SQL Server to 'Occupied'.
  - Check-Out        : Advances booking to 'Completed' and automatically updates
                       the room status to 'Cleaning' for housekeeping turnover.
  - Cancel Booking   : Cancels reservation, confirms cancellation, and releases
                       the room back to 'Available'.

--------------------------------------------------------------------------------
MODULE 7: SUITE PUBLISHING & EDITING ENGINE (admin/AddRoom.aspx, EditRoom.aspx)
--------------------------------------------------------------------------------
* Comprehensive Suite Form: Basic room metadata, pricing, capacity, dimensions,
  view orientation, amenities, extended descriptions, and highlights.
* Multi-Slot Image Upload Pipeline:
  - Slot 1: Primary Listing Image (Card Thumbnail)
  - Slot 2: Hero Header Banner
  - Slots 3-6: 4 High-Resolution Gallery Photos (Bedding, Bath, Living, Balcony)
* Automated File Processing: Validates extensions, assigns GUID-based secure
  filenames, and persists files into `~/images/rooms/`.

================================================================================
5. SECURITY & DATA PRIVACY ARCHITECTURE
================================================================================
* Parameterized SQL Execution:
  100% of all database commands utilize `SqlParameter` objects with explicit
  type declarations. Dynamic SQL string concatenation is strictly prohibited,
  providing complete immunity against SQL injection vulnerabilities.
* Segregated Role Sessions:
  Customer sessions (`Session["UserEmail"]`, `Session["UserName"]`) and Admin
  sessions are completely isolated, preventing privilege escalation.
* Output Encoding & XSS Prevention:
  All user-supplied and database-rendered text elements are rendered using
  ASP.NET server controls or encoded via `HttpUtility.HtmlEncode`.
* Zero Credential Leakage:
  All sensitive credentials, database connection strings, passwords, and
  administrative authentication keys are kept strictly protected within server
  configurations and are never hard-coded or exposed in public documentation.

================================================================================
6. LOCAL SETUP & RUNNING INSTRUCTIONS
================================================================================
1. PREREQUISITES
   * Microsoft Windows 10 / 11 / Windows Server
   * Microsoft Visual Studio 2019 or Visual Studio 2022
   * ASP.NET and Web Development Workload
   * .NET Framework 4.8 / 4.8.1
   * Microsoft SQL Server (LocalDB / Express / Enterprise)
   * IIS Express or Local IIS Web Server

2. HOW TO LAUNCH
   Step 1: Open Visual Studio.
   Step 2: Choose "Open a Web Site" or "Open Folder" and select the root directory:
           `Hotel-Management-Project-1/`
   Step 3: Ensure your local SQL Server instance is running with `HotelManagementDB`.
   Step 4: Verify connection settings in `Web.config`:
           <connectionStrings>
             <add name="HotelConnection" 
                  connectionString="Server=(LocalDB)\MSSQLLocalDB;Database=HotelManagementDB;Integrated Security=True;" 
                  providerName="System.Data.SqlClient" />
           </connectionStrings>
   Step 5: Press [F5] or click [IIS Express] in the top toolbar.
   Step 6: Access Public Portal: http://localhost:8088/index.aspx
           Access Admin Portal : http://localhost:8088/admin/Dashboard.aspx

================================================================================
7. QUALITY ASSURANCE & VERIFICATION STATUS
================================================================================
* ASP.NET Compilation Status : 100% Clean Build verified via `aspnet_compiler.exe`
                               (Exited with Code 0 - 0 Errors).
* Runtime Server Validation  : Verified HTTP 200 OK across public and admin pages
                               via active IIS Express service.
* UI & Responsiveness Checks :
  - Mobile Phones  (320px - 767px)  : Single-column responsive layout, touch menus.
  - Tablets & iPads(768px - 1024px) : 2-column adaptive layouts, collapsible sidebars.
  - Desktop Displays(1025px - 1920px): Full luxury multi-column grid layouts.
* Cross-Browser Compatibility: Google Chrome, Mozilla Firefox, Microsoft Edge, Safari.

================================================================================
                 (c) THE ROYAL PALACE HOTEL & RESORT
        Enterprise Hospitality Web Platform - All Rights Reserved
================================================================================
