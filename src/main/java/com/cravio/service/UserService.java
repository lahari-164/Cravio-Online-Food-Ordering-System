package com.cravio.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.cravio.entity.User;
import com.cravio.repository.UserRepo;

@Service
public class UserService {

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // ===== REGISTER ===== (unchanged)
    public User registerUser(User user) {
        if (userRepo.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already registered");
        }
        String hashedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(hashedPassword);
        return userRepo.save(user);
    }

    // ===== LOGIN ===== (unchanged)
    public User loginUser(String email, String password) {
        User user = userRepo.findByEmail(email);
        if (user == null) {
            return null;
        }
        boolean matches = passwordEncoder.matches(password, user.getPassword());
        if (!matches) {
            return null;
        }
        return user;
    }

    // ===== NEW: UPDATE PROFILE (name + phone) =====
    // Backs the "Details" tab in profile-modal.jsp, which currently only
    // writes to localStorage (handleSaveProfileDetails in auth-engine.js).
    public User updateProfile(Integer userId, String name, String phone) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (name == null || name.trim().isEmpty()) {
            throw new RuntimeException("Name is required");
        }
        if (phone == null || phone.trim().isEmpty()) {
            throw new RuntimeException("Phone number is required");
        }

        user.setName(name.trim());
        user.setPhone(phone.trim());
        return userRepo.save(user);
    }

    // ===== NEW: CHANGE PASSWORD =====
    // Backs the "Password" tab in profile-modal.jsp, which currently only
    // stores the new password in plain text in localStorage (!) via
    // handleChangePassword in auth-engine.js.
    public void changePassword(Integer userId, String currentPassword, String newPassword) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (currentPassword == null || !passwordEncoder.matches(currentPassword, user.getPassword())) {
            throw new RuntimeException("Current password is incorrect");
        }
        if (newPassword == null || newPassword.length() < 6) {
            throw new RuntimeException("New password must be at least 6 characters");
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepo.save(user);
    }
}
