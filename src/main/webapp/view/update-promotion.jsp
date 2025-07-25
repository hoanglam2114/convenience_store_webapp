<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập Nhật Khuyến Mãi</title>
        <link rel="stylesheet" href="https://demos.themeselection.com/sneat-bootstrap-html-admin-template/assets/vendor/css/core.css">
        <link rel="stylesheet" href="https://demos.themeselection.com/sneat-bootstrap-html-admin-template/assets/vendor/css/theme-default.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />

        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />
        <!-- Font and icon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />



        <style>
            body {
                font-family: 'Public Sans', sans-serif;
                background-color: #f5f5f9;
            }
            .card-custom {
                border-radius: 0.5rem;
                padding: 2rem;
                background-color: #fff;
                box-shadow: 0 2px 10px rgba(67,89,113,.1);
            }
            .form-control, .form-select {
                border-radius: 0.5rem;
                font-size: 0.95rem;
            }
            .btn-confirm {
                background-color: #03c3ec;
                border: none;
                border-radius: 0.5rem;
                padding: 0.5rem 1.25rem;
                font-weight: 500;
                color: white;
            }
            .title-header {
                font-weight: 600;
                font-size: 1.25rem;
                color: #566a7f;
                border-bottom: 1px solid #d9dee3;
                padding-bottom: 1rem;
                margin-bottom: 1.5rem;
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
                <div class="layout-page">
                    <!-- Navbar -->
                    <%@ include file="/common/nav-bar.jsp" %>
                    <!-- / Navbar -->


                    <!-- Main content -->
                    <div class="container-xxl flex-grow-1 container-p-y">

                        <div class="card card-custom">

                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="title-header">Cập nhật khuyến mãi</h5>
                                <a href="PromotionManage"  class="btn btn-info"><i class="bx bx-arrow-back me-1"></i>Trở về danh sách khuyến mãi</a>
                            </div>
                            <c:set var="p"   value="${promotion}" />
                            <form action="UpdatePromotion" method="post" class="row g-4">
                                <input type="hidden" name="promotionId" value="${p.promotion_id}" />
                                <div class="col-md-6">
                                    <label for="code" class="form-label">Mã</label>
                                    <input type="text"  class="form-control ${not empty errorCode ? 'is-invalid' : ''}"  
                                           name="code" value="${p.promotion_name}"
                                           placeholder="Enter code"
                                           value="${param.code != null ? param.code : ''}"
                                           />
                                    <c:if test="${not empty errorCode}">
                                        <div class="invalid-feedback">
                                            ${errorCode}
                                        </div>
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    <label for="description" class="form-label">Mô tả</label>
                                    <input type="text" class="form-control ${not empty errorDes ? 'is-invalid' : ''}"   
                                           name="description" value="${p.description}"
                                           value="${param.description != null ? param.description : ''}"
                                           />
                                    <c:if test="${not empty errorDes}">
                                        <div class="invalid-feedback">
                                            ${errorDes}
                                        </div>
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    <label for="startDate" class="form-label">Ngày bắt đầu</label>
                                    <input type="date" class="form-control" name="startDate" value="${p.start_date}">
                                </div>
                                <div class="col-md-6">
                                    <label for="endDate" class="form-label">Ngày kết thúc</label>
                                    <input type="date" class="form-control" name="endDate" value="${p.end_date}">
                                </div>
                                <div class="col-md-6">
                                    <label for="discount" class="form-label">Phần trăm khuyến mãi(%)</label>
                                    <input type="number" class="form-control" name="discountPercentage" value="${p.discount_value}"
                                           placeholder="Enter discount %" min="0" max="100" >
                                </div>
                                <div class="col-md-6">
                                    <label for="status" class="form-label">Trạng thái</label>
                                    <select class="form-select" name="status">
                                        <c:forEach items="${statuses}" var="status">
                                            <option value="${status}" ${status.equalsIgnoreCase(p.status) ? 'selected' : ''}>${status}</option>

                                        </c:forEach>
                                    </select>
                                </div>

                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger">
                                        ${errorMessage}
                                    </div>
                                </c:if>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-confirm">Cập Nhật</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>                        

        <!-- Sneat JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
        <script src="assets/js/main.js"></script> <!-- Quan trọng -->
    </body>
</html>
