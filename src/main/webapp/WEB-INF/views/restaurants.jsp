<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "Restaurants");
    request.setAttribute("activePage", "restaurants");
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<!-- SEARCH HEADER BANNER -->
<section style="background-color: var(--bg-subtle); padding: 3rem 0; border-bottom: 1px solid var(--border-color);">
  <div class="container">
    <h1 style="font-size: 2.25rem; margin-bottom: 0.5rem;">Explore Fine Dining & Authentic Kitchens</h1>
    <p style="color: var(--text-muted); margin-bottom: 1.5rem;">Discover top-rated restaurants delivering in your city.</p>
    
    <div style="display: flex; gap: 0.75rem; max-width: 700px;">
      <div style="flex-grow: 1; position: relative;">
        <i class="fa-solid fa-magnifying-glass" style="position: absolute; left: 1.25rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
        <input type="text" id="searchInput" placeholder="Search restaurant name, cuisine (Biryani, Dosa, Pizza)..." class="form-input" style="padding-left: 3rem; border-radius: var(--radius-pill);">
      </div>
      <button class="btn btn-primary" style="border-radius: var(--radius-pill); padding: 0.75rem 1.75rem;" onclick="if(window.CravioFilter) window.CravioFilter.renderFilteredRestaurants()">
        <i class="fa-solid fa-magnifying-glass"></i> Search
      </button>
    </div>
  </div>
</section>

<!-- LISTING MAIN LAYOUT -->
<section class="container">
  <div class="listing-layout">
    <!-- SIDEBAR FILTERS -->
    <aside class="filter-sidebar">
      <div class="filter-title">
        <span>Filter Options</span>
        <button style="font-size: 0.8rem; color: var(--primary); font-weight: 600;" onclick="location.reload()">Clear All</button>
      </div>

      <!-- Cuisine Filter -->
      <div class="filter-group">
        <div class="filter-group-title">Cuisines</div>
        <label class="filter-checkbox-label"><input type="checkbox" class="filter-cuisine-cb" value="Hyderabadi"> Hyderabadi & Biryani</label>
        <label class="filter-checkbox-label"><input type="checkbox" class="filter-cuisine-cb" value="North Indian"> North Indian</label>
        <label class="filter-checkbox-label"><input type="checkbox" class="filter-cuisine-cb" value="South Indian"> South Indian</label>
        <label class="filter-checkbox-label"><input type="checkbox" class="filter-cuisine-cb" value="Mughlai"> Mughlai & Kebabs</label>
        <label class="filter-checkbox-label"><input type="checkbox" class="filter-cuisine-cb" value="Italian"> Italian & Pizza</label>
        <label class="filter-checkbox-label"><input type="checkbox" class="filter-cuisine-cb" value="Chinese"> Chinese & Asian</label>
        <label class="filter-checkbox-label"><input type="checkbox" class="filter-cuisine-cb" value="Street Food"> Street Food</label>
      </div>

      <!-- Price Range Filter -->
      <div class="filter-group">
        <div class="filter-group-title">Price Range (For Two)</div>
        <label class="filter-checkbox-label"><input type="radio" name="priceRadio" value="400"> Under ₹400 (Budget)</label>
        <label class="filter-checkbox-label"><input type="radio" name="priceRadio" value="800"> Under ₹800 (Popular)</label>
        <label class="filter-checkbox-label"><input type="radio" name="priceRadio" value="1500"> Under ₹1500 (Luxury)</label>
        <label class="filter-checkbox-label"><input type="radio" name="priceRadio" value="99999" checked> All Prices</label>
      </div>

      <!-- Rating Filter -->
      <div class="filter-group">
        <div class="filter-group-title">Minimum Rating</div>
        <label class="filter-checkbox-label"><input type="radio" name="ratingRadio" value="4.8"> 4.8 & Above ★★★★★</label>
        <label class="filter-checkbox-label"><input type="radio" name="ratingRadio" value="4.5"> 4.5 & Above ★★★★☆</label>
        <label class="filter-checkbox-label"><input type="radio" name="ratingRadio" value="0" checked> All Ratings</label>
      </div>

      <!-- Veg Filter -->
      <div class="filter-group">
        <div class="filter-group-title">Dietary Preference</div>
        <label class="filter-checkbox-label"><input type="checkbox" id="filterVegOnly"> Pure Veg Only</label>
      </div>
    </aside>

    <!-- RESTAURANTS CONTENT GRID -->
    <main>
      <div class="listing-header">
        <span style="color: var(--text-muted); font-size: 0.95rem;" id="restaurantCountBadge">Showing Restaurants</span>
        <div class="sorting-tabs">
          <button class="tab-btn active" data-sort="recommended">Recommended</button>
          <button class="tab-btn" data-sort="rating">Rating: High to Low</button>
          <button class="tab-btn" data-sort="price_asc">Price: Low to High</button>
          <button class="tab-btn" data-sort="price_desc">Price: High to Low</button>
        </div>
      </div>

      <div class="restaurant-grid" id="restaurantGridContainer">
        <!-- Rendered dynamically by filter-engine.js -->
      </div>
    </main>
  </div>
</section>

<%@ include file="footer.jsp" %>
