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

        <div class="address-card active">
          <div style="display: flex; justify-content: space-between; margin-bottom: 0.35rem;">
            <strong style="font-size: 1rem;"><i class="fa-solid fa-house" style="color: var(--primary);"></i> Home Address</strong>
            <span class="badge badge-offer">DEFAULT</span>
          </div>
          <p style="font-size: 0.9rem; color: var(--text-muted);">Flat 402, Jubilee Heights, Jubilee Hills, Hyderabad, Telangana 500033</p>
          <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 0.25rem;"><i class="fa-solid fa-phone"></i> +91 98765 43210</p>
        </div>

        <div class="address-card">
          <div style="margin-bottom: 0.35rem;">
            <strong style="font-size: 1rem;"><i class="fa-solid fa-briefcase" style="color: var(--text-muted);"></i> Work Office</strong>
          </div>
          <p style="font-size: 0.9rem; color: var(--text-muted);">Cyber Towers, 8th Floor, HITECH City, Hyderabad 500081</p>
        </div>

        <button class="btn btn-secondary btn-sm" onclick="if(window.CravioAuth) window.CravioAuth.openProfileModal('addresses');" style="margin-top: 0.5rem;"><i class="fa-solid fa-plus"></i> Add New Address</button>
      </div>

      <!-- STEP 2: PAYMENT METHOD -->
      <div class="summary-card">
        <h3 style="font-size: 1.25rem; margin-bottom: 1.25rem; display: flex; align-items: center; gap: 0.75rem;">
          <span style="width: 32px; height: 32px; border-radius: 50%; background: var(--primary-light); color: var(--primary); display: inline-flex; align-items: center; justify-content: center; font-size: 0.9rem;">2</span>
          Payment Method
        </h3>

        <div style="display: flex; gap: 0.75rem; flex-wrap: wrap;">
          <button class="tab-btn active" id="payUpiBtn" onclick="selectPayment('upi')"><i class="fa-solid fa-qrcode"></i> UPI (GooglePay / PhonePe / Paytm)</button>
          <button class="tab-btn" id="payCreditCardBtn" onclick="selectPayment('card')"><i class="fa-solid fa-credit-card"></i> Debit / Credit Card</button>
          <button class="tab-btn" id="payNetBtn" onclick="selectPayment('net')"><i class="fa-solid fa-building-columns"></i> Net Banking</button>
          <button class="tab-btn" id="payCodBtn" onclick="selectPayment('cod')"><i class="fa-solid fa-money-bill-wave"></i> Cash on Delivery</button>
        </div>

        <!-- UPI FORM -->
        <div class="payment-tab-content" id="paymentUpiForm">
          <div style="text-align: center; margin-bottom: 1rem;">
            <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=upi://pay?pa=cravio@upi&pn=CravioFood" alt="UPI QR" style="margin: 0 auto 0.75rem auto; border: 2px solid var(--border-color); border-radius: var(--radius-md); padding: 0.5rem;">
            <p style="font-size: 0.85rem; color: var(--text-muted);">Scan QR using any UPI App (GPay, PhonePe, Paytm)</p>
          </div>
          <div class="form-group">
            <label class="form-label">Or Enter VPA / UPI ID</label>
            <input type="text" class="form-input" placeholder="alex@upi / 9876543210@ybl" required>
          </div>
        </div>

        <!-- CARD FORM -->
        <div class="payment-tab-content" id="paymentCardForm" style="display: none;">
          <div class="form-group">
            <label class="form-label">Cardholder Name</label>
            <input type="text" class="form-input" value="Alex Morgan" required>
          </div>
          <div class="form-group">
            <label class="form-label">Card Number</label>
            <input type="text" class="form-input" value="4532 •••• •••• 8892" required>
          </div>
          <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
            <div class="form-group">
              <label class="form-label">Expiry Date</label>
              <input type="text" class="form-input" value="08/28" placeholder="MM/YY" required>
            </div>
            <div class="form-group">
              <label class="form-label">CVV Code</label>
              <input type="password" class="form-input" value="382" placeholder="123" required>
            </div>
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
  function selectPayment(type) {
    document.querySelectorAll('.payment-tab-content').forEach(el => el.style.display = 'none');
    document.querySelectorAll('.tab-btn').forEach(el => el.classList.remove('active'));
    if(type === 'upi') {
      document.getElementById('paymentUpiForm').style.display = 'block';
      document.getElementById('payUpiBtn').classList.add('active');
    } else if(type === 'card') {
      document.getElementById('paymentCardForm').style.display = 'block';
      document.getElementById('payCreditCardBtn').classList.add('active');
    } else {
      window.CravioToast('Selected ' + type.toUpperCase() + ' payment method', 'info');
    }
  }

  function placeOrderAnimation() {
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
</script>
