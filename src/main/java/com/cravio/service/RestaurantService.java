package com.cravio.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}