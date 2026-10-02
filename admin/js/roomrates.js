/**
 * Room Rates Admin Page JavaScript
 * Location: admin/js/roomrates.js
 */

function filterRatesTable() {
    var searchInput = document.getElementById('ratesSearchInput');
    var planSelect = document.getElementById('planFilterSelect');
    if (!searchInput || !planSelect) return;

    var input = searchInput.value.toLowerCase();
    var plan = planSelect.value.toLowerCase();
    var rows = document.querySelectorAll('#ratesTable tbody tr');

    rows.forEach(function (row) {
        var text = row.innerText.toLowerCase();
        var matchesSearch = text.includes(input);
        var matchesPlan = !plan || text.includes(plan);
        row.style.display = (matchesSearch && matchesPlan) ? '' : 'none';
    });
}
