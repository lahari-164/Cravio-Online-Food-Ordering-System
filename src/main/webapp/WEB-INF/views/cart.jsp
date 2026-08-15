<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "Shopping Cart");
    request.setAttribute("activePage", "cart");
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<section class="container">
  <div style="padding: 2.5rem 0 1rem 0;">
    <h1 style="font-size: 2.25rem;">Your Culinary Cart</h1>
    <p style="color: var(--text-muted);">Review your selected gourmet dishes before checkout.</p>
  </div>

  <div class="cart-grid">
    <!-- CART ITEMS LIST CARD -->
    <div class="cart-table-card">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; padding-bottom: 1rem; border-bottom: 1px solid var(--border-color);">
        <h3 style="font-size: 1.25rem;">Selected Items</h3>
        <button style="color: var(--primary); font-size: 0.85rem; font-weight: 600;" onclick="localStorage.removeItem('cravio_cart_data'); location.reload();">Clear All</button>
      </div>

      <div id="cartItemsList">
      </div>
    </div>

    <!-- CART SUMMARY & PROMO CARD -->
    <div>
      <div class="summary-card" style="margin-bottom: 1.5rem;">
        <h3 style="font-size: 1.2rem; margin-bottom: 1rem;">Apply Coupon</h3>
        <div style="display: flex; gap: 0.5rem;">
          <input type="text" id="couponInput" placeholder="Enter CRAVIO20" class="form-input" style="text-transform: uppercase;">
          <button class="btn btn-secondary" onclick="CravioCart.applyCoupon(document.getElementById('couponInput').value)">Apply</button>
        </div>
        <div style="font-size: 0.8rem; color: var(--accent-green); margin-top: 0.5rem; font-weight: 600;">
          <i class="fa-solid fa-circle-info"></i> Available: CRAVIO20 (20% OFF) or FREEDEL
        </div>
      </div>

      <div class="summary-card">
        <h3 style="font-size: 1.2rem; margin-bottom: 1.25rem;">Order Summary</h3>
        <div class="summary-row">
          <span>Subtotal</span>
          <strong id="cartSubtotal">$0.00</strong>
        </div>
        <div class="summary-row">
          <span>Estimated Tax (8%)</span>
          <span id="cartTax">$0.00</span>
        </div>
        <div class="summary-row">
          <span>Delivery Fee</span>
          <span id="cartDelivery">$2.99</span>
        </div>
        <div class="summary-row" style="color: var(--accent-green);">
          <span>Promo Discount</span>
          <span id="cartDiscount">-$0.00</span>
        </div>

        <div class="summary-total" style="display: flex; justify-content: space-between;">
          <span>Grand Total</span>
          <span id="cartGrandTotal" style="color: var(--primary);">$0.00</span>
        </div>

        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-lg" style="width: 100%; margin-top: 1.5rem;">
          Proceed to Checkout <i class="fa-solid fa-arrow-right"></i>
        </a>
      </div>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
