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
    <img src="https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=1200&q=80" alt="Restaurant Banner" class="restaurant-banner-img" id="restBannerImg" style="transition: opacity 0.3s ease;">
    <div class="restaurant-hero-overlay">
      <div class="restaurant-hero-info">
        <span class="badge badge-offer" id="restOfferBadge" style="margin-bottom: 0.5rem;"><i class="fa-solid fa-fire"></i> Loading restaurant...</span>
        <h1 id="restNameHeading">Loading restaurant...</h1>
        <div class="restaurant-hero-tags" id="restMetaTags">
          <span><i class="fa-solid fa-star" style="color: #FFB800;"></i> <span id="restRatingText">--</span></span>
          <span><i class="fa-solid fa-utensils"></i> <span id="restCuisineText">--</span></span>
          <span><i class="fa-regular fa-clock"></i> <span id="restTimeText">--</span></span>
          <span><i class="fa-solid fa-location-dot"></i> <span id="restAddressText">--</span></span>
        </div>
      </div>
    </div>
  </div>

  <!-- GALLERY PREVIEW & DESCRIPTION -->
  <div class="card-glass" style="padding: 1.5rem; margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
    <div style="flex-grow: 1; max-width: 600px;">
      <h4 style="font-size: 1.1rem; font-weight: 700;">About Restaurant</h4>
      <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 0.25rem;" id="restDescriptionText">Loading restaurant details...</p>
      <span style="font-size: 0.8rem; color: var(--accent-green); font-weight: 600; margin-top: 0.5rem; display: inline-block;" id="restOpeningHours"><i class="fa-regular fa-clock"></i> Open: --</span>
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
    initRestaurantDetailPage();
  });

  function showRestaurantNotFound(message) {
    const nameEl = document.getElementById('restNameHeading');
    const badgeEl = document.getElementById('restOfferBadge');
    const ratingEl = document.getElementById('restRatingText');
    const cuisineEl = document.getElementById('restCuisineText');
    const timeEl = document.getElementById('restTimeText');
    const addressEl = document.getElementById('restAddressText');
    const descriptionEl = document.getElementById('restDescriptionText');
    const hoursEl = document.getElementById('restOpeningHours');
    const menuContainer = document.getElementById('dishCardsContainer');

    if (nameEl) nameEl.textContent = 'Restaurant not found';
    if (badgeEl) badgeEl.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i> Invalid restaurant';
    if (ratingEl) ratingEl.textContent = '--';
    if (cuisineEl) cuisineEl.textContent = '--';
    if (timeEl) timeEl.textContent = '--';
    if (addressEl) addressEl.textContent = '--';
    if (descriptionEl) descriptionEl.textContent = message;
    if (hoursEl) hoursEl.innerHTML = '<i class="fa-regular fa-clock"></i> Open: --';
    if (menuContainer) {
      menuContainer.innerHTML = '<div style="padding: 2rem; text-align: center; color: var(--text-muted);">' +
        '<p style="margin-bottom: 1rem;">' + message + '</p>' +
        '<a href="' + window.location.origin + '/restaurants" class="btn btn-primary">Back to Restaurants</a>' +
        '</div>';
    }
  }

  async function initRestaurantDetailPage() {
    const urlParams = new URLSearchParams(window.location.search);
    const restId = urlParams.get('id');

    if (!restId || isNaN(Number(restId))) {
      showRestaurantNotFound('No valid restaurant ID was provided in the URL.');
      return;
    }

    try {
      const restaurantRes = await fetch('/api/restaurants/' + restId);
      if (!restaurantRes.ok) {
        showRestaurantNotFound('Restaurant not found for this ID.');
        return;
      }

      const restaurant = await restaurantRes.json();
      const productRes = await fetch('/api/restaurants/' + restId + '/products');
      const products = productRes.ok ? await productRes.json() : [];

      populateRestaurant(restaurant, products);
    } catch (error) {
      console.error('CRAVIO: failed to load restaurant details', error);
      showRestaurantNotFound('Unable to load restaurant details right now.');
    }
  }

  function populateRestaurant(restaurant, products) {
    const restaurantName = restaurant.name || 'Restaurant';
    document.title = restaurantName + ' | Cravio';
    document.getElementById('restNameHeading').textContent = restaurantName;
    document.getElementById('restBannerImg').src = restaurant.imageUrl || restaurant.image || 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=1200&q=80';
    document.getElementById('restOfferBadge').innerHTML = '<i class="fa-solid fa-fire"></i> ' + (restaurant.offer || 'Freshly prepared');
    document.getElementById('restRatingText').textContent = (restaurant.rating != null ? Number(restaurant.rating).toFixed(1) : '4.5') + ' (' + (restaurant.reviewCount || '3.4k+') + '+ Reviews)';
    const cuisine = Array.isArray(restaurant.cuisine)
      ? restaurant.cuisine.join(' • ')
      : (restaurant.cuisine || 'Multi-cuisine');
    document.getElementById('restCuisineText').textContent = cuisine;
    document.getElementById('restTimeText').textContent = restaurant.deliveryTime || '30-40 min';
    document.getElementById('restAddressText').textContent = restaurant.address || (restaurant.locality || '') + (restaurant.city ? ', ' + restaurant.city : '');
    document.getElementById('restDescriptionText').textContent = restaurant.description || 'No description available.';
    document.getElementById('restOpeningHours').innerHTML = '<i class="fa-regular fa-clock"></i> Open: ' + (restaurant.openingHours || 'Hours not available');

    const galleryContainer = document.getElementById('restGalleryThumbnails');
    if (galleryContainer) {
      const photos = [restaurant.imageUrl || restaurant.image || 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=1200&q=80'];
      galleryContainer.innerHTML = photos.map(function(p) {
        return '<img src="' + p + '" onclick="switchBannerImage(this.src)" style="width: 72px; height: 72px; border-radius: var(--radius-md); object-fit: cover; cursor: pointer; border: 2px solid transparent; transition: all 0.2s ease;" onmouseover="this.style.borderColor=\'var(--primary)\'; this.style.transform=\'scale(1.05)\'" onmouseout="this.style.borderColor=\'transparent\'; this.style.transform=\'scale(1)\'" title="Click to view full photo">';
      }).join('');
    }

    renderMenuList(products || [], restaurantName, restaurant.id);

    const menuSearch = document.getElementById('menuSearchInput');
    if (menuSearch) {
      menuSearch.oninput = function(e) {
        const q = e.target.value.toLowerCase().trim();
        const filtered = (products || []).filter(function(d) {
          return (d.name || '').toLowerCase().indexOf(q) !== -1 || (d.description || '').toLowerCase().indexOf(q) !== -1;
        });
        renderMenuList(filtered, restaurantName, restaurant.id);
      };
    }
  }

  function renderMenuList(items, restName, restId) {
    const container = document.getElementById('dishCardsContainer');
    if (!container) return;

    if (!items || items.length === 0) {
      container.innerHTML = '<div style="padding: 2rem; text-align: center; color: var(--text-muted);">No dishes are available for this restaurant right now.</div>';
      return;
    }

    container.innerHTML = items.map(function(d) {
      const isAvailable = d.isAvailable !== false;
      const vegBadge = (d.category || '').toLowerCase().indexOf('veg') !== -1 ? '<span class="badge-veg">● VEG</span>' : '<span class="badge-nonveg">● NON-VEG</span>';
      const buttonLabel = isAvailable ? '<i class="fa-solid fa-plus"></i> Add' : 'Unavailable';
      const disabledAttr = isAvailable ? '' : 'disabled';
      return '<div class="dish-card">' +
        '<div class="dish-img-wrapper">' +
          '<img src="' + (d.imageUrl || d.image || 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80') + '" alt="' + (d.name || 'Dish') + '" class="dish-img">' +
        '</div>' +
        '<div class="dish-info">' +
          '<div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.25rem;">' +
            vegBadge +
            '<span style="font-size: 0.75rem; color: var(--text-muted);"><i class="fa-regular fa-clock"></i> 15-20 min</span>' +
          '</div>' +
          '<h3 class="dish-title">' + (d.name || 'Dish') + '</h3>' +
          '<div class="dish-price">₹' + Number(d.price || 0) + '</div>' +
          '<p class="dish-desc">' + (d.description || 'No description available.') + '</p>' +
          '<div style="font-size: 0.75rem; color: var(--text-muted); margin-top: 0.4rem;">Category: ' + (d.category || 'General') + '</div>' +
        '</div>' +
        '<button class="btn btn-primary btn-sm" ' + disabledAttr + ' onclick="CravioCart.addItem({id: \'' + (d.id || 'dish-' + Date.now()) + '\', productId: ' + (d.id || 0) + ', name: \'' + (d.name || 'Dish').replace(/'/g, "\\'") + '\', price: ' + Number(d.price || 0) + ', image: \'' + (d.imageUrl || d.image || 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80').replace(/'/g, "\\'") + '\', restaurant: \'' + restName.replace(/'/g, "\\'") + '\', restaurantId: \'' + restId + '\'})">' +
          buttonLabel +
        '</button>' +
      '</div>';
    }).join('');
  }
</script>
