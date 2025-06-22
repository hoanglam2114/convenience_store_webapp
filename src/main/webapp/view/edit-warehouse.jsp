<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/22/2025
  Time: 5:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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

    <title>Edit Warehouse</title>

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

                    <div class="row justify-content-center">
                        <div class="col-md-8 col-lg-6">
                            <div class="card shadow">
                                <div class="card-header bg-primary text-white">
                                    <h4 class="card-title mb-0">
                                        <i class="fas fa-warehouse me-2"></i>Edit Warehouse
                                    </h4>
                                </div>
                                <div class="card-body">
                                    <form action="edit-warehouse" method="post">
                                        <input type="hidden" name="warehouse_id" value="${warehouse.warehouseID}"/>

                                        <!-- Warehouse Name -->
                                        <div class="mb-3">
                                            <label for="name" class="form-label">
                                                Warehouse Name <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control" id="name" name="name" required
                                                   value="${warehouse.name}">
                                        </div>

                                        <!-- Address -->
                                        <div class="mb-3">
                                            <label for="address" class="form-label">
                                                Address <span class="text-danger">*</span>
                                            </label>
                                            <textarea class="form-control" id="address" name="address" rows="3"
                                                      required>${warehouse.address}</textarea>

                                        </div>

                                        <!-- Phone -->
                                        <div class="mb-3">
                                            <label for="phone" class="form-label">
                                                Phone <span class="text-danger">*</span>
                                            </label>
                                            <input type="tel" class="form-control" id="phone" name="phone" required
                                                   value="${warehouse.phone}">
                                        </div>

                                        <!-- Working Hours -->
                                        <div class="mb-3">
                                            <label for="workingHours" class="form-label">Working Hours</label>
                                            <input type="text" class="form-control" id="workingHours"
                                                   name="workingHours"
                                                   value="${warehouse.workingHours}">
                                        </div>
                                        <!-- Status -->
                                        <select name="status" class="form-select" required>
                                            <option value="ACTIVE" ${warehouse.status == 'ACTIVE' ? 'selected' : ''}>Đang hoạt động</option>
                                            <option value="MAINTENANCE" ${warehouse.status == 'MAINTENANCE' ? 'selected' : ''}>Bảo trì</option>
                                            <option value="CLOSED" ${warehouse.status == 'CLOSED' ? 'selected' : ''}>Đóng cửa</option>
                                        </select>

                                        <!-- Store Linked ID -->
                                        <div class="mb-3">
                                            <label for="storeLinkedID" class="form-label">Store Linked ID</label>
                                            <input type="number" class="form-control" id="storeLinkedID"
                                                   name="storeLinkedID"
                                                   value="${warehouse.storeLinkedID}" min="1">
                                        </div>

                                        <!-- Note -->
                                        <div class="mb-3">
                                            <label for="note" class="form-label">Note</label>
                                            <textarea class="form-control" id="note" name="note" rows="3"
                                                      >${warehouse.note}</textarea>
                                        </div>

                                        <!-- Submit Button -->
                                        <div class="d-grid gap-2">
                                            <button type="submit" class="btn btn-primary btn-lg">
                                                <i class="fas fa-plus me-2"></i>Confirm
                                            </button>
                                            <a href="list-warehouse" class="btn btn-secondary">Quay lại danh sách</a>
                                        </div>
                                    </form>
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
                            �
                            <script>
                                document.write(new Date().getFullYear());
                            </script>
                            , made with ?? by
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
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
</div>
<!-- / Layout wrapper -->

<!-- Core JS -->
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