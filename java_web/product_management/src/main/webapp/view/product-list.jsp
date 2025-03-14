<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Danh sách sản phẩm</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f7f9fc;
      color: #333;
    }
    h1 {
      color: #333;
      text-align: center;
      padding: 40px 0;
      font-size: 2.5rem;
      font-weight: 600;
    }
    .search-form {
      max-width: 600px;
      margin: 0 auto 30px auto;
      text-align: center;
    }
    .search-form input[type="text"] {
      padding: 12px;
      width: 70%;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 16px;
    }
    .search-form button {
      padding: 12px 25px;
      background-color: #ff7f32;
      color: white;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    .search-form button:hover {
      background-color: #ff5f00;
    }
    table {
      width: 90%;
      margin: 30px auto;
      border-collapse: collapse;
      background-color: #fff;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
    }
    th, td {
      padding: 18px;
      text-align: left;
      font-size: 16px;
      border-bottom: 1px solid #ddd;
    }
    th {
      background-color: #ff7f32;
      color: white;
      font-weight: bold;
    }
    tr:hover {
      background-color: #f1f1f1;
    }
    a {
      text-decoration: none;
      padding: 10px 20px;
      border-radius: 5px;
      color: white;
      font-size: 14px;
      transition: background-color 0.3s ease;
    }
    a[href*="details"] {
      background-color: #ff7f32;
    }
    a[href*="details"]:hover {
      background-color: #ff5f00;
    }
    a[href*="edit"] {
      background-color: #ff7f32;
    }
    a[href*="edit"]:hover {
      background-color: #ff5f00;
    }
    a[href*="delete"] {
      background-color: #ff7f32;
    }
    a[href*="delete"]:hover {
      background-color: #ff5f00;
    }
    a[href*="add"] {
      display: inline-block;
      margin-bottom: 20px;
      background-color: #ff7f32;
      padding: 12px 20px;
    }
    a[href*="add"]:hover {
      background-color: #ff5f00;
    }
  </style>
</head>
<body>
<h1>Danh sách sản phẩm</h1>
<a href="product?action=add">Thêm sản phẩm mới</a>
<form class="search-form" action="product" method="get">
  <input type="text" name="searchName" placeholder="Tìm kiếm sản phẩm">
  <button type="submit" name="action" value="search">Tìm kiếm</button>
</form>
<table>
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
        <a href="product?action=delete&id=${product.id}"
           onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
      </td>
    </tr>
  </c:forEach>
</table>
</body>
</html>