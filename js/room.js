/* ==========================================
   ROOM PAGE INTERACTIVE JAVASCRIPT LOGIC
   ========================================== */

/* ==========================================
   SIDEBAR ROOM FILTER (PRICE, CATEGORY, RATING)
   ========================================== */

function applyFilters() {
    var selectedPrices = [];
    document.querySelectorAll('.filter-price-chk:checked').forEach(function (chk) {
        if (chk.value) selectedPrices.push(chk.value);
    });

    var selectedCategories = [];
    document.querySelectorAll('.filter-category-chk:checked').forEach(function (chk) {
        if (chk.value) selectedCategories.push(chk.value.toLowerCase().trim().replace(/\s+/g, '-'));
    });

    var selectedRatings = [];
    document.querySelectorAll('.filter-rating-chk:checked').forEach(function (chk) {
        var val = parseFloat(chk.value);
        if (!isNaN(val)) selectedRatings.push(val);
    });

    var roomItems = document.querySelectorAll('.room-item-col');
    var visibleCount = 0;

    roomItems.forEach(function (item) {
        var price = parseFloat(item.getAttribute('data-price') || '0');
        
        // Robust Rating Extraction
        var rawRating = (item.getAttribute('data-rating') || '').toString().trim();
        var ratingMatchNum = rawRating.match(/[\d\.]+/);
        var rating = ratingMatchNum ? parseFloat(ratingMatchNum[0]) : 0;
        if (rating <= 0) {
            var numEl = item.querySelector('.rating-num');
            if (numEl) {
                var sMatch = numEl.textContent.match(/[\d\.]+/);
                if (sMatch) rating = parseFloat(sMatch[0]);
            }
        }
        if (!rating || isNaN(rating)) rating = 4.8;

        var cat = (item.getAttribute('data-category') || '').toLowerCase().trim().replace(/\s+/g, '-');

        // 1. Price Matching
        var priceMatch = (selectedPrices.length === 0);
        if (!priceMatch) {
            for (var i = 0; i < selectedPrices.length; i++) {
                var range = selectedPrices[i].split('-');
                var min = parseFloat(range[0]);
                var max = parseFloat(range[1]);
                if (price >= min && price <= max) {
                    priceMatch = true;
                    break;
                }
            }
        }

        // 2. Category Matching
        var categoryMatch = (selectedCategories.length === 0);
        if (!categoryMatch) {
            for (var j = 0; j < selectedCategories.length; j++) {
                var c = selectedCategories[j];
                if (cat === c || cat.indexOf(c) !== -1 || c.indexOf(cat) !== -1) {
                    categoryMatch = true;
                    break;
                }
            }
        }

        // 3. Rating Matching
        // Supports both single threshold and tiered checkbox selection:
        // - "4.5 & above": rating >= 4.5
        // - "4.0 & above": if 4.5 not selected, filters 4.0 <= rating < 4.5; if 4.5 selected, filters rating >= 4.0
        // - "3.5 & above": if 4.0 not selected, filters 3.5 <= rating < 4.0; if 4.0 selected, filters rating >= 3.5
        // - "3.0 & above": if 3.5 not selected, filters 3.0 <= rating < 3.5; if 3.5 selected, filters rating >= 3.0
        var ratingMatch = (selectedRatings.length === 0);
        if (!ratingMatch) {
            for (var rIdx = 0; rIdx < selectedRatings.length; rIdx++) {
                var rVal = selectedRatings[rIdx];
                if (rVal === 4.5 && rating >= 4.5) {
                    ratingMatch = true;
                    break;
                } else if (rVal === 4.0 && rating >= 4.0 && (selectedRatings.indexOf(4.5) !== -1 ? true : rating < 4.5)) {
                    ratingMatch = true;
                    break;
                } else if (rVal === 3.5 && rating >= 3.5 && (selectedRatings.indexOf(4.0) !== -1 ? true : rating < 4.0)) {
                    ratingMatch = true;
                    break;
                } else if (rVal === 3.0 && rating >= 3.0 && (selectedRatings.indexOf(3.5) !== -1 ? true : rating < 3.5)) {
                    ratingMatch = true;
                    break;
                }
            }
        }

        if (priceMatch && categoryMatch && ratingMatch) {
            item.style.display = 'block';
            item.classList.add('filter-fade-enter');
            item.classList.add('aos-animate');
            visibleCount++;
        } else {
            item.style.display = 'none';
            item.classList.remove('filter-fade-enter');
        }
    });

    var noRoomsMsg = document.getElementById('noRoomsFilterMsg');
    if (noRoomsMsg) {
        noRoomsMsg.style.display = (visibleCount === 0) ? 'block' : 'none';
    }

    if (typeof AOS !== 'undefined') {
        setTimeout(function () {
            if (typeof AOS.refreshHard === 'function') {
                AOS.refreshHard();
            } else if (typeof AOS.refresh === 'function') {
                AOS.refresh();
            }
        }, 50);
    }
}

function clearAllFilters() {
    document.querySelectorAll('.filter-price-chk, .filter-category-chk, .filter-rating-chk').forEach(function (chk) {
        chk.checked = false;
    });
    applyFilters();
}

