<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản lý mã khuyến mãi</title>

    <link rel="stylesheet" href="assets/vendor/css/core.css" />
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
    <link rel="stylesheet" href="assets/css/demo.css" />
    <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

    <!-- Custom UI/UX Style -->
    <style>
        body {
            background: linear-gradient(120deg, #e0c3fc 0%, #8ec5fc 100%);
            min-height: 100vh;
        }
        /* Card + Table */
        .card {
            border-radius: 18px;
            box-shadow: 0 8px 36px rgba(80, 51, 255, 0.10);
            border: none;
            background: rgba(255,255,255,0.92);
        }
        .table {
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 0;
            background: white;
        }
        .table thead th {
            background: linear-gradient(90deg, #a1c4fd 0%, #c2e9fb 100%) !important;
            font-weight: 700;
            color: #4c4088;
            border: none;
        }
        .table tbody tr {
            transition: background 0.22s, box-shadow 0.22s;
        }
        .table tbody tr:hover {
            background: linear-gradient(90deg,#fcf6ba 0%, #f7d9f6 100%);
            box-shadow: 0 2px 12px rgba(162, 104, 255, 0.05);
        }
        /* Badge status nhiều màu */
        .badge {
            font-size: 14px;
            padding: 8px 17px;
            border-radius: 12px;
            font-weight: 600;
            letter-spacing: 0.01em;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }
        .bg-success {
            background: linear-gradient(90deg, #23c16b 40%, #99f2c8 100%) !important;
            color: #fff;
        }
        .bg-warning {
            background: linear-gradient(90deg, #ffb347 40%, #ffe259 100%) !important;
            color: #6c4400;
        }
        .bg-secondary {
            background: linear-gradient(90deg, #6e8efb 40%, #a777e3 100%) !important;
            color: #fff;
        }
        .bg-danger {
            background: linear-gradient(90deg, #ff416c 40%, #ff4b2b 100%) !important;
            color: #fff;
        }
        /* Custom Button */
        .btn {
            border-radius: 12px !important;
            font-weight: 600;
            letter-spacing: 0.02em;
            box-shadow: 0 2px 14px rgba(111,89,239,.11);
            transition: background 0.23s, box-shadow 0.18s;
        }
        .btn-primary {
            background: linear-gradient(90deg, #6e8efb 0%, #a777e3 100%) !important;
            border: none;
            color: #fff !important;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #43e97b 0%, #38f9d7 100%) !important;
            color: #333 !important;
            box-shadow: 0 4px 20px rgba(60,244,206,.17);
        }
        .btn-outline-secondary {
            color: #6e8efb;
            border-color: #a777e3;
            background: none;
        }
        .btn-outline-secondary:hover {
            background: #f3f0fd;
            color: #3f51b5;
        }
        /* Icon button */
        .btn-icon {
            padding: 7px 11px !important;
            font-size: 18px;
        }
        .btn-outline-primary {
            border-color: #6e8efb;
            color: #6e8efb;
        }
        .btn-outline-primary:hover {
            background: #e0ecfa;
            color: #3226b7;
        }
        .btn-outline-danger {
            border-color: #ff416c;
            color: #ff416c;
        }
        .btn-outline-danger:hover {
            background: #ffd1e3;
            color: #b1002a;
        }
        /* Filter form */
        .filter-group .form-control, .filter-group .form-select {
            border-radius: 10px;
            min-width: 150px;
            border: 1px solid #ece7ff;
            box-shadow: none;
            transition: border 0.18s;
        }
        .filter-group .form-control:focus, .filter-group .form-select:focus {
            border: 1.5px solid #a777e3;
            box-shadow: 0 0 0 0.1rem #b49bfc33;
        }
        .filter-group {
            gap: 16px;
        }
        /* Add Coupon Button */
        .add-coupon-btn {
            box-shadow: 0 4px 24px rgba(162,119,227,0.12) !important;
        }
        /* Responsive */
        @media (max-width: 991px) {
            .filter-group {
                flex-direction: column !important;
                gap: 10px;
            }
            .add-coupon-btn {
                width: 100%;
                margin-top: 10px;
            }
        }
        /* Small decoration icon in table action */
        .table .btn-icon i {
            vertical-align: middle;
        }
        /* Extra: hover icon effect */
        .btn-icon:hover i {
            transform: scale(1.15) rotate(-8deg);
            transition: all 0.14s;
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

                    <div class="d-flex justify-content-between align-items-center flex-wrap mb-4">
                        <h4 class="fw-bold py-3 mb-0" style="color:#5b4ebd;">
                            <span class="text-muted fw-light">Quản lý /</span> Danh sách mã khuyến mãi
                        </h4>
                        <a href="couponAdd" class="btn btn-primary add-coupon-btn">
                            <i class="bx bx-plus"></i> Thêm mới mã khuyến mãi
                        </a>
                    </div>

                    <div class="card mb-4">
                        <div class="card-body">
                            <form method="post" action="couponManage" class="row filter-group align-items-end">
                                <div class="col-auto">
                                    <div class="input-group">
                                        <span class="input-group-text" style="background:#ece7ff;"><i class="bx bx-search"></i></span>
                                        <input type="text" class="form-control" name="couponCode" value="${couponCode}" placeholder="Mã khuyến mãi...">
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <select class="form-select" name="couponStatus">
                                        <option value="All Status" ${"All Status".equals(couponStatuss) ? "selected" : ""}>Tất cả trạng thái</option>
                                        <c:forEach items="${statuses}" var="status">
                                            <option value="${status}" ${status.equals(couponStatuss) ? "selected" : ""}>${status}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-auto">
                                    <input type="date" class="form-control" name="startDate" value="${startDate}" placeholder="Ngày bắt đầu">
                                </div>
                                <div class="col-auto">
                                    <input type="date" class="form-control" name="endDate" value="${endDate}" placeholder="Ngày kết thúc">
                                </div>
                                <div class="col-auto">
                                    <input type="number" class="form-control" step="0.1" name="discountAmount" value="${discountAmount}" placeholder="Giảm (%)">
                                </div>
                                <div class="col-auto d-flex gap-2">
                                    <button type="submit" class="btn btn-primary"><i class="bx bx-filter-alt"></i> Tìm kiếm</button>
                                    <a href="couponManage" class="btn btn-outline-secondary">Xóa</a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card">
                        <div class="table-responsive text-nowrap">
                            <table class="table align-middle mb-0">
                                <thead class="table-light">
                                <tr>
                                    <th>Mã</th>
                                    <th>Phần trăm giảm (%)</th>
                                    <th>Ngày bắt đầu khuyến mãi</th>
                                    <th>Ngày kết thúc khuyến mãi</th>
                                    <th>Trạng thái</th>
                                    <th class="text-center">Hành động</th>
                                </tr>
                                </thead>
                                <tbody class="table-border-bottom-0">
                                <c:forEach items="${listCoupon}" var="coupon">
                                    <tr>
                                        <td class="fw-semibold">${coupon.coupon_code}</td>
                                        <td>
                                            <span style="color:#9d50bb; font-weight:600;">${coupon.discount_amount}</span>
                                        </td>
                                        <td>${coupon.coupon_start_date}</td>
                                        <td>${coupon.coupon_end_date}</td>
                                        <td>
                                            <c:set var="statusClass"
                                                value="${coupon.coupon_status == 'Active' 
                                                        ? 'bg-success' 
                                                        : (coupon.coupon_status == 'Inactive'
                                                            ? 'bg-warning'
                                                            : (coupon.coupon_status == 'Expired' 
                                                                ? 'bg-danger'
                                                                : 'bg-secondary'))}" />
                                            <span class="badge ${statusClass}">${coupon.coupon_status}</span>
                                        </td>
                                        <td class="text-center">
                                            <a href="couponUpdate?id=${coupon.coupon_id}" class="btn btn-sm btn-icon btn-outline-primary me-1" title="Update">
                                                <i class="bx bx-edit"></i>
                                            </a>
                                            <button class="btn btn-sm btn-icon btn-outline-danger" onclick="doDelete(${coupon.coupon_id})" title="Delete">
                                                <i class="bx bx-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <footer class="content-footer footer bg-footer-theme mt-4" style="background:rgba(255,255,255,0.85);">
                    <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                        <div class="text-muted">
                            © <script>document.write(new Date().getFullYear())</script> CSMS Admin
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

<script src="assets/vendor/libs/jquery/jquery.js"></script>
<script src="assets/vendor/js/bootstrap.js"></script>
<script src="assets/vendor/js/menu.js"></script>
<script src="assets/vendor/js/helpers.js"></script>
<script src="assets/js/config.js"></script>
<script src="assets/js/main.js"></script>

<script type="text/javascript">
    function doDelete(id) {
        if (confirm("Are you sure delete coupon which has id =" + id)) {
            window.location = "couponDelete?id=" + id;
        }
    }
</script>
</body>
</html>
