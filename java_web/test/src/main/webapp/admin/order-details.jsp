<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Chi tiết đơn hàng - Bookshop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
  <h2>Chi tiết đơn hàng #${order.orderId}</h2>

  <!-- Thông tin đơn hàng -->
  <div class="row">
    <div class="col-md-6">
      <h4>Thông tin khách hàng</h4>
      <p><strong>Tên khách hàng:</strong> ${userService.getUserNameById(order.customerId)}</p>
      <p><strong>Email:</strong> ${order.email}</p>
      <p><strong>Số điện thoại:</strong> ${order.phone}</p>
    </div>
    <div class="col-md-6">
      <h4>Thông tin giao hàng</h4>
      <p><strong>Họ tên:</strong> ${order.shippingFirstName} ${order.shippingLastName}</p>
      <p><strong>Địa chỉ:</strong> ${order.shippingAddress}, ${order.city}, ${order.countryState}, ${order.postcode}</p>
    </div>
  </div>

  <!-- Thông tin đơn hàng -->
  <div class="row mt-4">
    <div class="col-12">
      <h4>Thông tin đơn hàng</h4>
      <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/></p>
      <p><strong>Tổng tiền:</strong> <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="đ"/></p>
      <p><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</p>
      <p><strong>Trạng thái:</strong>
        <span class="badge ${order.status == 'Pending' ? 'bg-warning' : order.status == 'Processing' ? 'bg-info' : order.status == 'Delivered' ? 'bg-success' : 'bg-danger'}">
          ${order.status}
        </span>
      </p>
      <p><strong>Ghi chú:</strong> ${order.orderNotes}</p>
    </div>
  </div>

  <!-- Chi tiết sản phẩm -->
  <div class="row mt-4">
    <div class="col-12">
      <h4>Chi tiết sản phẩm</h4>
      <table class="table table-bordered">
        <thead>
        <tr>
          <th>Sản phẩm</th>
          <th>Số lượng</th>
          <th>Đơn giá</th>
          <th>Thành tiền</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="detail" items="${order.orderDetails}">
          <tr>
            <td>${detail.productName}</td>
            <td>${detail.quantity}</td>
            <td><fmt:formatNumber value="${detail.unitPrice}" type="currency" currencySymbol="đ"/></td>
            <td><fmt:formatNumber value="${detail.unitPrice * detail.quantity}" type="currency" currencySymbol="đ"/></td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>