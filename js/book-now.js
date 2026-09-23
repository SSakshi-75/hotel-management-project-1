/* ==========================================================================
   BOOK NOW PAGE - MULTI-ROOM RATES, TABS, FILTERS & GALLERY JS
   100% Client-Side / Pure Frontend (HTML5, CSS3, Vanilla JavaScript)
   ========================================================================== */

const TAX_RATE = 0.18; // 18% GST

// State store per room card
const roomGalleryStates = {};

/* ==========================================================================
   1. TAB SWITCHING (ROOM RATES vs. OFFERS & PACKAGES)
   ========================================================================== */
function switchRatesTab(tabName, btn) {
    const btnRates = document.getElementById('tabBtnRates');
    const btnOffers = document.getElementById('tabBtnOffers');

    if (tabName === 'rates') {
        if (btnRates) btnRates.classList.add('active');
        if (btnOffers) btnOffers.classList.remove('active');
    } else if (tabName === 'offers') {
        if (btnOffers) btnOffers.classList.add('active');
        if (btnRates) btnRates.classList.remove('active');
    } else if (btn) {
        document.querySelectorAll('.bn-tab-button').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
    }

    const ratesSection = document.getElementById('viewRoomRatesSection');
    const offersSection = document.getElementById('viewOffersPackagesSection');

    if (tabName === 'rates') {
        if (ratesSection) {
            ratesSection.style.display = 'block';
        }
        if (offersSection) {
            offersSection.style.display = 'none';
        }
    } else if (tabName === 'offers') {
        if (ratesSection) {
            ratesSection.style.display = 'none';
        }
        if (offersSection) {
            offersSection.style.display = 'block';
        }
    }

    if (typeof AOS !== 'undefined') {
        setTimeout(function () { AOS.refresh(); }, 50);
    }
}
window.switchRatesTab = switchRatesTab;

/* ==========================================================================
   2. ROOM CATEGORY FILTERING (ALL ROOMS, EXECUTIVE, DELUXE, FAMILY, PENTHOUSE & ROYAL)
   ========================================================================== */
function filterBookNowRooms(category, btn) {
    category = (category || 'all').toLowerCase();

    // Backward compatibility for old specific room keys
    if (category === 'superior-twin' || category === 'superior-king') category = 'executive';
    if (category === 'deluxe-king' || category === 'deluxe-twin') category = 'deluxe';
    if (category === 'luxury-suite') category = 'family';

    // 1. Update active pill highlight
    const pills = document.querySelectorAll('.bn-filter-pill');
    pills.forEach(pill => pill.classList.remove('active'));

    if (btn) {
        btn.classList.add('active');
    } else {
        const matchPill = document.querySelector(`.bn-filter-pill[data-filter="${category}"]`);
        if (matchPill) matchPill.classList.add('active');
    }

    // 2. Filter the room luxury cards
    const blocks = document.querySelectorAll('.room-card-luxury-block');
    let visibleCount = 0;
    let firstTargetBlock = null;

    blocks.forEach(block => {
        const cat = (block.getAttribute('data-category') || '').toLowerCase();
        const catTokens = cat.split(/\s+/);
        if (category === 'all' || catTokens.includes(category) || cat === category) {
            block.style.display = 'block';
            visibleCount++;
            if (!firstTargetBlock) firstTargetBlock = block;
        } else {
            block.style.display = 'none';
        }
    });

    // 3. Update summary counter text
    const summaryEl = document.getElementById('searchContextSummary');
    if (summaryEl) {
        if (category === 'all') {
            summaryEl.textContent = `Showing ${visibleCount} available luxury rooms • 2 Adults`;
        } else {
            const label = btn ? btn.textContent.trim() : category.toUpperCase();
            summaryEl.textContent = `Showing ${visibleCount} luxury ${visibleCount === 1 ? 'room' : 'rooms'} (${label}) • 2 Adults`;
        }
    }

    if (typeof AOS !== 'undefined') {
        setTimeout(function () { AOS.refresh(); }, 50);
    }

    // 4. Smooth scroll to the visible card when a specific category is selected
    if (firstTargetBlock && category !== 'all') {
        const yOffset = -90;
        const y = firstTargetBlock.getBoundingClientRect().top + window.pageYOffset + yOffset;
        window.scrollTo({ top: Math.max(0, y), behavior: 'smooth' });
    }
}
window.filterBookNowRooms = filterBookNowRooms;
window.filterRooms = filterBookNowRooms;

/* ==========================================================================
   3. SPECIAL OFFERS & PACKAGES FILTERING
   ========================================================================== */
