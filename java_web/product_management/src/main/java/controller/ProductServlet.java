package controller;

import model.Product;
import service.ProductService;
import service.ProductServiceImpl;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private ProductService productService;

    public void init() {
        productService = new ProductServiceImpl();
    }

    // Phương thức xử lý các yêu cầu GET
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Mặc định là hiển thị danh sách
        }

        switch (action) {
            case "list":
                listProducts(request, response);
                break;
            case "details":
                showProductDetails(request, response);
                break;
            case "search":
                searchProducts(request, response);
                break;
            case "add":
                showAddProductForm(request, response);
                break;
            case "edit":
                showEditProductForm(request, response);
                break;
            default:
                listProducts(request, response); // Nếu action không hợp lệ, hiển thị danh sách mặc định
                break;
        }
    }

    // Phương thức xử lý các yêu cầu POST
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    // Phương thức hiển thị danh sách sản phẩm
    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productService.getAllProducts();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/product-list.jsp");
        dispatcher.forward(request, response);
    }

    // Phương thức hiển thị chi tiết sản phẩm
    private void showProductDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productService.getProductById(productId);
        request.setAttribute("product", product);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/product-details.jsp");
        dispatcher.forward(request, response);
    }

    // Phương thức tìm kiếm sản phẩm
    private void searchProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("searchName");
        List<Product> foundProducts = productService.searchProductsByName(name);
        request.setAttribute("products", foundProducts);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/product-list.jsp");
        dispatcher.forward(request, response);
    }

    // Phương thức hiển thị form thêm sản phẩm
    private void showAddProductForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/product-form.jsp");
        dispatcher.forward(request, response);
    }

    // Phương thức hiển thị form sửa sản phẩm
    private void showEditProductForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productService.getProductById(productId);
        request.setAttribute("product", product);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/product-form.jsp");
        dispatcher.forward(request, response);
    }

    // Phương thức thêm sản phẩm
    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String manufacturer = request.getParameter("manufacturer");
        Product newProduct = new Product(0, name, price, description, manufacturer); // ID tự động
        productService.addProduct(newProduct);
        response.sendRedirect("product?action=list");
    }

    // Phương thức cập nhật sản phẩm
    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String manufacturer = request.getParameter("manufacturer");
        Product updatedProduct = new Product(id, name, price, description, manufacturer);
        productService.updateProduct(updatedProduct);
        response.sendRedirect("product?action=list");
    }

    // Phương thức xóa sản phẩm
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productService.deleteProduct(id);
        response.sendRedirect("product?action=list");
    }
}
