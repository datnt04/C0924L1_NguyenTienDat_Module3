<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Thêm/Sửa sản phẩm</title>
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
      max-width: 500px;
    }

    h1 {
      color: #333;
      text-align: center;
      margin-bottom: 30px;
      font-size: 2.5rem;
      font-weight: 600;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-size: 16px;
      color: #444;
    }

    input[type="text"], input[type="number"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 18px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 16px;
      color: #333;
      background-color: #f9f9f9;
    }

    input[type="text"]:focus, input[type="number"]:focus {
      border-color: #ff7f32;
      outline: none;
    }

    button {
      padding: 12px 25px;
      background-color: #ff7f32;
      color: white;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      width: 100%;
    }

    button:hover {
      background-color: #ff5f00;
    }

    a {
      display: block;
      margin-top: 20px;
      text-align: center;
      color: #007bff;
      text-decoration: none;
      font-size: 16px;
    }

    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="container">
  <h1>${product != null ? 'Sửa sản phẩm' : 'Thêm sản phẩm mới'}</h1>
  <form action="product" method="post">
    <%--@declare id="name"--%>
    <%--@declare id="price"--%>
    <%--@declare id="description"--%>
    <%--@declare id="manufacturer"--%>
    <input type="hidden" name="id" value="${product.id}" />

    <label for="name">Tên sản phẩm:</label>
    <input type="text" name="name" value="${product != null ? product.name : ''}" required />

    <label for="price">Giá sản phẩm:</label>
    <input type="number" name="price" value="${product != null ? product.price : ''}" required />

    <label for="description">Mô tả:</label>
    <input type="text" name="description" value="${product != null ? product.description : ''}" required />

    <label for="manufacturer">Nhà sản xuất:</label>
    <input type="text" name="manufacturer" value="${product != null ? product.manufacturer : ''}" required />

    <button type="submit" name="action" value="${product != null ? 'update' : 'add'}">
      ${product != null ? 'Cập nhật' : 'Thêm'}
    </button>
  </form>

  <a href="product?action=list">Quay lại danh sách</a>
</div>

</body>
</html>
