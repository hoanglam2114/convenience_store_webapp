<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/21/2025
  Time: 2:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html
        lang="en"
        class="light-style layout-menu-fixed"
        dir="ltr"
        data-theme="theme-default"
        data-assets-path="/assets/"
        data-template="vertical-menu-template-free"
>
<head>
    <meta charset="UTF-8">
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>Inventory Management Dashboard</title>

    <meta name="description" content=""/>

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/fonts/boxicons.css"/>

    <!-- Core CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/core.css"
          class="template-customizer-core-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/theme-default.css"
          class="template-customizer-theme-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo.css"/>

    <!-- Vendors CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/libs/apex-charts/apex-charts.css"/>

    <!-- Page CSS -->
    <style>
        /* Bootstrap-focused custom styles */
        .inventory-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .alert-badge.critical::after {
            content: '';
            position: absolute;
            top: -2px;
            right: -2px;
            width: 8px;
            height: 8px;
            background: #dc3545;
            border-radius: 50%;
            animation: pulse 1.5s infinite;
        }

        .alert-badge.warning::after {
            content: '';
            position: absolute;
            top: -2px;
            right: -2px;
            width: 8px;
            height: 8px;
            background: #ffc107;
            border-radius: 50%;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.2); opacity: 0.7; }
            100% { transform: scale(1); opacity: 1; }
        }

        .stock-level-low { color: #dc3545; }
        .stock-level-medium { color: #fd7e14; }
        .stock-level-high { color: #198754; }
    </style>

    <!-- Helpers -->
    <script src="${pageContext.request.contextPath}/assets/vendor/js/helpers.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
</head>
<body>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">

        <!-- Site Bar -->
        <%@ include file="/common/site-bar.jsp" %>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar -->
            <%@ include file="/common/nav-bar.jsp" %>
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Page Header -->
                <div class="container-fluid">
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="card shadow-sm border-0">
                                <div class="card-header inventory-header border-0 rounded-top">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h3 class="card-title mb-1 text-white fw-bold">
                                                <i class="bx bx-package me-2"></i>
                                                Lô hàng cho sản phẩm: ${inventory.product.name}
                                            </h3>
                                            <p class="card-text mb-0 text-white-50">
                                                Quản lý thông tin các lô hàng
                                            </p>
                                        </div>
                                        <div>
                                            <a href="inventory?warehouse_id=${warehouseID}"
                                               class="btn btn-light btn-lg px-4">
                                                <i class="bx bx-arrow-back me-2"></i>
                                                Quay về kho
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Batch Table -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card shadow-sm border-0">
                                <div class="card-header bg-white border-bottom">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="card-title mb-0 fw-semibold">
                                            <i class="bx bx-list-ul me-2 text-primary"></i>
                                            Danh sách lô hàng
                                        </h5>
                                        <div class="d-flex gap-2">
<%--                                            <button class="btn btn-outline-primary btn-sm">--%>
<%--                                                <i class="bx bx-export me-1"></i>--%>
<%--                                                Xuất Excel--%>
<%--                                            </button>--%>
<%--                                            <button class="btn btn-primary btn-sm">--%>
<%--                                                <i class="bx bx-plus me-1"></i>--%>
<%--                                                Thêm lô hàng--%>
<%--                                            </button>--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-striped mb-0">
                                            <thead class="table-light">
                                            <tr>
                                                <th class="border-0 fw-semibold text-dark py-3 px-4">
                                                    <i class="bx bx-hash me-2"></i>
                                                    Lô hàng
                                                </th>
                                                <th class="border-0 fw-semibold text-dark py-3 px-4">
                                                    <i class="bx bx-package me-2"></i>
                                                    Số lượng
                                                </th>
                                                <th class="border-0 fw-semibold text-dark py-3 px-4">
                                                    <i class="bx bx-calendar me-2"></i>
                                                    Ngày nhập
                                                </th>
                                                <th class="border-0 fw-semibold text-dark py-3 px-4">
                                                    <i class="bx bx-note me-2"></i>
                                                    Ghi chú
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:if test="${empty batches}">
                                                <tr>
                                                    <td colspan="4" class="text-center py-5">
                                                        <div class="d-flex flex-column align-items-center">
                                                            <i class="bx bx-package display-1 text-muted mb-3"></i>
                                                            <h5 class="text-muted mb-2">Chưa có lô hàng nào</h5>
                                                            <p class="text-muted mb-0">
                                                                Hiện tại chưa có lô hàng nào được nhập cho sản phẩm này
                                                            </p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:if>
                                            <c:forEach items="${batches}" var="b" varStatus="status">
                                                <tr class="align-middle">
                                                    <td class="px-4 py-3">
                                                        <div class="d-flex align-items-center">
                                                            <div class="badge bg-primary-subtle text-primary rounded-pill me-2">
                                                                    ${status.index + 1}
                                                            </div>
                                                            <span class="fw-semibold">${b.batchId}</span>
                                                        </div>
                                                    </td>
                                                    <td class="px-4 py-3">
                                                        <div class="d-flex align-items-center">
                                                                <span class="badge bg-success-subtle text-success fs-6 px-3 py-2">
                                                                        ${b.quantity}
                                                                </span>
                                                        </div>
                                                    </td>
                                                    <td class="px-4 py-3">
                                                        <div class="d-flex align-items-center">
                                                            <i class="bx bx-calendar text-muted me-2"></i>
                                                            <span class="text-dark">${b.importDate}</span>
                                                        </div>
                                                    </td>
                                                    <td class="px-4 py-3">
                                                        <c:choose>
                                                            <c:when test="${not empty b.note}">
                                                                <span class="text-muted">${b.note}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted fst-italic">Không có ghi chú</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <!-- Table Footer with Pagination -->
                                <c:if test="${not empty batches}">
                                    <div class="card-footer bg-light border-top">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted">
                                                Hiển thị <strong>${batches.size()}</strong> lô hàng
                                            </small>
                                            <nav aria-label="Batch pagination">
                                                <ul class="pagination pagination-sm mb-0">
                                                    <li class="page-item disabled">
                                                        <span class="page-link">Trước</span>
                                                    </li>
                                                    <li class="page-item active">
                                                        <span class="page-link">1</span>
                                                    </li>
                                                    <li class="page-item disabled">
                                                        <span class="page-link">Sau</span>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
    <div class="layout-overlay layout-menu-toggle"></div>
</div>
<!-- / Layout wrapper -->

<!-- Toast Message -->
<c:if test="${not empty sessionScope.toastMessage}">
    <div id="toast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
        <div class="toast align-items-center text-white bg-danger border-0 show" role="alert">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="bx bx-error-circle me-2"></i>
                        ${sessionScope.toastMessage}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                        aria-label="Close"></button>
            </div>
        </div>
    </div>

    <script>
        // Auto hide sau 5 giây
        setTimeout(() => {
            const toast = document.getElementById('toast');
            if (toast) toast.remove();
        }, 5000);
    </script>

    <c:remove var="toastMessage" scope="session"/>
</c:if>

<!-- Scripts -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/popper/popper.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>
<!-- endbuild -->
<!-- Vendors JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/apex-charts/apexcharts.js"></script>
<!-- Main JS -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<!-- Page JS -->
<script src="${pageContext.request.contextPath}/assets/js/dashboards-analytics.js"></script>
</body>
</html>