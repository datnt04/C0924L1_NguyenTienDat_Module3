package repository;

import model.Order;
import model.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class OrderRepository {

    public int createOrder(Order order) throws SQLException {
        String insertOrderQuery = "INSERT INTO Orders (Customer_ID, Order_Date, Total_Amount, Order_Notes, Payment_Method, Status) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getCustomerId());
            stmt.setTimestamp(2, new Timestamp(order.getOrderDate().getTime()));
            stmt.setDouble(3, order.getTotalAmount());
            stmt.setString(4, order.getOrderNotes());
            stmt.setString(5, order.getPaymentMethod());
            stmt.setString(6, order.getStatus());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Tạo đơn hàng thất bại, không có hàng nào được thêm.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Tạo đơn hàng thất bại, không lấy được ID.");
                }
            }
        }
    }

    public void createOrderDetails(int orderId, List<OrderDetail> orderDetails) throws SQLException {
        String insertOrderDetailQuery = "INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Unit_Price) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertOrderDetailQuery)) {
            for (OrderDetail detail : orderDetails) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, detail.getProductId());
                stmt.setInt(3, detail.getQuantity());
                stmt.setDouble(4, detail.getUnitPrice());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    public void createPayment(int orderId, int customerId, double amount, String method) throws SQLException {
        String insertPaymentQuery = "INSERT INTO Payment (Order_ID, Customer_ID, Amount, Method, Payment_Date) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertPaymentQuery)) {
            stmt.setInt(1, orderId);
            stmt.setInt(2, customerId);
            stmt.setDouble(3, amount);
            stmt.setString(4, method);
            stmt.executeUpdate();
        }
    }
    public double calculateTotalRevenue() {
        String sql = "SELECT SUM(Total_Amount) AS total FROM Orders";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) AS total FROM Orders";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    public List<Double> getWeeklyRevenue() {
        List<Double> weeklyRevenue = new ArrayList<>();
        String sql = "SELECT " +
                "CASE " +
                "    WHEN DAY(Order_Date) BETWEEN 1 AND 7 THEN 1 " +
                "    WHEN DAY(Order_Date) BETWEEN 8 AND 14 THEN 2 " +
                "    WHEN DAY(Order_Date) BETWEEN 15 AND 21 THEN 3 " +
                "    WHEN DAY(Order_Date) BETWEEN 22 AND 28 THEN 4 " +
                "    ELSE 5 " +
                "END AS week_number, " +
                "SUM(Total_Amount) AS total " +
                "FROM Orders " +
                "WHERE MONTH(Order_Date) = MONTH(CURRENT_DATE) " +
                "  AND YEAR(Order_Date) = YEAR(CURRENT_DATE) " +
                "GROUP BY " +
                "    CASE " +
                "        WHEN DAY(Order_Date) BETWEEN 1 AND 7 THEN 1 " +
                "        WHEN DAY(Order_Date) BETWEEN 8 AND 14 THEN 2 " +
                "        WHEN DAY(Order_Date) BETWEEN 15 AND 21 THEN 3 " +
                "        WHEN DAY(Order_Date) BETWEEN 22 AND 28 THEN 4 " +
                "        ELSE 5 " +
                "    END";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            // Khởi tạo 5 tuần với giá trị 0
            for (int i = 0; i < 5; i++) {
                weeklyRevenue.add(0.0);
            }
            // Cập nhật doanh thu cho từng tuần
            while (rs.next()) {
                int weekNumber = rs.getInt("week_number") - 1; // Chuyển về chỉ số 0-4
                if (weekNumber >= 0 && weekNumber < 5) {
                    weeklyRevenue.set(weekNumber, rs.getDouble("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return weeklyRevenue;
    }
    public List<Integer> getDailyOrders() {
        List<Integer> dailyOrders = new ArrayList<>();
        String sql = "SELECT DAY(Order_Date) AS day, COUNT(*) AS total " +
                "FROM Orders " +
                "WHERE MONTH(Order_Date) = MONTH(CURRENT_DATE) " +
                "  AND YEAR(Order_Date) = YEAR(CURRENT_DATE) " +
                "GROUP BY DAY(Order_Date)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            // Khởi tạo 7 ngày (theo dữ liệu trong biểu đồ)
            for (int i = 0; i < 7; i++) {
                dailyOrders.add(0);
            }
            int[] days = {2, 10, 13, 14, 24, 5, 19}; // Các ngày trong biểu đồ
            while (rs.next()) {
                int day = rs.getInt("day");
                for (int i = 0; i < days.length; i++) {
                    if (day == days[i]) {
                        dailyOrders.set(i, rs.getInt("total"));
                        break;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dailyOrders;
    }
    // Lấy 5 đơn hàng gần đây
    public List<Order> getRecentOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT Order_ID, Customer_ID, Order_Date, Total_Amount, Order_Notes, Payment_Method, Status " +
                "FROM Orders " +
                "ORDER BY Order_Date DESC LIMIT 5";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("Order_ID"));
                order.setCustomerId(rs.getInt("Customer_ID"));
                order.setOrderDate(rs.getTimestamp("Order_Date"));
                order.setTotalAmount(rs.getDouble("Total_Amount"));
                order.setOrderNotes(rs.getString("Order_Notes"));
                order.setPaymentMethod(rs.getString("Payment_Method"));
                order.setStatus(rs.getString("Status"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    // Lấy tất cả đơn hàng
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT Order_ID, Customer_ID, Order_Date, Total_Amount, Order_Notes, Payment_Method, Status " +
                "FROM Orders";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("Order_ID"));
                order.setCustomerId(rs.getInt("Customer_ID"));
                order.setOrderDate(rs.getTimestamp("Order_Date"));
                order.setTotalAmount(rs.getDouble("Total_Amount"));
                order.setOrderNotes(rs.getString("Order_Notes"));
                order.setPaymentMethod(rs.getString("Payment_Method"));
                order.setStatus(rs.getString("Status"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    // Lấy chi tiết đơn hàng theo ID
    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT Order_ID, Customer_ID, Order_Date, Total_Amount, Order_Notes, Payment_Method, Status, " +
                "shipping_first_name, shipping_last_name, shipping_address, city, country_state, postcode, phone, email " +
                "FROM Orders WHERE Order_ID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setOrderId(rs.getInt("Order_ID"));
                    order.setCustomerId(rs.getInt("Customer_ID"));
                    order.setOrderDate(rs.getTimestamp("Order_Date"));
                    order.setTotalAmount(rs.getDouble("Total_Amount"));
                    order.setOrderNotes(rs.getString("Order_Notes"));
                    order.setPaymentMethod(rs.getString("Payment_Method"));
                    order.setStatus(rs.getString("Status"));
                    order.setShippingFirstName(rs.getString("shipping_first_name"));
                    order.setShippingLastName(rs.getString("shipping_last_name"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setCity(rs.getString("city"));
                    order.setCountryState(rs.getString("country_state"));
                    order.setPostcode(rs.getString("postcode"));
                    order.setPhone(rs.getString("phone"));
                    order.setEmail(rs.getString("email"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (order != null) {
            // Lấy chi tiết đơn hàng
            List<OrderDetail> orderDetails = new ArrayList<>();
            String detailSql = "SELECT od.Order_Detail_ID, od.Order_ID, od.Product_ID, od.Quantity, od.Unit_Price, p.Name AS Product_Name " +
                    "FROM Order_Details od JOIN Product p ON od.Product_ID = p.Product_ID WHERE od.Order_ID = ?";
            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(detailSql)) {
                stmt.setInt(1, orderId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        OrderDetail detail = new OrderDetail();
                        detail.setOrderDetailId(rs.getInt("Order_Detail_ID"));
                        detail.setOrderId(rs.getInt("Order_ID"));
                        detail.setProductId(rs.getInt("Product_ID"));
                        detail.setQuantity(rs.getInt("Quantity"));
                        detail.setUnitPrice(rs.getDouble("Unit_Price"));
                        detail.setProductName(rs.getString("Product_Name"));
                        orderDetails.add(detail);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            order.setOrderDetails(orderDetails);
        }

        return order;
    }
}