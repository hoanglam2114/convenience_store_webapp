<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Shift Detail</title>

    <link rel="stylesheet" href="assets/vendor/css/core.css" />
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css" /> 
    <link rel="stylesheet" href="assets/css/demo.css" />
    <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
    <style>
        .highlight-header {
            background: linear-gradient(90deg, #c2e9fb 0%, #a1c4fd 100%);
            padding: 16px;
            border-radius: 12px;
            color: #3b3b3b;
        }
        .styled-table th {
            background-color: #f5f8ff;
            color: #6c757d;
            text-transform: uppercase;
        }
        .styled-table tbody tr:nth-child(odd) {
            background-color: #fefefe;
        }
        .styled-table tbody tr:hover {
            background-color: #f3f0ff;
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
                    <div class="highlight-header mb-4">
                        <h4 class="fw-bold mb-1">📋 Chi tiết ca làm</h4>
                        <p class="mb-0">Thông tin chi tiết đơn hàng theo từng ca làm</p>
                    </div>

                    <div class="card border rounded-3 shadow-sm">
                        <div class="table-responsive text-nowrap styled-table">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Mã ca</th>
                                        <th>Bắt đầu</th>
                                        <th>Kết thúc</th>
                                        <th>Đơn hàng</th>
                                        <th>Khách hàng</th>
                                        <th>Thời gian mua</th>
                                        <th>Số lượng</th>
                                        <th>Giá SP</th>
                                        <th>Tổng tiền</th>
                                        <th>Sản phẩm</th>
                                        <th>Ảnh</th>
                                        <th>Nhân viên</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="shiftdetail" items="${requestScope.shiftDetails}">
                                        <tr>
                                            <td>${shiftdetail.shiftManagerId}</td>
                                            <td>${shiftdetail.formattedShiftStartTime}</td>
                                            <td>${shiftdetail.formattedShiftEndTime}</td>
                                            <td>${shiftdetail.orderId}</td>
                                            <td>${shiftdetail.customerName}</td>
                                            <td>${shiftdetail.formattedOrderDate}</td>
                                            <td>${shiftdetail.quantity}</td>
                                            <td>
                                                <fmt:formatNumber value="${shiftdetail.unitPrice}" type="number" minFractionDigits="0" maxFractionDigits="0" /> VNĐ
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${shiftdetail.totalPrice}" type="number" minFractionDigits="0" maxFractionDigits="0" /> VNĐ
                                            </td>
                                            <td>${shiftdetail.productName}</td>
                                            <td>
                                                <img src="assets/images/product/${shiftdetail.productImage}" width="60px" height="60px" style="border-radius: 8px; object-fit: cover;" />
                                            </td>
                                            <td>${shiftdetail.employeeName}</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty requestScope.shiftDetails}">
                                        <tr><td colspan="12" class="text-center text-muted">🚫 Không có dữ liệu ca làm nào</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <footer class="content-footer footer bg-footer-theme mt-4">
                    <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                        <div class="mb-2 mb-md-0">© 2025, Shift Admin Panel</div>
                        <div>🎨 Styled by You</div>
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