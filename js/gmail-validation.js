// Global Gmail Validation Script
document.addEventListener('DOMContentLoaded', function () {
    // Select all inputs of type email, or IDs containing 'email'
    var emailInputs = document.querySelectorAll('input[type="email"], input[id*="email" i], input[id*="Email" i]');
    
    emailInputs.forEach(function (input) {
        // Enforce lowercase and custom validation message on input
        input.addEventListener('input', function () {
            var start = this.selectionStart;
            var end = this.selectionEnd;
            this.value = this.value.toLowerCase();
            
            // Restore cursor position if possible
            if (this.type === 'text' || this.type === 'email') {
                try { this.setSelectionRange(start, end); } catch(e) {}
            }
            
            var val = this.value.trim();
            if (val && !val.endsWith('@gmail.com')) {
                this.setCustomValidity('Only @gmail.com addresses are allowed.');
            } else {
                this.setCustomValidity('');
            }
        });
    });

    // Intercept ASP.NET Form submission and validate
    var form = document.forms[0];
    if (form) {
        form.addEventListener('submit', function (e) {
            var isValid = true;
            emailInputs.forEach(function (input) {
                var val = input.value.trim();
                // If it's visible, not empty, and doesn't end with @gmail.com
                if (val && !val.endsWith('@gmail.com')) {
                    isValid = false;
                    try { input.focus(); } catch(e) {}
                }
            });
            
            if (!isValid) {
                alert('Please provide a valid @gmail.com address. Only gmail accounts are allowed.');
                e.preventDefault(); // Stop standard submit
            }
        });
    }
});
