<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html
    lang="vi"
    class="light-style customizer-hide"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="../assets/"
    data-template="vertical-menu-template-free"
    >
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

        <title>Đăng ký tài khoản nhân viên | Sneat</title>
        <meta name="description" content="" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

        <!-- Google Fonts hỗ trợ tiếng Việt -->
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&display=swap&subset=vietnamese" rel="stylesheet">
        <!-- Font Public Sans cũ (có thể giữ nếu muốn) -->
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
            />

        <!-- Icons. Uncomment required icon fonts -->
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

        <!-- Core CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="assets/css/demo.css" />

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <!-- Page CSS -->
        <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />

        <style>
            body, input, button, label, h1, h2, h3, h4, h5, h6, p, textarea, select {
                font-family: 'Noto Sans', 'Roboto', 'Public Sans', Arial, Helvetica, sans-serif !important;
            }
        </style>

        <!-- Helpers -->
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
    </head>

    <body>
        <!-- Content -->
        <div class="container-xxl">
            <div class="authentication-wrapper authentication-basic container-p-y">
                <div class="authentication-inner">
                    <!-- Register Card -->
                    <div class="card">
                        <div class="card-body">
                            <!-- Logo -->
                            <div class="app-brand justify-content-center">
                                <a href="index.html" class="app-brand-link gap-2">
                                    <span class="app-brand-logo demo">
                                        <!-- SVG LOGO -->
                                        <!-- ... giữ nguyên SVG ... -->
                                    </span>
                                    <span class="app-brand-text demo text-body fw-bolder">Sneat</span>
                                </a>
                            </div>
                            <!-- /Logo -->
                            <h4 class="mb-2">Đăng ký tài khoản mới cho nhân viên</h4>
                            <p class="mb-4">
                                Hãy nhập địa chỉ email của bạn và đội ngũ chúng tôi sẽ gửi cho bạn hướng dẫn tạo tài khoản.
                            </p>

                            <form class="mb-3" action="register" method="POST">
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="emailRegister"
                                           placeholder="Nhập email để đăng ký" required />
                                </div>
                                <input class="btn btn-primary d-grid w-100" type="submit" value="Đăng ký">
                                <div class="mb-3" style="color: red">
                                    ${error}
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- Register Card -->
                </div>
            </div>
        </div>
        <!-- / Content -->

        <!-- Core JS -->
        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="../assets/vendor/js/menu.js"></script>
        <!-- Main JS -->
        <script src="../assets/js/main.js"></script>
        <!-- Page JS -->
    </body>
</html>
