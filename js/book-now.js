/**
 * BookNow.aspx - Taj Hotels Room Rates & Packages Booking Engine
 * Dynamic Rate Plans, Taxes Toggle, Uncheck Support & Sticky Sidebar
 */

var bookingState = {
    selectedRoomId: '',
    selectedRoomName: '',
    selectedPlanName: '',
    baseRate: 0,
    checkIn: '',
    checkOut: '',
    adults: '2',
    children: '0',
    rooms: '1',
    nights: 1,
    showWithTaxes: false
};

// Date formatter helper: e.g. "2026-09-20" -> "20 Sep"
function formatDisplayDate(dateStr) {
    if (!dateStr) return '';
    var parts = dateStr.split('-');
    if (parts.length !== 3) return dateStr;
    var d = parseInt(parts[2], 10);
    var mIndex = parseInt(parts[1], 10) - 1;
    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return d + ' ' + (months[mIndex] || parts[1]);
}

/**
 * Handle Room Rate Plan Selection & Uncheck Toggle
 * @param {HTMLElement} btn - The clicked SELECT button
 */
function handleRateSelectToggle(btn) {
    if (!btn) return;

    // IF ALREADY ACTIVE -> UNCHECK / DESELECT IT!
    if (btn.classList.contains('active')) {
        uncheckSelectedRatePlan();
        return;
    }

    // De-activate all other SELECT buttons
    var allSelectButtons = document.querySelectorAll('.btn-taj-select');
    allSelectButtons.forEach(function (b) {
        b.classList.remove('active');
        b.innerHTML = 'SELECT';
    });

    // Remove active highlight from all rate plan boxes
    var allPlanBoxes = document.querySelectorAll('.taj-rate-plan-box');
    allPlanBoxes.forEach(function (box) {
        box.classList.remove('active-plan');
    });

    // Activate the clicked button
    btn.classList.add('active');
    btn.innerHTML = '<i class="bi bi-check2 me-1"></i> SELECTED';

    // Highlight the enclosing rate plan card
    var parentPlanBox = btn.closest('.taj-rate-plan-box');
    if (parentPlanBox) {
        parentPlanBox.classList.add('active-plan');
    }

    // Update state
    bookingState.selectedRoomId = btn.getAttribute('data-room-id') || '';
    bookingState.selectedRoomName = btn.getAttribute('data-room-name') || '';
    bookingState.selectedPlanName = btn.getAttribute('data-plan-name') || '';
    bookingState.baseRate = parseInt(btn.getAttribute('data-price')) || 0;

    // Recalculate and update YOUR STAY sidebar
    updateYourStaySidebar();
}

/**
 * Explicitly Uncheck & Clear Selected Room Rate
 */
function uncheckSelectedRatePlan() {
    var allSelectButtons = document.querySelectorAll('.btn-taj-select');
    allSelectButtons.forEach(function (b) {
        b.classList.remove('active');
        b.innerHTML = 'SELECT';
    });

    var allPlanBoxes = document.querySelectorAll('.taj-rate-plan-box');
    allPlanBoxes.forEach(function (box) {
        box.classList.remove('active-plan');
    });

    bookingState.selectedRoomId = '';
    bookingState.selectedRoomName = '';
    bookingState.selectedPlanName = '';
    bookingState.baseRate = 0;

    updateYourStaySidebar();
}

/**
 * Toggle Tax & Fee Inclusive View
 * @param {boolean} isChecked - Checked state of checkbox
 */
function toggleTaxesDisplay(isChecked) {
    bookingState.showWithTaxes = isChecked;

    var priceElements = document.querySelectorAll('.taj-tier-price[data-base-price]');
    priceElements.forEach(function (el) {
        var base = parseInt(el.getAttribute('data-base-price')) || 0;
        if (isChecked) {
            var inclTax = Math.round(base * 1.18);
            el.innerHTML = '&#8377; ' + inclTax.toLocaleString() + ' <small>/ Night <span class="tax-tag">(incl. taxes)</span></small>';
        } else {
            el.innerHTML = '&#8377; ' + base.toLocaleString() + ' <small>/ Night</small>';
        }
    });

    updateYourStaySidebar();
}

