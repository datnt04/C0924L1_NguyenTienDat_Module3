package controller;

import model.CartItem;
import service.CartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        boolean isAjax = "application/json".equals(request.getHeader("Accept"));

        if (userId == null) {
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
                response.getWriter().write("{\"error\": \"User not logged in\"}");
                return;
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
        }

        try {
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                int cartCount = cartService.getCartCount(userId);
                double totalAmount = cartService.getCartTotal(userId);

                String jsonResponse = String.format("{\"cartCount\": %d, \"cartTotal\": %.2f}", cartCount, totalAmount);
                response.getWriter().write(jsonResponse);
            } else {
                List<CartItem> cartItems = cartService.getCartItems(userId);
                request.setAttribute("cartItems", cartItems);

                double totalAmount = cartService.getCartTotal(userId);
                request.setAttribute("totalAmount", totalAmount);

                int cartCount = cartService.getCartCount(userId);
                session.setAttribute("cartCount", cartCount);
                session.setAttribute("cartTotal", totalAmount);

                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
                response.getWriter().write("{\"error\": \"Error retrieving cart: " + e.getMessage() + "\"}");
            } else {
                throw new ServletException("Error retrieving cart: " + e.getMessage());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if (userId == null) {
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
                response.getWriter().write("{\"error\": \"User not logged in\"}");
                return;
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                System.out.println("Adding to cart: userId=" + userId + ", productId=" + productId + ", quantity=" + quantity); // Debug
                cartService.addToCartWithQuantity(userId, productId, quantity);
            } else if ("update".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                System.out.println("Updating cart: userId=" + userId + ", productId=" + productId + ", quantity=" + quantity); // Debug
                cartService.updateQuantity(userId, productId, quantity);
            } else if ("remove".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                System.out.println("Removing from cart: userId=" + userId + ", productId=" + productId); // Debug
                cartService.removeFromCart(userId, productId);
            }

            int cartCount = cartService.getCartCount(userId);
            double cartTotal = cartService.getCartTotal(userId);
            System.out.println("Cart updated: cartCount=" + cartCount + ", cartTotal=" + cartTotal); // Debug
            session.setAttribute("cartCount", cartCount);
            session.setAttribute("cartTotal", cartTotal);

            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String jsonResponse = String.format("{\"cartCount\": %d, \"cartTotal\": %.2f}", cartCount, cartTotal);
                response.getWriter().write(jsonResponse);
            } else {
                response.sendRedirect(request.getContextPath() + "/cart");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQLException in doPost: " + e.getMessage()); // Debug
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
                response.getWriter().write("{\"error\": \"Error processing cart action: " + e.getMessage() + "\"}");
            } else {
                throw new ServletException("Error processing cart action: " + e.getMessage());
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.out.println("NumberFormatException in doPost: " + e.getMessage()); // Debug
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
                response.getWriter().write("{\"error\": \"Invalid productId or quantity: " + e.getMessage() + "\"}");
            } else {
                throw new ServletException("Invalid productId or quantity: " + e.getMessage());
            }
        }
    }
}