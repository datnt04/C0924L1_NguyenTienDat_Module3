<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Haven - Cửa hàng sách online</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- Font + Icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/11.0.5/swiper-bundle.min.css">
</head>
<body>
<!-- Header -->
<jsp:include page="header.jsp" />

<!-- Banner -->
<section class="banner">
    <img src="${pageContext.request.contextPath}/img/banner/banner_1.jpg" class="banner-img" alt="Banner Book Haven">
    <div class="banner-text">
        <h2>Khám phá thế giới tri thức tại Book Haven</h2>
        <p>Mỗi cuốn sách là một cuộc phiêu lưu mới!</p>
        <button onclick="window.location.href='${pageContext.request.contextPath}/products'">Xem bộ sưu tập</button>
    </div>
</section>

<!-- Danh mục -->
<section class="categories">
    <h3>Danh mục nổi bật</h3>
    <div class="category-list">
        <a href="${pageContext.request.contextPath}/products?category=Tiểu thuyết"
           class="category ${param.category == 'Tiểu thuyết' ? 'active' : ''}">Tiểu thuyết</a>
        <a href="${pageContext.request.contextPath}/products?category=Khoa học"
           class="category ${param.category == 'Khoa học' ? 'active' : ''}">Khoa học</a>
        <a href="${pageContext.request.contextPath}/products?category=Trẻ em"
           class="category ${param.category == 'Trẻ em' ? 'active' : ''}">Trẻ em</a>
        <a href="${pageContext.request.contextPath}/products?category=Lịch sử"
           class="category ${param.category == 'Lịch sử' ? 'active' : ''}">Lịch sử</a>
        <a href="${pageContext.request.contextPath}/products?category=Self-help"
           class="category ${param.category == 'Self-help' ? 'active' : ''}">Self-help</a>
    </div>
</section>

<!-- Sách nổi bật -->
<section class="featured-books">
    <h3>Danh sách sách tại Book Haven</h3>
    <div class="row" id="product-list">
        <c:choose>
            <c:when test="${empty bookList}">
                <p style="color:red; text-align: center; width: 100%;">
                    ⚠ Không tìm thấy sách nào phù hợp với từ khóa của bạn.
                </p>
            </c:when>
            <c:otherwise>
                <c:forEach var="book" items="${bookList}">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div class="product__item__pic">
                                <img src="${book.imageUrl}" alt="${book.name}" />
                            </div>
                            <div class="product__item__text">
                                <h6>
                                    <a href="${pageContext.request.contextPath}/product-details?product_id=${book.productId}">
                                            ${book.name}
                                    </a>
                                </h6>
                                <c:if test="${not empty book.author}">
                                    <p>Tác giả: ${book.author}</p>
                                </c:if>
                                <p>Danh mục: ${book.categoryName}</p>
                                <div class="product__item__price">
                                    <fmt:formatNumber value="${book.price}" type="currency" currencySymbol="VNĐ"/>
                                </div>
                                <div class="cart_add">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.username}">
                                            <a href="#" onclick="addToCart(${book.productId}); return false;">Thêm vào giỏ hàng</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/login.jsp">Thêm vào giỏ hàng</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- Đánh giá -->
<section class="reviews">
    <h3>Khách hàng nói gì</h3>
    <div class="swiper review-slider">
        <div class="swiper-wrapper">
            <div class="swiper-slide review-card">
                <div class="review-content">
                    <img src="${pageContext.request.contextPath}/img/customer/customer_1.jpg" alt="Customer" class="review-avatar">
                    <div class="review-info">
                        <h4>Nguyen Van A
                            <span class="rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i>
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                            </span>
                        </h4>
                        <p class="review-country">Vietnam</p>
                        <p class="review-text">"Sách rất hay, giao hàng nhanh!"</p>
                    </div>
                </div>
            </div>
            <div class="swiper-slide review-card">
                <div class="review-content">
                    <img src="${pageContext.request.contextPath}/img/customer/customer_2.jpg" alt="Customer" class="review-avatar">
                    <div class="review-info">
                        <h4>Tran Thi B
                            <span class="rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i>
                                <i class="fas fa-star"></i><i class="fas fa-star"></i>
                            </span>
                        </h4>
                        <p class="review-country">USA</p>
                        <p class="review-text">"Tôi rất thích bộ sưu tập sách ở đây."</p>
                    </div>
                </div>
            </div>
            <div class="swiper-slide review-card">
                <div class="review-content">
                    <img src="${pageContext.request.contextPath}/img/customer/customer_3.jpg" alt="Customer" class="review-avatar">
                    <div class="review-info">
                        <h4>Le Van C
                            <span class="rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i>
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                            </span>
                        </h4>
                        <p class="review-country">Japan</p>
                        <p class="review-text">"Dịch vụ tuyệt vời, sẽ quay lại!"</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="swiper-pagination"></div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="footer.jsp" />

