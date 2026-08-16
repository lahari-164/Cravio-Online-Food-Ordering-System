/* ==========================================================================
   CRAVIO AUTHENTICATION & USER PROFILE ENGINE
   Handles auth state, login/signup modals, profile management (Name, Phone,
   Password change), and Address CRUD operations with persistent localStorage.
   ========================================================================== */

(function () {
  'use strict';

  const AUTH_KEY = 'cravio_user_logged_in';
  const USER_KEY = 'cravio_user_profile';
  const PASS_KEY = 'cravio_user_password';
  const ADDRESS_KEY = 'cravio_user_addresses';

  // Default User Data
  const DEFAULT_USER = {
    name: 'Rohan Sharma',
    email: 'rohan.sharma@example.com',
    phone: '+91 98765 43210'
  };

  // Default Addresses
  const DEFAULT_ADDRESSES = [
    {
      id: 101,
      title: 'Home Address',
      tag: 'HOME',
      street: 'Flat 402, Jubilee Heights, Jubilee Hills',
      city: 'Hyderabad',
      zipcode: '500033',
      isDefault: true
    },
    {
      id: 102,
      title: 'Work Office',
      tag: 'WORK',
      street: 'Cyber Towers, 8th Floor, HITECH City',
      city: 'Hyderabad',
      zipcode: '500081',
      isDefault: false
    }
  ];

  function isLoggedIn() {
    return localStorage.getItem(AUTH_KEY) === 'true';
  }

  function getUser() {
    const data = localStorage.getItem(USER_KEY);
    return data ? JSON.parse(data) : DEFAULT_USER;
  }

  function getSavedPassword() {
    return localStorage.getItem(PASS_KEY) || 'password123';
  }

  function getAddresses() {
    const data = localStorage.getItem(ADDRESS_KEY);
    return data ? JSON.parse(data) : DEFAULT_ADDRESSES;
  }

  function saveAddresses(list) {
    localStorage.setItem(ADDRESS_KEY, JSON.stringify(list));
    window.dispatchEvent(new CustomEvent('cravio:addresses-updated'));
  }

  function notifyAddressChanged() {
    window.dispatchEvent(new CustomEvent('cravio:addresses-updated'));
  }

  function loginUser(name, email, phone, id) {
    const existing = getUser();
    const user = {
      id: id || existing.id,
      name: name || existing.name || 'Rohan Sharma',
      email: email || existing.email || 'rohan.sharma@example.com',
      phone: phone || existing.phone || '+91 98765 43210'
    };
    localStorage.setItem(AUTH_KEY, 'true');
    localStorage.setItem(USER_KEY, JSON.stringify(user));
    if (!localStorage.getItem(ADDRESS_KEY)) {
      saveAddresses(DEFAULT_ADDRESSES);
    }
    updateAuthUI();
    if (window.CravioToast) {
      window.CravioToast('Welcome back, ' + user.name + '! You can now place your order.', 'success');
    }
  }

  function registerUser(name, email, phone, id) {
    loginUser(name, email, phone, id);
  }

function logoutUser() {
    fetch('/api/logout', { method: 'POST' }).catch(() => {});
    localStorage.removeItem(AUTH_KEY);
    localStorage.removeItem(USER_KEY);
    updateAuthUI();
    closeProfileModal();
    if (window.CravioToast) window.CravioToast('Logged out successfully.', 'info');
  }

  function requireLogin(onSuccessCallback) {
    if (isLoggedIn()) {
      if (typeof onSuccessCallback === 'function') onSuccessCallback();
      return true;
    }

    const msgBanner = document.getElementById('authRequiredBanner');
    if (msgBanner) {
      msgBanner.style.display = 'block';
      msgBanner.textContent = 'Please login or create an account to continue ordering.';
    }

    const authOverlay = document.getElementById('authModalOverlay');
    if (authOverlay) {
      authOverlay.classList.add('active');
      document.body.style.overflow = 'hidden';
    }

    window._pendingPostLoginAction = onSuccessCallback;
    return false;
  }

  function updateAuthUI() {
    const loginBtns = document.querySelectorAll('.trigger-login');
    const signupBtns = document.querySelectorAll('.trigger-signup');
    const orderLinks = document.querySelectorAll('.orders-nav-link, .orders-footer-link');
    const logged = isLoggedIn();
    const user = getUser();

    loginBtns.forEach(btn => {
      if (logged) {
        btn.textContent = 'Hi, ' + user.name.split(' ')[0];
        btn.onclick = (e) => {
          e.preventDefault();
          e.stopPropagation();
          openProfileModal();
        };
      } else {
        btn.textContent = 'Login';
        btn.onclick = null;
      }
    });

    signupBtns.forEach(btn => {
      if (logged) {
        btn.style.display = 'none';
      } else {
        btn.style.display = 'inline-block';
      }
    });

    orderLinks.forEach(link => {
      if (logged) {
        link.style.display = 'inline-flex';
      } else {
        link.style.display = 'none';
      }
    });
  }

  // ==========================================
  // PROFILE MODAL & TABS MANAGEMENT
  // ==========================================
  function openProfileModal(tab) {
    const overlay = document.getElementById('profileModalOverlay');
    if (!overlay) return;

    const user = getUser();
    
    // Header Avatar Initials
    const initials = user.name.split(' ').map(n => n[0]).join('').substring(0, 2).toUpperCase() || 'US';
    const badge = document.getElementById('profileAvatarBadge');
    if (badge) badge.textContent = initials;

    const nameHeader = document.getElementById('profileHeaderName');
    if (nameHeader) nameHeader.textContent = user.name;

    const subHeader = document.getElementById('profileHeaderSub');
    if (subHeader) subHeader.textContent = (user.phone ? user.phone + ' • ' : '') + user.email;

    // Populate Tab 1 Inputs
    const inputName = document.getElementById('profileInputName');
    if (inputName) inputName.value = user.name;

    const inputPhone = document.getElementById('profileInputPhone');
    if (inputPhone) inputPhone.value = user.phone;

    const inputEmail = document.getElementById('profileInputEmail');
    if (inputEmail) inputEmail.value = user.email;

    switchProfileTab(tab || 'profile');

    overlay.classList.add('active');
    document.body.style.overflow = 'hidden';
  }

  function closeProfileModal() {
    const overlay = document.getElementById('profileModalOverlay');
    if (overlay) overlay.classList.remove('active');
    document.body.style.overflow = '';
  }

  function switchProfileTab(tabName) {
    const btnProfile = document.getElementById('btnTabProfile');
    const btnAddresses = document.getElementById('btnTabAddresses');
    const btnPassword = document.getElementById('btnTabPassword');

    const contentDetails = document.getElementById('profileContentDetails');
    const contentAddresses = document.getElementById('profileContentAddresses');
    const contentPassword = document.getElementById('profileContentPassword');

    [btnProfile, btnAddresses, btnPassword].forEach(btn => btn?.classList.remove('active'));
    [contentDetails, contentAddresses, contentPassword].forEach(c => { if(c) c.style.display = 'none'; });

    if (tabName === 'addresses') {
      btnAddresses?.classList.add('active');
      if (contentAddresses) contentAddresses.style.display = 'block';
      renderProfileAddresses();
    } else if (tabName === 'password') {
      btnPassword?.classList.add('active');
      if (contentPassword) contentPassword.style.display = 'block';
    } else {
      btnProfile?.classList.add('active');
      if (contentDetails) contentDetails.style.display = 'block';
    }
  }

  // ==========================================
  // PROFILE HANDLERS (Name, Phone, Password)
  // ==========================================
  function handleSaveProfileDetails(e) {
    if (e) e.preventDefault();
    const nameVal = document.getElementById('profileInputName')?.value.trim();
    const phoneVal = document.getElementById('profileInputPhone')?.value.trim();

    if (!nameVal || !phoneVal) {
      if (window.CravioToast) window.CravioToast('Please enter both name and phone number.', 'error');
      return;
    }

    const current = getUser();
    current.name = nameVal;
    current.phone = phoneVal;

    localStorage.setItem(USER_KEY, JSON.stringify(current));
    updateAuthUI();

    // Update Profile Header
    const initials = nameVal.split(' ').map(n => n[0]).join('').substring(0, 2).toUpperCase() || 'US';
    const badge = document.getElementById('profileAvatarBadge');
    if (badge) badge.textContent = initials;
    const nameHeader = document.getElementById('profileHeaderName');
    if (nameHeader) nameHeader.textContent = current.name;
    const subHeader = document.getElementById('profileHeaderSub');
    if (subHeader) subHeader.textContent = current.phone + ' • ' + current.email;

    if (window.CravioToast) window.CravioToast('Profile details updated successfully!', 'success');
  }

  function handleChangePassword(e) {
    if (e) e.preventDefault();
    const currentPass = document.getElementById('passCurrent')?.value;
    const newPass = document.getElementById('passNew')?.value;
    const confirmPass = document.getElementById('passConfirm')?.value;

    const savedPass = getSavedPassword();

    if (currentPass !== savedPass) {
      if (window.CravioToast) window.CravioToast('Current password is incorrect.', 'error');
      return;
    }

    if (!newPass || newPass.length < 6) {
      if (window.CravioToast) window.CravioToast('New password must be at least 6 characters.', 'error');
      return;
    }

    if (newPass !== confirmPass) {
      if (window.CravioToast) window.CravioToast('New passwords do not match.', 'error');
      return;
    }

    localStorage.setItem(PASS_KEY, newPass);

    // Clear inputs
    document.getElementById('passCurrent').value = '';
    document.getElementById('passNew').value = '';
    document.getElementById('passConfirm').value = '';

    if (window.CravioToast) window.CravioToast('Password changed successfully!', 'success');
  }

  function handleProfileLogout() {
    logoutUser();
  }

  // ==========================================
  // ADDRESS CRUD MANAGEMENT
  // ==========================================
  function renderProfileAddresses() {
    const container = document.getElementById('profileAddressList');
    if (!container) return;

    const list = getAddresses();

    if (!list || list.length === 0) {
      container.innerHTML = `
        <div style="text-align: center; padding: 2rem 1rem; color: var(--text-muted);">
          <i class="fa-solid fa-map-location-dot" style="font-size: 2rem; margin-bottom: 0.5rem; opacity: 0.5;"></i>
          <p style="font-size: 0.9rem; margin: 0;">No saved addresses yet.</p>
        </div>
      `;
      return;
    }

    let html = '';
    list.forEach(addr => {
      const icon = addr.tag === 'WORK' ? 'fa-briefcase' : (addr.tag === 'OTHER' ? 'fa-location-dot' : 'fa-house');
      html += `
        <div class="address-card ${addr.isDefault ? 'active' : ''}" style="border: 1px solid ${addr.isDefault ? 'var(--primary)' : 'var(--border-color)'}; padding: 0.85rem; border-radius: var(--radius-md); background: var(--bg-surface-elevated); position: relative;">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.35rem;">
            <strong style="font-size: 0.95rem; display: flex; align-items: center; gap: 0.5rem;">
              <i class="fa-solid ${icon}" style="color: var(--primary);"></i> ${escapeHtml(addr.title)}
            </strong>
            <div style="display: flex; gap: 0.5rem; align-items: center;">
              ${addr.isDefault ? '<span class="badge badge-offer" style="font-size: 0.7rem; padding: 0.15rem 0.5rem;">DEFAULT</span>' : `<button type="button" onclick="window.CravioAuth.setDefaultAddress(${addr.id})" style="background: none; border: none; font-size: 0.75rem; color: var(--text-muted); cursor: pointer; text-decoration: underline;">Set Default</button>`}
              <button type="button" onclick="window.CravioAuth.editAddress(${addr.id})" style="background: none; border: none; font-size: 0.85rem; color: var(--text-muted); cursor: pointer;" title="Edit Address"><i class="fa-solid fa-pen-to-square"></i></button>
              <button type="button" onclick="window.CravioAuth.deleteAddress(${addr.id})" style="background: none; border: none; font-size: 0.85rem; color: var(--primary); cursor: pointer;" title="Delete Address"><i class="fa-solid fa-trash-can"></i></button>
            </div>
          </div>
          <p style="font-size: 0.85rem; color: var(--text-muted); margin: 0; line-height: 1.4;">${escapeHtml(addr.street)}, ${escapeHtml(addr.city)} - ${escapeHtml(addr.zipcode)}</p>
        </div>
      `;
    });

    container.innerHTML = html;
  }

  function showAddAddressForm() {
    const form = document.getElementById('formAddressEdit');
    if (!form) return;

    document.getElementById('addrFormId').value = '';
    document.getElementById('addrFormTitle').textContent = 'Add New Address';
    document.getElementById('addrFormTag').value = 'HOME';
    document.getElementById('addrFormTitleInput').value = '';
    document.getElementById('addrFormStreetInput').value = '';
    document.getElementById('addrFormCityInput').value = '';
    document.getElementById('addrFormZipInput').value = '';
    document.getElementById('addrFormDefault').checked = getAddresses().length === 0;

    form.style.display = 'block';
    document.getElementById('btnAddAddressTrigger').style.display = 'none';
  }

  function cancelAddressForm() {
    const form = document.getElementById('formAddressEdit');
    if (form) form.style.display = 'none';
    const trigger = document.getElementById('btnAddAddressTrigger');
    if (trigger) trigger.style.display = 'inline-flex';
  }

  function editAddress(id) {
    const list = getAddresses();
    const addr = list.find(a => a.id === id);
    if (!addr) return;

    const form = document.getElementById('formAddressEdit');
    if (!form) return;

    document.getElementById('addrFormId').value = addr.id;
    document.getElementById('addrFormTitle').textContent = 'Edit Address';
    document.getElementById('addrFormTag').value = addr.tag || 'HOME';
    document.getElementById('addrFormTitleInput').value = addr.title || '';
    document.getElementById('addrFormStreetInput').value = addr.street || '';
    document.getElementById('addrFormCityInput').value = addr.city || '';
    document.getElementById('addrFormZipInput').value = addr.zipcode || '';
    document.getElementById('addrFormDefault').checked = !!addr.isDefault;

    form.style.display = 'block';
    document.getElementById('btnAddAddressTrigger').style.display = 'none';
  }

  function handleSaveAddress(e) {
    if (e) e.preventDefault();
    const idVal = document.getElementById('addrFormId')?.value;
    const tag = document.getElementById('addrFormTag')?.value || 'HOME';
    const title = document.getElementById('addrFormTitleInput')?.value.trim();
    const street = document.getElementById('addrFormStreetInput')?.value.trim();
    const city = document.getElementById('addrFormCityInput')?.value.trim();
    const zip = document.getElementById('addrFormZipInput')?.value.trim();
    const isDefault = document.getElementById('addrFormDefault')?.checked;

    if (!title || !street || !city || !zip) {
      if (window.CravioToast) window.CravioToast('Please fill all address fields.', 'error');
      return;
    }

    let list = getAddresses();

    if (isDefault) {
      list.forEach(a => a.isDefault = false);
    }

    if (idVal) {
      // Edit existing
      const index = list.findIndex(a => a.id == idVal);
      if (index !== -1) {
        list[index] = { id: Number(idVal), tag, title, street, city, zipcode: zip, isDefault };
      }
    } else {
      // Add new
      const newId = Date.now();
      list.push({ id: newId, tag, title, street, city, zipcode: zip, isDefault });
    }

    saveAddresses(list);
    cancelAddressForm();
    renderProfileAddresses();

    if (window.CravioToast) window.CravioToast('Address saved successfully!', 'success');
  }

  function syncAddressChange() {
    renderProfileAddresses();
    notifyAddressChanged();
  }

  function deleteAddress(id) {
    let list = getAddresses();
    list = list.filter(a => a.id !== id);
    if (list.length > 0 && !list.some(a => a.isDefault)) {
      list[0].isDefault = true;
    }
    saveAddresses(list);
    renderProfileAddresses();
    if (window.CravioToast) window.CravioToast('Address deleted.', 'info');
  }

  function setDefaultAddress(id) {
    const list = getAddresses();
    list.forEach(a => {
      a.isDefault = (a.id === id);
    });
    saveAddresses(list);
    renderProfileAddresses();
    if (window.CravioToast) window.CravioToast('Default address updated!', 'success');
  }

  function escapeHtml(str) {
    if (!str) return '';
    return str.replace(/[&<>"']/g, function (m) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }[m];
    });
  }

  document.addEventListener('DOMContentLoaded', () => {
    updateAuthUI();

    // Attach profile overlay click outside to close
    const profileOverlay = document.getElementById('profileModalOverlay');
    if (profileOverlay) {
      profileOverlay.addEventListener('click', (e) => {
        if (e.target === profileOverlay) closeProfileModal();
      });
    }

    window.addEventListener('cravio:addresses-updated', () => {
      if (window.renderCheckoutAddresses) {
        window.renderCheckoutAddresses();
      }
    });

    // Attach Auth form submit listeners
   const formLogin = document.getElementById('formLogin');
    if (formLogin) {
      formLogin.addEventListener('submit', async (e) => {
        e.preventDefault();
        const email = formLogin.querySelector('input[type="email"]')?.value;
        const password = formLogin.querySelector('input[type="password"]')?.value;

        try {
          const res = await fetch('/api/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
          });

          if (!res.ok) {
            const errText = await res.text();
            if (window.CravioToast) window.CravioToast(errText || 'Login failed', 'error');
            return;
          }

          const user = await res.json();
          loginUser(user.name, user.email, user.phone, user.id);

          const authOverlay = document.getElementById('authModalOverlay');
          if (authOverlay) authOverlay.classList.remove('active');
          document.body.style.overflow = '';

          if (window._pendingPostLoginAction) {
            const cb = window._pendingPostLoginAction;
            window._pendingPostLoginAction = null;
            cb();
          }
        } catch (err) {
          if (window.CravioToast) window.CravioToast('Unable to reach server. Please try again.', 'error');
        }
      });
    }

  const formSignup = document.getElementById('formSignup');
    if (formSignup) {
      formSignup.addEventListener('submit', async (e) => {
        e.preventDefault();
        const name = formSignup.querySelector('input[type="text"]')?.value;
        const email = formSignup.querySelector('input[type="email"]')?.value;
        const phone = formSignup.querySelector('input[type="tel"]')?.value;
        const password = formSignup.querySelector('input[type="password"]')?.value;

        try {
          const res = await fetch('/api/register', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name, email, phone, password })
          });

          if (!res.ok) {
            const errText = await res.text();
            if (window.CravioToast) window.CravioToast(errText || 'Registration failed', 'error');
            return;
          }

          // Registration alone doesn't start a session, so log in right after
          // using the same credentials to establish one.
          const loginRes = await fetch('/api/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
          });

          if (!loginRes.ok) {
            if (window.CravioToast) window.CravioToast('Account created. Please log in.', 'success');
            return;
          }

          const user = await loginRes.json();
          registerUser(user.name, user.email, user.phone, user.id);

          const authOverlay = document.getElementById('authModalOverlay');
          if (authOverlay) authOverlay.classList.remove('active');
          document.body.style.overflow = '';

          if (window._pendingPostLoginAction) {
            const cb = window._pendingPostLoginAction;
            window._pendingPostLoginAction = null;
            cb();
          }
        } catch (err) {
          if (window.CravioToast) window.CravioToast('Unable to reach server. Please try again.', 'error');
        }
      });
    }
  });

  // Export functions to global scope
  window.CravioAuth = {
    isLoggedIn,
    getUser,
    loginUser,
    registerUser,
    logoutUser,
    requireLogin,
    openProfileModal,
    closeProfileModal,
    switchProfileTab,
    getAddresses,
    saveAddresses,
    editAddress,
    deleteAddress,
    setDefaultAddress
  };

  // Global functions attached for JSP inline handlers
  window.openProfileModal = openProfileModal;
  window.closeProfileModal = closeProfileModal;
  window.switchProfileTab = switchProfileTab;
  window.handleSaveProfileDetails = handleSaveProfileDetails;
  window.handleChangePassword = handleChangePassword;
  window.handleProfileLogout = handleProfileLogout;
  window.showAddAddressForm = showAddAddressForm;
  window.cancelAddressForm = cancelAddressForm;
  window.handleSaveAddress = handleSaveAddress;

})();
