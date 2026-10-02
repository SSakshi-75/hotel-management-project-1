/* ==========================================
   MANAGE CATEGORY ADMIN JAVASCRIPT
   Location: admin/js/managecategory.js
   ========================================== */

function filterCategoryTable() {
    var searchInput = document.getElementById('txtCategorySearch');
    var filter = searchInput ? searchInput.value.toLowerCase().trim() : '';
    var table = document.getElementById('gvCategories');
    if (!table) return;

    var rows = table.getElementsByTagName('tr');
    // start from 1 to skip header
    for (var i = 1; i < rows.length; i++) {
        var row = rows[i];
        var text = row.textContent.toLowerCase();
        if (filter === '' || text.indexOf(filter) !== -1) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    }
}
