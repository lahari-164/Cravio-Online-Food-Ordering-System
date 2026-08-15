/* ==========================================================================
   CRAVIO LIVE GPS TRACKING & RIDER CHAT SIMULATION ENGINE
   OpenStreetMap bike animation, status timeline updates & rider chat
   ========================================================================== */

(function () {
  'use strict';

  let currentStage = 0; // 0: Confirmed, 1: Preparing, 2: Picked Up, 3: Out for Delivery, 4: Delivered
  let trackingTimer = null;
  let activeRider = null;
  let mapInstance = null;
  let bikeMarker = null;

  // Route Coordinates (Hyderabad Jubilee Hills Simulation)
  const ROUTE = [
    [17.4319, 78.4071], // Restaurant (Hyderabad Biryani House)
    [17.4325, 78.4095], // Jubilee Hills Rd 36
    [17.4338, 78.4120], // City Centre Mall crossing
    [17.4350, 78.4145], // Near Gate 2
    [17.4362, 78.4168]  // Customer Address (Flat 402, Jubilee Heights)
  ];

  const STATUS_TEXTS = [
    "Order confirmed! Restaurant has received your request.",
    "Chef is preparing your Hyderabadi Dum Biryani with fresh ingredients...",
    "Order ready! Rider Rahul Sharma has picked up your food bag.",
    "Rider crossed City Centre Mall. Out for delivery!",
    "Rider is arriving at your gate...",
    "Order Delivered Successfully! Enjoy your gourmet meal."
  ];

  function initTrackingEngine() {
    // Pick random Indian delivery partner
    if (window.CravioDelivery) {
      activeRider = window.CravioDelivery.getRandomPartner();
    } else {
      activeRider = {
        name: "Rahul Sharma",
        phone: "+91 98765 43210",
        bikeNumber: "TS-09-EA-4587",
        rating: 4.9,
        photo: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80"
      };
    }

    renderRiderCard(activeRider);
    initLeafletMap();
    startProgressTimer();
  }

  function renderRiderCard(rider) {
    const photoEl = document.getElementById('riderPhoto');
    const nameEl = document.getElementById('riderName');
    const ratingEl = document.getElementById('riderRating');
    const bikeEl = document.getElementById('riderBike');
    const callBtn = document.getElementById('riderCallBtn');

    if (photoEl) photoEl.src = rider.photo;
    if (nameEl) nameEl.textContent = rider.name;
    if (ratingEl) ratingEl.innerHTML = `<i class="fa-solid fa-star" style="color: #FFB800;"></i> ${rider.rating} (${rider.reviewCount || 450}+ deliveries)`;
    if (bikeEl) bikeEl.textContent = `Bike: ${rider.bikeNumber}`;
    if (callBtn) {
      const cleanPhone = rider.phone.replace(/[^0-9+]/g, '');
      callBtn.href = `tel:${cleanPhone}`;
      callBtn.innerHTML = `<i class="fa-solid fa-phone"></i> Call ${rider.name.split(' ')[0]} (${rider.phone})`;
    }

    // Set rider name in chat title
    const chatTitle = document.getElementById('riderChatTitle');
    if (chatTitle) chatTitle.textContent = `Chat with ${rider.name}`;
  }

  function initLeafletMap() {
    const mapEl = document.getElementById('deliveryMapContainer');
    if (!mapEl || typeof L === 'undefined') return;

    // Center map between Restaurant and Customer
    mapInstance = L.map('deliveryMapContainer', { zoomControl: false }).setView([17.4340, 78.4120], 15);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; OpenStreetMap contributors'
    }).addTo(mapInstance);

    // Restaurant Marker
    const restIcon = L.divIcon({
      className: 'custom-map-icon rest-marker',
      html: `<div style="background: #FF3B30; color: #FFF; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.1rem; box-shadow: 0 4px 10px rgba(0,0,0,0.3);"><i class="fa-solid fa-utensils"></i></div>`,
      iconSize: [36, 36]
    });
    L.marker(ROUTE[0], { icon: restIcon }).addTo(mapInstance).bindPopup("Hyderabad Biryani House");

    // Customer Marker
    const custIcon = L.divIcon({
      className: 'custom-map-icon cust-marker',
      html: `<div style="background: #10B981; color: #FFF; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.1rem; box-shadow: 0 4px 10px rgba(0,0,0,0.3);"><i class="fa-solid fa-house"></i></div>`,
      iconSize: [36, 36]
    });
    L.marker(ROUTE[ROUTE.length - 1], { icon: custIcon }).addTo(mapInstance).bindPopup("Your Delivery Address");

    // Polyline Route
    L.polyline(ROUTE, { color: '#FF3B30', weight: 4, opacity: 0.7, dashArray: '8, 8' }).addTo(mapInstance);

    // Moving Bike Marker
    const bikeIcon = L.divIcon({
      className: 'custom-map-icon bike-marker',
      html: `<div style="background: #000; color: #FFF; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; border: 2px solid #FFF; box-shadow: 0 6px 15px rgba(0,0,0,0.4);"><i class="fa-solid fa-motorcycle" style="color: #FF3B30;"></i></div>`,
      iconSize: [40, 40]
    });

    bikeMarker = L.marker(ROUTE[0], { icon: bikeIcon }).addTo(mapInstance);
  }

  function startProgressTimer() {
    let stepIndex = 0;
    
    trackingTimer = setInterval(() => {
      stepIndex++;
      if (stepIndex >= ROUTE.length) {
        stepIndex = ROUTE.length - 1;
        clearInterval(trackingTimer);
      }

      // Update bike marker position on map
      if (bikeMarker && ROUTE[stepIndex]) {
        bikeMarker.setLatLng(ROUTE[stepIndex]);
        if (mapInstance) mapInstance.panTo(ROUTE[stepIndex]);
      }

      // Update stage progression
      if (stepIndex === 0) currentStage = 0; // Confirmed
      else if (stepIndex === 1) currentStage = 1; // Preparing
      else if (stepIndex === 2) currentStage = 2; // Picked Up
      else if (stepIndex === 3) currentStage = 3; // Out for Delivery
      else if (stepIndex === 4) currentStage = 4; // Delivered

      updateTrackingUI(stepIndex);
    }, 4500);
  }

  function updateTrackingUI(stepIndex) {
    const progressFill = document.getElementById('trackingProgressFill');
    const statusTextEl = document.getElementById('trackingStatusText');
    const etaEl = document.getElementById('trackingEtaText');
    const badgeEl = document.getElementById('trackingStageBadge');

    const percent = Math.min(100, Math.round(((stepIndex + 1) / ROUTE.length) * 100));
    if (progressFill) progressFill.style.width = `${percent}%`;

    if (statusTextEl) statusTextEl.textContent = STATUS_TEXTS[stepIndex] || STATUS_TEXTS[0];

    const remainingMins = Math.max(0, 18 - (stepIndex * 4));
    if (etaEl) {
      etaEl.textContent = remainingMins > 0 ? `${remainingMins} Mins` : 'Delivered!';
    }

    if (badgeEl) {
      if (stepIndex === 4) {
        badgeEl.className = 'badge';
        badgeEl.style.background = '#10B981';
        badgeEl.style.color = '#FFF';
        badgeEl.textContent = 'DELIVERED';
      } else {
        badgeEl.className = 'badge badge-offer';
        badgeEl.textContent = 'OUT FOR DELIVERY';
      }
    }

    // Update timeline steps UI
    document.querySelectorAll('.timeline-step').forEach((step, idx) => {
      if (idx <= stepIndex) {
        step.classList.add('completed');
      } else {
        step.classList.remove('completed');
      }
    });
  }

  // RIDER CHAT SIMULATION
  window.openRiderChat = function () {
    const overlay = document.getElementById('riderChatModalOverlay');
    if (overlay) overlay.classList.add('active');
  };

  window.closeRiderChat = function () {
    const overlay = document.getElementById('riderChatModalOverlay');
    if (overlay) overlay.classList.remove('active');
  };

  window.sendRiderChatMessage = function () {
    const input = document.getElementById('riderChatInput');
    const body = document.getElementById('riderChatBody');
    if (!input || !body) return;

    const text = input.value.trim();
    if (!text) return;

    const now = new Date();
    const timeStr = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

    // Customer message
    const custMsg = document.createElement('div');
    custMsg.className = 'chat-msg user';
    custMsg.style.alignSelf = 'flex-end';
    custMsg.style.background = 'var(--primary)';
    custMsg.style.color = '#FFF';
    custMsg.style.padding = '0.75rem 1rem';
    custMsg.style.borderRadius = '16px 16px 2px 16px';
    custMsg.style.maxWidth = '80%';
    custMsg.style.marginBottom = '0.75rem';
    custMsg.innerHTML = `<div>${text}</div><div style="font-size: 0.7rem; opacity: 0.8; text-align: right; margin-top: 0.25rem;">${timeStr} • <i class="fa-solid fa-check-double"></i></div>`;
    body.appendChild(custMsg);

    input.value = '';
    body.scrollTop = body.scrollHeight;

    // Typing indicator
    const typingIndicator = document.createElement('div');
    typingIndicator.id = 'riderTypingIndicator';
    typingIndicator.style.fontSize = '0.8rem';
    typingIndicator.style.color = 'var(--text-muted)';
    typingIndicator.style.fontStyle = 'italic';
    typingIndicator.style.marginBottom = '0.5rem';
    typingIndicator.textContent = `${activeRider ? activeRider.name.split(' ')[0] : 'Rahul'} is typing...`;
    body.appendChild(typingIndicator);
    body.scrollTop = body.scrollHeight;

    // Simulated Auto Reply
    setTimeout(() => {
      typingIndicator.remove();

      const riderMsg = document.createElement('div');
      riderMsg.className = 'chat-msg bot';
      riderMsg.style.alignSelf = 'flex-start';
      riderMsg.style.background = 'var(--bg-subtle)';
      riderMsg.style.color = 'var(--text-main)';
      riderMsg.style.padding = '0.75rem 1rem';
      riderMsg.style.borderRadius = '16px 16px 16px 2px';
      riderMsg.style.maxWidth = '80%';
      riderMsg.style.marginBottom = '0.75rem';

      const replies = [
        "I am 5 minutes away, sir!",
        "Sure! Arriving near Gate 2 shortly.",
        "Traffic cleared, reaching your building now."
      ];
      const replyText = replies[Math.floor(Math.random() * replies.length)];

      riderMsg.innerHTML = `<div>${replyText}</div><div style="font-size: 0.7rem; color: var(--text-muted); margin-top: 0.25rem;">${timeStr}</div>`;
      body.appendChild(riderMsg);
      body.scrollTop = body.scrollHeight;
    }, 1500);
  };

  document.addEventListener('DOMContentLoaded', () => {
    if (document.getElementById('deliveryMapContainer')) {
      initTrackingEngine();
    }
  });

  window.CravioTracking = {
    initTrackingEngine,
    openRiderChat,
    closeRiderChat,
    sendRiderChatMessage
  };
})();