function bindRoomFilters() {
    document.querySelectorAll('.filter-price-chk, .filter-category-chk, .filter-rating-chk').forEach(function (chk) {
        chk.removeEventListener('change', applyFilters);
        chk.addEventListener('change', applyFilters);
        chk.removeEventListener('click', applyFiltersDebounced);
        chk.addEventListener('click', applyFiltersDebounced);
    });
}

function applyFiltersDebounced() {
    setTimeout(applyFilters, 10);
}

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', bindRoomFilters);
} else {
    bindRoomFilters();
}

window.applyFilters = applyFilters;
window.clearAllFilters = clearAllFilters;

function filterRooms(category, btnElement) {
    if (category && typeof category === 'object' && category.getAttribute) {
        btnElement = category;
        category = btnElement.getAttribute('data-category') || btnElement.getAttribute('data-filter') || 'all';
    }
    if (document.querySelectorAll('.room-card-luxury-block').length > 0 && typeof window.filterBookNowRooms === 'function') {
        return window.filterBookNowRooms(category, btnElement);
    }

    category = (category || 'all').toString().toLowerCase().trim().replace(/\s+/g, '-');

    if (category === 'all') {
        clearAllFilters();
        return;
    }

    var chks = document.querySelectorAll('.filter-category-chk');
    if (chks.length > 0) {
        chks.forEach(function (chk) {
            chk.checked = (chk.value.toLowerCase().replace(/\s+/g, '-') === category);
        });
        applyFilters();
    } else {
        var roomItems = document.querySelectorAll('.room-item-col');
        roomItems.forEach(function (item) {
            var cat = (item.getAttribute('data-category') || '').toString().toLowerCase().trim().replace(/\s+/g, '-');
            var isMatch = (category === 'all' || category === '') || (cat === category);
            item.style.display = isMatch ? 'block' : 'none';
        });
    }

    if (typeof AOS !== 'undefined') {
        setTimeout(function () { AOS.refresh(); }, 50);
    }
}

function openBookingModal(roomName, price) {
    var nameEl = document.getElementById('modalSelectedRoomName');
    var priceEl = document.getElementById('modalSelectedRoomPrice');
    if (nameEl) nameEl.innerText = roomName;
    if (priceEl) priceEl.innerText = '₹ ' + price + ' / night';
}

function handleReservationSubmit(e) {
    e.preventDefault();
    alert('Thank you! Your room reservation inquiry has been received. Our concierge team will contact you shortly.');
    var modalEl = document.getElementById('roomBookingModal');
    if (modalEl && window.bootstrap) {
        var modal = bootstrap.Modal.getInstance(modalEl);
        if (modal) {
            modal.hide();
        }
    }
}

function scrollToRooms() {
    var grid = document.getElementById('all-rooms-grid');
    if (grid) {
        grid.scrollIntoView({ behavior: 'smooth' });
    }
}

/* ==========================================
   ROOMS & RATES CALCULATION LOGIC
   ========================================== */
var selectedRoomData = null;

function triggerDatePicker(inputId) {
    var el = document.getElementById(inputId);
    if (el) {
        if (typeof el.showPicker === 'function') {
            try { el.showPicker(); return; } catch (e) { }
        }
        el.focus();
        el.click();
    }
}

function formatDateToCustom(input, displayId) {
    if (!input || !input.value) return;
    var parts = input.value.split('-');
    if (parts.length === 3) {
        var d = new Date(parseInt(parts[0], 10), parseInt(parts[1], 10) - 1, parseInt(parts[2], 10));
        var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        var formatted = days[d.getDay()] + ', ' + d.getDate() + ' ' + months[d.getMonth()];
        var el = document.getElementById(displayId);
        if (el) el.innerText = formatted;
    }
    if (typeof updateStaySummary === 'function') updateStaySummary();
}

document.addEventListener('DOMContentLoaded', function () {
    initDefaultDates();
});

function initDefaultDates() {
    var today = new Date();
    var tomorrow = new Date();
    tomorrow.setDate(today.getDate() + 1);

    var cin = document.getElementById('txtCheckIn');
    var cout = document.getElementById('txtCheckOut');

    if (cin && !cin.value) cin.valueAsDate = today;
    if (cout && !cout.value) cout.valueAsDate = tomorrow;

    if (cin && cin.value) formatDateToCustom(cin, 'lblCheckInDisplay');
    if (cout && cout.value) formatDateToCustom(cout, 'lblCheckOutDisplay');

    updateStaySummary();
}

function updateStaySummary() {
    var adults = document.getElementById('ddlAdults') ? document.getElementById('ddlAdults').value : "2";
    var summaryRoom = document.getElementById('lblSummaryRoom');
    if (summaryRoom) {
        summaryRoom.textContent = "Room 1: " + adults + " Adult(s)";
    }

    var cin = document.getElementById('txtCheckIn') ? new Date(document.getElementById('txtCheckIn').value) : null;
    var cout = document.getElementById('txtCheckOut') ? new Date(document.getElementById('txtCheckOut').value) : null;

    if (cin && cout && cout > cin) {
        var nights = Math.ceil((cout - cin) / (1000 * 60 * 60 * 24));
        var lblDates = document.getElementById('lblSummaryDates');
        if (lblDates) lblDates.textContent = nights + " Night(s)";

        if (selectedRoomData) {
            calculateTotal(selectedRoomData.price * nights);
        }
    }
}

