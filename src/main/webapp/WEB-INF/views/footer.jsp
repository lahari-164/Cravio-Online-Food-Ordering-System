<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- =========================================================
     CRAVIO MODERN FOOTER COMPONENT WITH WORKING POLICY MODALS
     ========================================================= --%>
<footer class="cravio-footer">
  <div class="container">
    <div class="footer-grid">
      <%-- Brand Column --%>
      <div class="footer-brand">
        <a href="${pageContext.request.contextPath}/" class="nav-logo">
          <div class="nav-logo-icon"><i class="fa-solid fa-utensils"></i></div>
          <span>Cravio</span>
        </a>
        <p>Experience gourmet dining delivered to your doorstep. Powered by passion, freshness, and technology.</p>
        <div class="social-links">
          <a href="https://instagram.com" target="_blank" class="social-link" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
          <a href="https://facebook.com" target="_blank" class="social-link" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
          <a href="https://linkedin.com" target="_blank" class="social-link" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
          <a href="https://twitter.com" target="_blank" class="social-link" aria-label="Twitter"><i class="fa-brands fa-x-twitter"></i></a>
          <a href="https://github.com" target="_blank" class="social-link" aria-label="GitHub"><i class="fa-brands fa-github"></i></a>
        </div>
      </div>

      <%-- Column 1: Company --%>
      <div>
        <h4 class="footer-title">Company</h4>
        <div class="footer-links">
          <a href="${pageContext.request.contextPath}/about">About Us</a>
          <a href="javascript:void(0)" onclick="openFooterModal('Careers at Cravio', 'We are hiring software engineers, culinary specialists, and logistics coordinators! Send your CV to careers@cravio.com.')">Careers</a>
          <a href="${pageContext.request.contextPath}/restaurants">Restaurants</a>
          <a href="javascript:void(0)" onclick="openFooterModal('Become a Restaurant Partner', 'Partner with Cravio to expand your reach. Fill out our partnership inquiry form on the Contact page or email partners@cravio.com.')">Become a Partner</a>
          <a href="${pageContext.request.contextPath}/about#journey">Our Story</a>
        </div>
      </div>

      <%-- Column 2: Quick Links --%>
      <div>
        <h4 class="footer-title">Quick Links</h4>
        <div class="footer-links">
          <a href="${pageContext.request.contextPath}/restaurants">Trending Dishes</a>
          <a href="${pageContext.request.contextPath}/cart">View Cart</a>
          <a href="${pageContext.request.contextPath}/orders" class="orders-footer-link" style="display: none;">My Orders</a>
          <a href="${pageContext.request.contextPath}/track-order">Track Order</a>
          <a href="${pageContext.request.contextPath}/contact#faq">FAQs</a>
          <a href="${pageContext.request.contextPath}/contact">Help & Support</a>
        </div>
      </div>

      <%-- Column 3: Legal & Support --%>
      <div>
        <h4 class="footer-title">Support & Policies</h4>
        <div class="footer-links">
          <a href="javascript:void(0)" onclick="openFooterModal('Privacy Policy', 'Cravio values your privacy. We collect minimal personal data solely to process food orders, provide real-time GPS tracking, and optimize user experience. Your data is encrypted and never sold to third parties.')">Privacy Policy</a>
          <a href="javascript:void(0)" onclick="openFooterModal('Terms of Service', 'By using Cravio, you agree to our platform terms. Orders placed cannot be cancelled once cooking has commenced. Prices are inclusive of applicable taxes.')">Terms of Service</a>
          <a href="javascript:void(0)" onclick="openFooterModal('Refund & Cancellation Policy', 'Full refunds are issued if an order is cancelled before restaurant acceptance or if delivery is delayed beyond 45 minutes due to Cravio fault. Refunds process back to original payment within 3-5 business days.')">Refund & Cancellation</a>
          <a href="javascript:void(0)" onclick="openFooterModal('Cookie Policy', 'Cravio uses essential cookies to remember your light/dark theme preference and shopping cart items. Optional analytics cookies help us improve performance.')">Cookie Policy</a>
          <a href="javascript:void(0)" onclick="openFooterModal('Security Standard', 'All payment transactions on Cravio are PCI-DSS Level 1 compliant with 256-bit SSL encryption.')">Security</a>
        </div>
      </div>

      <%-- Column 4: Newsletter --%>
      <div>
        <h4 class="footer-title">Newsletter</h4>
        <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 0.75rem;">Get exclusive discount codes and weekly culinary recommendations.</p>
        <form onsubmit="event.preventDefault(); window.CravioToast('Subscribed to Cravio newsletter!', 'success');" class="newsletter-box">
          <input type="email" placeholder="Your email address" class="newsletter-input" required>
          <button type="submit" class="btn btn-primary btn-sm"><i class="fa-solid fa-paper-plane"></i></button>
        </form>
      </div>
    </div>

    <%-- Footer Bottom Bar --%>
    <div class="footer-bottom">
      <p>&copy; 2026 Cravio Inc. All rights reserved. Premium Food Delivery Platform.</p>
      <div style="display: flex; gap: 1.5rem;">
        <a href="javascript:void(0)" onclick="openFooterModal('Privacy Policy', 'Cravio encrypts and protects all user data.')">Privacy</a>
        <a href="javascript:void(0)" onclick="openFooterModal('Terms of Service', 'Platform usage terms apply.')">Terms</a>
        <a href="javascript:void(0)" onclick="openFooterModal('Cookie Policy', 'Cookies are used for cart and theme preferences.')">Cookies</a>
      </div>
    </div>
  </div>
