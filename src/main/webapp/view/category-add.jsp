<%-- 
    Document   : category-add.jsp
    Created on : Jun 5, 2025, 10:27:50 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Thêm loại sản phẩm</title>

        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />


        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />





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



                        <!-- Form Thêm loại sản phẩm mới -->

                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Thêm loại sản phẩm mới</h5>
                            <a href="ListCate" class="btn btn-info">
                                <i class="bx bx-arrow-back"></i> Trở về danh sách loại sản phẩm
                            </a>
                        </div>
                        <div class="card" style="padding: 20px">
                            <div class="card-body">
                                <form action="AddCate" method="POST">
                                    <div class="mb-3">
                                        <label for="cateName" class="form-label">Tên loại sản phẩm: <span class="text-danger">*</span></label>
                                        <input type="text" 
                                               class="form-control ${not empty error ? 'is-invalid' : ''}" 
                                               name="nameCate" placeholder="Nhập loại sản phẩm"
                                               value="${param.nameCate != null ? param.nameCate : ''}"
                                               required/>
                                        <c:if test="${not empty error}">
                                            <div class="invalid-feedback">
                                                ${error}
                                            </div>
                                        </c:if>
                                    </div>

                                    <button type="submit" class="btn btn-outline-info">
                                        <i class="bx bx-plus"></i> Thêm loại sản phẩm
                                    </button>
                                    <button type="reset" class="btn btn-outline-primary">
                                        <i class="bx bx-refresh"></i> Làm mới
                                    </button>
                                </form>
                            </div>
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
