package service;

import model.CartItem;
import model.Order;
import model.OrderDetail;
import repository.OrderRepository;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderService {
    private final OrderRepository orderRepository = new OrderRepository();
    private final CartService cartService = new CartService();
    private OrderService orderService;
    private UserService userService;

    public void createOrder(Order order, List<CartItem> cartItems) throws SQLException {
        List<OrderDetail> orderDetails = new ArrayList<>();
        for (CartItem item : cartItems) {
            OrderDetail detail = new OrderDetail();
            detail.setProductId(item.getProduct().getProductId());
            detail.setQuantity(item.getQuantity());
            detail.setUnitPrice(item.getProduct().getPrice());
            detail.setSubtotal(item.getQuantity() * item.getProduct().getPrice());
            detail.setProductName(item.getProduct().getName());
            orderDetails.add(detail);
        }
        order.setOrderDetails(orderDetails);

        int orderId = orderRepository.createOrder(order);
        order.setOrderId(orderId);

        orderRepository.createOrderDetails(orderId, orderDetails);

        orderRepository.createPayment(orderId, order.getCustomerId(), order.getTotalAmount(), order.getPaymentMethod());

        cartService.clearCart(order.getCustomerId());

    }
    public double calculateTotalRevenue() {
        return orderRepository.calculateTotalRevenue();
    }

    public int getTotalOrders() {
        return orderRepository.getTotalOrders();
    }

    public List<Double> getWeeklyRevenue() {
        return orderRepository.getWeeklyRevenue();
    }

    public List<Integer> getDailyOrders() {
        return orderRepository.getDailyOrders();
    }

    public List<Order> getRecentOrders() {
        List<Order> orders = orderRepository.getRecentOrders();
        // Gán tên khách hàng cho từng đơn hàng
        for (Order order : orders) {
            String customerName = userService.getUserNameById(order.getCustomerId());
            // Vì Order không có customerName, ta không thể set trực tiếp
            // Tạm thời lưu vào một thuộc tính khác hoặc xử lý ở tầng trên (Servlet/JSP)
        }
        return orders;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = orderRepository.getAllOrders();
        // Gán tên khách hàng cho từng đơn hàng
        for (Order order : orders) {
            String customerName = userService.getUserNameById(order.getCustomerId());
            // Tương tự, không thể set customerName
        }
        return orders;
    }

    public Order getOrderById(int orderId) {
        Order order = orderRepository.getOrderById(orderId);
        if (order != null) {
            String customerName = userService.getUserNameById(order.getCustomerId());
            // Không thể set customerName
        }
        return order;
    }
}