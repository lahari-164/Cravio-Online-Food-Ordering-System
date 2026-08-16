<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "Restaurant Details");
    request.setAttribute("activePage", "restaurants");
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<div class="container">
  <!-- DYNAMIC RESTAURANT HERO BANNER -->
  <div class="restaurant-hero-banner" id="restBannerContainer">
    <img src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=1200&q=80" alt="Restaurant Banner" class="restaurant-banner-img" id="restBannerImg" style="transition: opacity 0.3s ease;">
    <div class="restaurant-hero-overlay">
      <div class="restaurant-hero-info">
        <span class="badge badge-offer" id="restOfferBadge" style="margin-bottom: 0.5rem;"><i class="fa-solid fa-fire"></i> 20% OFF | Code CRAVIO20</span>
        <h1 id="restNameHeading">Hyderabad Biryani House</h1>
        <div class="restaurant-hero-tags" id="restMetaTags">
          <span><i class="fa-solid fa-star" style="color: #FFB800;"></i> <span id="restRatingText">4.9 (3.4k+ Reviews)</span></span>
          <span><i class="fa-solid fa-utensils"></i> <span id="restCuisineText">Hyderabadi Dum Biryani & Mughlai</span></span>
          <span><i class="fa-regular fa-clock"></i> <span id="restTimeText">20-30 Mins</span></span>
          <span><i class="fa-solid fa-location-dot"></i> <span id="restAddressText">Jubilee Hills, Hyderabad</span></span>
        </div>
      </div>
    </div>
  </div>

  <!-- GALLERY PREVIEW & DESCRIPTION -->
  <div class="card-glass" style="padding: 1.5rem; margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
    <div style="flex-grow: 1; max-width: 600px;">
      <h4 style="font-size: 1.1rem; font-weight: 700;">About Restaurant</h4>
      <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 0.25rem;" id="restDescriptionText">Authentic royal Nizami biryanis cooked in clay handis with pure saffron, Kashmiri spices & tender meats.</p>
      <span style="font-size: 0.8rem; color: var(--accent-green); font-weight: 600; margin-top: 0.5rem; display: inline-block;" id="restOpeningHours"><i class="fa-regular fa-clock"></i> Open: 11:00 AM - 11:30 PM</span>
    </div>

    <%-- Clickable Gallery Thumbnails --%>
    <div>
      <div style="font-size: 0.75rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase; margin-bottom: 0.4rem; text-align: right;">Photo Gallery (Click to view)</div>
      <div style="display: flex; gap: 0.6rem;" id="restGalleryThumbnails">
        <!-- Rendered dynamically by JS -->
      </div>
    </div>
  </div>

  <!-- MAIN MENU LAYOUT -->
  <div class="menu-layout">
    <!-- DISHES LIST SECTION -->
    <div>
      <!-- MENU SEARCH INPUT -->
      <div style="margin-bottom: 1.5rem; position: relative;">
        <i class="fa-solid fa-magnifying-glass" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
        <input type="text" id="menuSearchInput" placeholder="Search dishes in this menu..." class="form-input" style="padding-left: 2.75rem;">
      </div>

      <!-- CATEGORY TABS BAR -->
      <div class="category-nav-bar" id="menuCategoryBar">
        <button class="tab-btn active">All Items</button>
      </div>

      <h2 class="menu-category-title" id="menuCategoryHeading"><i class="fa-solid fa-crown" style="color: var(--primary);"></i> Menu Items</h2>
      
      <div style="display: flex; flex-direction: column; gap: 1.25rem;" id="dishCardsContainer">
        <!-- Rendered dynamically by JS -->
      </div>
    </div>

    <!-- STICKY CART SUMMARY SIDEBAR -->
    <aside class="sticky-cart-sidebar">
      <h3 style="font-size: 1.2rem; margin-bottom: 1rem; display: flex; justify-content: space-between; align-items: center;">
        <span>Your Order</span>
        <i class="fa-solid fa-bag-shopping" style="color: var(--primary);"></i>
      </h3>

      <div id="cartItemsList" style="max-height: 320px; overflow-y: auto; padding-right: 6px; margin-bottom: 1rem;">
      </div>

      <div style="border-top: 1px solid var(--border-color); padding-top: 1rem;">
        <div class="summary-row">
          <span>Subtotal</span>
          <strong id="cartSubtotal">₹0</strong>
        </div>
        <div class="summary-row">
          <span>Delivery Fee</span>
          <span id="cartDelivery">₹50</span>
        </div>
        <div class="summary-total" style="display: flex; justify-content: space-between;">
          <span>Grand Total</span>
          <span id="cartGrandTotal" style="color: var(--primary);">₹0</span>
        </div>

        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary" style="width: 100%; margin-top: 1.25rem;">Proceed to Checkout <i class="fa-solid fa-arrow-right"></i></a>
      </div>
    </aside>
  </div>
</div>

<%@ include file="footer.jsp" %>

