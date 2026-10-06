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

// Auto-dismiss alert popup (e.g. Enquiry deleted successfully) after 2 seconds
function setupAlertAutoDismiss() {
    var alertPnl = document.querySelector('[id$="pnlEnquiryMsg"]') || document.querySelector('.alert');
    if (alertPnl && alertPnl.offsetParent !== null) {
        setTimeout(function () {
            if (!alertPnl || alertPnl.dataset.dismissed === 'true') return;
            alertPnl.dataset.dismissed = 'true';
            alertPnl.style.transition = 'opacity 0.4s ease, transform 0.4s ease';
            alertPnl.style.opacity = '0';
            alertPnl.style.transform = 'translateY(-8px)';
            setTimeout(function () {
                alertPnl.style.display = 'none';
            }, 400);
        }, 2000);
    }
}

document.addEventListener('DOMContentLoaded', function () {
    updateCardLivePreview();
    setupAlertAutoDismiss();
});