function filterRoomCards(category, btn) {
    var btns = document.querySelectorAll('.category-pill-btn');
    btns.forEach(function (b) { b.classList.remove('active'); });
    if (btn) btn.classList.add('active');

    var cards = document.querySelectorAll('.room-card-item');
    cards.forEach(function (card) {
        if (category === 'all' || card.getAttribute('data-category') === category) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

function switchRateType(type, btn) {
    var tabs = document.querySelectorAll('.rate-type-tab');
    tabs.forEach(function (t) { t.classList.remove('active'); });
    if (btn) btn.classList.add('active');
}

function toggleTaxesDisplay() {
    var chk = document.getElementById('chkShowTaxes');
    var showTax = chk ? chk.checked : false;

    document.querySelectorAll('.room-rate-card').forEach(function (card) {
        var baseElements = card.querySelectorAll('.base-price');
        baseElements.forEach(function (elem) {
            var base = parseFloat(elem.textContent.replace(/,/g, ''));
            if (showTax) {
                var withTax = Math.round(base * 1.18);
                elem.textContent = withTax.toLocaleString('en-IN');
            } else {
                elem.textContent = base.toLocaleString('en-IN');
            }
        });
    });
}

function selectRoomRate(btn, roomName, rateName, basePrice, imgUrl) {
    document.querySelectorAll('.rate-option-box').forEach(function (b) {
        b.classList.remove('selected-option');
        var bBtn = b.querySelector('.btn-select-rate');
        if (bBtn) {
            bBtn.textContent = 'SELECT';
        }
    });

    var parentBox = btn.closest('.rate-option-box');
    if (parentBox) {
        parentBox.classList.add('selected-option');
    }
    btn.textContent = 'SELECTED ✓';

    selectedRoomData = {
        roomName: roomName,
        rateName: rateName,
        price: basePrice,
        img: imgUrl
    };

    document.getElementById('lblSelectedRoomName').textContent = roomName;
    document.getElementById('lblSelectedRateName').textContent = rateName;

    var promptMsg = document.getElementById('emptyPromptMessage');
    if (promptMsg) promptMsg.style.display = 'none';

    var cin = document.getElementById('txtCheckIn') ? new Date(document.getElementById('txtCheckIn').value) : new Date();
    var cout = document.getElementById('txtCheckOut') ? new Date(document.getElementById('txtCheckOut').value) : new Date();
    var nights = (cout > cin) ? Math.ceil((cout - cin) / (1000 * 60 * 60 * 24)) : 1;

    calculateTotal(basePrice * nights);

    var proceedBtn = document.getElementById('btnProceedBooking');
    if (proceedBtn) {
        proceedBtn.disabled = false;
        proceedBtn.innerHTML = 'PROCEED TO BOOKING <i class="bi bi-arrow-right ms-2"></i>';
    }
}

function calculateTotal(totalBase) {
    var taxes = totalBase * 0.18;
    var grandTotal = totalBase + taxes;

    document.getElementById('lblBasePrice').textContent = totalBase.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    document.getElementById('lblTaxes').textContent = taxes.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    document.getElementById('lblTotalAmount').textContent = grandTotal.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

function proceedToBooking() {
    if (!selectedRoomData) return;
    var url = "RoomDetails.aspx?title=" + encodeURIComponent(selectedRoomData.roomName) + "&price=" + selectedRoomData.price + "&img=" + encodeURIComponent(selectedRoomData.img);
    window.location.href = url;
}

function scrollToRoomsList() {
    var el = document.getElementById('roomsListSection');
    if (el) el.scrollIntoView({ behavior: 'smooth' });
}

// Preserve checkIn, checkOut, and adults on Room Select clicks
document.addEventListener('click', function (e) {
    var btn = e.target.closest('.btn-room-book');
    if (btn && btn.href && btn.href.indexOf('RoomDetails.aspx') !== -1) {
        var cin = document.getElementById('txtCheckIn') ? document.getElementById('txtCheckIn').value : '';
        var cout = document.getElementById('txtCheckOut') ? document.getElementById('txtCheckOut').value : '';
        var adults = document.getElementById('ddlAdults') ? document.getElementById('ddlAdults').value : '';
        try {
            var url = new URL(btn.href, window.location.origin);
            if (cin && !url.searchParams.has('checkIn')) url.searchParams.set('checkIn', cin);
            if (cout && !url.searchParams.has('checkOut')) url.searchParams.set('checkOut', cout);
            if (adults && !url.searchParams.has('adults')) url.searchParams.set('adults', adults);
            btn.href = url.pathname.replace(/^\//, '') + url.search;
        } catch (ex) { }
    }
});

