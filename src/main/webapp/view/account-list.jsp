<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quản lý tài khoản</title>

        <!-- Stylesheets -->
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

                            <!-- Header -->
                            <div class="header-colorful">
                                <h4 class="fw-bold mb-1">📊 Quản lý Tài Khoản</h4>
                                <p class="mb-0">Theo dõi và kiểm soát tài khoản của nhân viên</p>
                            </div>

                            <!-- Filter Form -->
                            <form method="get" action="AccountFilterServlet" class="mb-3">
                                <div class="row g-2 align-items-center">
                                    <!-- Filter by Role -->
                                    <div class="col-md-4">
                                        <label for="roleFilter" class="form-label mb-1">Lọc theo vai trò</label>
                                        <select id="roleFilter" name="role" class="form-select">
                                            <option value="">Tất cả</option>
                                            <option value="1" ${param.role == '1' ? 'selected' : ''}>Admin</option>
                                            <option value="2" ${param.role == '2' ? 'selected' : ''}>Staff</option>
                                            <option value="3" ${param.role == '3' ? 'selected' : ''}>Manager</option>
                                        </select>
                                    </div>

                                    <!-- Filter by Status -->
                                    <div class="col-md-4">
                                        <label for="statusFilter" class="form-label mb-1">Lọc theo trạng thái</label>
                                        <select id="statusFilter" name="status" class="form-select">
                                            <option value="">Tất cả</option>
                                            <c:forEach var="status" items="${requestScope.statusList}">
                                                <option value="${status.status_id}" 
                                                        ${param.status == status.status_id ? 'selected' : ''}>
                                                    ${status.status_name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="col-md-4 mt-4 pt-1">
                                        <button type="submit" class="btn btn-primary">Lọc</button>
                                        <a href="AccountManagementServlet" class="btn btn-secondary">Reset</a>
                                    </div>
                                </div>
                            </form>

                            <!-- Account Table -->
                            <div class="card border shadow-sm">
                                <div class="table-responsive text-nowrap">
                                    <table class="table shift-table">
                                        <thead>
                                            <tr>
                                                <th>Account ID</th>
                                                <th>Họ tên</th>
                                                <th>Email</th>
                                                <th>Vai trò</th>
                                                <th>Trạng thái</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="account" items="${requestScope.account}">
                                                <tr>
                                                    <td>${account.account_id}</td>
                                                    <td>
                                                        <c:forEach var="employee" items="${requestScope.employee}">
                                                            <c:if test="${employee.accountId == account.account_id}">
                                                                ${employee.name}
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>${account.email}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${account.role_id == 1}">Admin</c:when>
                                                            <c:when test="${account.role_id == 2}">Staff</c:when>
                                                            <c:when test="${account.role_id == 3}">Manager</c:when>
                                                            <c:otherwise>Unknown</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:forEach var="status" items="${requestScope.statusList}">
                                                            <c:if test="${status.status_id == account.status_id}">
                                                                ${status.status_name}
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <!-- Xem chi tiết: luôn cho phép -->
                                                        <a href="ChangePassword?id=${account.account_id}" class="btn btn-sm btn-outline-info me-1" title="Xem chi tiết">
                                                            <i class="bx bx-show"></i>
                                                        </a>

                                                        <!-- Cập nhật trạng thái: chỉ nếu KHÔNG phải admin -->
                                                        <c:choose>
                                                            <c:when test="${account.role_id == 1}">
                                                                <button class="btn btn-sm btn-outline-secondary me-1" disabled title="Không thể cập nhật trạng thái của Admin">
                                                                    <i class="bx bx-edit-alt"></i>
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="UpdateStatusServlet?id=${account.account_id}" class="btn btn-sm btn-outline-primary me-1" title="Cập nhật trạng thái">
                                                                    <i class="bx bx-edit-alt"></i>
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <!-- Xóa: vẫn cho phép (hoặc thêm điều kiện khóa nếu muốn) -->
                                                        <a href="DeleteAccountServlet?id=${account.account_id}" class="btn btn-sm btn-outline-danger"
                                                           onclick="return confirm('Bạn có chắc muốn xóa không?');" title="Xóa">
                                                            <i class="bx bx-trash"></i>
                                                        </a>
                                                    </td>

                                                </tr>
                                            </c:forEach>

                                            <c:if test="${empty requestScope.account}">
                                                <tr>
                                                    <td colspan="6" class="text-center text-muted">
                                                        🚫 Không có dữ liệu tài khoản nào
                                                    </td>
                                                </tr>
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
        <script src="assets/js/customer.js"></script>
    </body>
</html>
