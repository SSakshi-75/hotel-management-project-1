/* ==========================================
   BOOKING PAGE JAVASCRIPT LOGIC
   6-Step Luxury Stay Reservation & Checkout Engine
   ========================================== */

var currentAppliedOffer = null;

// Initial state starts clean without fake/default room or dates
var bookingState = {
    room: '',
    ratePerNight: 0,
    nights: 0,
    checkIn: '',
    checkOut: '',
    adults: '2',
    children: '0',
    rooms: '1',
    currency: 'INR',
    currencySymbol: '₹'
};

var currencySymbols = {
    INR: '₹',
    USD: '$',
    EUR: '€',
    GBP: '£',
    AED: 'AED '
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

// Guests formatter helper: e.g. "2 Adults", "2 Adults, 1 Child", "2 Adults (2 Rooms)"
function formatGuestsText(adults, children, rooms) {
    var a = parseInt(adults) || 1;
    var c = parseInt(children) || 0;
    var r = parseInt(rooms) || 1;
    var txt = a + (a === 1 ? ' Adult' : ' Adults');
    if (c > 0) {
        txt += ', ' + c + (c === 1 ? ' Child' : ' Children');
    }
    if (r > 1) {
        txt += ' (' + r + ' Rooms)';
    }
    return txt;
}

// Step 2 Room Picker Handler (With Direct Uncheck / Toggle Support)
function selectBookingRoomCard(title, price, el) {
    var wasActive = el && el.classList.contains('active');

    // Remove active class from all cards
    var cards = document.querySelectorAll('.booking-room-pick-card');
    cards.forEach(function (c) {
        c.classList.remove('active');
    });

    // IF ALREADY ACTIVE -> USER CLICKED TO UNCHECK / DESELECT
    if (wasActive) {
        currentAppliedOffer = null;
        bookingState.room = '';
        bookingState.ratePerNight = 0;

        // Reset hidden select
        var select = document.getElementById('bookingRoomSelect');
        if (select) {
            select.selectedIndex = 0;
        }

        // Hide promotional offer banner if active
        var banner = document.getElementById('bookingOfferAppliedBanner');
        if (banner) {
            banner.classList.add('d-none');
        }

        updateBookingSummary();
        return;
    }

    // IF NOT ACTIVE -> SELECT THIS CARD
    if (el) {
        el.classList.add('active');
    }

    currentAppliedOffer = null;
    bookingState.room = title;
    bookingState.ratePerNight = parseInt(price) || 0;

    // Keep hidden select in sync
    var select = document.getElementById('bookingRoomSelect');
    if (select) {
        for (var i = 0; i < select.options.length; i++) {
            if (select.options[i].text.indexOf(title) !== -1 || select.options[i].value == price) {
                select.selectedIndex = i;
                break;
            }
        }
    }

    updateBookingSummary();
}

// Update Step 4 Booking Summary with REAL selected data only
function updateBookingSummary() {
    var arrInput = document.getElementById('arrivalDate');
    var depInput = document.getElementById('departureDate');
    var emptyStateEl = document.getElementById('bookingSummaryEmptyState');
    var tableBoxEl = document.getElementById('bookingSummaryTableBox');

    var hasDates = arrInput && depInput && arrInput.value && depInput.value;
    var hasRoom = bookingState.room && bookingState.ratePerNight > 0;

    // If user has not selected stay details AND room, show placeholder message
    if (!hasDates || !hasRoom) {
        if (emptyStateEl) emptyStateEl.classList.remove('d-none');
        if (tableBoxEl) tableBoxEl.classList.add('d-none');
        return;
    }

    // Recalculate duration in nights
    var d1 = new Date(arrInput.value + 'T00:00:00');
    var d2 = new Date(depInput.value + 'T00:00:00');
    var diffTime = d2.getTime() - d1.getTime();
    var diffDays = Math.round(diffTime / (1000 * 60 * 60 * 24));
    var nights = diffDays > 0 ? diffDays : 1;

    bookingState.nights = nights;
    bookingState.checkIn = arrInput.value;
    bookingState.checkOut = depInput.value;

    // Read Adults, Children, Rooms
    var adultsSel = document.getElementById('bookingAdults');
    var childrenSel = document.getElementById('bookingChildren');
    var roomsSel = document.getElementById('totalRooms');

    var adultsVal = adultsSel ? adultsSel.value : '2';
    var childrenVal = childrenSel ? childrenSel.value : '0';
    var roomsVal = roomsSel ? roomsSel.value : '1';
    var roomsCount = parseInt(roomsVal) || 1;

    var guestsFormatted = formatGuestsText(adultsVal, childrenVal, roomsVal);
    var datesFormatted = formatDisplayDate(bookingState.checkIn) + ' – ' + formatDisplayDate(bookingState.checkOut);

    // Actual pricing calculation
    var roomPrice = bookingState.ratePerNight * nights * roomsCount;
    var gst = Math.round(roomPrice * 0.18);
    var total = roomPrice + gst;
    var sym = currencySymbols[bookingState.currency] || '₹';

    // Show populated summary table and hide empty placeholder
    if (emptyStateEl) emptyStateEl.classList.add('d-none');
    if (tableBoxEl) tableBoxEl.classList.remove('d-none');

    var tblRoom = document.getElementById('sumTableRoom');
    var tblDates = document.getElementById('sumTableDates');
    var tblGuests = document.getElementById('sumTableGuests');
    var tblNights = document.getElementById('sumTableNights');
    var tblPrice = document.getElementById('sumTablePrice');
    var tblTaxes = document.getElementById('sumTableTaxes');
    var tblTotal = document.getElementById('sumTableTotal');

    if (tblRoom) tblRoom.textContent = bookingState.room;
    if (tblDates) tblDates.textContent = datesFormatted;
    if (tblGuests) tblGuests.textContent = guestsFormatted;
    if (tblNights) tblNights.textContent = nights + (nights === 1 ? ' Night' : ' Nights');
    if (tblPrice) tblPrice.textContent = sym + roomPrice.toLocaleString();
    if (tblTaxes) tblTaxes.textContent = sym + gst.toLocaleString();
    if (tblTotal) tblTotal.textContent = sym + total.toLocaleString();
}

function handleOnlineBookingSubmit(e) {
    e.preventDefault();

    var arrInput = document.getElementById('arrivalDate');
    var depInput = document.getElementById('departureDate');
    if (!arrInput || !arrInput.value || !depInput || !depInput.value) {
        alert('Please select your Check-in and Check-out dates in Step 1.');
        if (arrInput && !arrInput.value) arrInput.focus();
        else if (depInput) depInput.focus();
        return;
    }

    if (!bookingState.room || bookingState.ratePerNight <= 0) {
        alert('Please select a room in Step 2 to proceed.');
        var step2 = document.querySelector('.booking-room-pick-grid');
        if (step2) step2.scrollIntoView({ behavior: 'smooth', block: 'center' });
        return;
    }

    var termsCheckbox = document.getElementById('termsAgreement');
    if (termsCheckbox && !termsCheckbox.checked) {
        alert('Please review and accept the Terms & Conditions and Cancellation Policy before confirming your booking.');
        termsCheckbox.focus();
        return;
    }

    var guestName = document.getElementById('guestName') ? document.getElementById('guestName').value.trim() : 'Valued Guest';
    var guestEmail = document.getElementById('guestEmail') ? document.getElementById('guestEmail').value.trim() : 'guest@example.com';
    var guestContact = document.getElementById('guestContact') ? document.getElementById('guestContact').value.trim() : '+91 98765 43210';
    var specialReq = document.getElementById('additionalReqs') ? document.getElementById('additionalReqs').value.trim() : '';
    var neuId = document.getElementById('guestNeuId') ? document.getElementById('guestNeuId').value.trim() : '';

    var roomsSel = document.getElementById('totalRooms');
    var roomsCount = roomsSel ? (parseInt(roomsSel.value) || 1) : 1;
    var baseStay = bookingState.ratePerNight * bookingState.nights * roomsCount;
    var taxes = Math.round(baseStay * 0.18);
    var grandTotal = baseStay + taxes;
    var sym = currencySymbols[bookingState.currency] || '₹';

    var refNumber = 'HM-RES-' + Math.floor(100000 + Math.random() * 900000);

    // Populate confirmation voucher pass
    var confRef = document.getElementById('confRefNumber');
    var confGuest = document.getElementById('confGuestName');
    var confContact = document.getElementById('confGuestContact');
    var confEmail = document.getElementById('confGuestEmail');
    var confRoom = document.getElementById('confRoomName');
    var confStay = document.getElementById('confStaySchedule');
    var confGR = document.getElementById('confGuestsRooms');
    var confReq = document.getElementById('confSpecialRequest');
    var confBaseTax = document.getElementById('confBaseAndTax');
    var confTot = document.getElementById('confTotalAmount');

    var adultsSel = document.getElementById('bookingAdults');
    var childrenSel = document.getElementById('bookingChildren');
    var guestsFormatted = formatGuestsText(adultsSel ? adultsSel.value : '2', childrenSel ? childrenSel.value : '0', roomsCount);
    var datesFormatted = formatDisplayDate(bookingState.checkIn) + ' – ' + formatDisplayDate(bookingState.checkOut);

    if (confRef) confRef.textContent = refNumber;
    if (confGuest) confGuest.textContent = guestName + (neuId ? ' (NeuPass: ' + neuId + ')' : '');
    if (confContact) confContact.textContent = guestContact;
    if (confEmail) confEmail.textContent = guestEmail;
    if (confRoom) confRoom.textContent = bookingState.room;
    if (confStay) confStay.textContent = datesFormatted + ' (' + bookingState.nights + (bookingState.nights === 1 ? ' Night)' : ' Nights)');
    if (confGR) confGR.textContent = guestsFormatted;
    if (confReq) confReq.textContent = specialReq || 'None';
    if (confBaseTax) confBaseTax.textContent = sym + baseStay.toLocaleString() + ' + ' + sym + taxes.toLocaleString() + ' GST';
    if (confTot) confTot.innerHTML = sym + grandTotal.toLocaleString();

    // Hide form, reveal booking confirmation voucher pass
    var form = document.getElementById('onlineBookingForm');
    var pass = document.getElementById('bookingConfirmationPass');
    if (form && pass) {
        form.classList.add('d-none');
        pass.classList.remove('d-none');
        pass.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
}

document.addEventListener("DOMContentLoaded", function () {
    var urlParams = new URLSearchParams(window.location.search);
    var offerParam = urlParams.get('offer');
    var planParam = urlParams.get('plan');
    var priceParam = urlParams.get('price');
    var checkInParam = urlParams.get('checkIn');
    var checkOutParam = urlParams.get('checkOut');
    var adultsParam = urlParams.get('adults');
    var childrenParam = urlParams.get('children');
    var roomsParam = urlParams.get('rooms');
    var roomParam = urlParams.get('room') || urlParams.get('title');
    var currencyParam = urlParams.get('currency');

    if (currencyParam) bookingState.currency = currencyParam;

    // Date inputs
    var arrInput = document.getElementById('arrivalDate');
    var depInput = document.getElementById('departureDate');

    if (arrInput && depInput) {
        var today = new Date();
        var tomorrow = new Date(today);
        tomorrow.setDate(tomorrow.getDate() + 1);
        var fmt = function (d) { return d.toISOString().split("T")[0]; };

        arrInput.min = fmt(today);
        depInput.min = fmt(tomorrow);

        // Pre-fill ONLY if passed in URL params (from Check Availability)
        if (checkInParam) {
            arrInput.value = checkInParam;
            bookingState.checkIn = checkInParam;
        }
        if (checkOutParam) {
            depInput.value = checkOutParam;
            bookingState.checkOut = checkOutParam;
        }

        arrInput.addEventListener("change", function () {
            if (this.value) {
                var nxt = new Date(this.value);
                nxt.setDate(nxt.getDate() + 1);
                depInput.min = fmt(nxt);
                if (depInput.value && new Date(depInput.value) <= new Date(this.value)) {
                    depInput.value = fmt(nxt);
                }
            }
            updateBookingSummary();
        });

        depInput.addEventListener("change", function () {
            updateBookingSummary();
        });
    }

    // Adults pre-fill if passed in URL
    var adultsInput = document.getElementById('bookingAdults');
    if (adultsInput) {
        if (adultsParam) adultsInput.value = adultsParam;
        adultsInput.addEventListener('change', updateBookingSummary);
    }

    // Children pre-fill if passed in URL
    var childrenInput = document.getElementById('bookingChildren');
    if (childrenInput) {
        if (childrenParam) childrenInput.value = childrenParam;
        childrenInput.addEventListener('change', updateBookingSummary);
    }

    // Rooms pre-fill if passed in URL
    var roomsInput = document.getElementById('totalRooms');
    if (roomsInput) {
        if (roomsParam) roomsInput.value = roomsParam;
        roomsInput.addEventListener('change', updateBookingSummary);
    }

    // Pre-select room if passed via URL parameters (from Available Rooms / BOOK NOW)
    if (roomParam || priceParam) {
        var roomCards = document.querySelectorAll('.booking-room-pick-card');
        var matchedCard = null;
        if (roomParam) {
            var rLower = roomParam.toLowerCase();
            roomCards.forEach(function (card) {
                var cRoom = (card.getAttribute('data-room') || '').toLowerCase();
                if (cRoom.indexOf(rLower) !== -1 || rLower.indexOf(cRoom) !== -1) {
                    matchedCard = card;
                }
            });
        } else if (priceParam) {
            roomCards.forEach(function (card) {
                if (card.getAttribute('data-price') === priceParam) {
                    matchedCard = card;
                }
            });
        }

        if (matchedCard) {
            roomCards.forEach(function (c) { c.classList.remove('active'); });
            matchedCard.classList.add('active');
            bookingState.room = matchedCard.getAttribute('data-room');
            bookingState.ratePerNight = parseInt(matchedCard.getAttribute('data-price')) || 0;
        } else if (roomParam) {
            // In case room passed is custom like "Deluxe King Suite"
            bookingState.room = roomParam;
            bookingState.ratePerNight = parseInt(priceParam) || 9000;
        }
    }

    // Special Offer Banner prefill if applicable
    var offerCodeParam = urlParams.get('offerRateCode');
    if (roomParam && planParam) {
        var banner = document.getElementById('bookingOfferAppliedBanner');
        var bannerTitle = document.getElementById('bookingOfferTitle');
        var bannerRate = document.getElementById('bookingOfferRateBadge');

        if (banner) {
            banner.classList.remove('d-none');
            banner.style.backgroundColor = '#faf8f5';
        }
        if (bannerTitle) {
            var badgeText = offerParam ? (offerParam + (offerCodeParam ? ' &bull; ' + offerCodeParam : '')) : 'Selected Stay Package';
            bannerTitle.innerHTML = '<span class="badge bg-gold-subtle text-warning-dark text-uppercase px-2 py-1 mb-1 small d-inline-block">' + badgeText + '</span><br>' + roomParam + ' &mdash; <span class="fw-normal text-muted">' + planParam + '</span>';
        }
        if (bannerRate) {
            var sym = currencySymbols[bookingState.currency] || '₹';
            bannerRate.innerHTML = sym + Number(bookingState.ratePerNight).toLocaleString() + ' / night';
        }
    }

    // Initial summary evaluation:
    // If details & room are selected (e.g. from URL), it shows summary; otherwise displays placeholder!
    updateBookingSummary();
});
