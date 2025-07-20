<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/16/2025
  Time: 7:53 PM
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
<!-- Add padding to account for fixed navbar -->
<body>
<div style="padding-top: 80px;"></div>
<div class="container my-4">
    <h3 class="mb-4 text-center">Kết quả tìm kiếm</h3>
    <div class="row g-4" id="productsContainer">
        <c:choose>
            <c:when test="${not empty products}">
                <div class="row g-4">
                    <c:forEach var="p" items="${products}">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="card product-card h-100 shadow-sm border-0">
                                <div class="product-image p-3 text-center">
                                    <img src="assets/img/product/${p.getImage()}"
                                         class="img-fluid"
                                         style="max-height: 250px; object-fit: contain;"
                                         alt="${fn:escapeXml(p.name)}"/>
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title text-truncate">${p.name}</h5>
                                    <div class="product-price text-primary fw-bold mt-auto">
                                        <c:choose>
                                            <c:when test="${p.price != null}">
                                                ${p.price} VND
                                            </c:when>
                                            <c:otherwise>
                                                Liên hệ
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <a href="customer-product-detail?id=${p.id}" class="btn btn-outline-primary btn-sm mt-2">
                                        <i class="bi bi-eye me-1"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state text-center py-5">
                    <i class="bi bi-box-seam display-4 text-muted"></i>
                    <h4 class="mt-3">Không tìm thấy sản phẩm</h4>
                    <p class="text-muted">Thử thay đổi từ khóa tìm kiếm hoặc danh mục khác</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Footer -->
<jsp:include page="/common/customer-footer.jsp"/>
<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>