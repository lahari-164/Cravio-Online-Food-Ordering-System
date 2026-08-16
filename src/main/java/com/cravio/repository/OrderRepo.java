package com.cravio.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.cravio.entity.Order;

public interface OrderRepo extends JpaRepository<Order, Integer> {

    // Fetch all orders belonging to one user (for "My Orders")
    List<Order> findByUserId(Integer userId);
}