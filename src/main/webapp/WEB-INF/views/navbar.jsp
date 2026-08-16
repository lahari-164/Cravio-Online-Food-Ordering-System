<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String activePage = (String) request.getAttribute("activePage");
    if (activePage == null) activePage = "";
%>
<%-- =========================================================
     CRAVIO STICKY NAVIGATION BAR WITH EXPANDABLE LIVE SEARCH
     ========================================================= --%>
<header class="cravio-navbar">
  <div class="container nav-container">
    <%-- Logo --%>
    <a href="${pageContext.request.contextPath}/" class="nav-logo">
      <div class="nav-logo-icon">
        <i class="fa-solid fa-utensils"></i>
      </div>
      <span>Cravio</span>
    </a>

    <%-- Location Selector Button --%>
    <button class="nav-location-btn" id="navLocationBtn" onclick="openLocationModal()">
      <i class="fa-solid fa-location-dot"></i>
      <span id="currentLocDisplay" class="location-text">Jubilee Hills, Hyderabad</span>
      <i class="fa-solid fa-chevron-down" class="location-chevron"></i>
    </button>

    <%-- Main Navigation Links --%>
    <nav class="nav-links">
      <a href="${pageContext.request.contextPath}/" class="nav-link <%= "home".equals(activePage) ? "active" : "" %>">Home</a>
      <a href="${pageContext.request.contextPath}/restaurants" class="nav-link <%= "restaurants".equals(activePage) ? "active" : "" %>">Restaurants</a>
      <a href="${pageContext.request.contextPath}/about" class="nav-link <%= "about".equals(activePage) ? "active" : "" %>">About</a>
      <a href="${pageContext.request.contextPath}/contact" class="nav-link <%= "contact".equals(activePage) ? "active" : "" %>">Contact</a>
      <a href="${pageContext.request.contextPath}/orders" class="nav-link orders-nav-link <%= "orders".equals(activePage) ? "active" : "" %>" style="display: none;">Orders</a>
    </nav>

    <%-- Action Buttons & Expandable Search --%>
    <div class="nav-actions">
      <%-- Expandable Search Input & Dropdown --%>
      <div class="nav-search-wrapper" style="position: relative;">
        <div style="display: flex; align-items: center; background-color: var(--bg-subtle); border: 1px solid var(--border-color); border-radius: var(--radius-pill); padding: 0.25rem 0.75rem; transition: all 0.35s ease; width: 180px;" id="navSearchContainer">
          <i class="fa-solid fa-magnifying-glass" style="color: var(--text-muted); font-size: 0.9rem;"></i>
          <input type="text" id="navSearchInput" placeholder="Search biryani, pizza..." style="border: none; background: transparent; outline: none; padding: 0.4rem 0.5rem; font-size: 0.85rem; color: var(--text-main); width: 100%;">
        </div>

        <%-- Typeahead Live Dropdown --%>
        <div id="navSearchDropdown" class="card-glass" style="position: absolute; top: 50px; right: 0; width: 340px; max-height: 380px; overflow-y: auto; display: none; z-index: 1200; padding: 0.75rem; box-shadow: var(--shadow-lg);">
          <!-- Populated by main.js -->
        </div>
      </div>

      <%-- Cart Icon with Dynamic Badge --%>
      <a href="${pageContext.request.contextPath}/cart" class="cart-nav-btn <%= "cart".equals(activePage) ? "active" : "" %>" title="View Cart">
        <i class="fa-solid fa-bag-shopping"></i>
        <span class="cart-badge" id="navCartBadge">0</span>
      </a>

      <%-- Theme Switcher Button --%>
      <button class="theme-toggle-btn" id="themeToggleBtn" aria-label="Toggle Theme">
        <i class="fa-solid fa-moon"></i>
      </button>

      <%-- Login / Sign Up CTA --%>
      <button class="btn btn-secondary trigger-login btn-sm">Login</button>
      <button class="btn btn-primary trigger-signup btn-sm">Sign Up</button>

      <%-- Mobile Hamburger Menu Button --%>
      <button class="mobile-menu-btn" id="mobileMenuBtn" aria-label="Open Mobile Menu">
        <i class="fa-solid fa-bars-staggered"></i>
      </button>
    </div>
  </div>
</header>

