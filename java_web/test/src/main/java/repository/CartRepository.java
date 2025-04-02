package repository;

import model.CartItem;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartRepository {

    public void addToCart(int customerId, int productId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection()) {
            // First check if product exists and has stock
            String checkProductQuery = "SELECT Stock FROM Product WHERE Product_ID = ?";
            PreparedStatement checkProductStmt = conn.prepareStatement(checkProductQuery);
            checkProductStmt.setInt(1, productId);
            ResultSet productRs = checkProductStmt.executeQuery();

            if (!productRs.next()) {
                throw new SQLException("Product not found with ID: " + productId);
            }

            int stock = productRs.getInt("Stock");
            if (stock <= 0) {
                throw new SQLException("Product is out of stock: " + productId);
            }

            // Check if item already exists in cart
            String checkCartQuery = "SELECT Quantity FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement checkCartStmt = conn.prepareStatement(checkCartQuery);
            checkCartStmt.setInt(1, customerId);
            checkCartStmt.setInt(2, productId);
            ResultSet cartRs = checkCartStmt.executeQuery();

            if (cartRs.next()) {
                // Update quantity if item exists
                int currentQuantity = cartRs.getInt("Quantity");
                if (currentQuantity >= stock) {
                    throw new SQLException("Not enough stock available for product: " + productId);
                }
                updateCart(customerId, productId, currentQuantity + 1);
            } else {
                // Insert new item if it doesn't exist
                String insertCartQuery = "INSERT INTO Shopping_Cart (Customer_ID, Product_ID, Quantity, Created_Date) VALUES (?, ?, 1, CURRENT_DATE)";
                PreparedStatement insertStmt = conn.prepareStatement(insertCartQuery);
                insertStmt.setInt(1, customerId);
                insertStmt.setInt(2, productId);
                insertStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error adding item to cart: " + e.getMessage());
        }
    }

    public void removeFromCart(int customerId, int productId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String deleteCartQuery = "DELETE FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteCartQuery);
            deleteStmt.setInt(1, customerId);
            deleteStmt.setInt(2, productId);
            deleteStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error removing item from cart: " + e.getMessage());
        }
    }

    public void updateCart(int customerId, int productId, int quantity) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection()) {
            // First check if the item exists in cart
            String checkCartQuery = "SELECT Quantity FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement checkCartStmt = conn.prepareStatement(checkCartQuery);
            checkCartStmt.setInt(1, customerId);
            checkCartStmt.setInt(2, productId);
            ResultSet cartRs = checkCartStmt.executeQuery();

            if (!cartRs.next()) {
                throw new SQLException("Item not found in cart for customerId: " + customerId + ", productId: " + productId);
            }

            // Check stock availability
            String checkStockQuery = "SELECT Stock FROM Product WHERE Product_ID = ?";
            PreparedStatement checkStockStmt = conn.prepareStatement(checkStockQuery);
            checkStockStmt.setInt(1, productId);
            ResultSet stockRs = checkStockStmt.executeQuery();

            if (!stockRs.next()) {
                throw new SQLException("Product not found with ID: " + productId);
            }

            int stock = stockRs.getInt("Stock");
            if (quantity > stock) {
                throw new SQLException("Not enough stock available for product: " + productId + ", stock: " + stock + ", requested: " + quantity);
            }

            if (quantity <= 0) {
                removeFromCart(customerId, productId);
            } else {
                String updateCartQuery = "UPDATE Shopping_Cart SET Quantity = ?, Updated_Date = CURRENT_DATE WHERE Customer_ID = ? AND Product_ID = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateCartQuery);
                updateStmt.setInt(1, quantity);
                updateStmt.setInt(2, customerId);
                updateStmt.setInt(3, productId);
                updateStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error updating cart: " + e.getMessage());
        }
    }

    public List<CartItem> getCartItems(int customerId) throws SQLException {
        List<CartItem> cartItems = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("Getting cart items for customerId: " + customerId); // Debug
            String query = "SELECT p.Product_ID, p.Name, p.Price, p.Stock, p.Product_Description, p.Product_img, p.Author, " +
                    "pc.Name AS Category_Name, s.Name AS Supplier_Name, c.Quantity, c.Cart_ID " +
                    "FROM Shopping_Cart c " +
                    "JOIN Product p ON c.Product_ID = p.Product_ID " +
                    "JOIN Product_Category pc ON p.Product_Category_ID = pc.Category_ID " + // Sửa từ pc.Product_Category_ID thành pc.Category_ID
                    "JOIN Supplier s ON p.Supplier_ID = s.ID " +
                    "WHERE c.Customer_ID = ? " +
                    "ORDER BY c.Created_Date DESC";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Name"),
                        rs.getDouble("Price"),
                        rs.getInt("Stock"),
                        rs.getString("Product_Description"),
                        rs.getString("Category_Name"),
                        rs.getString("Supplier_Name"),
                        rs.getString("Product_img"),
                        rs.getString("Author")
                );
                int quantity = rs.getInt("Quantity");
                int cartId = rs.getInt("Cart_ID");
                CartItem cartItem = new CartItem(cartId, product, quantity);
                cartItems.add(cartItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error getting cart items: " + e.getMessage());
        }
        return cartItems;
    }

    public void addToCartWithQuantity(int customerId, int productId, int quantity) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("Adding to cart: customerId=" + customerId + ", productId=" + productId + ", quantity=" + quantity); // Debug
            // First check if product exists and has stock
            String checkProductQuery = "SELECT Stock FROM Product WHERE Product_ID = ?";
            PreparedStatement checkProductStmt = conn.prepareStatement(checkProductQuery);
            checkProductStmt.setInt(1, productId);
            ResultSet productRs = checkProductStmt.executeQuery();

            if (!productRs.next()) {
                throw new SQLException("Product not found with ID: " + productId);
            }

            int stock = productRs.getInt("Stock");
            if (stock <= 0) {
                throw new SQLException("Product is out of stock: " + productId);
            }

            if (quantity > stock) {
                throw new SQLException("Not enough stock available for product: " + productId + ", stock: " + stock + ", requested: " + quantity);
            }

            // Check if item already exists in cart
            String checkCartQuery = "SELECT Quantity FROM Shopping_Cart WHERE Customer_ID = ? AND Product_ID = ?";
            PreparedStatement checkCartStmt = conn.prepareStatement(checkCartQuery);
            checkCartStmt.setInt(1, customerId);
            checkCartStmt.setInt(2, productId);
            ResultSet cartRs = checkCartStmt.executeQuery();

            if (cartRs.next()) {
                // Update quantity if item exists
                int currentQuantity = cartRs.getInt("Quantity");
                int newQuantity = currentQuantity + quantity;
                if (newQuantity > stock) {
                    throw new SQLException("Not enough stock available for product: " + productId + ", stock: " + stock + ", requested: " + newQuantity);
                }
                updateCart(customerId, productId, newQuantity);
            } else {
                // Insert new item if it doesn't exist
                String insertCartQuery = "INSERT INTO Shopping_Cart (Customer_ID, Product_ID, Quantity, Created_Date) VALUES (?, ?, ?, CURRENT_DATE)";
                PreparedStatement insertStmt = conn.prepareStatement(insertCartQuery);
                insertStmt.setInt(1, customerId);
                insertStmt.setInt(2, productId);
                insertStmt.setInt(3, quantity);
                insertStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error adding item to cart: " + e.getMessage());
        }
    }

    public void clearCart(int customerId) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String deleteQuery = "DELETE FROM Shopping_Cart WHERE Customer_ID = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
            deleteStmt.setInt(1, customerId);
            deleteStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error clearing cart: " + e.getMessage());
        }
    }
}