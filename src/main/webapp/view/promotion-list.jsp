<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh Sách Khuyến Mãi - Sneat Style</title>
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
            .card {
                border-radius: 10px;
                box-shadow: 0 0.25rem 1rem rgba(0, 0, 0, 0.05);
                animation: fadeIn 1s ease-in-out;
            }
            .form-control, .form-select {
                border-radius: 0.5rem;
                transition: border-color 0.3s ease;
            }
            .form-control:focus, .form-select:focus {
                border-color: #3f51b5;
                box-shadow: 0 0 5px rgba(63, 81, 181, 0.2);
            }
            .table th {
                background-color: #f2f4f7;
                font-weight: 600;
            }
            .badge-inactive {
                background-color: #fbc02d;
                color: #fff;
                font-size: 0.8rem;
            }
            .btn-action {
                margin: 0 3px;
                transition: transform 0.2s;
            }
            .btn-action:hover {
                transform: scale(1.1);
            }
            tr {
                transition: background-color 0.3s ease;
            }
            tr:hover {
                background-color: #f0f9ff;
            }
            @keyframes fadeIn {
                0% {
                    opacity: 0;
                    transform: translateY(20px);
                }
                100% {
                    opacity: 1;
                    transform: translateY(0);
                }
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


                        <div class="container py-5">
                            <div class="card p-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="mb-0">Danh Sách Khuyến Mãi</h4>
                                    <a href="AddPromotion" class="btn btn-primary" "><i class="fas fa-plus"></i> Thêm Khuyến Mãi</a>
                                </div>
                                <div class="row mb-4">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-body">
                                                <form method="post" action="PromotionManage" class="row">
                                                    <div class="col-md-2">
                                                        <input  type="text" class="form-control"
                                                               value="${promotionCode}"
                                                               name="promotionCode"
                                                               placeholder="Tìm theo mã">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <input type="text" class="form-control" 
                                                               value="${description}"
                                                               name="description"
                                                               placeholder="Mô tả">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <select class="form-select" name="promotionStatus">
                                                            <option value="All Status" ${"All Status".equals(promotionStatus) ? "selected" : ""}>All Status</option>
                                                            <c:forEach items="${statuses}" var="status">
                                                                <option value="${status}" ${status.equals(promotionStatus) ? "selected" : ""}>${status}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <input type="date" class="form-control" value="${startDate}"
                                                               name="startDate">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <input type="date" class="form-control" value="${endDate}"
                                                               name="endDate">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <input style="width: 150px" type="number" class="form-control" 
                                                               value="${discountAmount}"
                                                               name="discountAmount"
                                                               placeholder="% Khuyển mãi">
                                                    </div>
                                                    <div class="col-md-3 d-flex gap-1">
                                                        <button style="width: 150px" type="submit" class="btn btn-info ">Tìm</button>
                                                        <a style="width: 200px" href="PromotionManage" class="btn btn-outline-secondary ">Làm mới</a>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-bordered align-middle">
                                        <thead>
                                            <tr>
                                                <th>Mã</th>
                                                <th>Mô tả</th>
                                                <th>Ngày bắt đầu</th>
                                                <th>Ngày kết thúc</th>
                                                <th>Giảm (%)</th>
                                                <th>Trạng thái</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${ListPromotion}" var="promotion">
                                                <tr>
                                                    <td>${promotion.promotion_name}</td>
                                                    <td>${promotion.description}</td>
                                                    <td>${promotion.start_date}</td>
                                                    <td>${promotion.end_date}</td>
                                                    <td>${promotion.discount_value}</td>
                                                    <td>
                                                        <c:set var="statusClass" value="${promotion.status == 'Active' ? 'bg-info' : 'bg-danger'}" />
                                                        <span class="badge ${statusClass}">${promotion.status}</span>
                                                    </td>
                                                    <td>
                                                        <a class="btn btn-sm btn-info btn-action"
                                                             href="UpdatePromotion?id=${promotion.promotion_id}"><i class="fas fa-edit"></i></a>
                                                        <button class="btn btn-sm btn-danger btn-action"><i class="fas fa-trash-alt"></i></button>
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
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
