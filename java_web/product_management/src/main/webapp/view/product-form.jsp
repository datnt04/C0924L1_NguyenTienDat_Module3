<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Thêm/Sửa sản phẩm</title>
</head>
<body>
<h1>${product != null ? 'Sửa sản phẩm' : 'Thêm sản phẩm mới'}</h1>
<form action="product" method="post">
  <%--@declare id="name"--%><%--@declare id="price"--%><%--@declare id="description"--%><%--@declare id="manufacturer"--%><input type="hidden" name="id" value="${product.id}" />
  <label for="name">Tên sản phẩm:</label>
  <input type="text" name="name" value="${product != null ? product.name : ''}" required /><br><br>
  <label for="price">Giá sản phẩm:</label>
  <input type="number" name="price" value="${product != null ? product.price : ''}" required /><br><br>
  <label for="description">Mô tả:</label>
  <input type="text" name="description" value="${product != null ? product.description : ''}" required /><br><br>
  <label for="manufacturer">Nhà sản xuất:</label>
  <input type="text" name="manufacturer" value="${product != null ? product.manufacturer : ''}" required /><br><br>
  <button type="submit" name="action" value="${product != null ? 'update' : 'add'}">${product != null ? 'Cập nhật' : 'Thêm'}</button>
</form>
<a href="product?action=list">Quay lại danh sách</a>
</body>
</html>