<!-- JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/11.0.5/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Khởi tạo Swiper cho phần đánh giá
    new Swiper('.review-slider', {
        slidesPerView: 1,
        spaceBetween: 20,
        loop: true,
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        autoplay: {
            delay: 5000,
            disableOnInteraction: false,
        },
        breakpoints: {
            768: {
                slidesPerView: 2,
            },
            1200: {
                slidesPerView: 3,
            },
        },
    });

    function addToCart(productId) {
        const cartUrl = '${pageContext.request.contextPath}/cart';
        console.log('Sending POST request to:', cartUrl); // Debug URL
        fetch(cartUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: 'action=add&productId=' + productId + '&quantity=1'
        })
            .then(response => {
                console.log('Response status:', response.status); // Debug status
                console.log('Response statusText:', response.statusText); // Debug statusText
                if (!response.ok) {
                    if (response.status === 401) {
                        return response.json().then(data => {
                            throw new Error(data.error || 'User not logged in');
                        });
                    } else if (response.status === 500) {
                        return response.json().then(data => {
                            throw new Error(data.error || 'Lỗi server không xác định');
                        });
                    }
                    throw new Error('Lỗi khi thêm sản phẩm vào giỏ hàng: ' + response.status + ' ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                console.log('Dữ liệu nhận được:', data); // Debug dữ liệu
                if (data.error) {
                    alert(data.error);
                    if (data.error === "User not logged in") {
                        window.location.href = '${pageContext.request.contextPath}/login.jsp';
                    }
                } else if (data && typeof data.cartCount !== 'undefined' && typeof data.cartTotal !== 'undefined') {
                    const cartCountElement = document.getElementById('cart-count');
                    const cartTotalElement = document.getElementById('cart-total');
                    if (cartCountElement && cartTotalElement) {
                        cartCountElement.innerText = data.cartCount;
                        // Định dạng cartTotal giống với JSP
                        const formattedTotal = new Intl.NumberFormat('vi-VN', {
                            style: 'currency',
                            currency: 'VND',
                            currencyDisplay: 'symbol'
                        }).format(data.cartTotal).replace('₫', ' ₫');
                        cartTotalElement.innerText = `Giỏ hàng: ${formattedTotal}`;
                        alert('Đã thêm sản phẩm vào giỏ hàng!');
                    } else {
                        console.error('Không tìm thấy cart-count hoặc cart-total trong DOM');
                    }
                } else {
                    throw new Error('Dữ liệu JSON không hợp lệ');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi thêm vào giỏ hàng: ' + error.message);
                if (error.message.includes("User not logged in")) {
                    window.location.href = '${pageContext.request.contextPath}/login.jsp';
                }
            });
    }

    // JavaScript để xử lý hiển thị/ẩn form tìm kiếm
    document.addEventListener('DOMContentLoaded', function() {
        const searchIcon = document.getElementById('searchIcon');
        const searchBar = document.getElementById('searchBar');
        if (searchIcon && searchBar) {
            console.log('Search icon and search bar found.');
            searchIcon.addEventListener('click', function() {
                console.log('Search icon clicked.');
                searchBar.classList.toggle('active');
                if (searchBar.classList.contains('active')) {
                    searchBar.querySelector('input[name="search"]').focus();
                }
            });
        } else {
            console.error('Search icon or search bar not found.');
        }
    });
</script>
</body>
</html>