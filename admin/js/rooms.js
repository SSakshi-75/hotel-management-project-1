/**
 * Rooms Management Admin Page JavaScript
 * Location: admin/js/rooms.js
 */

function filterRoomsTable() {
    var searchInput = document.getElementById('roomSearchInput');
    var statusSelect = document.getElementById('statusFilterSelect');
    if (!searchInput || !statusSelect) return;

    var input = searchInput.value.toLowerCase();
    var status = statusSelect.value.toLowerCase();
    var rows = document.querySelectorAll('#roomsTable tbody tr');

    rows.forEach(function (row) {
        var text = row.innerText.toLowerCase();
        var matchesSearch = text.includes(input);
        var matchesStatus = !status || text.includes(status);
        row.style.display = (matchesSearch && matchesStatus) ? '' : 'none';
    });
}

function confirmDeleteRoom(roomName) {
    if (confirm('Are you sure you want to delete "' + roomName + '"?')) {
        if (window.showAdminToast) {
            showAdminToast('Room Removed', roomName + ' deleted successfully.', 'bi-trash text-danger');
        }
    }
}
