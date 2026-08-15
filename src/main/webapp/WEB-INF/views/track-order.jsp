<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "Track Live Order");
    request.setAttribute("activePage", "cart");
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<!-- Include Leaflet CSS for OpenStreetMap -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

<section class="container" style="padding: 2.5rem 0 4rem 0;">
  <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; flex-wrap: wrap; gap: 1rem;">
    <div>
      <span class="badge badge-offer" id="trackingStageBadge" style="margin-bottom: 0.5rem;">OUT FOR DELIVERY</span>
      <h1 style="font-size: 2.25rem;">Live Order Tracking</h1>
      <p style="color: var(--text-muted);">Order #CRV-98421 • Hyderabad Biryani House</p>
    </div>
    <div style="text-align: right;">
      <div style="font-size: 0.85rem; color: var(--text-muted);">Estimated Delivery</div>
      <div style="font-size: 2rem; font-weight: 800; color: var(--primary);" id="trackingEtaText">18 Mins</div>
    </div>
  </div>

  <div class="checkout-grid">
    <!-- LEFT: MAP & TIMELINE PROGRESS -->
    <div>
      <!-- LIVE SIMULATED MAP CONTAINER -->
      <div class="card-glass" style="padding: 1rem; margin-bottom: 2rem; position: relative;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.75rem; padding: 0 0.5rem;">
          <span style="font-size: 0.9rem; font-weight: 700;"><i class="fa-solid fa-location-arrow" style="color: var(--primary);"></i> Live Route Simulation</span>
          <span style="font-size: 0.8rem; color: var(--accent-green); font-weight: 600;"><i class="fa-solid fa-circle-dot fa-beat"></i> GPS Active</span>
        </div>

        <div id="deliveryMapContainer" style="height: 340px; border-radius: var(--radius-lg); overflow: hidden; z-index: 1;"></div>

        <div style="margin-top: 1rem; padding: 0.75rem 1rem; background: var(--bg-subtle); border-radius: var(--radius-md); font-size: 0.9rem; font-weight: 600; color: var(--text-main); display: flex; align-items: center; gap: 0.75rem;">
          <i class="fa-solid fa-motorcycle" style="color: var(--primary); font-size: 1.25rem;"></i>
          <span id="trackingStatusText">Rider crossed City Centre Mall. Out for delivery!</span>
        </div>
      </div>

      <!-- PROGRESS BAR & TIMELINE STEPS -->
      <div class="summary-card" style="margin-bottom: 2rem;">
        <h3 style="font-size: 1.2rem; margin-bottom: 1rem;">Order Progress</h3>
        
        <div class="progress-bar-wrap" style="margin-bottom: 1.75rem; height: 10px; background: var(--bg-subtle); border-radius: 10px; overflow: hidden;">
          <div class="progress-bar-fill" id="trackingProgressFill" style="width: 75%; height: 100%; background: linear-gradient(90deg, #FF3B30, #FF6B4A); transition: width 0.8s ease;"></div>
        </div>

        <div class="timeline-container" style="display: flex; justify-content: space-between; position: relative;">
          <div class="timeline-step completed" style="text-align: center;">
            <div class="step-icon" style="width: 38px; height: 38px; border-radius: 50%; background: var(--primary); color: #FFF; display: flex; align-items: center; justify-content: center; margin: 0 auto 0.5rem auto;"><i class="fa-solid fa-check"></i></div>
            <strong style="font-size: 0.85rem; display: block;">Confirmed</strong>
          </div>
          <div class="timeline-step completed" style="text-align: center;">
            <div class="step-icon" style="width: 38px; height: 38px; border-radius: 50%; background: var(--primary); color: #FFF; display: flex; align-items: center; justify-content: center; margin: 0 auto 0.5rem auto;"><i class="fa-solid fa-fire-burner"></i></div>
            <strong style="font-size: 0.85rem; display: block;">Preparing</strong>
          </div>
          <div class="timeline-step completed" style="text-align: center;">
            <div class="step-icon" style="width: 38px; height: 38px; border-radius: 50%; background: var(--primary); color: #FFF; display: flex; align-items: center; justify-content: center; margin: 0 auto 0.5rem auto;"><i class="fa-solid fa-bag-shopping"></i></div>
            <strong style="font-size: 0.85rem; display: block;">Picked Up</strong>
          </div>
          <div class="timeline-step completed" style="text-align: center;">
            <div class="step-icon" style="width: 38px; height: 38px; border-radius: 50%; background: var(--primary); color: #FFF; display: flex; align-items: center; justify-content: center; margin: 0 auto 0.5rem auto;"><i class="fa-solid fa-motorcycle"></i></div>
            <strong style="font-size: 0.85rem; display: block;">On The Way</strong>
          </div>
          <div class="timeline-step" style="text-align: center;">
            <div class="step-icon" style="width: 38px; height: 38px; border-radius: 50%; background: var(--bg-subtle); color: var(--text-muted); display: flex; align-items: center; justify-content: center; margin: 0 auto 0.5rem auto;"><i class="fa-solid fa-house"></i></div>
            <strong style="font-size: 0.85rem; display: block;">Delivered</strong>
          </div>
        </div>
      </div>
    </div>

    <!-- RIGHT: DELIVERY PARTNER CARD & ORDER SUMMARY -->
    <div>
      <!-- INDIAN DELIVERY PARTNER CARD -->
      <div class="summary-card" style="margin-bottom: 2rem;">
        <h3 style="font-size: 1.25rem; margin-bottom: 1.25rem;">Delivery Partner</h3>
        
        <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 1.25rem;">
          <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80" id="riderPhoto" alt="Delivery Partner" style="width: 64px; height: 64px; border-radius: 50%; object-fit: cover; border: 2px solid var(--primary);">
          <div>
            <h4 style="font-size: 1.15rem; font-weight: 700;" id="riderName">Rahul Sharma</h4>
            <div style="font-size: 0.85rem; color: var(--text-muted);" id="riderRating"><i class="fa-solid fa-star" style="color: #FFB800;"></i> 4.9 (450+ deliveries)</div>
            <span style="font-size: 0.8rem; font-weight: 700; color: var(--primary);" id="riderBike">Bike: TS-09-EA-4587</span>
          </div>
        </div>

        <div style="display: flex; gap: 0.75rem;">
          <a href="tel:+919876543210" id="riderCallBtn" class="btn" style="flex: 1; background: #10B981; color: #FFF; text-align: center; font-weight: 700; text-decoration: none; display: flex; align-items: center; justify-content: center; gap: 0.5rem;">
            <i class="fa-solid fa-phone"></i> Call Rahul
          </a>
          <button onclick="openRiderChat()" class="btn btn-secondary" style="flex: 1; display: flex; align-items: center; justify-content: center; gap: 0.5rem;">
            <i class="fa-solid fa-comments"></i> Chat
          </button>
        </div>
      </div>

      <!-- ORDER DETAILS & SUMMARY -->
      <div class="summary-card">
        <h3 style="font-size: 1.2rem; margin-bottom: 1rem;">Order Details</h3>
        
        <div style="border-bottom: 1px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 1rem;">
          <div style="display: flex; justify-content: space-between; font-size: 0.9rem; margin-bottom: 0.5rem;">
            <span>Hyderabadi Chicken Dum Biryani x 2</span>
            <strong>₹760</strong>
          </div>
          <div style="display: flex; justify-content: space-between; font-size: 0.9rem;">
            <span>Double Ka Meetha x 1</span>
            <strong>₹160</strong>
          </div>
        </div>

        <div class="summary-row">
          <span>Subtotal</span>
          <strong>₹920</strong>
        </div>
        <div class="summary-row">
          <span>Delivery Fee</span>
          <span>FREE</span>
        </div>
        <div class="summary-row">
          <span>Taxes (GST 5%)</span>
          <span>₹46</span>
        </div>
        
        <div class="summary-total" style="display: flex; justify-content: space-between;">
          <span>Paid Total</span>
          <span style="color: var(--primary);">₹966</span>
        </div>

        <div style="margin-top: 1rem; font-size: 0.85rem; color: var(--text-muted); display: flex; align-items: center; gap: 0.5rem;">
          <i class="fa-solid fa-house" style="color: var(--primary);"></i> Delivering to Flat 402, Jubilee Heights, Jubilee Hills, Hyderabad
        </div>
      </div>
    </div>
  </div>
