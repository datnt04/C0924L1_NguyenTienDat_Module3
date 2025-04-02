package controller.admin;

import model.Order;
import model.User;
import service.OrderService;
import service.ProductService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private OrderService orderService;
    private ProductService productService;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
        productService = new ProductService();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra phân quyền
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Tính tổng doanh thu
            double totalRevenue = orderService.calculateTotalRevenue();
            request.setAttribute("totalRevenue", totalRevenue);

            // Tính tổng số đơn hàng
            int totalOrders = orderService.getTotalOrders();
            request.setAttribute("totalOrders", totalOrders);

            // Tính tổng số khách hàng
            int totalCustomers = userService.getTotalCustomers();
            request.setAttribute("totalCustomers", totalCustomers);

            // Tính tổng số sản phẩm
            int totalProducts = productService.getTotalProducts();
            request.setAttribute("totalProducts", totalProducts);

            // Lấy dữ liệu cho biểu đồ doanh thu
            List<Double> revenueData = orderService.getWeeklyRevenue();
            String revenueDataString = String.join(",", revenueData.stream().map(String::valueOf).toList());
            request.setAttribute("revenueData", revenueDataString);

            // Lấy dữ liệu cho biểu đồ đơn hàng
            List<Integer> orderData = orderService.getDailyOrders();
            String orderDataString = String.join(",", orderData.stream().map(String::valueOf).toList());
            request.setAttribute("orderData", orderDataString);

            // Lấy danh sách đơn hàng gần đây
            List<Order> recentOrders = orderService.getRecentOrders();
            request.setAttribute("recentOrders", recentOrders);

            // Lưu UserService vào request để JSP có thể gọi getUserNameById
            request.setAttribute("userService", userService);

            // Debug: In dữ liệu ra console để kiểm tra
            System.out.println("Total Revenue: " + totalRevenue);
            System.out.println("Total Orders: " + totalOrders);
            System.out.println("Total Customers: " + totalCustomers);
            System.out.println("Total Products: " + totalProducts);
            System.out.println("Revenue Data: " + revenueDataString);
            System.out.println("Order Data: " + orderDataString);
            System.out.println("Recent Orders Size: " + (recentOrders != null ? recentOrders.size() : "null"));

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi tải dữ liệu: " + e.getMessage());
        }

        request.getRequestDispatcher("/admin/dashboard.jsp")
                .forward(request, response);
    }
}