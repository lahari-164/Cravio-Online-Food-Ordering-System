<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
request.setAttribute("pageTitle", "Home");
request.setAttribute("activePage", "home");
%>
<%@ include file="header.jsp"%>
<%@ include file="navbar.jsp"%>

<!-- 1. HERO SECTION -->
<section class="hero-section">
&#x9;<div class="container hero-grid">
&#x9;	<div class="fade-in-up">
&#x9;		<div class="hero-badge pulse-badge">
&#x9;			<i class="fa-solid fa-fire"></i> Premium Food Delivery Service
&#x9;		</div>
&#x9;		<h1 class="hero-title">
&#x9;			Discover Luxury Dining &<br>
&#x9;			<span class="text-gradient">Authentic Indian Flavors</span>
&#x9;		</h1>
&#x9;		<p class="hero-subtitle">Explore top-rated kitchens in your city,
&#x9;			discover trending gourmet dishes, and order with live GPS tracking.</p>
&#x9;		<div class="hero-buttons">
&#x9;			<a href="${pageContext.request.contextPath}*/restaurants"
&#x9;				class="btn btn-primary btn-lg"><i class="fa-solid fa-store"></i>
&#x9;				Discover Restaurants</a> <a href="#popularDishesSection"
&#x9;				class="btn btn-secondary btn-lg"><i
&#x9;				class="fa-solid fa-utensils"></i> Showcase Dishes</a>
&#x9;		</div>
&#x9;	</div>

&#x9;	<div class="hero-slider-container fade-in-up delay-100">
&#x9;		<div class="hero-slide active">
&#x9;			<img
&#x9;				src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=1000&q=80"
&#x9;				alt="Hyderabadi Biryani">
&#x9;			<div class="hero-slide-overlay">
&#x9;				<span class="hero-slide-tag">Trending #1</span>
&#x9;				<h2>Hyderabadi Dum Biryani</h2>
&#x9;				<p>Authentic clay handi dum biryani starting at ₹380</p>
&#x9;			</div>
&#x9;		</div>
&#x9;		<div class="hero-slide">
&#x9;			<img
&#x9;				src="https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=1000&q=80"
&#x9;				alt="Butter Chicken">
&#x9;			<div class="hero-slide-overlay">
&#x9;				<span class="hero-slide-tag">Chef's Choice</span>
&#x9;				<h2>Royal Mughlai Butter Chicken</h2>
&#x9;				<p>Slow-cooked velvet tomato gravy with garlic naan</p>
&#x9;			</div>
&#x9;		</div>
&#x9;		<div class="hero-slide">
&#x9;			<img
&#x9;				src="https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=1000&q=80"
&#x9;				alt="Ghee Masala Dosa">
&#x9;			<div class="hero-slide-overlay">
&#x9;				<span class="hero-slide-tag">South Indian Special</span>
&#x9;				<h2>Crispy Ghee Roast Dosa</h2>
&#x9;				<p>Served with fresh coconut chutney & filter coffee</p>
&#x9;			</div>
&#x9;		</div>
&#x9;	</div>
&#x9;</div>
</section>

<!-- 2. FOOD CATEGORIES -->
<section style="padding: *4rem 0*;">
&#x9;<div class="container">
&#x9;	<div class="section-title-wrap">
&#x9;		<h2 class="section-title">Explore Categories</h2>
&#x9;		<p class="section-subtitle">Select your favorite culinary style
&#x9;			to discover partner kitchens</p>
&#x9;	</div>

