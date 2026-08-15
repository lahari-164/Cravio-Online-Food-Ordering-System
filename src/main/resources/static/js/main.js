/* ==========================================================================
   CRAVIO MAIN INTERACTIVITY & UTILITIES
   Navbar scroll, mobile drawer, modals, chat widget, toast engine, back to top, live search
   ========================================================================== */

document.addEventListener('DOMContentLoaded', () => {
  'use strict';

  // 1. STICKY NAVBAR SCROLL
  const navbar = document.querySelector('.cravio-navbar');
  const backToTopBtn = document.getElementById('backToTopBtn');

  window.addEventListener('scroll', () => {
    if (window.scrollY > 40) {
      navbar?.classList.add('scrolled');
      backToTopBtn?.classList.add('visible');
    } else {
      navbar?.classList.remove('scrolled');
      backToTopBtn?.classList.remove('visible');
    }
  });

  backToTopBtn?.addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });

  // 2. MOBILE DRAWER NAVIGATION
  const mobileMenuBtn = document.getElementById('mobileMenuBtn');
  const drawerCloseBtn = document.getElementById('drawerCloseBtn');
  const mobileDrawer = document.getElementById('mobileDrawer');
  const drawerOverlay = document.getElementById('drawerOverlay');

  function openDrawer() {
    mobileDrawer?.classList.add('active');
    drawerOverlay?.classList.add('active');
    document.body.style.overflow = 'hidden';
  }

  function closeDrawer() {
    mobileDrawer?.classList.remove('active');
    drawerOverlay?.classList.remove('active');
    document.body.style.overflow = '';
  }

  mobileMenuBtn?.addEventListener('click', openDrawer);
  drawerCloseBtn?.addEventListener('click', closeDrawer);
  drawerOverlay?.addEventListener('click', closeDrawer);

  // 3. AUTH MODAL (LOGIN & SIGN UP)
  const authModal = document.getElementById('authModal');
  const authOverlay = document.getElementById('authModalOverlay');
  const authModalClose = document.getElementById('authModalClose');
  const loginBtns = document.querySelectorAll('.trigger-login');
  const signupBtns = document.querySelectorAll('.trigger-signup');

  function openAuthModal(mode) {
    if (!authOverlay) return;
    authOverlay.classList.add('active');
    document.body.style.overflow = 'hidden';

    const loginTab = document.getElementById('tabLogin');
    const signupTab = document.getElementById('tabSignup');
    const loginForm = document.getElementById('formLogin');
    const signupForm = document.getElementById('formSignup');

    if (mode === 'signup') {
      loginTab?.classList.remove('active');
      signupTab?.classList.add('active');
      if (loginForm) loginForm.style.display = 'none';
      if (signupForm) signupForm.style.display = 'block';
    } else {
      signupTab?.classList.remove('active');
      loginTab?.classList.add('active');
      if (signupForm) signupForm.style.display = 'none';
      if (loginForm) loginForm.style.display = 'block';
    }
  }

  function closeAuthModal() {
    authOverlay?.classList.remove('active');
    document.body.style.overflow = '';
  }

  loginBtns.forEach(btn => btn.addEventListener('click', (e) => {
    e.preventDefault();
    if (window.CravioAuth && window.CravioAuth.isLoggedIn()) {
      window.CravioAuth.openProfileModal();
    } else {
      openAuthModal('login');
    }
  }));
  signupBtns.forEach(btn => btn.addEventListener('click', (e) => { e.preventDefault(); openAuthModal('signup'); }));
  authModalClose?.addEventListener('click', closeAuthModal);
  authOverlay?.addEventListener('click', (e) => {
    if (e.target === authOverlay) closeAuthModal();
  });

  document.getElementById('tabLogin')?.addEventListener('click', () => openAuthModal('login'));
  document.getElementById('tabSignup')?.addEventListener('click', () => openAuthModal('signup'));

  // 4. EXPANDABLE NAVBAR SEARCH ENGINE
  const navInput = document.getElementById('navSearchInput');
  const navDropdown = document.getElementById('navSearchDropdown');

  if (navInput) {
    navInput.addEventListener('focus', () => {
      const container = document.getElementById('navSearchContainer');
      if (container) {
        container.style.width = '300px';
        container.style.borderColor = 'var(--primary)';
      }
    });

    navInput.addEventListener('blur', () => {
      setTimeout(() => {
        const container = document.getElementById('navSearchContainer');
        if (container && navInput.value.trim() === '') {
          container.style.width = '180px';
          container.style.borderColor = 'var(--border-color)';
        }
        if (navDropdown) navDropdown.style.display = 'none';
      }, 250);
    });

    navInput.addEventListener('input', (e) => {
      const query = e.target.value.toLowerCase().trim();
      if (!query || !window.CravioData) {
        if (navDropdown) navDropdown.style.display = 'none';
        return;
      }

      const results = [];
      window.CravioData.RESTAURANTS.forEach(r => {
        if (r.name.toLowerCase().includes(query) || r.cuisine.some(c => c.toLowerCase().includes(query))) {
          results.push({ type: 'restaurant', name: r.name, detail: r.cuisine.join(', '), image: r.image, id: r.id });
        }
        r.menu.forEach(d => {
          if (d.name.toLowerCase().includes(query)) {
            results.push({ type: 'dish', name: d.name, detail: 'at ' + r.name + ' • ₹' + d.price, image: d.image, id: r.id });
          }
        });
      });

      if (results.length > 0) {
        const targetBase = '/restaurant-detail';

        navDropdown.innerHTML = results.slice(0, 6).map(res => `
          <a href="${targetBase}?id=${res.id}" style="display: flex; align-items: center; gap: 0.75rem; padding: 0.5rem; border-radius: var(--radius-sm); transition: background 0.2s;" onmouseover="this.style.background='var(--bg-subtle)'" onmouseout="this.style.background='transparent'">
            <img src="${res.image}" style="width: 40px; height: 40px; border-radius: 8px; object-fit: cover;">
            <div>
              <strong style="font-size: 0.85rem; color: var(--text-main); display: block;">${res.name}</strong>
              <span style="font-size: 0.75rem; color: var(--text-muted);">${res.detail}</span>
            </div>
          </a>
        `).join('');
        navDropdown.style.display = 'block';
      } else {
        navDropdown.innerHTML = `<div style="padding: 1rem; text-align: center; color: var(--text-muted); font-size: 0.85rem;">No matching restaurants or dishes found</div>`;
        navDropdown.style.display = 'block';
      }
    });
  }

  // 5. FLOATING CHAT WIDGET
  const chatTrigger = document.getElementById('chatWidgetTrigger');
  const chatDrawer = document.getElementById('chatDrawer');
  const chatClose = document.getElementById('chatCloseBtn');
  const chatSendBtn = document.getElementById('chatSendBtn');
  const chatInput = document.getElementById('chatInput');
  const chatBody = document.getElementById('chatBody');

  chatTrigger?.addEventListener('click', () => {
    chatDrawer?.classList.toggle('active');
  });

  chatClose?.addEventListener('click', () => {
    chatDrawer?.classList.remove('active');
  });

  function sendChatMessage() {
    const text = chatInput?.value.trim();
    if (!text) return;

    const userMsg = document.createElement('div');
    userMsg.className = 'chat-msg user';
    userMsg.textContent = text;
    chatBody?.appendChild(userMsg);

    chatInput.value = '';
    chatBody.scrollTop = chatBody.scrollHeight;

    setTimeout(() => {
      const botMsg = document.createElement('div');
      botMsg.className = 'chat-msg bot';
      botMsg.textContent = "Thanks for asking! Cravio Concierge is live 24/7. How can we assist with your order?";
      chatBody?.appendChild(botMsg);
      chatBody.scrollTop = chatBody.scrollHeight;
    }, 1000);
  }

  chatSendBtn?.addEventListener('click', sendChatMessage);
  chatInput?.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') sendChatMessage();
  });

  // 6. FAVORITE BUTTON TOGGLE
  document.addEventListener('click', (e) => {
    const favBtn = e.target.closest('.restaurant-fav-btn');
    if (favBtn) {
      e.preventDefault();
      favBtn.classList.toggle('active');
      const icon = favBtn.querySelector('i');
      if (favBtn.classList.contains('active')) {
        icon.className = 'fa-solid fa-heart';
        if (window.CravioToast) window.CravioToast('Added to your favorite restaurants!', 'success');
      } else {
        icon.className = 'fa-regular fa-heart';
        if (window.CravioToast) window.CravioToast('Removed from favorites', 'info');
      }
    }
  });

  // 7. TOAST NOTIFICATIONS SYSTEM
  window.CravioToast = function (message, type = 'info') {
    const container = document.getElementById('cravioToastContainer');
    if (!container) return;

    const toast = document.createElement('div');
    toast.className = `cravio-toast toast-${type}`;

    let icon = 'fa-info-circle';
    if (type === 'success') icon = 'fa-circle-check';
    if (type === 'error') icon = 'fa-circle-xmark';

    toast.innerHTML = `<i class="fa-solid ${icon}" style="color: var(--primary);"></i> <span>${message}</span>`;
    container.appendChild(toast);

    setTimeout(() => {
      toast.style.opacity = '0';
      toast.style.transform = 'translateX(100%)';
      toast.style.transition = 'all 0.4s ease';
      setTimeout(() => toast.remove(), 400);
    }, 3500);
  };
});
