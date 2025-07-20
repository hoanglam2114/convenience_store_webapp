<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/16/2025
  Time: 8:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<div class="container my-5">
    <div class="row g-4">
        <div class="col-md-6">
            <div class="card shadow-sm border-0">
                <img src="assets/img/product/${product.getImage()}"
                     class="img-fluid rounded"
                     style="max-height: 400px; object-fit: contain;"
                     alt="${product.name}">
            </div>
        </div>
        <div class="col-md-6">
            <div class="card h-100 shadow-sm border-0 p-4">
                <h2 class="card-title mb-3">${product.name}</h2>
                <p class="text-muted mb-3">Giá:
                    <strong class="text-primary">
                        <c:choose>
                            <c:when test="${product.price != null}">
                                ${product.price} VND
                            </c:when>
                            <c:otherwise>
                                Liên hệ
                            </c:otherwise>
                        </c:choose>
                    </strong>
                </p>
                <p class="card-text">${product.description}</p>
                <div class="mt-auto">
                    <label for="btn-branch-link" class="form-label">Mua ngay tại</label>
                    <a class="btn btn-outline-primary" href="retail-chain" id="btn-branch-link">
                        <i class="bi bi-geo-alt me-1"></i> Cửa hàng
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer -->
<jsp:include page="/common/customer-footer.jsp"/>
<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>