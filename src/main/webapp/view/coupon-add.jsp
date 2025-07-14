<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="assets/"
      data-template="vertical-menu-template-free">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add new Coupon | POS Admin</title>
    <!-- Sneat CSS -->
    <link rel="stylesheet" href="assets/vendor/css/core.css"/>
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css"/>
    <link rel="stylesheet" href="assets/css/demo.css"/>
    <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>
    <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css"/>
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico"/>
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Public Sans', sans-serif;
        }
        .page-title {
            background: linear-gradient(90deg, #696cff, #00cfe8);
            color: #fff;
            padding: 12px 34px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.35rem;
            box-shadow: 0 3px 12px rgba(105, 108, 255, 0.15);
            display: inline-block;
            margin-bottom: 25px;
            letter-spacing: 0.5px;
        }
        .card {
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(105, 108, 255, 0.10);
            border: none;
            background: #fff;
        }
        .card-header {
            border-bottom: none;
            background: none;
            padding-bottom: 0;
        }
        .card-title {
            color: #696cff;
            font-weight: 700;
            font-size: 1.2rem;
            letter-spacing: 0.03em;
        }
        .form-label {
            font-weight: 600;
            color: #696cff;
            margin-bottom: 7px;
        }
        .form-control, .form-select {
            border-radius: 10px !important;
            border: 1.3px solid #dbeafe !important;
            background: #f6f9ff !important;
            font-size: 1.07rem;
            height: 48px;
            box-shadow: none !important;
            color: #344767;
        }
        .form-control:focus, .form-select:focus {
            border-color: #00cfe8 !important;
            box-shadow: 0 0 0 0.13rem #00cfe82d !important;
            background: #fff !important;
        }
        .btn {
            border-radius: 0.5rem;
            font-size: 1.09rem;
            font-weight: 600;
            transition: all 0.16s;
        }
        .btn-primary {
            background: linear-gradient(90deg, #696cff 65%, #00cfe8 100%);
            border: none;
            color: #fff;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #43e97b 0%, #38f9d7 100%);
            color: #344767 !important;
            box-shadow: 0 6px 24px #38f9d732;
        }
        .btn-outline-secondary {
            color: #696cff;
            border-color: #b3b8f9;
            margin-left: 10px;
        }
        .btn-outline-secondary:hover {
            background: #f0f3ff;
            color: #4834d4;
        }
        .btn i {
            vertical-align: middle;
            margin-right: 4px;
        }
        @media (min-width: 1200px) {
            .add-coupon-col {
                max-width: 880px;
            }
        }
        @media (max-width: 600px) {
            .page-title {
                font-size: 1.09rem;
                padding: 9px 10px;
            }
            .card {
                margin-top: 10px;
            }
            .btn-primary, .btn-outline-secondary {
                width: 100%;
                margin: 7px 0 0 0;
            }
            .btn-outline-secondary {
                margin-left: 0;
            }
        }
    </style>
</head>

<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <%@ include file="/common/site-bar.jsp" %>
        <div class="layout-page">
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="page-title">
                            Add new Coupon
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-12 add-coupon-col">
                            <div class="card p-lg-4 p-3 mb-4">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Coupon Detail</h5>
                                </div>
                                <div class="card-body">
                                    <form action="couponAdd" method="post" autocomplete="off">
                                        <div class="row g-4">
                                            <div class="col-md-6">
                                                <label class="form-label">Code</label>
                                                <input type="text" class="form-control" name="code" required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Discount Percentage (%)</label>
                                                <input type="number" class="form-control" name="discountPercentage" required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Start Date</label>
                                                <input type="date" class="form-control" name="startDate" required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">End Date</label>
                                                <input type="date" class="form-control" name="endDate" required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Status</label>
                                                <select name="status" class="form-select">
                                                    <c:forEach items="${statuses}" var="status">
                                                        <option value="${status}">${status}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="mt-4 d-flex flex-wrap">
                                            <button type="submit" class="btn btn-primary me-2 mb-2"><i class="bx bx-save"></i> Add Coupon</button>
                                            <a href="couponManage" class="btn btn-outline-secondary mb-2">Cancel</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <footer class="content-footer footer bg-footer-theme mt-4">
                    <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                        <div class="text-muted">
                            © <script>document.write(new Date().getFullYear())</script> POS Admin
                        </div>
                        <div>
                            <a href="#">Privacy Policy</a> | <a href="#">Terms of Use</a>
                        </div>
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
<script src="assets/js/main.js"></script>
</body>
</html>
