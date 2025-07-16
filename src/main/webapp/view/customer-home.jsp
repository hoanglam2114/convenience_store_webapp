<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/22/2025
  Time: 8:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang Gian Hàng</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --card-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
                --hover-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            }

            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            /* Navbar Styling */
            .navbar-custom {
                background: var(--primary-gradient);
                box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
                padding: 1rem 0;
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
                color: white !important;
            }

            .navbar-nav .nav-link {
                color: rgba(255, 255, 255, 0.9) !important;
                font-weight: 500;
                margin: 0 0.5rem;
                padding: 0.5rem 1rem !important;
                border-radius: 25px;
                transition: all 0.3s ease;
            }

            .navbar-nav .nav-link:hover {
                background-color: rgba(255, 255, 255, 0.1);
                color: white !important;
                transform: translateY(-1px);
            }

            /* Search Section */
            .search-section {
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                padding: 3rem 0;
                margin-bottom: 2rem;
            }

            .search-card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                padding: 2rem;
                box-shadow: var(--card-shadow);
                border: none;
            }

            .form-control:focus, .form-select:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            .btn-search {
                background: var(--primary-gradient);
                border: none;
                border-radius: 25px;
                padding: 0.75rem 2rem;
                font-weight: 600;
                color: white;
                transition: all 0.3s ease;
            }

            .btn-search:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
                color: white;
            }

            /* Banner Styling */
            .banner-section {
                margin-bottom: 3rem;
            }

            .banner-container {
                position: relative;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: var(--card-shadow);
                height: 300px;
                background: var(--primary-gradient);
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .banner-content {
                text-align: center;
                color: white;
                z-index: 2;
            }

            .banner-title {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 1rem;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            }

            .banner-subtitle {
                font-size: 1.2rem;
                opacity: 0.9;
            }

            /* Product Grid */
            .products-section {
                margin-bottom: 3rem;
            }

            .section-title {
                font-size: 2rem;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 2rem;
                text-align: center;
                position: relative;
            }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: var(--primary-gradient);
                border-radius: 2px;
            }

            .product-card {
                background: white;
                border-radius: 15px;
                box-shadow: var(--card-shadow);
                transition: all 0.3s ease;
                border: none;
                overflow: hidden;
                height: 100%;
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--hover-shadow);
            }

            .product-image {
                height: 200px;
                background: linear-gradient(45deg, #f093fb, #f5576c);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 3rem;
            }

            .product-body {
                padding: 1.5rem;
            }

            .product-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 0.5rem;
                line-height: 1.3;
            }

            .product-price {
                font-size: 1.25rem;
                font-weight: 700;
                color: #e74c3c;
                margin-bottom: 1rem;
            }

            .btn-add-cart {
                background: var(--primary-gradient);
                border: none;
                border-radius: 25px;
                padding: 0.5rem 1.5rem;
                color: white;
                font-weight: 600;
                width: 100%;
                transition: all 0.3s ease;
            }

            .btn-add-cart:hover {
                transform: translateY(-1px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
                color: white;
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 3rem 0;
                color: #6c757d;
            }

            .empty-state i {
                font-size: 4rem;
                margin-bottom: 1rem;
                opacity: 0.5;
            }

            /* Footer */
            .footer {
                background: #2c3e50;
                color: white;
                padding: 2rem 0;
                margin-top: 4rem;
            }

            .footer-content {
                text-align: center;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .banner-title {
                    font-size: 1.8rem;
                }

                .search-card {
                    padding: 1.5rem;
                }

                .product-image {
                    height: 150px;
                    font-size: 2rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-custom fixed-top">
            <div class="container">
                <a class="navbar-brand" href="customer-home">
                    <i class="bi bi-shop me-2"></i>Gian Hàng
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="customer-home">
                                <i class="bi bi-house me-1"></i>Trang chủ
                            </a>
                        </li>
                        <c:choose>
                            <c:when test="${empty sessionScope.customer}">
                                <li class="nav-item">
                                    <a class="nav-link" href="customer-login">
                                        <i class="bi bi-person me-1"></i>Đăng nhập
                                    </a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link" href="customer-profile">
                                        <i class="bi bi-person-circle me-1"></i>Hồ sơ
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="customer-logout">
                                        <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Add padding to account for fixed navbar -->
        <div style="padding-top: 80px;"></div>

        <!-- Search & Category filter -->
        <section class="search-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="card search-card">
                            <form action="customer-home" method="get">
                                <div class="row g-3 align-items-end">
                                    <div class="col-md-5">
                                        <label class="form-label fw-semibold">
                                            <i class="bi bi-search me-2"></i>Tìm kiếm sản phẩm
                                        </label>
                                        <input type="text"
                                               class="form-control"
                                               name="keyword"
                                               placeholder="Nhập tên sản phẩm..."
                                               value="${param.keyword}">
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label fw-semibold">
                                            <i class="bi bi-tags me-2"></i>Danh mục
                                        </label>
                                        <select name="category" class="form-select">
                                            <option value="" ${empty param.category ? 'selected' : ''}>Tất cả danh mục</option>
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.id}" ${param.category == cat.id ? 'selected' : ''}>${cat.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <button type="submit" class="btn btn-search w-100">
                                            <i class="bi bi-search me-2"></i>Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Banner sự kiện -->
        <section class="banner-section">
            <div class="container">
                <div class="banner-container">
                    <div class="banner-content">
                        <h1 class="banner-title">Sự Kiện Đặc Biệt</h1>
                        <p class="banner-subtitle">Khuyến mãi lớn - Giảm giá tới 50% cho tất cả sản phẩm</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Danh sách sản phẩm -->
        <section class="products-section">
            <div class="container">
                <h2 class="section-title">Sản Phẩm Nổi Bật</h2>

                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="row g-4">
                            <c:forEach var="p" items="${products}">
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="card product-card">
                                        <div class="product-image">
                                            <i class="bi bi-image"></i>
                                        </div>
                                        <div class="product-body">
                                            <h5 class="product-title">${p.name}</h5>
                                            <div class="product-price">
                                                <c:choose>
                                                    <c:when test="${p.price != null}">
                                                        ${p.price} VND
                                                    </c:when>
                                                    <c:otherwise>
                                                        Liên hệ
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <button class="btn btn-add-cart">
                                                <i class="bi bi-cart-plus me-2"></i>Xem chi tiết
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="bi bi-box-seam"></i>
                            <h4>Không tìm thấy sản phẩm</h4>
                            <p>Thử thay đổi từ khóa tìm kiếm hoặc danh mục khác</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="footer-content">
                    <p class="mb-0">
                        <i class="bi bi-shop me-2"></i>
                        © 2025 Gian Hàng. Tất cả quyền được bảo lưu.
                    </p>
                </div>
            </div>
        </footer>

        <!-- Bootstrap 5 JS Bundle -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

        <script>
            // Add some interactive features
            document.addEventListener('DOMContentLoaded', function () {
                // Add to cart button animation
                const addToCartButtons = document.querySelectorAll('.btn-add-cart');
                addToCartButtons.forEach(button => {
                    button.addEventListener('click', function (e) {
                        e.preventDefault();

                        // Add temporary success state
                        const originalText = this.innerHTML;
                        this.innerHTML = '<i class="bi bi-check-circle me-2"></i>Đã thêm!';
                        this.style.background = '#28a745';

                        setTimeout(() => {
                            this.innerHTML = originalText;
                            this.style.background = '';
                        }, 1500);
                    });
                });

                // Search form enhancement
                const searchForm = document.querySelector('form[action="customer-home"]');
                const searchInput = searchForm.querySelector('input[name="keyword"]');

                searchInput.addEventListener('keypress', function (e) {
                    if (e.key === 'Enter') {
                        searchForm.submit();
                    }
                });
            });
        </script>
    </body>
</html>