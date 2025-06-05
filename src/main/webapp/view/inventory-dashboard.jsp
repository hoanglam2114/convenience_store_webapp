<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/3/2025
  Time: 3:30 PM
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
    <meta charset="UTF-8">
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>Inventory Dashboard</title>

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
                <div class="modal fade" id="new-order" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-body">
                                <div class="popup text-left">
                                    <h4 class="mb-3">New Order</h4>
                                    <div class="content create-workform bg-body">
                                        <div class="pb-3">
                                            <label class="mb-2">Email</label>
                                            <input type="text" class="form-control" placeholder="Enter Name or Email">
                                        </div>
                                        <div class="col-lg-12 mt-4">
                                            <div class="d-flex flex-wrap align-items-ceter justify-content-center">
                                                <div class="btn btn-primary mr-4" data-dismiss="modal">Cancel</div>
                                                <div class="btn btn-outline-primary" data-dismiss="modal">Create</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content-page">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="d-flex flex-wrap flex-wrap align-items-center justify-content-between mb-4">
                                    <div>
                                        <h4 class="mb-3">Kho</h4>
                                    </div>
                                    <a href="listLogInventory" class="btn btn-primary add-list"><i class="ri-eye-line"></i>Lịch sử nhập/xuất kho</a>
                                    <a href="addNewProduct" class="btn btn-primary add-list"><i class="las la-plus mr-3"></i>Nhập sản phẩm mới vào kho</a>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="table-responsive rounded mb-3">
                                    <form action="findProInInven" method="get" data-toggle="validator">
                                        <div class="mb-3 d-flex justify-content-end">
                                            <input type="text" class="form-control" name="namePro" placeholder="Tìm kiếm sản phẩm theo tên" style="max-width: 300px;" />
                                            <button type="submit" class="btn btn-primary mr-2">Tìm kiếm</button>
                                            <a href="listInventory" class="btn btn-primary add-list"><i class="ri-eye-line"></i>Xem toàn bộ kho</a>
                                        </div>
                                    </form>
                                    <table class="table mb-0 tbl-server-info">
                                        <thead class="bg-white text-uppercase">
                                        <tr class="ligth ligth-data">
                                            <th>Lô</th>
                                            <th>Sản phẩm</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Số lượng</th>
                                            <th>Trạng thái</th>
                                            <th>Lần cuối cập nhập</th>
                                            <th>Cảnh báo</th>
                                            <th>Chức năng khác</th>
                                        </tr>
                                        </thead>
                                        <tbody class="ligth-body">
                                        <c:if test="${empty inven}">
                                            <tr>
                                                <td colspan="10" style="text-align: center;">Không tìm thấy sản phẩm.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${inven}" var="i">
                                            <tr>
                                                <td>${i.getProduct().getBatch()}</td>
                                                <td><img src="assets/images/product/${i.getProduct().getImage()}" width="80px" height="80px"/></td>
                                                <td>${i.getProduct().getName()}</td>
                                                <td>${i.getCurrentStock()}</td>
                                                <td>${i.getInventoryStatus()}</td>
                                                <td>${i.getLastRestockDate()}</td>
                                                <td>${i.getAlert()}</td>
                                                <td>
                                                    <div class="d-flex align-items-center list-action">
                                                        <a class="badge bg-success mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Nhập kho"
                                                           href="importProduct?inventory_id=${i.getId()}"><i class="ri-add-fill mr-0"></i></a>
                                                        <a class="badge bg-warning mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Xóa sản phẩm trong kho"
                                                           href="#" onclick="doDelete(${i.getId()})"><i class="ri-delete-bin-line mr-0"></i></a>
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
                    <!-- Modal Edit -->
                    <div class="modal fade" id="edit-note" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-body">
                                    <div class="popup text-left">
                                        <div class="media align-items-top justify-content-between">
                                            <h3 class="mb-3">Product</h3>
                                            <div class="btn-cancel p-0" data-dismiss="modal"><i class="las la-times"></i></div>
                                        </div>
                                        <div class="content edit-notes">
                                            <div class="card card-transparent card-block card-stretch event-note mb-0">
                                                <div class="card-body px-0 bukmark">
                                                    <div class="d-flex align-items-center justify-content-between pb-2 mb-3 border-bottom">
                                                        <div class="quill-tool">
                                                        </div>
                                                    </div>
                                                    <div id="quill-toolbar1">
                                                        <p>Virtual Digital Marketing Course every week on Monday, Wednesday and Saturday.Virtual Digital Marketing Course every week on Monday</p>
                                                    </div>
                                                </div>
                                                <div class="card-footer border-0">
                                                    <div class="d-flex flex-wrap align-items-ceter justify-content-end">
                                                        <div class="btn btn-primary mr-3" data-dismiss="modal">Cancel</div>
                                                        <div class="btn btn-outline-primary" data-dismiss="modal">Save</div>
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
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
    <div class="layout-overlay layout-menu-toggle"></div>
</div>
<!-- / Layout wrapper -->

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