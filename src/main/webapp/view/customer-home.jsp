<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/22/2025
  Time: 8:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Convema</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-color: #0d6efd;
      --secondary-color: #6c757d;
      --success-color: #198754;
      --danger-color: #dc3545;
      --warning-color: #ffc107;
      --info-color: #0dcaf0;
    }
    .navbar-custom {
      background-color: #ffffff;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      border-bottom: 1px solid #e9ecef;
    }

    .navbar-brand {
      font-weight: 700;
      color: #0d6efd !important;
      font-size: 1.5rem;
    }

    .search-container {
      max-width: 400px;
      width: 100%;
    }

    .search-input {
      border: 2px solid #e9ecef;
      border-radius: 25px;
      padding: 8px 20px;
      transition: all 0.3s ease;
    }

    .search-input:focus {
      border-color: #0d6efd;
      box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
    }

    .search-btn {
      border-radius: 25px;
      padding: 8px 16px;
      margin-left: 8px;
    }

    .nav-link {
      font-weight: 500;
      color: #495057 !important;
      transition: color 0.3s ease;
    }

    .nav-link:hover {
      color: #0d6efd !important;
    }

    .dropdown-toggle::after {
      margin-left: 8px;
    }

    .user-avatar {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      object-fit: cover;
    }

    .user-info {
      display: flex;
      align-items: center;
      gap: 8px;
    }

    @media (max-width: 991px) {
      .search-container {
        margin: 1rem 0;
      }
    }


    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      line-height: 1.6;
    }

    /* Navbar Styles */
    .navbar-custom {
      background: linear-gradient(135deg, #667eea 0%, #5c7abb 100%);
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      padding: 1rem 0;
    }

    .navbar-brand {
      font-weight: 700;
      color: white !important;
      font-size: 1.8rem;
    }

    .navbar-nav .nav-link {
      color: rgba(255,255,255,0.9) !important;
      font-weight: 500;
      margin: 0 0.5rem;
      transition: all 0.3s ease;
    }

    .navbar-nav .nav-link:hover {
      color: white !important;
      transform: translateY(-2px);
    }

    .search-container {
      max-width: 400px;
    }

    .search-input {
      border-radius: 25px;
      border: none;
      padding: 0.7rem 1.5rem;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .search-btn {
      border-radius: 25px;
      padding: 0.7rem 1.5rem;
      background: linear-gradient(45deg, #ff6b6b, #ff8e8e);
      border: none;
      box-shadow: 0 4px 15px rgba(255,107,107,0.3);
      transition: all 0.3s ease;
    }

    .search-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(255,107,107,0.4);
    }

    /* Hero Banner */
    .hero-section {
      height: 60vh;
      min-height: 400px;
      position: relative;
      overflow: hidden;
      margin-top: 80px;
    }

    .carousel-item {
      height: 60vh;
      min-height: 400px;
    }

    .carousel-item img {
      object-fit: cover;
      height: 100%;
      width: 100%;
    }

    .carousel-caption {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      text-align: center;
      background: rgba(0,0,0,0.5);
      padding: 3rem;
      border-radius: 15px;
      backdrop-filter: blur(10px);
    }

    .carousel-caption h1 {
      font-size: 3rem;
      font-weight: 700;
      margin-bottom: 1rem;
      text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
    }

    .carousel-caption p {
      font-size: 1.3rem;
      margin-bottom: 2rem;
    }

    .btn-hero {
      background: linear-gradient(45deg, #ff6b6b, #ff8e8e);
      border: none;
      padding: 1rem 2rem;
      font-size: 1.1rem;
      font-weight: 600;
      border-radius: 25px;
      box-shadow: 0 4px 15px rgba(255,107,107,0.3);
      transition: all 0.3s ease;
    }

    .btn-hero:hover {
      transform: translateY(-3px);
      box-shadow: 0 6px 20px rgba(255,107,107,0.4);
    }

    /* Category Section */
    .category-section {
      padding: 4rem 0;
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    }

    .section-title {
      text-align: center;
      font-size: 2.5rem;
      font-weight: 700;
      margin-bottom: 3rem;
      color: #2c3e50;
      position: relative;
    }

    .section-title::after {
      content: '';
      position: absolute;
      width: 80px;
      height: 4px;
      background: linear-gradient(45deg, #ff6b6b, #ff8e8e);
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      border-radius: 2px;
    }

    .category-card {
      background: white;
      border-radius: 20px;
      padding: 2rem;
      text-align: center;
      transition: all 0.3s ease;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      cursor: pointer;
      border: none;
      height: 100%;
    }

    .category-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 35px rgba(0,0,0,0.2);
    }

    .category-icon {
      font-size: 3rem;
      margin-bottom: 1rem;
      display: block;
    }

    .category-name {
      font-size: 1.2rem;
      font-weight: 600;
      color: #2c3e50;
    }

    /* Products Section */
    .products-section {
      padding: 4rem 0;
      background: white;
    }

    .product-tabs {
      display: flex;
      justify-content: center;
      margin-bottom: 3rem;
      border-bottom: 2px solid #e9ecef;
    }

    .tab-btn {
      background: none;
      border: none;
      padding: 1rem 2rem;
      font-size: 1.1rem;
      font-weight: 600;
      color: #6c757d;
      cursor: pointer;
      transition: all 0.3s ease;
      position: relative;
    }

    .tab-btn.active,
    .tab-btn:hover {
      color: var(--primary-color);
    }

    .tab-btn.active::after {
      content: '';
      position: absolute;
      bottom: -2px;
      left: 50%;
      transform: translateX(-50%);
      width: 80%;
      height: 3px;
      background: linear-gradient(45deg, #ff6b6b, #ff8e8e);
      border-radius: 2px;
    }

    .product-card {
      background: white;
      border-radius: 15px;
      overflow: hidden;
      transition: all 0.3s ease;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      border: none;
      height: 100%;
    }

    .product-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(0,0,0,0.2);
    }

    .product-image {
      height: 200px;
      background: linear-gradient(45deg, #f8f9fa, #e9ecef);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 3rem;
      color: #6c757d;
      position: relative;
      overflow: hidden;
    }

    .product-image::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(45deg, transparent, rgba(255,255,255,0.3), transparent);
      transform: translateX(-100%);
      transition: transform 0.6s ease;
    }

    .product-card:hover .product-image::before {
      transform: translateX(100%);
    }

    .product-body {
      padding: 1.5rem;
    }

    .product-title {
      font-size: 1.1rem;
      font-weight: 600;
      color: #2c3e50;
      margin-bottom: 0.5rem;
      line-height: 1.4;
    }

    .product-price {
      font-size: 1.3rem;
      font-weight: 700;
      color: var(--danger-color);
      margin-bottom: 1rem;
    }

    .btn-view-detail {
      background: linear-gradient(45deg, #667eea, #764ba2);
      border: none;
      padding: 0.7rem 1.5rem;
      border-radius: 25px;
      font-weight: 600;
      transition: all 0.3s ease;
      width: 100%;
    }

    .btn-view-detail:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(102,126,234,0.3);
    }

    /* Special Event Section */
    .event-section {
      padding: 4rem 0;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
    }

    .event-banner {
      background: rgba(255,255,255,0.1);
      border-radius: 15px;
      padding: 2rem;
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255,255,255,0.2);
    }

    .event-title {
      font-size: 2rem;
      font-weight: 700;
      margin-bottom: 1rem;
    }

    .event-subtitle {
      font-size: 1.2rem;
      margin-bottom: 2rem;
      opacity: 0.9;
    }

    .btn-event {
      background: linear-gradient(45deg, #ff6b6b, #ff8e8e);
      border: none;
      padding: 1rem 2rem;
      font-weight: 600;
      border-radius: 25px;
    }

    /* Footer */
    .footer {
      background: #2c3e50;
      color: white;
      padding: 3rem 0 1rem;
    }

    .footer-title {
      font-size: 1.3rem;
      font-weight: 700;
      margin-bottom: 1.5rem;
      color: white;
    }

    .footer-link {
      color: rgba(255,255,255,0.8);
      text-decoration: none;
      transition: all 0.3s ease;
      display: block;
      margin-bottom: 0.5rem;
    }

    .footer-link:hover {
      color: white;
      transform: translateX(5px);
    }

    .social-icons {
      display: flex;
      gap: 1rem;
      margin-top: 1rem;
    }

    .social-icon {
      width: 40px;
      height: 40px;
      background: rgba(255,255,255,0.1);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      text-decoration: none;
      transition: all 0.3s ease;
    }

    .social-icon:hover {
      background: rgba(255,255,255,0.2);
      transform: translateY(-3px);
      color: white;
    }

    .footer-bottom {
      border-top: 1px solid rgba(255,255,255,0.1);
      padding-top: 2rem;
      margin-top: 2rem;
      text-align: center;
      color: rgba(255,255,255,0.8);
    }

    /* Responsive Design */
    @media (max-width: 768px) {
      .carousel-caption h1 {
        font-size: 2rem;
      }

      .carousel-caption p {
        font-size: 1rem;
      }

      .carousel-caption {
        padding: 2rem 1rem;
      }

      .section-title {
        font-size: 2rem;
      }

      .category-card {
        margin-bottom: 2rem;
      }

      .product-tabs {
        flex-wrap: wrap;
      }

      .tab-btn {
        padding: 0.5rem 1rem;
        font-size: 1rem;
      }
    }

    /* Animation */
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .animate-fade-in {
      animation: fadeInUp 0.6s ease-out;
    }

    /* Loading animation */
    .loading-spinner {
      border: 3px solid #f3f3f3;
      border-top: 3px solid var(--primary-color);
      border-radius: 50%;
      width: 30px;
      height: 30px;
      animation: spin 1s linear infinite;
      margin: 0 auto;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
  </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom fixed-top">
  <div class="container">
    <!-- Logo -->
    <a class="navbar-brand" href="customer-home">
      <i class="bi bi-shop me-2"></i>Convema
    </a>

    <!-- Search Bar (visible on larger screens) -->
    <div class="search-container d-none d-lg-flex mx-auto">
      <div class="input-group">
        <input type="text" class="form-control search-input" placeholder="Tìm kiếm sản phẩm..." aria-label="Tìm kiếm sản phẩm">
        <button class="btn btn-primary search-btn" type="button">
          <i class="bi bi-search"></i>
        </button>
      </div>
    </div>

    <!-- Toggle button for mobile -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Navigation Menu -->
    <div class="collapse navbar-collapse" id="navbarNav">
      <!-- Search Bar (mobile) -->
      <div class="search-container d-lg-none mb-3">
        <div class="input-group">
          <input type="text" class="form-control search-input" placeholder="Tìm kiếm sản phẩm..." aria-label="Tìm kiếm sản phẩm">
          <button class="btn btn-primary search-btn" type="button">
            <i class="bi bi-search"></i>
          </button>
        </div>
      </div>

      <ul class="navbar-nav ms-auto align-items-center">
        <!-- Category Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="bi bi-grid-3x3-gap me-1"></i>Danh mục
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Điện tử</a></li>
            <li><a class="dropdown-item" href="#">Thời trang</a></li>
            <li><a class="dropdown-item" href="#">Gia dụng</a></li>
            <li><a class="dropdown-item" href="#">Sách</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Xem tất cả</a></li>
          </ul>
        </li>

        <!-- Promotion -->
        <li class="nav-item">
          <a class="nav-link" href="promotion">
            <i class="bi bi-gift me-1"></i>Khuyến mãi
          </a>
        </li>

        <!-- Store System -->
        <li class="nav-item">
          <a class="nav-link" href="retail-chain">
            <i class="bi bi-geo-alt me-1"></i>Hệ thống cửa hàng
          </a>
        </li>

        <!-- Login/Profile Section -->
        <!-- Demo: Not logged in state -->
        <li class="nav-item d-none" id="loginSection">
          <a class="nav-link btn btn-outline-primary ms-2" href="customer-login">
            <i class="bi bi-person me-1"></i>Đăng nhập
          </a>
        </li>

        <!-- Demo: Logged in state -->
        <li class="nav-item dropdown" id="userSection">
          <c:choose>
            <c:when test="${not empty sessionScope.customer}">
              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <div class="user-info">
                  <img src="https://via.placeholder.com/32x32/007bff/ffffff?text=${fn:substring(sessionScope.customer.name, 0, 1)}"
                       alt="Avatar" class="user-avatar">
                  <span class="d-none d-md-inline">${sessionScope.customer.name}</span>
                </div>
              </a>
              <ul class="dropdown-menu dropdown-menu-end">
                <li>
                  <a class="dropdown-item" href="customer-profile">
                    <i class="bi bi-person-circle me-2"></i>Hồ sơ
                  </a>
                </li>
                <li><hr class="dropdown-divider"></li>
                <li>
                  <a class="dropdown-item" href="customer-logout">
                    <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                  </a>
                </li>
              </ul>
            </c:when>
            <c:otherwise>
              <a class="nav-link" href="customer-login">
                <i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập
              </a>
            </c:otherwise>
          </c:choose>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Add padding to account for fixed navbar -->
<div style="padding-top: 80px;"></div>

<!-- Slide Banner -->
<section class="hero-section" id="home">
  <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
      <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
      <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"></button>
    </div>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <div style="background: linear-gradient(45deg, #667eea, #764ba2); height: 100%;"></div>
        <div class="carousel-caption">
          <h1 class="animate-fade-in">Siêu Sale 50%</h1>
          <p class="animate-fade-in">Khuyến mãi lớn nhất trong năm - Giảm giá tới 50% cho tất cả sản phẩm</p>
          <button class="btn btn-hero animate-fade-in" onclick="scrollToProducts()">
            <i class="bi bi-arrow-right me-2"></i>Mua ngay
          </button>
        </div>
      </div>
      <div class="carousel-item">
        <div style="background: linear-gradient(45deg, #ff6b6b, #ff8e8e); height: 100%;"></div>
        <div class="carousel-caption">
          <h1 class="animate-fade-in">Sản phẩm mới</h1>
          <p class="animate-fade-in">Khám phá bộ sưu tập mới nhất với nhiều ưu đãi hấp dẫn</p>
          <button class="btn btn-hero animate-fade-in" onclick="scrollToProducts()">
            <i class="bi bi-eye me-2"></i>Khám phá
          </button>
        </div>
      </div>
      <div class="carousel-item">
        <div style="background: linear-gradient(45deg, #4ecdc4, #44a08d); height: 100%;"></div>
        <div class="carousel-caption">
          <h1 class="animate-fade-in">Miễn phí vận chuyển</h1>
          <p class="animate-fade-in">Giao hàng miễn phí cho đơn hàng trên 500.000 VND</p>
          <button class="btn btn-hero animate-fade-in" onclick="scrollToProducts()">
            <i class="bi bi-truck me-2"></i>Đặt hàng
          </button>
        </div>
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>
  </div>
</section>

<!-- Category Section -->
<section class="category-section" id="categories">
  <div class="container">
    <h2 class="section-title">Danh mục sản phẩm</h2>
    <div class="row g-4">
      <div class="col-lg-2 col-md-4 col-sm-6">
        <div class="category-card" onclick="filterProducts('confectionery')">
          <span class="category-icon">🍬</span>
          <div class="category-name">Bánh kẹo</div>
        </div>
      </div>
      <div class="col-lg-2 col-md-4 col-sm-6">
        <div class="category-card" onclick="filterProducts('beverage')">
          <span class="category-icon">🥤</span>
          <div class="category-name">Đồ uống</div>
        </div>
      </div>
      <div class="col-lg-2 col-md-4 col-sm-6">
        <div class="category-card" onclick="filterProducts('noodles')">
          <span class="category-icon">🍜</span>
          <div class="category-name">Mì - Thực phẩm khô</div>
        </div>
      </div>
      <div class="col-lg-2 col-md-4 col-sm-6">
        <div class="category-card" onclick="filterProducts('cosmetics')">
          <span class="category-icon">🧴</span>
          <div class="category-name">Mỹ phẩm</div>
        </div>
      </div>
      <div class="col-lg-2 col-md-4 col-sm-6">
        <div class="category-card" onclick="filterProducts('housewares')">
          <span class="category-icon">🧻</span>
          <div class="category-name">Đồ gia dụng</div>
        </div>
      </div>
      <div class="col-lg-2 col-md-4 col-sm-6">
        <div class="category-card" onclick="filterProducts('all')">
          <span class="category-icon">🛍️</span>
          <div class="category-name">Tất cả</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Products Section -->
<section class="products-section" id="products">
  <div class="container">
    <h2 class="section-title">Sản phẩm nổi bật</h2>

    <div class="product-tabs">
      <button class="tab-btn active" onclick="showProducts('new')">Sản phẩm mới</button>
      <button class="tab-btn" onclick="showProducts('bestseller')">Bán chạy</button>
      <button class="tab-btn" onclick="showProducts('promotion')">Khuyến mãi</button>
    </div>

    <div class="row g-4" id="productsContainer">
      <c:choose>
        <c:when test="${not empty products}">
          <div class="row g-4">
            <c:forEach var="p" items="${products}">
              <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="card product-card">
                  <div class="product-image">
                    <img src="assets/img/product/${p.getImage()}"
                         width="230" height="250"
                         style="object-fit: contain;"
                         alt=""/>
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

    <div class="text-center mt-5">
      <button class="btn btn-primary btn-lg" onclick="loadMoreProducts()">
        <i class="bi bi-arrow-down me-2"></i>Xem thêm sản phẩm
      </button>
    </div>
  </div>
</section>

<!-- Special Event Section -->
<section class="event-section" id="promotions">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-lg-8">
        <div class="event-banner">
          <h2 class="event-title">🎉 Sự kiện đặc biệt tháng 7</h2>
          <p class="event-subtitle">Mua 2 tặng 1 - Áp dụng cho tất cả sản phẩm bánh kẹo và đồ uống</p>
          <button class="btn btn-event" onclick="scrollToProducts()">
            <i class="bi bi-gift me-2"></i>Tham gia ngay
          </button>
        </div>
      </div>
      <div class="col-lg-4">
        <div class="text-center">
          <div style="font-size: 6rem; animation: bounce 2s infinite;">🎁</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="footer" id="contact">
  <div class="container">
    <div class="row">
      <div class="col-lg-4 col-md-6">
        <h4 class="footer-title">
          <i class="bi bi-shop me-2"></i>Gian Hàng Online
        </h4>
        <p>Cửa hàng trực tuyến uy tín với hàng nghìn sản phẩm chất lượng cao, giá cả phải chăng.</p>
        <div class="social-icons">
          <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
          <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
          <a href="#" class="social-icon"><i class="bi bi-youtube"></i></a>
          <a href="#" class="social-icon"><i class="bi bi-twitter"></i></a>
        </div>
      </div>
      <div class="col-lg-2 col-md-3">
        <h5 class="footer-title">Liên kết</h5>
        <a href="#" class="footer-link">Trang chủ</a>
        <a href="#" class="footer-link">Sản phẩm</a>
        <a href="#" class="footer-link">Khuyến mãi</a>
        <a href="#" class="footer-link">Liên hệ</a>
      </div>
      <div class="col-lg-2 col-md-3">
        <h5 class="footer-title">Hỗ trợ</h5>
        <a href="#" class="footer-link">Chính sách đổi trả</a>
        <a href="#" class="footer-link">Hướng dẫn mua hàng</a>
        <a href="#" class="footer-link">Câu hỏi thường gặp</a>
        <a href="#" class="footer-link">Bảo hành</a>
      </div>
      <div class="col-lg-4 col-md-6">
        <h5 class="footer-title">Thông tin liên hệ</h5>
        <p><i class="bi bi-geo-alt me-2"></i>123 Đường ABC, Quận XYZ, TP.HCM</p>
        <p><i class="bi bi-telephone me-2"></i>+84 123 456 789</p>
        <p><i class="bi bi-envelope me-2"></i>info@gianhang.com</p>
        <p><i class="bi bi-clock me-2"></i>8:00 - 22:00 (Tất cả các ngày)</p>
      </div>
    </div>
    <div class="footer-bottom">
      <p>&copy; 2025 Gian Hàng Online. Tất cả quyền được bảo lưu.</p>
    </div>
  </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
  // Add some interactive features
  document.addEventListener('DOMContentLoaded', function() {
    // Add to cart button animation
    const addToCartButtons = document.querySelectorAll('.btn-add-cart');
    addToCartButtons.forEach(button => {
      button.addEventListener('click', function(e) {
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

    searchInput.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        searchForm.submit();
      }
    });
  });
</script>
</body>
</html>