<script>
  function switchBannerImage(src) {
    const banner = document.getElementById('restBannerImg');
    if (!banner) return;
    banner.style.opacity = '0.4';
    setTimeout(function() {
      banner.src = src;
      banner.style.opacity = '1';
    }, 150);
  }

  document.addEventListener('DOMContentLoaded', function() {
    if (!window.CravioData) return;
    // NEW — restaurant/menu data now comes from the backend
    // (GET /api/restaurants, GET /api/restaurants/{id}/products) and loads
    // asynchronously, so wait for it before trying to render.
    var readyPromise = (window.CravioData.ready && typeof window.CravioData.ready.then === 'function')
      ? window.CravioData.ready
      : Promise.resolve();
    readyPromise.then(initRestaurantDetailPage);
  });

  function initRestaurantDetailPage() {
    const urlParams = new URLSearchParams(window.location.search);
    const restId = urlParams.get('id');

    const rest = window.CravioData.getRestaurantById(restId);
    if (!rest) {
      const container = document.getElementById('dishCardsContainer');
      if (container) {
        container.innerHTML = '<div style="padding: 2rem; text-align: center; color: var(--text-muted);">Restaurant not found. It may have been removed, or the backend could not be reached.</div>';
      }
      return;
    }

    // Populate Restaurant Info
    document.title = rest.name + ' | Cravio';
    document.getElementById('restNameHeading').textContent = rest.name;
    document.getElementById('restBannerImg').src = rest.banner || rest.image;
    document.getElementById('restOfferBadge').innerHTML = '<i class="fa-solid fa-fire"></i> ' + rest.offer;
    document.getElementById('restRatingText').textContent = rest.rating + ' (' + rest.reviewCount + '+ Reviews)';
    document.getElementById('restCuisineText').textContent = rest.cuisine.join(' • ');
    document.getElementById('restTimeText').textContent = rest.deliveryTime;
    document.getElementById('restAddressText').textContent = rest.address || (rest.locality + ', ' + rest.city);
    document.getElementById('restDescriptionText').textContent = rest.description;
    document.getElementById('restOpeningHours').innerHTML = '<i class="fa-regular fa-clock"></i> Open: ' + rest.openingHours;

    // Render Clickable Gallery Thumbnails
    const galleryContainer = document.getElementById('restGalleryThumbnails');
    if (galleryContainer) {
      const photos = rest.gallery || [rest.banner || rest.image, rest.image];
      galleryContainer.innerHTML = photos.map(function(p) {
        return '<img src="' + p + '" onclick="switchBannerImage(this.src)" style="width: 72px; height: 72px; border-radius: var(--radius-md); object-fit: cover; cursor: pointer; border: 2px solid transparent; transition: all 0.2s ease;" onmouseover="this.style.borderColor=\'var(--primary)\'; this.style.transform=\'scale(1.05)\'" onmouseout="this.style.borderColor=\'transparent\'; this.style.transform=\'scale(1)\'" title="Click to view full photo">';
      }).join('');
    }

    // Render Menu Items
    renderMenuList(rest.menu, rest.name, rest.id);

    // Menu Search Input
    const menuSearch = document.getElementById('menuSearchInput');
    if (menuSearch) {
      menuSearch.addEventListener('input', function(e) {
        const q = e.target.value.toLowerCase().trim();
        const filtered = rest.menu.filter(function(d) {
          return d.name.toLowerCase().indexOf(q) !== -1 || d.desc.toLowerCase().indexOf(q) !== -1;
        });
        renderMenuList(filtered, rest.name, rest.id);
      });
    }
  });

  function renderMenuList(items, restName, restId) {
    const container = document.getElementById('dishCardsContainer');
    if (!container) return;

    if (!items || items.length === 0) {
      container.innerHTML = '<div style="padding: 2rem; text-align: center; color: var(--text-muted);">No dishes match your menu search.</div>';
      return;
    }

    container.innerHTML = items.map(function(d) {
      const vegBadge = d.isVeg ? '<span class="badge-veg">● VEG</span>' : '<span class="badge-nonveg">● NON-VEG</span>';
      return '<div class="dish-card">' +
        '<div class="dish-img-wrapper">' +
          '<img src="' + d.image + '" alt="' + d.name + '" class="dish-img">' +
        '</div>' +
        '<div class="dish-info">' +
          '<div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.25rem;">' +
            vegBadge +
            '<span style="font-size: 0.75rem; color: var(--text-muted);"><i class="fa-regular fa-clock"></i> ' + (d.prepTime || '15 min') + '</span>' +
          '</div>' +
          '<h3 class="dish-title">' + d.name + '</h3>' +
          '<div class="dish-price">₹' + d.price + '</div>' +
          '<p class="dish-desc">' + d.desc + '</p>' +
        '</div>' +
        '<button class="btn btn-primary btn-sm" onclick="CravioCart.addItem({id: \'' + d.id + '\', productId: ' + d.productId + ', name: \'' + d.name.replace(/'/g, "\\'") + '\', price: ' + d.price + ', image: \'' + d.image + '\', restaurant: \'' + restName.replace(/'/g, "\\'") + '\', restaurantId: \'' + restId + '\'})">' +
          '<i class="fa-solid fa-plus"></i> Add' +
        '</button>' +
      '</div>';
    }).join('');
  }
</script>
