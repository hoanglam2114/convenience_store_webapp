<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Thêm Nhân Viên</title>

        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
        
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="java.util.List" %>
    </head>

    <body>
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">

                <!-- Sidebar -->
                <%@ include file="/common/site-bar.jsp" %>

                <div class="layout-page">
                    <!-- Navbar -->
                    <nav class="layout-navbar">
                        <!-- Navbar n?u có -->
                    </nav>

                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">

                            <!-- Page title -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="fw-bold mb-0">
                                    <span class="text-muted fw-light">Quản Lý / Quản Lý Nhân Viên /</span> Thêm Nhân Viên Mới 
                                </h4>
                                <a href="listEmployee" class="btn btn-outline-secondary">
                                    <i class="bx bx-arrow-back"></i> Quay Lại
                                </a>
                            </div>

                            <!-- Card -->
                            <div class="card">
                                <div class="card-body">
                                    <form action="addEmployee" method="POST">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label" for="name">Tên</label>
                                                <input type="text" id="name" name="name" class="form-control" placeholder="Nguyen Van A" required />
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label" for="phone">Số Điện Thoại</label>
                                                <input type="text" id="phone" name="phone" class="form-control" placeholder="0123456789" required />
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label" for="address">Địa Chỉ</label>
                                                <input type="text" id="address" name="address" class="form-control" placeholder="Ha Noi" required />
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label" for="accountId">Mã Tài Khoản</label>
                                                <input type="number" id="accountId" name="accountId" class="form-control" placeholder="1" required />
                                            </div>

                                            <!--                    <div class="col-md-6">
                                                                  <label class="form-label" for="status">Status</label>
                                                                  <select id="status" name="status" class="form-select" required>
                                                                    <option value="active" selected>Active</option>
                                                                    <option value="inactive">Inactive</option>
                                                                  </select>
                                                                </div>-->

                                            <div class="col-12 text-end">
                                                <button type="reset" class="btn btn-outline-secondary">Làm Mới</button>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bx bx-save me-1"></i> Thêm
                                                </button>
                                            </div>

                                            <%
                                            List<String> errors = (List<String>) request.getAttribute("errors");
                                            if (errors != null && !errors.isEmpty()) {
                                            %>
                                            <div class="alert alert-danger" role="alert">
                                                <ul class="mb-0">
                                                    <% for (String err : errors) { %>
                                                    <li><%= err %></li>
                                                        <% } %>
                                                </ul>
                                            </div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </form>
                                </div>
                            </div>

                        </div>

                        <!-- Footer -->
                        <footer class="content-footer footer bg-footer-theme">
                            <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                                <div class="mb-2 mb-md-0">© 2025, Sneat Admin</div>
                            </div>
                        </footer>
                    </div>
                </div>

            </div>
        </div>

        <!-- Core JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/libs/popper/popper.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/js/main.js"></script>
    </body>

</html>
