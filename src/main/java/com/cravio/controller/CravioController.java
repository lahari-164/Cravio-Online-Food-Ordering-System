package com.cravio.controller;

import com.cravio.entity.Address;
import com.cravio.entity.Restaurant;
import com.cravio.entity.Order;
import com.cravio.entity.OrderItem;
import com.cravio.service.AddressService;
import com.cravio.service.OrderService;
import com.cravio.service.OrderService.CartItemRequest;
import org.springframework.web.bind.annotation.PathVariable;
import java.util.Map;
import com.cravio.service.RestaurantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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

	@Autowired
	private AddressService addressService; // NEW

	// ==========================================
	// PAGE ROUTES (return JSP view names)
	// ==========================================
	// NOTE: /login, /register, /orders, /order-details, /order-success,
	// /profile, /addresses map to JSP files that do NOT exist in
	// src/main/webapp/WEB-INF/views. Login/Register/Profile/Addresses are
	// actually handled by the auth-modal.jsp / profile-modal.jsp overlays
	// included on every page — so hitting these URLs directly currently
	// throws a 500. See the "backend improvements" notes for the fix.

	@GetMapping({ "/", "/index" })
	public String home() {
		return "index";
	}

	@GetMapping("/error")
	public String errorPage() {
		return "error";
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
		User saved = userService.registerUser(user);
		saved.setPassword(null);
		return ResponseEntity.ok(saved);
	}

	@PostMapping("/api/login")
	@ResponseBody
	public ResponseEntity<?> loginApi(@RequestBody LoginRequest loginRequest, HttpSession session) {
		User user = userService.loginUser(loginRequest.getEmail(), loginRequest.getPassword());

		if (user == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid email or password");
		}

		// Regenerate the session on login to prevent session fixation —
		// see backend improvements notes.
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
	// PROFILE APIs (NEW)
	// ==========================================

	@PutMapping("/api/users/profile")
	@ResponseBody
	public ResponseEntity<?> updateProfile(@RequestBody UpdateProfileRequest request, HttpSession session) {
		Integer userId = requireUserId(session);
		User updated = userService.updateProfile(userId, request.getName(), request.getPhone());
		updated.setPassword(null);
		session.setAttribute("userName", updated.getName());
		return ResponseEntity.ok(updated);
	}

	@PutMapping("/api/users/password")
	@ResponseBody
	public ResponseEntity<?> changePassword(@RequestBody ChangePasswordRequest request, HttpSession session) {
		Integer userId = requireUserId(session);
		userService.changePassword(userId, request.getCurrentPassword(), request.getNewPassword());
		return ResponseEntity.ok("Password updated successfully");
	}

	// ==========================================
	// ADDRESS APIs (NEW)
	// ==========================================

	@GetMapping("/api/addresses")
	@ResponseBody
	public ResponseEntity<?> getAddresses(HttpSession session) {
		Integer userId = requireUserId(session);
		return ResponseEntity.ok(addressService.getAddressesForUser(userId));
	}

	@PostMapping("/api/addresses")
	@ResponseBody
	public ResponseEntity<?> addAddress(@RequestBody AddressRequest request, HttpSession session) {
		Integer userId = requireUserId(session);
		Address saved = addressService.addAddress(userId, request);
		return ResponseEntity.status(HttpStatus.CREATED).body(saved);
	}

	@PutMapping("/api/addresses/{id}")
	@ResponseBody
	public ResponseEntity<?> updateAddress(@PathVariable Integer id, @RequestBody AddressRequest request, HttpSession session) {
		Integer userId = requireUserId(session);
		return ResponseEntity.ok(addressService.updateAddress(id, userId, request));
	}

	@DeleteMapping("/api/addresses/{id}")
	@ResponseBody
	public ResponseEntity<?> deleteAddress(@PathVariable Integer id, HttpSession session) {
		Integer userId = requireUserId(session);
		addressService.deleteAddress(id, userId);
		return ResponseEntity.ok("Address deleted");
	}

	@PutMapping("/api/addresses/{id}/default")
	@ResponseBody
	public ResponseEntity<?> setDefaultAddress(@PathVariable Integer id, HttpSession session) {
		Integer userId = requireUserId(session);
		addressService.setDefaultAddress(id, userId);
		return ResponseEntity.ok("Default address updated");
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
	public ResponseEntity<?> getProductById(@PathVariable Integer id) {
		Product product = productService.getProductById(id);
		if (product == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product not found");
		}
		return ResponseEntity.ok(product);
	}

	@GetMapping("/api/products/category/{category}")
	@ResponseBody
	public List<Product> getProductsByCategory(@PathVariable String category) {
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
	public ResponseEntity<?> getRestaurantById(@PathVariable Integer id) {
		Restaurant restaurant = restaurantService.getRestaurantById(id);
		if (restaurant == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Restaurant not found");
		}
		return ResponseEntity.ok(restaurant);
	}

	@GetMapping("/api/restaurants/{id}/products")
	@ResponseBody
	public List<Product> getProductsByRestaurant(@PathVariable Integer id) {
		return productService.getProductsByRestaurant(id);
	}

	// ==========================================
	// RESTAURANT ADMIN APIs (NEW)
	// Use these from Postman to seed/manage restaurants — there's no
	// admin UI yet, so this is the only way in besides the MySQL shell.
	// ==========================================

	@PostMapping("/api/restaurants")
	@ResponseBody
	public ResponseEntity<?> createRestaurant(@RequestBody RestaurantRequest request) {
		Restaurant saved = restaurantService.createRestaurant(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(saved);
	}

	@PutMapping("/api/restaurants/{id}")
	@ResponseBody
	public ResponseEntity<?> updateRestaurant(@PathVariable Integer id, @RequestBody RestaurantRequest request) {
		return ResponseEntity.ok(restaurantService.updateRestaurant(id, request));
	}

	@DeleteMapping("/api/restaurants/{id}")
	@ResponseBody
	public ResponseEntity<?> deleteRestaurant(@PathVariable Integer id) {
		restaurantService.deleteRestaurant(id);
		return ResponseEntity.ok("Restaurant deleted");
	}

	// ==========================================
	// PRODUCT ADMIN APIs (NEW)
	// Add menu items to a restaurant you've already created above.
	// ==========================================

	@PostMapping("/api/products")
	@ResponseBody
	public ResponseEntity<?> createProduct(@RequestBody ProductRequest request) {
		Product saved = productService.createProduct(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(saved);
	}

	@PutMapping("/api/products/{id}")
	@ResponseBody
	public ResponseEntity<?> updateProduct(@PathVariable Integer id, @RequestBody ProductRequest request) {
		return ResponseEntity.ok(productService.updateProduct(id, request));
	}

	@DeleteMapping("/api/products/{id}")
	@ResponseBody
	public ResponseEntity<?> deleteProduct(@PathVariable Integer id) {
		productService.deleteProduct(id);
		return ResponseEntity.ok("Product deleted");
	}

	// ==========================================
	// ORDER APIs
	// ==========================================

	@PostMapping("/api/orders")
	@ResponseBody
	public ResponseEntity<?> placeOrder(@RequestBody PlaceOrderRequest request, HttpSession session) {
		Integer userId = requireUserId(session);
		Order order = orderService.placeOrder(
				userId,
				request.getDeliveryAddress(),
				request.getPaymentMethod(),
				request.getItems()
		);
		return ResponseEntity.ok(order);
	}

	@GetMapping("/api/orders/my-orders")
	@ResponseBody
	public ResponseEntity<?> getMyOrders(HttpSession session) {
		Integer userId = requireUserId(session);
		List<Order> orders = orderService.getOrdersForUser(userId);
		return ResponseEntity.ok(orders);
	}

	@GetMapping("/api/orders/{id}")
	@ResponseBody
	public ResponseEntity<?> getOrderDetails(@PathVariable Integer id, HttpSession session) {
		Integer userId = requireUserId(session);

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

	// NEW — lets the logged-in user cancel their own Pending/Preparing order.
	// Wire a "Cancel Order" button in orders.jsp / track-order.jsp to this.
	@PutMapping("/api/orders/{id}/cancel")
	@ResponseBody
	public ResponseEntity<?> cancelOrder(@PathVariable Integer id, HttpSession session) {
		Integer userId = requireUserId(session);
		Order order = orderService.cancelOrder(id, userId);
		return ResponseEntity.ok(order);
	}

	// Small helper so every protected endpoint doesn't repeat the same
	// "get userId from session or return 401" check.
	private Integer requireUserId(HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			throw new UnauthorizedException("Please log in to continue");
		}
		return userId;
	}

	// Thrown by requireUserId; caught below so it still returns 401
	// (not the 400 that GlobalExceptionHandler gives plain RuntimeExceptions).
	public static class UnauthorizedException extends RuntimeException {
		public UnauthorizedException(String message) { super(message); }
	}

	@org.springframework.web.bind.annotation.ExceptionHandler(UnauthorizedException.class)
	@ResponseBody
	public ResponseEntity<?> handleUnauthorized(UnauthorizedException ex) {
		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ex.getMessage());
	}

	// ==========================================
	// REQUEST DTOs
	// ==========================================

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

	public static class LoginRequest {
		private String email;
		private String password;

		public String getEmail() { return email; }
		public void setEmail(String email) { this.email = email; }
		public String getPassword() { return password; }
		public void setPassword(String password) { this.password = password; }
	}

	public static class UpdateProfileRequest {
		private String name;
		private String phone;

		public String getName() { return name; }
		public void setName(String name) { this.name = name; }
		public String getPhone() { return phone; }
		public void setPhone(String phone) { this.phone = phone; }
	}

	
	public static class ChangePasswordRequest {
		private String currentPassword;
		private String newPassword;

		public String getCurrentPassword() { return currentPassword; }
		public void setCurrentPassword(String currentPassword) { this.currentPassword = currentPassword; }
		public String getNewPassword() { return newPassword; }
		public void setNewPassword(String newPassword) { this.newPassword = newPassword; }
	}

	// Body for POST/PUT /api/restaurants. Matches the "restaurants" table
	// columns exactly (see `desc restaurants;`).
	public static class RestaurantRequest {
		private String name;
		private String city;
		private String locality;
		private String address;
		private String cuisine; // comma-separated, e.g. "North Indian,Chinese"
		private java.math.BigDecimal rating;
		private String deliveryTime;
		private Integer priceForTwo;
		private String openingHours;
		private String imageUrl;
		private String description;

		public String getName() { return name; }
		public void setName(String name) { this.name = name; }
		public String getCity() { return city; }
		public void setCity(String city) { this.city = city; }
		public String getLocality() { return locality; }
		public void setLocality(String locality) { this.locality = locality; }
		public String getAddress() { return address; }
		public void setAddress(String address) { this.address = address; }
		public String getCuisine() { return cuisine; }
		public void setCuisine(String cuisine) { this.cuisine = cuisine; }
		public java.math.BigDecimal getRating() { return rating; }
		public void setRating(java.math.BigDecimal rating) { this.rating = rating; }
		public String getDeliveryTime() { return deliveryTime; }
		public void setDeliveryTime(String deliveryTime) { this.deliveryTime = deliveryTime; }
		public Integer getPriceForTwo() { return priceForTwo; }
		public void setPriceForTwo(Integer priceForTwo) { this.priceForTwo = priceForTwo; }
		public String getOpeningHours() { return openingHours; }
		public void setOpeningHours(String openingHours) { this.openingHours = openingHours; }
		public String getImageUrl() { return imageUrl; }
		public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
		public String getDescription() { return description; }
		public void setDescription(String description) { this.description = description; }
	}

	// Body for POST/PUT /api/products. restaurantId must reference an
	// existing restaurant (create it first via /api/restaurants).
	public static class ProductRequest {
		private Integer restaurantId;
		private String name;
		private String description;
		private java.math.BigDecimal price;
		private String imageUrl;
		private String category;
		private Boolean isAvailable;

		public Integer getRestaurantId() { return restaurantId; }
		public void setRestaurantId(Integer restaurantId) { this.restaurantId = restaurantId; }
		public String getName() { return name; }
		public void setName(String name) { this.name = name; }
		public String getDescription() { return description; }
		public void setDescription(String description) { this.description = description; }
		public java.math.BigDecimal getPrice() { return price; }
		public void setPrice(java.math.BigDecimal price) { this.price = price; }
		public String getImageUrl() { return imageUrl; }
		public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
		public String getCategory() { return category; }
		public void setCategory(String category) { this.category = category; }
		public Boolean getIsAvailable() { return isAvailable; }
		public void setIsAvailable(Boolean isAvailable) { this.isAvailable = isAvailable; }
	}

	// (addrFormTag, addrFormTitleInput, addrFormStreetInput, ...)
	public static class AddressRequest {
		private String tag;
		private String title;
		private String street;
		private String city;
		private String zipcode;
		private Boolean isDefault;

		public String getTag() { return tag; }
		public void setTag(String tag) { this.tag = tag; }
		public String getTitle() { return title; }
		public void setTitle(String title) { this.title = title; }
		public String getStreet() { return street; }
		public void setStreet(String street) { this.street = street; }
		public String getCity() { return city; }
		public void setCity(String city) { this.city = city; }
		public String getZipcode() { return zipcode; }
		public void setZipcode(String zipcode) { this.zipcode = zipcode; }
		public Boolean getIsDefault() { return isDefault; }
		public void setIsDefault(Boolean isDefault) { this.isDefault = isDefault; }
	}
}
