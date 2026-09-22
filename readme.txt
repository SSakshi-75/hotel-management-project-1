================================================================================
                    THE ROYAL PALACE HOTEL & RESORT
       Enterprise Hotel Management & Reservation System (ASP.NET & C#)
================================================================================

1. PROJECT OVERVIEW
--------------------------------------------------------------------------------
The Royal Palace Hotel Management System is an enterprise-grade, full-stack 
hospitality web application designed and built using ASP.NET Web Forms (C#) 
and Microsoft SQL Server. 

The platform delivers an opulent, luxury guest-facing portal with seamless 
online room discovery, detailed suite specifications, dynamic photo galleries, 
and reservation management, backed by a comprehensive Executive Admin Portal 
for managing rooms, galleries, reservations, guest inquiries, and operations.

Key System Highlights:
* Bespoke Royal Heritage UI: Premium Mahogany (#442305) and Warm Gold (#B88E68 / #9A724E) 
  color palette with Playfair Display, Cormorant Upright, and Plus Jakarta Sans typography.
* Dynamic Data-Driven Architecture: Seamless ADO.NET database binding with parameterized 
  queries for rooms, pricing, amenities, galleries, and reviews.
* Granular Single-Room Details Engine: High-performance ASP.NET Repeater dynamically 
  rendering exact room specifications, 5-photo interactive gallery, verified guest review 
  highlight box, and categorized luxury amenity cards based on URL parameters.
* End-to-End Room Management: Dedicated Admin Room Publishing Engine supporting image 
  uploads, rate configuration, specs, and real-time database updates.
* Multi-Step Booking & Calculations: Automated nightly calculation with 18% GST tax, 
  special add-on packages, and verified inquiry modals.
* Enterprise Security: 100% Parameterized SQL queries preventing SQL Injection, 
  secure session handling, cryptographic password protection, and HTML sanitization.
* Fully Responsive Design: Pixel-perfect cross-device layouts for mobile, tablet, 
  laptop, and 4K desktop screens using Bootstrap 5 and customized CSS.

================================================================================
2. TECHNOLOGY STACK
================================================================================
Backend Framework       : ASP.NET Web Forms (.NET Framework 4.8.1 / C#)
Architecture Pattern    : Code-Behind (ASPX + C#), Modular Master Pages
Database Management     : Microsoft SQL Server (LocalDB / Express / Enterprise)
Data Access Layer       : ADO.NET (SqlConnection, SqlCommand, SqlDataAdapter, DataTable)
Frontend Core           : HTML5, CSS3, JavaScript (ES6+)
CSS & UI Architecture   : Bootstrap 5.3.2, Custom Modular CSS, Flexbox & CSS Grid
Typography & Icons      : Google Fonts (Playfair Display, Cormorant Upright, Plus Jakarta Sans),
                          Bootstrap Icons (1.11.3), Font Awesome 6.5.1
Animations & Effects    : AOS (Animate on Scroll), Swiper.js, CSS Keyframe Transitions
Server Environment      : Microsoft IIS / IIS Express, ASP.NET Web Application Server

================================================================================
3. PROJECT ARCHITECTURE & FILE DIRECTORY MAP
================================================================================
Hotel-Management-Project-1/
│
├── MasterPage.master          # Public Master Page (Header, Nav, Footer, Modals)
├── MasterPage.master.cs       # Public Master Page Code-Behind
├── Web.config                 # Database Connection Configuration & Runtime Settings
├── style.css                  # Master Brand Theme & Component Stylesheet (8,000+ lines)
├── readme.txt                 # Master Project Technical Documentation
│
├── PUBLIC GUEST PORTAL (FRONTEND)
│   ├── index.aspx             # Resort Homepage: Hero Slider, Highlights, Quick Booking
│   ├── index.aspx.cs          # Homepage Server Logic
│   ├── Room.aspx              # Room Listing Catalog: Category Filter & Dynamic Room Cards
│   ├── Room.aspx.cs           # Database Query & DataBinding for Room Cards
│   ├── RoomDetails.aspx       # Single Suite Specifications, Gallery & Booking Page
│   ├── RoomDetails.aspx.cs    # Suite Details Controller & Helper Renderers
│   ├── Booking.aspx           # Multi-Room Reservation & Pricing Overview
│   ├── Booking.aspx.cs        # Booking Page Server Logic
│   ├── BookNow.aspx           # Step-by-Step Checkout, Guest Details & Confirmation
│   ├── BookNow.aspx.cs        # Final Reservation Processing
│   ├── Dining.aspx            # Gourmet Fine Dining, Menus & Table Reservations
│   ├── Dining.aspx.cs         # Dining Page Controller
│   ├── Amenities.aspx         # Resort Spa, Infinity Pool & Concierge Services
│   ├── Amenities.aspx.cs      # Amenities Page Controller
│   ├── Offers.aspx            # Seasonal Packages, Member Discounts & Promo Codes
│   ├── Offers.aspx.cs         # Offers Controller
│   ├── OfferDetails.aspx      # Detailed Promo Offer Breakdown
│   ├── OfferDetails.aspx.cs   # Offer Details Controller
│   ├── About.aspx             # Hotel Heritage, History, Leadership & Awards
│   ├── About.aspx.cs          # About Us Controller
│   ├── Location.aspx          # Interactive Map, Nearby Attractions & Directions
│   ├── Location.aspx.cs       # Location Controller
│   ├── Gallery.aspx           # Resort Photo & Video Showcase Gallery
│   ├── Gallery.aspx.cs        # Gallery Controller
│   ├── Contact.aspx           # Inquiry Contact Form, Reception & Concierge Desk
│   ├── Contact.aspx.cs        # Contact Submission Handler
│   ├── Login.aspx             # Guest User Authentication Portal
│   ├── Login.aspx.cs          # Authentication & Session Initiation
│   ├── LoginConfirmation.aspx # Post-Authentication Redirect & Greeting
│   ├── Register.aspx          # New Guest Account Registration & Validation
│   ├── Register.aspx.cs       # Password Hashing & User Insertion Logic
│   ├── RegistrationConfirmation.aspx # Registration Success Screen
│   ├── Privacy.aspx           # Privacy Policy & Data Security Compliance
│   └── Terms.aspx             # Terms of Service & Cancellation Policies
│
├── ADMIN EXECUTIVE MANAGEMENT PORTAL
│   └── admin/
│       ├── AdminMaster.master # Unified Executive Admin Layout with Sidebar & Topbar
│       ├── AdminMaster.master.cs # Admin Master Navigation State Controller
│       ├── Dashboard.aspx     # Operational Metrics (Revenue, Occupancy, Bookings, Trends)
│       ├── Dashboard.aspx.cs  # Metrics Aggregation & Dynamic Analytics Loader
│       ├── Rooms.aspx         # Hotel Room Inventory Catalog & Management View
│       ├── Rooms.aspx.cs      # Admin Room Management Operations
│       ├── AddRoom.aspx       # Unified Add Room & Suite Specification Form
│       ├── AddRoom.aspx.cs    # Room Publishing Controller & Multi-Image Upload Engine
│       ├── ManageRoomDetails.aspx # Room Details Page Customizer (Galleries, Policies)
│       ├── ManageRoomDetails.aspx.cs # Room Details Configuration Controller
│       ├── Login.aspx         # Secure Administrative Access Gateway
│       ├── Login.aspx.cs      # Role-Based Verification & Admin Session Security
│       ├── css/
│       │   ├── dashboard.css  # Admin Dashboard & Metric Cards Design
│       │   └── addroom.css    # Admin Form & Image Slot Layout System
│       └── js/
│           ├── dashboard.js   # Analytics Charts (Chart.js) & Live Stat Counters
│           ├── addroom.js     # Form Validation, Image Preview & Slot Handlers
│           └── login.js       # Admin Security Validation Script
│
└── ASSETS, MEDIA & LIBRARIES
    ├── images/                # High-Res Logos, Hero Banners, Food & Resort Photos
    │   └── rooms/             # Admin-Uploaded Primary & Gallery Suite Photos
    ├── css/                   # Sub-stylesheets & Third-Party CSS Frameworks
    └── js/                    # Client-Side Helpers, Gallery Lightbox & Date Handlers
        ├── room.js            # Room Filter Tab Switcher & Dynamic Navigation
        └── room-details.js    # Gallery Photo Swap, Inquiry Modal & Book Now Sync

================================================================================
4. DETAILED FUNCTIONAL MODULES
================================================================================

MODULE 1: ROOMS CATALOG & CATEGORY FILTERING (Room.aspx)
--------------------------------------------------------------------------------
* Data-Driven Repeater: Automatically loads active inventory from SQL Server `Rooms` 
  table ordered by newest additions.
* Category Filtering: Instant filtering across suites and rooms:
  - All Accommodations
  - Executive Suites
  - Deluxe Rooms
  - Family Suites
  - Royal King Chambers
  - Penthouse Havens
* Responsive Room Cards: Displays primary suite image, category badge, room title, 
  nightly tariff (formatted with currency symbol), guest capacity, area in m², 
  scenic view type, and key amenity checkmarks.
* Dynamic Deep-Linking: Every room card features a "View Details" button automatically 
  mapped to `RoomDetails.aspx?RoomId={ID}` to open the exact suite's specifications.

MODULE 2: SUITE SPECIFICATIONS & DETAILS ENGINE (RoomDetails.aspx)
--------------------------------------------------------------------------------
* Single-Room Precision Loading: Code-behind securely reads `RoomId` (or fallback 
  title parameters) and loads only the requested room via ADO.NET `SqlDataAdapter`.
* Hero Header Banner: Dynamic luxury banner showcasing top category badge, bespoke hero 
  title, curated subtitle tagline, and interactive breadcrumb navigation.
* Overview & Specifications:
  - Main primary high-res room image with category badge overlay.
  - Guest rating score with dynamic 5-star / half-star icon calculation.
  - Key specifications grid: Max Guests, Room Area, and View Type.
  - Price per night badge with live "Book Now" routing.
* Luxury 5-Image Gallery Grid:
  - 1 Primary Large Feature Photo on the left (height: 360px).
  - 4 High-Resolution Thumbnails on the right in a 2x2 grid (Photo Slots 1 to 4).
  - Interactive Gallery Switcher: Clicking any thumbnail instantly swaps it with the 
    main viewport smoothly without page reload (`swapGallery(this)`).
* Room Overview & Highlight Card:
  - Multi-paragraph rich overview text formatted with luxury line spacing.
  - Highlight Box (`.highlight-box`): Soft gradient background, 1px gold border, 
    circular golden star icon, "Premium Experience" header, quoted guest testimonial, 
    and verified guest author attribution.
* Categorized 4-Column Luxury Amenities:
  - Four distinct amenity cards matching resort theme (`.amenity-category`):
    1. Sleeping   : King emperor bed, Egyptian cotton linens, Memory foam pillows, Blackout drapes
    2. Technology : High-speed Wi-Fi, 55" 4K Smart OLED TV, Bluetooth soundbar, USB-C hub
    3. Comfort    : Touch climate control, Gourmet mini bar, Coffee machine, Electronic safe
    4. Bathroom   : Italian marble bath, Rain glass shower, Luxury toiletries, Bathrobes & slippers
* Tabbed Information System:
  - Tab 1: Policies (Check-in 2:00 PM, Check-out 11:00 AM, 24-hr Free Cancellation)
  - Tab 2: Location & Attractions (Diplomatic Enclave, Airport Transfer, Metro)
  - Tab 3: Dedicated Services (24/7 Royal Concierge, Fine In-Room Dining, Housekeeping)
* Enhance Your Stay Add-ons:
  - Royal Gourmet Breakfast Package
  - Luxury Thermal Spa & Hydrotherapy Access
  - VIP Sedan Airport Transfer
* Quick Booking Inquiry Modal:
  - Client-side validated popup form for instant guest check-in/check-out inquiry.

MODULE 3: ADMIN ADD ROOM & SPECIFICATION PUBLISHING (admin/AddRoom.aspx)
--------------------------------------------------------------------------------
* Unified Administration Form: Allows administrators to publish both basic listing 
  data and full room detail page specifications in a single operation:
  - Section 1: Basic Information
    * Room/Suite Title
    * Room Category Filter (Dropdown)
    * Price Per Night in INR
    * Category Badge Tag (e.g. EXECUTIVE, DELUXE)
    * Rating Score (e.g. 4.9 out of 5.0)
    * Guest Capacity, Room Size (m²), and View Type
    * Primary Listing Image (File Upload)
    * Short Card Description
    * Key Amenity Checkbox Pills
  - Section 2: Extended Room Details
    * Top Banner Badge Text
    * Page Hero Title & Subtitle Tagline
    * Featured Header Image (File Upload)
    * Detailed Room Overview (Long-form description)
    * Suite Highlights (Comma-separated highlights)
    * 4 Photo Gallery Upload Slots (Main, Bedding, Bathroom, Balcony)
    * Featured Guest Review Quote & Author Details
* Automated Asset Pipeline: Validates, saves, and links uploaded files to `~/images/rooms/`.
* Secure Database Execution: Parameterized SQL INSERT transaction populates the `Rooms` 
  table with unique auto-increment sequence identifiers.
* Admin Feedback Panel: Instant alert banner confirming publication success.

MODULE 4: EXECUTIVE DASHBOARD & ADMIN PORTAL (admin/Dashboard.aspx)
--------------------------------------------------------------------------------
* KPI Metrics: Real-time calculation of Total Bookings, Monthly Revenue, Occupancy Rate, 
  and Total Registered Guests.
* Live Interactive Charts: Chart.js integrations rendering monthly revenue trends and 
  occupancy percentage distributions.
* Recent Reservations Table: Tabular breakdown of latest guest bookings with live status 
  badges (Confirmed, Pending, Cancelled) and quick action controls.
* Responsive Sidebar: Multi-level collapsible menu system with brand logo header.

MODULE 5: GUEST BOOKING ENGINE & CHECKOUT (Booking.aspx & BookNow.aspx)
--------------------------------------------------------------------------------
* Dynamic Date Picker & Night Calculator: Real-time calculation of total nights 
  between check-in and check-out.
* Live Price Summary: Automatically calculates Subtotal = (Nights x Tariff) + Add-ons.
* GST Tax Calculator: Automatically computes standard 18% hospitality tax.
* Guest Details Capture: Full Name, Email, Phone, Special Requests, and Room Preferences.
* Secure Payment Gateway Simulation: Card, UPI, Net Banking, and Pay-At-Hotel modes.

================================================================================
5. DATABASE SCHEMA SPECIFICATIONS
================================================================================

TABLE: Rooms
--------------------------------------------------------------------------------
* Id                : INT (Identity, Primary Key)
* RoomID            : INT (Auto-generated from sequence [RoomIDSequence])
* RoomName          : NVARCHAR(150), Not Null
* RoomCategory      : NVARCHAR(50), Not Null
* PricePerNight     : NVARCHAR(50), Not Null
* CategoryBadge     : NVARCHAR(50), Nullable
* Rating            : NVARCHAR(10), Nullable
* MaxGuests         : NVARCHAR(50), Nullable
* RoomArea          : NVARCHAR(50), Nullable
* ViewType          : NVARCHAR(100), Nullable
* PrimaryRoomImage  : NVARCHAR(255), Nullable
* ShortDescription  : NVARCHAR(MAX), Nullable
* KeyAmenities      : NVARCHAR(500), Nullable
* HeaderBadge       : NVARCHAR(100), Nullable
* HeaderTitle       : NVARCHAR(150), Nullable
* HeaderSubtitle    : NVARCHAR(255), Nullable
* HeaderImage       : NVARCHAR(255), Nullable
* FullOverview      : NVARCHAR(MAX), Nullable
* Highlights        : NVARCHAR(MAX), Nullable
* GalleryImage1     : NVARCHAR(255), Nullable
* GalleryImage2     : NVARCHAR(255), Nullable
* GalleryImage3     : NVARCHAR(255), Nullable
* GalleryImage4     : NVARCHAR(255), Nullable
* ReviewQuote       : NVARCHAR(MAX), Nullable
* ReviewAuthor      : NVARCHAR(100), Nullable

TABLE: Users & Authentication
--------------------------------------------------------------------------------
* Id / UserID       : INT (Identity, Primary Key)
* FullName          : NVARCHAR(100)
* Email             : NVARCHAR(100), Unique
* PasswordHash      : NVARCHAR(256), Cryptographically Hashed
* PhoneNumber       : NVARCHAR(20)
* CreatedDate       : DATETIME

TABLE: AdminLogin
--------------------------------------------------------------------------------
* AdminID           : INT (Identity, Primary Key)
* Username          : NVARCHAR(50), Unique
* PasswordHash      : NVARCHAR(256), Cryptographically Hashed
* Role              : NVARCHAR(50)
* LastLogin         : DATETIME

================================================================================
6. SECURITY & DATA PROTECTION STANDARDS
================================================================================
* SQL Injection Prevention:
  All database interactions in C# code-behind files strictly utilize parameterized 
  `SqlCommand` parameters (`cmd.Parameters.AddWithValue` / `cmd.Parameters.Add`). 
  No dynamic string concatenation is allowed in queries.
* Password Protection:
  Credentials are never stored in plain text. Secure cryptographic hashing algorithms 
  are applied before insertion or verification.
* Session Hardening:
  Guest and Admin sessions are strictly segregated into isolated session keys 
  (`Session["UserEmail"]`, `Session["AdminUser"]`), preventing privilege escalation.
* Output Encoding:
  Dynamic database strings rendered into HTML are encoded using `HttpUtility.HtmlEncode` 
  to eliminate Cross-Site Scripting (XSS) risks.
* Credential Privacy:
  All production credentials, database passwords, and private connection strings are 
  kept confidential and protected inside configuration boundaries.

================================================================================
7. SETUP & DEPLOYMENT INSTRUCTIONS
================================================================================

1. SYSTEM REQUIREMENTS
   * OS: Windows 10 / 11 / Windows Server 2019+
   * IDE: Microsoft Visual Studio 2019 or Visual Studio 2022
   * Workload: "ASP.NET and web development"
   * Runtime: .NET Framework 4.8 / 4.8.1
   * Database: Microsoft SQL Server (LocalDB / Express / Enterprise)
   * Web Server: IIS 10+ or IIS Express (bundled with Visual Studio)

2. OPENING & CONFIGURING IN VISUAL STUDIO
   Step 1: Open Visual Studio.
   Step 2: Click "Open a project or solution" -> Select the folder:
           `Hotel-Management-Project-1`
   Step 3: Verify the database connection string in `Web.config`:
           <connectionStrings>
             <add name="HotelConnection" 
                  connectionString="Data Source=(LocalDB)\MSSQLLocalDB;Initial Catalog=HotelManagementDB;Integrated Security=True" 
                  providerName="System.Data.SqlClient" />
           </connectionStrings>
   Step 4: Ensure the SQL Server service is running.
   Step 5: Press `F5` or click the green "IIS Express" button on the toolbar.
   Step 6: The default browser will launch at:
           Public Portal : http://localhost:54858/index.aspx
           Admin Portal  : http://localhost:54858/admin/Dashboard.aspx

================================================================================
8. TESTING & QUALITY ASSURANCE VERIFICATION
================================================================================
* C# Compilation Status       : Verified 100% clean build with 0 syntax or runtime errors.
* Dynamic DataBinding Test    : Verified ADO.NET SQL adapter filling and repeater binding.
* End-to-End Suite Publishing : Verified room creation via Admin, database storage, 
                                and client-side dynamic rendering on RoomDetails.aspx.
* Responsive Breakpoints      : 
  - Extra Large Screens       : 1400px+ (Full container grid, expanded gallery)
  - Desktops & Laptops        : 992px - 1200px (Side-by-side room specs & cards)
  - Tablets & iPads           : 768px - 991px (Adaptive flex columns, touch galleries)
  - Mobile Phones             : 320px - 767px (Single-column stacked responsive layout)
* Browser Support             : Fully tested on Google Chrome, Mozilla Firefox, 
                                Microsoft Edge, Apple Safari, and Opera.

================================================================================
                    (c) The Royal Palace Hotel & Resort
          Enterprise Hospitality System - All Rights Reserved
================================================================================
