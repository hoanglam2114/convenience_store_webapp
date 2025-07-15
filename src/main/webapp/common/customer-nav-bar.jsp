<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/11/2025
  Time: 5:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                <li class="nav-item d-none" id="loginSection">
                    <a class="nav-link btn btn-outline-primary ms-2" href="customer-login">
                        <i class="bi bi-person me-1"></i>Đăng nhập
                    </a>
                </li>

                <!-- Logged in state -->
                <li class="nav-item dropdown" id="userSection">
                    <c:choose>
                        <c:when test="${not empty sessionScope.customer}">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <div class="user-info">
                                    <div class="user-avatar">
                                        <c:choose>
                                            <c:when test="${customer.avatarUrl != null}">
                                                <img src="uploads/${customer.avatarUrl}" alt="Avatar">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-person-fill"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
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