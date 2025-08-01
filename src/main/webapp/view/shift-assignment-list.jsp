<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html
    lang="vi"
    class="light-style layout-menu-fixed"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="../assets/"
    data-template="vertical-menu-template-free">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
        <title>Phân công ca làm</title>
        <meta name="description" content="" />
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    </head>

    <body>
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <jsp:include page="/common/site-bar.jsp"></jsp:include>

                    <div class="layout-page">
                    <jsp:include page="/common/nav-bar.jsp"></jsp:include>

                        <div class="content-wrapper">
                            <div class="container-xxl flex-grow-1 container-p-y">
                                <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Quản lý /</span> Phân công ca làm</h4>

                                <!-- Form lọc -->
                                <div class="card mb-4">
                                    <h5 class="card-header">Xem lịch làm việc</h5>
                                    <div class="card-body">
                                        <form action="shift-assignment" method="GET">
                                            <input type="hidden" name="action" value="list">
                                            <div class="row">
                                                <div class="col-md-4 mb-3">
                                                    <label for="locationType" class="form-label">Loại địa điểm:</label>
                                                    <select name="locationType" id="locationType" class="form-select">
                                                        <option value="shop" ${selectedLocationType == 'shop' ? 'selected' : ''}>Cửa hàng</option>
                                                    <option value="warehouse" ${selectedLocationType == 'warehouse' ? 'selected' : ''}>Kho</option>
                                                </select>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label for="locationId" class="form-label">Địa điểm:</label>
                                                <select name="locationId" id="locationId" class="form-select"></select>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label for="workDate" class="form-label">Ngày làm việc:</label>
                                                <input type="date" name="workDate" value="${selectedDate}" class="form-control">
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Xem lịch</button>
                                    </form>
                                </div>
                            </div>

                            <c:if test="${not empty employees}">
                                <div class="row">
                                    <!-- Form thêm phân công -->
                                    <div class="col-md-4">
                                        <div class="card">
                                            <h5 class="card-header">Thêm phân công mới</h5>
                                            <div class="card-body">
                                                <form action="shift-assignment" method="POST">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="locationType" value="${selectedLocationType}">
                                                    <input type="hidden" name="locationId" value="${selectedLocationType == 'shop' ? selectedShopId : selectedWarehouseID}">
                                                    <input type="hidden" name="workDate" value="${selectedDate}">

                                                    <div class="mb-3">
                                                        <label for="employeeId" class="form-label">Nhân viên:</label>
                                                        <select name="employeeId" class="form-select">
                                                            <c:forEach var="employee" items="${employees}">
                                                                <option value="${employee.id}">${employee.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="shiftId" class="form-label">Ca làm:</label>
                                                        <select name="shiftId" class="form-select">
                                                            <c:forEach var="shift" items="${shifts}">
                                                                <option value="${shift.shiftId}">
                                                                    ${shift.shiftName} (${shift.startTime} - ${shift.endTime})
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>

                                                    <button type="submit" class="btn btn-success">Thêm</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Bảng lịch phân công -->
                                    <div class="col-md-8">
                                        <div class="card">
                                            <h5 class="card-header">Lịch làm việc ngày ${selectedDate}</h5>
                                            <div class="table-responsive text-nowrap">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>Nhân viên</th>
                                                            <th>Ca đã phân</th>
                                                            <th>Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="table-border-bottom-0">
                                                        <c:forEach var="employee" items="${employees}">
                                                            <tr>
                                                                <td><strong>${employee.name}</strong></td>
                                                                <td>
                                                                    <c:set var="schedule" value="${scheduleMap[employee.id]}"/>
                                                                    <c:if test="${not empty schedule}">
                                                                        <c:forEach var="shift" items="${shifts}">
                                                                            <c:if test="${shift.shiftId == schedule.shiftId}">
                                                                                <span class="badge bg-label-primary me-1">${shift.shiftName}</span>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </c:if>
                                                                    <c:if test="${empty schedule}">
                                                                        <span class="badge bg-label-warning me-1">Chưa phân</span>
                                                                    </c:if>
                                                                </td>
                                                                <td>
                                                                    <c:if test="${not empty schedule}">
                                                                        <form action="shift-assignment" method="POST" style="display:inline;">
                                                                            <input type="hidden" name="action" value="delete">
                                                                            <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                            <input type="hidden" name="locationType" value="${selectedLocationType}">
                                                                            <input type="hidden" name="locationId" value="${selectedLocationType == 'shop' ? selectedShopId : selectedWarehouseID}">
                                                                            <input type="hidden" name="workDate" value="${selectedDate}">
                                                                            <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
                                                                        </form>
                                                                    </c:if>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        <div class="content-backdrop fade"></div>
                    </div>
                </div>
            </div>
            <div class="layout-overlay layout-menu-toggle"></div>
        </div>

        <!-- Sneat JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
        <script src="assets/js/main.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const locationTypeSelect = document.getElementById('locationType');
                const locationIdSelect = document.getElementById('locationId');

                const shops = [];
            <c:forEach var="s" items="${shops}">
                shops.push({id: "${s.shopId}", name: "${s.shopName}"});
            </c:forEach>

                const warehouses = [];
            <c:forEach var="w" items="${warehouses}">
                warehouses.push({id: "${w.warehouseID}", name: "${w.name}"});
            </c:forEach>

                function populateLocations() {
                    const selectedType = locationTypeSelect.value;
                    locationIdSelect.innerHTML = '';

                    if (selectedType === 'shop') {
                        shops.forEach(s => {
                            const option = new Option(s.name, s.id);
                            locationIdSelect.add(option);
                        });
                    } else {
                        warehouses.forEach(w => {
                            const option = new Option(w.name, w.id);
                            locationIdSelect.add(option);
                        });
                    }
                }

                locationTypeSelect.addEventListener('change', populateLocations);

                populateLocations();
                const selectedId = "${selectedLocationType == 'shop' ? selectedShopId : selectedWarehouseID}";
                if (selectedId) {
                    locationIdSelect.value = selectedId;
                }
            });
        </script>
    </body>
</html>
