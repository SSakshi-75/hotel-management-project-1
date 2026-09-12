# Product Requirement Document (PRD)
## Feature Gap Analysis & Transformation Roadmap: Taj Hotels Benchmark

---

## 1. Executive Summary & Objective

### 1.1 Objective
The purpose of this Product Requirement Document (PRD) is to conduct an in-depth frontend feature benchmark between **Taj Hotels (IHCL - www.tajhotels.com)** and the existing **Hotel Management Web Application**, identify all missing high-value frontend features and UX patterns, and provide detailed functional, technical, and UI/UX specifications for integrating these capabilities.

> **Strict Directive Followed**: As instructed, **zero code modifications** have been performed on the existing codebase (`.aspx`, `.cs`, `.css`, `.js` files remain completely untouched). This document acts as the definitive architectural blueprint and functional specification for future engineering phases.

---

## 2. Current State vs. Taj Hotels Comparative Matrix

| Feature Area | Existing Hotel Management Website | Taj Hotels Official Website (tajhotels.com) | Status in Existing Site | Priority |
| :--- | :--- | :--- | :--- | :--- |
| **Property Scope** | Single property (Chanakyapuri, New Delhi) | Global Multi-property & Multi-brand portfolio (Palaces, Safaris, Resorts, City Hotels) | ❌ Missing multi-property/destination search | **High (P0)** |
| **Booking Widget** | Static homepage card & separate single-room form | Floating/Sticky omnipresent search bar with live destination autocomplete & recent searches | ❌ Missing sticky autocomplete & recent searches | **High (P0)** |
| **Multi-Room & Guest Configuration** | Dropdown with total guests & rooms count | Granular multi-room builder (Room 1, 2, 3...) with independent adult/child count + child ages | ❌ Missing granular multi-room/child age builder | **High (P0)** |
| **Special Rates & Corporate Codes** | None | Promo code, Corporate rate code, Travel Agent (IATA), Government rate, Tata Employee rate | ❌ Missing special rates & coupon system | **High (P0)** |
| **Rate Plans & Meal Inclusions** | Single fixed price per room (e.g. ₹8,500/night) | Multi-tier rate plans: Room Only, Bed & Breakfast, Half/Full Board, Member Exclusive, Package Deals | ❌ Missing dynamic rate plans & inclusions | **High (P0)** |
| **Loyalty Program** | Basic dummy Login/Register form ("Coming soon") | Integrated NeuPass loyalty portal: NeuCoins wallet, tier tracking, member-only rates, points redemption | ❌ Missing loyalty rewards & points redemption | **High (P0)** |
| **Currency & Language Localization** | Hardcoded INR (₹) and English only | Live multi-currency selector (INR, USD, EUR, GBP, AED, SGD) & multi-lingual language switcher | ❌ Missing currency & language switchers | **Medium (P1)** |
| **Dining & Table Reservations** | Static amenities description | Dedicated Dining directory, restaurant showcase, chef profiles, and live table booking engine | ❌ Missing table reservation engine | **High (P0)** |
| **Spa & Wellness Booking** | Static amenity card | Jiva Spa treatment catalog, wellness packages, and spa appointment booking engine | ❌ Missing spa appointment booking | **Medium (P1)** |
| **Weddings & Banquets (MICE)** | Static text mention | Event venue finder with guest capacity filters, floor plans, and interactive RFP (Request For Proposal) | ❌ Missing interactive RFP & venue finder | **High (P1)** |
| **Gift Cards (Taj Experiences)** | None | Taj Experience Gift Cards purchasing (Digital/Physical), custom themes, balance check widget | ❌ Missing gift card purchasing & balance check | **Medium (P2)** |
| **Interactive Map & Search Results (SERP)** | Static room grid | Map view toggle with price pin markers, faceted filters (Price slider, Brand, Amenities, View), sorting | ❌ Missing map view & faceted search filters | **High (P0)** |
| **Media & Virtual Tours** | Static images + lightbox marquee | 360-degree Virtual 3D Tours, video hero banners, interactive floor plans, downloadable brochures | ❌ Missing 360° virtual tours & floor plans | **Medium (P1)** |
| **Checkout & Payment Gateway** | Static 2-step form with alert submission | Multi-channel checkout pipeline: UPI (GPay/PhonePe), Credit/Debit, Net Banking, EMI, NeuCoins, Pay at Hotel | ❌ Missing live payment gateway & NeuCoins | **High (P0)** |
| **Post-Booking & Self-Service** | None | Guest portal: Modify/Cancel booking, live cancellation fee calculation, download GST tax invoice, Apple/Google Wallet | ❌ Missing booking modification & cancellation portal | **High (P0)** |
| **Concierge & Direct Communication** | Static phone & email links | 24/7 AI Concierge chat, WhatsApp Concierge click-to-chat, Paathya ESG & sustainability showcase | ❌ Missing AI/WhatsApp live chat concierge | **Medium (P1)** |

