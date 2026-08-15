<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "Home");
    request.setAttribute("activePage", "home");
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<!-- 1. HERO SECTION -->
<section class="hero-section">
  <div class="container hero-grid">
    <div class="fade-in-up">
      <div class="hero-badge pulse-badge">
        <i class="fa-solid fa-fire"></i> Premium Food Delivery Service
      </div>
      <h1 class="hero-title">Discover Luxury Dining &<br><span class="text-gradient">Authentic Indian Flavors</span></h1>
      <p class="hero-subtitle">Explore top-rated kitchens in your city, discover trending gourmet dishes, and order with live GPS tracking.</p>
      <div class="hero-buttons">
        <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary btn-lg"><i class="fa-solid fa-store"></i> Discover Restaurants</a>
        <a href="#popularDishesSection" class="btn btn-secondary btn-lg"><i class="fa-solid fa-utensils"></i> Showcase Dishes</a>
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
        <img src="https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=1000&q=80" alt="Butter Chicken">
        <div class="hero-slide-overlay">
          <span class="hero-slide-tag">Chef's Choice</span>
          <h2>Royal Mughlai Butter Chicken</h2>
          <p>Slow-cooked velvet tomato gravy with garlic naan</p>
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

<!-- 2. FOOD CATEGORIES -->
<section style="padding: 4rem 0;">
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

<!-- 3. FEATURED RESTAURANTS -->
<section style="padding: 4rem 0; background-color: var(--bg-subtle);">
  <div class="container">
    <div class="section-title-wrap">
      <h2 class="section-title">Featured Restaurants</h2>
      <p class="section-subtitle">Handpicked luxury dining experiences in your city</p>
    </div>

    <div class="restaurant-grid">
      <!-- Rest 1 -->
      <div class="card-glass restaurant-card">
        <div class="restaurant-img-wrapper">
          <img src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=600&q=80" alt="Hyderabad Biryani House" class="restaurant-img">
          <button class="restaurant-fav-btn"><i class="fa-regular fa-heart"></i></button>
          <div class="restaurant-offer-tag">20% OFF | CRAVIO20</div>
        </div>
        <div class="restaurant-content">
          <div class="restaurant-header-row">
            <h3 class="restaurant-title"><a href="${pageContext.request.contextPath}/restaurant-detail?id=rest-1">Hyderabad Biryani House</a></h3>
            <div class="restaurant-rating"><i class="fa-solid fa-star"></i> 4.9</div>
          </div>
          <p style="font-size: 0.85rem; color: var(--text-muted);">Hyderabadi • Biryani • Mughlai</p>
          <div style="font-size: 0.85rem; font-weight: 700; color: var(--primary); margin-top: 0.25rem;">₹500 for two</div>
          <div class="restaurant-meta">
            <span><i class="fa-regular fa-clock"></i> 20-30 min</span>
            <span><i class="fa-solid fa-location-dot"></i> Jubilee Hills, Hyderabad</span>
          </div>
          <a href="${pageContext.request.contextPath}/restaurant-detail?id=rest-1" class="btn btn-secondary btn-sm" style="margin-top: 1rem; width: 100%;">View Restaurant & Menu</a>
        </div>
      </div>

      <!-- Rest 2 -->
      <div class="card-glass restaurant-card">
        <div class="restaurant-img-wrapper">
          <img src="https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=600&q=80" alt="Bukhara Royal Tandoor" class="restaurant-img">
          <button class="restaurant-fav-btn"><i class="fa-regular fa-heart"></i></button>
          <div class="restaurant-offer-tag">FREE DELIVERY</div>
        </div>
        <div class="restaurant-content">
          <div class="restaurant-header-row">
            <h3 class="restaurant-title"><a href="${pageContext.request.contextPath}/restaurant-detail?id=rest-3">Bukhara Royal Tandoor</a></h3>
            <div class="restaurant-rating"><i class="fa-solid fa-star"></i> 4.9</div>
          </div>
          <p style="font-size: 0.85rem; color: var(--text-muted);">North Indian • Dal Bukhara • Kebabs</p>
          <div style="font-size: 0.85rem; font-weight: 700; color: var(--primary); margin-top: 0.25rem;">₹900 for two</div>
          <div class="restaurant-meta">
            <span><i class="fa-regular fa-clock"></i> 25-35 min</span>
            <span><i class="fa-solid fa-location-dot"></i> Connaught Place, Delhi</span>
          </div>
          <a href="${pageContext.request.contextPath}/restaurant-detail?id=rest-3" class="btn btn-secondary btn-sm" style="margin-top: 1rem; width: 100%;">View Restaurant & Menu</a>
        </div>
      </div>

      <!-- Rest 3 -->
      <div class="card-glass restaurant-card">
        <div class="restaurant-img-wrapper">
          <img src="https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=600&q=80" alt="South Spice" class="restaurant-img">
          <button class="restaurant-fav-btn"><i class="fa-regular fa-heart"></i></button>
          <div class="restaurant-offer-tag">PURE VEG</div>
        </div>
        <div class="restaurant-content">
          <div class="restaurant-header-row">
            <h3 class="restaurant-title"><a href="${pageContext.request.contextPath}/restaurant-detail?id=rest-6">South Spice</a></h3>
            <div class="restaurant-rating"><i class="fa-solid fa-star"></i> 4.9</div>
          </div>
          <p style="font-size: 0.85rem; color: var(--text-muted);">South Indian • Ghee Dosa • Filter Coffee</p>
          <div style="font-size: 0.85rem; font-weight: 700; color: var(--primary); margin-top: 0.25rem;">₹350 for two</div>
          <div class="restaurant-meta">
            <span><i class="fa-regular fa-clock"></i> 15-20 min</span>
            <span><i class="fa-solid fa-location-dot"></i> Indiranagar, Bangalore</span>
          </div>
          <a href="${pageContext.request.contextPath}/restaurant-detail?id=rest-6" class="btn btn-secondary btn-sm" style="margin-top: 1rem; width: 100%;">View Restaurant & Menu</a>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- 4. POPULAR DISHES (SHOWCASE ONLY - NO DIRECT ORDERING) -->
