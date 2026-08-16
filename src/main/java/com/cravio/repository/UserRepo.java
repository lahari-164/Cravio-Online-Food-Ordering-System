package com.cravio.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.cravio.entity.User;

public interface UserRepo extends JpaRepository<User, Integer> {

    // Used during login to find a user by their email
    User findByEmail(String email);

    // Used during registration to check for duplicate emails
    boolean existsByEmail(String email);
}