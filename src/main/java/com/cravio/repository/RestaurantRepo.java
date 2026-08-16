package com.cravio.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.cravio.entity.Restaurant;

public interface RestaurantRepo extends JpaRepository<Restaurant, Integer> {

    // Used for filtering restaurants by city (matches frontend's city selector)
    java.util.List<Restaurant> findByCity(String city);
}