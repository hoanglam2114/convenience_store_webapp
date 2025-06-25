<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

    <title>Quản lý phân công nhân viên</title>

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
        .assignment-card {
            background: #2c3e50;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            color: white;
            position: relative;
        }
        .assignment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .assignment-title {
            font-size: 18px;
            font-weight: bold;
            margin: 0;
        }
        .assignment-status {
            background: #27ae60;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
        }
        .assignment-info {
            margin-bottom: 15px;
        }
        .assignment-info p {
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
        .add-form-card {
            background: #34495e;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            color: white;
        }
        .form-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #ecf0f1;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #bdc3c7;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #7f8c8d;
            border-radius: 5px;
            background: #2c3e50;
            color: white;
        }
        .form-control:focus {
            border-color: #3498db;
            outline: none;
        }
        .btn-primary {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn-primary:hover {
            background: #2980b9;
        }
        .btn-secondary {
            background: #95a5a6;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-secondary:hover {
            background: #7f8c8d;
        }
        /* Bootstrap Modal Customization */
        .modal-content {
            background-color: #2c3e50;
            color: white;
            border: none;
        }
        .modal-header {
            background-color: #34495e;
            border-bottom: 1px solid #495057;
        }
        .modal-body {
            background-color: #2c3e50;
        }
        .modal-title {
            color: white;
        }
        .btn-close-white {
            filter: invert(1) grayscale(100%) brightness(200%);
        }
        
        /* Modal form styling */
        .modal .form-control {
            background-color: #34495e;
            border: 1px solid #495057;
            color: white;
        }
        
        .modal .form-control:focus {
            background-color: #34495e;
            border-color: #3498db;
            color: white;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }
        
        .modal .btn {
            pointer-events: auto;
            z-index: auto;
        }
        
        /* Ensure modal content is clickable */
        .modal-dialog {
            pointer-events: none;
        }
        
        .modal-content {
            pointer-events: auto;
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
        
        /* Assignment Actions Styling */
        .assignment-actions {
            display: flex;
            gap: 8px;
            margin-top: 15px;
            justify-content: flex-end;
        }
        
        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .btn-info {
            background-color: #17a2b8;
            color: white;
        }
        
        .btn-info:hover {
            background-color: #138496;
            color: white;
        }
        
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        
        .btn-warning:hover {
            background-color: #e0a800;
            color: #212529;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
            color: white;
        }
        
        .btn-sm {
            padding: 6px 10px;
            font-size: 11px;
        }
        
        /* Assignment Type Badge */
        .assignment-type {
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
        }
        
        .shop-type {
            background-color: #28a745;
            color: white;
        }
        
        .warehouse-type {
            background-color: #fd7e14;
            color: white;
        }
        
        /* Staff Details Styling */
        .staff-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .staff-details {
            flex: 1;
        }
        
        .staff-name {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 4px;
            color: #ecf0f1;
        }
        
        .staff-role {
            font-size: 12px;
            padding: 2px 8px;
            border-radius: 10px;
            display: inline-block;
            margin-bottom: 4px;
        }
        
        .staff-role.manager {
            background-color: #e74c3c;
            color: white;
        }
        
        .staff-role.staff {
            background-color: #3498db;
            color: white;
        }
        
        .staff-contact {
            font-size: 12px;
            color: #bdc3c7;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        /* Info Items */
        .info-item {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
            font-size: 13px;
            color: #bdc3c7;
        }
        
        .info-item i {
            color: #3498db;
        }
        
        /* Grid Layout */
        .assignments-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        /* No assignments styling */
        .no-assignments {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
            grid-column: 1 / -1;
        }
        
        .no-assignments i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #bdc3c7;
        }
        
        .no-assignments h5 {
            margin-bottom: 10px;
            color: #95a5a6;
        }
        
        /* Alert styling */
        .alert {
            padding: 12px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: none;
        }
        
        .alert-danger {
            background-color: #e74c3c;
            color: white;
        }
        
        .alert-success {
            background-color: #27ae60;
            color: white;
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
            <%--<%@ include file="/common/nav-bar.jsp" %>--%>
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
                    
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                            ${success}
                        </div>
                    </c:if>
                    
                    <!-- Main Assignment Management View -->
                    <h1>Quản lý phân công nhân viên</h1>
                    
                    <!-- Add Assignment Form -->
                    <div class="add-form-card">
                        <div class="form-title">
                            <i class="bx bx-plus-circle"></i> Thêm phân công mới
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/assignment-management" method="post" onsubmit="enableAllFields()">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="row">
                                <!-- Employee Selection -->
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="employeeId" class="form-label">
                                            <i class="bx bx-user"></i> Nhân viên *
                                        </label>
                                        <select class="form-control" id="employeeId" name="employeeId" required>
                                            <option value="">-- Chọn nhân viên --</option>
                                            <c:forEach var="employee" items="${employees}">
                                                <option value="${employee.id}">
                                                    ${employee.name} - ${employee.phone}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Location Type Selection -->
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="locationType" class="form-label">
                                            <i class="bx bx-map"></i> Loại địa điểm *
                                        </label>
                                        <select class="form-control" id="locationType" name="locationType" required onchange="updateLocationOptions()">
                                            <option value="">-- Chọn loại --</option>
                                            <option value="shop">Cửa hàng</option>
                                            <option value="warehouse">Kho hàng</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Location Selection -->
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="locationId" class="form-label">
                                            <i class="bx bx-building"></i> Địa điểm *
                                        </label>
                                        <select class="form-control" id="locationId" name="locationId" required disabled>
                                            <option value="">-- Chọn địa điểm --</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Role Selection -->
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="assignmentRole" class="form-label">
                                            <i class="bx bx-user-check"></i> Vai trò *
                                        </label>
                                        <select class="form-control" id="assignmentRole" name="assignmentRole" required disabled>
                                            <option value="">-- Chọn vai trò --</option>
                                            <option value="Manager">Quản lý</option>
                                            <option value="Staff">Nhân viên</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row mt-3">
                                <!-- Start Date Selection -->
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="startDate" class="form-label">
                                            <i class="bx bx-calendar"></i> Ngày bắt đầu
                                        </label>
                                        <input type="date" class="form-control" id="startDate" name="startDate" 
                                               value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                                        <small class="form-text text-muted">Để trống sẽ sử dụng ngày hiện tại</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row mt-3">
                                <div class="col-12">
                                    <button type="submit" class="btn-primary">
                                        <i class="bx bx-plus"></i> Thêm phân công
                                    </button>
                                    <button type="reset" class="btn-secondary" onclick="resetForm()">
                                        <i class="bx bx-reset"></i> Đặt lại
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Current Assignments -->
                    <div class="assignments-grid">
                        <!-- Shop Assignments -->
                        <c:forEach var="assignment" items="${shopAssignments}">
                            <div class="assignment-card">
                                <div class="assignment-header">
                                    <div class="assignment-title">
                                        <i class="bx bx-store"></i>
                                        <span>${assignment.shopName}</span>
                                    </div>
                                    <div class="assignment-type shop-type">Cửa hàng</div>
                                </div>
                                
                                <div class="staff-section">
                                    <div class="staff-info">
                                        <div class="staff-avatar">
                                            <i class="bx bx-user"></i>
                                        </div>
                                        <div class="staff-details">
                                            <div class="staff-name">${assignment.employeeName}</div>
                                            <div class="staff-role ${assignment.assignmentRole == 'Manager' ? 'manager' : 'staff'}">
                                                ${assignment.assignmentRole}
                                            </div>
                                            <div class="staff-contact">
                                                <i class="bx bx-phone"></i> ${assignment.employeePhone}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="assignment-info">
                                    <div class="info-item">
                                        <i class="bx bx-map"></i>
                                        <span>${assignment.shopAddress}</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="bx bx-time"></i>
                                        <span><fmt:formatDate value="${assignment.startDate}" pattern="dd/MM/yyyy" /></span>
                                    </div>
                                </div>
                                
                                <div class="assignment-actions">
                                    <button type="button" onclick="viewAssignmentDetail('shop', ${assignment.assignmentId})" 
                                       class="btn btn-info btn-sm" data-bs-toggle="tooltip" title="Xem chi tiết">
                                        <i class="bx bx-show"></i>
                                    </button>
                                    <button type="button" onclick="editAssignment('shop', ${assignment.assignmentId})" 
                                       class="btn btn-warning btn-sm" data-bs-toggle="tooltip" title="Chỉnh sửa">
                                        <i class="bx bx-edit"></i>
                                    </button>
                                    <button type="button" onclick="doDeleteAssignment('shop', ${assignment.assignmentId})" 
                                       class="btn btn-danger btn-sm" data-bs-toggle="tooltip" title="Xóa phân công">
                                        <i class="bx bx-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <!-- Warehouse Assignments -->
                        <c:forEach var="assignment" items="${warehouseAssignments}">
                            <div class="assignment-card">
                                <div class="assignment-header">
                                    <div class="assignment-title">
                                        <i class="bx bx-package"></i>
                                        <span>${assignment.warehouseName}</span>
                                    </div>
                                    <div class="assignment-type warehouse-type">Kho hàng</div>
                                </div>
                                
                                <div class="staff-section">
                                    <div class="staff-info">
                                        <div class="staff-avatar">
                                            <i class="bx bx-user"></i>
                                        </div>
                                        <div class="staff-details">
                                            <div class="staff-name">${assignment.employeeName}</div>
                                            <div class="staff-role ${assignment.assignmentRole == 'Manager' ? 'manager' : 'staff'}">
                                                ${assignment.assignmentRole}
                                            </div>
                                            <div class="staff-contact">
                                                <i class="bx bx-phone"></i> ${assignment.employeePhone}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="assignment-info">
                                    <div class="info-item">
                                        <i class="bx bx-map"></i>
                                        <span>${assignment.warehouseAddress}</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="bx bx-time"></i>
                                        <span><fmt:formatDate value="${assignment.startDate}" pattern="dd/MM/yyyy" /></span>
                                    </div>
                                </div>
                                
                                <div class="assignment-actions">
                                    <button type="button" onclick="viewAssignmentDetail('warehouse', ${assignment.assignmentId})" 
                                       class="btn btn-info btn-sm" data-bs-toggle="tooltip" title="Xem chi tiết">
                                        <i class="bx bx-show"></i>
                                    </button>
                                    <button type="button" onclick="editAssignment('warehouse', ${assignment.assignmentId})" 
                                       class="btn btn-warning btn-sm" data-bs-toggle="tooltip" title="Chỉnh sửa">
                                        <i class="bx bx-edit"></i>
                                    </button>
                                    <button type="button" onclick="doDeleteAssignment('warehouse', ${assignment.assignmentId})" 
                                       class="btn btn-danger btn-sm" data-bs-toggle="tooltip" title="Xóa phân công">
                                        <i class="bx bx-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <!-- No assignments message -->
                        <c:if test="${empty shopAssignments and empty warehouseAssignments}">
                            <div class="no-assignments">
                                <i class="bx bx-inbox"></i>
                                <h5>Chưa có phân công nào</h5>
                                <p>Hãy thêm phân công mới bằng form ở trên.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->
        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->
    
    <!-- Assignment Detail Modal -->
    <div class="modal fade" id="assignmentDetailModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-info-circle me-2"></i>
                        Chi tiết phân công
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="assignmentDetailContent">
                    <!-- Content will be loaded here -->
                </div>
            </div>
        </div>
    </div>
    
    <!-- Edit Assignment Modal -->
    <div class="modal fade" id="editAssignmentModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-edit me-2"></i>
                        Chỉnh sửa phân công
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="editAssignmentContent">
                    <!-- Content will be loaded here -->
                </div>
            </div>
        </div>
    </div>
    

</div>
 
<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/popper/popper.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

<!-- Page specific script -->
<script>
    // Shop and warehouse data for dropdowns
    const shops = [
        <c:forEach var="shop" items="${shops}" varStatus="status">
            {
                id: ${shop.shopId},
                name: '${fn:escapeXml(shop.shopName)}',
                address: '${fn:escapeXml(shop.shopAddress)}'
            }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    
    const warehouses = [
        <c:forEach var="warehouse" items="${warehouses}" varStatus="status">
            {
                id: ${warehouse.warehouseId},
                name: '${fn:escapeXml(warehouse.name)}',
                address: '${fn:escapeXml(warehouse.address)}'
            }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    
    console.log('Shops loaded:', shops);
    console.log('Warehouses loaded:', warehouses);
    
    function updateLocationOptions() {
        console.log('updateLocationOptions called');
        const locationType = document.getElementById('locationType').value;
        console.log('Selected location type:', locationType);
        const locationSelect = document.getElementById('locationId');
        const roleSelect = document.getElementById('assignmentRole');
        
        // Clear previous options
        locationSelect.innerHTML = '<option value="">-- Chọn địa điểm --</option>';
        
        if (locationType === 'shop') {
            shops.forEach(shop => {
                const option = document.createElement('option');
                option.value = shop.id;
                option.textContent = shop.name + ' - ' + shop.address;
                locationSelect.appendChild(option);
            });
            locationSelect.disabled = false;
            roleSelect.disabled = false;
        } else if (locationType === 'warehouse') {
            warehouses.forEach(warehouse => {
                const option = document.createElement('option');
                option.value = warehouse.id;
                option.textContent = warehouse.name + ' - ' + warehouse.address;
                locationSelect.appendChild(option);
            });
            locationSelect.disabled = false;
            roleSelect.disabled = false;
        } else {
            locationSelect.disabled = true;
            roleSelect.disabled = true;
        }
    }
    
    function resetForm() {
        document.getElementById('employeeId').value = '';
        document.getElementById('locationType').value = '';
        document.getElementById('locationId').innerHTML = '<option value="">-- Chọn địa điểm --</option>';
        document.getElementById('locationId').disabled = true;
        document.getElementById('assignmentRole').value = '';
        document.getElementById('assignmentRole').disabled = true;
        document.getElementById('startDate').value = '<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>';
    }
    
    function enableAllFields() {
        // Enable all form fields before submission to ensure values are sent
        document.getElementById('locationId').disabled = false;
        document.getElementById('assignmentRole').disabled = false;
        return true;
    }
    
    function doDeleteAssignment(type, assignmentId) {
        if (confirm('Bạn có muốn xóa phân công có ID là ' + assignmentId + ' không?')) {
            window.location = '${pageContext.request.contextPath}/assignment-management?action=delete&type=' + type + '&assignmentId=' + assignmentId;
        }
    }
    
    // Function to view assignment detail in modal
    function viewAssignmentDetail(type, assignmentId) {
        console.log('Viewing assignment detail:', type, assignmentId);
        
        // Show loading in modal
        const modalContent = document.getElementById('assignmentDetailContent');
        modalContent.innerHTML = '<div class="text-center"><i class="bx bx-loader-alt bx-spin"></i> Đang tải...</div>';
        
        // Show modal
        const modal = new bootstrap.Modal(document.getElementById('assignmentDetailModal'));
        modal.show();
        
        // Load content via AJAX
        fetch('${pageContext.request.contextPath}/assignment-management?action=view&type=' + type + '&assignmentId=' + assignmentId + '&ajax=true')
            .then(response => response.text())
            .then(data => {
                modalContent.innerHTML = data;
            })
            .catch(error => {
                console.error('Error loading assignment detail:', error);
                modalContent.innerHTML = '<div class="alert alert-danger">Có lỗi xảy ra khi tải thông tin phân công.</div>';
            });
    }
    
    // Function to edit assignment in modal
    function editAssignment(type, assignmentId) {
        console.log('Editing assignment:', type, assignmentId);
        
        // Show loading in modal
        const modalContent = document.getElementById('editAssignmentContent');
        modalContent.innerHTML = '<div class="text-center"><i class="bx bx-loader-alt bx-spin"></i> Đang tải...</div>';
        
        // Show modal
        const modal = new bootstrap.Modal(document.getElementById('editAssignmentModal'));
        modal.show();
        
        // Load content via AJAX
        fetch('${pageContext.request.contextPath}/assignment-management?action=edit&type=' + type + '&assignmentId=' + assignmentId + '&ajax=true')
            .then(response => response.text())
            .then(data => {
                modalContent.innerHTML = data;
            })
            .catch(error => {
                console.error('Error loading assignment edit form:', error);
                modalContent.innerHTML = '<div class="alert alert-danger">Có lỗi xảy ra khi tải form chỉnh sửa.</div>';
            });
    }
</script>
    
</body>
</html>