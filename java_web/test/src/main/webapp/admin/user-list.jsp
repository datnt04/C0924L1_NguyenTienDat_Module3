<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý người dùng - Bookshop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="https://cdn.misdeliver.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
  <h2>Quản lý người dùng</h2>
  <table class="table table-bordered">
    <thead>
    <tr>
      <th>ID</th>
      <th>Tên</th>
      <th>Email</th>
      <th>Địa chỉ</th>
      <th>Vai trò</th>
      <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${userList}">
      <tr>
        <td>${user.id}</td>
        <td>${user.name}</td>
        <td>${user.email}</td>
        <td>${user.address}</td>
        <td>${user.role}</td>
        <td>
          <a href="edit-user.jsp?userId=${user.id}" class="btn btn-sm btn-warning">Sửa</a>
          <a href="delete-user?userId=${user.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa người dùng này?')">Xóa</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>