/* ==========================================================================
   CRAVIO THEME ENGINE
   Handles Light/Dark Mode switching, animations, localStorage & cookie persistence
   ========================================================================== */

(function () {
  'use strict';

  const THEME_KEY = 'cravioTheme';
  const COOKIE_EXPIRES_DAYS = 365;

  // Helper to set cookie for JSP servlet compatibility
  function setCookie(name, value, days) {
    const d = new Date();
    d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
    document.cookie = `${name}=${value};expires=${d.toUTCString()};path=/`;
  }

  // Get current theme from localStorage or system preference
  function getPreferredTheme() {
    const saved = localStorage.getItem(THEME_KEY);
    if (saved === 'light' || saved === 'dark') {
      return saved;
    }
    return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }

  // Apply theme to <html> tag
  function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem(THEME_KEY, theme);
    setCookie(THEME_KEY, theme, COOKIE_EXPIRES_DAYS);
    updateToggleIcons(theme);
  }

  // Update sun/moon icon on toggle button(s)
  function updateToggleIcons(theme) {
    const toggleBtns = document.querySelectorAll('.theme-toggle-btn');
    toggleBtns.forEach(btn => {
      const icon = btn.querySelector('i');
      if (icon) {
        if (theme === 'dark') {
          icon.className = 'fa-solid fa-sun';
          btn.setAttribute('aria-label', 'Switch to Light Mode');
          btn.setAttribute('title', 'Switch to Light Mode');
        } else {
          icon.className = 'fa-solid fa-moon';
          btn.setAttribute('aria-label', 'Switch to Dark Mode');
          btn.setAttribute('title', 'Switch to Dark Mode');
        }
      }
    });
  }

  // Initialize immediately on script parse to avoid flash
  const currentTheme = getPreferredTheme();
  applyTheme(currentTheme);

  // Bind click listeners once DOM is ready
  document.addEventListener('DOMContentLoaded', () => {
    updateToggleIcons(document.documentElement.getAttribute('data-theme') || 'light');

    document.addEventListener('click', (e) => {
      const toggleBtn = e.target.closest('.theme-toggle-btn');
      if (toggleBtn) {
        const activeTheme = document.documentElement.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
        applyTheme(activeTheme);
        if (window.CravioToast) {
          window.CravioToast(`Switched to ${activeTheme.toUpperCase()} mode`, 'info');
        }
      }
    });
  });

  // Expose global API
  window.CravioTheme = {
    get: () => document.documentElement.getAttribute('data-theme'),
    set: applyTheme,
    toggle: () => applyTheme(document.documentElement.getAttribute('data-theme') === 'dark' ? 'light' : 'dark')
  };
})();
