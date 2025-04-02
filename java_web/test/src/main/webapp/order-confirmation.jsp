<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Haven - Xác nhận đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .confirmation-page {
            padding: 120px 0 40px;
            background: linear-gradient(135deg, #f5f6fa 0%, #fff 100%);
            min-height: 100vh;
        }

        .confirmation-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 20px;
            text-align: center;
        }

        .confirmation-title {
            font-size: 2.5rem;
            color: #e67e22;
            margin-bottom: 20px;
            font-family: 'Playfair Display', serif;
        }

        .confirmation-message {
            font-size: 1.2rem;
            color: #333;
            margin-bottom: 30px;
            font-family: 'Poppins', sans-serif;
        }

        .btn-home {
            background: linear-gradient(90deg, #e67e22, #ff7f50);
            color: white;
            padding: 10px 30px;
            border-radius: 30px;
            text-decoration: none;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }

        .btn-home:hover {
            background: linear-gradient(90deg, #ff7f50, #e67e22);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 126, 34, 0.3);
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="confirmation-page">
    <div class="confirmation-container">
        <h1 class="confirmation-title">Đặt hàng thành công!</h1>
        <p class="confirmation-message">
            Cảm ơn bạn đã đặt hàng. Mã đơn hàng của bạn là: <strong>#${param.orderId}</strong>.<br>
            Chúng tôi sẽ liên hệ với bạn sớm để xác nhận đơn hàng.
        </p>
        <a href="${pageContext.request.contextPath}products" class="btn-home">Quay về trang chủ</a>
    </div>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.misdeliver.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>