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
<div class="container mt-4">
    <div class="row">
        <div class="col-md-6">
            <img src="assets/img/product/${product.getImage()}" class="img-fluid rounded" alt="${product.name}">
        </div>
        <div class="col-md-6">
            <h2>${product.name}</h2>
            <p class="text-muted">Giá: <strong>${product.price} VND</strong></p>
            <p>description</p>
            <label for="btn-branch-link">Mua ngay tại</label>
            <a class="btn btn-outline-primary" href="retail-chain" id="btn-branch-link">
                <i class="bi bi-geo-alt me-1"></i>
            </a>
        </div>
    </div>
</div>
</body>
</html>