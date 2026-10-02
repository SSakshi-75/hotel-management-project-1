/* ==========================================
   REGISTERED USERS & LOGINS ADMIN JAVASCRIPT
   Location: admin/js/users.js
   ========================================== */

function filterRegisteredGuests() {
    var input = document.getElementById('userSearchInput');
    var table = document.querySelector('[id$="gvUsers"]');
    if (!input || !table) return;

    var query = input.value.trim().toLowerCase();
    var rows = table.querySelectorAll('tr');

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        if (row.querySelector('th')) continue;
        var text = row.textContent.toLowerCase();
        row.style.display = (query === '' || text.includes(query)) ? '' : 'none';
    }
}

function filterLoginDirectory() {
    var input = document.getElementById('loginSearchInput');
    var table = document.querySelector('[id$="gvLogins"]');
    if (!input || !table) return;

    var query = input.value.trim().toLowerCase();
    var rows = table.querySelectorAll('tr');

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        if (row.querySelector('th')) continue;
        var text = row.textContent.toLowerCase();
        row.style.display = (query === '' || text.includes(query)) ? '' : 'none';
    }
}
