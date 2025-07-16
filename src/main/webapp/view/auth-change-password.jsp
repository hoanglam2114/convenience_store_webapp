<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="light-style customizer-hide" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <title>Register Basic - Pages | Sneat</title>
    <meta name="description" content="" />
    <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;600&display=swap" rel="stylesheet" />

    <!-- Icons -->
    <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="assets/css/demo.css" />
    <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />

    <script src="assets/vendor/js/helpers.js"></script>
    <script src="assets/js/config.js"></script>
</head>

<body>
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
                                <!-- You can insert your SVG or logo image here -->
                                <img src="../assets/img/favicon/favicon.ico" alt="logo" width="30">
                            </span>
                            <span class="app-brand-text demo text-body fw-bolder">Sneat</span>
                        </a>
                    </div>
                    <!-- /Logo -->

                    <h4 class="mb-2">New Password ?</h4>
                    <p class="mb-4">Enter your new password to register a new account</p>

                    <form id="formAuthentication" class="mb-3" action="changePassword" method="POST">
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input
                                type="password"
                                class="form-control"
                                id="password"
                                name="passwordRegister"
                                placeholder="Enter your new password"
                                required
                            />
                        </div>

                        <div class="mb-3">
                            <label for="reenterPassword" class="form-label">Re-enter Password</label>
                            <input
                                type="password"
                                class="form-control"
                                id="reenterPassword"
                                name="reenterPassword"
                                placeholder="Re-enter your new password"
                                required
                            />
                        </div>

                        <input class="btn btn-primary d-grid w-100" type="submit" value="Enter Password">

                        <div class="mb-3" style="color: red">
                            ${error}
                        </div>
                    </form>
                </div>
            </div>
            <!-- /Register Card -->
        </div>
    </div>
</div>

<!-- Core JS -->
<script src="../assets/vendor/libs/jquery/jquery.js"></script>
<script src="../assets/vendor/libs/popper/popper.js"></script>
<script src="../assets/vendor/js/bootstrap.js"></script>
<script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="../assets/vendor/js/menu.js"></script>
<script src="../assets/js/main.js"></script>

<!-- JavaScript to validate password matching -->
<script>
    document.getElementById("formAuthentication").addEventListener("submit", function (e) {
        var password = document.getElementById("password").value;
        var reenter = document.getElementById("reenterPassword").value;

        if (password !== reenter) {
            e.preventDefault();
            alert("Passwords do not match. Please re-enter.");
        }
    });
</script>

</body>
</html>
