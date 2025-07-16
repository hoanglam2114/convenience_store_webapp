<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý tuyển dụng</title>


        <link rel="stylesheet" href="../assets/vendor/css/core.css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />
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
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h4 class="fw-bold">Quản lý tuyển dụng</h4>
                                <span class="text-muted">Quản lý danh sách các vị trí tuyển dụng</span>
                            </div>
                            <a href="add-recruitment.jsp" class="btn btn-primary">
                                <i class='bx bx-plus'></i> Thêm tin tuyển dụng
                            </a>
                        </div>

                        <div class="card p-4">
                            <div class="row g-3 mb-3">
                                <div class="col-md-4">
                                    <input type="text" class="form-control" placeholder="Tìm kiếm theo tên vị trí...">
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select">
                                        <option selected>Trạng thái</option>
                                        <option>Đang tuyển</option>
                                        <option>Đã đóng</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select">
                                        <option selected>Phòng ban</option>
                                        <option>CNTT</option>
                                        <option>Kế toán</option>
                                    </select>
                                </div>
                                <div class="col-md-2 d-flex justify-content-end">
                                    <button class="btn btn-outline-secondary me-2">Làm mới</button>
                                    <button class="btn btn-outline-success">Xuất Excel</button>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th><input type="checkbox"/></th>
                                            <th>ID</th>
                                            <th>Vị trí tuyển dụng</th>
                                            <th>Phòng ban</th>
                                            <th>Số lượng</th>
                                            <th>Ngày đăng</th>
                                            <th>Hạn nộp</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><input type="checkbox"/></td>
                                            <td>#001</td>
                                            <td>
                                                <strong>Senior Frontend Developer</strong><br/>
                                                <small class="text-muted">Phát triển giao diện người dùng với React, Vue.js</small>
                                            </td>
                                            <td>Công nghệ thông tin</td>
                                            <td>2 người</td>
                                            <td>15/01/2025</td>
                                            <td>28/02/2025</td>
                                            <td><span class="badge bg-label-success">Đang tuyển</span></td>
                                            <td>
                                                <a href="view.jsp?id=001" class="text-primary me-2"><i class="bx bx-show"></i></a>
                                                <a href="edit.jsp?id=001" class="text-warning me-2"><i class="bx bx-edit"></i></a>
                                                <a href="delete?id=001" class="text-danger"><i class="bx bx-trash"></i></a>
                                            </td>
                                        </tr>
                                        <!-- Có thể lặp bằng JSTL với danh sách từ server -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Layout page -->

            </div>
            <!-- /Layout container -->
        </div>
        <!-- /Layout wrapper -->  

        <script src="../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- Sneat JS -->
        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/js/menu.js"></script>
        <script src="../assets/vendor/js/helpers.js"></script>
        <script src="../assets/js/config.js"></script>
        <script src="../assets/js/main.js"></script> <!-- Quan trọng -->
    </body>
</html>
