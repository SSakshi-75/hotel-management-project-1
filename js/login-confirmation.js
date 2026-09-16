/* ==========================================
   LOGIN CONFIRMATION COUNTDOWN & REDIRECT LOGIC
   ========================================== */
(function () {
    var seconds = 3;
    var countdownEl = document.getElementById('countdown');
    var timer = setInterval(function () {
        seconds--;
        if (countdownEl) countdownEl.textContent = seconds;
        if (seconds <= 0) {
            clearInterval(timer);
            window.location.href = 'index.aspx';
        }
    }, 1000);
})();
