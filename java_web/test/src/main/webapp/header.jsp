<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa Hàng Sách Online - Book Haven</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&family=Dancing+Script&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-Fo3rlrZj/k7ujTnHg4CGR2D7kSs0v4LLanw2qksYuRlEzO+tcaEPQogQ0KaoGN26/zrn20ImR1DfuLWnOo7aBA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .logout-btn {
            background-color: #FF7F50;
            color: #FFFFFF;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .logout-btn:hover {
            background-color: #FFD700;
            transform: translateY(-2px);
        }

        /* CSS cho phần tìm kiếm */
        .search-container {
            display: inline-flex;
            align-items: center;
            margin-right: 15px;
            position: relative;
            background-color: #fff;
            border-radius: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            padding: 5px;
            transition: box-shadow 0.3s ease;
        }

        .search-container:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .search-icon {
            margin: 0 8px;
            width: 20px;
            height: 20px;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .search-icon:hover {
            transform: scale(1.1);
        }

        .search-bar {
            display: flex;
            align-items: center;
        }

        .search-bar input {
            padding: 8px 12px;
            border: none;
            border-radius: 20px 0 0 20px;
            outline: none;
            width: 180px; /* Điều chỉnh độ rộng ô tìm kiếm */
            font-size: 14px;
            color: #333;
            background-color: #f5f5f5;
            transition: background-color 0.3s ease;
        }

        .search-bar input:focus {
            background-color: #fff;
            box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.05);
        }

        .search-bar select {
            padding: 8px 10px;
            border: none;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            outline: none;
            background-color: #f5f5f5;
            font-size: 14px;
            color: #333;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .search-bar select:hover {
            background-color: #fff;
        }

        .search-bar button {
            padding: 8px 15px;
            border: none;
            background-color: #FF7F50;
            color: white;
            border-radius: 0 20px 20px 0;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .search-bar button:hover {
            background-color: #FFD700;
            transform: translateY(-2px);
        }

        .icons {
            display: flex;
            align-items: center;
        }

        .icon {
            margin: 0 10px;
            width: 24px;
            height: 24px;
            transition: transform 0.3s ease;
        }

        .icon:hover {
            transform: scale(1.1);
        }

        .sign-in-btn {
            background-color: #FF7F50;
            color: #FFFFFF;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .sign-in-btn:hover {
            background-color: #FFD700;
            transform: translateY(-2px);
        }
    </style>
</head>
<style>
    .cart-container {
        position: relative; /* Để định vị số lượng tương đối với icon */
        display: inline-flex;
        align-items: center;
        text-decoration: none;
        color: #333;
    }

    .icon {
        margin: 0 10px;
        width: 24px;
        height: 24px;
        transition: transform 0.3s ease;
    }

    .cart-count {
        position: absolute;
        top: -5px; /* Điều chỉnh vị trí theo chiều dọc */
        right: 0; /* Điều chỉnh vị trí theo chiều ngang */
        background-color: #FF7F50; /* Màu nền của số lượng */
        color: white; /* Màu chữ */
        border-radius: 50%; /* Tạo hình tròn */
        width: 16px; /* Kích thước vòng tròn */
        height: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 12px; /* Kích thước chữ */
        font-weight: bold;
        border: 1px solid #fff; /* Viền trắng để nổi bật */
    }

    .cart-total {
        margin-left: 5px;
        font-size: 14px;
        color: #FF7F50;
        font-weight: bold;
    }
</style>
<body>
<!-- Header -->
<header>
    <div class="container">
        <div class="logo">
            <h1>Book Haven</h1>
        </div>
        <nav>
            <ul>
                <li><a href="products">Trang chủ</a></li>
                <li><a href="#">Cửa hàng</a></li>
                <li><a href="#">Liên hệ</a></li>
            </ul>
        </nav>
        <div class="icons">
            <div class="search-container">
                <img src="img/icon/search.png" alt="Search" class="icon search-icon" id="searchIcon">
                <form action="products" method="get" id="searchForm">
                    <div class="search-bar" id="searchBar">
                        <label>
                            <input type="text" name="search" placeholder="Tìm kiếm sách...">
                        </label>
                        <select name="category">
                            <option value="">Tất cả danh mục</option>
                            <option value="Tiểu thuyết">Tiểu thuyết</option>
                            <option value="Khoa học">Khoa học</option>
                            <option value="Trẻ em">Trẻ em</option>
                            <option value="Lịch sử">Lịch sử</option>
                            <option value="Self-help">Self-help</option>
                        </select>
                        <button type="submit">🔍</button>
                    </div>
                </form>
            </div>
            <!-- Phần giỏ hàng -->
            <!-- Phần giỏ hàng -->
            <a href="${pageContext.request.contextPath}/cart" class="cart-container">
                <img src="img/icon/cart.png" alt="Cart" class="icon">
                <span id="cart-count" class="cart-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                <span id="cart-total" class="cart-total">
        Giỏ hàng:
        <fmt:formatNumber value="${sessionScope.cartTotal != null ? sessionScope.cartTotal : 0}"
                          type="currency"
                          currencySymbol="₫"
                          pattern="#,##0 ₫"/>
    </span>
            </a>
            <img src="img/icon/heart.png" alt="Heart" class="icon">
            <c:choose>
                <c:when test="${not empty sessionScope.userId}">
                    <a href="logout" class="logout-btn">Logout</a>
                </c:when>
                <c:otherwise>
                    <button class="sign-in-btn"><a href="login.jsp" style="text-decoration: none; color: inherit;">Sign In</a></button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>