<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
request.setAttribute("pageTitle", "Home");
request.setAttribute("activePage", "home");
%>
<%@ include file="header.jsp"%>
<%@ include file="navbar.jsp"%>

<style>
  .home-page-shell {
    display: block;
  }

  .home-hero {
    padding: 3rem 0 4rem;
  }

  .home-hero-grid {
    display: grid;
    grid-template-columns: 1.1fr 0.9fr;
    gap: 2.5rem;
    align-items: center;
  }

  .home-hero-content {
    max-width: 620px;
  }

  .home-hero-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.55rem;
    background: rgba(255, 107, 74, 0.12);
    color: var(--primary);
    border: 1px solid rgba(255, 107, 74, 0.16);
    border-radius: 999px;
    padding: 0.6rem 1rem;
    font-size: 0.8rem;
    font-weight: 700;
    letter-spacing: 0.02em;
    margin-bottom: 1.3rem;
  }

  .home-hero-title {
    font-size: clamp(2.3rem, 4vw, 4rem);
    line-height: 1.08;
    margin: 0 0 1rem;
    letter-spacing: -0.04em;
  }

  .home-hero-subtitle {
    color: var(--text-muted);
    font-size: 1.06rem;
    line-height: 1.7;
    margin-bottom: 2rem;
    max-width: 560px;
  }

  .home-hero-actions {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
  }

  .home-hero-card {
    background: rgba(15, 23, 42, 0.92);
    border: 1px solid var(--border-color);
    border-radius: 22px;
    overflow: hidden;
    box-shadow: var(--shadow-lg);
  }

  .home-hero-image {
    width: 100%;
    height: 100%;
    min-height: 460px;
    object-fit: cover;
    display: block;
  }

  .home-hero-overlay {
    position: absolute;
    inset: auto 0 0 0;
    padding: 1.5rem;
    background: linear-gradient(180deg, rgba(6, 10, 18, 0.05), rgba(6, 10, 18, 0.85));
  }

  .home-hero-overlay-badge {
    display: inline-block;
    background: var(--primary);
    color: #fff;
    border-radius: 999px;
    padding: 0.35rem 0.8rem;
    font-size: 0.7rem;
    font-weight: 700;
    margin-bottom: 0.6rem;
  }

  .home-hero-overlay h3 {
    margin: 0 0 0.25rem;
    font-size: clamp(1.3rem, 2vw, 2rem);
  }

  .home-hero-overlay p {
    margin: 0;
    color: rgba(255,255,255,0.88);
  }

  .home-section {
    padding: 4rem 0;
  }

  .home-section.alt {
    background: rgba(17, 24, 39, 0.45);
  }

  .home-offers-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.75rem;
  }

  .promo-card {
    border-radius: 24px;
    padding: 2rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    min-height: 180px;
    box-shadow: var(--shadow-md);
  }

  .promo-card h3 {
    margin: 0.2rem 0 0.5rem;
    font-size: clamp(1.5rem, 2vw, 2.2rem);
    line-height: 1.1;
    letter-spacing: -0.04em;
  }

  .promo-card p {
    margin: 0;
    opacity: 0.9;
    line-height: 1.6;
  }

  .promo-card .badge {
    display: inline-block;
    background: rgba(255,255,255,0.18);
    color: #fff;
    border-radius: 999px;
    padding: 0.4rem 0.8rem;
    font-weight: 700;
    font-size: 0.72rem;
    letter-spacing: 0.08em;
  }

  .promo-card button {
    flex-shrink: 0;
  }

  .testimonial-card {
    max-width: 760px;
    margin: 0 auto;
    padding: 2.5rem;
    text-align: center;
  }

  .testimonial-card p {
    font-size: 1.08rem;
    line-height: 1.9;
    color: var(--text-main);
    margin-bottom: 1.5rem;
  }

  .testimonial-card i {
    display: inline-block;
    font-size: 2.4rem;
    color: var(--primary-light);
    margin-bottom: 1rem;
  }

  @media (max-width: 900px) {
    .home-hero-grid {
      grid-template-columns: 1fr;
    }

    .home-hero-image {
      min-height: 340px;
    }
  }

  @media (max-width: 640px) {
    .home-hero {
      padding-top: 2rem;
    }

    .home-hero-actions {
      flex-direction: column;
      align-items: stretch;
    }

    .home-hero-actions .btn {
      width: 100%;
      justify-content: center;
    }

    .promo-card {
      flex-direction: column;
      align-items: flex-start;
      text-align: left;
    }

    .promo-card button {
      width: 100%;
    }

    .testimonial-card {
      padding: 2rem 1.25rem;
    }
  }
