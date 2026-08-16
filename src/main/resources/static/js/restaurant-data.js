/* ==========================================================================
   CRAVIO RESTAURANT DATA — now backed by the real database via
   GET /api/restaurants and GET /api/restaurants/{id}/products, instead of
   a hardcoded array. Everything that used to read window.CravioData.RESTAURANTS
   still works the same way — this file just fills that array from the
   backend instead of from a fixed list, and every dish now carries a real
   `productId` so it can actually be ordered (see cart-store.js / checkout.jsp).

   Other scripts (filter-engine.js, restaurant-detail.jsp) run on
   DOMContentLoaded, which can fire before this fetch finishes. They wait on
   window.CravioData.ready (a Promise) or listen for the 'cravio:data-ready'
   event before rendering — see the patches in those files.
   ========================================================================== */

(function () {
  'use strict';

  // Kept as a static fallback for the city/locality picker UI — the DB
  // schema has no "supported cities" table, so this isn't fetched.
  const LOCATIONS = {
    Hyderabad: ["Jubilee Hills", "Banjara Hills", "Gachibowli", "Madhapur", "HITECH City"],
    Mumbai: ["Bandra West", "Juhu", "Powai", "Andheri East", "Lower Parel"],
    Delhi: ["Connaught Place", "Hauz Khas Village", "Saket", "Cyber City", "Chandni Chowk"],
    Bangalore: ["Indiranagar", "Koramangala", "HSR Layout", "MG Road", "Whitefield"],
    Pune: ["Koregaon Park", "Viman Nagar", "Baner", "Kothrud", "Hinjewadi"]
  };

  const FALLBACK_IMAGE = "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80";

  // Live array — populated in place (not reassigned) so any code holding
  // a reference to window.CravioData.RESTAURANTS sees the real data once
  // it arrives, as long as it re-reads/re-renders after 'cravio:data-ready'.
  const RESTAURANTS = [];

  function mapProduct(p) {
    return {
      id: String(p.id),
      productId: p.id, // real DB id — REQUIRED for CravioCart.addItem / checkout
      category: p.category || 'Menu',
      name: p.name,
      price: Number(p.price),
      isVeg: !!(p.category && /veg(?!.*non)/i.test(p.category)),
      prepTime: '15-20 min',
      isAvailable: p.isAvailable !== false,
      rating: 4.5,
      image: p.imageUrl || FALLBACK_IMAGE,
      desc: p.description || ''
    };
  }

  function mapRestaurant(r, products) {
    const cuisineList = (r.cuisine || '')
      .split(',')
      .map(function (c) { return c.trim(); })
      .filter(Boolean);

    return {
      id: String(r.id),
      name: r.name,
      city: r.city || '',
      locality: r.locality || '',
      address: r.address || '',
      cuisine: cuisineList.length ? cuisineList : ['Multi-cuisine'],
      rating: r.rating != null ? Number(r.rating) : 4.3,
      reviewCount: 100,
      deliveryTime: r.deliveryTime || '30-40 min',
      priceForTwo: r.priceForTwo || 300,
      openingHours: r.openingHours || '10:00 AM - 10:00 PM',
      image: r.imageUrl || FALLBACK_IMAGE,
      banner: r.imageUrl || FALLBACK_IMAGE,
      gallery: r.imageUrl ? [r.imageUrl] : [FALLBACK_IMAGE],
      offer: 'Available on CRAVIO',
      offerCode: '',
      vegOnly: false,
      description: r.description || '',
      menu: products.map(mapProduct)
    };
  }

  async function loadFromBackend() {
    try {
      const restRes = await fetch('/api/restaurants');
      if (!restRes.ok) throw new Error('GET /api/restaurants failed: ' + restRes.status);
      const restaurants = await restRes.json();

      const withMenus = await Promise.all(restaurants.map(async function (r) {
        try {
          const prodRes = await fetch('/api/restaurants/' + r.id + '/products');
          const products = prodRes.ok ? await prodRes.json() : [];
          return mapRestaurant(r, products);
        } catch (innerErr) {
          console.error('CRAVIO: could not load products for restaurant', r.id, innerErr);
          return mapRestaurant(r, []);
        }
      }));

      RESTAURANTS.length = 0;
      RESTAURANTS.push.apply(RESTAURANTS, withMenus);
    } catch (err) {
      console.error('CRAVIO: could not load restaurants from backend. Is the Spring Boot app running on the same origin?', err);
    }
    document.dispatchEvent(new CustomEvent('cravio:data-ready'));
  }

  const readyPromise = loadFromBackend();

  window.CravioData = {
    LOCATIONS: LOCATIONS,
    RESTAURANTS: RESTAURANTS,
    ready: readyPromise, // await/`.then()` this before reading RESTAURANTS
    getCurrentLocation: function () {
      return JSON.parse(localStorage.getItem('cravio_user_location')) || { city: "Hyderabad", locality: "Jubilee Hills" };
    },
    setCurrentLocation: function (city, locality) {
      const loc = { city: city, locality: locality };
      localStorage.setItem('cravio_user_location', JSON.stringify(loc));
      return loc;
    },
    getRestaurantById: function (id) {
      return RESTAURANTS.find(function (r) { return r.id === String(id); }) || null;
    }
  };
})();
