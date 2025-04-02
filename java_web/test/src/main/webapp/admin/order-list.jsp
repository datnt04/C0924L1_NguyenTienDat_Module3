<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý đơn hàng - Bookshop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
  <h2>Quản lý đơn hàng</h2>
  <table class="table table-bordered">
    <thead>
    <tr>
      <th>Mã đơn</th>
      <th>Khách hàng</th>
      <th>Ngày đặt</th>
      <th>Tổng tiền</th>
      <th>Trạng thái</th>
      <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="order" items="${orderList}">
      <tr>
        <td>#${order.orderId}</td>
        <td>${order.customerName}</td>
        <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></td>
        <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="đ"/></td>
        <td>${order.status}</td>
        <td>
          <a href="order-details.jsp?orderId=${order.orderId}" class="btn btn-sm btn-info">Xem chi tiết</a>
          <a href="update-order-status?orderId=${order.orderId}" class="btn btn-sm btn-primary">Cập nhật trạng thái</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>