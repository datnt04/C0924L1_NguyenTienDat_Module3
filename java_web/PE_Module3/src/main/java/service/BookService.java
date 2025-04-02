package service;

import model.Book;
import repository.BookRepository;

import java.util.List;

public class BookService {
    private BookRepository bookRepository = new BookRepository();

    public List<Book> getAllBooks() {
        return bookRepository.getAllBooks();
    }

    public Book getBookById(String bookId) {
        return bookRepository.getBookById(bookId);
    }

    public void updateQuantity(String bookId, int quantity) {
        bookRepository.updateQuantity(bookId, quantity);
    }
}