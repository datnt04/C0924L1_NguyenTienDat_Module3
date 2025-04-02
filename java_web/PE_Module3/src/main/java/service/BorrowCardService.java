package service;

import model.BorrowCard;
import repository.BorrowCardRepository;

import java.util.List;

public class BorrowCardService {
    private BorrowCardRepository borrowCardRepository = new BorrowCardRepository();

    public void addBorrowCard(BorrowCard card) {
        borrowCardRepository.addBorrowCard(card);
    }

    public List<BorrowCard> getBorrowedBooks() {
        return borrowCardRepository.getBorrowedBooks();
    }

    public void returnBook(String borrowId) {
        borrowCardRepository.returnBook(borrowId);
    }
    public List<BorrowCard> searchBorrowedBooks(String bookTitle, String studentName) {
        return borrowCardRepository.searchBorrowedBooks(bookTitle, studentName);
    }
}