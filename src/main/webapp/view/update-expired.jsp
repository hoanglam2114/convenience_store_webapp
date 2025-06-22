<%-- 
    Document   : UpdateUnit
    Created on : Jun 3, 2025, 11:20:03 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Cập nhật đơn vị</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />
        <!-- Font and icon -->
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





                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0 font-size: 3rem;">Cập nhật giá sản phẩm sắp hết hạn</h5>
                            <a href="ProductDiscount" class="btn btn-info text-white">
                                <i class="bx bx-left-arrow"></i> Trở về danh sách sản phẩm
                            </a>
                        </div>


                        <div class="card " style="padding: 20px">
                            <c:set value="${productExpired}" var="pe"/>
                            <form action="UpdateProductExpired" method="post">
                                <!-- Hidden ID nếu cần -->
                                <input type="hidden" name="idPro" value="${pe.getId()}" />

                                <div class="row">
                                    <!-- Tên sản phẩm -->
                                    <div class="col-md-6 mb-3">
                                        <label for="productName" class="form-label">Tên *</label>
                                        <input type="text"  name="productName" 
                                               class="form-control" 
                                               value="${pe.getName()}" 
                                               readonly />
                                    </div>

                                    <!-- Giảm giá (%) -->
                                    <div class="col-md-6 mb-3">
                                        <label for="discountPercent" class="form-label">Giảm giá (%)</label>
                                        <input type="number"  name="discount" 
                                               class="form-control" 
                                               placeholder="Nhập % giảm giá" 
                                               min="0" max="100" required />
                                    </div>
                                </div>

                                <div class="d-flex justify-content-start">
                                    <button type="submit" class="btn btn-primary">
                                        Cập nhật
                                    </button>
                                </div>
                            </form>


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

