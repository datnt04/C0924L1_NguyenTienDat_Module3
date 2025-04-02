package controller;

import model.Product;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("🌀 [ProductServlet] doGet called");

        String searchQuery = request.getParameter("search");
        String category = request.getParameter("category");
        List<Product> bookList;

        if ((searchQuery != null && !searchQuery.trim().isEmpty()) || (category != null && !category.trim().isEmpty())) {
            searchQuery = (searchQuery == null || searchQuery.trim().isEmpty()) ? "" : searchQuery;
            bookList = productService.searchProducts(searchQuery, category);
        } else {
            bookList = productService.getAllBooks();
        }

        if (bookList == null) {
            System.out.println("[ProductServlet] bookList is null");
        } else {
            System.out.println("[ProductServlet] bookList size: " + bookList.size());
        }

        request.setAttribute("bookList", bookList);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}