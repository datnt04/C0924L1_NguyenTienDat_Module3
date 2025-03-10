<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Danh sách sản phẩm</title>
</head>
<body>
<h1>Danh sách sản phẩm</h1>
<a href="product?action=add">Thêm sản phẩm mới</a>
<form action="product" method="get">
  <input type="text" name="searchName" placeholder="Tìm kiếm sản phẩm">
  <button type="submit" name="action" value="search">Tìm kiếm</button>
</form>
<table border="1">
  <tr>
    <th>ID</th>
    <th>Tên</th>
    <th>Giá</th>
    <th>Mô tả</th>
    <th>Nhà sản xuất</th>
    <th>Thao tác</th>
  </tr>
  <c:forEach var="product" items="${products}">
    <tr>
      <td>${product.id}</td>
      <td>${product.name}</td>
      <td>${product.price}</td>
      <td>${product.description}</td>
      <td>${product.manufacturer}</td>
      <td>
        <a href="product?action=details&id=${product.id}">Xem chi tiết</a>
        <a href="product?action=edit&id=${product.id}">Sửa</a>
        <a href="product?action=delete&id=${product.id}">Xóa</a>
      </td>
    </tr>
  </c:forEach>
</table>
</body>
</html>
