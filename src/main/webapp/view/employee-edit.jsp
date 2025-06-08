<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Chỉnh Sửa Thông Tin Nhân Viên</title>

        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
        
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <!-- Page header -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="fw-bold mb-0">
                                    <span class="text-muted fw-light">Quản Lý / Quản Lý Nhân Viên /</span> Chỉnh Sửa Thông Tin Nhân Viên
                                </h4>
                                <a href="listEmployee" class="btn btn-outline-secondary">
                                    <i class="bx bx-arrow-back"></i> Quay Lại
                                </a>
                            </div>

                            <!-- Edit Staff Form -->
                            <div class="card">
                                <div class="card-body">
                                    <form method="POST" action="editStaff">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label for="ID" class="form-label">Mã</label>
                                                <input type="text" id="id" name="id" class="form-control" value="<%= request.getParameter("id") %>" readonly>
                                            </div>  

                                            <div class="col-md-6">
                                                <label for="Name" class="form-label">Tên</label>
                                                <input type="text" id="name" name="name" class="form-control" value="${employee.name}" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="Phone" class="form-label">Số Điện Thoại</label>
                                                <input type="text" id="phone" name="phone" class="form-control" value="${employee.phone}" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="Address" class="form-label">Địa Chỉ</label>
                                                <input type="text" id="address" name="address" class="form-control" value="${employee.address}" required>
                                            </div>

                                            <!--                    <div class="col-md-6">
                                                                  <label for="status" class="form-label">Status</label>
                                                                  <select id="status" name="status" class="form-select">
                                                                    <option value="active" selected>Active</option>
                                                                    <option value="inactive">Inactive</option>
                                                                  </select>
                                                                </div>-->

                                            <div class="col-12 text-end">
                                                <button type="reset" class="btn btn-outline-secondary">Làm Mới</button>
                                                <button type="submit" class="btn btn-success">
                                                    <i class="bx bx-save me-1"></i> Cập Nhật
                                                </button>
                                            </div>

                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Footer -->
                        <footer class="content-footer footer bg-footer-theme mt-4">
                            <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                                <div class="mb-2 mb-md-0">© 2025, Sneat Admin Template</div>
                            </div>
                        </footer>
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
