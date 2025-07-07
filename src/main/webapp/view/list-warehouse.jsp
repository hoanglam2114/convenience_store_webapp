<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/21/2025
  Time: 9:39 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.WarehouseStatus" %>
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
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>Warehouses</title>

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

    <!-- Bootstrap 5 CSS (Enhanced) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Page CSS -->
    <style>
        .menu-inner .menu-link {
            text-decoration: none !important;
        }

        .warehouse-card {
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
        }

        .warehouse-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .status-badge {
            font-size: 0.75rem;
            padding: 0.35rem 0.7rem;
            border-radius: 20px;
            font-weight: 600;
        }

        .detail-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-left: 4px solid var(--bs-primary);
            border-radius: 0 0 12px 12px;
            margin-top: -1px;
        }

        .action-buttons .btn {
            margin: 0.125rem;
            border-radius: 8px;
        }

        .manager-info {
            background: rgba(var(--bs-primary-rgb), 0.1);
            border-radius: 12px;
            padding: 1rem;
            border: 1px solid rgba(var(--bs-primary-rgb), 0.2);
        }

        .no-manager {
            background: rgba(var(--bs-secondary-rgb), 0.1);
            border-radius: 12px;
            padding: 1rem;
            border: 1px solid rgba(var(--bs-secondary-rgb), 0.2);
            color: var(--bs-secondary);
        }

        .fade-in {
            animation: fadeIn 0.4s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-15px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header-section {
            background: linear-gradient(135deg, var(--bs-primary) 0%, #0056b3 100%);
            border-radius: 16px;
            color: white;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .search-section {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }

        .warehouse-grid {
            gap: 1.5rem;
        }

        .card-header {
            background: transparent;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            padding: 1.25rem;
        }

        .btn-group-status .btn {
            border-radius: 6px;
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
        }

        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 0.75rem;
        }

        .info-item i {
            width: 20px;
            margin-right: 0.5rem;
            color: var(--bs-primary);
        }
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
                <!-- Content -->
                <div class="container-xxl flex-grow-1 container-p-y">

                    <!-- Header Section -->
                    <div class="header-section">
                        <div class="d-flex justify-content-between align-items-center flex-wrap">
                            <div>
                                <h2 class="mb-2 text-white"><i class="bi bi-building me-2"></i>Quản lý kho</h2>
                                <p class="mb-0 opacity-75">Danh sách và quản lý các kho hàng trong hệ thống</p>
                            </div>
                            <div class="d-flex gap-2">
                                <button class="btn btn-warning" data-bs-toggle="modal"
                                        data-bs-target="#addWarehouseModal">
                                    <a href="add-warehouse" class="btn btn-warning">
                                        <i class="bi bi-plus-lg me-1"></i> Thêm kho mới
                                    </a>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Search Section -->
                    <form id="filterForm" method="get" action="list-warehouse">
                        <div class="search-section">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="input-group">
                                    <span class="input-group-text bg-light border-0">
                                        <i class="bi bi-search text-muted"></i>
                                    </span>
                                        <input name="search" type="text" class="form-control border-0 bg-light"
                                               placeholder="Tìm kiếm theo tên kho." value="${param.search}"
                                               onkeydown="if(event.key === 'Enter') this.form.submit();">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <select name="status" class="form-select border-0 bg-light"
                                            onchange="document.getElementById('filterForm').submit();">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="ACTIVE">Hoạt động</option>
                                        <option value="MAINTENANCE">Bảo trì</option>
                                        <option value="CLOSED">Đóng cửa</option>
                                    </select>

                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-primary me-2"
                                            onclick="window.location.href='list-warehouse'">
                                        <i class="bi bi-arrow-counterclockwise"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>

                    <!-- Warehouse Cards Grid -->
                    <div class="row warehouse-grid" id="warehouseContainer">
                        <c:forEach var="w" items="${list}" varStatus="status">
                            <div class="col-12 mb-4">
                                <div class="card warehouse-card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center">
                                            <h6 class="card-title mb-0 fw-bold me-3">${w.name}</h6>
                                            <c:choose>
                                                <c:when test="${w.status == WarehouseStatus.ACTIVE}">
                                                    <span class="badge bg-success status-badge">Hoạt động</span>
                                                </c:when>
                                                <c:when test="${w.status.name() == WarehouseStatus.MAINTENANCE}">
                                                    <span class="badge bg-warning status-badge">Bảo trì</span>
                                                </c:when>
                                                <c:when test="${w.status.name() == WarehouseStatus.CLOSED}">
                                                    <span class="badge bg-info status-badge">Đóng cửa</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary status-badge">${w.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="d-flex align-items-center gap-2">
                                            <button class="btn btn-primary btn-sm"
                                                    onclick="toggleDetailsAndRedirect(${w.warehouseID})">
                                                Quản lý hàng
                                            </button>
                                            <button class="btn btn-outline-primary btn-sm"
                                                    onclick="toggleDetails(${w.warehouseID})">
                                                <i class="bi bi-eye me-1" id="detailIcon${w.warehouseID}"></i> Chi tiết
                                            </button>
                                            <div class="action-buttons">
                                                <button class="btn btn-outline-success btn-sm"
                                                        title="Chỉnh sửa"
                                                        onclick="editWarehouse(${w.warehouseID})">
                                                    <i class="bi bi-pencil"></i>
                                                </button>
                                                <button class="btn btn-outline-danger btn-sm"
                                                        title="Xóa"
                                                        onclick="deleteWarehouse(${w.warehouseID})">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="info-item">
                                                    <i class="bi bi-geo-alt-fill"></i>
                                                    <div>
                                                        <small class="text-muted d-block">Địa chỉ:</small>
                                                        <span>${w.address}</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="info-item">
                                                    <i class="bi bi-telephone-fill"></i>
                                                    <div>
                                                        <small class="text-muted d-block">Liên hệ:</small>
                                                        <span>${w.phone}</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="info-item">
                                                    <i class="bi bi-clock-fill"></i>
                                                    <div>
                                                        <small class="text-muted d-block">Giờ hoạt động:</small>
                                                        <span>${w.workingHours}</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <c:if test="${not empty w.note}">
                                                    <div class="info-item">
                                                        <i class="bi bi-sticky-fill"></i>
                                                        <div>
                                                            <small class="text-muted d-block">Ghi chú:</small>
                                                            <span class="text-truncate">${w.note}</span>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Detail Card (Initially Hidden) -->
                                    <div class="detail-section" id="details${w.warehouseID}" style="display: none;">
                                        <div class="detail-card fade-in p-4">
                                            <h6 class="mb-3 fw-bold">
                                                <i class="bi bi-info-circle me-2"></i>Thông tin chi tiết
                                            </h6>

                                            <!-- Manager Info -->
                                            <c:choose>
                                                <c:when test="${not empty w.managerID && w.managerID > 0}">
                                                    <div class="manager-info mb-3">
                                                        <h6 class="mb-2 fw-semibold">
                                                            <i class="bi bi-person-badge me-1"></i>Quản lý kho
                                                        </h6>
                                                        <div class="d-flex align-items-center justify-content-between">
                                                            <div>
                                                                <strong>Quản lý: ${w.managerName}</strong>
                                                                <small class="text-muted ms-1">(${w.managerID})</small>
                                                                <small class="text-muted">
                                                                    <i class="bi bi-telephone me-1"></i>Liên hệ qua hệ
                                                                    thống
                                                                </small>
                                                            </div>
                                                            <a href="assignment-management"
                                                               class="btn btn-primary btn-sm"> <i
                                                                    class="bi bi-person-plus me-1"></i>Thay Đổi</a>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-manager mb-3">
                                                        <div class="d-flex align-items-center justify-content-between">
                                                            <div>
                                                                <h6 class="mb-1"><i class="bi bi-person-x me-1"></i>Chưa
                                                                    có quản lý</h6>
                                                                <small>Kho này chưa được phân công quản lý</small>
                                                            </div>
                                                            <a href="assignment-management"
                                                               class="btn btn-primary btn-sm"> <i
                                                                    class="bi bi-person-plus me-1"></i>Phân công</a>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <!-- Store Link -->
                                            <div class="mb-3">
                                                <h6 class="mb-2 fw-semibold">
                                                    <i class="bi bi-shop me-1"></i>Cửa hàng liên kết
                                                </h6>
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <c:choose>
                                                        <c:when test="${not empty w.storeLinkedID && w.storeLinkedID > 0}">
            <span class="badge bg-info fs-6">
                Liên kết: ${w.storeName}
            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Chưa liên kết cửa hàng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                            </div>

                                            <!-- Status Controls -->
                                            <div class="mb-3">
                                                <h6 class="mb-2 fw-semibold">
                                                    <i class="bi bi-gear me-1"></i>Điều khiển trạng thái
                                                </h6>
                                                <button class="btn ${w.status.name() == 'ACTIVE' ? 'btn-success' : 'btn-outline-success'} btn-sm"
                                                        onclick="updateStatus(${w.warehouseID}, '${w.name}', 'ACTIVE')">
                                                    <i class="bi bi-check-circle me-1"></i>Hoạt động
                                                </button>
                                                <button class="btn ${w.status.name() == 'MAINTENANCE' ? 'btn-warning' : 'btn-outline-warning'} btn-sm"
                                                        onclick="updateStatus(${w.warehouseID}, '${w.name}', 'MAINTENANCE')">
                                                    <i class="bi bi-pause-circle me-1"></i>Bảo Trì
                                                </button>
                                                <button class="btn ${w.status.name() == 'CLOSED' ? 'btn-info' : 'btn-outline-info'} btn-sm"
                                                        onclick="updateStatus(${w.warehouseID}, '${w.name}', 'CLOSED')">
                                                    <i class="bi bi-wrench me-1"></i>Đóng cửa
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <div class="d-flex justify-content-between align-items-center mt-4">
                            <!-- Page Info -->
                            <div class="text-muted">
                                <small>
                                    Trang ${currentPage} của ${totalPages}
                                    <c:if test="${not empty list}">
                                        <!-- Option 1: Show total items if you pass it from controller -->
                                        <c:if test="${not empty totalItems}">
                                            (${totalItems} kho)
                                        </c:if>
                                        <!-- Option 2: Just show that there are items -->
                                        <c:if test="${empty totalItems}">
                                            (có kho)
                                        </c:if>
                                    </c:if>
                                </small>
                            </div>

                            <!-- Pagination -->
                            <nav aria-label="Warehouse pagination">
                                <ul class="pagination mb-0">
                                    <!-- Previous Button -->
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage - 1}&search=${param.search}&status=${param.status}">
                                                <i class="bi bi-chevron-left"></i>
                                            </a>
                                        </li>
                                    </c:if>

                                    <!-- Show limited page numbers for better UX -->
                                    <c:choose>
                                        <c:when test="${totalPages <= 7}">
                                            <!-- Show all pages if total is 7 or less -->
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="?page=${i}&search=${param.search}&status=${param.status}">
                                                            ${i}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Show limited pages with ellipsis -->
                                            <c:choose>
                                                <c:when test="${currentPage <= 4}">
                                                    <!-- Show first 5 pages + ellipsis + last page -->
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link" href="?page=${i}&search=${param.search}&status=${param.status}">
                                                                    ${i}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                    <li class="page-item">
                                                        <a class="page-link" href="?page=${totalPages}&search=${param.search}&status=${param.status}">
                                                                ${totalPages}
                                                        </a>
                                                    </li>
                                                </c:when>
                                                <c:when test="${currentPage >= totalPages - 3}">
                                                    <!-- Show first page + ellipsis + last 5 pages -->
                                                    <li class="page-item">
                                                        <a class="page-link" href="?page=1&search=${param.search}&status=${param.status}">
                                                            1
                                                        </a>
                                                    </li>
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                    <c:forEach begin="${totalPages - 4}" end="${totalPages}" var="i">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link" href="?page=${i}&search=${param.search}&status=${param.status}">
                                                                    ${i}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- Show first page + ellipsis + current-1, current, current+1 + ellipsis + last page -->
                                                    <li class="page-item">
                                                        <a class="page-link" href="?page=1&search=${param.search}&status=${param.status}">
                                                            1
                                                        </a>
                                                    </li>
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                    <c:forEach begin="${currentPage - 1}" end="${currentPage + 1}" var="i">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link" href="?page=${i}&search=${param.search}&status=${param.status}">
                                                                    ${i}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                    <li class="page-item disabled">
                                                        <span class="page-link">...</span>
                                                    </li>
                                                    <li class="page-item">
                                                        <a class="page-link" href="?page=${totalPages}&search=${param.search}&status=${param.status}">
                                                                ${totalPages}
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- Next Button -->
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}&search=${param.search}&status=${param.status}">
                                                <i class="bi bi-chevron-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </div>

                    <!-- Empty State -->
                    <c:if test="${empty list}">
                        <div class="text-center py-5">
                            <div class="mb-4">
                                <i class="bi bi-building text-muted" style="font-size: 4rem;"></i>
                            </div>
                            <h4 class="text-muted">Chưa có kho nào</h4>
                            <p class="text-muted">Bấm nút "Thêm kho mới" để tạo kho đầu tiên</p>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addWarehouseModal">
                                <i class="bi bi-plus-lg me-2"></i>Thêm kho mới
                            </button>
                        </div>
                    </c:if>
                </div>

                <!-- / Content -->

                <!-- Footer -->
                <footer class="content-footer footer bg-footer-theme">
                    <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                        <div class="mb-2 mb-md-0">
                            ©
                            <script>
                                document.write(new Date().getFullYear());
                            </script>
                            , made by CONVEMA
                        </div>
                    </div>
                </footer>
                <!-- / Footer -->

                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
