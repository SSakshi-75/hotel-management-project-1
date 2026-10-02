/* ==========================================
   RESTAURANT MANAGEMENT ADMIN JAVASCRIPT
   Location: admin/js/restaurantmanagement.js
   ========================================== */

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
