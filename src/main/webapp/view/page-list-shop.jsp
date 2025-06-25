<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">

    <head>
        <meta charset="UTF-8" />
        <title>Danh sách cửa hàng</title>
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
                if (confirm("Bạn có muốn xóa cửa hàng có mã là " + id + " không ?")) {
                    window.location = "DeleteShop?shop_id=" + id;
                }
            }
        </script>




        <style>
            .header-card {
                background: linear-gradient(90deg, #f78ed2, #a4d2f4);
                color: #fff;
                padding: 1.5rem;
                border-radius: 1rem;
                margin-bottom: 1.5rem;
            }
            .filter-section select, .filter-section button {
                margin-right: 10px;
            }
            .table thead {
                background-color: #e3f2fd;
            }
            .btn-view {
                background-color: #e3e3ff;
                color: #5a5aee;
            }
            .btn-delete {
                background-color: #ffe3e3;
                color: #ee5a5a;
            }
        </style>



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

                        <div class="header-card text-start">
                            <h4><i class="bi bi-person-lines-fill"></i> Quản Lý Cửa hàng</h4>
                            <p>Quản lý hệ thống siêu thị FPT trên toàn quốc</p>
                        </div>

                        <div class="mb-3 d-flex justify-content-between align-items-center ">

                            <div>
                                <a href="AddShop" class="btn btn-success">
                                    <i class="bx bx-plus "></i> Thêm cửa hàng
                                </a>
                            </div>

                            <div class="d-flex align-items-center  mb-2">
                                <form action="FindShop" class="d-flex align-items-center gap-1 w-100">

                                    <input type="text" class="form-control flex-grow-1"" name="nameShop" 
                                           placeholder="Tìm cửa hàng theo tên" />
                                    <button style="width: 150px" class=" btn btn-outline-primary" >tìm kiếm</button>
                                    <a href='ListShop' style="width: 150px" class=" btn btn-outline-primary" >làm mới </a>

                                </form>

                            </div>
                        </div>

                        <div class="card">
                            <div class="table-responsive text-nowrap">
                                <table class="table">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Tên Cửa Hàng</th>
                                            <th>Số Điện Thoại</th>
                                            <th>Địa Chỉ Cửa Hàng</th>
                                            <th>Email</th>
                                            <th>Thời gian hoạt động</th>
                                            <th>Ảnh Cửa Hàng</th>
                                            <th>Chức Năng</th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-border-bottom-0">
                                        <c:if test="${empty listshop}">
                                            <tr>
                                                <td colspan="10" style="text-align: center;">Không tìm thấy cửa hàng.</td>
                                            </tr>
                                        </c:if>
                                        
                                        <c:forEach items="${listshop}" var="s">
                                            <tr>
                                                <td>${s.getShopName()}</td>
                                                <td>${s.getShopPhone()}</td>
                                                <td>${s.getShopAddress()}</td>
                                                <td>${s.getShopEmail()}</td>
                                                <td>${s.getShopOpeningHours()}</td>
                                                <td>
                                                    <img src="assets/img/shop/${s.getShopLogo()}" width="80px" height="80px" />
                                                </td>
                                                <td>
                                                    <a href="UpdateShop?shop_id=${s.getShopId()}" class="btn btn-sm btn-info mb-1">Sửa</a><br />
                                                    <a href="#" onclick="doDelete(${s.getShopId()})" class="btn btn-sm btn-danger">Xóa</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Footer -->
                        <footer class="content-footer footer bg-footer-theme">
                            <div class="container-xxl d-flex justify-content-center py-3">
                                <div class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="ListShop?index=${currentPage - 1}">Previous</a>
                                </div>

                                <c:forEach begin="1" end="${endPage}" var="i">
                                    <div class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="ListShop?index=${i}">${i}</a>
                                    </div>
                                </c:forEach>

                                <div class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                                    <a class="page-link" href="ListShop?index=${currentPage + 1}">Next</a>
                                </div>
                            </div>

                        </footer>
                        <!-- /Footer -->
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
