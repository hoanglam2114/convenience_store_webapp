<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Cửa Hàng - Sneat Template</title>
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
                border-radius: 0.75rem;
                padding: 2rem;
                background-color: #fff;
                box-shadow: 0 0.5rem 1rem rgba(67,89,113,0.1);
                animation: fadeIn 0.7s ease-in-out;
            }
            .section-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #566a7f;
                margin-bottom: 1.5rem;
                border-bottom: 2px solid #d9dee3;
                padding-bottom: 0.5rem;
            }
            .shop-image {
                width: 100%;
                height: auto;
                border-radius: 0.75rem;
                transition: transform 0.3s ease;
            }
            .shop-image:hover {
                transform: scale(1.03);
            }
            .info-label {
                font-weight: 600;
                color: #3e4854;
                margin-bottom: 4px;
            }
            .info-value {
                color: #6f6b7d;
                padding: 0.35rem 0.75rem;
                background-color: #f7f8f9;
                border-radius: 0.5rem;
                box-shadow: inset 0 1px 2px rgba(0,0,0,0.03);
                transition: background-color 0.3s;
            }
            .info-value:hover {
                background-color: #f0f2f4;
            }
            .map-container {
                margin-top: 2rem;
                border-radius: 0.75rem;
                overflow: hidden;
                box-shadow: 0 0 0.75rem rgba(0,0,0,0.05);
            }
            iframe {
                width: 100%;
                height: 400px;
                border: none;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
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



                        <div class="card card-custom">
                            <div class="section-title">Chi Tiết Cửa Hàng</div>

                            <div class="row g-4">
                                <div class="col-md-8">
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="info-label">Tên cửa hàng:</div>
                                            <div class="info-value">${Shop.shopName}</div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="info-label">Địa chỉ:</div>
                                            <div class="info-value">${Shop.shopAddress}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="info-label">Số điện thoại:</div>
                                            <div class="info-value">${Shop.shopPhone}</div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="info-label">Email:</div>
                                            <div class="info-value">${Shop.shopEmail}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="info-label">Thời gian hoạt động:</div>
                                            <div class="info-value">${Shop.shopOpeningHours}</div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="info-label">Trạng thái:</div>
                                            <div class="info-value text-success">Đang hoạt động</div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <h5 class="card-title mt-4">Danh sách nhân sự đang hoạt động tại cửa hàng</h5>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Tên nhân viên</th>
                                            <th>Vai trò</th>
                                            <th>Điện thoại</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="assignment" items="${assignments}">

                                            <tr>
                                                <td>${assignment.employeeName}</td>
                                                <td>
                                                    <span class="badge bg-${assignment.assignmentRole == 'Quản lý' || assignment.assignmentRole == 'Manager' ? 'danger' : 'primary'}">
                                                        ${assignment.assignmentRole}
                                                    </span>
                                                </td>

                                                <td>${assignment.employeePhone}</td>
                                            </tr>

                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="map-container mt-4">
                                <iframe src="${Shop.map}" width="600" height="400"></iframe>
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