</style>

<section class="hero-section">
  <div class="container hero-grid">
    <div class="fade-in-up">
      <div class="hero-badge pulse-badge">
        <i class="fa-solid fa-fire"></i> Premium Food Delivery Service
      </div>
      <h1 class="hero-title">
        Discover Luxury Dining &<br>
        <span class="text-gradient">Authentic Indian Flavors</span>
      </h1>
      <p class="hero-subtitle">
        Explore top-rated kitchens in your city, discover trending gourmet dishes, and order with live GPS tracking.
      </p>
      <div class="hero-buttons">
        <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary btn-lg">
          <i class="fa-solid fa-store"></i> Discover Restaurants
        </a>
        <a href="#popularDishesSection" class="btn btn-secondary btn-lg">
          <i class="fa-solid fa-utensils"></i> Showcase Dishes
        </a>
      </div>
    </div>

    <div class="hero-slider-container fade-in-up delay-100">
      <div class="hero-slide active">
        <img src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=1000&q=80" alt="Hyderabadi Biryani">
        <div class="hero-slide-overlay">
          <span class="hero-slide-tag">Trending #1</span>
          <h2>Hyderabadi Dum Biryani</h2>
          <p>Authentic clay handi dum biryani starting at ₹380</p>
        </div>
      </div>
      <div class="hero-slide">
        <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=1000&q=80" alt="Pizza">
        <div class="hero-slide-overlay">
          <span class="hero-slide-tag">Chef's Choice</span>
          <h2>FireStone Pizza</h2>
          <p>Wood-fired gourmet pizza with rich toppings and cheesy crust</p>
        </div>
      </div>
      <div class="hero-slide">
        <img src="https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=1000&q=80" alt="Ghee Masala Dosa">
        <div class="hero-slide-overlay">
          <span class="hero-slide-tag">South Indian Special</span>
          <h2>Crispy Ghee Roast Dosa</h2>
          <p>Served with fresh coconut chutney & filter coffee</p>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="home-section">
  <div class="container">
    <div class="section-title-wrap">
      <h2 class="section-title">Explore Categories</h2>
      <p class="section-subtitle">Select your favorite culinary style to discover partner kitchens</p>
    </div>

    <div class="categories-grid">
      <div class="category-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurants'">
        <div class="category-icon"><i class="fa-solid fa-bowl-rice"></i></div>
        <span class="category-name">Biryani</span>
      </div>
      <div class="category-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurants'">
        <div class="category-icon"><i class="fa-solid fa-fire-burner"></i></div>
        <span class="category-name">North Indian</span>
      </div>
      <div class="category-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurants'">
        <div class="category-icon"><i class="fa-solid fa-mortar-pestle"></i></div>
        <span class="category-name">South Indian</span>
      </div>
      <div class="category-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurants'">
        <div class="category-icon"><i class="fa-solid fa-pizza-slice"></i></div>
        <span class="category-name">Pizza & Italian</span>
      </div>
      <div class="category-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurants'">
        <div class="category-icon"><i class="fa-solid fa-leaf"></i></div>
        <span class="category-name">Pure Veg</span>
      </div>
      <div class="category-card" onclick="window.location.href='${pageContext.request.contextPath}/restaurants'">
        <div class="category-icon"><i class="fa-solid fa-cookie"></i></div>
        <span class="category-name">Desserts</span>
      </div>
    </div>
  </div>