/**
 * Handle Schedule (Check-in, Check-out, Guests) Change
 */
function handleScheduleChange() {
    var arrInput = document.getElementById('arrivalDate');
    var depInput = document.getElementById('departureDate');
    var adultsSel = document.getElementById('bookingAdults');
    var childrenSel = document.getElementById('bookingChildren');
    var roomsSel = document.getElementById('totalRooms');

    if (arrInput && depInput && arrInput.value) {
        var fmt = function (d) { return d.toISOString().split("T")[0]; };
        var nxt = new Date(arrInput.value);
        nxt.setDate(nxt.getDate() + 1);
        depInput.min = fmt(nxt);
        if (depInput.value && new Date(depInput.value) <= new Date(arrInput.value)) {
            depInput.value = fmt(nxt);
        }
        bookingState.checkIn = arrInput.value;
        bookingState.checkOut = depInput.value;
    }

    if (adultsSel) bookingState.adults = adultsSel.value;
    if (childrenSel) bookingState.children = childrenSel.value;
    if (roomsSel) bookingState.rooms = roomsSel.value;

    // Update search context badge
    var searchContext = document.getElementById('searchContextSummary');
    if (searchContext) {
        var a = bookingState.adults;
        var r = bookingState.rooms;
        searchContext.textContent = 'Showing 6 available luxury rooms • ' + a + ' Adult' + (a > 1 ? 's' : '') + (r > 1 ? ' (' + r + ' Rooms)' : '');
    }

    updateYourStaySidebar();
}

/**
 * Update the Sticky "YOUR STAY" Sidebar Breakdown
 */
function updateYourStaySidebar() {
    var arrInput = document.getElementById('arrivalDate');
    var depInput = document.getElementById('departureDate');
    var hasDates = arrInput && depInput && arrInput.value && depInput.value;

    var nights = 1;
    if (hasDates) {
        var d1 = new Date(arrInput.value + 'T00:00:00');
        var d2 = new Date(depInput.value + 'T00:00:00');
        var diffTime = d2.getTime() - d1.getTime();
        var diffDays = Math.round(diffTime / (1000 * 60 * 60 * 24));
        nights = diffDays > 0 ? diffDays : 1;
    }
    bookingState.nights = nights;
    bookingState.checkIn = arrInput ? arrInput.value : '';
    bookingState.checkOut = depInput ? depInput.value : '';

    var roomsCount = parseInt(bookingState.rooms) || 1;
    var adultsCount = parseInt(bookingState.adults) || 2;

    // Update Room Label
    var roomLabel = document.getElementById('stayRoomLabel');
    if (roomLabel) {
        roomLabel.textContent = 'Room 1 : ' + adultsCount + ' Adult' + (adultsCount > 1 ? 's' : '');
    }

    var selectedRoomTitleEl = document.getElementById('staySelectedRoomTitle');
    var datesDurationEl = document.getElementById('stayDatesDuration');
    var basePriceEl = document.getElementById('stayBasePrice');
    var taxesPriceEl = document.getElementById('stayTaxesPrice');
    var totalPriceEl = document.getElementById('stayTotalPrice');
    var promptEl = document.getElementById('stayPromptNotSelected');
    var proceedBtn = document.getElementById('btnProceedBooking');
    var uncheckBtn = document.getElementById('btnUncheckRoomSidebar');

    // Case 1: UNSELECTED / UNCHECKED STATE
    if (!bookingState.selectedRoomName || bookingState.baseRate <= 0) {
        if (selectedRoomTitleEl) {
            selectedRoomTitleEl.className = 'text-muted small';
            selectedRoomTitleEl.textContent = 'Not selected';
        }
        if (datesDurationEl) datesDurationEl.classList.add('d-none');
        if (basePriceEl) basePriceEl.textContent = '₹ 0.00';
        if (taxesPriceEl) taxesPriceEl.textContent = '₹ 0.00';
        if (totalPriceEl) totalPriceEl.textContent = '₹ 0.00';

        if (promptEl) promptEl.classList.remove('d-none');
        if (proceedBtn) proceedBtn.classList.add('d-none');
        if (uncheckBtn) uncheckBtn.classList.add('d-none');
        return;
    }

    // Case 2: SELECTED STATE - DYNAMIC PRICING CALCULATION
    if (selectedRoomTitleEl) {
        selectedRoomTitleEl.className = 'text-dark small';
        selectedRoomTitleEl.innerHTML = '<strong class="d-block font-serif text-dark" style="font-size: 0.95rem;">' + bookingState.selectedRoomName + '</strong>' +
            '<span class="badge bg-gold-subtle text-warning-dark text-uppercase small mt-1" style="font-size: 0.72rem;">' + bookingState.selectedPlanName + '</span>';
    }

    if (datesDurationEl && hasDates) {
        datesDurationEl.classList.remove('d-none');
        datesDurationEl.innerHTML = '<i class="bi bi-calendar3 me-1 text-gold"></i> ' +
            formatDisplayDate(bookingState.checkIn) + ' – ' + formatDisplayDate(bookingState.checkOut) + ' (' + nights + ' Night' + (nights > 1 ? 's' : '') + ')';
    }

    var baseStay = bookingState.baseRate * nights * roomsCount;
    var taxes = Math.round(baseStay * 0.18);
    var grandTotal = baseStay + taxes;

    if (basePriceEl) basePriceEl.textContent = '₹ ' + baseStay.toLocaleString();
    if (taxesPriceEl) taxesPriceEl.textContent = '₹ ' + taxes.toLocaleString();
    if (totalPriceEl) totalPriceEl.textContent = '₹ ' + grandTotal.toLocaleString();

    if (promptEl) promptEl.classList.add('d-none');
    if (proceedBtn) proceedBtn.classList.remove('d-none');
    if (uncheckBtn) uncheckBtn.classList.remove('d-none');
}