&#x9;	<div class="categories-grid">
&#x9;		<div class="category-card"
&#x9;			onclick="window.location.href='*${pageContext.request.contextPath}*/restaurants'">
&#x9;			<div class="category-icon">
&#x9;				<i class="fa-solid fa-bowl-rice"></i>
&#x9;			</div>
&#x9;			<span class="category-name">Biryani</span>
&#x9;		</div>
&#x9;		<div class="category-card"
&#x9;			onclick="window.location.href='*${pageContext.request.contextPath}*/restaurants'">
&#x9;			<div class="category-icon">
&#x9;				<i class="fa-solid fa-fire-burner"></i>
&#x9;			</div>
&#x9;			<span class="category-name">North Indian</span>
&#x9;		</div>
&#x9;		<div class="category-card"
&#x9;			onclick="window.location.href='*${pageContext.request.contextPath}*/restaurants'">
&#x9;			<div class="category-icon">
&#x9;				<i class="fa-solid fa-mortar-pestle"></i>
&#x9;			</div>
&#x9;			<span class="category-name">South Indian</span>
&#x9;		</div>
&#x9;		<div class="category-card"
&#x9;			onclick="window.location.href='*${pageContext.request.contextPath}*/restaurants'">
&#x9;			<div class="category-icon">
&#x9;				<i class="fa-solid fa-pizza-slice"></i>
&#x9;			</div>
&#x9;			<span class="category-name">Pizza & Italian</span>
&#x9;		</div>
&#x9;		<div class="category-card"
&#x9;			onclick="window.location.href='*${pageContext.request.contextPath}*/restaurants'">
&#x9;			<div class="category-icon">
&#x9;				<i class="fa-solid fa-leaf"></i>
&#x9;			</div>
&#x9;			<span class="category-name">Pure Veg</span>
&#x9;		</div>
&#x9;		<div class="category-card"
&#x9;			onclick="window.location.href='*${pageContext.request.contextPath}*/restaurants'">
&#x9;			<div class="category-icon">
&#x9;				<i class="fa-solid fa-cookie"></i>
&#x9;			</div>
&#x9;			<span class="category-name">Desserts</span>
&#x9;		</div>
&#x9;	</div>
&#x9;</div>
</section>

<!-- 3. FEATURED RESTAURANTS -->
<section style="padding: *4rem 0*; background-color: *var(--bg-subtle)*;">
&#x9;<div class="container">
&#x9;	<div class="section-title-wrap">
&#x9;		<h2 class="section-title">Featured Restaurants</h2>
&#x9;		<p class="section-subtitle">Handpicked luxury dining experiences
&#x9;			in your city</p>
&#x9;	</div>

&#x9;	<div class="restaurant-grid" id="featuredRestaurantsGrid"></div>
&#x9;</div>
</section>

<!-- 4. POPULAR DISHES (SHOWCASE ONLY - NO DIRECT ORDERING) -->
<section style="padding: *5rem 0*;" id="popularDishesSection">
&#x9;<div class="container">
&#x9;	<div class="section-title-wrap">
&#x9;		<span class="badge badge-offer" style="margin-bottom: *0.5rem*;"><i
&#x9;			class="fa-solid fa-eye"></i> SHOWCASE ONLY</span>
&#x9;		<h2 class="section-title">Popular Dishes Across City</h2>
&#x9;		<p class="section-subtitle">Explore trending dishes. Click "View
&#x9;			Restaurant" to order directly from their menu.</p>
&#x9;	</div>

&#x9;	<div id="featuredDishesGrid"
&#x9;		style="display: *grid*; grid-template-columns: *repeat(auto-fit, minmax(320px, 1fr))*; gap: *1.75rem*;"></div>
&#x9;</div>
</section>

<!-- 5. TODAY'S OFFERS -->
<section id="offers"
&#x9;style="padding: *4rem 0*; background-color: *var(--bg-subtle)*;">
&#x9;<div class="container">
&#x9;	<div class="section-title-wrap">
&#x9;		<h2 class="section-title">Today's Offers & Promo Codes</h2>
&#x9;		<p class="section-subtitle">Copy coupon code and apply at
&#x9;			checkout</p>
&#x9;	</div>

