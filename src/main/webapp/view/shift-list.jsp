<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Shift" %>

<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="assets/"
      data-template="vertical-menu-template-free">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Shift Management</title>

    <!-- Sneat CSS -->
    <link rel="stylesheet" href="assets/vendor/css/core.css"/>
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css"/>
    <link rel="stylesheet" href="assets/css/demo.css"/>
    <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>
    <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css"/>
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico"/>

    <style>
        body { background-color: #f5f7fa; font-family: 'Public Sans', sans-serif; }
        .page-title { background: linear-gradient(90deg, #696cff, #00cfe8); color: white; padding: 10px 25px; border-radius: 10px; font-weight: 600; font-size: 1.5rem; box-shadow: 0 3px 8px rgba(105, 108, 255, 0.3);}
        .table thead { background: linear-gradient(to right, #696cff, #00cfe8); }
        .table thead th { color: white !important; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;}
        .table-hover tbody tr:hover { background-color: #eef2f7; transition: background 0.3s;}
        .btn { border-radius: 0.5rem; transition: all 0.3s ease-in-out;}
        .btn:hover { box-shadow: 0 4px 12px rgba(67, 89, 113, 0.2);}
        .btn-primary { background-color: #696cff; border-color: #696cff;}
        .btn-secondary { background-color: #8592a3; border-color: #8592a3;}
        .btn-success { background-color: #71dd37; border-color: #71dd37;}
        .btn-outline-primary { border-color: #696cff; color: #696cff;}
        .btn-outline-primary:hover { background-color: #696cff; color: white;}
        .btn-outline-danger { border-color: #ff3e1d; color: #ff3e1d;}
        .btn-outline-danger:hover { background-color: #ff3e1d; color: white;}
        .pagination .page-item.active .page-link { background-color: #696cff; border-color: #696cff; color: white;}
        .card { border-radius: 12px; box-shadow: 0 4px 16px rgba(105, 108, 255, 0.1);}
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
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="page-title">Shift Management</div>
                    </div>
                    
                    <!-- FILTER FORM -->
                    <form method="get" action="ListShift" class="mb-3">
                        <div class="row mb-3 align-items-end">
                            <div class="col-md-3">
                                <label for="keyword" class="form-label">Tên ca</label>
                                <input type="text" id="keyword" name="keyword" class="form-control" placeholder="Nhập tên ca"
                                       value="${param.keyword != null ? param.keyword : ''}">
                            </div>
                            <div class="col-md-2">
                                <label for="fromTime" class="form-label">Giờ bắt đầu</label>
                                <input type="time" id="fromTime" name="fromTime" class="form-control"
                                       value="${param.fromTime != null ? param.fromTime : ''}">
                            </div>
                            <div class="col-md-2">
                                <label for="toTime" class="form-label">Giờ kết thúc</label>
                                <input type="time" id="toTime" name="toTime" class="form-control"
                                       value="${param.toTime != null ? param.toTime : ''}">
                            </div>
                            <div class="col-md-3">
                                <label for="weekday" class="form-label">Ngày trong tuần</label>
                                <select id="weekday" name="weekday" class="form-control">
                                    <option value="">-- Tất cả --</option>
                                    <option value="Monday" ${param.weekday == 'Monday' ? 'selected' : ''}>Monday</option>
                                    <option value="Tuesday" ${param.weekday == 'Tuesday' ? 'selected' : ''}>Tuesday</option>
                                    <option value="Wednesday" ${param.weekday == 'Wednesday' ? 'selected' : ''}>Wednesday</option>
                                    <option value="Thursday" ${param.weekday == 'Thursday' ? 'selected' : ''}>Thursday</option>
                                    <option value="Friday" ${param.weekday == 'Friday' ? 'selected' : ''}>Friday</option>
                                    <option value="Saturday" ${param.weekday == 'Saturday' ? 'selected' : ''}>Saturday</option>
                                    <option value="Sunday" ${param.weekday == 'Sunday' ? 'selected' : ''}>Sunday</option>
                                </select>
                            </div>
                            <div class="col-md-2 d-flex gap-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="bx bx-search"></i> Lọc
                                </button>
                                <a href="ListShift" class="btn btn-secondary w-100">
                                    <i class="bx bx-reset"></i> Reset
                                </a>
                            </div>
                        </div>
                        <div class="mb-4">
                            <a href="AddShiftServlet" class="btn btn-success shadow">
                                <i class="bx bx-plus"></i> Thêm ca
                            </a>
                        </div>
                    </form>
                    <!-- END FILTER FORM -->

                    <div class="card">
                        <div class="table-responsive text-nowrap">
                            <table class="table table-hover table-bordered">
                                <thead>
                                <tr>
                                    <th>Tên ca</th>
                                    <th>Giờ bắt đầu</th>
                                    <th>Giờ kết thúc</th>
                                    <th>Ngày làm việc</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="shift" items="${shiftList}">
                                    <tr>
                                        <td>${shift.shiftName}</td>
                                        <td>${shift.startTime}</td>
                                        <td>${shift.endTime}</td>
                                        <td>
                                            <c:forEach var="day" items="${shift.workingDays}">
                                                <div>${day}</div>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <a href="EditShift?id=${shift.shiftId}"
                                               class="btn btn-sm btn-icon btn-outline-primary me-1" title="Sửa">
                                                <i class="bx bx-edit-alt"></i>
                                            </a>
                                            <a href="deleteShift?id=${shift.shiftId}"
                                               class="btn btn-sm btn-icon btn-outline-danger"
                                               onclick="return confirm('Bạn chắc chắn xóa?');" title="Xóa">
                                                <i class="bx bx-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty shiftList}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted">Không có ca nào phù hợp.</td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- PHÂN TRANG -->
                <footer class="content-footer footer bg-footer-theme mt-3">
                    <div class="container-xxl d-flex justify-content-center py-3">
                        <ul class="pagination pagination-rounded mb-0">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link"
                                   href="ListShift?index=${currentPage - 1
                                    }&keyword=${param.keyword}&fromTime=${param.fromTime}&toTime=${param.toTime}&weekday=${param.weekday}">&laquo;</a>
                            </li>
                            <c:forEach begin="1" end="${endPage}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="ListShift?index=${i
                                        }&keyword=${param.keyword}&fromTime=${param.fromTime}&toTime=${param.toTime}&weekday=${param.weekday}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                                <a class="page-link"
                                   href="ListShift?index=${currentPage + 1
                                    }&keyword=${param.keyword}&fromTime=${param.fromTime}&toTime=${param.toTime}&weekday=${param.weekday}">&raquo;</a>
                            </li>
                        </ul>
                    </div>
                </footer>
                <!-- END PHÂN TRANG -->
            </div>
        </div>
    </div>
</div>

<!-- Sneat JS -->
<script src="assets/vendor/libs/jquery/jquery.js"></script>
<script src="assets/vendor/js/bootstrap.js"></script>
<script src="assets/vendor/js/menu.js"></script>
<script src="assets/vendor/js/helpers.js"></script>
<script src="assets/js/config.js"></script>
<script src="assets/js/main.js"></script>
</body>
</html>
