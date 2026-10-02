/* ==========================================
   MANAGE HOTEL & SUITES ADMIN JAVASCRIPT
   Location: admin/js/managehotel.js
   ========================================== */

var currentActiveCategory = 'ALL';

function confirmDeleteRoom(roomId, roomName) {
    var hdn = document.querySelector('[id$="hdnDeleteRoomId"]');
    if (hdn) {
        hdn.value = roomId;
    }
    var lbl = document.getElementById('lblDeleteModalRoomName');
    if (lbl) {
        lbl.innerText = roomName || ('Room #' + roomId);
    }
    var modalEl = document.getElementById('deleteConfirmModal');
    if (modalEl) {
        if (typeof bootstrap !== 'undefined' && bootstrap.Modal) {
            var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
            modal.show();
        } else if (typeof $ !== 'undefined' && $(modalEl).modal) {
            $(modalEl).modal('show');
        }
    }
}

function toggleSelectAllRooms(master) {
    var checkboxes = document.querySelectorAll('.room-row-chk input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = master.checked;
    }
}

function filterHotelTable() {
    var searchInput = document.getElementById('txtHotelSearch');
    var filter = searchInput ? searchInput.value.toLowerCase().trim() : '';
    var rows = document.querySelectorAll('#grdrooms tr.hotel-room-row');

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var text = row.textContent.toLowerCase();
        var category = (row.getAttribute('data-category') || '').toUpperCase();

        var matchesSearch = (filter === '' || text.indexOf(filter) !== -1);
        var matchesCategory = (currentActiveCategory === 'ALL' || category.indexOf(currentActiveCategory) !== -1);

        row.style.display = (matchesSearch && matchesCategory) ? '' : 'none';
    }
}

function setCategoryFilter(category, button) {
    if (category && typeof category === 'object' && category.getAttribute) {
        button = category;
        category = button.getAttribute('data-category') || 'ALL';
    }
    currentActiveCategory = (category || 'ALL').toUpperCase();

    var buttons = document.querySelectorAll('.filter-pill-btn');
    for (var i = 0; i < buttons.length; i++) {
        buttons[i].classList.remove('active');
    }

    if (button) {
        button.classList.add('active');
    }

    filterHotelTable();
}

function confirmBulkDelete() {
    var checked = document.querySelectorAll('.room-row-chk input[type="checkbox"]:checked');
    if (checked.length === 0) {
        alert('Please select at least one room checkbox from the table to delete.');
        return false;
    }
    return confirm('Are you sure you want to permanently delete ' + checked.length + ' selected room(s)?');
}
