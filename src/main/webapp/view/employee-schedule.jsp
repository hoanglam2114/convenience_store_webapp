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
    data-template="vertical-menu-template-free"
    >
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
            />
        <title>Lịch Làm Việc Của Tôi</title>
        <meta name="description" content="" />
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
            />
        <!-- Icons -->
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <!-- Core CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <!-- Vendors CSS -->
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <style>
            .schedule-card {
                border: 1px solid #d9dee3;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 10px;
                background: #f8f9fa;
            }
            .day-header {
                font-weight: 600;
                color: #566a7f;
                margin-bottom: 10px;
            }
            .shift-info {
                background: #e7f3ff;
                border-left: 4px solid #007bff;
                padding: 10px;
                margin: 5px 0;
                border-radius: 4px;
            }
            .location-badge {
                background: #28a745;
                color: white;
                padding: 2px 8px;
                border-radius: 12px;
                font-size: 0.8em;
                margin-left: 5px;
            }
            .no-schedule {
                color: #6c757d;
                font-style: italic;
                text-align: center;
                padding: 20px;
            }
            .week-navigation {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .today {
                background: #fff3cd !important;
                border-color: #ffc107 !important;
            }
            .today .day-header {
                color: #856404;
            }
        </style>
    </head>

    <body>
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- Menu -->
                <jsp:include page="/common/site-bar.jsp"></jsp:include>
                    <!-- / Menu -->

                    <!-- Layout container -->
                    <div class="layout-page">
                        <!-- Navbar -->
                    <jsp:include page="/common/nav-bar.jsp"></jsp:include>
                        <!-- / Navbar -->

                        <!-- Content wrapper -->
                        <div class="content-wrapper">
                            <!-- Content -->
                            <div class="container-xxl flex-grow-1 container-p-y">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between align-items-center">
                                                <h5 class="mb-0">
                                                    <i class="bx bx-calendar me-2"></i>
                                                    Lịch Làm Việc Của Tôi
                                                </h5>
                                                <div class="employee-info">
                                                    <span class="badge bg-primary">
                                                        <i class="bx bx-user me-1"></i>
                                                    ${employee.name}
                                                </span>
                                            </div>
                                        </div>

                                        <div class="card-body">
                                            <c:if test="${not empty error}">
                                                <div class="alert alert-danger" role="alert">
                                                    ${error}
                                                </div>
                                            </c:if>

                                            <!-- Week Navigation -->
                                            <div class="week-navigation">
                                                <a href="employee-schedule?date=${selectedDate.minusWeeks(1)}" class="btn btn-outline-primary">
                                                    <i class="bx bx-chevron-left"></i> Tuần trước
                                                </a>
                                                <h6 class="mb-0">
                                                    Tuần từ ${startDateFormatted} đến ${endDateFormatted}
                                                </h6>
                                                <a href="employee-schedule?date=${selectedDate.plusWeeks(1)}" class="btn btn-outline-primary">
                                                    Tuần sau <i class="bx bx-chevron-right"></i>
                                                </a>
                                            </div>

                                            <!-- Weekly Schedule -->
                                            <div class="row">
                                                <c:forEach var="date" items="${weekDates}" varStatus="status">
                                                    <div class="col-md-12 mb-3">
                                                        <div class="schedule-card ${date.equals(selectedDate) ? 'today' : ''}">
                                                            <div class="day-header">
                                                                <c:set var="dayNames" value="${['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy']}" />
                                                                <i class="bx bx-calendar-event me-2"></i>
                                                                ${dayNames[date.dayOfWeek.value % 7]} - 
                                                                ${weekDatesFormatted[status.index]}
                                                                <c:if test="${date.equals(java.time.LocalDate.now())}">
                                                                    <span class="badge bg-warning ms-2">Hôm nay</span>
                                                                </c:if>
                                                            </div>

                                                            <c:set var="schedule" value="${dailyScheduleMap[date]}" />
                                                            <c:if test="${not empty schedule}">
                                                                <div class="shift-info">
                                                                    <div class="d-flex justify-content-between align-items-center">
                                                                        <div>
                                                                            <strong>
                                                                                <i class="bx bx-time me-1"></i>
                                                                                ${shiftMap[schedule.shiftId].shiftName}
                                                                            </strong>
                                                                            <br>
                                                                            <small class="text-muted">
                                                                                ${shiftMap[schedule.shiftId].startTime} - ${shiftMap[schedule.shiftId].endTime}
                                                                            </small>
                                                                        </div>
                                                                        <div>
                                                                            <c:if test="${not empty schedule.shopId}">
                                                                                <span class="location-badge">
                                                                                    <i class="bx bx-store me-1"></i>
                                                                                    ${shopMap[schedule.shopId].shopName}
                                                                                </span>
                                                                            </c:if>
                                                                            <c:if test="${not empty schedule.warehouseId}">
                                                                                <span class="location-badge" style="background: #17a2b8;">
                                                                                    <i class="bx bx-package me-1"></i>
                                                                                    ${warehouseMap[schedule.warehouseId].name}
                                                                                </span>
                                                                            </c:if>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:if>

                                                            <c:if test="${empty schedule}">
                                                                <div class="no-schedule">
                                                                    <i class="bx bx-calendar-x me-2"></i>
                                                                    Không có lịch làm việc
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>

                                            <!-- Legend -->
                                            <div class="row mt-4">
                                                <div class="col-md-12">
                                                    <div class="card bg-light">
                                                        <div class="card-body">
                                                            <h6 class="card-title">Chú thích:</h6>
                                                            <div class="d-flex flex-wrap gap-3">
                                                                <div>
                                                                    <span class="location-badge">
                                                                        <i class="bx bx-store me-1"></i>
                                                                        Cửa hàng
                                                                    </span>
                                                                </div>
                                                                <div>
                                                                    <span class="location-badge" style="background: #17a2b8;">
                                                                        <i class="bx bx-package me-1"></i>
                                                                        Kho hàng
                                                                    </span>
                                                                </div>
                                                                <div>
                                                                    <span class="badge bg-warning">
                                                                        <i class="bx bx-calendar me-1"></i>
                                                                        Hôm nay
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- / Content -->
                        <div class="content-backdrop fade"></div>
                    </div>
                    <!-- Content wrapper -->
                </div>
                <!-- / Layout page -->
            </div>
            <!-- Overlay -->
            <div class="layout-overlay layout-menu-toggle"></div>
        </div>
        <!-- / Layout wrapper -->

        <!-- Core JS -->
        <!-- Sneat JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html> 