/**
 * Filter Room Cards by Category Pill
 * @param {string} category - 'all', 'superior-twin', 'superior-king', etc.
 * @param {HTMLElement} btn - Clicked pill button
 */
function filterRoomCards(category, btn) {
    var pills = document.querySelectorAll('.taj-filter-pill');
    pills.forEach(function (p) { p.classList.remove('active'); });
    if (btn) btn.classList.add('active');

    var cards = document.querySelectorAll('.taj-room-card');
    cards.forEach(function (card) {
        var cardCat = card.getAttribute('data-category');
        if (category === 'all' || cardCat === category) {
            card.classList.remove('d-none');
        } else {
            card.classList.add('d-none');
        }
    });

    // If specific room selected, smooth scroll to it
    if (category !== 'all') {
        var targetCard = document.getElementById('room-' + category);
        if (targetCard) {
            targetCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }
}

/**
 * Switch Rates vs Offers Tabs
 */
function switchRatesView(tab) {
    var tabRates = document.getElementById('tabRoomRates');
    var tabOffers = document.getElementById('tabOffersPackages');
    if (tab === 'rates') {
        if (tabRates) tabRates.classList.add('active');
        if (tabOffers) tabOffers.classList.remove('active');
    } else {
        if (tabRates) tabRates.classList.remove('active');
        if (tabOffers) tabOffers.classList.add('active');
        alert('Displaying curated staycation and special package inclusions with exclusive privileges.');
    }
}

/**
 * Open Guest Details Modal
 */
function openGuestDetailsModal() {
    if (!bookingState.selectedRoomName || bookingState.baseRate <= 0) {
        alert('Please select a room rate above to proceed with your reservation.');
        return;
    }

    var modalRoomEl = document.getElementById('modalSelectedRoomSummary');
    var modalDatesEl = document.getElementById('modalDatesSummary');
    var modalTotalEl = document.getElementById('modalTotalSummary');

    var roomsCount = parseInt(bookingState.rooms) || 1;
    var baseStay = bookingState.baseRate * bookingState.nights * roomsCount;
    var taxes = Math.round(baseStay * 0.18);
    var grandTotal = baseStay + taxes;

    if (modalRoomEl) {
        modalRoomEl.textContent = bookingState.selectedRoomName + ' (' + bookingState.selectedPlanName + ')';
    }
    if (modalDatesEl) {
        modalDatesEl.textContent = 'Stay: ' + formatDisplayDate(bookingState.checkIn) + ' – ' + formatDisplayDate(bookingState.checkOut) + ' (' + bookingState.nights + ' Nights) • ' + bookingState.adults + ' Adults';
    }
    if (modalTotalEl) {
        modalTotalEl.textContent = '₹ ' + grandTotal.toLocaleString();
    }

    // Reset view: hide confirmation pass, show form
    var formEl = document.getElementById('tajGuestDetailsForm');
    var passEl = document.getElementById('tajConfirmationVoucherPass');
    if (formEl) formEl.classList.remove('d-none');
    if (passEl) passEl.classList.add('d-none');

    var modalEl = document.getElementById('guestDetailsModal');
    if (modalEl && typeof bootstrap !== 'undefined' && bootstrap.Modal) {
        var modalInstance = bootstrap.Modal.getInstance(modalEl) || new bootstrap.Modal(modalEl);
        modalInstance.show();
    }
}

/**
 * Handle Final Booking Form Submit
 * @param {Event} e - Submit event
 */
function handleTajReservationSubmit(e) {
    e.preventDefault();

    var nameInput = document.getElementById('modalGuestName');
    var emailInput = document.getElementById('modalGuestEmail');
    var phoneInput = document.getElementById('modalGuestPhone');
    var termsInput = document.getElementById('modalTermsCheckbox');

    if (!nameInput || !nameInput.value.trim() || !emailInput || !emailInput.value.trim() || !phoneInput || !phoneInput.value.trim()) {
        alert('Please fill in all required guest contact information.');
        return;
    }

    if (!termsInput || !termsInput.checked) {
        alert('Please review and accept the Terms & Conditions.');
        return;
    }

    var guestName = nameInput.value.trim();
    var refNumber = 'HM-RES-' + Math.floor(100000 + Math.random() * 900000);

    var roomsCount = parseInt(bookingState.rooms) || 1;
    var baseStay = bookingState.baseRate * bookingState.nights * roomsCount;
    var taxes = Math.round(baseStay * 0.18);
    var grandTotal = baseStay + taxes;

    // Populate Voucher Pass
    var vRef = document.getElementById('voucherConfRef');
    var vGuest = document.getElementById('voucherGuestName');
    var vRoom = document.getElementById('voucherRoomPlan');
    var vDates = document.getElementById('voucherDates');
    var vTotal = document.getElementById('voucherTotal');

    if (vRef) vRef.textContent = refNumber;
    if (vGuest) vGuest.textContent = guestName;
    if (vRoom) vRoom.textContent = bookingState.selectedRoomName + ' (' + bookingState.selectedPlanName + ')';
    if (vDates) vDates.textContent = formatDisplayDate(bookingState.checkIn) + ' – ' + formatDisplayDate(bookingState.checkOut) + ' (' + bookingState.nights + ' Nights)';
    if (vTotal) vTotal.textContent = '₹ ' + grandTotal.toLocaleString();

    // Hide form, reveal voucher
    var formEl = document.getElementById('tajGuestDetailsForm');
    var passEl = document.getElementById('tajConfirmationVoucherPass');
    if (formEl) formEl.classList.add('d-none');
    if (passEl) passEl.classList.remove('d-none');
}

/**
 * Open Policy & Information Modals
 */
function openPolicyModal(type) {
    var titleEl = document.getElementById('policyModalTitle');
    var bodyEl = document.getElementById('policyModalBody');

    if (!titleEl || !bodyEl) return;

    if (type === 'best-rate') {
        titleEl.textContent = 'Best Rate Guarantee';
        bodyEl.innerHTML = '<p class="small leading-relaxed text-muted mb-3">When you book direct on our official website, you are guaranteed the lowest public rate available online. If you find a lower qualified rate elsewhere within 24 hours of booking, we will match that rate and offer an additional 10% savings.</p><ul class="small text-muted ps-3 mb-0"><li>No hidden booking fees</li><li>Complimentary Wi-Fi across all suites</li><li>Direct access to concierge desk</li></ul>';
    } else if (type === 'breakfast-incl') {
        titleEl.textContent = 'Breakfast Inclusive Rate Policies';
        bodyEl.innerHTML = '<p class="small leading-relaxed text-muted mb-2"><strong>Rate Inclusions:</strong></p><ul class="small text-muted ps-3 mb-3"><li>Gourmet multi-cuisine breakfast buffet for all registered guests.</li><li>Access to recreation lounge, pool table, and fitness studio.</li><li>Complimentary valet parking & high-speed Wi-Fi.</li></ul><p class="small text-muted mb-0"><strong>Cancellation:</strong> Free cancellation up to 48 hours before check-in date.</p>';
    } else if (type === 'member-rate') {
        titleEl.textContent = 'Taj Member Exclusive Rate';
        bodyEl.innerHTML = '<p class="small leading-relaxed text-muted mb-3">Enjoy an exclusive 15% discount on all room suites when you log in with your Taj / NeuPass membership account.</p><div class="p-3 bg-light rounded-3 text-center mb-3"><a href="Login.aspx" class="btn btn-navbar-theme btn-sm px-4 fw-bold text-uppercase">Log In To Account</a><div class="mt-2"><small class="text-muted">Not a member? <a href="Register.aspx" class="text-gold fw-bold">Join For Free</a></small></div></div>';
    } else {
        titleEl.textContent = 'Terms & Cancellation Policy';
        bodyEl.innerHTML = '<ul class="small text-muted ps-3 mb-0"><li><strong>Check-in:</strong> 2:00 PM | <strong>Check-out:</strong> 12:00 PM</li><li><strong>Cancellation:</strong> 48 hours prior to arrival for full refund.</li><li><strong>Identification:</strong> Govt photo ID mandatory for all staying guests.</li></ul>';
    }

    var modalEl = document.getElementById('tajPolicyInfoModal');
    if (modalEl && typeof bootstrap !== 'undefined' && bootstrap.Modal) {
        var modalInstance = bootstrap.Modal.getInstance(modalEl) || new bootstrap.Modal(modalEl);
        modalInstance.show();
    }
}

/**
 * Initialize on DOMContentLoaded
 */
document.addEventListener('DOMContentLoaded', function () {
    var today = new Date();
    var tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    var fmt = function (d) { return d.toISOString().split("T")[0]; };

    var arrInput = document.getElementById('arrivalDate');
    var depInput = document.getElementById('departureDate');

    if (arrInput && depInput) {
        arrInput.min = fmt(today);
        depInput.min = fmt(tomorrow);

        var urlParams = new URLSearchParams(window.location.search);
        var checkInParam = urlParams.get('checkIn');
        var checkOutParam = urlParams.get('checkOut');
        var roomParam = urlParams.get('room') || urlParams.get('title');

        arrInput.value = checkInParam || fmt(today);
        depInput.value = checkOutParam || fmt(tomorrow);

        bookingState.checkIn = arrInput.value;
        bookingState.checkOut = depInput.value;

        // If specific room passed in URL, auto-scroll and select its first standard rate
        if (roomParam) {
            var rLower = roomParam.toLowerCase();
            var allSelectButtons = document.querySelectorAll('.btn-taj-select');
            for (var i = 0; i < allSelectButtons.length; i++) {
                var btnRoom = (allSelectButtons[i].getAttribute('data-room-name') || '').toLowerCase();
                if (btnRoom.indexOf(rLower) !== -1 || rLower.indexOf(btnRoom) !== -1) {
                    handleRateSelectToggle(allSelectButtons[i]);
                    break;
                }
            }
        }
    }

    updateYourStaySidebar();
});
