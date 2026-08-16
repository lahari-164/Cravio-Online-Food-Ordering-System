package com.cravio.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cravio.controller.CravioController.ProductRequest;
import com.cravio.entity.Product;
import com.cravio.entity.Restaurant;
import com.cravio.repository.ProductRepo;
import com.cravio.repository.RestaurantRepo;

@Service
public class ProductService {

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private RestaurantRepo restaurantRepo;

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

    // NEW — lets a menu item be added via Postman (POST /api/products) once
    // its restaurant already exists (create the restaurant first).
    @Transactional
    public Product createProduct(ProductRequest req) {
        Restaurant restaurant = requireRestaurant(req.getRestaurantId());
        validate(req);

        Product product = new Product();
        product.setRestaurant(restaurant);
        applyRequest(product, req);
        return productRepo.save(product);
    }

    // NEW — PUT /api/products/{id}
    @Transactional
    public Product updateProduct(Integer id, ProductRequest req) {
        Product existing = productRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        validate(req);

        if (req.getRestaurantId() != null) {
            existing.setRestaurant(requireRestaurant(req.getRestaurantId()));
        }
        applyRequest(existing, req);
        return productRepo.save(existing);
    }

    // NEW — DELETE /api/products/{id}
    @Transactional
    public void deleteProduct(Integer id) {
        if (!productRepo.existsById(id)) {
            throw new RuntimeException("Product not found");
        }
        productRepo.deleteById(id);
    }

    private Restaurant requireRestaurant(Integer restaurantId) {
        if (restaurantId == null) {
            throw new RuntimeException("restaurantId is required");
        }
        return restaurantRepo.findById(restaurantId)
                .orElseThrow(() -> new RuntimeException("Restaurant not found: " + restaurantId));
    }

    private void applyRequest(Product product, ProductRequest req) {
        product.setName(req.getName().trim());
        product.setDescription(req.getDescription());
        product.setPrice(req.getPrice());
        product.setImageUrl(req.getImageUrl());
        product.setCategory(req.getCategory());
        product.setIsAvailable(req.getIsAvailable() == null ? Boolean.TRUE : req.getIsAvailable());
    }

    private void validate(ProductRequest req) {
        if (req.getName() == null || req.getName().trim().isEmpty()) {
            throw new RuntimeException("Product name is required");
        }
        if (req.getPrice() == null || req.getPrice().signum() <= 0) {
            throw new RuntimeException("Product price must be greater than 0");
        }
    }
}