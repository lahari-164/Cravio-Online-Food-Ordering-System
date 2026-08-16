/* ==========================================================================
   CRAVIO SEARCH, FILTER & LOCATION ENGINE
   Specific locality filtering (3+ restaurants per locality) & sorting
   ========================================================================== */

(function () {
  'use strict';

  let currentSearch = '';
  let selectedCuisines = [];
  let selectedRating = 0;
  let selectedPriceMax = Infinity;
  let selectedSort = 'recommended';
  let vegOnlyFilter = false;

  function initFilterEngine() {
    const searchInput = document.getElementById('searchInput') || document.querySelector('.listing-header input') || document.querySelector('.form-input[placeholder*="Search"]');
    if (searchInput) {
      searchInput.addEventListener('input', (e) => {
        currentSearch = e.target.value.toLowerCase().trim();
        renderFilteredRestaurants();
      });
    }

    // Cuisine checkboxes
    document.querySelectorAll('.filter-cuisine-cb').forEach(cb => {
      cb.addEventListener('change', () => {
        selectedCuisines = Array.from(document.querySelectorAll('.filter-cuisine-cb:checked')).map(el => el.value);
        renderFilteredRestaurants();
      });
    });

    // Rating radios
    document.querySelectorAll('input[name="ratingRadio"]').forEach(radio => {
      radio.addEventListener('change', (e) => {
        selectedRating = parseFloat(e.target.value) || 0;
        renderFilteredRestaurants();
      });
    });

    // Price Filter radios / checkboxes
    document.querySelectorAll('input[name="priceRadio"]').forEach(radio => {
      radio.addEventListener('change', (e) => {
        selectedPriceMax = parseFloat(e.target.value) || Infinity;
        renderFilteredRestaurants();
      });
    });

    // Veg Only Filter
    const vegOnlyCb = document.getElementById('filterVegOnly');
    if (vegOnlyCb) {
      vegOnlyCb.addEventListener('change', (e) => {
        vegOnlyFilter = e.target.checked;
        renderFilteredRestaurants();
      });
    }

    // Sorting Tabs
    document.querySelectorAll('.sorting-tabs .tab-btn').forEach(btn => {
      btn.addEventListener('click', (e) => {
        document.querySelectorAll('.sorting-tabs .tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        const sortType = btn.getAttribute('data-sort') || btn.textContent.toLowerCase();
        if (sortType.includes('rating')) selectedSort = 'rating';
        else if (sortType.includes('low to high')) selectedSort = 'price_asc';
        else if (sortType.includes('high to low')) selectedSort = 'price_desc';
        else if (sortType.includes('delivery')) selectedSort = 'speed';
        else selectedSort = 'recommended';
        renderFilteredRestaurants();
      });
    });

    renderFilteredRestaurants();
    renderExploreFoodsGrid();
  }

  function getFilteredData() {
    if (!window.CravioData) return [];
    let list = [...window.CravioData.RESTAURANTS];
    const userLoc = window.CravioData.getCurrentLocation();

    // Filter strictly by City AND Locality if NOT "ALL"
    if (userLoc && userLoc.city && userLoc.city !== 'ALL') {
      let cityMatches = list.filter(r => r.city.toLowerCase() === userLoc.city.toLowerCase());
      
      if (userLoc.locality && userLoc.locality !== 'ALL') {
        const localityMatches = cityMatches.filter(r => r.locality.toLowerCase() === userLoc.locality.toLowerCase());
        if (localityMatches.length > 0) {
          cityMatches = localityMatches;
        }
      }

      if (cityMatches.length > 0) {
        list = cityMatches;
      }
    }

    // Search query filter
    if (currentSearch) {
      list = list.filter(r => {
        const nameMatch = r.name.toLowerCase().includes(currentSearch);
        const cuisineMatch = r.cuisine.some(c => c.toLowerCase().includes(currentSearch));
        const dishMatch = r.menu.some(d => d.name.toLowerCase().includes(currentSearch));
        return nameMatch || cuisineMatch || dishMatch;
      });
    }

    // Cuisine filter
    if (selectedCuisines.length > 0) {
      list = list.filter(r => r.cuisine.some(c => selectedCuisines.includes(c)));
    }

    // Rating filter
    if (selectedRating > 0) {
      list = list.filter(r => r.rating >= selectedRating);
    }

    // Price Max filter
    if (selectedPriceMax < Infinity) {
      list = list.filter(r => r.priceForTwo <= selectedPriceMax);
    }

    // Veg Only filter
    if (vegOnlyFilter) {
      list = list.filter(r => r.vegOnly || r.menu.some(d => d.isVeg));
    }

    // Sorting
    if (selectedSort === 'rating') {
      list.sort((a, b) => b.rating - a.rating);
    } else if (selectedSort === 'price_asc') {
      list.sort((a, b) => a.priceForTwo - b.priceForTwo);
    } else if (selectedSort === 'price_desc') {
      list.sort((a, b) => b.priceForTwo - a.priceForTwo);
    }

    return list;
  }

  function renderFilteredRestaurants() {
    const grid = document.getElementById('restaurantGridContainer');
    const countEl = document.getElementById('restaurantCountBadge');
    if (!grid) return;

    const data = getFilteredData();
    if (countEl) countEl.textContent = `${data.length} Restaurants Found`;

    if (data.length === 0) {
      grid.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 4rem 1rem;">
          <i class="fa-solid fa-utensils" style="font-size: 3rem; color: var(--text-muted); margin-bottom: 1rem;"></i>
          <h3>No restaurants found in this location/filter</h3>
          <p style="color: var(--text-muted); margin-top: 0.5rem;">Try selecting "View All Localities" or clear your filters.</p>
          <button class="btn btn-primary" style="margin-top: 1.5rem;" onclick="window.CravioData.setCurrentLocation('ALL', 'ALL'); location.reload();">View All Locations</button>
        </div>
      `;
      return;
    }

    const detailUrl = '/restaurant-detail';

    grid.innerHTML = data.map(r => `
      <div class="card-glass restaurant-card">
        <div class="restaurant-img-wrapper">
          <img src="${r.image}" alt="${r.name}" class="restaurant-img">
          <div class="restaurant-offer-tag">${r.offer}</div>
        </div>
        <div class="restaurant-content">
          <div class="restaurant-header-row">
            <h3 class="restaurant-title"><a href="${detailUrl}?id=${r.id}">${r.name}</a></h3>
            <div class="restaurant-rating"><i class="fa-solid fa-star"></i> ${r.rating}</div>
          </div>
          <p style="font-size: 0.85rem; color: var(--text-muted);">${r.cuisine.join(' • ')}</p>
          <div style="font-size: 0.85rem; font-weight: 700; color: var(--primary); margin-top: 0.25rem;">₹${r.priceForTwo} for two</div>
          <div class="restaurant-meta">
            <span><i class="fa-regular fa-clock"></i> ${r.deliveryTime}</span>
            <span><i class="fa-solid fa-location-dot"></i> ${r.locality}, ${r.city}</span>
          </div>
          <a href="${detailUrl}?id=${r.id}" class="btn btn-secondary btn-sm" style="margin-top: 1rem; width: 100%;">View Menu & Order</a>
        </div>
      </div>
    `).join('');
  }

  function renderExploreFoodsGrid() {
    const exploreContainer = document.getElementById('exploreFoodsGrid');
    if (!exploreContainer || !window.CravioData) return;

    let allDishes = [];
    window.CravioData.RESTAURANTS.forEach(r => {
      r.menu.forEach(d => {
        allDishes.push({ ...d, restaurantName: r.name, restaurantId: r.id });
      });
    });

    exploreContainer.innerHTML = allDishes.map(d => `
      <div class="dish-card" style="display: flex; gap: 1rem; align-items: center;">
        <img src="${d.image}" alt="${d.name}" style="width: 100px; height: 100px; border-radius: var(--radius-md); object-fit: cover;">
        <div style="flex-grow: 1;">
          <div style="font-size: 0.75rem; font-weight: 700; color: ${d.isVeg ? 'var(--accent-green)' : 'var(--primary)'}; margin-bottom: 0.2rem;">
            ${d.isVeg ? '● VEG' : '● NON-VEG'}
          </div>
          <h4 style="font-size: 1.05rem; font-weight: 700;">${d.name}</h4>
          <span style="font-size: 0.8rem; color: var(--text-muted);">${d.restaurantName}</span>
          <div style="font-size: 1.1rem; font-weight: 800; color: var(--primary); margin-top: 0.25rem;">₹${d.price}</div>
        </div>
        <button class="btn btn-primary btn-sm" onclick="CravioCart.addItem({id: '${d.id}', productId: ${d.productId}, name: '${d.name.replace(/'/g, "\\'")}', price: ${d.price}, image: '${d.image}', restaurant: '${d.restaurantName.replace(/'/g, "\\'")}', restaurantId: '${d.restaurantId}'})">
          <i class="fa-solid fa-plus"></i> Add
        </button>
      </div>
    `).join('');
  }

  // NEW — restaurant-data.js now loads restaurants/menu from the backend
  // asynchronously (GET /api/restaurants), so it may not have finished by
  // the time DOMContentLoaded fires. Wait for it, then render; also
  // re-render whenever fresh data arrives (covers any later reload).
  document.addEventListener('DOMContentLoaded', function () {
    if (window.CravioData && window.CravioData.ready && typeof window.CravioData.ready.then === 'function') {
      window.CravioData.ready.then(initFilterEngine);
    } else {
      initFilterEngine();
    }
  });

  document.addEventListener('cravio:data-ready', function () {
    renderFilteredRestaurants();
    renderExploreFoodsGrid();
  });

  window.CravioFilter = {
    renderFilteredRestaurants,
    renderExploreFoodsGrid
  };
})();
