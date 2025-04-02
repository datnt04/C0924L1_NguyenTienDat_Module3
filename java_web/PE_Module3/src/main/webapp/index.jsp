<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách sách</title>
    <link rel="stylesheet" href="../index.css">
</head>
<body>
<h1>DANH SÁCH SÁCH</h1>

<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<table border="1">
    <thead>
    <tr>
        <th>Mã sách</th>
        <th>Tên sách</th>
        <th>Tác giả</th>
        <th>Mô tả</th>
        <th>Số lượng</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="book" items="${books}">
        <tr>
            <td>${book.bookId}</td>
            <td>${book.title}</td>
            <td>${book.author}</td>
            <td>${book.description}</td>
            <td>${book.quantity}</td>
            <td>
                <c:choose>
                    <c:when test="${book.quantity > 0}">
                        <a href="/borrow?bookId=${book.bookId}">MƯỢN</a>
                    </c:when>
                    <c:otherwise>
                        <span style="color: red;">Hết sách</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<br>
<a href="/borrowed">Thống kê sách đang cho mượn</a>
</body>
</html>