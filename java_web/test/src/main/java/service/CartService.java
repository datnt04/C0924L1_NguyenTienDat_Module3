package service;

import model.CartItem;
import repository.CartRepository;

import java.sql.SQLException;
import java.util.List;

public class CartService {
    private final CartRepository cartRepository = new CartRepository();

    public List<CartItem> getCartItems(int userId) throws SQLException {
        return cartRepository.getCartItems(userId);
    }


    public int getCartCount(int userId) throws SQLException {
        List<CartItem> cartItems = cartRepository.getCartItems(userId);
        return cartItems.size();
    }


    public double getCartTotal(int userId) throws SQLException {
        List<CartItem> cartItems = cartRepository.getCartItems(userId);
        double total = 0.0;
        for (CartItem item : cartItems) {
            total += item.getTotalPrice();
        }
        return total;
    }


    public void addToCart(int userId, int productId) throws SQLException {
        cartRepository.addToCart(userId, productId);
    }


    public void addToCartWithQuantity(int userId, int productId, int quantity) throws SQLException {
        cartRepository.addToCartWithQuantity(userId, productId, quantity);
    }


    public void updateQuantity(int userId, int productId, int quantity) throws SQLException {
        cartRepository.updateCart(userId, productId, quantity);
    }


    public void removeFromCart(int userId, int productId) throws SQLException {
        cartRepository.removeFromCart(userId, productId);
    }


    public void clearCart(int userId) throws SQLException {
        cartRepository.clearCart(userId);
    }
}