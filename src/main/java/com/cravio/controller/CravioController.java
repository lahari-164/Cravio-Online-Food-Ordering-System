package com.cravio.controller;

import com.cravio.entity.Restaurant;
import com.cravio.entity.Order;
import com.cravio.entity.OrderItem;
import com.cravio.service.OrderService;
import com.cravio.service.OrderService.CartItemRequest;
import org.springframework.web.bind.annotation.PathVariable;
import java.util.Map;
import com.cravio.service.RestaurantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import com.cravio.service.ProductService;
import com.cravio.entity.Product;
import java.util.List;
import com.cravio.entity.User;
import com.cravio.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CravioController {
	@Autowired
	private UserService userService;

	@Autowired
	private ProductService productService;

	@Autowired
	private RestaurantService restaurantService;

	@Autowired
	private OrderService orderService;

	// ==========================================
	// PAGE ROUTES (return JSP view names)
	// ==========================================

	@GetMapping({ "/", "/index" })
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

	@GetMapping({ "/restaurant", "/restaurant-menu", "/restaurant-detail" })
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

	// ==========================================
	// AUTH APIs (return JSON, not JSP views)
	// ==========================================

	@PostMapping("/api/register")
	@ResponseBody
	public ResponseEntity<?> registerApi(@RequestBody User user) {
		try {
			User saved = userService.registerUser(user);
			saved.setPassword(null); // never send the hash back
			return ResponseEntity.ok(saved);
		} catch (RuntimeException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
		}
	}

	@PostMapping("/api/login")
	@ResponseBody
	public ResponseEntity<?> loginApi(@RequestBody LoginRequest loginRequest, HttpSession session) {
		User user = userService.loginUser(loginRequest.getEmail(), loginRequest.getPassword());

		if (user == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid email or password");
		}

		session.setAttribute("userId", user.getId());
		session.setAttribute("userName", user.getName());

		user.setPassword(null);
		return ResponseEntity.ok(user);
	}

	@PostMapping("/api/logout")
	@ResponseBody
	public ResponseEntity<?> logoutApi(HttpSession session) {
		session.invalidate();
		return ResponseEntity.ok("Logged out successfully");
	}

	// ==========================================
	// PRODUCT APIs
	// ==========================================

	@GetMapping("/api/products")
	@ResponseBody
	public List<Product> getAllProducts() {
		return productService.getAllAvailableProducts();
	}

	@GetMapping("/api/products/{id}")
	@ResponseBody
	public ResponseEntity<?> getProductById(@org.springframework.web.bind.annotation.PathVariable Integer id) {
		Product product = productService.getProductById(id);
		if (product == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product not found");
		}
		return ResponseEntity.ok(product);
	}

	@GetMapping("/api/products/category/{category}")
	@ResponseBody
	public List<Product> getProductsByCategory(@org.springframework.web.bind.annotation.PathVariable String category) {
		return productService.getProductsByCategory(category);
	}
	// ==========================================
	// RESTAURANT APIs
	// ==========================================

	@GetMapping("/api/restaurants")
	@ResponseBody
	public List<Restaurant> getAllRestaurants() {
		return restaurantService.getAllRestaurants();
	}

	@GetMapping("/api/restaurants/{id}")
	@ResponseBody
	public ResponseEntity<?> getRestaurantById(@org.springframework.web.bind.annotation.PathVariable Integer id) {
		Restaurant restaurant = restaurantService.getRestaurantById(id);
		if (restaurant == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Restaurant not found");
		}
		return ResponseEntity.ok(restaurant);
	}

	@GetMapping("/api/restaurants/{id}/products")
	@ResponseBody
	public List<Product> getProductsByRestaurant(@org.springframework.web.bind.annotation.PathVariable Integer id) {
		return productService.getProductsByRestaurant(id);
	}
	// ==========================================
    // ORDER APIs
    // ==========================================

    // Request body shape: { "deliveryAddress": "...", "paymentMethod": "UPI",
    //                        "items": [ { "productId": 1, "quantity": 2 }, ... ] }
    @PostMapping("/api/orders")
    @ResponseBody
    public ResponseEntity<?> placeOrder(@RequestBody PlaceOrderRequest request, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Please log in to place an order");
        }

        try {
            Order order = orderService.placeOrder(
                    userId,
                    request.getDeliveryAddress(),
                    request.getPaymentMethod(),
                    request.getItems()
            );
            return ResponseEntity.ok(order);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // Logged-in user's own order history
    @GetMapping("/api/orders/my-orders")
    @ResponseBody
    public ResponseEntity<?> getMyOrders(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Please log in");
        }
        List<Order> orders = orderService.getOrdersForUser(userId);
        return ResponseEntity.ok(orders);
    }

    // Single order details — only visible to the user who placed it
    @GetMapping("/api/orders/{id}")
    @ResponseBody
    public ResponseEntity<?> getOrderDetails(@PathVariable Integer id, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Please log in");
        }

        Order order = orderService.getOrderForUser(id, userId);
        if (order == null) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Order not found or access denied");
        }

        List<OrderItem> items = orderService.getOrderItems(id);

        Map<String, Object> response = new java.util.HashMap<>();
        response.put("order", order);
        response.put("items", items);
        return ResponseEntity.ok(response);
    }

    // Helper class to read the place-order JSON body
    public static class PlaceOrderRequest {
        private String deliveryAddress;
        private String paymentMethod;
        private List<CartItemRequest> items;

        public String getDeliveryAddress() { return deliveryAddress; }
        public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
        public String getPaymentMethod() { return paymentMethod; }
        public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
        public List<CartItemRequest> getItems() { return items; }
        public void setItems(List<CartItemRequest> items) { this.items = items; }
    }

	// Helper class to read {email, password} JSON from the login request body
	public static class LoginRequest {
		private String email;
		private String password;

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}
	}
}