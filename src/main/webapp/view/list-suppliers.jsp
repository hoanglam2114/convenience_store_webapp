<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/8/2025
  Time: 7:45 PM
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

    <title>Supplier</title>

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
            if (confirm("Bạn có muốn xóa nhà cung cấp có mã là " + id + " không ?")) {
                window.location = "delete-supplier?supplier_id=" + id;
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

                    <!-- Main Content -->
                    <div class="content-page">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="d-flex flex-wrap flex-wrap align-items-center justify-content-between mb-4">
                                        <div>
                                            <h4 class="mb-3">Danh sách nhà cung cấp</h4>
                                            <p class="mb-0">Danh sách nhà cung cấp là tập hợp thông tin về các đơn vị
                                                hoặc cá nhân cung cấp hàng hóa, <br>dịch vụ cho doanh nghiệp.</p>
                                        </div>
                                        <a href="add-supplier" class="btn btn-primary add-list"><i
                                                class="las la-plus mr-3"></i>Thêm nhà cung cấp</a>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="table-responsive rounded mb-3">
                                        <form action="find-supplier" method="get" data-toggle="validator">
                                            <div class="mb-3 d-flex justify-content-end">
                                                <input type="text" class="form-control" name="nameSup"
                                                       placeholder="Tìm kiếm nhà cung cấp theo tên"
                                                       style="max-width: 300px;"/>
                                                <button type="submit" class="btn btn-primary mr-2">Tìm kiếm</button>
                                                <a href="list-supplier" class="btn btn-outline-primary btn-enhanced">
                                                    <i class="bi bi-arrow-clockwise"></i>
                                                </a>
                                                <c:if test="${not empty message}">
                                                    <div class="alert alert-danger">
                                                            ${message}
                                                    </div>
                                                </c:if>
                                            </div>
                                        </form>
                                        <table class="table mb-0 tbl-server-info">
                                            <thead class="bg-white text-uppercase">
                                            <tr class="ligth ligth-data">
                                                <th>Mã</th>
                                                <th>Nhà cung cấp</th>
                                                <th>Tên nhà cung cấp</th>
                                                <th>Địa chỉ</th>
                                                <th>Số điện thoại</th>
                                                <th>Email</th>
                                                <th>Người đại diện</th>
                                                <th>Chức năng khác</th>
                                            </tr>
                                            </thead>
                                            <tbody class="ligth-body">
                                            <c:forEach items="${supplier}" var="sup">
                                                <tr>
                                                    <td>${sup.getId()}</td>
                                                    <td><img src="assets/img/supplier/${sup.getImg()}" width="80px"
                                                             height="80px"/></td>
                                                    <td>${sup.getName()}</td>
                                                    <td>${sup.getAddress()}</td>
                                                    <td>${sup.getPhone()}</td>
                                                    <td>${sup.getEmail()}</td>
                                                    <td>${sup.getContact()}</td>
                                                    <td>
                                                        <div class="d-flex align-items-center gap-2">
                                                            <a class="btn btn-sm btn-success rounded-circle d-flex align-items-center justify-content-center"
                                                               data-bs-toggle="tooltip" data-bs-placement="top"
                                                               title="Chỉnh sửa nhà cung cấp"
                                                               href="update-supplier?supplier_id=${sup.getId()}">
                                                                <i class="bi bi-pencil-square"></i>
                                                            </a>

                                                            <a class="btn btn-sm btn-danger rounded-circle d-flex align-items-center justify-content-center"
                                                               data-bs-toggle="tooltip" data-bs-placement="top"
                                                               title="Xóa nhà cung cấp"
                                                               href="#" onclick="doDelete(${sup.getId()})">
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
                            <!-- Page end  -->
                        </div>
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