function filterPackages(category, btn) {
    const pills = document.querySelectorAll('.bn-package-pill');
    pills.forEach(pill => pill.classList.remove('active'));

    if (btn) {
        btn.classList.add('active');
    } else {
        const matchPill = document.querySelector(`.bn-package-pill[data-package-filter="${category}"]`);
        if (matchPill) matchPill.classList.add('active');
    }

    const cards = document.querySelectorAll('.package-offer-card-block');
    let visibleCount = 0;
    let firstTargetCard = null;

    cards.forEach(card => {
        const cat = card.getAttribute('data-package-category');
        if (category === 'all' || cat === category) {
            card.style.display = 'block';
            visibleCount++;
            if (!firstTargetCard) firstTargetCard = card;
        } else {
            card.style.display = 'none';
        }
    });

    const summaryEl = document.getElementById('packageContextSummary');
    if (summaryEl) {
        if (category === 'all') {
            summaryEl.textContent = `Showing ${visibleCount} special packages • Best rate guaranteed`;
        } else {
            const label = btn ? btn.textContent.trim() : category;
            summaryEl.textContent = `Showing 1 special package (${label}) • Best rate guaranteed`;
        }
    }

    if (typeof AOS !== 'undefined') {
        setTimeout(function () { AOS.refresh(); }, 50);
    }

    if (firstTargetCard && category !== 'all') {
        const yOffset = -90;
        const y = firstTargetCard.getBoundingClientRect().top + window.pageYOffset + yOffset;
        window.scrollTo({ top: Math.max(0, y), behavior: 'smooth' });
    }
}
window.filterPackages = filterPackages;

/* ==========================================================================
   4. ROOM GALLERY SLIDER / THUMBNAIL LOGIC
   ========================================================================== */
function initGallery(roomId, images) {
    roomGalleryStates[roomId] = {
        images: images,
        currentIndex: 0
    };
}

function changeGalleryImage(roomId, index) {
    const state = roomGalleryStates[roomId];
    if (!state || !state.images || state.images.length === 0) return;

    state.currentIndex = (index + state.images.length) % state.images.length;
    const mainImg = document.getElementById(`mainImg_${roomId}`);
    const thumbs = document.querySelectorAll(`.thumb_${roomId}`);

    if (mainImg) {
        mainImg.src = state.images[state.currentIndex];
    }

    thumbs.forEach((thumb, idx) => {
        if (idx === state.currentIndex) {
            thumb.classList.add('active');
        } else {
            thumb.classList.remove('active');
        }
    });
}

function prevRoomPhoto(roomId) {
    const state = roomGalleryStates[roomId];
    if (state) {
        changeGalleryImage(roomId, state.currentIndex - 1);
    }
}

function nextRoomPhoto(roomId) {
    const state = roomGalleryStates[roomId];
    if (state) {
        changeGalleryImage(roomId, state.currentIndex + 1);
    }
}

function selectRoomPhoto(roomId, index) {
    changeGalleryImage(roomId, index);
}

/* ==========================================================================
   5. RATE PLAN SELECTOR & LIVE PRICE CALCULATION
   ========================================================================== */
function selectRatePlan(roomId, price, rateNameOrElem, element) {
    let rateName = 'Room Only';
    let targetEl = element;

    if (typeof rateNameOrElem === 'string') {
        rateName = rateNameOrElem;
    } else if (rateNameOrElem) {
        targetEl = rateNameOrElem;
    }

    const roomCard = document.getElementById(`card_${roomId}`);
    if (!roomCard) return;

    if (targetEl) {
        roomCard.querySelectorAll('.rate-plan-card').forEach(card => {
            card.classList.remove('active');
            const radio = card.querySelector('.rate-radio');
            if (radio) radio.checked = false;
        });

        targetEl.classList.add('active');
        const radio = targetEl.querySelector('.rate-radio');
        if (radio) radio.checked = true;

        const titleEl = targetEl.querySelector('.fw-bold');
        if (titleEl) {
            const text = titleEl.textContent.trim();
            if (text.includes('Standard')) rateName = 'Standard Rate';
            else if (text.includes('Room Only')) rateName = 'Room Only';
        }
    }

    const basePrice = parseFloat(price) || 0;
    const taxes = Math.round(basePrice * TAX_RATE * 100) / 100;
    const total = Math.round((basePrice + taxes) * 100) / 100;

    const baseEl = roomCard.querySelector('.sidebar-base-price');
    const taxEl = roomCard.querySelector('.sidebar-tax-price');
    const totalEl = roomCard.querySelector('.sidebar-total-price');
    const bookBtn = roomCard.querySelector('.sidebar-book-btn');
    const roomTitle = roomCard.querySelector('.room-title-text')?.textContent || '';

    if (baseEl) baseEl.textContent = basePrice.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    if (taxEl) taxEl.textContent = taxes.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    if (totalEl) totalEl.textContent = total.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

    if (bookBtn) {
        bookBtn.href = `Booking.aspx?room=${encodeURIComponent(roomTitle.trim())}&price=${basePrice}&rate=${encodeURIComponent(rateName)}&total=${total}`;
    }
}
window.selectRatePlan = selectRatePlan;

function toggleTaxesDisplay(showWithTaxes) {
    const totalEls = document.querySelectorAll('.sidebar-total-price');
    totalEls.forEach(el => {
        if (showWithTaxes) {
            el.style.color = '#B88E68';
        } else {
            el.style.color = '';
        }
    });
}
window.toggleTaxesDisplay = toggleTaxesDisplay;

