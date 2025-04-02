package controller;

import model.Book;
import model.BorrowCard;
import model.Student;
import service.BookService;
import service.BorrowCardService;
import service.StudentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet {
    private BookService bookService = new BookService();
    private StudentService studentService = new StudentService();
    private BorrowCardService borrowCardService = new BorrowCardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookId = req.getParameter("bookId");
        Book book = bookService.getBookById(bookId);
        if (book == null || book.getQuantity() == 0) {
            req.setAttribute("error", "Sách đã hết, không thể mượn!");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return;
        }
        List<Student> students = studentService.getAllStudents();
        req.setAttribute("book", book);
        req.setAttribute("students", students);
        req.getRequestDispatcher("/borrow.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String borrowId = req.getParameter("borrowId");
        String bookId = req.getParameter("bookId");
        String studentId = req.getParameter("studentId");
        String returnDateStr = req.getParameter("returnDate");

        // Kiểm tra định dạng borrowId
        if (!borrowId.matches("MS-\\d{4}")) {
            req.setAttribute("error", "Mã mượn sách phải theo định dạng MS-XXXX!");
            req.getRequestDispatcher("/borrow.jsp").forward(req, resp);
            return;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        BorrowCard card = new BorrowCard();
        card.setBorrowId(borrowId);
        card.setBookId(bookId);
        card.setStudentId(studentId);
        card.setStatus(true); // Đặt status là TRUE (đang mượn)
        card.setBorrowDate(new Date());

        System.out.println("Status before adding: " + card.isStatus()); // Debug

        try {
            card.setReturnDate(sdf.parse(returnDateStr));
            if (card.getReturnDate().before(card.getBorrowDate())) {
                req.setAttribute("error", "Ngày trả không được trước ngày mượn!");
                req.getRequestDispatcher("/borrow.jsp").forward(req, resp);
                return;
            }
        } catch (Exception e) {
            req.setAttribute("error", "Định dạng ngày không hợp lệ!");
            req.getRequestDispatcher("/borrow.jsp").forward(req, resp);
            return;
        }

        try {
            borrowCardService.addBorrowCard(card);
            Book book = bookService.getBookById(bookId);
            bookService.updateQuantity(bookId, book.getQuantity() - 1);
            resp.sendRedirect("/books");
        } catch (RuntimeException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/borrow.jsp").forward(req, resp);
        }
    }
}