---

## 3. Detailed PRD Modules for Missing Features

```
          ┌─────────────────────────────────────────────────────────────┐
          │               TAJ HOTELS BENCHMARK ARCHITECTURE             │
          └──────────────────────────────┬──────────────────────────────┘
                                         │
    ┌────────────────────┬───────────────┴───────────────┬────────────────────┐
    ▼                    ▼                               ▼                    ▼
┌────────────────┐ ┌───────────────────────────┐ ┌────────────────┐ ┌─────────────────┐
│ 1. Omnipresent │ │ 2. Dynamic Rate Plans     │ │ 3. NeuPass     │ │ 4. Dining, Spa  │
│    Sticky Bar  │ │    & Inclusions Engine    │ │    Loyalty Hub │ │    & MICE RFP   │
│ - Autocomplete │ │ - Room Only vs B&B vs VIP │ │ - Member rates │ │ - Table Booking │
│ - Multi-Room   │ │ - Add-ons & Upsell Deals  │ │ - NeuCoins     │ │ - Spa Scheduling│
│ - Promo/Corp   │ │ - Free Cancel vs Advance  │ │ - Tier status  │ │ - Banquet RFP   │
└────────────────┘ └───────────────────────────┘ └────────────────┘ └─────────────────┘
    │                    │                               │                    │
    └────────────────────┼───────────────────────────────┼────────────────────┘
                         ▼                               ▼
          ┌─────────────────────────────┐ ┌─────────────────────────────┐
          │ 5. Map & Faceted Search SERP│ │ 6. Guest Self-Service &     │
          │ - Price Pins & Interactive  │ │    Multi-Channel Checkout   │
          │ - 360° Virtual Tours        │ │ - UPI / Cards / Gift Cards  │
          │ - Currency & Language Switch│ │ - Modify / Cancel / Invoice │
          └─────────────────────────────┘ └─────────────────────────────┘
```

---

### Module 1: Omnipresent Sticky Booking Engine & Granular Multi-Room Selector

#### 1.1 Business Rationale
On Taj Hotels, visitors can initiate or adjust their reservation from any scroll position or page. Furthermore, luxury travelers frequently book for families or entourages across multiple rooms with distinct guest compositions.

#### 1.2 Functional Specifications
1. **Sticky Floating Booking Bar**:
   - Floats anchored to the bottom on mobile screens and top-sticky on desktop when scrolling past the hero.
   - Smooth animation collapse to a compact summary pill when scrolling down, expanding on click or hover.
2. **Destination / Hotel Search with Live Autocomplete**:
   - Type-ahead search matching:
     - Destination City (e.g., *New Delhi, Mumbai, Udaipur, London*)
     - Region / Category (e.g., *Rajasthan Palaces, Goa Beach Resorts*)
     - Property Name (e.g., *Taj Mahal Palace, Taj Lake Palace*)
   - Shows "Recent Searches" and "Popular Luxury Destinations" when the input field receives focus.
3. **Dual-Month Range Calendar Picker**:
   - Side-by-side dual month interactive calendar.
   - Displays minimum-night-stay requirements and sold-out dates in real-time.
   - Quick date preset pills: "This Weekend", "Next Weekend", "Next 7 Days".