<section style="padding: 5rem 0;" id="popularDishesSection">
  <div class="container">
    <div class="section-title-wrap">
      <span class="badge badge-offer" style="margin-bottom: 0.5rem;"><i class="fa-solid fa-eye"></i> SHOWCASE ONLY</span>
      <h2 class="section-title">Popular Dishes Across City</h2>
      <p class="section-subtitle">Explore trending dishes. Click "View Restaurant" to order directly from their menu.</p>
    </div>

    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 1.75rem;">
      <!-- Showcase Dish 1 -->
      <div class="card-glass" style="padding: 1.5rem; display: flex; flex-direction: column; height: 100%;">
        <div style="position: relative; height: 180px; border-radius: var(--radius-md); overflow: hidden; margin-bottom: 1rem;">
          <img src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=400&q=80" alt="Hyderabadi Dum Biryani" style="width: 100%; height: 100%; object-fit: cover;">
          <span class="badge-nonveg" style="position: absolute; top: 10px; left: 10px; background: rgba(255,255,255,0.9);">● NON-VEG</span>
        </div>
        <div style="flex-grow: 1;">
          <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.35rem;">
            <h3 style="font-size: 1.15rem; font-weight: 700;">Hyderabadi Dum Biryani</h3>
            <span style="font-weight: 800; color: var(--primary); font-size: 1.15rem;">₹380</span>
          </div>
          <p style="font-size: 0.85rem; color: var(--primary); font-weight: 600; margin-bottom: 0.5rem;"><i class="fa-solid fa-store"></i> Hyderabad Biryani House</p>
          <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 1rem;">Sealed clay handi dum biryani cooked with saffron, Kashmiri spices & tender chicken.</p>
        </div>
        <a href="${pageContext.request.contextPath}/restaurant-detail?id=rest-1" class="btn btn-secondary" style="width: 100%;"><i class="fa-solid fa-arrow-right"></i> View Restaurant</a>
      </div>

      <!-- Showcase Dish 2 -->
      <div class="card-glass" style="padding: 1.5rem; display: flex; flex-direction: column; height: 100%;">
        <div style="position: relative; height: 180px; border-radius: var(--radius-md); overflow: hidden; margin-bottom: 1rem;">
          <img src="https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=400&q=80" alt="Classic Dal Makhani" style="width: 100%; height: 100%; object-fit: cover;">
          <span class="badge-veg" style="position: absolute; top: 10px; left: 10px; background: rgba(255,255,255,0.9);">● VEG</span>
        </div>
        <div style="flex-grow: 1;">
          <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.35rem;">
            <h3 style="font-size: 1.15rem; font-weight: 700;">Classic Dal Makhani</h3>
            <span style="font-weight: 800; color: var(--primary); font-size: 1.15rem;">₹340</span>
          </div>
          <p style="font-size: 0.85rem; color: var(--primary); font-weight: 600; margin-bottom: 0.5rem;"><i class="fa-solid fa-store"></i> Bukhara Royal Tandoor</p>
          <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 1rem;">24-hour slow-cooked black lentils simmered with white butter & cream.</p>
        </div>
        <a href="${pageContext.request.contextPath}/restaurant-detail?id=rest-3" class="btn btn-secondary" style="width: 100%;"><i class="fa-solid fa-arrow-right"></i> View Restaurant</a>
      </div>

      <!-- Showcase Dish 3 -->
      <div class="card-glass" style="padding: 1.5rem; display: flex; flex-direction: column; height: 100%;">
        <div style="position: relative; height: 180px; border-radius: var(--radius-md); overflow: hidden; margin-bottom: 1rem;">
          <img src="https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=400&q=80" alt="Ghee Roast Dosa" style="width: 100%; height: 100%; object-fit: cover;">
          <span class="badge-veg" style="position: absolute; top: 10px; left: 10px; background: rgba(255,255,255,0.9);">● VEG</span>
        </div>
        <div style="flex-grow: 1;">
          <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.35rem;">
            <h3 style="font-size: 1.15rem; font-weight: 700;">Ghee Roast Masala Dosa</h3>
            <span style="font-weight: 800; color: var(--primary); font-size: 1.15rem;">₹180</span>
          </div>
          <p style="font-size: 0.85rem; color: var(--primary); font-weight: 600; margin-bottom: 0.5rem;"><i class="fa-solid fa-store"></i> South Spice</p>
          <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 1rem;">Golden crispy crepe roasted in pure cow ghee, served with sambar & coconut chutney.</p>
        </div>
        <a href="${pageContext.request.contextPath}/restaurant-detail?id=rest-6" class="btn btn-secondary" style="width: 100%;"><i class="fa-solid fa-arrow-right"></i> View Restaurant</a>
      </div>
    </div>
  </div>
