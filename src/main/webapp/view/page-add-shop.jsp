<%-- 
    Document   : AddUnit
    Created on : Jun 3, 2025, 3:59:29 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Thêm cửa hàng</title>
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
                    <h5  class="mb-0 font-size: 3rem;">Thêm cửa hàng</h5>
                    <a href="ListShop" class="btn btn-info text-white">
                        <i class="bx bx-left-arrow"></i> Trở về danh sách cửa hàng
                    </a>
                </div>


                <div class="card " style="padding: 20px">

                    <form action="AddShop" method="post" enctype="multipart/form-data">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Tên cửa hàng *</label>
                                <input type="text"
                                       class="form-control ${not empty errorStoreName ? 'is-invalid' : ''}"
                                       placeholder="Nhập tên cửa hàng"
                                       name="storeName"
                                       value="${param.storeName != null ? param.storeName : ''}" required />

                                <c:if test="${not empty errorStoreName}">
                                    <div class="invalid-feedback">
                                            ${errorStoreName}
                                    </div>
                                </c:if>


                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Địa chỉ cửa hàng *</label>
                                <input type="text" class="form-control ${not empty errorStoreAddress ? 'is-invalid' : ''}"
                                       placeholder="Nhập địa chỉ cửa hàng"
                                       name="storeAddress"
                                       value="${param.storeAddress != null ? param.storeAddress : ''}" required />
                                <c:if test="${not empty errorStoreAddress }">
                                    <div class="invalid-feedback">
                                            ${errorStoreAddress }
                                    </div>
                                </c:if>

                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại cửa hàng *</label>
                                <input type="text" class="form-control ${not empty errorStorePhone ? 'is-invalid' : ''}"
                                       placeholder="Nhập số điện thoại"
                                       name="storePhone"
                                       value="${param.storePhone != null ? param.storePhone : ''}" required />
                                <c:if test="${not empty errorStorePhone}">
                                    <div class="invalid-feedback">
                                            ${errorStorePhone}
                                    </div>
                                </c:if>

                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email *</label>
                                <input type="email" class="form-control ${not empty errorStoreEmail ? 'is-invalid' : ''}"
                                       placeholder="Nhập email"
                                       name="storeEmail"
                                       value="${param.storeEmail != null ? param.storeEmail : ''}" required />
                                <c:if test="${not empty errorStoreEmail}">
                                    <div class="invalid-feedback">
                                            ${errorStoreEmail}
                                    </div>
                                </c:if>


                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Giờ hoạt động *</label>
                                <input type="text" class="form-control ${not empty errorStoreHours ? 'is-invalid' : ''}"
                                       placeholder="Nhập thời gian hoạt động"
                                       name="storeHours"
                                       value="${param.storeHours != null ? param.storeHours : ''}" required />
                                <c:if test="${not empty errorStoreHours}">
                                    <div class="invalid-feedback">
                                            ${errorStoreHours}
                                    </div>
                                </c:if>

                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Hình ảnh *</label>
                                <input type="file" class="form-control" name="storeImage" accept="image/*" />
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary">Thêm cửa hàng</button>
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
<script src="assets/vendor/js/helpers.js"></script>
<script src="assets/js/config.js"></script>
<script src="assets/js/main.js"></script> <!-- Quan trọng -->



</body>
</html>