/* ==========================================
   ROOM PAGE INTERACTIVE JAVASCRIPT LOGIC
   ========================================== */

function filterRooms(category, btnElement) {
    if (document.querySelectorAll('.room-card-luxury-block').length > 0 && typeof window.filterBookNowRooms === 'function') {
        return window.filterBookNowRooms(category, btnElement);
    }
    var buttons = document.querySelectorAll('.room-filter-btn');
    buttons.forEach(function (btn) {
        btn.classList.remove('active');
    });
    if (btnElement) {
        btnElement.classList.add('active');
    }

    var roomItems = document.querySelectorAll('.room-item-col');
    roomItems.forEach(function (item) {
        if (category === 'all' || item.getAttribute('data-category') === category) {
            item.style.display = 'block';
            item.classList.add('filter-fade-enter');
        } else {
            item.style.display = 'none';
            item.classList.remove('filter-fade-enter');
        }
    });
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

