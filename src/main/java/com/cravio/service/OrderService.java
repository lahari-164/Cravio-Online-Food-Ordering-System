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

    // Centralizes every valid status value so cancel/update can validate
    // against it instead of accepting any random string.
    public static final List<String> VALID_STATUSES = List.of(
            "Pending", "Preparing", "Out for Delivery", "Delivered", "Cancelled");

    // Statuses a user is still allowed to cancel from
    private static final List<String> CANCELLABLE_STATUSES = List.of("Pending", "Preparing");

    @Autowired
    private OrderRepo orderRepo;

    @Autowired
    private OrderItemRepo orderItemRepo;

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private PaymentService paymentService; // NEW

    public static class CartItemRequest {
        private Integer productId;
        private Integer quantity;

        public Integer getProductId() { return productId; }
        public void setProductId(Integer productId) { this.productId = productId; }
        public Integer getQuantity() { return quantity; }
        public void setQuantity(Integer quantity) { this.quantity = quantity; }
    }

    @Transactional
    public Order placeOrder(Integer userId, String deliveryAddress, String paymentMethod, List<CartItemRequest> cartItems) {

        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (cartItems == null || cartItems.isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        BigDecimal totalAmount = BigDecimal.ZERO;

        for (CartItemRequest item : cartItems) {
            Product product = productRepo.findById(item.getProductId())
                    .orElseThrow(() -> new RuntimeException("Product not found: " + item.getProductId()));

            if (product.getIsAvailable() == null || !product.getIsAvailable()) {
                throw new RuntimeException("Product not available: " + product.getName());
            }

            BigDecimal lineTotal = product.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            totalAmount = totalAmount.add(lineTotal);
        }

        // NEW — validate payment method/amount and get a transaction reference
        // BEFORE writing anything to the DB. If this throws, @Transactional
        // means nothing partial gets saved.
        String transactionId = paymentService.authorizePayment(paymentMethod, totalAmount);

        Order order = new Order();
        order.setUser(user);
        order.setTotalAmount(totalAmount);
        order.setStatus("Pending");
        order.setDeliveryAddress(deliveryAddress);
        order.setPaymentMethod(paymentMethod);
        order.setTransactionId(transactionId); // NEW
        Order savedOrder = orderRepo.save(order);

        for (CartItemRequest item : cartItems) {
            Product product = productRepo.findById(item.getProductId()).get();

            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(savedOrder);
            orderItem.setProduct(product);
            orderItem.setQuantity(item.getQuantity());
            orderItem.setPrice(product.getPrice());
            orderItemRepo.save(orderItem);
        }

        return savedOrder;
    }

    public List<Order> getOrdersForUser(Integer userId) {
        return orderRepo.findByUserId(userId);
    }

    public List<OrderItem> getOrderItems(Integer orderId) {
        return orderItemRepo.findByOrderId(orderId);
    }

    public Order getOrderForUser(Integer orderId, Integer userId) {
        Order order = orderRepo.findById(orderId).orElse(null);
        if (order == null) {
            return null;
        }
        if (!order.getUser().getId().equals(userId)) {
            return null;
        }
        return order;
    }

    // NEW — lets a user cancel their own order, only while it's still
    // Pending/Preparing. Backs a "Cancel Order" button that doesn't exist
    // yet in orders.jsp/track-order.jsp but should.
    @Transactional
    public Order cancelOrder(Integer orderId, Integer userId) {
        Order order = getOrderForUser(orderId, userId);
        if (order == null) {
            throw new RuntimeException("Order not found or access denied");
        }
        if (!CANCELLABLE_STATUSES.contains(order.getStatus())) {
            throw new RuntimeException("This order can no longer be cancelled");
        }
        order.setStatus("Cancelled");
        return orderRepo.save(order);
    }

    // NEW — moves an order through its lifecycle (Preparing -> Out for
    // Delivery -> Delivered). Right now nothing calls this because there's
    // no restaurant/admin side to the app yet (see backend improvements).
    @Transactional
    public Order updateOrderStatus(Integer orderId, String newStatus) {
        if (newStatus == null || !VALID_STATUSES.contains(newStatus)) {
            throw new RuntimeException("Invalid order status: " + newStatus);
        }
        Order order = orderRepo.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setStatus(newStatus);
        return orderRepo.save(order);
    }
}
