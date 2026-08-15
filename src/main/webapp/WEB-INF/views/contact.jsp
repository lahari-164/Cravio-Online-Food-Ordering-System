<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "Contact Us");
    request.setAttribute("activePage", "contact");
%>
<%@ include file="header.jsp" %>
<%@ include file="navbar.jsp" %>

<!-- CONTACT HERO -->
<section style="padding: 3.5rem 0 2rem 0; background-color: var(--bg-subtle);">
  <div class="container" style="text-align: center; max-width: 700px;">
    <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">We'd Love to Hear From You</h1>
    <p style="color: var(--text-muted);">Have a question about an order, restaurant partnership, or feedback? Contact the Cravio Concierge team.</p>
  </div>
</section>

<!-- CONTACT GRID & FORM -->
<section class="container" style="padding: 4rem 0;">
  <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 3rem;">
    <!-- FORM -->
    <div class="card-glass" style="padding: 2.5rem;">
      <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem;">Send Us a Message</h2>
      
      <form onsubmit="event.preventDefault(); window.CravioToast('Message sent! Our team will respond within 15 minutes.', 'success'); this.reset();">
        <div class="form-group">
          <label class="form-label">Full Name</label>
          <input type="text" class="form-input" placeholder="Sarah Jenkins" required>
        </div>
        <div class="form-group">
          <label class="form-label">Email Address</label>
          <input type="email" class="form-input" placeholder="sarah@example.com" required>
        </div>
        <div class="form-group">
          <label class="form-label">Subject</label>
          <input type="text" class="form-input" placeholder="Order Inquiry / Partnership" required>
        </div>
        <div class="form-group">
          <label class="form-label">Your Message</label>
          <textarea class="form-input" rows="4" placeholder="How can we help you today?" required style="resize: vertical;"></textarea>
        </div>
        <button type="submit" class="btn btn-primary btn-lg" style="width: 100%;">
          <i class="fa-solid fa-paper-plane"></i> Send Message
        </button>
      </form>
    </div>

    <!-- SUPPORT INFO CARDS & MAP -->
    <div>
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem; margin-bottom: 2rem;">
        <div class="card-glass" style="padding: 1.5rem;">
          <i class="fa-solid fa-phone" style="font-size: 1.5rem; color: var(--primary); margin-bottom: 0.75rem;"></i>
          <h4 style="font-weight: 700;">24/7 Support Line</h4>
          <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 0.25rem;">+1 (800) 555-CRAVIO</p>
        </div>

        <div class="card-glass" style="padding: 1.5rem;">
          <i class="fa-solid fa-envelope" style="font-size: 1.5rem; color: var(--accent-blue); margin-bottom: 0.75rem;"></i>
          <h4 style="font-weight: 700;">Email Us</h4>
          <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 0.25rem;">support@cravio.com</p>
        </div>
      </div>

      <div class="map-placeholder" style="height: 280px;">
        <i class="fa-solid fa-location-dot" style="font-size: 2.5rem; color: var(--primary);"></i>
        <h3>Cravio Global HQ</h3>
        <p style="font-size: 0.9rem;">742 Evergreen Terrace, Suite 500, New York, NY</p>
      </div>
    </div>
  </div>
</section>

<!-- FAQ ACCORDION SECTION -->
<section style="padding: 4rem 0; background-color: var(--bg-subtle);" id="faq">
  <div class="container" style="max-width: 800px;">
    <div class="section-title-wrap">
      <h2 class="section-title">Frequently Asked Questions</h2>
      <p class="section-subtitle">Got questions? We've got answers.</p>
    </div>

    <div style="display: flex; flex-direction: column; gap: 1rem; margin-top: 2rem;">
      <details class="card-glass" style="padding: 1.25rem; cursor: pointer;">
        <summary style="font-weight: 700; font-size: 1.05rem; color: var(--text-main);">How fast is Cravio delivery?</summary>
        <p style="color: var(--text-muted); margin-top: 0.75rem; font-size: 0.95rem;">Our electric delivery fleet guarantees an average delivery time of 18 to 25 minutes from the time your meal leaves the restaurant kitchen.</p>
      </details>

      <details class="card-glass" style="padding: 1.25rem; cursor: pointer;">
        <summary style="font-weight: 700; font-size: 1.05rem; color: var(--text-main);">What promo codes can I use today?</summary>
        <p style="color: var(--text-muted); margin-top: 0.75rem; font-size: 0.95rem;">Use code <strong>CRAVIO20</strong> for 20% off your order, or code <strong>FREEDEL</strong> for free delivery on any order size!</p>
      </details>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>