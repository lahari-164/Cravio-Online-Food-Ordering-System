package com.cravio.entity;

import java.math.BigDecimal;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "restaurants")
@Getter
@Setter
public class Restaurant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false, length = 150)
    private String name;

    @Column(name = "city", length = 100)
    private String city;

    @Column(name = "locality", length = 100)
    private String locality;

    @Column(name = "address", length = 255)
    private String address;

    // Comma-separated for simplicity, e.g. "Hyderabadi,Biryani,Mughlai"
    @Column(name = "cuisine", length = 255)
    private String cuisine;

    @Column(name = "rating", precision = 2, scale = 1)
    private BigDecimal rating;

    @Column(name = "delivery_time", length = 50)
    private String deliveryTime;

    @Column(name = "price_for_two")
    private Integer priceForTwo;

    @Column(name = "opening_hours", length = 100)
    private String openingHours;

    @Column(name = "image_url", length = 500)
    private String imageUrl;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
}