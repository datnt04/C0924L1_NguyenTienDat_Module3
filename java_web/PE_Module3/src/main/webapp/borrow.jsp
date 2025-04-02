<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Mượn sách</title>
  <link rel="stylesheet" href="../borrow.css">
  <script>
    function confirmCancel() {
      return confirm("Bạn có chắc chắn muốn trở về danh sách không?");
    }
  </script>
</head>
<body>
<h1>MƯỢN SÁCH</h1>

<c:if test="${not empty error}">
  <p style="color: red;">${error}</p>
</c:if>

<form action="/borrow" method="post">
  <input type="hidden" name="bookId" value="${book.bookId}">

  <label for="borrowId">Mã mượn sách:</label>
  <input type="text" id="borrowId" name="borrowId" value="MS-" required
         pattern="MS-\d{4}" title="Mã mượn sách phải theo định dạng MS-XXXX (X là số)"><br><br>

  <label for="title">Tên sách:</label>
  <input type="text" id="title" name="title" value="${book.title}" readonly><br><br>

  <label for="studentId">Tên học sinh:</label>
  <select id="studentId" name="studentId" required>
    <option value="">-- Chọn học sinh --</option>
    <c:forEach var="student" items="${students}">
      <option value="${student.studentId}">${student.fullName}</option>
    </c:forEach>
  </select><br><br>

  <label for="borrowDate">Ngày mượn sách:</label>
  <input type="text" id="borrowDate" name="borrowDate"
         value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %>" readonly><br><br>

  <label for="returnDate">Ngày trả sách:</label>
  <input type="text" id="returnDate" name="returnDate" required
         placeholder="dd/MM/yyyy" pattern="\d{2}/\d{2}/\d{4}"
         title="Ngày trả phải theo định dạng dd/MM/yyyy"><br><br>

  <button type="submit">Mượn sách</button>
  <a href="/books" onclick="return confirmCancel();"><button type="button">Trở về danh sách</button></a>
</form>
</body>
</html>