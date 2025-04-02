<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Haven - Thanh toán</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .checkout-page {
            padding: 120px 0 40px;
            background: linear-gradient(135deg, #f5f6fa 0%, #fff 100%);
            min-height: 100vh;
        }

        .checkout-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .checkout-title {
            font-size: 2.5rem;
            color: #e67e22;
            margin-bottom: 30px;
            font-weight: 700;
            text-align: center;
            font-family: 'Playfair Display', serif;
        }

        .checkout-form {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .checkout-summary {
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
        }

        .checkout-btn {
            background: linear-gradient(90deg, #e67e22, #ff7f50);
            color: white;
            border: none;
            padding: 12px 35px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 1.1rem;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 5px 15px rgba(230, 126, 34, 0.3);
        }

        .checkout-btn:hover {
            background: linear-gradient(90deg, #ff7f50, #e67e22);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(230, 126, 34, 0.5);
        }

        .error-message {
            color: #e74c3c;
            font-size: 1rem;
            margin-bottom: 20px;
            text-align: center;
        }

        .cart-item-img {
            width: 50px;
            height: 75px;
            object-fit: cover;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="checkout-page">
    <div class="checkout-container">
        <h1 class="checkout-title">Thanh toán</h1>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <div class="row">
            <div class="col-md-8">
                <div class="checkout-form">
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <h3>Thông tin giao hàng</h3>
                        <div class="mb-3">
                            <label for="shippingFirstName" class="form-label">Họ</label>
                            <input type="text" class="form-control" id="shippingFirstName" name="shippingFirstName" required>
                        </div>
                        <div class="mb-3">
                            <label for="shippingLastName" class="form-label">Tên</label>
                            <input type="text" class="form-control" id="shippingLastName" name="shippingLastName" required>
                        </div>
                        <div class="mb-3">
                            <label for="shippingAddress" class="form-label">Địa chỉ giao hàng</label>
                            <input type="text" class="form-control" id="shippingAddress" name="shippingAddress" required>
                        </div>
                        <div class="mb-3">
                            <label for="city" class="form-label">Thành phố</label>
                            <input type="text" class="form-control" id="city" name="city" required>
                        </div>
                        <div class="mb-3">
                            <label for="countryState" class="form-label">Tỉnh/Quốc gia</label>
                            <input type="text" class="form-control" id="countryState" name="countryState" required>
                        </div>
                        <div class="mb-3">
                            <label for="postcode" class="form-label">Mã bưu điện</label>
                            <input type="text" class="form-control" id="postcode" name="postcode" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="phone" name="phone" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="orderNotes" class="form-label">Ghi chú đơn hàng</label>
                            <textarea class="form-control" id="orderNotes" name="orderNotes" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="paymentMethod" class="form-label">Phương thức thanh toán</label>
                            <select class="form-control" id="paymentMethod" name="paymentMethod" required>
                                <option value="Cash">Tiền mặt</option>
                                <option value="Credit Card">Thẻ tín dụng</option>
                                <option value="Online Banking">Chuyển khoản ngân hàng</option>
                                <option value="PayPal">PayPal</option>
                            </select>
                        </div>
                        <button type="submit" class="checkout-btn">Xác nhận thanh toán</button>
                    </form>
                </div>
            </div>
            <div class="col-md-4">
                <div class="checkout-summary">
                    <h3>Tóm tắt đơn hàng</h3>
                    <ul class="list-group mb-3">
                        <c:forEach var="item" items="${cartItems}">
                            <li class="list-group-item d-flex align-items-center">
                                <img src="${item.product.imageUrl}" alt="${item.product.name}" class="cart-item-img me-3">
                                <div class="flex-grow-1">
                                    <span>${item.product.name} (x${item.quantity})</span>
                                </div>
                                <span><fmt:formatNumber value="${item.quantity * item.product.price}" type="currency" currencySymbol="VNĐ"/></span>
                            </li>
                        </c:forEach>
                    </ul>
                    <h4>Tổng cộng: <span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="VNĐ"/></span></h4>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>