<%-- Mobile Drawer Navigation --%>
<div class="drawer-overlay" id="drawerOverlay"></div>
<div class="mobile-drawer" id="mobileDrawer">
  <div class="drawer-header">
    <a href="${pageContext.request.contextPath}/" class="nav-logo">
      <div class="nav-logo-icon"><i class="fa-solid fa-utensils"></i></div>
      <span>Cravio</span>
    </a>
    <button class="drawer-close-btn" id="drawerCloseBtn"><i class="fa-solid fa-xmark"></i></button>
  </div>
  <div class="drawer-links">
    <a href="${pageContext.request.contextPath}/" class="drawer-link">Home</a>
    <a href="${pageContext.request.contextPath}/restaurants" class="drawer-link">Restaurants</a>
    <a href="${pageContext.request.contextPath}/about" class="drawer-link">About Us</a>
    <a href="${pageContext.request.contextPath}/contact" class="drawer-link">Contact & Help</a>
    <a href="${pageContext.request.contextPath}/cart" class="drawer-link">My Cart</a>
    <a href="${pageContext.request.contextPath}/orders" class="drawer-link orders-nav-link" style="display: none;">My Orders</a>
    <a href="${pageContext.request.contextPath}/track-order" class="drawer-link">Track Order</a>
    <hr style="border-color: var(--border-color); margin: 1rem 0;">
    <button class="btn btn-secondary trigger-login" style="width: 100%;">Login</button>
    <button class="btn btn-primary trigger-signup" style="width: 100%; margin-top: 0.5rem;">Sign Up</button>
  </div>
</div>

<%-- LOCATION SELECTOR MODAL --%>
<div class="modal-overlay" id="locationModalOverlay">
  <div class="modal-card">
    <button class="modal-close" onclick="closeLocationModal()"><i class="fa-solid fa-xmark"></i></button>
    <h3 style="font-size: 1.25rem; margin-bottom: 1rem;"><i class="fa-solid fa-location-crosshairs" style="color: var(--primary);"></i> Select Delivery Location</h3>
    
    <div class="form-group">
      <label class="form-label">Select City</label>
      <select class="form-input" id="citySelect" onchange="onCityChange(this.value)">
        <option value="ALL">🌐 View All Cities</option>
        <option value="Hyderabad">Hyderabad</option>
        <option value="Mumbai">Mumbai</option>
        <option value="Delhi">Delhi</option>
        <option value="Bangalore">Bangalore</option>
        <option value="Pune">Pune</option>
      </select>
    </div>

    <div class="form-group">
      <label class="form-label">Select Nearby Locality</label>
      <select class="form-input" id="localitySelect">
      </select>
    </div>

    <div class="location-modal-actions">
      <button class="btn btn-secondary" style="flex: 1;" onclick="viewAllLocations()">View All Restaurants</button>
      <button class="btn btn-primary" style="flex: 1;" onclick="saveSelectedLocation()">Set Location</button>
    </div>
  </div>
</div>

<script>
  function openLocationModal() {
    document.getElementById('locationModalOverlay').classList.add('active');
    if (window.CravioData) {
      const loc = window.CravioData.getCurrentLocation();
      document.getElementById('citySelect').value = loc.city || 'ALL';
      onCityChange(loc.city || 'ALL', loc.locality);
    }
  }

  function closeLocationModal() {
    document.getElementById('locationModalOverlay').classList.remove('active');
  }

  function onCityChange(city, defaultLocality) {
    const locSelect = document.getElementById('localitySelect');
    if (!window.CravioData) return;

    if (city === 'ALL' || !window.CravioData.LOCATIONS[city]) {
      locSelect.innerHTML = '<option value="ALL">📍 All Localities (View All)</option>';
      return;
    }

    const localities = window.CravioData.LOCATIONS[city];
    let html = '<option value="ALL">📍 All Localities in ' + city + '</option>';
    html += localities.map(function(l) { return '<option value="' + l + '">' + l + '</option>'; }).join('');
    locSelect.innerHTML = html;

    if (defaultLocality && localities.includes(defaultLocality)) {
      locSelect.value = defaultLocality;
    }
  }

  function saveSelectedLocation() {
    const city = document.getElementById('citySelect').value;
    const locality = document.getElementById('localitySelect').value;
    if (window.CravioData) {
      window.CravioData.setCurrentLocation(city, locality);
    }
    updateLocDisplay();
    closeLocationModal();
    const label = (city === 'ALL' || locality === 'ALL') ? 'All Locations' : locality + ', ' + city;
    if (window.CravioToast) window.CravioToast('Location set to ' + label, 'success');
    if (window.CravioFilter) window.CravioFilter.renderFilteredRestaurants();
  }

  function viewAllLocations() {
    if (window.CravioData) {
      window.CravioData.setCurrentLocation('ALL', 'ALL');
    }
    updateLocDisplay();
    closeLocationModal();
    if (window.CravioToast) window.CravioToast('Showing all restaurants across all locations', 'info');
    if (window.CravioFilter) window.CravioFilter.renderFilteredRestaurants();
  }

  function updateLocDisplay() {
    const displayEl = document.getElementById('currentLocDisplay');
    if (displayEl && window.CravioData) {
      const loc = window.CravioData.getCurrentLocation();
      if (!loc.city || loc.city === 'ALL' || loc.locality === 'ALL') {
        displayEl.textContent = 'All Locations';
      } else {
        displayEl.textContent = loc.locality + ', ' + loc.city;
      }
    }
  }

  document.addEventListener('DOMContentLoaded', updateLocDisplay);
</script>
