<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html
    lang="en"
    class="light-style customizer-hide"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="../assets/"
    data-template="vertical-menu-template-free"
    >
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
            />
        <title>Login Basic - Pages | Sneat - Bootstrap 5 HTML Admin Template - Pro</title>
        <meta name="description" content="" />
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />
        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
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
        <!-- Helpers -->
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="../assets/js/config.js"></script>
    </head>

    <body>
        <!-- Content -->
        <div class="container-xxl">
            <div class="authentication-wrapper authentication-basic container-p-y">
                <div class="authentication-inner">
                    <!-- Register -->
                    <div class="card">
                        <div class="card-body">
                            <!-- Logo -->
                            <div class="app-brand justify-content-center">
                                <a href="index.html" class="app-brand-link gap-2">
                                    <span class="app-brand-logo demo">
                                        <!-- SVG Logo nh? c? -->
                                    </span>
                                    <span class="app-brand-text demo text-body fw-bolder">Convema</span>
                                </a>
                            </div>
                            <!-- /Logo -->
                            <h4 class="mb-2">Chào mừng tới Convema! </h4>
                            <p class="mb-4">Vui lòng hãy đăng nhập tài khoản của bạn và bắt đầu khám phá dự án này</p>

                            <!-- HI?N TH? THÔNG BÁO L?I -->
                            <c:if test="${not empty mess}">
                                <div class="mb-3" style="color: red">${mess}</div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="mb-3" style="color: red">${error}</div>
                            </c:if>

                            <form id="formAuthentication" class="mb-3" action="LoginServlet" method="POST">
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input
                                        type="text"
                                        class="form-control"
                                        id="email"
                                        name="emailLogin"
                                        placeholder="Nhập địa chỉ email của bạn"
                                        value="${enteredEmail != null ? enteredEmail : ''}"
                                        autofocus
                                        />
                                </div>
                                <div class="mb-3 form-password-toggle">
                                    <div class="d-flex justify-content-between">
                                        <label class="form-label" for="password">Mật khẩu</label>
                                        <a href="ForgotPassword">
                                            <small>Quên mật khẩu?</small>
                                        </a>
                                    </div>
                                    <div class="input-group input-group-merge">
                                        <input
                                            type="password"
                                            id="password"
                                            class="form-control"
                                            name="passwordLogin"
                                            placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                                            aria-describedby="password"
                                            />
                                        <span class="input-group-text cursor-pointer toggle-password">
                                            <i class="bx bx-hide"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <button class="btn btn-primary d-grid w-100" type="submit">Đăng nhập</button>
                                </div>
                            </form>
                            <!--
                            <p class="text-center">
                                <span>New on our platform?</span>
                                <a href="view/auth-register.jsp">
                                    <span>Create an account</span>
                                </a>
                            </p>
                            -->
                        </div>
                    </div>
                    <!-- /Register -->
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
        <!-- endbuild -->
        <script src="../assets/js/main.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const togglePassword = document.querySelector('.toggle-password');
                const passwordInput = document.querySelector('#password');
                togglePassword.addEventListener('click', function () {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    this.querySelector('i').classList.toggle('bx-hide');
                    this.querySelector('i').classList.toggle('bx-show');
                });
            });
        </script>
    </body>
</html>
