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

    // ===== REGISTER =====
    // Returns the saved User if successful.
    // Throws an exception if the email is already taken.
    public User registerUser(User user) {
        if (userRepo.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already registered");
        }

        // Hash the plain password before saving — never store plain text.
        String hashedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(hashedPassword);

        return userRepo.save(user);
    }

    // ===== LOGIN =====
    // Returns the User if email + password match, otherwise returns null.
    public User loginUser(String email, String password) {
        User user = userRepo.findByEmail(email);

        if (user == null) {
            return null; // no account with this email
        }

        // Compare the entered plain password against the stored BCrypt hash.
        boolean matches = passwordEncoder.matches(password, user.getPassword());

        if (!matches) {
            return null; // wrong password
        }

        return user;
    }
}