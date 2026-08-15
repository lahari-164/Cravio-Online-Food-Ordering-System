<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- =========================================================
     CRAVIO USER PROFILE MODAL COMPONENT
     Edit Profile (Name, Phone), Change Password, Manage Addresses
     ========================================================= --%>
<div class="modal-overlay" id="profileModalOverlay" style="z-index: 1250;">
  <div class="modal-card" id="profileModalCard" style="max-width: 540px; padding: 2rem;">
    <button class="modal-close" id="profileModalClose" onclick="closeProfileModal()"><i class="fa-solid fa-xmark"></i></button>

    <%-- Header Profile Avatar & Info --%>
    <div style="display: flex; align-items: center; gap: 1.25rem; margin-bottom: 1.5rem; padding-bottom: 1.25rem; border-bottom: 1px solid var(--border-color);">
      <div style="width: 56px; height: 56px; border-radius: 50%; background: var(--primary-gradient); color: #fff; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; font-weight: 800; box-shadow: var(--shadow-glow); flex-shrink: 0;" id="profileAvatarBadge">
        RS
      </div>
      <div style="overflow: hidden;">
        <h3 style="font-size: 1.25rem; font-weight: 700; margin: 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" id="profileHeaderName">Rohan Sharma</h3>
        <p style="font-size: 0.85rem; color: var(--text-muted); margin: 0.2rem 0 0 0;" id="profileHeaderSub">+91 98765 43210 • rohan.sharma@example.com</p>
      </div>
    </div>

    <%-- Navigation Tabs --%>
    <div class="profile-tabs" style="display: flex; gap: 0.5rem; background-color: var(--bg-subtle); padding: 0.35rem; border-radius: var(--radius-md); margin-bottom: 1.5rem;">
      <button class="profile-tab-btn active" id="btnTabProfile" onclick="switchProfileTab('profile')" style="flex: 1; padding: 0.5rem 0.75rem; border: none; border-radius: var(--radius-sm); font-weight: 600; font-size: 0.85rem; cursor: pointer; transition: var(--transition-fast);">
        <i class="fa-solid fa-user-gear"></i> Details
      </button>
      <button class="profile-tab-btn" id="btnTabAddresses" onclick="switchProfileTab('addresses')" style="flex: 1; padding: 0.5rem 0.75rem; border: none; border-radius: var(--radius-sm); font-weight: 600; font-size: 0.85rem; cursor: pointer; transition: var(--transition-fast);">
        <i class="fa-solid fa-location-dot"></i> Addresses
      </button>
      <button class="profile-tab-btn" id="btnTabPassword" onclick="switchProfileTab('password')" style="flex: 1; padding: 0.5rem 0.75rem; border: none; border-radius: var(--radius-sm); font-weight: 600; font-size: 0.85rem; cursor: pointer; transition: var(--transition-fast);">
        <i class="fa-solid fa-key"></i> Password
      </button>
    </div>

    <%-- TAB 1: EDIT PROFILE DETAILS --%>
    <div class="profile-tab-content" id="profileContentDetails" style="display: block;">
      <form id="formEditProfile" onsubmit="handleSaveProfileDetails(event)">
        <div class="form-group">
          <label class="form-label"><i class="fa-solid fa-user" style="color: var(--primary);"></i> Full Name</label>
          <input type="text" id="profileInputName" class="form-input" placeholder="e.g. Rohan Sharma" required>
        </div>

        <div class="form-group">
          <label class="form-label"><i class="fa-solid fa-phone" style="color: var(--primary);"></i> Phone Number</label>
          <input type="tel" id="profileInputPhone" class="form-input" placeholder="e.g. +91 98765 43210" required>
        </div>

        <div class="form-group">
          <label class="form-label"><i class="fa-solid fa-envelope" style="color: var(--text-muted);"></i> Email Address (Read only)</label>
          <input type="email" id="profileInputEmail" class="form-input" style="opacity: 0.7; cursor: not-allowed;" readonly>
        </div>

        <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
          <i class="fa-solid fa-floppy-disk"></i> Save Profile Changes
        </button>
      </form>
    </div>

    <%-- TAB 2: ADDRESSES MANAGEMENT --%>
    <div class="profile-tab-content" id="profileContentAddresses" style="display: none;">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
        <h4 style="font-size: 1rem; font-weight: 700; margin: 0;">My Saved Addresses</h4>
        <button class="btn btn-secondary btn-sm" onclick="showAddAddressForm()" id="btnAddAddressTrigger">
          <i class="fa-solid fa-plus"></i> Add Address
        </button>
      </div>

      <%-- Address List Container --%>
      <div id="profileAddressList" style="max-height: 260px; overflow-y: auto; display: flex; flex-direction: column; gap: 0.75rem; padding-right: 4px;">
        <!-- Dynamically rendered address cards -->
      </div>

      <%-- Address Form (Add / Edit) --%>
      <form id="formAddressEdit" style="display: none; background-color: var(--bg-subtle); padding: 1rem; border-radius: var(--radius-md); margin-top: 1rem; border: 1px solid var(--border-color);" onsubmit="handleSaveAddress(event)">
        <input type="hidden" id="addrFormId" value="">
        <h5 style="font-size: 0.95rem; font-weight: 700; margin-bottom: 0.75rem;" id="addrFormTitle">Add New Address</h5>
        
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem;">
          <div class="form-group" style="margin-bottom: 0.75rem;">
            <label class="form-label" style="font-size: 0.75rem;">Address Tag</label>
            <select id="addrFormTag" class="form-input" style="padding: 0.4rem 0.6rem; font-size: 0.85rem;">
              <option value="HOME">Home</option>
              <option value="WORK">Work</option>
              <option value="OTHER">Other</option>
            </select>
          </div>
          <div class="form-group" style="margin-bottom: 0.75rem;">
            <label class="form-label" style="font-size: 0.75rem;">Label Name</label>
            <input type="text" id="addrFormTitleInput" class="form-input" placeholder="e.g. Home Address" style="padding: 0.4rem 0.6rem; font-size: 0.85rem;" required>
          </div>
        </div>

        <div class="form-group" style="margin-bottom: 0.75rem;">
          <label class="form-label" style="font-size: 0.75rem;">Street / Flat No / Area</label>
          <input type="text" id="addrFormStreetInput" class="form-input" placeholder="e.g. Flat 402, Jubilee Heights, Jubilee Hills" style="padding: 0.4rem 0.6rem; font-size: 0.85rem;" required>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem;">
          <div class="form-group" style="margin-bottom: 0.75rem;">
            <label class="form-label" style="font-size: 0.75rem;">City</label>
            <input type="text" id="addrFormCityInput" class="form-input" placeholder="e.g. Hyderabad" style="padding: 0.4rem 0.6rem; font-size: 0.85rem;" required>
          </div>
          <div class="form-group" style="margin-bottom: 0.75rem;">
            <label class="form-label" style="font-size: 0.75rem;">Pincode / Zip</label>
            <input type="text" id="addrFormZipInput" class="form-input" placeholder="e.g. 500033" style="padding: 0.4rem 0.6rem; font-size: 0.85rem;" required>
          </div>
        </div>

        <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1rem;">
          <input type="checkbox" id="addrFormDefault" style="accent-color: var(--primary);">
          <label for="addrFormDefault" style="font-size: 0.8rem; color: var(--text-muted); cursor: pointer;">Set as default delivery address</label>
        </div>

        <div style="display: flex; gap: 0.5rem;">
          <button type="button" class="btn btn-secondary btn-sm" style="flex: 1;" onclick="cancelAddressForm()">Cancel</button>
          <button type="submit" class="btn btn-primary btn-sm" style="flex: 1;">Save Address</button>
        </div>
      </form>
    </div>

    <%-- TAB 3: CHANGE PASSWORD --%>
    <div class="profile-tab-content" id="profileContentPassword" style="display: none;">
      <form id="formChangePassword" onsubmit="handleChangePassword(event)">
        <div class="form-group">
          <label class="form-label"><i class="fa-solid fa-lock" style="color: var(--text-muted);"></i> Current Password</label>
          <input type="password" id="passCurrent" class="form-input" placeholder="••••••••" required>
        </div>

        <div class="form-group">
          <label class="form-label"><i class="fa-solid fa-key" style="color: var(--primary);"></i> New Password</label>
          <input type="password" id="passNew" class="form-input" placeholder="At least 6 characters" minlength="6" required>
        </div>

        <div class="form-group">
          <label class="form-label"><i class="fa-solid fa-shield-halved" style="color: var(--primary);"></i> Confirm New Password</label>
          <input type="password" id="passConfirm" class="form-input" placeholder="Re-enter new password" minlength="6" required>
        </div>

        <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
          <i class="fa-solid fa-check"></i> Update Password
        </button>
      </form>
    </div>

    <%-- Logout Action --%>
    <div style="margin-top: 1.5rem; padding-top: 1rem; border-top: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center;">
      <span style="font-size: 0.8rem; color: var(--text-muted);">Log out of Cravio on this device</span>
      <button class="btn btn-secondary btn-sm" style="color: var(--primary); border-color: rgba(255,59,48,0.3);" onclick="handleProfileLogout()">
        <i class="fa-solid fa-right-from-bracket"></i> Logout
      </button>
    </div>
  </div>
</div>
