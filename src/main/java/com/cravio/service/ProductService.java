package com.cravio.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cravio.entity.Product;
import com.cravio.repository.ProductRepo;

@Service
public class ProductService {

    @Autowired
    private ProductRepo productRepo;

    // Get all products that are currently available
    public List<Product> getAllAvailableProducts() {
        return productRepo.findByIsAvailableTrue();
    }

    // Get a single product by its ID
    public Product getProductById(Integer id) {
        return productRepo.findById(id).orElse(null);
    }

    // Get available products filtered by category
    public List<Product> getProductsByCategory(String category) {
        return productRepo.findByCategoryAndIsAvailableTrue(category);
    }
    
    public List<Product> getProductsByRestaurant(Integer restaurantId) {
        return productRepo.findByRestaurantIdAndIsAvailableTrue(restaurantId);
    }
}