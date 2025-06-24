<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Shifts" %>
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
    <title>Shift Management</title>

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
        .shift-table thead th {
            background-color: #e3f2fd;
            color: #444;
            text-transform: uppercase;
        }
        .shift-table tbody tr:nth-child(odd) {
            background-color: #fafafa;
        }
        .shift-table tbody tr:hover {
            background-color: #f1f8e9;
        }
        .btn-outline-primary {
            border-color: #6f42c1;
            color: #6f42c1;
        }
        .btn-outline-primary:hover {
            background-color: #6f42c1;
            color: white;
        }
        .btn-outline-danger {
            border-color: #d63384;
            color: #d63384;
        }
        .btn-outline-danger:hover {
            background-color: #d63384;
            color: white;
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
                    <div class="header-colorful">
                        <h4 class="fw-bold mb-1">📊 Quản lý Ca Làm</h4>
                        <p class="mb-0">Theo dõi và kiểm soát lịch sử làm việc của nhân viên</p>
                    </div>

                    <!-- Search and Filter Bar -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <form action="searchShift" method="POST">
                                <div class="input-group shadow-sm">
                                    <input type="text" name="shiftSearch" class="form-control border-primary" placeholder="🔍 Nhập mã ca hoặc tên nhân viên..." />
                                    <button class="btn btn-outline-primary" type="submit">
                                        <i class="bx bx-search"></i>
                                    </button>
                                    <button class="btn btn-outline-secondary" type="button" onclick="window.location.href='listShift'">
                                        <i class="bx bx-reset"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                        <div class="col-md-6">
                            <form action="filterShift" method="GET" class="d-flex justify-content-end gap-2">
                                <select class="form-select border-info" name="status">
                                    <option value="">-- Trạng thái --</option>
                                    <option value="completed">✅ Đã hoàn thành</option>
                                    <option value="in_progress">🟡 Đang diễn ra</option>
                                    <option value="cancelled">❌ Đã hủy</option>
                                </select>
                                <select class="form-select border-success" name="sort">
                                    <option value="">-- Sắp xếp --</option>
                                    <option value="start_asc">📅 Bắt đầu ↑</option>
                                    <option value="start_desc">📅 Bắt đầu ↓</option>
                                    <option value="revenue_desc">💰 Doanh thu ↓</option>
                                </select>
                                <button class="btn btn-outline-primary" type="submit">🔎 Lọc</button>
                            </form>
                        </div>
                    </div>

                    <!-- Shift Table -->
                    <div class="card border shadow-sm">
                        <div class="table-responsive text-nowrap">
                            <table class="table shift-table">
                                <thead>
                                    <tr>
                                        <th>Mã ca làm</th>
                                        <th>Bắt đầu</th>
                                        <th>Kết thúc</th>
                                        <th>Doanh thu</th>
                                        <th>Giờ làm</th>
                                        <th>Nhân viên</th>
                                        <th>Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="shift" items="${requestScope.shift}">
                                        <tr>
                                            <td>${shift.shiftManageId}</td>
                                            <td>${shift.formattedShiftStartTime}</td>
                                            <td>${shift.formattedShiftEndTime}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty shift.totalRevenue}">
                                                        <fmt:formatNumber value="${shift.totalRevenue}" type="number" minFractionDigits="0" maxFractionDigits="0"/> VNĐ
                                                    </c:when>
                                                    <c:otherwise>0 VNĐ</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty shift.totalHours}">
                                                        <fmt:formatNumber value="${shift.totalHours}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                                    </c:when>
                                                    <c:otherwise>0.00</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${shift.employeeName}</td>
                                            <td>
                                                <a href="ShiftDetailServlet?id=${shift.shiftManageId}" class="btn btn-sm btn-outline-primary me-1" title="Chi tiết">
                                                    <i class="bx bx-show"></i>
                                                </a>
                                                <a href="DeleteShift?id=${shift.shiftManageId}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc muốn xóa không?');" title="Xóa">
                                                    <i class="bx bx-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty requestScope.shift}">
                                        <tr><td colspan="7" class="text-center text-muted">🚫 Không có dữ liệu ca làm nào</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

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

<script src="assets/vendor/libs/jquery/jquery.js"></script>
<script src="assets/vendor/libs/popper/popper.js"></script>
<script src="assets/vendor/js/bootstrap.js"></script>
<script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="assets/vendor/js/menu.js"></script>
<script src="assets/js/main.js"></script>
</body>
</html>