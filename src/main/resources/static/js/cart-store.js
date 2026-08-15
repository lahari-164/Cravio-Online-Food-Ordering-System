/* ==========================================================================
   CRAVIO CART ENGINE & SINGLE-RESTAURANT RESTRICTION ENGINE
   Requires login before ordering, preserves item, enforces single restaurant
   ========================================================================== */

(function () {
  'use strict';

  const STORAGE_KEY = 'cravio_cart_data';

  let cart = JSON.parse(localStorage.getItem(STORAGE_KEY)) || [
    { id: 'd-101', name: 'Hyderabadi Chicken Dum Biryani', price: 380, qty: 2, image: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=400&q=80', restaurant: 'Hyderabad Biryani House', restaurantId: 'rest-1' }
  ];

  let pendingItemToAdd = null;
  let appliedCoupon = null;

  function saveCart() {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(cart));
    updateBadges();
    renderCartSummary();
  }

  function getCartCount() {
    return cart.reduce((sum, item) => sum + item.qty, 0);
  }

  function getSubtotal() {
    return cart.reduce((sum, item) => sum + (item.price * item.qty), 0);
  }

  function updateBadges() {
    const badges = document.querySelectorAll('.cart-badge');
    const count = getCartCount();
    badges.forEach(b => {
      b.textContent = count;
      b.style.display = count > 0 ? 'flex' : 'none';
    });
  }

  function getCurrentCartRestaurant() {
    if (cart.length === 0) return null;
    return cart[0].restaurant;
  }

  function addItem(item) {
    // REQUIRE LOGIN FIRST!
    if (window.CravioAuth && !window.CravioAuth.isLoggedIn()) {
      window.CravioAuth.requireLogin(() => {
        addItem(item);
      });
      return false;
    }

    const currentRest = getCurrentCartRestaurant();

    // Check if cart has items from a DIFFERENT restaurant
    if (currentRest && item.restaurant && currentRest.toLowerCase() !== item.restaurant.toLowerCase()) {
      pendingItemToAdd = item;
      showRestaurantConflictModal(currentRest, item.restaurant);
      return false;
    }

    // Otherwise add item normally
    const existing = cart.find(i => i.id === item.id);
    if (existing) {
      existing.qty += (item.qty || 1);
    } else {
      cart.push({
        id: item.id || 'dish-' + Date.now(),
        name: item.name || 'Delicious Dish',
        price: parseFloat(item.price) || 250,
        qty: item.qty || 1,
        image: item.image || 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
        restaurant: item.restaurant || 'Cravio Kitchen',
        restaurantId: item.restaurantId || ''
      });
    }
    saveCart();
    if (window.CravioToast) {
      window.CravioToast(`Added "${item.name}" to your cart!`, 'success');
    }
    return true;
  }

  function showRestaurantConflictModal(existingRest, newRest) {
    let overlay = document.getElementById('cartConflictModalOverlay');
    if (!overlay) {
      overlay = document.createElement('div');
      overlay.id = 'cartConflictModalOverlay';
      overlay.className = 'modal-overlay';
      overlay.innerHTML = `
        <div class="modal-card" style="text-align: center; max-width: 480px;">
          <div style="width: 60px; height: 60px; border-radius: 50%; background: var(--primary-light); color: var(--primary); display: flex; align-items: center; justify-content: center; font-size: 1.75rem; margin: 0 auto 1.25rem auto;">
            <i class="fa-solid fa-triangle-exclamation"></i>
          </div>
          <h3 style="font-size: 1.35rem; margin-bottom: 0.75rem;">Items from another restaurant</h3>
          <p style="color: var(--text-muted); font-size: 0.95rem; line-height: 1.6; margin-bottom: 1.5rem;" id="conflictMsgText"></p>
          <div style="display: flex; flex-direction: column; gap: 0.75rem;">
            <button class="btn btn-primary" onclick="CravioCart.clearCartAndAddPending()"><i class="fa-solid fa-trash-can"></i> Clear Cart & Continue</button>
            <button class="btn btn-secondary" onclick="CravioCart.cancelPendingAdd()">Keep Existing Cart</button>
          </div>
        </div>
      `;
      document.body.appendChild(overlay);
    }

    const msgEl = document.getElementById('conflictMsgText');
    if (msgEl) {
      msgEl.innerHTML = `Your cart already contains items from <strong>${existingRest}</strong>.<br><br>To order from <strong>${newRest}</strong>, please clear your current cart first.`;
    }
    overlay.classList.add('active');
  }

  function clearCartAndAddPending() {
    cart = [];
    const overlay = document.getElementById('cartConflictModalOverlay');
    if (overlay) overlay.classList.remove('active');
    if (pendingItemToAdd) {
      const item = pendingItemToAdd;
      pendingItemToAdd = null;
      addItem(item);
    }
  }

  function cancelPendingAdd() {
    pendingItemToAdd = null;
    const overlay = document.getElementById('cartConflictModalOverlay');
    if (overlay) overlay.classList.remove('active');
    if (window.CravioToast) window.CravioToast('Kept items in existing cart.', 'info');
  }

  function removeItem(id) {
    const item = cart.find(i => i.id === id);
    cart = cart.filter(i => i.id !== id);
    saveCart();
    if (item && window.CravioToast) {
      window.CravioToast(`Removed "${item.name}" from cart`, 'info');
    }
  }

  function updateQty(id, delta) {
    const item = cart.find(i => i.id === id);
    if (!item) return;
    item.qty += delta;
    if (item.qty <= 0) {
      removeItem(id);
    } else {
      saveCart();
    }
  }

  function applyCoupon(code) {
    const clean = code.trim().toUpperCase();
    if (clean === 'CRAVIO20') {
      appliedCoupon = { code: 'CRAVIO20', discountPercent: 20 };
      saveCart();
      if (window.CravioToast) window.CravioToast('Promo code CRAVIO20 applied! (20% OFF)', 'success');
      return true;
    } else if (clean === 'FREEDEL') {
      appliedCoupon = { code: 'FREEDEL', freeDelivery: true };
      saveCart();
      if (window.CravioToast) window.CravioToast('Free Delivery Applied!', 'success');
      return true;
    } else {
      if (window.CravioToast) window.CravioToast('Invalid coupon code. Try "CRAVIO20"', 'error');
      return false;
    }
  }

  function renderCartSummary() {
    const subtotalEl = document.getElementById('cartSubtotal');
    const taxEl = document.getElementById('cartTax');
    const delEl = document.getElementById('cartDelivery');
    const discountEl = document.getElementById('cartDiscount');
    const grandEl = document.getElementById('cartGrandTotal');

    const subtotal = getSubtotal();
    const delivery = (appliedCoupon && appliedCoupon.freeDelivery) || subtotal === 0 ? 0 : 50;
    const tax = subtotal * 0.05;
    let discount = 0;

    if (appliedCoupon && appliedCoupon.discountPercent) {
      discount = subtotal * (appliedCoupon.discountPercent / 100);
    }

    const grandTotal = Math.max(0, subtotal + delivery + tax - discount);

    if (subtotalEl) subtotalEl.textContent = `₹${subtotal.toFixed(0)}`;
    if (taxEl) taxEl.textContent = `₹${tax.toFixed(0)}`;
    if (delEl) delEl.textContent = delivery === 0 ? 'FREE' : `₹${delivery.toFixed(0)}`;
    if (discountEl) discountEl.textContent = `-₹${discount.toFixed(0)}`;
    if (grandEl) grandEl.textContent = `₹${grandTotal.toFixed(0)}`;

    const listEl = document.getElementById('cartItemsList');
    if (listEl) {
      if (cart.length === 0) {
        listEl.innerHTML = `
          <div style="text-align: center; padding: 2.5rem 1rem;">
            <i class="fa-solid fa-basket-shopping" style="font-size: 2.5rem; color: var(--text-muted); margin-bottom: 0.75rem;"></i>
            <h4 style="font-size: 1.05rem; font-weight: 700;">Your cart is empty</h4>
            <p style="color: var(--text-muted); font-size: 0.85rem; margin-top: 0.25rem;">Explore top restaurants to order!</p>
          </div>
        `;
      } else {
        listEl.innerHTML = cart.map(item => `
          <div style="padding: 0.85rem 0; border-bottom: 1px solid var(--border-color); display: flex; flex-direction: column; gap: 0.5rem;">
            <div style="display: flex; gap: 0.75rem; align-items: flex-start;">
              <img src="${item.image}" alt="${item.name}" style="width: 48px; height: 48px; border-radius: 10px; object-fit: cover; flex-shrink: 0;">
              <div style="flex-grow: 1; min-width: 0;">
                <h4 style="font-size: 0.9rem; font-weight: 700; color: var(--text-main); margin-bottom: 0.15rem; line-height: 1.3;">${item.name}</h4>
                <div style="font-size: 0.75rem; color: var(--text-muted);">${item.restaurant}</div>
              </div>
              <button onclick="CravioCart.removeItem('${item.id}')" style="color: var(--text-muted); font-size: 0.85rem; padding: 4px; border: none; background: transparent; cursor: pointer;" title="Remove"><i class="fa-solid fa-trash-can"></i></button>
            </div>
            
            <div style="display: flex; justify-content: space-between; align-items: center; padding-left: 56px;">
              <div style="font-size: 0.9rem; font-weight: 800; color: var(--primary);">₹${(item.price * item.qty).toFixed(0)}</div>
              
              <div class="qty-control" style="padding: 2px 6px; gap: 0.35rem; border-radius: 20px;">
                <button class="qty-btn" style="width: 22px; height: 22px; font-size: 0.7rem;" onclick="CravioCart.updateQty('${item.id}', -1)"><i class="fa-solid fa-minus"></i></button>
                <span class="qty-val" style="font-size: 0.85rem; min-width: 14px; text-align: center;">${item.qty}</span>
                <button class="qty-btn" style="width: 22px; height: 22px; font-size: 0.7rem;" onclick="CravioCart.updateQty('${item.id}', 1)"><i class="fa-solid fa-plus"></i></button>
              </div>
            </div>
          </div>
        `).join('');
      }
    }
  }

  document.addEventListener('DOMContentLoaded', () => {
    saveCart();
  });

  window.CravioCart = {
    getCart: () => cart,
    addItem,
    removeItem,
    updateQty,
    applyCoupon,
    getSubtotal,
    getCartCount,
    saveCart,
    clearCartAndAddPending,
    cancelPendingAdd
  };
})();