</section>

<!-- RIDER CHAT MODAL -->
<div class="modal-overlay" id="riderChatModalOverlay">
  <div class="modal-card" style="max-width: 440px; padding: 0; overflow: hidden; border-radius: var(--radius-xl);">
    <div style="background: var(--primary); color: #FFF; padding: 1rem 1.25rem; display: flex; justify-content: space-between; align-items: center;">
      <div style="display: flex; align-items: center; gap: 0.75rem;">
        <div style="width: 10px; height: 10px; border-radius: 50%; background: #10B981;"></div>
        <strong style="font-size: 1rem;" id="riderChatTitle">Chat with Rahul Sharma</strong>
      </div>
      <button onclick="closeRiderChat()" style="color: #FFF; background: transparent; border: none; font-size: 1.2rem; cursor: pointer;"><i class="fa-solid fa-xmark"></i></button>
    </div>

    <div id="riderChatBody" style="height: 320px; overflow-y: auto; padding: 1.25rem; display: flex; flex-direction: column;">
      <div class="chat-msg bot" style="align-self: flex-start; background: var(--bg-subtle); color: var(--text-main); padding: 0.75rem 1rem; border-radius: 16px 16px 16px 2px; max-width: 80%; margin-bottom: 0.75rem;">
        <div>Hello! I have picked up your order from Hyderabad Biryani House and I'm on my way.</div>
        <div style="font-size: 0.7rem; color: var(--text-muted); margin-top: 0.25rem;">Just now</div>
      </div>
    </div>

    <div style="padding: 0.85rem 1rem; border-top: 1px solid var(--border-color); display: flex; gap: 0.5rem; background: var(--bg-surface);">
      <input type="text" id="riderChatInput" placeholder="Type your message to rider..." class="form-input" style="flex: 1;" onkeypress="if(event.key === 'Enter') sendRiderChatMessage()">
      <button onclick="sendRiderChatMessage()" class="btn btn-primary btn-sm"><i class="fa-solid fa-paper-plane"></i></button>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

<!-- Include Leaflet JS for OpenStreetMap -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script src="${pageContext.request.contextPath}/js/delivery-data.js"></script>
<script src="${pageContext.request.contextPath}/js/tracking-engine.js"></script>
