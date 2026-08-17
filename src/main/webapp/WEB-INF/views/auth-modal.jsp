<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- =========================================================
     CRAVIO AUTHENTICATION MODAL COMPONENT (LOGIN / SIGN UP)
     ========================================================= --%>
<div class="modal-overlay" id="authModalOverlay">
  <div class="modal-card" id="authModal" style="max-width: 440px;">
    <button class="modal-close" id="authModalClose"><i class="fa-solid fa-xmark"></i></button>

    <%-- Required Message Banner --%>
    <div id="authRequiredBanner" style="display: none; background: var(--primary-light); color: var(--primary); padding: 0.75rem 1rem; border-radius: var(--radius-md); font-size: 0.85rem; font-weight: 700; text-align: center; margin-bottom: 1.25rem;">
      Please login or create an account to continue ordering.
    </div>

    <%-- Tab Header --%>
    <div class="auth-tabs" style="display: flex; gap: 1rem; border-bottom: 1px solid var(--border-color); margin-bottom: 1.5rem;">
      <button class="tab-btn active" id="tabLogin" style="flex: 1; padding-bottom: 0.75rem; font-size: 1.1rem; font-weight: 700;">Login</button>
      <button class="tab-btn" id="tabSignup" style="flex: 1; padding-bottom: 0.75rem; font-size: 1.1rem; font-weight: 700;">Sign Up</button>
    </div>

    <%-- LOGIN FORM --%>
    <form id="formLogin" style="display: block;" autocomplete="off">
      <div class="form-group">
        <label class="form-label">Email Address or Phone</label>
        <input
          type="email"
          class="form-input"
          placeholder="e.g. rohan.sharma@example.com"
          autocomplete="off"
          required>
      </div>

      <div class="form-group">
        <div style="display: flex; justify-content: space-between; margin-bottom: 0.35rem;">
          <label class="form-label">Password</label>
          <a href="#" style="font-size: 0.8rem; color: var(--primary);">Forgot?</a>
        </div>
        <input
          type="password"
          class="form-input"
          placeholder="••••••••"
          autocomplete="new-password"
          required>
      </div>

      <button type="submit" class="btn btn-primary btn-lg" style="width: 100%; margin-top: 1rem;">
        Login & Continue <i class="fa-solid fa-arrow-right"></i>
      </button>
    </form>

    <%-- SIGN UP FORM --%>
    <form id="formSignup" style="display: none;" autocomplete="off">
      <div class="form-group">
        <label class="form-label">Full Name</label>
        <input
          type="text"
          class="form-input"
          placeholder="e.g. Rahul Sharma"
          autocomplete="off"
          required>
      </div>

      <div class="form-group">
        <label class="form-label">Email Address</label>
        <input
          type="email"
          class="form-input"
          placeholder="rahul@example.com"
          autocomplete="off"
          required>
      </div>

      <div class="form-group">
        <label class="form-label">Mobile Phone Number</label>
        <input
          type="tel"
          class="form-input"
          placeholder="+91 98765 43210"
          autocomplete="off"
          required>
      </div>

      <div class="form-group">
        <label class="form-label">Create Password</label>
        <input
          type="password"
          class="form-input"
          placeholder="••••••••"
          autocomplete="new-password"
          required>
      </div>

      <button type="submit" class="btn btn-primary btn-lg" style="width: 100%; margin-top: 1rem;">
        Create Account & Login <i class="fa-solid fa-arrow-right"></i>
      </button>
    </form>
  </div>
</div>