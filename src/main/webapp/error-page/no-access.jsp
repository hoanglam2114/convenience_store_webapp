<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Accounts" %><%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/19/2025
  Time: 9:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html
        lang="en"
        class="light-style layout-menu-fixed"
        dir="ltr"
        data-theme="theme-default"
        data-assets-path="/assets/"
        data-template="vertical-menu-template-free"
>
<head>
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>Access Denied - Unauthorized</title>

    <meta name="description" content=""/>

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/fonts/boxicons.css"/>

    <!-- Core CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/core.css"
          class="template-customizer-core-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/theme-default.css"
          class="template-customizer-theme-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo.css"/>

    <!-- Vendors CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>

    <!-- Page CSS -->
    <style>
        .error-container {
            min-height: calc(100vh - 200px);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .error-content {
            text-align: center;
            max-width: 500px;
        }

        .error-icon {
            font-size: 8rem;
            color: #ff4757;
            margin-bottom: 2rem;
        }

        .error-code {
            font-size: 4rem;
            font-weight: 700;
            color: #2f3349;
            margin-bottom: 1rem;
        }

        .error-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #2f3349;
            margin-bottom: 1rem;
        }

        .error-description {
            color: #6c757d;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .btn-group-custom {
            gap: 1rem;
        }

        .fade-in {
            animation: fadeIn 0.8s ease-in;
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

    <!-- Helpers -->
    <script src="${pageContext.request.contextPath}/assets/vendor/js/helpers.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
</head>
<body>

<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">

        <!-- Site Bar (Only show if user is logged in) -->
        <%
            // Check if user is logged in (adjust this condition based on your session management)
            Accounts account = (Accounts) session.getAttribute("account");
            int role = account.getRole_id();
            boolean isLoggedIn = (role == 1 || role == 2 || role == 3 || role == 4);
        %>

        <% if (isLoggedIn) { %>
        <%@ include file="/common/site-bar.jsp" %>
        <% } %>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar (Only show if user is logged in) -->
            <% if (isLoggedIn) { %>
            <%@ include file="/common/nav-bar.jsp" %>
            <% } %>
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->
                <div class="container-xxl flex-grow-1 container-p-y">
                    <div class="error-container">
                        <div class="error-content fade-in">
                            <!-- Error Icon -->
                            <div class="error-icon">
                                <i class='bx bx-block'></i>
                            </div>

                            <!-- Error Code -->
                            <div class="error-code">403</div>

                            <!-- Error Title -->
                            <h1 class="error-title">Từ chối truy cập!</h1>
                            <c:choose>
                                <c:when test="${not empty error}">
                                    <p>${error}</p>
                                </c:when>
                                <c:otherwise><!-- Error Description -->
                                    <div class="error-description">
                                        <p>Ồ!, Bạn không có quyền truy cập vào trang này!.</p>
                                        <p>Trang này yêu cầu một số quyền người dùng cụ thể mà hiện tại bạn chưa có. Vui
                                            lòng liên hệ với quản trị viên hệ thống nếu bạn cho rằng đây là lỗi.</p>
                                    </div>

                                    <!-- Alert Box with Additional Info -->
                                    <div class="alert alert-warning" role="alert">
                                        <i class='bx bx-info-circle'></i>
                                        <strong>Cần quyền truy cập?</strong> Liên hệ với quản trị viên của bạn hoặc kiểm
                                        tra xem bạn đã đăng nhập bằng đúng tài khoản chưa.
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <!-- Action Buttons -->
                            <div class="d-flex flex-column flex-sm-row justify-content-center btn-group-custom">
                                <% if (isLoggedIn) { %>
                                <a href="HomeAdmin" class="btn btn-primary mb-2 mb-sm-0">
                                    <i class='bx bx-home-circle'></i> Trở về Trang chủ
                                </a>
                                <a href="javascript:history.back()" class="btn btn-outline-secondary">
                                    <i class='bx bx-arrow-back'></i> Trở về
                                </a>
                                <% } else { %>
                                <a href="LoginServlet" class="btn btn-primary mb-2 mb-sm-0">
                                    <i class='bx bx-log-in'></i> Đăng nhập
                                </a>
                                <a href="HomeAdmin" class="btn btn-outline-secondary">
                                    <i class='bx bx-home'></i> Trang chủ
                                </a>
                                <% } %>
                            </div>

                            <!-- Additional Help Section -->
                            <div class="mt-4 pt-4 border-top">
                                <h6 class="text-muted mb-3">Những lý do phổ biến khiến quyền truy cập bị từ chối:</h6>
                                <div class="row text-start">
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-start mb-3">
                                            <i class='bx bx-user-x text-danger me-2 mt-1'></i>
                                            <div>
                                                <strong>Tài khoản không có quyền</strong><br>
                                                <small class="text-muted">Tài khoản người dùng của bạn không có đủ quyền
                                                    cần thiết</small>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-start mb-3">
                                            <i class='bx bx-time text-warning me-2 mt-1'></i>
                                            <div>
                                                <strong>Phiên đăng nhập hết hạn</strong><br>
                                                <small class="text-muted">Thời hạn đăng nhập của bạn có thể đã hết
                                                    hạn</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-start mb-3">
                                            <i class='bx bx-shield-x text-danger me-2 mt-1'></i>
                                            <div>
                                                <strong>Tài nguyên hạn chế</strong><br>
                                                <small class="text-muted">Trang này chỉ dành cho người dùng cụ
                                                    thể</small>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-start mb-3">
                                            <i class='bx bx-cog text-info me-2 mt-1'></i>
                                            <div>
                                                <strong>Bảo trì hệ thống</strong><br>
                                                <small class="text-muted">Tài nguyên có thể tạm thời không khả
                                                    dụng</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Contact Support -->
                            <div class="mt-4">
                                <div class="card bg-light">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <i class='bx bx-support text-primary me-3' style="font-size: 2rem;"></i>
                                            <div class="text-start">
                                                <h6 class="mb-1">Cần hỗ trợ?</h6>
                                                <p class="mb-0 text-muted">Liên lạc với quản trị viên</p>
                                                <small class="text-muted">
                                                    <i class='bx bx-envelope'></i> hoanglam02112004@gmail.com |
                                                    <i class='bx bx-phone'></i> +84 918 127 783
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- / Content -->

                <!-- Footer -->
                <footer class="content-footer footer bg-footer-theme">
                    <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                        <div class="mb-2 mb-md-0">
                            ©
                            <script>
                                document.write(new Date().getFullYear());
                            </script>
                            , copyright by Convema
                        </div>
                        <div>
                            <a href="#" class="footer-link me-4">Privacy Policy</a>
                            <a href="#" class="footer-link me-4">Terms of Service</a>
                            <a href="#" class="footer-link me-4">Contact Support</a>
                        </div>
                    </div>
                </footer>
                <!-- / Footer -->

                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
</div>
<!-- / Layout wrapper -->

<!-- Core JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/popper/popper.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>
<!-- Main JS -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

<script>
    // Auto-redirect after 30 seconds (optional)
    /*
    setTimeout(function() {
<% if (isLoggedIn) { %>
            window.location.href = '${pageContext.request.contextPath}/dashboard';
        <% } else { %>
            window.location.href = '${pageContext.request.contextPath}/login';
        <% } %>
    }, 30000);
    */

    // Log access denied event (optional)
    console.log('Access denied to page: ' + window.location.href);

    // Show a toast notification (optional)
    if (typeof Swal !== 'undefined') {
        Swal.fire({
            icon: 'error',
            title: 'Quyền truy cập bị từ chối',
            text: 'Bạn không có quyền truy cập vào trang này.',
            timer: 5000,
            timerProgressBar: true,
            showConfirmButton: false
        });
    }
</script>
</body>
</html>