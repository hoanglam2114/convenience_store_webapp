<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">

    <head>
        <meta charset="UTF-8" />
        <title>Danh sách thay đổi giá</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />
        <!-- Font and icon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Bạn có muốn xóa lịch sử thay đổi sản phẩm có mã là " + id + " không ?")) {
                    window.location = "DeleteHistory?history_id=" + id;
                }
            }
        </script>

    </head>

    <body>
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">

                <!-- Sidebar -->
                <%@ include file="/common/site-bar.jsp" %>
                <!-- Layout page -->
                <div class="layout-page" >
                    <!-- Navbar -->
                    <%@ include file="/common/nav-bar.jsp" %>
                    <!-- / Navbar -->

                    <div class="container-xxl flex-grow-1 container-p-y">

                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Lịch sử thay đổi giá của sản phẩm</h5>
                                <a href="ListProduct" class="btn btn-info text-white">
                                    <i class="bx bx-arrow-back"></i> Trở về danh sách sản phẩm
                                </a>
                            </div>

                            <div class="table-responsive text-nowrap">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Tên Sản Phẩm</th>
                                            <th>Giá Mới</th>
                                            <th>Giá Cũ</th>
                                            <th>Lần Cuối Cập Nhật</th>
                                            <th>Trạng Thái</th>
                                            <th>Xóa Lịch Sử Thay Đổi</th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-border-bottom-0">
                                        <c:forEach items="${history}" var="h">
                                            <tr>
                                                <td>${h.getProduct().getName()}</td>
                                                <td>${h.getPrice()}</td>
                                                <td>${h.getPriceBefore()}</td>
                                                <td>${h.getUpdatedAt()}</td>
                                                <td>${h.getStatus()}</td>
                                                <td>
                                                    <div class="d-flex align-items-center list-action">
                                                        <a data-bs-toggle="tooltip" data-bs-placement="top" title="Xóa sản phẩm"
                                                           href="#" onclick="doDelete(${h.getHistoryId()})" class="btn btn-sm btn-danger rounded-pill" >
                                                            <i class="bx bx-trash"></i>
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
                    <!-- /Layout page -->

                </div>
                <!-- /Layout container -->
            </div>
            <!-- /Layout wrapper -->      





            <!-- Sneat JS -->
            <script src="assets/vendor/libs/jquery/jquery.js"></script>
            <script src="assets/vendor/js/bootstrap.js"></script>
            <script src="assets/vendor/js/menu.js"></script>
            <script src="assets/vendor/js/helpers.js"></script>
            <script src="assets/js/config.js"></script>
            <script src="assets/js/main.js"></script> <!-- Quan trọng -->

    </body>

</html>

