package repository;

import model.BorrowCard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BorrowCardRepository {

    public void addBorrowCard(BorrowCard card) {
        String sql = "INSERT INTO borrow_cards (borrow_id, book_id, student_id, status, borrow_date, return_date) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, card.getBorrowId());
            stmt.setString(2, card.getBookId());
            stmt.setString(3, card.getStudentId());
            stmt.setInt(4, 1); // Buộc ghi status = 1 (TRUE)
            stmt.setDate(5, new java.sql.Date(card.getBorrowDate().getTime()));
            stmt.setDate(6, card.getReturnDate() != null ? new java.sql.Date(card.getReturnDate().getTime()) : null);
            int rows = stmt.executeUpdate();
            System.out.println("Inserted " + rows + " rows into borrow_cards with status = 1");
        } catch (SQLException e) {
            System.err.println("Error adding borrow card: " + e.getMessage());
            throw new RuntimeException("Failed to add borrow card: " + e.getMessage(), e);
        }
    }

    public List<BorrowCard> getBorrowedBooks() {
        List<BorrowCard> cards = new ArrayList<>();
        String sql = "SELECT * FROM borrow_cards WHERE status = 1"; // Sử dụng 1 thay vì TRUE
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                BorrowCard card = new BorrowCard(
                        rs.getString("borrow_id"),
                        rs.getString("book_id"),
                        rs.getString("student_id"),
                        rs.getBoolean("status"),
                        rs.getDate("borrow_date"),
                        rs.getDate("return_date")
                );
                cards.add(card);
                System.out.println("Fetched borrow card: " + card.getBorrowId() + ", Status: " + card.isStatus());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cards;
    }

    public void returnBook(String borrowId) {
        String sql = "UPDATE borrow_cards SET status = FALSE WHERE borrow_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, borrowId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public List<BorrowCard> searchBorrowedBooks(String bookTitle, String studentName) {
        List<BorrowCard> cards = new ArrayList<>();
        String sql = "SELECT bc.* FROM borrow_cards bc " +
                "JOIN books b ON bc.book_id = b.book_id " +
                "JOIN students s ON bc.student_id = s.student_id " +
                "WHERE bc.status = TRUE AND b.title LIKE ? AND s.full_name LIKE ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + bookTitle + "%");
            stmt.setString(2, "%" + studentName + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                BorrowCard card = new BorrowCard(
                        rs.getString("borrow_id"),
                        rs.getString("book_id"),
                        rs.getString("student_id"),
                        rs.getBoolean("status"),
                        rs.getDate("borrow_date"),
                        rs.getDate("return_date")
                );
                cards.add(card);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cards;
    }
}