</section>

<section class="home-section alt">
  <div class="container">
    <div class="section-title-wrap">
      <h2 class="section-title">Featured Restaurants</h2>
      <p class="section-subtitle">Handpicked luxury dining experiences in your city</p>
    </div>
    <div class="restaurant-grid" id="featuredRestaurantsGrid"></div>
  </div>
</section>

<section class="home-section" id="popularDishesSection">
  <div class="container">
    <div class="section-title-wrap">
      <span class="badge badge-offer" style="margin-bottom: 0.5rem;"><i class="fa-solid fa-eye"></i> SHOWCASE ONLY</span>
      <h2 class="section-title">Popular Dishes Across City</h2>
      <p class="section-subtitle">Explore trending dishes. Click "View Restaurant" to order directly from their menu.</p>
    </div>
    <div id="featuredDishesGrid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 1.75rem;"></div>
  </div>
</section>

<section id="offers" class="home-section alt">
  <div class="container">
    <div class="section-title-wrap">
      <h2 class="section-title">Today's Offers & Promo Codes</h2>
      <p class="section-subtitle">Copy coupon code and apply at checkout</p>
    </div>

    <div class="home-offers-grid">
      <div class="promo-card" style="background: linear-gradient(135deg, #FF3B30 0%, #FF6B4A 100%); color: #fff;">
        <div>
          <span class="badge">CRAVIO20</span>
          <h3>20% OFF</h3>
          <p>On orders above ₹400</p>
        </div>
        <button class="btn" onclick="navigator.clipboard.writeText('CRAVIO20'); window.CravioToast('Code CRAVIO20 copied!', 'success');" style="background:#fff; color:var(--primary); font-weight:700;">Copy Code</button>
      </div>

      <div class="promo-card" style="background: linear-gradient(135deg, #10B981 0%, #059669 100%); color: #fff;">
        <div>
          <span class="badge">FREEDEL</span>
          <h3>FREE DELIVERY</h3>
          <p>No minimum order required</p>
        </div>
        <button class="btn" onclick="navigator.clipboard.writeText('FREEDEL'); window.CravioToast('Code FREEDEL copied!', 'success');" style="background:#fff; color:#059669; font-weight:700;">Copy Code</button>
      </div>
    </div>
  </div>
</section>

<section class="home-section">
  <div class="container">
    <div class="section-title-wrap">
      <h2 class="section-title">What Diners Say</h2>
      <p class="section-subtitle">Real reviews from food connoisseurs</p>
    </div>

    <div class="card-glass testimonial-card">
      <i class="fa-solid fa-quote-left"></i>
      <p>"Cravio delivered piping hot Hyderabadi Dum Biryani to my apartment in 22 minutes! The thermal packaging kept the flavors completely sealed. Truly a 5-star experience."</p>
      <h4 style="font-weight: 700; margin: 0;">Rohan Sharma</h4>
      <span style="font-size: 0.85rem; color: var(--text-muted);">Food Critic • Hyderabad</span>
    </div>
  </div>
</section>

<section class="container">
  <div class="app-download-banner">
    <div class="app-download-content">
      <h2>Order Faster with Cravio Mobile App</h2>
      <p>Get real-time live order updates, exclusive app-only coupons, and seamless 1-tap checkout.</p>
      <div class="app-store-btns">
        <a href="#" class="app-btn">
          <i class="fa-brands fa-apple"></i>
          <div><span style="font-size: 0.7rem; text-transform: uppercase;">Download on</span><br>App Store</div>
        </a>
        <a href="#" class="app-btn">
          <i class="fa-brands fa-google-play"></i>
          <div><span style="font-size: 0.7rem; text-transform: uppercase;">Get it on</span><br>Google Play</div>
        </a>
      </div>
    </div>
    <div style="text-align: center;">
      <img src="https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?auto=format&fit=crop&w=400&q=80" alt="Cravio App" style="max-width: 260px; margin: 0 auto; border-radius: 24px; box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);">
    </div>
  </div>
