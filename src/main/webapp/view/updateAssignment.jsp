<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Employees, model.Shop" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Phân Công</title>
    <link rel="stylesheet" href="assets/vendor/css/core.css" />
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
    <link rel="stylesheet" href="assets/css/demo.css" />
    <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
</head>
<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <%@ include file="/common/site-bar.jsp" %>
        <div class="layout-page">
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">

                    <!-- Header -->
                    <div class="header-colorful mb-4">
                        <h4 class="fw-bold mb-1">✏️ Cập nhật phân công nhân viên</h4>
                        <p class="mb-0">Thay đổi nhân viên hoặc cửa hàng của một phân công hiện tại</p>
                    </div>

                    <!-- Thông báo -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">${message}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <!-- Form cập nhật -->
                    <div class="card">
                        <div class="card-body">
                            <form method="post" action="updateAssignmentServlet" class="row g-3">

                                <!-- Hidden fields -->
                                <input type="hidden" name="oldEmployeeId" value="${employeeId}" />
                                <input type="hidden" name="oldShopId" value="${shopId}" />

                                <!-- Nhân viên mới -->
                                <div class="col-md-6">
                                    <label class="form-label">Chọn Nhân Viên Mới</label>
                                    <select name="newEmployeeId" class="form-select" required>
                                        <option value="">-- Chọn nhân viên --</option>
                                        <c:forEach var="e" items="${employeeList}">
                                            <option value="${e.id}" ${e.id == employeeId ? "selected" : ""}>${e.name} (${e.roleName})</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Cửa hàng mới -->
                                <div class="col-md-6">
                                    <label class="form-label">Chọn Cửa Hàng Mới</label>
                                    <select name="newShopId" class="form-select" required>
                                        <option value="">-- Chọn cửa hàng --</option>
                                        <c:forEach var="s" items="${shopList}">
                                            <option value="${s.shopId}" ${s.shopId == shopId ? "selected" : ""}>${s.shopName}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Nút cập nhật -->
                                <div class="col-md-12 d-flex justify-content-end">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bx bx-save"></i> Lưu Thay Đổi
                                    </button>
                                    <a href="AssignEmployeeServlet" class="btn btn-outline-secondary ms-2">
                                        <i class="bx bx-arrow-back"></i> Quay lại
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>

                <!-- Footer -->
                <footer class="content-footer footer bg-footer-theme mt-4">
                    <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                        <div class="mb-2 mb-md-0">© 2025, Hệ thống quản lý nhân sự</div>
                        <div>🚀 Giao diện tùy chỉnh theo Sneat</div>
                    </div>
                </footer>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="assets/vendor/libs/jquery/jquery.js"></script>
<script src="assets/vendor/libs/popper/popper.js"></script>
<script src="assets/vendor/js/bootstrap.js"></script>
<script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="assets/vendor/js/menu.js"></script>
<script src="assets/js/main.js"></script>
</body>
</html>
