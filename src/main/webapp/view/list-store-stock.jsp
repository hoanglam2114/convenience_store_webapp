<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/8/2025
  Time: 10:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>Store List</title>

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

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

    <!-- Page CSS -->
    <style>
        .enhanced-card {
            border: none;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .enhanced-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .gradient-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 12px 12px 0 0;
            padding: 1.5rem;
        }

        .search-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .product-image-enhanced {
            border-radius: 8px;
            transition: transform 0.2s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .product-image-enhanced:hover {
            transform: scale(1.05);
        }

        .table-enhanced {
            border-radius: 8px;
            overflow: hidden;
        }

        .table-enhanced thead th {
            background: linear-gradient(135deg, #495057 0%, #6c757d 100%);
            color: white !important;
            font-weight: 600;
            border: none;
            padding: 1rem 0.75rem;
        }

        .table-enhanced tbody tr {
            transition: all 0.2s ease;
        }

        .table-enhanced tbody tr:hover {
            background-color: #f8f9fa;
        }

        .action-btn {
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
            text-decoration: none;
            margin: 0 2px;
        }

        .action-btn:hover {
            transform: scale(1.1);
        }

        .stock-badge {
            font-size: 0.875rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
        }

        .alert-indicator {
            padding: 0.375rem 0.75rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .price-display {
            font-weight: 600;
            font-size: 1.1rem;
        }

        .btn-enhanced {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
        }

        .btn-enhanced:hover {
            transform: translateY(-1px);
        }
    </style>

    <!-- Helpers -->
    <script src="${pageContext.request.contextPath}/assets/vendor/js/helpers.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
    <script type="text/javascript">
        function doDelete(id) {
            if (confirm("Bạn có muốn xóa sản phẩm này không ?")) {
                window.location = "delete-store-stock?store_stock_id=" + id;
            }
        }
    </script>
</head>
<body>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <!-- Site Bar -->
        <%@ include file="/common/site-bar.jsp" %>

        <!-- Layout Page -->
        <div class="layout-page">
            <!-- Navbar -->
            <%@ include file="/common/nav-bar.jsp" %>

            <!-- Content Wrapper -->
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">

                    <!-- New Order Modal -->
                    <div class="modal fade" id="new-order" tabindex="-1" aria-labelledby="newOrderModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content enhanced-card">
                                <div class="modal-header gradient-header">
                                    <h5 class="modal-title" id="newOrderModalLabel">
                                        <i class="bi bi-plus-circle me-2"></i>New Order
                                    </h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form>
                                        <div class="mb-3">
                                            <label for="orderEmail" class="form-label fw-semibold">
                                                <i class="bi bi-envelope me-2"></i>Email
                                            </label>
                                            <input type="email" class="form-control" id="orderEmail"
                                                   placeholder="Enter Name or Email">
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel
                                    </button>
                                    <button type="button" class="btn btn-primary">Create</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="content-page">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <div>
                                            <h4 class="mb-0 fw-bold">
                                                <i class="bi bi-boxes me-2 text-primary"></i>Sản phẩm cửa hàng
                                            </h4>
                                            <p class="text-muted mb-0 mt-1">Quản lý tồn kho sản phẩm tại cửa hàng</p>
                                        </div>
                                        <a href="export-new-to-store" class="btn btn-primary btn-enhanced">
                                            <i class="bi bi-plus-circle me-2"></i>
                                            Nhập sản phẩm mới lên cửa hàng
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- Search Section -->
                            <div class="search-section">
                                <form action="find-product-store" method="get" data-toggle="validator">
                                    <div class="row align-items-end">
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold mb-2">
                                                <i class="bi bi-search me-2"></i>Tìm kiếm sản phẩm
                                            </label>
                                            <input type="text" class="form-control" name="namePro"
                                                   placeholder="Nhập tên sản phẩm để tìm kiếm..."
                                                   style="border-radius: 8px; padding: 0.75rem;"/>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="d-flex gap-2">
                                                <button type="submit" class="btn btn-primary btn-enhanced">
                                                    <i class="bi bi-search me-2"></i>Tìm kiếm
                                                </button>
                                                <a href="list-store-stock" class="btn btn-outline-primary btn-enhanced">
                                                    <i class="bi bi-arrow-clockwise"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <!-- Products Table -->
                            <div class="col-lg-12">
                                <div class="enhanced-card">
                                    <div class="gradient-header">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h5 class="mb-0">
                                                <i class="bi bi-list-ul me-2"></i>Danh sách sản phẩm
                                            </h5>
                                            <span class="badge bg-light text-dark">
                                                <c:choose>
                                                    <c:when test="${not empty store}">
                                                        ${store.size()} sản phẩm
                                                    </c:when>
                                                    <c:otherwise>
                                                        0 sản phẩm
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-enhanced mb-0">
                                            <thead>
                                            <tr>
                                                <th><i class="bi bi-tag me-1"></i>Lô</th>
                                                <th><i class="bi bi-image me-1"></i>Sản phẩm</th>
                                                <th><i class="bi bi-box me-1"></i>Tên sản phẩm</th>
                                                <th><i class="bi bi-hash me-1"></i>Số lượng</th>
                                                <th><i class="bi bi-currency-dollar me-1"></i>Giá bán</th>
                                                <th><i class="bi bi-exclamation-triangle me-1"></i>Cảnh báo</th>
                                                <th><i class="bi bi-gear me-1"></i>Chức năng khác</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:if test="${empty store}">
                                                <tr>
                                                    <td colspan="7" class="text-center py-5">
                                                        <div class="text-muted">
                                                            <i class="bi bi-inbox display-4 d-block mb-3 text-muted"></i>
                                                            <h5>Không tìm thấy sản phẩm</h5>
                                                            <p class="mb-0">Hiện tại không có sản phẩm nào trong cửa
                                                                hàng</p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:if>
                                            <c:forEach items="${store}" var="s">
                                                <tr>
                                                    <td>
                                                            <span class="fw-semibold text-primary">
                                                                    ${s.getInventory().getProduct().getBatch()}
                                                            </span>
                                                    </td>
                                                    <td>
                                                        <img src="assets/img/product/${s.getInventory().getProduct().getImage()}"
                                                             class="product-image-enhanced"
                                                             width="60" height="60"
                                                             alt="Product"/>
                                                    </td>
                                                    <td>
                                                        <div class="fw-semibold">
                                                                ${s.getInventory().getProduct().getName()}
                                                        </div>
                                                    </td>
                                                    <td>
                                                            <span class="stock-badge bg-info text-white">
                                                                    ${s.getStock()}
                                                            </span>
                                                    </td>
                                                    <td>
                                                        <div class="price-display text-success">
                                                            <c:choose>
                                                                <c:when test="${s.getDiscount()== null}">
                                                                    ${s.getInventory().getProduct().getPrice()} VND
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="text-decoration-line-through text-muted small">
                                                                            ${s.getInventory().getProduct().getPrice()}
                                                                    </div>
                                                                    ${s.getDiscount().getPriceSell()} VND
                                                                    <span class="badge bg-danger ms-1">Sale</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${s.getStock() <= 10}">
                                                                    <span class="alert-indicator bg-danger text-white">
                                                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                                                        ${s.getAlert()}
                                                                    </span>
                                                            </c:when>
                                                            <c:when test="${s.getStock() <= 20}">
                                                                    <span class="alert-indicator bg-warning text-dark">
                                                                        <i class="bi bi-exclamation-circle me-1"></i>
                                                                        ${s.getAlert()}
                                                                    </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                    <span class="alert-indicator bg-success text-white">
                                                                        <i class="bi bi-check-circle me-1"></i>
                                                                        Tốt
                                                                    </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <a class="action-btn bg-success text-white"
                                                               data-toggle="tooltip"
                                                               data-placement="top"
                                                               title="Nhập số lượng từ kho"
                                                               href="export-old-batch?store_stock_id=${s.getStoreStockId()}">
                                                                <i class="bi bi-plus-lg"></i>
                                                            </a>
                                                            <a class="action-btn bg-warning text-white"
                                                               data-toggle="tooltip"
                                                               data-placement="top"
                                                               title="Xóa sản phẩm ở cửa hàng"
                                                               href="#" onclick="doDelete(${s.getStoreStockId()})">
                                                                <i class="bi bi-trash"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Page end  -->
                    </div>

                    <!-- Modal Edit -->
                    <div class="modal fade" id="edit-note" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content enhanced-card">
                                <div class="modal-body">
                                    <div class="popup text-left">
                                        <div class="media align-items-top justify-content-between mb-4">
                                            <h3 class="mb-3">
                                                <i class="bi bi-pencil-square me-2 text-primary"></i>Product
                                            </h3>
                                            <div class="btn-cancel p-0" data-dismiss="modal">
                                                <i class="las la-times"></i>
                                            </div>
                                        </div>
                                        <div class="content edit-notes">
                                            <div class="card card-transparent card-block card-stretch event-note mb-0">
                                                <div class="card-body px-0 bukmark">
                                                    <div class="d-flex align-items-center justify-content-between pb-2 mb-3 border-bottom">
                                                        <div class="quill-tool">
                                                        </div>
                                                    </div>
                                                    <div id="quill-toolbar1">
                                                        <p>Virtual Digital Marketing Course every week on Monday,
                                                            Wednesday and
                                                            Saturday.Virtual Digital Marketing Course every week on
                                                            Monday</p>
                                                    </div>
                                                </div>
                                                <div class="card-footer border-0">
                                                    <div class="d-flex flex-wrap align-items-ceter justify-content-end">
                                                        <div class="btn btn-primary mr-3" data-dismiss="modal">
                                                            Cancel
                                                        </div>
                                                        <div class="btn btn-outline-primary" data-dismiss="modal">
                                                            Save
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
            , made with ❤️ by
            <a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
        </div>
        <div>
            <a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a>
            <a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More
                Themes</a>

            <a
                    href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/"
                    target="_blank"
                    class="footer-link me-4"
            >Documentation</a
            >

            <a
                    href="https://github.com/themeselection/sneat-html-admin-template-free/issues"
                    target="_blank"
                    class="footer-link me-4"
            >Support</a
            >
        </div>
    </div>
</footer>
<!-- / Footer -->

<div class="content-backdrop fade"></div>
<!-- Content wrapper -->
<!-- / Layout page -->

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
<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>