package com.cravio.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CravioController {

    @GetMapping({"/", "/index"})
    public String home() {
        return "index";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @GetMapping("/restaurants")
    public String restaurants() {
        return "restaurants";
    }

    @GetMapping({"/restaurant", "/restaurant-menu", "/restaurant-detail"})
    public String restaurantMenu() {
        return "restaurant-detail";
    }

    @GetMapping("/cart")
    public String cart() {
        return "cart";
    }

    @GetMapping("/checkout")
    public String checkout() {
        return "checkout";
    }

    @GetMapping("/track-order")
    public String trackOrder() {
        return "track-order";
    }

    @GetMapping("/orders")
    public String orders() {
        return "orders";
    }

    @GetMapping("/order-details")
    public String orderDetails() {
        return "order-details";
    }

    @GetMapping("/order-success")
    public String orderSuccess() {
        return "order-success";
    }

    @GetMapping("/profile")
    public String profile() {
        return "profile";
    }

    @GetMapping("/addresses")
    public String addresses() {
        return "addresses";
    }

    @GetMapping("/about")
    public String about() {
        return "about";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }
}