/* ==========================================
   USER LOGIN PAGE PASSWORD TOGGLE LOGIC
   ========================================== */
function togglePassword(inputId, btn) {
    var input = document.getElementById(inputId);
    if (!input) {
        return;
    }

    var icon = btn ? btn.querySelector("i") : null;

    if (input.type === "password") {
        input.type = "text";
        if (icon) {
            icon.classList.remove("bi-eye");
            icon.classList.add("bi-eye-slash");
        }
    } else {
        input.type = "password";
        if (icon) {
            icon.classList.remove("bi-eye-slash");
            icon.classList.add("bi-eye");
        }
    }
}
