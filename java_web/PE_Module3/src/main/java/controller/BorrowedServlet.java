package controller;

import model.Book;
import model.BorrowCard;
import service.BookService;
import service.BorrowCardService;
import service.StudentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/borrowed")
public class BorrowedServlet extends HttpServlet {
    private BorrowCardService borrowCardService = new BorrowCardService();
    private BookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookTitle = req.getParameter("bookTitle");
        String studentName = req.getParameter("studentName");
        List<BorrowCard> borrowedBooks;
        if (bookTitle != null || studentName != null) {
            borrowedBooks = borrowCardService.searchBorrowedBooks(bookTitle != null ? bookTitle : "",
                    studentName != null ? studentName : "");
        } else {
            borrowedBooks = borrowCardService.getBorrowedBooks();
        }
        req.setAttribute("borrowedBooks", borrowedBooks);
        req.setAttribute("books", bookService.getAllBooks()); // Để hiển thị tên sách, tác giả
        req.setAttribute("students", new StudentService().getAllStudents()); // Để hiển thị tên học sinh, lớp
        req.getRequestDispatcher("/borrowed.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String borrowId = req.getParameter("borrowId");
        String bookId = req.getParameter("bookId");

        borrowCardService.returnBook(borrowId);
        Book book = bookService.getBookById(bookId);
        bookService.updateQuantity(bookId, book.getQuantity() + 1);
        resp.sendRedirect("/borrowed");
    }
}