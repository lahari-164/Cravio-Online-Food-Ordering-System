package com.cravio.service;

import java.math.BigDecimal;
import java.util.UUID;
import org.springframework.stereotype.Service;

// This was an empty stub before (no @Service, no methods, never wired
// into OrderService). checkout.jsp lets the user submit ANY payment
// method / amount with zero server-side validation.
//
// This is still NOT a real payment gateway integration — there's no
// Razorpay/Stripe/PayU account behind it. It gives you:
//   1) server-side validation of the payment method + amount
//   2) a single place to plug in a real gateway SDK later
//   3) a transaction reference stored against the Order for audit/tracking
@Service
public class PaymentService {

    /**
     * Validates the payment details and (for online methods) simulates
     * gateway authorization. Throws RuntimeException on anything invalid.
     * Returns a transaction reference to store on the Order.
     */
    public String authorizePayment(String paymentMethod, BigDecimal amount) {
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            throw new RuntimeException("Payment method is required");
        }
        if (amount == null || amount.signum() <= 0) {
            throw new RuntimeException("Invalid order amount for payment");
        }

        String normalized = paymentMethod.trim().toUpperCase();

        // Cash on Delivery needs no gateway authorization
        if (normalized.contains("COD") || normalized.contains("CASH")) {
            return "COD-" + shortId();
        }

        // UPI / Card / Netbanking all go through the (simulated) gateway.
        // TODO: replace this block with a real gateway SDK call, e.g.:
        //   RazorpayClient client = new RazorpayClient(keyId, keySecret);
        //   Order order = client.orders.create(orderRequest);
        // and propagate a real failure (insufficient funds, card declined, etc.)
        // as a RuntimeException so OrderService rolls the order back.
        if (normalized.contains("UPI") || normalized.contains("CARD") || normalized.contains("NET")) {
            return "TXN-" + shortId();
        }

        throw new RuntimeException("Unsupported payment method: " + paymentMethod);
    }

    private String shortId() {
        return UUID.randomUUID().toString().substring(0, 10).toUpperCase();
    }
}
