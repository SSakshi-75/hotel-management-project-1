/* ==========================================
   MANAGE HOTEL & SUITES ADMIN JAVASCRIPT
   Location: admin/js/managehotel.js
   ========================================== */

var currentActiveCategory = 'ALL';

function confirmDeleteRoom(btnOrId, name) {
    var roomId = "";
    var roomName = "";

    if (btnOrId && typeof btnOrId === "object" && btnOrId.getAttribute) {
        roomId = btnOrId.getAttribute("data-room-id") || "";
        roomName = btnOrId.getAttribute("data-room-name") || "";
    } else {
        roomId = btnOrId || "";
        roomName = name || "";
    }

    roomId = String(roomId).trim();

    var hdn = document.getElementById("hdnDeleteRoomId") || document.querySelector('[id$="hdnDeleteRoomId"]');
    var lbl = document.getElementById("lblDeleteModalRoomName");
    var modalEl = document.getElementById("deleteConfirmModal");

    if (hdn && roomId) {
        hdn.value = roomId;
    }

    if (lbl) {
        lbl.textContent = (roomName ? roomName + " " : "") + (roomId ? "(Room #" + roomId + ")" : "");
    }

    // Try showing Bootstrap modal
    try {
        if (modalEl && window.bootstrap && bootstrap.Modal) {
            bootstrap.Modal.getOrCreateInstance(modalEl).show();
            return false;
        } else if (modalEl && window.jQuery && typeof jQuery.fn.modal === "function") {
            jQuery(modalEl).modal("show");
            return false;
        }
    } catch (e) {
        // Fallback to native confirmation below
    }

    // Direct confirm fallback if modal is unavailable
    return confirm("Are you sure you want to permanently delete " + (roomName ? roomName : "this room") + (roomId ? " (Room #" + roomId + ")" : "") + "?");
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