</div>
<!-- / Layout wrapper -->

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Core JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/popper/popper.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>

<!-- Vendors JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/apex-charts/apexcharts.js"></script>

<!-- Main JS -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/dashboards-analytics.js"></script>

<!-- Custom JavaScript -->
<script>
    // Toggle detail sections
    function toggleDetails(warehouseId) {
        const detailSection = document.getElementById('details' + warehouseId);
        const icon = document.getElementById('detailIcon' + warehouseId);

        if (detailSection.style.display === 'none' || detailSection.style.display === '') {
            detailSection.style.display = 'block';
            detailSection.classList.add('fade-in');
            icon.className = 'bi bi-eye-slash me-1';
        } else {
            detailSection.style.display = 'none';
            icon.className = 'bi bi-eye me-1';
        }
    }

    function toggleDetailsAndRedirect(warehouseID) {
        toggleDetails(warehouseID);
        setTimeout(() => {
            window.location.href = `inventory?warehouse_id=` + warehouseID;
        });
    }

    // Edit warehouse
    function editWarehouse(warehouseID) {
        alert('Chỉnh sửa kho ID: ' + warehouseID);
        toggleDetails(warehouseID);
        setTimeout(() => {
            window.location.href = `edit-warehouse?warehouse_id=` + warehouseID;
        });
    }

    function updateStatus(warehouseID, warehouseName, newStatus) {
        const confirmed = confirm("Bạn có chắc chắn muốn cập nhật trạng thái của kho '" + warehouseName + "' sang '" + newStatus + "'?");
        if (confirmed) {
            window.location.href = "update-warehouse-status?warehouse_id=" + warehouseID + "&status=" + newStatus;
        }
    }

    // Delete warehouse
    function deleteWarehouse(warehouseID) {
        if (confirm("Bạn có chắc chắn muốn xóa kho '" + warehouseID + "' không ?")) {
            alert('Xóa kho ID: ' + warehouseID);
            setTimeout(() => {
                window.location.href = `delete-warehouse?warehouse_id=` + warehouseID;
            });
        }
    }

    // Status filter functionality
    document.getElementById('statusFilter').addEventListener('change', function () {
        const selectedStatus = this.value.toLowerCase();
        const warehouseCards = document.querySelectorAll('.warehouse-card');

        warehouseCards.forEach(function (card) {
            const statusBadge = card.querySelector('.status-badge');
            const cardContainer = card.closest('.col-lg-6');

            if (selectedStatus === '' || statusBadge.textContent.toLowerCase().includes(selectedStatus)) {
                cardContainer.style.display = 'block';
            } else {
                cardContainer.style.display = 'none';
            }
        });
    });
</script>

<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>