</section>

<%@ include file="footer.jsp"%>

<script>
  function safeImageUrl(value, fallbackImage) {
    const raw = typeof value === 'string' ? value.trim() : '';
    if (raw && raw !== 'null' && raw !== 'undefined') {
      return raw;
    }
    return fallbackImage || 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80';
  }

  function renderHomepageFeaturedRestaurants() {
    const container = document.getElementById('featuredRestaurantsGrid');
    if (!container || !window.CravioData || !window.CravioData.RESTAURANTS) return;

    const restaurants = window.CravioData.RESTAURANTS.slice(0, 3);
    if (!restaurants.length) return;

    container.innerHTML = restaurants.map(function (restaurant, index) {
      const cuisine = Array.isArray(restaurant.cuisine)
        ? restaurant.cuisine.join(' • ')
        : (restaurant.cuisine || 'Multi-cuisine');

      const isFirstFeaturedCard = index === 0;
      const displayName = isFirstFeaturedCard ? (restaurant.name || 'Hyderabad Biryani House') : (restaurant.name || 'Pizza Corner');
      const displayCuisine = isFirstFeaturedCard ? (restaurant.cuisine || 'Biryani • Hyderabadi') : cuisine;
      const displayLocality = isFirstFeaturedCard ? (restaurant.locality || restaurant.city || 'Hyderabad') : (restaurant.locality || restaurant.city || 'Your city');
      const safeImage = isFirstFeaturedCard
        ? 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=900&q=80'
        : safeImageUrl(restaurant.image, 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=900&q=80');

      const offer = restaurant.offer || 'Available on CRAVIO';
      const link = '${pageContext.request.contextPath}/restaurant-detail?id=' + restaurant.id;

      const rating = restaurant.rating == null ? 4.5 : restaurant.rating;
      const priceForTwo = restaurant.priceForTwo == null ? 300 : restaurant.priceForTwo;
      const deliveryTime = restaurant.deliveryTime || '30-40 min';
      const locality = displayLocality;

      return ''
        + '<div class="card-glass restaurant-card">'
        + '  <div class="restaurant-img-wrapper">'
        + '    <img src="' + safeImage + '" alt="' + displayName + '" class="restaurant-img" onerror="this.onerror=null;this.src=\'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=900&q=80\';">'
        + '    <div class="restaurant-offer-tag">' + offer + '</div>'
        + '  </div>'
        + '  <div class="restaurant-content">'
        + '    <div class="restaurant-header-row">'
        + '      <h3 class="restaurant-title"><a href="' + link + '">' + displayName + '</a></h3>'
        + '      <div class="restaurant-rating"><i class="fa-solid fa-star"></i> ' + rating + '</div>'
        + '    </div>'
        + '    <p style="font-size: 0.85rem; color: var(--text-muted);">' + displayCuisine + '</p>'
        + '    <div style="font-size: 0.85rem; font-weight: 700; color: var(--primary); margin-top: 0.25rem;">₹'
        + priceForTwo + ' for two</div>'
        + '    <div class="restaurant-meta">'
        + '      <span><i class="fa-regular fa-clock"></i> ' + deliveryTime + '</span>'
        + '      <span><i class="fa-solid fa-location-dot"></i> ' + locality + '</span>'
        + '    </div>'
        + '    <a href="' + link + '" class="btn btn-secondary btn-sm" style="margin-top: 1rem; width: 100%;">View Restaurant & Menu</a>'
        + '  </div>'
        + '</div>';
    }).join('');
  }

  function renderHomepageFeaturedDishes() {
    const container = document.getElementById('featuredDishesGrid');
    if (!container || !window.CravioData || !window.CravioData.RESTAURANTS) return;

    const dishes = [];

    window.CravioData.RESTAURANTS.forEach(function (restaurant) {
      if (!restaurant.menu || !restaurant.menu.length) return;

      restaurant.menu.slice(0, 2).forEach(function (dish) {
        dishes.push({
          ...dish,
          restaurantName: restaurant.name,
          restaurantId: restaurant.id,
          restaurantUrl: '${pageContext.request.contextPath}/restaurant-detail?id=' + restaurant.id
        });
      });
    });

    const featured = dishes.slice(0, 3);
    if (!featured.length) return;

    container.innerHTML = featured.map(function (dish, index) {
      const badgeClass = dish.isVeg ? 'badge-veg' : 'badge-nonveg';
      const badgeLabel = dish.isVeg ? '● VEG' : '● NON-VEG';
      const restaurantLink = dish.restaurantUrl;
      const description = dish.desc || 'Freshly prepared and served with care.';

      const isFirstDish = index === 0;
      const isSecondDish = index === 1;

      const safeDishImage = isFirstDish
        ? 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=800&q=80'
        : isSecondDish
          ? 'https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&w=800&q=80'
          : safeImageUrl(dish.image, 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=800&q=80');

      const displayRestaurantName = isFirstDish ? 'Pizza Corner' : isSecondDish ? 'Chinese & Asian Favorites' : (dish.restaurantName || 'Pizza Corner');
      const displayDishName = isFirstDish ? 'Margherita Supreme Pizza' : isSecondDish ? 'Kung Pao Noodles' : (dish.name || 'Margherita Supreme Pizza');
      const displayDescription = isFirstDish
        ? 'Loaded with mozzarella, basil, tomato sauce and a wood-fired finish.'
        : isSecondDish
          ? 'Wok-tossed noodles with bold spices, crunchy vegetables and a savory Asian finish.'
          : description;

      return ''
        + '<div class="card-glass" style="padding: 1.5rem; display: flex; flex-direction: column; height: 100%;">'
        + '  <div style="position: relative; height: 180px; border-radius: var(--radius-md); overflow: hidden; margin-bottom: 1rem;">'
        + '    <img src="' + safeDishImage + '" alt="' + displayDishName + '" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.onerror=null;this.src=\'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=800&q=80\';">'
        + '    <span class="' + badgeClass + '" style="position: absolute; top: 10px; left: 10px; background: rgba(255,255,255,0.9);">'
        + badgeLabel + '</span>'
        + '  </div>'
        + '  <div style="flex-grow: 1;">'
        + '    <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.35rem;">'
        + '      <h3 style="font-size: 1.15rem; font-weight: 700;">' + displayDishName + '</h3>'
        + '      <span style="font-weight: 800; color: var(--primary); font-size: 1.15rem;">₹' + dish.price + '</span>'
        + '    </div>'
        + '    <p style="font-size: 0.85rem; color: var(--primary); font-weight: 600; margin-bottom: 0.5rem;">'
        + '      <i class="fa-solid fa-store"></i> ' + displayRestaurantName
        + '    </p>'
        + '    <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 1rem;">'
        + displayDescription + '</p>'
        + '  </div>'
        + '  <a href="' + restaurantLink + '" class="btn btn-secondary" style="width: 100%;">'
        + '    <i class="fa-solid fa-arrow-right"></i> View Restaurant'
        + '  </a>'
        + '</div>';
    }).join('');
  }

  function hydrateHomepageCards() {
    renderHomepageFeaturedRestaurants();
    renderHomepageFeaturedDishes();
  }

  document.addEventListener('DOMContentLoaded', function () {
    if (window.CravioData && window.CravioData.ready && typeof window.CravioData.ready.then === 'function') {
      window.CravioData.ready.then(function () {
        hydrateHomepageCards();
      });
    } else {
      hydrateHomepageCards();
    }

    document.addEventListener('cravio:data-ready', hydrateHomepageCards);
  });
</script>