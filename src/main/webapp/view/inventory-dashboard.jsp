<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %><%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/3/2025
  Time: 3:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .inventory-stats {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            color: white;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 8px;
            padding: 1rem;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .stat-label {
            font-size: 0.875rem;
            opacity: 0.9;
        }
        .alert-badge {
            position: relative;
            display: inline-block;
        }
        .alert-badge.critical::after {
            content: '';
            position: absolute;
            top: -2px;
            right: -2px;
            width: 8px;
            height: 8px;
            background: #ff4757;
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
            background: #ffa502;
            border-radius: 50%;
            animation: pulse 1.5s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.2); opacity: 0.7; }
            100% { transform: scale(1); opacity: 1; }
        }
        .inventory-filters {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid #e9ecef;
        }
        .stock-level-low {
            color: #dc3545;
            font-weight: 600;
        }
        .stock-level-medium {
            color: #fd7e14;
            font-weight: 600;
        }
        .stock-level-high {
            color: #198754;
            font-weight: 600;
        }
        .product-image {
            border-radius: 8px;
            border: 2px solid #e9ecef;
            transition: transform 0.2s;
        }
        .product-image:hover {
            transform: scale(1.05);
            border-color: #0d6efd;
        }
        .table-hover tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.05);
        }
        .action-buttons {
            gap: 0.5rem;
        }
        .btn-action {
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-action:hover {
            transform: translateY(-1px);
        }
        .inventory-header {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .quick-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        .export-section {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
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

                <!-- Import Product Modal -->
                <div class="modal fade" id="import-product" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Nhập sản phẩm vào kho</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Mã sản phẩm</label>
                                            <input type="text" class="form-control" placeholder="Nhập mã sản phẩm">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Số lượng nhập</label>
                                            <input type="number" class="form-control" placeholder="0">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Lô hàng</label>
                                            <input type="text" class="form-control" placeholder="Nhập số lô">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Ngày hết hạn</label>
                                            <input type="date" class="form-control">
                                        </div>
                                        <div class="col-12 mb-3">
                                            <label class="form-label">Ghi chú</label>
                                            <textarea class="form-control" rows="3" placeholder="Ghi chú thêm..."></textarea>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="button" class="btn btn-primary">Nhập kho</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Export Product Modal -->
                <div class="modal fade" id="export-product" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Xuất sản phẩm khỏi kho</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="mb-3">
                                        <label class="form-label">Mã sản phẩm</label>
                                        <input type="text" class="form-control" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Số lượng xuất</label>
                                        <input type="number" class="form-control" placeholder="0">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Lý do xuất</label>
                                        <select class="form-control">
                                            <option>Bán hàng</option>
                                            <option>Trả hàng</option>
                                            <option>Hư hỏng</option>
                                            <option>Hết hạn</option>
                                            <option>Khác</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Ghi chú</label>
                                        <textarea class="form-control" rows="2"></textarea>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="button" class="btn btn-warning">Xuất kho</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="content-page">
                    <div class="container-fluid">

                        <!-- Inventory Statistics -->
                        <div class="inventory-stats mt-2">
                            <div class="row">
                                <div class="col-lg-4 col-md-6 mb-2">
                                    <div class="stat-card">
                                        <div class="stat-number">${stats.totalProducts}</div>
                                        <div class="stat-label">Tổng sản phẩm</div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-6 mb-2">
                                    <div class="stat-card">
                                        <div class="stat-number">${stats.lowStock}</div>
                                        <div class="stat-label">Sắp hết hàng</div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-6 mb-2">
                                    <div class="stat-card">
                                        <div class="stat-number">${stats.outOfStock}</div>
                                        <div class="stat-label">Hết hàng</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Header Section -->
                        <div class="inventory-header">
                            <div class="d-flex flex-wrap align-items-center justify-content-between">
                                <div>
                                    <h4 class="mb-1">Quản Lý Kho Hàng</h4>
                                    <p class="text-muted mb-0">Theo dõi và quản lý tồn kho một cách hiệu quả</p>
                                </div>
                                <div class="quick-actions d-flex">
                                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#import-product">
                                        <i class="bx bx-import me-1"></i>Nhập kho
                                    </button>
                                    <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#export-product">
                                        <i class="bx bx-export me-1"></i>Xuất kho
                                    </button>
                                    <a href="listLogInventory" class="btn btn-info">
                                        <i class="bx bx-history me-1"></i>Lịch sử
                                    </a>
                                    <a href="addNewProduct" class="btn btn-primary">
                                        <i class="bx bx-plus me-1"></i>Thêm sản phẩm
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Export Section -->
                        <div class="export-section">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <h6 class="mb-1">Xuất báo cáo tồn kho</h6>
                                    <p class="text-muted mb-0">Tải xuống báo cáo chi tiết về tình trạng kho hàng</p>
                                </div>
                                <div class="col-md-4 text-end">
                                    <div class="btn-group" role="group">
                                        <button class="btn btn-outline-primary btn-sm">
                                            <i class="bx bx-file me-1"></i>Excel
                                        </button>
                                        <button class="btn btn-outline-primary btn-sm">
                                            <i class="bx bx-file-pdf me-1"></i>PDF
                                        </button>
                                        <button class="btn btn-outline-primary btn-sm">
                                            <i class="bx bx-printer me-1"></i>In
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Filters and Search -->
                        <div class="inventory-filters">
                            <form action="findProInInven" method="get" data-toggle="validator">
                                <div class="row align-items-end">
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Tìm kiếm sản phẩm</label>
                                        <input type="text" class="form-control" name="namePro"
                                               placeholder="Nhập tên hoặc mã sản phẩm..." value="${param.namePro}"/>
                                    </div>
                                    <div class="col-md-2 mb-3">
                                        <label class="form-label">Trạng thái</label>
                                        <select class="form-control" name="status">
                                            <option value="">Tất cả</option>
                                            <option value="in_stock">Còn hàng</option>
                                            <option value="low_stock">Sắp hết</option>
                                            <option value="out_of_stock">Hết hàng</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2 mb-3">
                                        <label class="form-label">Danh mục</label>
                                        <select class="form-control">
                                            <option value="">Tất cả</option>
                                            <option value="electronics">Điện tử</option>
                                            <option value="clothing">Thời trang</option>
                                            <option value="food">Thực phẩm</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2 mb-3">
                                        <label class="form-label">Sắp xếp</label>
                                        <select class="form-control">
                                            <option>Tên A-Z</option>
                                            <option>Tên Z-A</option>
                                            <option>Số lượng tăng</option>
                                            <option>Số lượng giảm</option>
                                            <option>Ngày cập nhật</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2 mb-3">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="bx bx-search me-1"></i>Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Inventory Table -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover mb-0">
                                                <thead class="table-light">
                                                <tr>
                                                    <th><input type="checkbox" class="form-check-input"></th>
                                                    <th>Lô hàng</th>
                                                    <th>Sản phẩm</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Số lượng</th>
                                                    <th>Trạng thái</th>
                                                    <th>Cập nhật cuối</th>
                                                    <th>Cảnh báo</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:if test="${empty inven}">
                                                    <tr>
                                                        <td colspan="9" class="text-center py-5">
                                                            <div class="text-muted">
                                                                <i class="bx bx-package" style="font-size: 3rem;"></i>
                                                                <p class="mt-2">Không tìm thấy sản phẩm nào</p>
                                                                <a href="addNewProduct" class="btn btn-primary btn-sm">
                                                                    <i class="bx bx-plus me-1"></i>Thêm sản phẩm mới
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                                <c:forEach items="${inven}" var="i">
                                                    <tr>
                                                        <td><input type="checkbox" class="form-check-input"></td>
                                                        <td>
                                                            <span class="badge bg-light text-dark">${i.product.batch}</span>
                                                        </td>
                                                        <td>
                                                            <img src="assets/images/product/${i.product.image}"
                                                                 class="product-image" width="60" height="60"
                                                                 alt="${i.product.name}"/>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <strong>${i.product.name}</strong>
                                                                <br><small class="text-muted">PID: ${i.product.id}</small>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${i.currentStock < 10}">
                                                                    <span class="stock-level-low">${i.currentStock}</span>
                                                                </c:when>
                                                                <c:when test="${i.currentStock < 50}">
                                                                    <span class="stock-level-medium">${i.currentStock}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="stock-level-high">${i.currentStock}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${i.inventoryStatus == 'Còn hàng'}">
                                                                    <span class="badge bg-success">Còn hàng</span>
                                                                </c:when>
                                                                <c:when test="${i.inventoryStatus == 'Sắp hết'}">
                                                                    <span class="badge bg-warning">Sắp hết</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-danger">Hết hàng</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <small class="text-muted">${i.lastRestockDate}</small>
                                                        </td>
                                                        <td>
                                                            <c:if test="${not empty i.alert}">
                                                                <c:choose>
                                                                    <c:when test="${i.alert.contains('Nguy hiểm')}">
                                                                        <span class="alert-badge critical">
                                                                            <i class="bx bx-error text-danger"></i>
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="alert-badge warning">
                                                                            <i class="bx bx-error-circle text-warning"></i>
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <small class="text-muted d-block">${i.alert}</small>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <div class="action-buttons">
                                                                <a href="importProduct?inventory_id=${i.inventoryID}"
                                                                   class="btn btn-success btn-sm btn-action"
                                                                   title="Nhập kho">
                                                                    <i class="bx bx-import"></i>
                                                                </a>
                                                                <a href="exportProduct?inventory_id=${i.inventoryID}"
                                                                   class="btn btn-warning btn-sm btn-action"
                                                                   title="Xuất kho">
                                                                    <i class="bx bx-export"></i>
                                                                </a>
                                                                <a href="editProduct?inventory_id=${i.inventoryID}"
                                                                   class="btn btn-primary btn-sm btn-action"
                                                                   title="Chỉnh sửa">
                                                                    <i class="bx bx-edit"></i>
                                                                </a>
                                                                <a href="#" onclick="confirmDelete(${i.inventoryID})"
                                                                   class="btn btn-danger btn-sm btn-action"
                                                                   title="Xóa">
                                                                    <i class="bx bx-trash"></i>
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                        <!-- Pagination -->
                                        <%
                                            String queryParams = "";
                                            if (request.getParameter("productName") != null) {
                                                queryParams += "&productName=" + URLEncoder.encode(request.getParameter("productName"), StandardCharsets.UTF_8);
                                            }
                                            if (request.getParameter("status") != null) {
                                                queryParams += "&status=" + URLEncoder.encode(request.getParameter("status"), StandardCharsets.UTF_8);
                                            }
                                            if (request.getParameter("sortBy") != null) {
                                                queryParams += "&sortBy=" + URLEncoder.encode(request.getParameter("sortBy"), StandardCharsets.UTF_8);
                                            }
                                        %>

                                        <nav aria-label="Page navigation" class="mt-4">
                                            <ul class="pagination justify-content-center">
                                                <!-- Nút Trước -->
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link" href="?page=${currentPage - 1}<%= queryParams %>">Trước</a>
                                                </li>

                                                <!-- Số trang -->
                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <a class="page-link" href="?page=${i}<%= queryParams %>">${i}</a>
                                                    </li>
                                                </c:forEach>

                                                <!-- Nút Sau -->
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link" href="?page=${currentPage + 1}<%= queryParams %>">Sau</a>
                                                </li>
                                            </ul>
                                        </nav>

                                    </div>
                                </div>
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
<c:if test="${not empty sessionScope.toastMessage}">
    <div id="toast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
        <div class="toast align-items-center text-white bg-danger border-0 show" role="alert">
            <div class="d-flex">
                <div class="toast-body">
                        ${sessionScope.toastMessage}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
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

<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->
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

<script>
    function confirmDelete(inventoryId) {
        if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi kho?')) {
            window.location.href = 'deleteFromInventory?inventory_id=' + inventoryId;
        }
    }

    // Initialize tooltips
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });

    // Select all checkbox functionality
    document.querySelector('thead input[type="checkbox"]').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('tbody input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });
</script>

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>