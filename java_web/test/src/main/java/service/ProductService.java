package service;

import model.Product;
import repository.ProductRepository;
import java.util.List;

public class ProductService {
    private final ProductRepository productRepository = new ProductRepository();

    public List<Product> getAllBooks() {
        return productRepository.findAllBooks();
    }
    public int getTotalProducts() {
        return productRepository.getTotalProducts();
    }
    public Product getProductById(int id) {
        return productRepository.findById(id);
    }
    public List<Product> searchProducts(String query, String category) {
        return productRepository.searchProducts(query, category);
    }
    public List<Product> getAllProducts() {
        return productRepository.getAllProducts();
    }


}