4. **Granular Multi-Room & Guest Builder**:
   - Users can configure up to 5 distinct rooms in a single checkout session.
   - Per Room Config:
     - Adult counter (1 to 4 adults).
     - Child counter (0 to 3 children).
     - If children > 0, dynamic age dropdowns appear for each child (e.g., Child 1 Age: 4 yrs; Child 2 Age: 9 yrs) to calculate extra-bed and meal surcharges.
5. **Special Rates / Promotional Codes Dropdown**:
   - Radio / Select option for rate categories:
     - **Standard Rate** (Default)
     - **Promotional / Coupon Code** (Input text field)
     - **Corporate / Negotiated Code** (For enterprise travelers)
     - **Travel Agent (IATA / TIDS)** (For travel agencies)
     - **Employee / Tata Group Special Rate**

---

### Module 2: Dynamic Rate Plans, Package Inclusions & Upselling Engine

#### 2.1 Business Rationale
Taj Hotels never sells a room as a single flat price. Each suite offers tiered rate plans tailored to guest willingness-to-pay (Room Only vs. Bed & Breakfast vs. Luxury Experiential Packages) and flexible cancellation terms.

#### 2.2 Functional Specifications
1. **Multi-Tier Rate Plan Selection per Room**:
   For every room category (e.g. *Executive Suite*), display a selection of rate tiers:
   - **Plan A: Room Only** (Base lowest price, no meals).
   - **Plan B: Bed & Breakfast** (Includes buffet breakfast at the signature restaurant).
   - **Plan C: Taj Experience Package** (Includes breakfast, 2-way airport luxury sedan transfer, ₹2,500 Spa credit per day, and late check-out till 4:00 PM).
   - **Plan D: NeuPass Member Exclusive Rate** (Additional 5-10% discount + NeuCoins earning).
2. **Cancellation Policy Tags**:
   - **Free Cancellation**: "Cancel before 2:00 PM 48 hours prior to check-in for 100% refund."
   - **Non-Refundable / Advance Saver**: 15% lower rate with "Non-refundable once confirmed" warning badge.
3. **"Rate Inclusions" Comparative Modal**:
   - Clickable "View Inclusions" link triggering a modal comparing what is covered under each rate tier with clear checkmarks and cross icons.
4. **Add-on Services / Upselling Step**:
   Before finalizing checkout, offer interactive one-click add-ons:
   - Luxury Airport Transfer (Mercedes E-Class / BMW 7-Series) [+₹3,500].
   - Jiva Signature Couple Spa Session [+₹7,000].
   - Candlelight Private Cabana Dinner [+₹5,500].
   - Celebration Hamper (Champagne, artisanal chocolates, fresh floral arrangement) [+₹4,000].

---

### Module 3: NeuPass / Taj InnerCircle Loyalty Program

#### 3.1 Business Rationale
The NeuPass loyalty ecosystem (Tata Neu & IHCL) is the core driver of repeat direct bookings on Taj Hotels, rewarding guests with points (**NeuCoins**) where 1 NeuCoin = ₹1.

#### 3.2 Functional Specifications
1. **Loyalty Header & Navigation Integration**:
   - Dedicated "NeuPass" item in primary navbar.
   - Login button with option to log in via Mobile OTP or Password.
2. **Loyalty Tiers Display & Status Bar**:
   - Visual tier comparison widget:
     - **Copper**: 4% NeuCoins earning, standard member rates.
     - **Bronze**: 5% NeuCoins, priority check-in.
     - **Silver**: 6% NeuCoins, complimentary room upgrade (subject to availability).
     - **Gold**: 7% NeuCoins, early check-in (9 AM), late check-out (6 PM).
     - **Platinum**: 8% NeuCoins, 24/7 dedicated personal concierge, suite upgrade vouchers.
3. **NeuCoins Calculation & Live Display**:
   - On every room card and rate plan, show: *"Earn **680 NeuCoins** on this stay"*.
   - During checkout: Real-time slider allowing members to redeem existing NeuCoins directly to deduct from the invoice balance.

---

### Module 4: Multi-Currency & Multi-Lingual Localization

