/* ==========================================
   TABLE RESERVATIONS MANAGEMENT ADMIN JAVASCRIPT
   Location: admin/js/tablereservations.js
   ========================================== */

function filterResStatus(status, btnElem) {
    var buttons = document.querySelectorAll('.filter-pill-btn');
    buttons.forEach(function (b) { b.classList.remove('active'); });
    if (btnElem) btnElem.classList.add('active');

    var rows = document.querySelectorAll('#tblReservations tbody tr[data-status]');
    rows.forEach(function (row) {
        var rowStatus = row.getAttribute('data-status');
        if (status === 'All' || rowStatus === status) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

function searchReservationsTable() {
    var searchInput = document.getElementById('txtSearchReservation');
    if (!searchInput) return;
    var filter = searchInput.value.toLowerCase().trim();
    var rows = document.querySelectorAll('#tblReservations tbody tr[data-status]');
    rows.forEach(function (row) {
        var text = row.textContent.toLowerCase();
        if (filter === '' || text.indexOf(filter) !== -1) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

function showConfirmation(message) {
    var toast = document.getElementById('confirmationToast');
    var msgElem = document.getElementById('confirmationToastMsg');
    if (toast) {
        if (msgElem && message) msgElem.textContent = message;
        toast.style.display = 'flex';
        toast.style.opacity = '0';
        toast.style.transform = 'translate(-50%, -20px)';
        setTimeout(function () {
            toast.style.opacity = '1';
            toast.style.transform = 'translate(-50%, 0)';
        }, 10);
        setTimeout(function () {
            toast.style.opacity = '0';
            toast.style.transform = 'translate(-50%, -20px)';
            setTimeout(function () {
                toast.style.display = 'none';
            }, 350);
        }, 2000);
    }
}

document.addEventListener('DOMContentLoaded', function () {
    var pnl = document.querySelector('[id$="pnlStatusMsg"]');
    if (pnl) {
        setTimeout(function () {
            pnl.style.transition = 'opacity 0.4s ease';
            pnl.style.opacity = '0';
            setTimeout(function () {
                pnl.style.display = 'none';
            }, 400);
        }, 2000);
    }
});
