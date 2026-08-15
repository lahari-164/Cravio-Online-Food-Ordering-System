<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "Checkout");
    request.setAttribute("activePage", "cart");
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<section class="container">
  <div style="padding: 2.5rem 0 1rem 0;">
    <h1 style="font-size: 2.25rem;">Secure Checkout</h1>
    <p style="color: var(--text-muted);">Choose delivery address and payment method.</p>
  </div>

  <div class="checkout-grid">
    <div>
      <!-- STEP 1: ADDRESS -->
      <div class="summary-card" style="margin-bottom: 2rem;">
        <h3 style="font-size: 1.25rem; margin-bottom: 1.25rem; display: flex; align-items: center; gap: 0.75rem;">
          <span style="width: 32px; height: 32px; border-radius: 50%; background: var(--primary-light); color: var(--primary); display: inline-flex; align-items: center; justify-content: center; font-size: 0.9rem;">1</span>
          Select Delivery Address
        </h3>

        <div id="checkoutAddressList" class="address-list" aria-live="polite"></div>
        <div id="checkoutAddressError" class="field-error">Please select a delivery address.</div>

        <button class="btn btn-secondary btn-sm" onclick="if(window.CravioAuth) window.CravioAuth.openProfileModal('addresses');" style="margin-top: 0.5rem;"><i class="fa-solid fa-plus"></i> Add New Address</button>
      </div>

      <!-- STEP 2: PAYMENT METHOD -->
      <div class="summary-card">
        <h3 style="font-size: 1.25rem; margin-bottom: 1.25rem; display: flex; align-items: center; gap: 0.75rem;">
          <span style="width: 32px; height: 32px; border-radius: 50%; background: var(--primary-light); color: var(--primary); display: inline-flex; align-items: center; justify-content: center; font-size: 0.9rem;">2</span>
          Payment Method
        </h3>

        <div class="payment-method-grid">
          <button type="button" class="tab-btn" id="payUpiBtn" onclick="selectPayment('upi')"><i class="fa-solid fa-qrcode"></i> UPI (GooglePay / PhonePe / Paytm)</button>
          <button type="button" class="tab-btn" id="payCreditCardBtn" onclick="selectPayment('card')"><i class="fa-solid fa-credit-card"></i> Debit / Credit Card</button>
          <button type="button" class="tab-btn" id="payNetBtn" onclick="selectPayment('net')"><i class="fa-solid fa-building-columns"></i> Net Banking</button>
          <button type="button" class="tab-btn" id="payCodBtn" onclick="selectPayment('cod')"><i class="fa-solid fa-money-bill-wave"></i> Cash on Delivery</button>
        </div>

        <div id="paymentMethodError" class="field-error">Please choose a payment method and fill the required details.</div>

        <div class="payment-tab-content" id="paymentUpiForm" style="display: none;">
          <div style="text-align: center; margin-bottom: 1rem;">
            <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=upi://pay?pa=cravio@upi&pn=CravioFood" alt="UPI QR" style="margin: 0 auto 0.75rem auto; border: 2px solid var(--border-color); border-radius: var(--radius-md); padding: 0.5rem;">
            <p style="font-size: 0.85rem; color: var(--text-muted);">Scan QR using any UPI App (GPay, PhonePe, Paytm)</p>
          </div>
          <div class="form-group">
            <label class="form-label">Or Enter VPA / UPI ID</label>
            <input id="upiIdInput" type="text" class="form-input" placeholder="alex@upi / 9876543210@ybl" autocomplete="off">
          </div>
        </div>

        <div class="payment-tab-content" id="paymentCardForm" style="display: none;">
          <div class="form-group">
            <label class="form-label">Cardholder Name</label>
            <input id="cardNameInput" type="text" class="form-input" placeholder="Enter cardholder name" autocomplete="cc-name">
          </div>
          <div class="form-group">
            <label class="form-label">Card Number</label>
            <input id="cardNumberInput" type="text" class="form-input" placeholder="1234 5678 9012 3456" inputmode="numeric" autocomplete="cc-number">
          </div>
          <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
            <div class="form-group">
              <label class="form-label">Expiry Date</label>
              <input id="cardExpiryInput" type="text" class="form-input" placeholder="MM/YY" autocomplete="cc-exp">
            </div>
            <div class="form-group">
              <label class="form-label">CVV Code</label>
              <input id="cardCvvInput" type="password" class="form-input" placeholder="123" autocomplete="cc-csc">
            </div>
          </div>
        </div>

        <div class="payment-tab-content" id="paymentNetForm" style="display: none;">
          <div class="form-group">
            <label class="form-label">Select Bank</label>
            <select id="netBankInput" class="form-input">
              <option value="">Choose your bank</option>
              <option value="HDFC">HDFC Bank</option>
              <option value="ICICI">ICICI Bank</option>
              <option value="SBI">State Bank of India</option>
              <option value="Axis">Axis Bank</option>
            </select>
          </div>
        </div>
      </div>
    </div>

    <!-- ORDER SUMMARY & PLACE ORDER BUTTON -->
    <div>
      <div class="summary-card">
        <h3 style="font-size: 1.25rem; margin-bottom: 1.25rem;">Order Details</h3>
        
        <div style="border-bottom: 1px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 1rem;">
          <div style="display: flex; justify-content: space-between; font-size: 0.9rem; margin-bottom: 0.5rem;">
            <span>Hyderabadi Dum Biryani x 2</span>
            <strong>₹760</strong>
          </div>
          <div style="display: flex; justify-content: space-between; font-size: 0.9rem;">
            <span>Dal Makhani x 1</span>
            <strong>₹340</strong>
          </div>
        </div>

        <div class="summary-row">
          <span>Subtotal</span>
          <strong id="cartSubtotal">₹1100</strong>
        </div>
        <div class="summary-row">
          <span>Delivery Fee</span>
          <span id="cartDelivery">₹50</span>
        </div>
        <div class="summary-row">
          <span>GST Taxes (5%)</span>
          <span id="cartTax">₹55</span>
        </div>
        
        <div class="summary-total" style="display: flex; justify-content: space-between;">
          <span>Total Payable</span>
          <span id="cartGrandTotal" style="color: var(--primary);">₹1205</span>
        </div>

        <button onclick="placeOrderAnimation()" class="btn btn-primary btn-lg" style="width: 100%; margin-top: 1.5rem;" id="btnPlaceOrder">
          <i class="fa-solid fa-lock"></i> Place Order (₹1205)
        </button>
      </div>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>

