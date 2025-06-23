<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Employees, model.EmployeeStoreAssignment" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">
<head>
    <meta charset="UTF-8">
    <title>Phân Công Nhân Viên</title>
    
    
    
    <!-- CSS -->
    <link rel="stylesheet" href="assets/vendor/css/core.css" />
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
    <link rel="stylesheet" href="assets/css/demo.css" />
    <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

    <!-- Custom Styling -->
    <style>
        .header-colorful {
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(255, 180, 150, 0.4);
            color: #333;
            margin-bottom: 20px;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
            transition: all 0.3s ease-in-out;
        }
        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
        }
        .shift-table thead th {
            background: linear-gradient(90deg, #a1c4fd 0%, #c2e9fb 100%);
            color: #333;
            font-weight: bold;
            text-transform: uppercase;
        }
        .shift-table tbody tr:nth-child(odd) {
            background-color: #f9f9ff;
        }
        .shift-table tbody tr:hover {
            background-color: #e8f0fe;
        }
        .btn-outline-primary {
            border-color: #4e73df;
            color: #4e73df;
        }
        .btn-outline-primary:hover {
            background-color: #4e73df;
            color: white;
        }
        .btn-outline-danger {
            border-color: #e74a3b;
            color: #e74a3b;
        }
        .btn-outline-danger:hover {
            background-color: #e74a3b;
            color: white;
        }
        .btn-assign {
            background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
            color: white;
            border: none;
            font-weight: bold;
            padding: 10px 18px;
            border-radius: 8px;
        }
        .btn-assign:hover {
            background: linear-gradient(135deg, #66a6ff 0%, #89f7fe 100%);
            transform: scale(1.02);
        }
        .form-select {
            border-radius: 8px;
        }
        .alert-success::before {
            content: "✅ ";
        }
        .alert-danger::before {
            content: "❌ ";
        }
    </style>
</head>

<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        
        <%@ include file="../common/site-bar.jsp" %>


        <div class="layout-page">
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">

                    <!-- Header -->
                    <div class="header-colorful mb-4">
                        <h4 class="fw-bold mb-1">🧑‍💼 Phân công nhân viên vào cửa hàng</h4>
                        <p class="mb-0">Gán nhân viên hiện có vào các cửa hàng hoạt động</p>
                    </div>

                    <!-- Alert -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">${message}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <!-- Form -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <form action="AssignEmployeeServlet" method="POST" class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Chọn Nhân Viên</label>
                                    <select name="employeeId" class="form-select" required>
                                        <option value="">-- Chọn nhân viên --</option>
                                        <c:forEach var="e" items="${employeeList}">
                                            <option value="${e.id}">${e.name} (${e.roleName})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Chọn Cửa Hàng</label>
                                    <select name="shopId" class="form-select" required>
                                        <option value="">-- Chọn cửa hàng --</option>
                                        <c:forEach var="s" items="${shopList}">
                                            <option value="${s.shopId}">${s.shopName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="col-md-12 d-flex justify-content-end">
                                    <button type="submit" class="btn btn-assign">
                                        <i class="bx bx-check"></i> Gán
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Table -->
                    <div class="card border shadow-sm">
                        <div class="table-responsive text-nowrap">
                            <table class="table shift-table">
                                <thead>
                                    <tr>
                                        <th>Nhân Viên</th>
                                        <th>Vai Trò</th>
                                        <th>Cửa Hàng</th>
                                        <th>Kho</th>
                                        <th>Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="a" items="${assignmentList}">
                                        <tr>
                                            <td>${a.employeeName}</td>
                                            <td>${a.roleName}</td>
                                            <td>${a.shopName}</td>
                                            <td>${a.warehouseName}</td>
                                            <td>
                                                <a href="updateAssignmentServlet?employeeId=${a.employee_id}&shopId=${a.store_id}" 
                                                   class="btn btn-sm btn-outline-primary" title="Cập nhật phân công">
                                                    <i class="bx bx-edit"></i>
                                                </a>
                                                <a href="deleteAssignment?employeeId=${a.employee_id}&shopId=${a.store_id}" 
                                                   class="btn btn-sm btn-outline-danger" 
                                                   onclick="return confirm('Bạn có chắc muốn hủy phân công này?');" 
                                                   title="Xoá">
                                                    <i class="bx bx-trash"></i>
                                                </a>
                                                <c:if test="${a.roleName eq 'Manager'}">
                                                    <a href="ListShiftStaffServlet?shopId=${a.store_id}" 
                                                       class="btn btn-sm btn-outline-primary"
                                                       title="Xem chi tiết phân công">
                                                        <i class="bx bx-show"></i>
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty assignmentList}">
                                        <tr>
                                            <td colspan="4" class="text-center text-muted">🚫 Không có phân công nào</td>
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
                        <div class="mb-2 mb-md-0">© 2025, Hệ thống quản lý nhân sự</div>
                        <div>🏢 Giao diện tùy chỉnh từ Shift Panel</div>
                    </div>
                </footer>
            </div>
        </div>
    </div>
</div>

<!-- JS -->
<script src="assets/vendor/libs/jquery/jquery.js"></script>
<script src="assets/vendor/libs/popper/popper.js"></script>
<script src="assets/vendor/js/bootstrap.js"></script>
<script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="assets/vendor/js/menu.js"></script>
<script src="assets/js/main.js"></script>
</body>
</html>


