<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Haven - Giỏ hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .cart-page {
            padding: 120px 0 40px;
            background: linear-gradient(135deg, #f5f6fa 0%, #fff 100%); /* Gradient nền nhẹ nhàng */
            min-height: 100vh;
        }

        .cart-page .cart-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .cart-page .cart-title {
            font-size: 3rem; /* Tăng kích thước tiêu đề */
            color: #e67e22;
            margin-bottom: 40px;
            font-weight: 700;
            text-align: center;
            position: relative;
            font-family: 'Playfair Display', serif; /* Phông chữ sang trọng */
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1); /* Bóng chữ nhẹ */
        }

        .cart-page .cart-title:after {
            content: '';
            display: block;
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #e67e22, #ff7f50); /* Gradient cho đường gạch chân */
            margin: 15px auto;
            border-radius: 2px;
        }

        .cart-page .cart-table {
            width: 100%;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
            margin-bottom: 40px;
            font-family: 'Poppins', sans-serif; /* Phông chữ hiện đại */
        }

        .cart-page .cart-table th {
            background: linear-gradient(135deg, #e67e22, #ff7f50); /* Gradient cho header */
            color: #fff;
            padding: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .cart-page .cart-table td {
            padding: 20px 15px;
            vertical-align: middle;
            border-bottom: 1px solid #eee;
            font-size: 1rem;
            color: #333;
        }

        .cart-page .cart-table tr:hover {
            background-color: #fff8f3;
            transition: background-color 0.3s ease;
        }

        .cart-page .product-img {
            width: 80px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #e67e22;
            padding: 2px;
            transition: transform 0.3s ease;
        }

        .cart-page .product-img:hover {
            transform: scale(1.05);
        }

        .cart-page .product-name a {
            color: #333;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .cart-page .product-name a:hover {
            color: #e67e22;
        }

        .cart-page .quantity-input {
            width: 70px;
            padding: 8px;
            text-align: center;
            border: 2px solid #ddd;
            border-radius: 5px;
            margin-right: 10px;
            font-family: 'Poppins', sans-serif;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .cart-page .quantity-input:focus {
            border-color: #e67e22;
            box-shadow: 0 0 5px rgba(230, 126, 34, 0.3);
            outline: none;
        }

        .cart-page .update-btn {
            background: #e67e22;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }

        .cart-page .update-btn:hover {
            background: #d35400;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 126, 34, 0.3);
        }

        .cart-page .remove-btn {
            background: #fff;
            color: #e74c3c;
            border: 2px solid #e74c3c;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9rem;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }

        .cart-page .remove-btn:hover {
            background: #e74c3c;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        .cart-page .cart-summary {
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 400px;
            margin: 0 0 0 0; /* Căn trái */
            text-align: left; /* Căn trái nội dung bên trong */
            font-family: 'Poppins', sans-serif;
        }

        .cart-page .cart-total {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 20px;
        }

        .cart-page .cart-total span {
            color: #e67e22;
            font-weight: 700;
            font-size: 1.5rem;
        }

        .cart-page .checkout-btn {
            display: inline-block;
            background: linear-gradient(90deg, #e67e22, #ff7f50); /* Gradient cho nút */
            color: white;
            border: none;
            padding: 12px 35px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 5px 15px rgba(230, 126, 34, 0.3);
        }

        .cart-page .checkout-btn:hover {
            background: linear-gradient(90deg, #ff7f50, #e67e22);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(230, 126, 34, 0.5);
            color: white;
        }

        .cart-page .empty-cart {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1.2rem;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            font-family: 'Poppins', sans-serif;
        }

        @media (max-width: 768px) {
            .cart-page .cart-title {
                font-size: 2.2rem;
            }

            .cart-page .cart-table {
                font-size: 14px;
                display: block;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }

            .cart-page .cart-table th,
            .cart-page .cart-table td {
                padding: 12px 10px;
            }

            .cart-page .product-img {
                width: 60px;
                height: 90px;
            }

            .cart-page .quantity-input {
                width: 60px;
                padding: 6px;
            }

            .cart-page .update-btn,
            .cart-page .remove-btn {
                padding: 6px 12px;
                font-size: 0.85rem;
            }

            .cart-page .cart-total {
                font-size: 1.2rem;
            }

            .cart-page .checkout-btn {
                padding: 10px 25px;
                font-size: 1rem;
            }

            .cart-page .cart-summary {
                max-width: 100%;
                margin: 0; /* Vẫn căn trái trên mobile */
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<jsp:include page="header.jsp" />

<!-- Phần giỏ hàng -->
<div class="cart-content cart-page">
    <div class="cart-container">
        <h1 class="cart-title">Giỏ hàng của bạn</h1>
        <c:choose>
            <c:when test="${empty cartItems}">
                <p class="empty-cart">Giỏ hàng của bạn đang trống. Hãy thêm sản phẩm để tiếp tục!</p>
            </c:when>
            <c:otherwise>
                <table class="cart-table">
                    <thead>
                    <tr>
                        <th>Hình ảnh</th>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tổng tiền</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr>
                            <td>
                                <img src="${item.product.imageUrl}" alt="${item.product.name}" class="product-img">
                            </td>
                            <td class="product-name">
                                <a href="${pageContext.request.contextPath}/product-details?product_id=${item.product.productId}">
                                        ${item.product.name}
                                </a>
                            </td>
                            <td>
                                <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="VNĐ"/>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="productId" value="${item.product.productId}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" class="quantity-input">
                                    <button type="submit" class="update-btn">Cập nhật</button>
                                </form>
                            </td>
                            <td>
                                <fmt:formatNumber value="${item.quantity * item.product.price}" type="currency" currencySymbol="VNĐ"/>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="productId" value="${item.product.productId}">
                                    <button type="submit" class="remove-btn">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="cart-summary">
                    <div class="cart-total">
                        Tổng cộng: <span><fmt:formatNumber value="${sessionScope.cartTotal}" type="currency" currencySymbol="VNĐ"/></span>
                    </div>
                    <a href="${pageContext.request.contextPath}/checkout" class="checkout-btn">Thanh toán</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<!-- Footer -->
<jsp:include page="footer.jsp" />

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>