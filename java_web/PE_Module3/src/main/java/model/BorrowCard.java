package model;

import java.util.Date;

public class BorrowCard {
    private String borrowId;
    private String bookId;
    private String studentId;
    private boolean status;
    private Date borrowDate;
    private Date returnDate;

    public BorrowCard() {}
    public BorrowCard(String borrowId, String bookId, String studentId, boolean status, Date borrowDate, Date returnDate) {
        this.borrowId = borrowId;
        this.bookId = bookId;
        this.studentId = studentId;
        this.status = status;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
    }

    public String getBorrowId() { return borrowId; }
    public void setBorrowId(String borrowId) { this.borrowId = borrowId; }
    public String getBookId() { return bookId; }
    public void setBookId(String bookId) { this.bookId = bookId; }
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
    public Date getBorrowDate() { return borrowDate; }
    public void setBorrowDate(Date borrowDate) { this.borrowDate = borrowDate; }
    public Date getReturnDate() { return returnDate; }
    public void setReturnDate(Date returnDate) { this.returnDate = returnDate; }
}