</footer>

<%-- Global Floating Chat Widget --%>
<button class="chat-widget-trigger" id="chatWidgetTrigger" title="Chat with Cravio Concierge">
  <i class="fa-solid fa-comments"></i>
</button>

<div class="chat-drawer" id="chatDrawer">
  <div class="chat-header">
    <div style="display: flex; align-items: center; gap: 0.6rem;">
      <div style="width: 10px; height: 10px; border-radius: 50%; background: #10B981;"></div>
      <strong style="font-size: 0.95rem;">Cravio Concierge AI</strong>
    </div>
    <button id="chatCloseBtn" style="color: #FFF; font-size: 1.1rem;"><i class="fa-solid fa-xmark"></i></button>
  </div>
  <div class="chat-body" id="chatBody">
    <div class="chat-msg bot">
      Hello! Welcome to Cravio. How can I help you find gourmet meals or track your order today?
    </div>
  </div>
  <div class="chat-footer">
    <input type="text" id="chatInput" placeholder="Type your message..." class="chat-input">
    <button id="chatSendBtn" class="btn btn-primary btn-sm btn-icon"><i class="fa-solid fa-paper-plane"></i></button>
  </div>
</div>

<%-- Global Policy Modal --%>
<div class="modal-overlay" id="footerPolicyModalOverlay">
  <div class="modal-card">
    <button class="modal-close" onclick="closeFooterModal()"><i class="fa-solid fa-xmark"></i></button>
    <h3 style="font-size: 1.3rem; margin-bottom: 1rem;" id="footerPolicyTitle">Policy</h3>
    <div style="color: var(--text-muted); font-size: 0.95rem; line-height: 1.7;" id="footerPolicyContent"></div>
    <button class="btn btn-primary" style="width: 100%; margin-top: 1.5rem;" onclick="closeFooterModal()">Close</button>
  </div>
</div>

<%-- Global Back To Top Button --%>
<button class="back-to-top" id="backToTopBtn" title="Back to Top">
  <i class="fa-solid fa-arrow-up"></i>
</button>

<%-- Include Auth Modal & Profile Modal --%>
<%@ include file="auth-modal.jsp" %>
<%@ include file="profile-modal.jsp" %>

<%-- Scripts --%>
<script src="${pageContext.request.contextPath}/js/restaurant-data.js"></script>
<script src="${pageContext.request.contextPath}/js/delivery-data.js"></script>
<script src="${pageContext.request.contextPath}/js/auth-engine.js"></script>
<script src="${pageContext.request.contextPath}/js/filter-engine.js"></script>
<script src="${pageContext.request.contextPath}/js/cart-store.js"></script>
<script src="${pageContext.request.contextPath}/js/slider.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
  function openFooterModal(title, content) {
    document.getElementById('footerPolicyTitle').textContent = title;
    document.getElementById('footerPolicyContent').textContent = content;
    document.getElementById('footerPolicyModalOverlay').classList.add('active');
  }

  function closeFooterModal() {
    document.getElementById('footerPolicyModalOverlay').classList.remove('active');
  }
</script>