<script>
  let selectedAddressId = null;
  let selectedPaymentMethod = null;

  function showAddressError(show) {
    const error = document.getElementById('checkoutAddressError');
    if (error) error.classList.toggle('visible', show);
  }

  function showPaymentError(show) {
    const error = document.getElementById('paymentMethodError');
    if (error) error.classList.toggle('visible', show);
  }

  function renderCheckoutAddresses() {
    const listEl = document.getElementById('checkoutAddressList');
    if (!listEl) return;

    const addresses = window.CravioAuth && window.CravioAuth.getAddresses ? window.CravioAuth.getAddresses() : [];
    listEl.innerHTML = '';

    if (!addresses.length) {
      listEl.innerHTML = '<div class="address-card" style="border-style: dashed; opacity: 0.9;"><strong style="font-size: 1rem;">No saved addresses yet</strong><p style="font-size: 0.9rem; color: var(--text-muted); margin-top: 0.5rem;">Add a delivery address to continue.</p></div>';
      selectedAddressId = null;
      showAddressError(false);
      return;
    }

    addresses.forEach((addr) => {
      const card = document.createElement('button');
      const isWorkAddress = addr.tag === 'WORK';
      const iconClass = isWorkAddress ? 'fa-briefcase' : 'fa-house';
      const defaultBadge = addr.isDefault ? '<span class="badge badge-offer">DEFAULT</span>' : '';

      card.type = 'button';
      card.className = 'address-card' + (selectedAddressId === addr.id ? ' selected' : '');
      card.setAttribute('data-address-id', String(addr.id));
      card.style.display = 'block';
      card.style.textAlign = 'left';
      card.style.width = '100%';
      card.style.padding = '1.1rem 1.25rem';
      card.innerHTML =
        '<div style="display: flex; justify-content: space-between; align-items: center; gap: 0.5rem; margin-bottom: 0.4rem;">' +
        '  <strong style="font-size: 1rem; display: flex; align-items: center; gap: 0.5rem;">' +
        '    <i class="fa-solid ' + iconClass + '" style="color: var(--primary);"></i> ' + (addr.title || 'Delivery Address') +
        '  </strong>' +
        defaultBadge +
        '</div>' +
        '<p style="font-size: 0.9rem; color: var(--text-muted); margin: 0;">' + (addr.street || '') + ', ' + (addr.city || '') + ', ' + (addr.zipcode || '') + '</p>';

      card.addEventListener('click', () => {
        selectedAddressId = addr.id;
        renderCheckoutAddresses();
        showAddressError(false);
      });
      listEl.appendChild(card);
    });
  }

  function selectPayment(type) {
    selectedPaymentMethod = type;
    const paymentForms = {
      upi: document.getElementById('paymentUpiForm'),
      card: document.getElementById('paymentCardForm'),
      net: document.getElementById('paymentNetForm')
    };

    Object.values(paymentForms).forEach((form) => {
      if (form) form.style.display = 'none';
    });

    document.querySelectorAll('.tab-btn').forEach((button) => button.classList.remove('active'));
    showPaymentError(false);

    if (type === 'upi' && paymentForms.upi) {
      paymentForms.upi.style.display = 'block';
      document.getElementById('payUpiBtn').classList.add('active');
    } else if (type === 'card' && paymentForms.card) {
      paymentForms.card.style.display = 'block';
      document.getElementById('payCreditCardBtn').classList.add('active');
    } else if (type === 'net' && paymentForms.net) {
      paymentForms.net.style.display = 'block';
      document.getElementById('payNetBtn').classList.add('active');
    } else if (type === 'cod') {
      document.getElementById('payCodBtn').classList.add('active');
    }
  }

  function validateCheckoutForm() {
    let isValid = true;

    if (!selectedAddressId) {
      showAddressError(true);
      isValid = false;
    } else {
      showAddressError(false);
    }

    if (!selectedPaymentMethod) {
      showPaymentError(true);
      return false;
    }

    if (selectedPaymentMethod === 'upi') {
      const upi = document.getElementById('upiIdInput')?.value.trim();
      if (!upi) {
        showPaymentError(true);
        return false;
      }
    }

    if (selectedPaymentMethod === 'card') {
      const cardName = document.getElementById('cardNameInput')?.value.trim();
      const cardNumber = document.getElementById('cardNumberInput')?.value.trim();
      const cardExpiry = document.getElementById('cardExpiryInput')?.value.trim();
      const cardCvv = document.getElementById('cardCvvInput')?.value.trim();
      if (!cardName || !cardNumber || !cardExpiry || !cardCvv) {
        showPaymentError(true);
        return false;
      }
    }

    if (selectedPaymentMethod === 'net') {
      const bank = document.getElementById('netBankInput')?.value.trim();
      if (!bank) {
        showPaymentError(true);
        return false;
      }
    }

    showPaymentError(false);
    return isValid;
  }

  function placeOrderAnimation() {
    if (!validateCheckoutForm()) {
      return;
    }

    const btn = document.getElementById('btnPlaceOrder');
    btn.disabled = true;
    btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Processing Payment...';
    setTimeout(() => {
      window.CravioToast('Order placed successfully! Redirecting to live tracking...', 'success');
      setTimeout(() => {
        window.location.href = '${pageContext.request.contextPath}/track-order';
      }, 1200);
    }, 1500);
  }

  document.addEventListener('DOMContentLoaded', () => {
    renderCheckoutAddresses();
    if (window.CravioAuth && window.CravioAuth.getAddresses) {
      window.addEventListener('cravio:addresses-updated', renderCheckoutAddresses);
    }
  });

  window.renderCheckoutAddresses = renderCheckoutAddresses;
</script>