#### 4.1 Functional Specifications
1. **Live Currency Switcher**:
   - Header dropdown supporting key currencies:
     - **INR (₹)** - Indian Rupee (Default)
     - **USD ($)** - United States Dollar
     - **EUR (€)** - Euro
     - **GBP (£)** - British Pound
     - **AED (د.إ)** - UAE Dirham
     - **SGD (S$)** - Singapore Dollar
   - Instant frontend recalculation of all room prices, taxes, and service fees based on live exchange rates without requiring a full page refresh.
2. **Multi-Language Selector**:
   - Switcher for International and Domestic guests:
     - English (Global)
     - Hindi (हिन्दी)
     - French (Français)
     - German (Deutsch)
     - Japanese (日本語)

---

### Module 5: Interactive Search Results Page (SERP) & Map View

#### 5.1 Functional Specifications
1. **List View vs. Map View Toggle**:
   - Toggle switch in search header: `[ List View | Map View ]`.
   - **Map View Mode**:
     - Split screen: Left side shows hotel cards, Right side displays interactive map.
     - Map markers display the starting price (e.g. ₹18,500) directly on the pin.
     - Clicking a pin highlights the corresponding property card and opens an info window with thumbnail, rating, and "Book Now" CTA.
2. **Faceted Filtering Panel**:
   - **Price Range**: Dual-thumb interactive slider (e.g., ₹5,000 to ₹1,50,000+).
   - **Property Brand / Collection**: Palaces, Beach Resorts, Wildlife Safaris, City Hotels.
   - **Amenities**: Rooftop Pool, Jiva Spa, Pet Friendly, Fitness Center, Butler Service, Ocean Facing.
   - **Meal Plans Included**: Breakfast Included, All Meals Included.
3. **Sorting Options**:
   - Dropdown with: "Recommended (Taj Choice)", "Price: Low to High", "Price: High to Low", "Guest Rating", "Distance from City Center".

---

### Module 6: Dining Showcase & Table Reservation Engine

#### 6.1 Business Rationale
Dining is a primary revenue pillar for luxury hotels. Taj Hotels allows guests (residents and non-residents) to explore signature restaurants, browse menus, and reserve dining tables online.

#### 6.2 Functional Specifications
1. **Restaurant Catalog Showcase**:
   - Dedicated `/Dining` section with multi-restaurant cards (e.g., *Varq - Contemporary Indian*, *Orient Express - European Fine Dining*, *Machan - All-Day Dining*).
   - Details per restaurant: Cuisine type, Master Chef profile, dress code, operating hours, seating capacity.
2. **Online Table Reservation Widget**:
   - Modal or standalone widget:
     - Select Date & Meal Period (Breakfast, Lunch, High Tea, Dinner).
     - Select Time Slot (e.g., 7:30 PM, 8:00 PM, 8:30 PM).
     - Number of Guests (Adults, Children).
     - Seating Preference (Indoor, Alfresco, Window View, Private Dining Room).
     - Special Occasion (Birthday, Anniversary, Business Meeting).
     - Dietary Restrictions & Allergies notes.
3. **Interactive Digital Menus**:
   - Tabs for À la carte, Degustation/Tasting menu, Beverage & Wine list.
   - Dietary badges: Vegetarian (🟢), Non-Vegetarian (🔴), Vegan (🌱), Gluten-Free (🌾).

---

### Module 7: Jiva Spa & Wellness Appointment Module

#### 7.1 Functional Specifications
1. **Treatment Catalog**:
   - Categorized spa offerings: Signature Indian Aromatherapies, Ayurvedic Shirodhara, Body Scrubs & Wraps, Beauty Treatments.
   - Duration selector: 60 mins, 90 mins, 120 mins with transparent pricing.
2. **Online Spa Appointment Booking**:
   - Select therapist preference (Male, Female, No preference).
   - Date & time slot picker.
   - Pre-treatment health questionnaire (High blood pressure, allergies, pregnancy).
   - Confirmation voucher sent via SMS and Email.

---

### Module 8: Weddings, Banquets & MICE (Request for Proposal - RFP)

