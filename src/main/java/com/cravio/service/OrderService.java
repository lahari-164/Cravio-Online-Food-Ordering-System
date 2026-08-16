package com.cravio.service;

import java.math.BigDecimal;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cravio.entity.Order;
import com.cravio.entity.OrderItem;
import com.cravio.entity.Product;
import com.cravio.entity.User;
import com.cravio.repository.OrderItemRepo;
import com.cravio.repository.OrderRepo;
import com.cravio.repository.ProductRepo;
import com.cravio.repository.UserRepo;

@Service
public class OrderService {

    @Autowired
    private OrderRepo orderRepo;

    @Autowired
    private OrderItemRepo orderItemRepo;

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private UserRepo userRepo;

    // Simple structure representing "one line" from the cart the frontend sends us:
    // just a productId and a quantity. We never trust a price sent from the frontend.
    public static class CartItemRequest {
        private Integer productId;
        private Integer quantity;

        public Integer getProductId() { return productId; }
        public void setProductId(Integer productId) { this.productId = productId; }
        public Integer getQuantity() { return quantity; }
        public void setQuantity(Integer quantity) { this.quantity = quantity; }
    }

    // @Transactional makes sure the order + all its items are saved together.
    // If anything fails partway through, everything rolls back — no half-saved orders.
    @Transactional
    public Order placeOrder(Integer userId, String deliveryAddress, String paymentMethod, List<CartItemRequest> cartItems) {

        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (cartItems == null || cartItems.isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        BigDecimal totalAmount = BigDecimal.ZERO;

        // First pass: validate every product exists and is available,
        // and calculate the real total using DATABASE prices (never frontend prices).
        for (CartItemRequest item : cartItems) {
            Product product = productRepo.findById(item.getProductId())
                    .orElseThrow(() -> new RuntimeException("Product not found: " + item.getProductId()));

            if (product.getIsAvailable() == null || !product.getIsAvailable()) {
                throw new RuntimeException("Product not available: " + product.getName());
            }

            BigDecimal lineTotal = product.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            totalAmount = totalAmount.add(lineTotal);
        }

        // Create the order first (so it gets an ID we can attach items to)
        Order order = new Order();
        order.setUser(user);
        order.setTotalAmount(totalAmount);
        order.setStatus("Pending");
        order.setDeliveryAddress(deliveryAddress);
        order.setPaymentMethod(paymentMethod);
        Order savedOrder = orderRepo.save(order);

        // Second pass: create the order_items rows, using the price AT THIS MOMENT
        for (CartItemRequest item : cartItems) {
            Product product = productRepo.findById(item.getProductId()).get();

            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(savedOrder);
            orderItem.setProduct(product);
            orderItem.setQuantity(item.getQuantity());
            orderItem.setPrice(product.getPrice()); // snapshot price at order time
            orderItemRepo.save(orderItem);
        }

        return savedOrder;
    }

    // Get all orders belonging to one user (My Orders page)
    public List<Order> getOrdersForUser(Integer userId) {
        return orderRepo.findByUserId(userId);
    }

    // Get items belonging to one order
    public List<OrderItem> getOrderItems(Integer orderId) {
        return orderItemRepo.findByOrderId(orderId);
    }

    // Get a single order, but ONLY if it belongs to the given user.
    // Returns null if the order doesn't exist OR belongs to someone else —
    // the controller will treat both cases as "not accessible" for security.
    public Order getOrderForUser(Integer orderId, Integer userId) {
        Order order = orderRepo.findById(orderId).orElse(null);

        if (order == null) {
            return null;
        }

        if (!order.getUser().getId().equals(userId)) {
            return null; // belongs to a different user — deny access
        }

        return order;
    }
}