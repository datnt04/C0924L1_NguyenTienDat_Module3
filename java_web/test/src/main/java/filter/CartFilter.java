package filter;

import service.CartService;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebFilter("/*") // Áp dụng cho tất cả các trang
public class CartFilter implements Filter {
    private CartService cartService;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        cartService = new CartService();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId != null) {
            try {
                int cartCount = cartService.getCartCount(userId);
                double cartTotal = cartService.getCartTotal(userId);
                session.setAttribute("cartCount", cartCount);
                session.setAttribute("cartTotal", cartTotal);
            } catch (SQLException e) {
                e.printStackTrace();
                throw new ServletException("Error updating cart in filter: " + e.getMessage());
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}