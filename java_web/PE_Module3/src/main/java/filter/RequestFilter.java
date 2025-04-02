package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = "/*")
public class RequestFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("RequestFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String requestURI = req.getRequestURI();
        System.out.println("Request URI: " + requestURI);


        if (requestURI.contains("/books") || requestURI.contains("/borrowed") || requestURI.contains("/borrow")) {
            System.out.println("Forwarding to Servlet: " + requestURI);
            chain.doFilter(request, response);
        } else {
            System.out.println("Invalid request: " + requestURI);
            resp.sendRedirect("/books");
        }
    }

    @Override
    public void destroy() {
        System.out.println("RequestFilter destroyed");
    }
}