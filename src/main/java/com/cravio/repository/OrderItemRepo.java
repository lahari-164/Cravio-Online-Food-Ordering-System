package com.cravio.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.cravio.entity.OrderItem;

public interface OrderItemRepo extends JpaRepository<OrderItem, Integer> {

    // Fetch all items belonging to one order
    List<OrderItem> findByOrderId(Integer orderId);
}