</section>

<!-- 5. TODAY'S OFFERS -->
<section id="offers" style="padding: 4rem 0; background-color: var(--bg-subtle);">
  <div class="container">
    <div class="section-title-wrap">
      <h2 class="section-title">Today's Offers & Promo Codes</h2>
      <p class="section-subtitle">Copy coupon code and apply at checkout</p>
    </div>

    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.75rem;">
      <div style="background: linear-gradient(135deg, #FF3B30 0%, #FF6B4A 100%); color: #FFF; padding: 2rem; border-radius: var(--radius-xl); box-shadow: var(--shadow-glow); display: flex; justify-content: space-between; align-items: center;">
        <div>
          <span class="badge" style="background: rgba(255,255,255,0.2); color: #FFF; margin-bottom: 0.5rem;">CRAVIO20</span>
          <h3 style="color: #FFF; font-size: 1.75rem;">20% OFF</h3>
          <p style="font-size: 0.9rem; opacity: 0.9;">On orders above ₹400</p>
        </div>
        <button onclick="navigator.clipboard.writeText('CRAVIO20'); window.CravioToast('Code CRAVIO20 copied!', 'success');" class="btn" style="background: #FFF; color: var(--primary); font-weight: 700;">Copy Code</button>
      </div>

      <div style="background: linear-gradient(135deg, #10B981 0%, #059669 100%); color: #FFF; padding: 2rem; border-radius: var(--radius-xl); display: flex; justify-content: space-between; align-items: center;">
        <div>
          <span class="badge" style="background: rgba(255,255,255,0.2); color: #FFF; margin-bottom: 0.5rem;">FREEDEL</span>
          <h3 style="color: #FFF; font-size: 1.75rem;">FREE DELIVERY</h3>
          <p style="font-size: 0.9rem; opacity: 0.9;">No minimum order required</p>
        </div>
        <button onclick="navigator.clipboard.writeText('FREEDEL'); window.CravioToast('Code FREEDEL copied!', 'success');" class="btn" style="background: #FFF; color: #059669; font-weight: 700;">Copy Code</button>
      </div>
    </div>
  </div>
</section>

<!-- 6. TESTIMONIALS -->
<section style="padding: 5rem 0;">
  <div class="container">
    <div class="section-title-wrap">
      <h2 class="section-title">What Diners Say</h2>
      <p class="section-subtitle">Real reviews from food connoisseurs</p>
    </div>

    <div style="max-width: 700px; margin: 0 auto; text-align: center;" class="card-glass testimonial-card" style="padding: 2.5rem;">
      <i class="fa-solid fa-quote-left" style="font-size: 2.5rem; color: var(--primary-light); margin-bottom: 1rem;"></i>
      <p style="font-size: 1.1rem; line-height: 1.8; margin-bottom: 1.5rem; color: var(--text-main);">"Cravio delivered piping hot Hyderabadi Dum Biryani to my apartment in 22 minutes! The thermal packaging kept the flavors completely sealed. Truly a 5-star experience."</p>
      <h4 style="font-weight: 700;">Rohan Sharma</h4>
      <span style="font-size: 0.85rem; color: var(--text-muted);">Food Critic • Hyderabad</span>
    </div>
  </div>
</section>

<!-- 7. DOWNLOAD APP BANNER -->
<section class="container">
  <div class="app-download-banner">
    <div class="app-download-content">
      <h2>Order Faster with Cravio Mobile App</h2>
      <p>Get real-time live order updates, exclusive app-only coupons, and seamless 1-tap checkout.</p>
      <div class="app-store-btns">
        <a href="#" class="app-btn"><i class="fa-brands fa-apple"></i> <div><span style="font-size: 0.7rem; text-transform: uppercase;">Download on</span><br>App Store</div></a>
        <a href="#" class="app-btn"><i class="fa-brands fa-google-play"></i> <div><span style="font-size: 0.7rem; text-transform: uppercase;">Get it on</span><br>Google Play</div></a>
      </div>
    </div>
    <div style="text-align: center;">
      <img src="https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?auto=format&fit=crop&w=400&q=80" alt="Cravio App" style="max-width: 260px; margin: 0 auto; border-radius: 24px; box-shadow: 0 20px 40px rgba(0,0,0,0.3);">
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>