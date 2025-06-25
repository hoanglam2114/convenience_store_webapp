<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">
    <head>
        <meta charset="UTF-8">
        <title>Thông tin người dùng</title>

        <!-- Styles -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

        <style>
            .header-colorful {
                background: linear-gradient(90deg, #fbc2eb 0%, #a6c1ee 100%);
                border-radius: 12px;
                padding: 16px 24px;
                margin-bottom: 20px;
                color: #333;
            }
        </style>
    </head>
    <body>
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <%@ include file="/common/site-bar.jsp" %>

                <div class="layout-page">
                    <nav class="layout-navbar container-xxl navbar navbar-expand-xl"></nav>
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">

                            <!-- Header -->
                            <div class="header-colorful">
                                <h4 class="fw-bold mb-1">👤 Thông tin cá nhân</h4>
                                <p class="mb-0">Xem thông tin tài khoản và đổi mật khẩu</p>
                            </div>

                            <div class="row g-4">
                                <!-- Thông tin người dùng -->
                                <div class="col-md-6">
                                    <div class="card p-4 shadow-sm">
                                        <h5 class="mb-3 text-primary">🪪 Thông tin người dùng</h5>
                                        <p><strong>Họ tên:</strong> ${employee.name}</p>
                                        <p><strong>Điện thoại:</strong> ${employee.phone}</p>
                                        <p><strong>Địa chỉ:</strong> ${employee.address}</p>
                                        <p><strong>Email:</strong> ${account.email}</p>
                                    </div>
                                </div>

                                <!-- Form đổi mật khẩu -->
                                <div class="col-md-6">
                                    <div class="card p-4 shadow-sm">
                                        <h5 class="mb-3 text-primary">🔐 Đổi mật khẩu</h5>
                                        <form method="post" action="ChangePassword">
                                            <input type="hidden" name="accountId" value="${account.account_id}" />
                                            <!--                                    <div class="mb-3">
                                                                                    <label for="currentPassword" class="form-label">Mật khẩu hiện tại</label>
                                                                                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                                                                </div>-->
                                            <div class="mb-3">
                                                <label for="newPassword" class="form-label">Mật khẩu mới</label>
                                                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="confirmPassword" class="form-label">Nhập lại mật khẩu mới</label>
                                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                            </div>
                                            <p class="text-muted">🔑 Mật khẩu phải dài ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.</p>
                                            <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                                        </form>

                                        <c:if test="${not empty message}">
                                            <div class="alert alert-info mt-3">${message}</div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Footer -->
                        <footer class="content-footer footer bg-footer-theme mt-4">
                            <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                                <div class="mb-2 mb-md-0">© 2025, Shift Admin Panel</div>
                                <div>🎨 Giao diện bởi bạn</div>
                            </div>
                        </footer>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html>
