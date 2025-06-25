<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.ShopAssignment, model.WarehouseAssignment" %>
<%
    Object assignment = request.getAttribute("assignment");
    String type = (String) request.getAttribute("type");
%>

<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="${pageContext.request.contextPath}/assets/"
      data-template="vertical-menu-template-free">

<head>
    <meta charset="UTF-8"/>
    <title>Chỉnh Sửa Phân Công</title>

    <!-- Sneat CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/core.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/theme-default.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/fonts/boxicons.css"/>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>
</head>

<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">

        <%@ include file="/common/site-bar.jsp" %>

        <div class="layout-page">
            <%@ include file="/common/nav-bar.jsp" %>

            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">

                    <!-- Page Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="fw-bold mb-0">
                            <span class="text-muted fw-light">Quản Lý / Phân Công /</span> Chỉnh Sửa Phân Công
                        </h4>
                        <a href="${pageContext.request.contextPath}/assignment-management" class="btn btn-outline-secondary">
                            <i class="bx bx-arrow-back"></i> Quay Lại
                        </a>
                    </div>

                    <!-- Edit Assignment Form -->
                    <div class="card">
                        <div class="card-body">
                            <form method="POST" action="${pageContext.request.contextPath}/assignment-management">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="assignmentId" value="${assignment.assignmentId}">
                                <input type="hidden" name="type" value="${type}">

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Tên nhân viên</label>
                                        <input type="text" class="form-control" value="${assignment.employeeName}" readonly>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">${type eq 'shop' ? 'Cửa hàng' : 'Kho hàng'}</label>
                                        <input type="text" class="form-control"
                                               value="${type eq 'shop' ? assignment.shopName : assignment.warehouseName}" readonly>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Vai trò</label>
                                        <select name="role" class="form-select" required>
                                            <option value="Manager" ${assignment.assignmentRole eq 'Manager' ? 'selected' : ''}>Quản lý</option>
                                            <option value="Staff" ${assignment.assignmentRole eq 'Staff' ? 'selected' : ''}>Nhân viên</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Trạng thái</label>
                                        <select name="isActive" class="form-select" required>
                                            <option value="true" ${assignment.active ? 'selected' : ''}>Đang hoạt động</option>
                                            <option value="false" ${!assignment.active ? 'selected' : ''}>Ngưng hoạt động</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Ngày kết thúc (tùy chọn)</label>
                                        <input type="date" name="endDate" class="form-control"
                                               value="<fmt:formatDate value='${assignment.endDate}' pattern='yyyy-MM-dd'/>">
                                    </div>
                                </div>

                                <div class="mt-4 text-end">
                                    <button type="reset" class="btn btn-outline-secondary">
                                        <i class="bx bx-reset me-1"></i> Làm Mới
                                    </button>
                                    <button type="submit" class="btn btn-success">
                                        <i class="bx bx-save me-1"></i> Cập Nhật
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>

                
            </div>
        </div>
    </div>
</div>

<!-- Sneat JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/helpers.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
