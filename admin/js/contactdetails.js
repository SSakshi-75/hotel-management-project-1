/**
 * Contact Details Admin Page JavaScript
 * Location: admin/js/contactdetails.js
 */

function updateLivePreview() {
    var txtLoc = document.querySelector('[id$="txtLocationAddress"]');
    var txtPh = document.querySelector('[id$="txtPhoneNumber"]');
    var txtEm = document.querySelector('[id$="txtContactEmail"]');

    var prevLoc = document.getElementById('livePreviewLocation');
    var prevPh = document.getElementById('livePreviewPhone');
    var prevEm = document.getElementById('livePreviewEmail');

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

function setDefaultLocation() {
    var txtLoc = document.querySelector('[id$="txtLocationAddress"]');
    if (txtLoc) {
        txtLoc.value = "Diplomatic Enclave, Chanakyapuri, New Delhi 110021, India";
        updateLivePreview();
    }
}

document.addEventListener('DOMContentLoaded', function () {
    updateLivePreview();
});
