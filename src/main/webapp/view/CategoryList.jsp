<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi" class="light-style layout-navbar-fixed" dir="ltr"
      data-theme="theme-default" data-assets-path="../assets/" data-template="vertical-menu-template-free">

    <head>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách loại sản phẩm</title>

        <!-- Sneat core CSS -->

        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />


        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
    </head>

    <body>
        <div class="layout-wrapper layout-content-navbar">

            <div class="layout-container">

                <!-- Sidebar -->
                <%@ include file="/common/site-bar.jsp" %>

                <!-- Layout page -->
                <div class="layout-page">

                    <!-- Navbar -->
                    <%@ include file="/common/nav-bar.jsp" %>
                    <!-- / Navbar -->

                    <div class="content-wrapper">

                        <div class="container-xxl flex-grow-1 container-p-y">

                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <h4 class="fw-bold">Danh sách loại sản phẩm</h4>
                                    <p class="mb-0 text-muted">

                                    </p>
                                </div>
                                <a href="AddCate" class="btn btn-primary">
                                    <i  class="bx bx-plus me-1"></i> Thêm loại sản phẩm
                                </a>
                            </div>

                            <div class="row mb-3">
                                <form action="FindCate" method="get">
                                    <div class="d-flex  align-items-center gap-1 mb-2"> 
                                        <input style="width: 300px;"  type="text" class="form-control" name="nameCate" placeholder="Tìm kiếm loại sản phẩm theo tên">
                                        <button  type="submit" class="btn btn-outline-primary"><i class="bx bx-search"></i> Tìm kiếm</button>
                                        <a  href="ListCate" class="btn btn-outline-info">
                                            <i class="bx bx-show"></i> Xem toàn bộ loại sản phẩm</a>
                                    </div>



                                </form>

                            </div>

                            <div class="card">
                                <div class="table-responsive text-nowrap">
                                    <table class="table">
                                        <thead class="table-light text-center">
                                            <tr>
                                                <th>Mã</th>
                                                <th>Loại Sản Phẩm</th>
                                                <th>Chức Năng Khác</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <c:forEach items="${list}" var="c">
                                                <tr>
                                                    <td>${c.getId()}</td>
                                                    <td class="text-center">${c.getName()}</td>
                                                    <td>
                                                        <a href="UpdateCate?cateId=${c.getId()}" class="btn btn-icon btn-success me-2">
                                                            <i class="bx bx-edit"></i></a>

                                                        <a href="#" class="btn btn-icon btn-danger">
                                                            <i class="bx bx-trash"></i></a>
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
                                        <a class="page-link" href="ListCate?index=${currentPage - 1}">Previous</a>
                                    </div>

                                    <c:forEach begin="1" end="${endPage}" var="i">
                                        <div class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="ListCate?index=${i}">${i}</a>
                                        </div>
                                    </c:forEach>

                                    <div class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                                        <a class="page-link" href="ListCate?index=${currentPage + 1}">Next</a>
                                    </div>
                                </div>

                            </footer>
                            <!-- /Footer -->
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
    </body>

</html>
