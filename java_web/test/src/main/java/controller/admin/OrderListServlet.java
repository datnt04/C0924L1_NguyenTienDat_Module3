package controller.admin;

import model.Order;
import model.User;
import service.OrderService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/order-list")
public class OrderListServlet extends HttpServlet {
    private OrderService orderService;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
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

        List<Order> orderList = orderService.getAllOrders();
        request.setAttribute("orderList", orderList);
        request.setAttribute("userService", userService); // Truyền userService vào request
        request.getRequestDispatcher("/admin/order-list.jsp")
                .forward(request, response);
    }
}