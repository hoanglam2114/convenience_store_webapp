<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <title>Quản lý Kho</title>

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
        .warehouse-card {
            background: #2c3e50;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            color: white;
            position: relative;
        }
        .warehouse-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .warehouse-title {
            font-size: 18px;
            font-weight: bold;
            margin: 0;
        }
        .warehouse-status {
            background: #27ae60;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
        }
        .warehouse-info {
            margin-bottom: 15px;
        }
        .warehouse-info p {
            margin: 5px 0;
            font-size: 14px;
        }
        .staff-section {
            margin-bottom: 15px;
        }
        .staff-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .staff-item {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
        }
        .staff-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: #3498db;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            font-weight: bold;
            font-size: 12px;
        }
        .staff-info {
            flex: 1;
        }
        .staff-name {
            font-weight: bold;
            margin: 0;
        }
        .staff-role {
            font-size: 12px;
            color: #bdc3c7;
            margin: 0;
        }
        .staff-badge {
            background: #e74c3c;
            color: white;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 10px;
        }
        .view-detail-btn {
            background: #3498db;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 12px;
        }
        .view-detail-btn:hover {
            background: #2980b9;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: #2c3e50;
            margin: 5% auto;
            padding: 20px;
            border-radius: 10px;
            width: 80%;
            max-width: 800px;
            color: white;
            position: relative;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            position: absolute;
            right: 20px;
            top: 15px;
        }
        .close:hover {
            color: white;
        }
        .modal-header {
            margin-bottom: 20px;
        }
        .modal-title {
            font-size: 24px;
            margin: 0;
        }
        .detail-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .detail-table th,
        .detail-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #34495e;
        }
        .detail-table th {
            background-color: #34495e;
            font-weight: bold;
        }
        .detail-table tr:hover {
            background-color: #34495e;
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

        <!-- Site Bar -->
        <%@ include file="../common/site-bar.jsp" %>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar -->
            <%@ include file="/common/nav-bar.jsp" %>
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->
                <div class="container-xxl flex-grow-1 container-p-y">
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>
                    
                    <c:choose>
                        <c:when test="${isWarehouseDetail}">
                            <!-- Warehouse Detail View -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h1>Chi tiết kho: ${warehouseInfo.warehouseName}</h1>
                                <a href="${pageContext.request.contextPath}/warehouse-assignment" class="btn btn-secondary">
                                    <i class="bx bx-arrow-back"></i> Quay lại
                                </a>
                            </div>
                            
                            <!-- Warehouse Detail Modal Content -->
                            <div class="modal-content" style="display: block; position: relative; margin: 0; width: 100%;">
                                <div class="modal-header">
                                    <h2 class="modal-title">Chi tiết kho: ${warehouseInfo.warehouseName}</h2>
                                </div>
                                
                                <div class="warehouse-info">
                                    <p><i class="bx bx-map"></i> <strong>Địa chỉ:</strong> ${warehouseInfo.warehouseAddress}</p>
                                    <p><i class="bx bx-phone"></i> <strong>Điện thoại:</strong> ${warehouseInfo.warehousePhone}</p>
                                    <p><i class="bx bx-time"></i> <strong>Giờ làm việc:</strong> ${warehouseInfo.warehouseWorkingHours}</p>
                                </div>
                                
                                <h3>Danh sách nhân sự</h3>
                                <table class="detail-table">
                                    <thead>
                                        <tr>
                                            <th>Tên nhân viên</th>
                                            <th>Vai trò</th>
                                            <th>Địa chỉ</th>
                                            <th>Điện thoại</th>
                                            <th>Ngày bắt đầu</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="assignment" items="${assignments}">
                                            <c:if test="${assignment.active}">
                                                <tr>
                                                    <td>${assignment.employeeName}</td>
                                                    <td>
                                                        <span class="staff-badge" style="background: ${assignment.assignmentRole == 'Quản lý' || assignment.assignmentRole == 'Manager' ? '#e74c3c' : '#3498db'}">
                                                            ${assignment.assignmentRole}
                                                        </span>
                                                    </td>
                                                    <td>${assignment.employeeAddress}</td>
                                                    <td>${assignment.employeePhone}</td>
                                                    <td>
                                                        <fmt:formatDate value="${assignment.startDate}" pattern="dd/MM/yyyy"/>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            
                        </c:when>
                        <c:when test="${isAssignmentDetail}">
                            <!-- Assignment Detail View -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h1>Chi tiết phân công</h1>
                                <a href="${pageContext.request.contextPath}/warehouse-assignment" class="btn btn-secondary">
                                    <i class="bx bx-arrow-back"></i> Quay lại
                                </a>
                            </div>
                            
                            <div class="modal-content" style="display: block; position: relative; margin: 0; width: 100%;">
                                <div class="modal-header">
                                    <h2 class="modal-title">Thông tin phân công</h2>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <h4>Thông tin nhân viên</h4>
                                        <p><strong>Tên:</strong> ${assignment.employeeName}</p>
                                        <p><strong>Điện thoại:</strong> ${assignment.employeePhone}</p>
                                        <p><strong>Địa chỉ:</strong> ${assignment.employeeAddress}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h4>Thông tin kho</h4>
                                        <p><strong>Tên kho:</strong> ${assignment.warehouseName}</p>
                                        <p><strong>Địa chỉ:</strong> ${assignment.warehouseAddress}</p>
                                        <p><strong>Điện thoại:</strong> ${assignment.warehousePhone}</p>
                                        <p><strong>Giờ làm việc:</strong> ${assignment.warehouseWorkingHours}</p>
                                    </div>
                                </div>
                                
                                <div class="row mt-3">
                                    <div class="col-md-12">
                                        <h4>Thông tin phân công</h4>
                                        <p><strong>Vai trò:</strong> 
                                            <span class="staff-badge" style="background: ${assignment.assignmentRole == 'Quản lý' || assignment.assignmentRole == 'Manager' ? '#e74c3c' : '#3498db'}">
                                                ${assignment.assignmentRole}
                                            </span>
                                        </p>
                                        <p><strong>Ngày bắt đầu:</strong> 
                                            <fmt:formatDate value="${assignment.startDate}" pattern="dd/MM/yyyy"/>
                                        </p>
                                        <c:if test="${not empty assignment.endDate}">
                                            <p><strong>Ngày kết thúc:</strong> 
                                                <fmt:formatDate value="${assignment.endDate}" pattern="dd/MM/yyyy"/>
                                            </p>
                                        </c:if>
                                        <p><strong>Trạng thái:</strong> 
                                            <span class="warehouse-status" style="background: ${assignment.active ? '#27ae60' : '#e74c3c'}">
                                                ${assignment.active ? 'Đang hoạt động' : 'Không hoạt động'}
                                            </span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            
                        </c:when>
                        <c:otherwise>
                            <!-- Main Warehouse List View -->
                            <h1>Quản lý Kho</h1>
                            
                            <div class="row">
                                <c:forEach var="warehouse" items="${warehouses}">
                                    <div class="col-md-4">
                                        <div class="warehouse-card">
                                            <div class="warehouse-header">
                                                <h3 class="warehouse-title">${warehouse.warehouseName}</h3>
                                                <span class="warehouse-status">Đang hoạt động</span>
                                            </div>
                                            
                                            <div class="warehouse-info">
                                                <p><i class="bx bx-map"></i> ${warehouse.warehouseAddress}</p>
                                                <p><i class="bx bx-phone"></i> ${warehouse.warehousePhone}</p>
                                                <p><i class="bx bx-time"></i> ${warehouse.warehouseWorkingHours}</p>
                                            </div>
                                            
                                            <div class="staff-section">
                                                <div class="staff-title">Quản lý</div>
                                                <c:set var="managerCount" value="${managerCountMap[warehouse.warehouseId]}" />
                                                <c:set var="staffCount" value="${staffCountMap[warehouse.warehouseId]}" />
                                                
                                                <c:if test="${managerCount > 0}">
                                                    <c:forEach var="assignment" items="${warehouseAssignmentsMap[warehouse.warehouseId]}" varStatus="status">
                                                        <c:if test="${assignment.active && (assignment.assignmentRole == 'Quản lý' || assignment.assignmentRole == 'Manager')}">
                                                            <div class="staff-item">
                                                                <div class="staff-avatar">
                                                                    ${assignment.employeeName.substring(0, 1).toUpperCase()}
                                                                </div>
                                                                <div class="staff-info">
                                                                    <p class="staff-name">${assignment.employeeName}</p>
                                                                    <p class="staff-role">${assignment.assignmentRole} | ${assignment.employeePhone}</p>
                                                                </div>
                                                                <span class="staff-badge">Quản lý</span>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                                
                                                <c:if test="${managerCount == 0}">
                                                    <p style="color: #bdc3c7; font-style: italic;">Chưa có quản lý</p>
                                                </c:if>
                                            </div>
                                            
                                            <div class="staff-section">
                                                <div class="staff-title">Nhân viên (${staffCount})</div>
                                                <c:set var="displayedStaff" value="0" />
                                                <c:forEach var="assignment" items="${warehouseAssignmentsMap[warehouse.warehouseId]}">
                                                    <c:if test="${assignment.active && (assignment.assignmentRole == 'Nhân viên' || assignment.assignmentRole == 'Staff') && displayedStaff < 2}">
                                                        <div class="staff-item">
                                                            <div class="staff-avatar" style="background: #27ae60;">
                                                                ${assignment.employeeName.substring(0, 1).toUpperCase()}
                                                            </div>
                                                            <div class="staff-info">
                                                                <p class="staff-name">${assignment.employeeName}</p>
                                                                <p class="staff-role">${assignment.assignmentRole} | ${assignment.employeePhone}</p>
                                                            </div>
                                                            <span class="staff-badge" style="background: #3498db;">Nhân viên</span>
                                                        </div>
                                                        <c:set var="displayedStaff" value="${displayedStaff + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                
                                                <c:if test="${staffCount == 0}">
                                                    <p style="color: #bdc3c7; font-style: italic;">Chưa có nhân viên</p>
                                                </c:if>
                                            </div>
                                            
                                            <div class="text-center mt-3">
                                                <button class="view-detail-btn" onclick="viewWarehouseDetail(${warehouse.warehouseId})">
                                                    Xem chi tiết
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
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
                            , made with ❤️ by
                            <a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
                        </div>
                        <div>
                            <a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a>
                            <a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More
                                Themes</a>
                            <a
                                    href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/"
                                    target="_blank"
                                    class="footer-link me-4"
                            >Documentation</a>
                            <a
                                    href="https://github.com/themeselection/sneat-html-admin-template-free/issues"
                                    target="_blank"
                                    class="footer-link me-4"
                            >Support</a>
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
<!-- endbuild -->
<!-- Vendors JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/apex-charts/apexcharts.js"></script>
<!-- Main JS -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<!-- Page JS -->
<script src="${pageContext.request.contextPath}/assets/js/dashboards-analytics.js"></script>
<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<script>
    function viewWarehouseDetail(warehouseId) {
        window.location.href = '${pageContext.request.contextPath}/warehouse-assignment?action=detail&warehouseId=' + warehouseId;
    }
    
    function viewAssignmentDetail(assignmentId) {
        window.location.href = '${pageContext.request.contextPath}/warehouse-assignment?action=view&assignmentId=' + assignmentId;
    }
</script>

</body>
</html>