&#x9;	<div
&#x9;		style="display: *grid*; grid-template-columns: *repeat(auto-fit, minmax(300px, 1fr))*; gap: *1.75rem*;">
&#x9;		<div
&#x9;			style="background: *linear-gradient(135deg, #FF3B30 0%, #FF6B4A 100%)*; color: *#FFF*; padding: *2rem*; border-radius: *var(--radius-xl)*; box-shadow: *var(--shadow-glow)*; display: *flex*; justify-content: *space-between*; align-items: *center*;">
&#x9;			<div>
&#x9;				<span class="badge"
&#x9;					style="background: *rgba(255, 255, 255, 0.2)*; color: *#FFF*; margin-bottom: *0.5rem*;">CRAVIO20</span>
&#x9;				<h3 style="color: *#FFF*; font-size: *1.75rem*;">20% OFF</h3>
&#x9;				<p style="font-size: *0.9rem*; opacity: *0.9*;">On orders above
&#x9;					₹400</p>
&#x9;			</div>
&#x9;			<button
&#x9;				onclick="navigator.clipboard.writeText('CRAVIO20'); window.CravioToast('Code CRAVIO20 copied!', 'success');"
&#x9;				class="btn"
&#x9;				style="background: *#FFF*; color: *var(--primary)*; font-weight: *700*;">Copy
&#x9;				Code</button>
&#x9;		</div>

&#x9;		<div
&#x9;			style="background: *linear-gradient(135deg, #10B981 0%, #059669 100%)*; color: *#FFF*; padding: *2rem*; border-radius: *var(--radius-xl)*; display: *flex*; justify-content: *space-between*; align-items: *center*;">
&#x9;			<div>
&#x9;				<span class="badge"
&#x9;					style="background: *rgba(255, 255, 255, 0.2)*; color: *#FFF*; margin-bottom: *0.5rem*;">FREEDEL</span>
&#x9;				<h3 style="color: *#FFF*; font-size: *1.75rem*;">FREE DELIVERY</h3>
&#x9;				<p style="font-size: *0.9rem*; opacity: *0.9*;">No minimum order
&#x9;					required</p>
&#x9;			</div>
&#x9;			<button
&#x9;				onclick="navigator.clipboard.writeText('FREEDEL'); window.CravioToast('Code FREEDEL copied!', 'success');"
&#x9;				class="btn"
&#x9;				style="background: *#FFF*; color: *#059669*; font-weight: *700*;">Copy
&#x9;				Code</button>
&#x9;		</div>
&#x9;	</div>
&#x9;</div>
</section>

<!-- 6. TESTIMONIALS -->
<section style="padding: *5rem 0*;">
&#x9;<div class="container">
&#x9;	<div class="section-title-wrap">
&#x9;		<h2 class="section-title">What Diners Say</h2>
&#x9;		<p class="section-subtitle">Real reviews from food connoisseurs</p>
&#x9;	</div>

&#x9;	<div style="max-width: *700px*; margin: *0 auto*; text-align: *center*;"
&#x9;		class="card-glass testimonial-card" style="padding: 2.*5rem;">
&#x9;		<i class="fa-solid fa-quote-left"
&#x9;			style="font-size: *2.5rem*; color: *var(--primary-light)*; margin-bottom: *1rem*;"></i>
&#x9;		<p
&#x9;			style="font-size: *1.1rem*; line-height: *1.8*; margin-bottom: *1.5rem*; color: *var(--text-main)*;">"Cravio
&#x9;			delivered piping hot Hyderabadi Dum Biryani to my apartment in 22
&#x9;			minutes! The thermal packaging kept the flavors completely sealed.
&#x9;			Truly a 5-star experience."</p>
&#x9;		<h4 style="font-weight: *700*;">Rohan Sharma</h4>
&#x9;		<span style="font-size: *0.85rem*; color: *var(--text-muted)*;">Food
&#x9;			Critic • Hyderabad</span>
&#x9;	</div>
&#x9;</div>
</section>

<!-- 7. DOWNLOAD APP BANNER -->
<section class="container">
&#x9;<div class="app-download-banner">
&#x9;	<div class="app-download-content">
&#x9;		<h2>Order Faster with Cravio Mobile App</h2>
&#x9;		<p>Get real-time live order updates, exclusive app-only coupons,
&#x9;			and seamless 1-tap checkout.</p>
&#x9;		<div class="app-store-btns">
&#x9;			<a href="#" class="app-btn"><i class="fa-brands fa-apple"></i>
&#x9;				<div>
&#x9;					<span style="font-size: *0.7rem*; text-transform: *uppercase*;">Download
&#x9;						on</span><br>App Store
&#x9;				</div></a> <a href="#" class="app-btn"><i
&#x9;				class="fa-brands fa-google-play"></i>
&#x9;				<div>
&#x9;					<span style="font-size: *0.7rem*; text-transform: *uppercase*;">Get
&#x9;						it on</span><br>Google Play
&#x9;				</div></a>
&#x9;		</div>
&#x9;	</div>
&#x9;	<div style="text-align: *center*;">
&#x9;		<img
&#x9;			src="https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?auto=format&fit=crop&w=400&q=80"
&#x9;			alt="Cravio App"
&#x9;			style="max-width: *260px*; margin: *0 auto*; border-radius: *24px*; box-shadow: *0 20px 40px rgba(0, 0, 0, 0.3)*;">
&#x9;	</div>
&#x9;</div>
</section>