#### 8.1 Functional Specifications
1. **Venue Directory & Capacity Matrix**:
   - Showcase of Grand Ballrooms, Royal Lawns, and Boardrooms.
   - Filter venues by:
     - Guest Count (e.g. 50, 100-300, 500-1500+ guests).
     - Seating Layout (Theater, Classroom, Cluster, Banquet, U-Shape).
   - Downloadable floor plans (PDF) and technical specifications (AV equipment, lighting, stage dimensions).
2. **Interactive Multi-Step RFP Form (Request For Proposal)**:
   - **Step 1: Event Scope**: Event type (Royal Wedding, Corporate Conference, Product Launch, Social Gala), expected dates, attendee count.
   - **Step 2: Room Requirements**: Number of guest rooms required for wedding attendees.
   - **Step 3: Food & Beverage**: Buffet, plated course dinner, cocktail reception, live counters.
   - **Step 4: Contact & Organization**: Organizer details, corporate entity, budget range.
   - **Output**: Generates a unique RFP Tracking Number and routes inquiry to the Banquet Sales Team.

---

### Module 9: Taj Experience Gift Cards & Balance Checker

#### 9.1 Functional Specifications
1. **Gift Card Purchase Flow**:
   - Card Format: E-Gift Card (Instant email delivery) vs. Physical Luxury Gift Card (Delivered in embossed golden box).
   - Card Themes: Weddings & Anniversaries, Festive (Diwali, New Year), Corporate Gifting, Luxury Staycation.
   - Denomination: Quick presets (₹5,000, ₹10,000, ₹25,000, ₹50,000) or Custom Amount input.
   - Personalization: Recipient name, custom greeting message, scheduled delivery date.
2. **Online Balance Check Widget**:
   - Enter 16-digit Gift Card number and 6-digit Security PIN.
   - Displays real-time available balance, expiry date, and recent transaction history.

---

### Module 10: Rich Media, 360° Virtual Tours & Interactive Floor Plans

#### 10.1 Functional Specifications
1. **Hero Cinematic Video**:
   - Full-width, low-latency streaming background video with pause/play toggle and fallback image for low bandwidth.
2. **360° Virtual Room & Palace Walkthrough**:
   - Integrated WebGL / Pannellum 360° viewer inside the Room Details page.
   - Hotspots to navigate between bedroom, bathroom, private balcony, and living salon.
3. **Interactive Floor Plans**:
   - Vector architectural floor layout for top-tier suites (Presidential Suite, Penthouse) showing room dimensions, terrace orientation, and bathroom placement.

---

### Module 11: End-to-End Multi-Channel Checkout Pipeline

#### 11.1 Functional Specifications
1. **Step-by-Step Checkout Wizard**:
   - **Step 1: Room & Rate Confirmation**: Price breakdown including base fare, GST (18%), and luxury cess.
   - **Step 2: Guest Details & Corporate GST**:
     - Lead guest contact information.
     - "I am booking for someone else" checkbox.
     - "Enter GST Details for Business Tax Credit" (GSTIN, Company Name, Registered Address) with automatic GST format validation.
   - **Step 3: Upsells & Special Requests**: Arrival time, high-floor request, quiet room, baby crib.
   - **Step 4: Loyalty & Coupon Redemption**: NeuCoins redemption slider + Promo code box.
   - **Step 5: Payment Gateway Integration**:
     - Instant UPI payment (Google Pay, PhonePe, Paytm, BHIM QR code).
     - Credit / Debit Cards (Visa, Mastercard, Amex, Diners, RuPay) with 3D Secure OTP.
     - Net Banking (All major Indian banks).
     - Taj Gift Card / NeuCoins split payment.
     - Pay At Hotel option (guaranteed with credit card hold).
2. **Instant Confirmation Screen & Deliverables**:
   - Downloadable PDF Booking Voucher with QR code for express kiosk check-in.
   - "Add to Apple Wallet" and "Add to Google Wallet" buttons.
   - "Add to Calendar" (.ics file).
   - Automated WhatsApp confirmation with directions and reservation summary.

---

### Module 12: Guest Self-Service Portal (Manage Reservation)

#### 12.1 Functional Specifications
1. **Find & Access Booking**:
   - Lookup reservation without login via **Booking Reference Number (PNR)** + **Last Name / Email**.
