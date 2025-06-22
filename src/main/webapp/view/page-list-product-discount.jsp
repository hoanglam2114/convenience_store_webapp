<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">

    <head>
        <meta charset="UTF-8" />
        <title>Danh sách sản phẩm giảm giá</title>
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
                        <h4 class="fw-bold py-3 mb-4">Danh sách sản phẩm giảm giá</h4>
                        <p class="mb-4">Danh sách sản phẩm giảm giá do hết hạn là tập hợp các mặt hàng được doanh nghiệp giảm giá vì sắp hoặc đã gần đến ngày hết hạn sử dụng.</p>

                        <div class="mb-3 d-flex justify-content-between align-items-center ">
                            <div class="card">
                                <div class="table-responsive text-nowrap">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Lô</th>
                                                <th>Barcode</th>
                                                <th>Sản Phẩm</th>
                                                <th>Tên Sản Phẩm</th>
                                                <th>Loại Sản Phẩm</th>
                                                <th>Giá Cũ</th>
                                                <th>Giá Sau Khi Giảm</th>
                                                <th>Nhãn Hàng</th>
                                                <th>Đơn Vị</th>
                                                <th>Ngày Hết Hạn</th>
                                                <th>Chức Năng Khác</th>
                                            </tr>
                                        </thead>
                                        <tbody class="table-border-bottom-0">   
                                            <c:forEach items="${productListExpired}" var="p">
                                                <tr>
                                                    <td>${p.batch}</td>
                                                    <td>${p.barcode}</td>
                                                    <td><img src="assets/img/product/${p.image}" width="80px" height="80px"/></td>
                                                    <td>${p.name}</td>
                                                    <td>${p.productCategories.name}</td>
                                                    <td>${p.price}</td>
                                                    <c:set var="found" value="false" />
                                                    <c:forEach items="${discountProductList}" var="disProduct">
                                                        <c:if test="${p.id eq disProduct.productId}">
                                                            <c:set var="found" value="true" />
                                                            <td>${disProduct.priceSell}</td>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${!found}">
                                                        <td></td>
                                                    </c:if>
                                                    <td>${p.suppliers.name}</td>
                                                    <td>${p.weightUnit.name}</td>
                                                    <td>${p.expirationDate}</td>
                                                    <td>
                                                        <a href="UpdateProductExpired?product_id=${p.getId()}" class="btn btn-sm btn-icon btn-outline-success">
                                                            <i class="bx bx-edit"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

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
