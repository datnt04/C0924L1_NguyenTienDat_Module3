<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 250px;
            background-color: #343a40;
            padding-top: 20px;
        }
        .sidebar a {
            color: white;
            padding: 15px;
            display: block;
            text-decoration: none;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
        }
        .logout-section {
            position: absolute;
            top: 20px;
            right: 20px;
        }
        .logout-section a {
            color: #dc3545;
            text-decoration: none;
        }
        .logout-section a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/product-list">Quản lý Sản phẩm</a>
    <a href="${pageContext.request.contextPath}/admin/order-list">Quản lý Đơn hàng</a>
    <a href="${pageContext.request.contextPath}/admin/user-list">Quản lý Khách hàng</a>
</div>

<!-- Nội dung chính -->
<div class="content">
    <!-- Hiển thị tên admin và nút đăng xuất -->
    <div class="logout-section">
        <span>Xin chào, ${user.name} (<a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>)</span>
    </div>

    <h2>Chào mừng đến với Dashboard của Admin</h2>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- Thống kê tổng quan -->
    <div class="row mt-4">
        <div class="col-md-3">
            <div class="card text-white bg-primary mb-3">
                <div class="card-body">
                    <h5 class="card-title">Doanh thu</h5>
                    <p class="card-text">
                        <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="đ"/>
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-white bg-success mb-3">
                <div class="card-body">
                    <h5 class="card-title">Đơn hàng</h5>
                    <p class="card-text">${totalOrders}</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-white bg-info mb-3">
                <div class="card-body">
                    <h5 class="card-title">Khách hàng</h5>
                    <p class="card-text">${totalCustomers}</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-white bg-warning mb-3">
                <div class="card-body">
                    <h5 class="card-title">Sản phẩm</h5>
                    <p class="card-text">${totalProducts}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Biểu đồ -->
    <div class="row mt-4">
        <div class="col-md-6">
            <h4>Doanh thu theo tuần trong tháng</h4>
            <canvas id="revenueChart"></canvas>
        </div>
        <div class="col-md-6">
            <h4>Phân bố đơn hàng theo ngày</h4>
            <canvas id="orderChart"></canvas>
        </div>
    </div>

    <!-- Đơn hàng gần đây -->
    <div class="row mt-4">
        <div class="col-12">
            <h4>Đơn hàng gần đây</h4>
            <c:if test="${empty recentOrders}">
                <p>Không có đơn hàng nào gần đây.</p>
            </c:if>
            <c:if test="${not empty recentOrders}">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Khách hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${recentOrders}">
                        <tr>
                            <td>#${order.orderId}</td>
                            <td>${userService.getUserNameById(order.customerId)}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="đ"/></td>
                            <td>
                                    <span class="badge ${order.status == 'Pending' ? 'bg-warning' : order.status == 'Processing' ? 'bg-info' : order.status == 'Delivered' ? 'bg-success' : 'bg-danger'}">
                                            ${order.status}
                                    </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/order-details?orderId=${order.orderId}" class="btn btn-sm btn-info">Xem chi tiết</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
</div>

<script>
    // Biểu đồ doanh thu
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revenueCtx, {
        type: 'bar',
        data: {
            labels: ['T03 - Tuần 1', 'T03 - Tuần 2', 'T03 - Tuần 3', 'T03 - Tuần 4', 'T03 - Tuần 5'],
            datasets: [{
                label: 'Doanh thu (đ)',
                data: [${revenueData}],
                backgroundColor: '#ff6200',
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Biểu đồ đơn hàng
    const orderCtx = document.getElementById('orderChart').getContext('2d');
    new Chart(orderCtx, {
        type: 'line',
        data: {
            labels: ['Ngày 2', 'Ngày 10', 'Ngày 13', 'Ngày 14', 'Ngày 24', 'Ngày 05', 'Ngày 19'],
            datasets: [{
                label: 'Số lượng đơn hàng',
                data: [${orderData}],
                borderColor: '#28a745',
                fill: false
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>