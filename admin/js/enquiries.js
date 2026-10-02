/**
 * Enquiries & Contact Info Admin Page JavaScript
 * Location: admin/js/enquiries.js
 */

function updateCardLivePreview() {
    var txtLoc = document.querySelector('[id$="txtCardLocation"]');
    var txtPh = document.querySelector('[id$="txtCardPhone"]');
    var txtEm = document.querySelector('[id$="txtCardEmail"]');

    var prevLoc = document.getElementById('cardPreviewLocation');
    var prevPh = document.getElementById('cardPreviewPhone');
    var prevEm = document.getElementById('cardPreviewEmail');

    if (txtLoc && prevLoc) {
        var locVal = txtLoc.value.trim();
        prevLoc.innerText = locVal;
    }

    if (txtPh && prevPh) {
        var phVal = txtPh.value.trim();
        prevPh.innerText = phVal;
    }

    if (txtEm && prevEm) {
        var emVal = txtEm.value.trim();
        prevEm.innerText = emVal;
    }
}

document.addEventListener('DOMContentLoaded', updateCardLivePreview);