/* ==========================================================================
   6. DOM INITIALIZATION & EVENT DELEGATION BINDINGS
   ========================================================================== */
function attachBookNowEventListeners() {
    // 1. Direct event listeners on Tab buttons (ROOM RATES & OFFERS & PACKAGES)
    const btnRates = document.getElementById('tabBtnRates');
    const btnOffers = document.getElementById('tabBtnOffers');

    if (btnRates) {
        btnRates.onclick = function (e) {
            if (e) e.preventDefault();
            switchRatesTab('rates', this);
        };
    }

    if (btnOffers) {
        btnOffers.onclick = function (e) {
            if (e) e.preventDefault();
            switchRatesTab('offers', this);
        };
    }

    // 2. Direct event listeners on Room Filter Pills (All 7 buttons)
    const filterPills = document.querySelectorAll('.bn-filter-pill');
    filterPills.forEach(function (pill) {
        pill.onclick = function (e) {
            if (e) e.preventDefault();
            const category = this.getAttribute('data-filter') || 'all';
            filterBookNowRooms(category, this);
        };
    });

    // 3. Direct event listeners on Package Filter Pills (All 5 buttons)
    const packagePills = document.querySelectorAll('.bn-package-pill');
    packagePills.forEach(function (pill) {
        pill.onclick = function (e) {
            if (e) e.preventDefault();
            const category = this.getAttribute('data-package-filter') || 'all';
            filterPackages(category, this);
        };
    });

    // 4. Default check-in/check-out dates
    const checkIn = document.getElementById('arrivalDate');
    const checkOut = document.getElementById('departureDate');

    if (checkIn && !checkIn.value) {
        const today = new Date();
        checkIn.value = today.toISOString().split('T')[0];
    }
    if (checkOut && !checkOut.value) {
        const tomorrow = new Date();
        tomorrow.setDate(tomorrow.getDate() + 1);
        checkOut.value = tomorrow.toISOString().split('T')[0];
    }

    // 5. Initialize galleries for all 6 rooms
    // initGallery('1', ['images/room-classic-double.jpg', 'images/room-superior-king.jpg']);
    // initGallery('2', ['images/room-superior-king.jpg', 'images/room-classic-double.jpg']);
    // initGallery('3', ['images/room-mini-garden.jpg', 'images/room-classic-double.jpg']);
    // initGallery('4', ['images/room-mini-family.jpg', 'images/room-classic-double.jpg']);
    // initGallery('5', ['images/room-mini-business.jpg', 'images/room-superior-king.jpg']);
    // initGallery('6', ['images/room-luxury-penthouse.jpg', 'images/room-featured-presidential.jpg']);

    // 5. Initialize galleries dynamically from RoomImages database
    document.querySelectorAll('.room-card-luxury-block').forEach(function (card) {

        const roomId = card.id.replace('card_', '');
        const galleryData = card.getAttribute('data-gallery-images');

        if (!roomId || !galleryData) return;

        try {
            const imageObjects = JSON.parse(galleryData);

            const images = imageObjects
                .map(function (item) {
                    return item.ImageUrl;
                })
                .filter(function (url) {
                    return url && url.trim() !== '';
                });

            if (images.length > 0) {
                initGallery(roomId, images);
            }

        } catch (error) {
            console.error('Gallery data error for RoomId:', roomId, error);
        }
    });
}

/* ==========================================================================
   7. LUXURY IMAGE LIGHTBOX MODAL LOGIC
   ========================================================================== */
function openImageLightbox(target, title) {
    let src = '';
    if (typeof target === 'string') {
        const el = document.getElementById(target);
        if (el && el.src) {
            src = el.src;
        } else {
            src = target;
        }
    } else if (target && target.src) {
        src = target.src;
    }

    const modal = document.getElementById('luxuryImageLightbox');
    const modalImg = document.getElementById('bnLightboxImg');
    const modalTitle = document.getElementById('bnLightboxTitle');

    if (modal && modalImg) {
        modalImg.src = src;
        if (modalTitle) {
            modalTitle.textContent = title || 'Luxury Room View';
        }
        modal.style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }
}
window.openImageLightbox = openImageLightbox;

function closeImageLightbox(e) {
    if (e && e.target && e.target.closest && e.target.closest('.bn-lightbox-content') && !e.target.closest('.bn-lightbox-close')) {
        return; // Don't close if clicked inside image content, unless clicking close button
    }
    const modal = document.getElementById('luxuryImageLightbox');
    if (modal) {
        modal.style.display = 'none';
        document.body.style.overflow = '';
    }
}
window.closeImageLightbox = closeImageLightbox;

// Keyboard Esc to close
document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' || e.keyCode === 27) {
        closeImageLightbox();
    }
});

// Attach immediately if DOM already loaded or on DOMContentLoaded
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', attachBookNowEventListeners);
} else {
    attachBookNowEventListeners();
}
