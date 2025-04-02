package controller;

import model.CartItem;
import model.Order;
import service.CartService;
import service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private OrderService orderService;
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<CartItem> cartItems = cartService.getCartItems(userId);
            double cartTotal = cartService.getCartTotal(userId);

            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Lỗi khi lấy thông tin giỏ hàng: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<CartItem> cartItems = cartService.getCartItems(userId);
            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            // Lấy thông tin từ form
            String shippingFirstName = request.getParameter("shippingFirstName");
            String shippingLastName = request.getParameter("shippingLastName");
            String shippingAddress = request.getParameter("shippingAddress");
            String city = request.getParameter("city");
            String countryState = request.getParameter("countryState");
            String postcode = request.getParameter("postcode");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String orderNotes = request.getParameter("orderNotes");
            String paymentMethod = request.getParameter("paymentMethod");

            double cartTotal = cartService.getCartTotal(userId);

            Order order = new Order();
            order.setCustomerId(userId);
            order.setTotalAmount(cartTotal);
            order.setShippingFirstName(shippingFirstName);
            order.setShippingLastName(shippingLastName);
            order.setShippingAddress(shippingAddress);
            order.setCity(city);
            order.setCountryState(countryState);
            order.setPostcode(postcode);
            order.setPhone(phone);
            order.setEmail(email);
            order.setOrderNotes(orderNotes);
            order.setPaymentMethod(paymentMethod);
            order.setOrderDate(new Date());
            order.setStatus("Pending");

            orderService.createOrder(order, cartItems);

            response.sendRedirect(request.getContextPath() + "/order-confirmation?orderId=" + order.getOrderId());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tạo đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        }
    }
}