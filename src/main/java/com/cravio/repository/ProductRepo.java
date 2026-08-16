package com.cravio.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.cravio.entity.Product;

public interface ProductRepo extends JpaRepository<Product, Integer> {

    List<Product> findByIsAvailableTrue();

    List<Product> findByCategoryAndIsAvailableTrue(String category);

    List<Product> findByRestaurantIdAndIsAvailableTrue(Integer restaurantId);
}