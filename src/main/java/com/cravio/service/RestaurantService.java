package com.cravio.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cravio.controller.CravioController.RestaurantRequest;
import com.cravio.entity.Restaurant;
import com.cravio.repository.RestaurantRepo;

@Service
public class RestaurantService {

    @Autowired
    private RestaurantRepo restaurantRepo;

    public List<Restaurant> getAllRestaurants() {
        return restaurantRepo.findAll();
    }

    public Restaurant getRestaurantById(Integer id) {
        return restaurantRepo.findById(id).orElse(null);
    }

    public List<Restaurant> getRestaurantsByCity(String city) {
        return restaurantRepo.findByCity(city);
    }

    // NEW — lets a restaurant be added via Postman (POST /api/restaurants)
    // instead of only through phpMyAdmin/the MySQL shell.
    @Transactional
    public Restaurant createRestaurant(RestaurantRequest req) {
        validate(req);
        Restaurant restaurant = new Restaurant();
        applyRequest(restaurant, req);
        return restaurantRepo.save(restaurant);
    }

    // NEW — PUT /api/restaurants/{id}
    @Transactional
    public Restaurant updateRestaurant(Integer id, RestaurantRequest req) {
        Restaurant existing = restaurantRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Restaurant not found"));
        validate(req);
        applyRequest(existing, req);
        return restaurantRepo.save(existing);
    }

    // NEW — DELETE /api/restaurants/{id}
    // Note: this will fail with a foreign key error if the restaurant still
    // has products pointing at it. Delete/reassign its products first.
    @Transactional
    public void deleteRestaurant(Integer id) {
        if (!restaurantRepo.existsById(id)) {
            throw new RuntimeException("Restaurant not found");
        }
        restaurantRepo.deleteById(id);
    }

    private void applyRequest(Restaurant restaurant, RestaurantRequest req) {
        restaurant.setName(req.getName().trim());
        restaurant.setCity(req.getCity());
        restaurant.setLocality(req.getLocality());
        restaurant.setAddress(req.getAddress());
        restaurant.setCuisine(req.getCuisine());
        restaurant.setRating(req.getRating());
        restaurant.setDeliveryTime(req.getDeliveryTime());
        restaurant.setPriceForTwo(req.getPriceForTwo());
        restaurant.setOpeningHours(req.getOpeningHours());
        restaurant.setImageUrl(req.getImageUrl());
        restaurant.setDescription(req.getDescription());
    }

    private void validate(RestaurantRequest req) {
        if (req.getName() == null || req.getName().trim().isEmpty()) {
            throw new RuntimeException("Restaurant name is required");
        }
    }
}