<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "About Us");
    request.setAttribute("activePage", "about");
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<!-- HERO STORY -->
<section style="padding: 4rem 0; background-color: var(--bg-subtle);">
  <div class="container" style="text-align: center; max-width: 800px;">
    <span class="badge badge-offer" style="margin-bottom: 1rem;"><i class="fa-solid fa-heart"></i> OUR STORY</span>
    <h1 style="font-size: 3rem; margin-bottom: 1.25rem;">Redefining Fine Dining <br>At Your <span class="text-gradient">Doorstep</span></h1>
    <p style="font-size: 1.15rem; color: var(--text-muted); line-height: 1.8;">
      Cravio was born out of a passion to bridge the gap between Michelin-quality restaurant kitchens and modern, lightning-fast food delivery. We believe every meal should be a memorable culinary experience.
    </p>
  </div>
</section>

<!-- MISSION & VISION -->
<section style="padding: 5rem 0;">
  <div class="container" style="display: grid; grid-template-columns: 1fr 1fr; gap: 2.5rem;">
    <div class="card-glass" style="padding: 2.5rem;">
      <div style="width: 54px; height: 54px; border-radius: 14px; background: var(--primary-light); color: var(--primary); display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 1.25rem;">
        <i class="fa-solid fa-bullseye"></i>
      </div>
      <h2 style="font-size: 1.75rem; margin-bottom: 0.75rem;">Our Mission</h2>
      <p style="color: var(--text-muted); line-height: 1.7;">To empower independent chefs, luxury bistros, and passionate food lovers by delivering piping hot, fresh meals using eco-friendly electric fleets and precision logistics.</p>
    </div>

    <div class="card-glass" style="padding: 2.5rem;">
      <div style="width: 54px; height: 54px; border-radius: 14px; background: rgba(59,130,246,0.15); color: #3B82F6; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 1.25rem;">
        <i class="fa-solid fa-eye"></i>
      </div>
      <h2 style="font-size: 1.75rem; margin-bottom: 0.75rem;">Our Vision</h2>
      <p style="color: var(--text-muted); line-height: 1.7;">To become the world's most trusted culinary ecosystem where quality food, sustainability, and technological innovation converge seamlessly.</p>
    </div>
  </div>
</section>

<!-- JOURNEY TIMELINE -->
<section style="padding: 4rem 0; background-color: var(--bg-subtle);" id="journey">
  <div class="container">
    <div class="section-title-wrap">
      <h2 class="section-title">The Cravio Journey</h2>
      <p class="section-subtitle">From a small startup to a luxury delivery platform</p>
    </div>

    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 2rem; margin-top: 3rem;">
      <div class="card-glass" style="padding: 2rem;">
        <span style="font-size: 1.75rem; font-weight: 800; color: var(--primary); font-family: var(--font-heading);">2022</span>
        <h3 style="font-size: 1.15rem; margin: 0.5rem 0;">Cravio Founded</h3>
        <p style="font-size: 0.9rem; color: var(--text-muted);">Launched in Manhattan with 15 partner restaurants and 10 electric scooters.</p>
      </div>

      <div class="card-glass" style="padding: 2rem;">
        <span style="font-size: 1.75rem; font-weight: 800; color: var(--primary); font-family: var(--font-heading);">2024</span>
        <h3 style="font-size: 1.15rem; margin: 0.5rem 0;">100k+ Orders Milestone</h3>
        <p style="font-size: 0.9rem; color: var(--text-muted);">Expanded across 12 major metropolitan cities with 18-minute average delivery time.</p>
      </div>

      <div class="card-glass" style="padding: 2rem;">
        <span style="font-size: 1.75rem; font-weight: 800; color: var(--primary); font-family: var(--font-heading);">2026</span>
        <h3 style="font-size: 1.15rem; margin: 0.5rem 0;">Global Gourmet Network</h3>
        <p style="font-size: 0.9rem; color: var(--text-muted);">Over 500+ handpicked partner kitchens and AI-driven thermal tracking.</p>
      </div>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>