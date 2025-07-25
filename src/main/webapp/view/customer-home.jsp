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
<html
        lang="en"
        class="light-style layout-menu-fixed"
        dir="ltr"
        data-theme="theme-default"
        data-assets-path="/assets/"
        data-template="vertical-menu-template-free"
>
<%
    request.setAttribute("pageTitle", "Convema");
%>
<jsp:include page="/common/header.jsp"/>
<jsp:include page="/common/customer-nav-bar.jsp"/>
<body>
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
                    <h1 class="animate-fade-in">Sản phẩm bán chạy</h1>
                    <p class="animate-fade-in">Sản phẩm bán chạy như "tôm tươi", được cực kỳ nhiều người lựa chọn</p>
                    <button class="btn btn-hero animate-fade-in" onclick="scrollToProducts()">
                        <i class="bi bi-eye me-2"></i>Khám phá
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

<!-- Products Section -->
<section class="products-section" id="products">
    <div class="container">
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
                                        <a href="customer-product-detail?id=${p.id}"
                                           class="btn btn-outline-primary btn-sm">
                                            <i class="bi bi-eye me-1"></i> Xem chi tiết
                                        </a>
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

<!-- Footer -->
<jsp:include page="/common/customer-footer.jsp"/>
<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
    // Add some interactive features
    document.addEventListener('DOMContentLoaded', function () {
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