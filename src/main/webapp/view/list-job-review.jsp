<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thông tin tuyển dụng</title>


        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
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
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h4 class="fw-bold">Danh sách người ứng tuyển</h4>
                                <span class="text-muted">Màn hình hiển thị danh sách thông tin người ứng tuyển</span>
                            </div>
                          
                        </div>

                        <div class="card p-4">
                            <div class="row g-3 mb-3">
                                <form action="FindJobApplication"  method="get">
                                <div class="d-flex  align-items-center gap-2 mb-2">
                                    <input style="width: 300px" type="text" class="form-control" name="name" placeholder="Tìm kiếm theo tên" />
                                    <button style="width: 120px"  type="submit" class="btn btn-primary me-2"><i ></i> Tìm kiếm</button>
                                    <a style="width: 120px" href="ListJobApplication" class="btn btn-primary ">
                                        <i ></i> Làm mới
                                    </a>
                                </div>
                                </form>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>STT</th>
                                            <th>Tên đầy đủ</th>
                                            <th>Email</th>
                                            <th>SĐT</th>
                                            <th>Ngày sinh</th>
                                            <th>giới tính</th>
                                            <th>Địa chỉ hiện tại</th>
                                            <th>Địa chỉ cửa hàng ứng tuyển</th>
                                            <th>Ngày phỏng vấn</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${job}" var="j">
                                            <tr>
                                                <td>${j.getId()}</td>
                                                <td>${j.getName()}</td>
                                                <td>${j.getEmail()}</td>
                                                <td>${j.getPhone()}</td>
                                                <td>${j.getDateofbirth()}</td>
                                                <td>${j.getGender().getName()}</td>
                                                <td>${j.getCurrent_address()}</td>
                                                <td>${j.getDistrict_apply().getName()}</td>
                                                <td>${j.getInterview_date()}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- Footer -->
                            <footer class="content-footer footer bg-footer-theme">
                                <div class="container-xxl d-flex justify-content-center py-3">
                                    <div class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="ListJobApplication?index=${currentPage - 1}">Previous</a>
                                    </div>

                                    <c:forEach begin="1" end="${endPage}" var="i">
                                        <div class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="ListJobApplication?index=${i}">${i}</a>
                                        </div>
                                    </c:forEach>

                                    <div class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                                        <a class="page-link" href="ListJobApplication?index=${currentPage + 1}">Next</a>
                                    </div>
                                </div>

                            </footer>
                        </div>
                    </div>
                </div>
                <!-- /Layout page -->

            </div>
            <!-- /Layout container -->
        </div>
        <!-- /Layout wrapper -->  

        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- Sneat JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
        <script src="assets/js/main.js"></script> <!-- Quan trọng -->
    </body>
</html>
