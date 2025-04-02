<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <title>Thống kê sách đang cho mượn</title>
  <link rel="stylesheet" href="../borrowed.css">
  <script>
    function confirmReturn() {
      return confirm("Bạn có chắc chắn muốn trả sách này không?");
    }
  </script>
</head>
<body>
<h1>THỐNG KẾ SÁCH ĐANG CHO MƯỢN</h1>

<form action="/borrowed" method="get">
  <label for="bookTitle">Tên sách:</label>
  <input type="text" id="bookTitle" name="bookTitle" value="${param.bookTitle}">

  <label for="studentName">Tên học sinh:</label>
  <input type="text" id="studentName" name="studentName" value="${param.studentName}">

  <button type="submit">Tìm kiếm</button>
</form>

<br>

<table border="1">
  <thead>
  <tr>
    <th>Mã mượn sách</th>
    <th>Tên sách</th>
    <th>Tác giả</th>
    <th>Tên học sinh</th>
    <th>Lớp</th>
    <th>Ngày mượn</th>
    <th>Ngày trả</th>
    <th>Hành động</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="card" items="${borrowedBooks}">
    <tr>
      <td>${card.borrowId}</td>
      <td>
        <c:forEach var="book" items="${books}">
          <c:if test="${book.bookId == card.bookId}">${book.title}</c:if>
        </c:forEach>
      </td>
      <td>
        <c:forEach var="book" items="${books}">
          <c:if test="${book.bookId == card.bookId}">${book.author}</c:if>
        </c:forEach>
      </td>
      <td>
        <c:forEach var="student" items="${students}">
          <c:if test="${student.studentId == card.studentId}">${student.fullName}</c:if>
        </c:forEach>
      </td>
      <td>
        <c:forEach var="student" items="${students}">
          <c:if test="${student.studentId == card.studentId}">${student.className}</c:if>
        </c:forEach>
      </td>
      <td><fmt:formatDate value="${card.borrowDate}" pattern="dd/MM/yyyy"/></td>
      <td><fmt:formatDate value="${card.returnDate}" pattern="dd/MM/yyyy"/></td>
      <td>
        <form action="/borrowed" method="post" style="display:inline;" onsubmit="return confirmReturn();">
          <input type="hidden" name="borrowId" value="${card.borrowId}">
          <input type="hidden" name="bookId" value="${card.bookId}">
          <button type="submit">Trả sách</button>
        </form>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

<br>
<a href="/books">Quay lại danh sách sách</a>
</body>
</html>