<%@ include file="footer.jsp"%>

<script>
  function renderHomepageFeaturedRestaurants() {
    const container = document.getElementById('featuredRestaurantsGrid');
    if (!container || !window.CravioData || !window.CravioData.RESTAURANTS) return;

    const restaurants = window.CravioData.RESTAURANTS.slice(0, 3);
    if (!restaurants.length) return;

    container.innerHTML = restaurants.map(function (restaurant) {
      const cuisine = Array.isArray(restaurant.cuisine)
        ? restaurant.cuisine.join(' • ')
        : (restaurant.cuisine || 'Multi-cuisine');

      const offer = restaurant.offer || 'Available on CRAVIO';
      const link = '${pageContext.request.contextPath}/restaurant-detail?id=' + restaurant.id;

      const rating = restaurant.rating == null ? 4.5 : restaurant.rating;
      const priceForTwo = restaurant.priceForTwo == null ? 300 : restaurant.priceForTwo;
      const deliveryTime = restaurant.deliveryTime || '30-40 min';
      const locality = restaurant.locality || restaurant.city || 'Your city';

      return ''
        + '<div class="card-glass restaurant-card">'
        + '  <div class="restaurant-img-wrapper">'
        + '    <img src="' + restaurant.image + '" alt="' + restaurant.name + '" class="restaurant-img">'
        + '    <div class="restaurant-offer-tag">' + offer + '</div>'
        + '  </div>'
        + '  <div class="restaurant-content">'
        + '    <div class="restaurant-header-row">'
        + '      <h3 class="restaurant-title"><a href="' + link + '">' + restaurant.name + '</a></h3>'
        + '      <div class="restaurant-rating"><i class="fa-solid fa-star"></i> ' + rating + '</div>'
        + '    </div>'
        + '    <p style="font-size: 0.85rem; color: var(--text-muted);">' + cuisine + '</p>'
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

    container.innerHTML = featured.map(function (dish) {
      const badgeClass = dish.isVeg ? 'badge-veg' : 'badge-nonveg';
      const badgeLabel = dish.isVeg ? '● VEG' : '● NON-VEG';
      const restaurantLink = dish.restaurantUrl;
      const description = dish.desc || 'Freshly prepared and served with care.';

      return ''
        + '<div class="card-glass" style="padding: 1.5rem; display: flex; flex-direction: column; height: 100%;">'
        + '  <div style="position: relative; height: 180px; border-radius: var(--radius-md); overflow: hidden; margin-bottom: 1rem;">'
        + '    <img src="' + dish.image + '" alt="' + dish.name + '" style="width: 100%; height: 100%; object-fit: cover;">'
        + '    <span class="' + badgeClass + '" style="position: absolute; top: 10px; left: 10px; background: rgba(255,255,255,0.9);">'
        + badgeLabel + '</span>'
        + '  </div>'
        + '  <div style="flex-grow: 1;">'
        + '    <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.35rem;">'
        + '      <h3 style="font-size: 1.15rem; font-weight: 700;">' + dish.name + '</h3>'
        + '      <span style="font-weight: 800; color: var(--primary); font-size: 1.15rem;">₹' + dish.price + '</span>'
        + '    </div>'
        + '    <p style="font-size: 0.85rem; color: var(--primary); font-weight: 600; margin-bottom: 0.5rem;">'
        + '      <i class="fa-solid fa-store"></i> ' + dish.restaurantName
        + '    </p>'
        + '    <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 1rem;">'
        + description + '</p>'
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