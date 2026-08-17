/* ==========================================================================
   CRAVIO AUTHENTICATION & USER PROFILE ENGINE
   Handles auth state, login/signup modals, profile management (Name, Phone,
   Password change), and Address CRUD operations.
   ========================================================================== */

(function () {
  'use strict';

  const AUTH_KEY = 'cravio_user_logged_in';
  const USER_KEY = 'cravio_user_profile';
  const PASS_KEY = 'cravio_user_password';
  const ADDRESS_KEY_PREFIX = 'cravio_user_addresses_';

  // No default user data.
  // A user must come from the authenticated backend session.
  const EMPTY_USER = {
    name: '',
    email: '',
    phone: ''
  };

  // --------------------------------------------------------------------------
  // AUTHENTICATION STATE
  // --------------------------------------------------------------------------

  function isLoggedIn() {
    return localStorage.getItem(AUTH_KEY) === 'true';
  }

  function getUser() {
    const data = localStorage.getItem(USER_KEY);

    if (!data) {
      return EMPTY_USER;
    }

    try {
      return JSON.parse(data);
    } catch (e) {
      localStorage.removeItem(USER_KEY);
      return EMPTY_USER;
    }
  }

  function getSavedPassword() {
    const user = getUser();

    if (user && user.id) {
      const userPasswordKey = PASS_KEY + '_' + user.id;
      return localStorage.getItem(userPasswordKey) || 'password123';
    }

    return localStorage.getItem(PASS_KEY) || 'password123';
  }

  // --------------------------------------------------------------------------
  // USER-SPECIFIC ADDRESS STORAGE
  // --------------------------------------------------------------------------

  let currentUserAddresses = [];

  function getAddressStorageKey() {
    const user = getUser();

    if (!user || !user.id) {
      return null;
    }

    return ADDRESS_KEY_PREFIX + user.id;
  }

  function getAddresses() {
    return Array.isArray(currentUserAddresses)
      ? currentUserAddresses
      : [];
  }

  function setCurrentUserAddresses(list) {
    currentUserAddresses = Array.isArray(list) ? list : [];

    const key = getAddressStorageKey();

    if (key) {
      localStorage.setItem(key, JSON.stringify(currentUserAddresses));
    }

    window.dispatchEvent(new CustomEvent('cravio:addresses-updated'));
  }

  function saveAddresses(list) {
    setCurrentUserAddresses(list);
  }

  function loadCachedAddressesForCurrentUser() {
    const key = getAddressStorageKey();

    if (!key) {
      currentUserAddresses = [];
      return [];
    }

    const data = localStorage.getItem(key);

    if (!data) {
      currentUserAddresses = [];
      return [];
    }

    try {
      const parsed = JSON.parse(data);

      currentUserAddresses = Array.isArray(parsed)
        ? parsed
        : [];

      return currentUserAddresses;
    } catch (e) {
      localStorage.removeItem(key);
      currentUserAddresses = [];
      return [];
    }
  }

  function clearCurrentUserAddressState() {
    currentUserAddresses = [];
  }

  function notifyAddressChanged() {
    window.dispatchEvent(new CustomEvent('cravio:addresses-updated'));
  }

  // Convert backend Address object into the format already used by
  // the CRAVIO frontend.
  function normalizeAddress(address) {
    if (!address) return null;

    return {
      id: address.id,
      tag: address.tag || 'HOME',
      title: address.title || '',
      street: address.street || '',
      city: address.city || '',
      zipcode: address.zipcode || '',
      isDefault: !!address.isDefault
    };
  }

  async function loadAddressesFromServer() {
    if (!isLoggedIn()) {
      currentUserAddresses = [];
      notifyAddressChanged();
      return [];
    }

    try {
      const response = await fetch('/api/addresses', {
        method: 'GET',
        credentials: 'same-origin',
        headers: {
          'Accept': 'application/json'
        }
      });

      if (response.status === 401 || response.status === 403) {
        currentUserAddresses = [];
        notifyAddressChanged();
        return [];
      }

      if (!response.ok) {
        throw new Error('Unable to load addresses');
      }

      const data = await response.json();

      const addresses = Array.isArray(data)
        ? data.map(normalizeAddress).filter(Boolean)
        : [];

      currentUserAddresses = addresses;

      const key = getAddressStorageKey();

      if (key) {
        localStorage.setItem(key, JSON.stringify(addresses));
      }

      notifyAddressChanged();

      return addresses;
    } catch (error) {
      // If the server is temporarily unavailable, use only the
      // currently logged-in user's own cached addresses.
      loadCachedAddressesForCurrentUser();
      notifyAddressChanged();
      return currentUserAddresses;
    }
  }

  // --------------------------------------------------------------------------
  // LOGIN / REGISTER / LOGOUT
  // --------------------------------------------------------------------------

  function loginUser(name, email, phone, id) {
    const user = {
      id: id,
      name: name || '',
      email: email || '',
      phone: phone || ''
    };

    localStorage.setItem(AUTH_KEY, 'true');
    localStorage.setItem(USER_KEY, JSON.stringify(user));

    // IMPORTANT:
    // Never carry the previous user's address list into this user.
    clearCurrentUserAddressState();

    // Load only this user's addresses from the backend.
    loadCachedAddressesForCurrentUser();
    loadAddressesFromServer();

    updateAuthUI();

    if (window.CravioToast) {
      window.CravioToast(
        'Welcome back, ' + (user.name || 'User') + '! You can now place your order.',
        'success'
      );
    }
  }

  function registerUser(name, email, phone, id) {
    // A newly registered user must start with NO addresses.
    const user = {
      id: id,
      name: name || '',
      email: email || '',
      phone: phone || ''
    };

    localStorage.setItem(AUTH_KEY, 'true');
    localStorage.setItem(USER_KEY, JSON.stringify(user));

    clearCurrentUserAddressState();

    // Remove only this new user's old cache if one somehow exists.
    const key = ADDRESS_KEY_PREFIX + user.id;
    localStorage.removeItem(key);

    // Fetch from backend. For a new user this should return [].
    loadAddressesFromServer();

    updateAuthUI();

    if (window.CravioToast) {
      window.CravioToast(
        'Welcome, ' + (user.name || 'User') + '! Your account is ready.',
        'success'
      );
    }
  }

  function logoutUser() {
    fetch('/api/logout', {
      method: 'POST',
      credentials: 'same-origin'
    }).catch(() => {});

    // Remove only authentication information.
    // User-specific address cache is retained for that user so it
    // can be restored when the same user logs back in.
    localStorage.removeItem(AUTH_KEY);
    localStorage.removeItem(USER_KEY);

    // Clear address data from the current JavaScript memory.
    // This prevents the previous user from appearing after logout.
    clearCurrentUserAddressState();

    updateAuthUI();
    closeProfileModal();

    if (window.CravioToast) {
      window.CravioToast('Logged out successfully.', 'info');
    }
  }

  function requireLogin(onSuccessCallback) {
    if (isLoggedIn()) {
      if (typeof onSuccessCallback === 'function') {
        onSuccessCallback();
      }

      return true;
    }

    const msgBanner = document.getElementById('authRequiredBanner');

    if (msgBanner) {
      msgBanner.style.display = 'block';
      msgBanner.textContent =
        'Please login or create an account to continue ordering.';
    }

    const authOverlay = document.getElementById('authModalOverlay');

    if (authOverlay) {
      authOverlay.classList.add('active');
      document.body.style.overflow = 'hidden';
    }

    window._pendingPostLoginAction = onSuccessCallback;

    return false;
  }

  // --------------------------------------------------------------------------
  // AUTH UI
  // --------------------------------------------------------------------------

  function updateAuthUI() {
    const loginBtns = document.querySelectorAll('.trigger-login');
    const signupBtns = document.querySelectorAll('.trigger-signup');
    const orderLinks = document.querySelectorAll(
      '.orders-nav-link, .orders-footer-link'
    );

    const logged = isLoggedIn();
    const user = getUser();

    loginBtns.forEach(btn => {
      if (logged) {
        const firstName =
          user.name && user.name.trim()
            ? user.name.trim().split(' ')[0]
            : 'User';

        btn.textContent = 'Hi, ' + firstName;

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

  // --------------------------------------------------------------------------
  // PROFILE MODAL & TABS MANAGEMENT
  // --------------------------------------------------------------------------

  function openProfileModal(tab) {
    const overlay = document.getElementById('profileModalOverlay');

    if (!overlay) return;

    const user = getUser();

    const safeName = user.name || 'User';

    // Header Avatar Initials
    const initials = safeName
      .split(' ')
      .map(n => n[0])
      .join('')
      .substring(0, 2)
      .toUpperCase() || 'US';

    const badge = document.getElementById('profileAvatarBadge');

    if (badge) {
      badge.textContent = initials;
    }

    const nameHeader = document.getElementById('profileHeaderName');

    if (nameHeader) {
      nameHeader.textContent = safeName;
    }

    const subHeader = document.getElementById('profileHeaderSub');

    if (subHeader) {
      subHeader.textContent =
        (user.phone ? user.phone + ' • ' : '') +
        (user.email || '');
    }

    // Populate Tab 1 Inputs
    const inputName = document.getElementById('profileInputName');

    if (inputName) {
      inputName.value = user.name || '';
    }

    const inputPhone = document.getElementById('profileInputPhone');

    if (inputPhone) {
      inputPhone.value = user.phone || '';
    }

    const inputEmail = document.getElementById('profileInputEmail');

    if (inputEmail) {
      inputEmail.value = user.email || '';
    }

    switchProfileTab(tab || 'profile');

    overlay.classList.add('active');
    document.body.style.overflow = 'hidden';

    // Always refresh addresses for the currently authenticated user.
    if ((tab || 'profile') === 'addresses') {
      loadAddressesFromServer().then(() => {
        renderProfileAddresses();
      });
    }
  }

  function closeProfileModal() {
    const overlay = document.getElementById('profileModalOverlay');

    if (overlay) {
      overlay.classList.remove('active');
    }

    document.body.style.overflow = '';
  }

  function switchProfileTab(tabName) {
    const btnProfile = document.getElementById('btnTabProfile');
    const btnAddresses = document.getElementById('btnTabAddresses');
    const btnPassword = document.getElementById('btnTabPassword');

    const contentDetails =
      document.getElementById('profileContentDetails');

    const contentAddresses =
      document.getElementById('profileContentAddresses');

    const contentPassword =
      document.getElementById('profileContentPassword');

    [btnProfile, btnAddresses, btnPassword].forEach(btn =>
      btn?.classList.remove('active')
    );

    [contentDetails, contentAddresses, contentPassword].forEach(c => {
      if (c) c.style.display = 'none';
    });

    if (tabName === 'addresses') {
      btnAddresses?.classList.add('active');

      if (contentAddresses) {
        contentAddresses.style.display = 'block';
      }

      // Show current user's cached addresses immediately,
      // then refresh from backend.
      renderProfileAddresses();

      loadAddressesFromServer().then(() => {
        renderProfileAddresses();
      });
    } else if (tabName === 'password') {
      btnPassword?.classList.add('active');

      if (contentPassword) {
        contentPassword.style.display = 'block';
      }
    } else {
      btnProfile?.classList.add('active');

      if (contentDetails) {
        contentDetails.style.display = 'block';
      }
    }
  }

  // --------------------------------------------------------------------------
  // PROFILE HANDLERS
  // --------------------------------------------------------------------------

  function handleSaveProfileDetails(e) {
    if (e) e.preventDefault();

    const nameVal =
      document.getElementById('profileInputName')?.value.trim();

    const phoneVal =
      document.getElementById('profileInputPhone')?.value.trim();

    if (!nameVal || !phoneVal) {
      if (window.CravioToast) {
        window.CravioToast(
          'Please enter both name and phone number.',
          'error'
        );
      }

      return;
    }

    const current = getUser();

    current.name = nameVal;
    current.phone = phoneVal;

    localStorage.setItem(USER_KEY, JSON.stringify(current));

    updateAuthUI();

    // Update Profile Header
    const initials = nameVal
      .split(' ')
      .map(n => n[0])
      .join('')
      .substring(0, 2)
      .toUpperCase() || 'US';

    const badge = document.getElementById('profileAvatarBadge');

    if (badge) {
      badge.textContent = initials;
    }

    const nameHeader =
      document.getElementById('profileHeaderName');

    if (nameHeader) {
      nameHeader.textContent = current.name;
    }

    const subHeader =
      document.getElementById('profileHeaderSub');

    if (subHeader) {
      subHeader.textContent =
        current.phone + ' • ' + current.email;
    }

    // Keep existing backend profile update behavior.
    fetch('/api/users/profile', {
      method: 'PUT',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        name: nameVal,
        phone: phoneVal
      })
    }).catch(() => {});

    if (window.CravioToast) {
      window.CravioToast(
        'Profile details updated successfully!',
        'success'
      );
    }
  }

  function handleChangePassword(e) {
    if (e) e.preventDefault();

    const currentPass =
      document.getElementById('passCurrent')?.value;

    const newPass =
      document.getElementById('passNew')?.value;

    const confirmPass =
      document.getElementById('passConfirm')?.value;

    const savedPass = getSavedPassword();

    if (currentPass !== savedPass) {
      if (window.CravioToast) {
        window.CravioToast(
          'Current password is incorrect.',
          'error'
        );
      }

      return;
    }

    if (!newPass || newPass.length < 6) {
      if (window.CravioToast) {
        window.CravioToast(
          'New password must be at least 6 characters.',
          'error'
        );
      }

      return;
    }

    if (newPass !== confirmPass) {
      if (window.CravioToast) {
        window.CravioToast(
          'New passwords do not match.',
          'error'
        );
      }

      return;
    }

    const user = getUser();

    if (user && user.id) {
      localStorage.setItem(
        PASS_KEY + '_' + user.id,
        newPass
      );
    }

    localStorage.setItem(PASS_KEY, newPass);

    // Also update password in backend.
    fetch('/api/users/password', {
      method: 'PUT',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        currentPassword: currentPass,
        newPassword: newPass
      })
    }).catch(() => {});

    // Clear inputs
    const currentInput =
      document.getElementById('passCurrent');

    const newInput =
      document.getElementById('passNew');

    const confirmInput =
      document.getElementById('passConfirm');

    if (currentInput) currentInput.value = '';
    if (newInput) newInput.value = '';
    if (confirmInput) confirmInput.value = '';

    if (window.CravioToast) {
      window.CravioToast(
        'Password changed successfully!',
        'success'
      );
    }
  }

  function handleProfileLogout() {
    logoutUser();
  }

  // --------------------------------------------------------------------------
  // ADDRESS CRUD MANAGEMENT
  // --------------------------------------------------------------------------

  function renderProfileAddresses() {
    const container =
      document.getElementById('profileAddressList');

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
      const icon =
        addr.tag === 'WORK'
          ? 'fa-briefcase'
          : (addr.tag === 'OTHER'
            ? 'fa-location-dot'
            : 'fa-house');

      html += `
        <div class="address-card ${addr.isDefault ? 'active' : ''}" style="border: 1px solid ${addr.isDefault ? 'var(--primary)' : 'var(--border-color)'}; padding: 0.85rem; border-radius: var(--radius-md); background: var(--bg-surface-elevated); position: relative;">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.35rem;">
            <strong style="font-size: 0.95rem; display: flex; align-items: center; gap: 0.5rem;">
              <i class="fa-solid ${icon}" style="color: var(--primary);"></i> ${escapeHtml(addr.title)}
            </strong>

            <div style="display: flex; gap: 0.5rem; align-items: center;">
              ${
                addr.isDefault
                  ? '<span class="badge badge-offer" style="font-size: 0.7rem; padding: 0.15rem 0.5rem;">DEFAULT</span>'
                  : `<button type="button" onclick="window.CravioAuth.setDefaultAddress(${addr.id})" style="background: none; border: none; font-size: 0.75rem; color: var(--text-muted); cursor: pointer; text-decoration: underline;">Set Default</button>`
              }

              <button type="button" onclick="window.CravioAuth.editAddress(${addr.id})" style="background: none; border: none; font-size: 0.85rem; color: var(--text-muted); cursor: pointer;" title="Edit Address">
                <i class="fa-solid fa-pen-to-square"></i>
              </button>

              <button type="button" onclick="window.CravioAuth.deleteAddress(${addr.id})" style="background: none; border: none; font-size: 0.85rem; color: var(--primary); cursor: pointer;" title="Delete Address">
                <i class="fa-solid fa-trash-can"></i>
              </button>
            </div>
          </div>

          <p style="font-size: 0.85rem; color: var(--text-muted); margin: 0; line-height: 1.4;">
            ${escapeHtml(addr.street)}, ${escapeHtml(addr.city)} - ${escapeHtml(addr.zipcode)}
          </p>
        </div>
      `;
    });

    container.innerHTML = html;
  }

  function showAddAddressForm() {
    const form =
      document.getElementById('formAddressEdit');

    if (!form) return;

    document.getElementById('addrFormId').value = '';
    document.getElementById('addrFormTitle').textContent =
      'Add New Address';

    document.getElementById('addrFormTag').value = 'HOME';
    document.getElementById('addrFormTitleInput').value = '';
    document.getElementById('addrFormStreetInput').value = '';
    document.getElementById('addrFormCityInput').value = '';
    document.getElementById('addrFormZipInput').value = '';

    document.getElementById('addrFormDefault').checked =
      getAddresses().length === 0;

    form.style.display = 'block';

    const trigger =
      document.getElementById('btnAddAddressTrigger');

    if (trigger) {
      trigger.style.display = 'none';
    }
  }

  function cancelAddressForm() {
    const form =
      document.getElementById('formAddressEdit');

    if (form) {
      form.style.display = 'none';
    }

    const trigger =
      document.getElementById('btnAddAddressTrigger');

    if (trigger) {
      trigger.style.display = 'inline-flex';
    }
  }

  function editAddress(id) {
    const list = getAddresses();

    const addr = list.find(a => Number(a.id) === Number(id));

    if (!addr) return;

    const form =
      document.getElementById('formAddressEdit');

    if (!form) return;

    document.getElementById('addrFormId').value = addr.id;
    document.getElementById('addrFormTitle').textContent =
      'Edit Address';

    document.getElementById('addrFormTag').value =
      addr.tag || 'HOME';

    document.getElementById('addrFormTitleInput').value =
      addr.title || '';

    document.getElementById('addrFormStreetInput').value =
      addr.street || '';

    document.getElementById('addrFormCityInput').value =
      addr.city || '';

    document.getElementById('addrFormZipInput').value =
      addr.zipcode || '';

    document.getElementById('addrFormDefault').checked =
      !!addr.isDefault;

    form.style.display = 'block';

    const trigger =
      document.getElementById('btnAddAddressTrigger');

    if (trigger) {
      trigger.style.display = 'none';
    }
  }

  async function handleSaveAddress(e) {
    if (e) e.preventDefault();

    if (!isLoggedIn()) {
      if (window.CravioToast) {
        window.CravioToast(
          'Please login before saving an address.',
          'error'
        );
      }

      return;
    }

    const idVal =
      document.getElementById('addrFormId')?.value;

    const tag =
      document.getElementById('addrFormTag')?.value || 'HOME';

    const title =
      document.getElementById('addrFormTitleInput')?.value.trim();

    const street =
      document.getElementById('addrFormStreetInput')?.value.trim();

    const city =
      document.getElementById('addrFormCityInput')?.value.trim();

    const zip =
      document.getElementById('addrFormZipInput')?.value.trim();

    const isDefault =
      document.getElementById('addrFormDefault')?.checked;

    if (!title || !street || !city || !zip) {
      if (window.CravioToast) {
        window.CravioToast(
          'Please fill all address fields.',
          'error'
        );
      }

      return;
    }

    const payload = {
      tag,
      title,
      street,
      city,
      zipcode: zip,
      isDefault: !!isDefault
    };

    try {
      let response;

      if (idVal) {
        response = await fetch(
          '/api/addresses/' + encodeURIComponent(idVal),
          {
            method: 'PUT',
            credentials: 'same-origin',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json'
            },
            body: JSON.stringify(payload)
          }
        );
      } else {
        response = await fetch('/api/addresses', {
          method: 'POST',
          credentials: 'same-origin',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify(payload)
        });
      }

      if (!response.ok) {
        const errorText = await response.text();

        if (window.CravioToast) {
          window.CravioToast(
            errorText || 'Unable to save address.',
            'error'
          );
        }

        return;
      }

      const savedAddress = await response.json();

      if (idVal) {
        const index = currentUserAddresses.findIndex(
          a => Number(a.id) === Number(idVal)
        );

        const normalized = normalizeAddress(savedAddress);

        if (index !== -1 && normalized) {
          currentUserAddresses[index] = normalized;
        }
      } else {
        const normalized = normalizeAddress(savedAddress);

        if (normalized) {
          currentUserAddresses.push(normalized);
        }
      }

      // Refresh from backend to ensure the frontend is synchronized.
      await loadAddressesFromServer();

      cancelAddressForm();
      renderProfileAddresses();

      if (window.CravioToast) {
        window.CravioToast(
          'Address saved successfully!',
          'success'
        );
      }
    } catch (error) {
      if (window.CravioToast) {
        window.CravioToast(
          'Unable to save address. Please try again.',
          'error'
        );
      }
    }
  }

  function syncAddressChange() {
    renderProfileAddresses();
    notifyAddressChanged();
  }

  async function deleteAddress(id) {
    if (!isLoggedIn()) return;

    try {
      const response = await fetch(
        '/api/addresses/' + encodeURIComponent(id),
        {
          method: 'DELETE',
          credentials: 'same-origin'
        }
      );

      if (!response.ok) {
        const errorText = await response.text();

        if (window.CravioToast) {
          window.CravioToast(
            errorText || 'Unable to delete address.',
            'error'
          );
        }

        return;
      }

      currentUserAddresses =
        currentUserAddresses.filter(
          a => Number(a.id) !== Number(id)
        );

      await loadAddressesFromServer();

      renderProfileAddresses();

      if (window.CravioToast) {
        window.CravioToast(
          'Address deleted.',
          'info'
        );
      }
    } catch (error) {
      if (window.CravioToast) {
        window.CravioToast(
          'Unable to delete address. Please try again.',
          'error'
        );
      }
    }
  }

  async function setDefaultAddress(id) {
    if (!isLoggedIn()) return;

    try {
      const response = await fetch(
        '/api/addresses/' +
        encodeURIComponent(id) +
        '/default',
        {
          method: 'PUT',
          credentials: 'same-origin'
        }
      );

      if (!response.ok) {
        const errorText = await response.text();

        if (window.CravioToast) {
          window.CravioToast(
            errorText || 'Unable to update default address.',
            'error'
          );
        }

        return;
      }

      await loadAddressesFromServer();

      renderProfileAddresses();

      if (window.CravioToast) {
        window.CravioToast(
          'Default address updated!',
          'success'
        );
      }
    } catch (error) {
      if (window.CravioToast) {
        window.CravioToast(
          'Unable to update default address.',
          'error'
        );
      }
    }
  }

  // --------------------------------------------------------------------------
  // HTML ESCAPING
  // --------------------------------------------------------------------------

  function escapeHtml(str) {
    if (!str) return '';

    return String(str).replace(
      /[&<>"']/g,
      function (m) {
        return {
          '&': '&amp;',
          '<': '&lt;',
          '>': '&gt;',
          '"': '&quot;',
          "'": '&#039;'
        }[m];
      }
    );
  }

  // --------------------------------------------------------------------------
  // DOM READY
  // --------------------------------------------------------------------------

  document.addEventListener('DOMContentLoaded', () => {
    updateAuthUI();

    // If the user is already logged in after a page refresh,
    // load ONLY that user's addresses from the backend.
    if (isLoggedIn()) {
      loadCachedAddressesForCurrentUser();
      loadAddressesFromServer();
    } else {
      clearCurrentUserAddressState();
    }

    // Attach profile overlay click outside to close
    const profileOverlay =
      document.getElementById('profileModalOverlay');

    if (profileOverlay) {
      profileOverlay.addEventListener('click', (e) => {
        if (e.target === profileOverlay) {
          closeProfileModal();
        }
      });
    }

    window.addEventListener(
      'cravio:addresses-updated',
      () => {
        if (window.renderCheckoutAddresses) {
          window.renderCheckoutAddresses();
        }
      }
    );

    // ----------------------------------------------------------------------
    // LOGIN FORM
    // ----------------------------------------------------------------------

    const formLogin =
      document.getElementById('formLogin');

    if (formLogin) {
      formLogin.addEventListener('submit', async (e) => {
        e.preventDefault();

        const email =
          formLogin.querySelector(
            'input[type="email"]'
          )?.value.trim();

        const password =
          formLogin.querySelector(
            'input[type="password"]'
          )?.value;

        try {
          const res = await fetch('/api/login', {
            method: 'POST',
            credentials: 'same-origin',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              email,
              password
            })
          });

          if (!res.ok) {
            const errText = await res.text();

            if (window.CravioToast) {
              window.CravioToast(
                errText || 'Login failed',
                'error'
              );
            }

            return;
          }

          const user = await res.json();

          loginUser(
            user.name,
            user.email,
            user.phone,
            user.id
          );

          const authOverlay =
            document.getElementById(
              'authModalOverlay'
            );

          if (authOverlay) {
            authOverlay.classList.remove('active');
          }

          document.body.style.overflow = '';

          if (window._pendingPostLoginAction) {
            const cb =
              window._pendingPostLoginAction;

            window._pendingPostLoginAction = null;

            cb();
          }
        } catch (err) {
          if (window.CravioToast) {
            window.CravioToast(
              'Unable to reach server. Please try again.',
              'error'
            );
          }
        }
      });
    }

    // ----------------------------------------------------------------------
    // SIGNUP FORM
    // ----------------------------------------------------------------------

    const formSignup =
      document.getElementById('formSignup');

    if (formSignup) {
      formSignup.addEventListener('submit', async (e) => {
        e.preventDefault();

        const name =
          formSignup.querySelector(
            'input[type="text"]'
          )?.value.trim();

        const email =
          formSignup.querySelector(
            'input[type="email"]'
          )?.value.trim();

        const phone =
          formSignup.querySelector(
            'input[type="tel"]'
          )?.value.trim();

        const password =
          formSignup.querySelector(
            'input[type="password"]'
          )?.value;

        try {
          const res = await fetch('/api/register', {
            method: 'POST',
            credentials: 'same-origin',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              name,
              email,
              phone,
              password
            })
          });

          if (!res.ok) {
            const errText = await res.text();

            if (window.CravioToast) {
              window.CravioToast(
                errText || 'Registration failed',
                'error'
              );
            }

            return;
          }

          // Registration alone doesn't start a session,
          // so log in immediately after registration.
          const loginRes = await fetch('/api/login', {
            method: 'POST',
            credentials: 'same-origin',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              email,
              password
            })
          });

          if (!loginRes.ok) {
            if (window.CravioToast) {
              window.CravioToast(
                'Account created. Please log in.',
                'success'
              );
            }

            return;
          }

          const user = await loginRes.json();

          registerUser(
            user.name,
            user.email,
            user.phone,
            user.id
          );

          const authOverlay =
            document.getElementById(
              'authModalOverlay'
            );

          if (authOverlay) {
            authOverlay.classList.remove('active');
          }

          document.body.style.overflow = '';

          if (window._pendingPostLoginAction) {
            const cb =
              window._pendingPostLoginAction;

            window._pendingPostLoginAction = null;

            cb();
          }
        } catch (err) {
          if (window.CravioToast) {
            window.CravioToast(
              'Unable to reach server. Please try again.',
              'error'
            );
          }
        }
      });
    }
  });

  // --------------------------------------------------------------------------
  // EXPORT FUNCTIONS TO GLOBAL SCOPE
  // --------------------------------------------------------------------------

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
    loadAddressesFromServer,

    editAddress,
    deleteAddress,
    setDefaultAddress
  };

  // Global functions attached for JSP inline handlers
  window.openProfileModal = openProfileModal;
  window.closeProfileModal = closeProfileModal;
  window.switchProfileTab = switchProfileTab;

  window.handleSaveProfileDetails =
    handleSaveProfileDetails;

  window.handleChangePassword =
    handleChangePassword;

  window.handleProfileLogout =
    handleProfileLogout;

  window.showAddAddressForm =
    showAddAddressForm;

  window.cancelAddressForm =
    cancelAddressForm;

  window.handleSaveAddress =
    handleSaveAddress;

})();