<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Chi tiết sản phẩm</title>
  <link rel="stylesheet" href="css/product-details.css" type="text/css" />
</head>
<body>
<div class="container">
  <h1>Chi tiết sản phẩm</h1>
  <div class="product-info">
    <p><strong>ID:</strong> ${product.id}</p>
    <p><strong>Tên sản phẩm:</strong> ${product.name}</p>
    <p><strong>Giá sản phẩm:</strong> ${product.price} VNĐ</p>
    <p><strong>Mô tả:</strong> ${product.description}</p>
    <p><strong>Nhà sản xuất:</strong> ${product.manufacturer}</p>
  </div>
  <a href="product?action=list" class="back-link">Quay lại danh sách</a>
  <a href="product?action=edit&id=${product.id}" class="button">Sửa sản phẩm</a>
</div>
</body>
</html>