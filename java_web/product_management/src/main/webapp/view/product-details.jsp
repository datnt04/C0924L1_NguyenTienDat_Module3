<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Chi tiết sản phẩm</title>
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
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .container {
      background-color: #fff;
      padding: 40px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 600px;
    }

    h1 {
      color: #333;
      text-align: center;
      margin-bottom: 30px;
      font-size: 2.5rem;
      font-weight: 600;
    }

    .product-info {
      margin-bottom: 20px;
    }

    .product-info p {
      font-size: 16px;
      margin: 12px 0;
    }

    .product-info strong {
      font-weight: bold;
      color: #444;
    }

    .back-link {
      display: block;
      text-align: center;
      color: #007bff;
      text-decoration: none;
      font-size: 16px;
      margin-top: 20px;
    }

    .back-link:hover {
      text-decoration: underline;
    }

    .button {
      display: block;
      padding: 12px 25px;
      background-color: #ff7f32;
      color: white;
      text-align: center;
      text-decoration: none;
      border-radius: 5px;
      margin-top: 20px;
      font-size: 16px;
      width: 100%;
    }

    .button:hover {
      background-color: #ff5f00;
    }
  </style>
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