2. **Self-Service Actions**:
   - **Modify Dates**: Check date availability difference and calculate fare adjustment.
   - **Upgrade Room**: View available suite upgrades and upgrade fare.
   - **Cancel Reservation**:
     - Real-time display of applicable cancellation fees based on current timestamp and hotel cancellation policy.
     - One-click confirmation with refund breakdown and estimated credit timeline (3-5 business days).
   - **Download Invoice**: Download official GST-compliant tax invoice.
3. **Guest Preference Center**:
   - Save dietary preferences (Jain, Halal, Vegan, Kosher).
   - Save room preferences (King Bed, Feather Pillow, Away from Elevator, High Floor).

---

### Module 13: 24/7 AI Concierge & WhatsApp Concierge Integration

#### 13.1 Functional Specifications
1. **Floating AI Hospitality Assistant**:
   - Bottom-right floating gold badge: "Taj Virtual Concierge".
   - Capable of answering FAQs: Check-in times, airport distance, dress codes, pet policy, breakfast timings.
   - Guided booking assistance: Helps guests find the ideal suite based on party size and budget.
2. **One-Click WhatsApp Concierge**:
   - Direct button to chat with front desk / reservation desk on WhatsApp for instant assistance with pre-filled message: *"Hello Taj Concierge, I would like assistance regarding my stay."*

---

### Module 14: Sustainability (Paathya) & Cultural Heritage Showcase

#### 14.1 Functional Specifications
1. **Paathya ESG Framework Showcase**:
   - Showcase of eco-friendly commitments: Zero single-use plastic, solar-powered facilities, water conservation, local heritage preservation.
2. **Heritage & History Interactive Timeline**:
   - Interactive horizontal scroll timeline depicting the history and royal lineage of the property.

---

## 4. Implementation Roadmap & Phasing

```
┌───────────────────────────────────────────────────────────────────────────┐
│ PHASE 1: CORE COMMERCIAL ENGINE (Weeks 1 - 4)                            │
│ 1. Sticky Floating Booking Bar with Dual-Month Calendar                   │
│ 2. Granular Multi-Room & Child-Age Selector                               │
│ 3. Multi-tier Dynamic Rate Plans per Room (Room Only vs B&B vs Inclusions)│
│ 4. Promotional & Corporate Code Input Engine                              │
│ 5. Multi-Currency Display Switcher (INR, USD, EUR, GBP, AED)              │
└─────────────────────────────────────┬─────────────────────────────────────┘
                                      │
┌─────────────────────────────────────▼─────────────────────────────────────┐
│ PHASE 2: EXPERIENCES, LOCALIZATION & BOOKING PORTAL (Weeks 5 - 8)         │
│ 1. Online Table Reservation Engine for Fine Dining                        │
│ 2. Weddings & MICE Request for Proposal (RFP) Interactive Form            │
│ 3. Jiva Spa Treatment Booking Module                                      │
│ 4. Search Results Page (SERP) with Faceted Filters & Price Map View       │
│ 5. Guest Self-Service (Modify Booking, Cancel Reservation, GST Invoice)   │
└─────────────────────────────────────┬─────────────────────────────────────┘
                                      │
┌─────────────────────────────────────▼─────────────────────────────────────┐
│ PHASE 3: ENTERPRISE LOYALTY & IMMERSIVE TECH (Weeks 9 - 12)               │
│ 1. NeuPass Loyalty Integration & NeuCoins Earning/Redemption Slider       │
│ 2. 360° Virtual Room Tours & 3D Interactive Floor Plans                   │
│ 3. Taj Experience Gift Cards (Buy e-Cards & PIN Balance Checker)          │
│ 4. 24/7 AI Concierge & WhatsApp Direct Hospitality Chat                   │
│ 5. Multi-Lingual Localization (English, Hindi, French, German)            │
└───────────────────────────────────────────────────────────────────────────┘
```

---

## 5. Sign-off & Next Steps

This document provides a 100% comprehensive, production-grade Product Requirement Document mapping all missing frontend capabilities from **Taj Hotels** to the **Hotel Management Project**.

> **Note**: Per your explicit instruction, **no source code has been altered**. When you decide to start coding, we can follow this exact roadmap step by step.
