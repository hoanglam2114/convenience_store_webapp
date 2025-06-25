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

        <!-- Boxicons -->
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css"/>
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico"/>
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
                                <h4 class="fw-bold px-3 py-2 rounded text-white"
                                    style="background: linear-gradient(90deg, #5f72bd, #9b23ea); width: fit-content;">
                                    Shift Management
                                </h4>
                                
                            </div>
                            <form method="get" action="ListShift" class="mb-3">
                                <div class="input-group" style="max-width: 700px;">
                                    <input type="text" name="keyword" class="form-control" placeholder="Search shift name..."
                                           value="${param.keyword != null ? param.keyword : ''}" />
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bx bx-search"></i> Filter
                                    </button>
                                    <a href="ListShift" class="btn btn-secondary">
                                        <i class="bx bx-reset"></i> Reset
                                    </a>
                                    
                                </div>
                                <div class="input-group" style="max-width: 400px;">
                                    <a href="AddShiftServlet" class="btn btn-success shadow"
                                   style="background: linear-gradient(to right, #00c6ff, #0072ff); border: none;">
                                    <i class="bx bx-plus"></i> Add Shift
                                    </a>
                                </div>    
                                   
                                
                            </form>

                            <div class="card shadow">
                                <div class="table-responsive text-nowrap">
                                    <table class="table table-hover table-striped table-bordered">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Shift</th>
                                                <th>From Time</th>
                                                <th>To Time</th>
                                                <th>Weekdays</th>
                                                <th>Action</th>
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
                                                           class="btn btn-sm btn-icon btn-outline-primary me-1" title="Edit">
                                                            <i class="bx bx-edit-alt"></i>
                                                        </a>
                                                        <a href="deleteShift?id=${shift.shiftId}"
                                                           class="btn btn-sm btn-icon btn-outline-danger"
                                                           onclick="return confirm('Are you sure?');" title="Delete">
                                                            <i class="bx bx-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>

                                            <c:if test="${empty shiftList}">
                                                <tr>
                                                    <td colspan="6" class="text-center text-muted">No shift available.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Footer with Pagination -->
                        <footer class="content-footer footer bg-footer-theme">
                            <div class="container-xxl d-flex justify-content-center py-3">
                                <ul class="pagination pagination-rounded mb-0">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="ListShift?index=${currentPage - 1}">&laquo;</a>
                                    </li>

                                    <c:forEach begin="1" end="${endPage}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="ListShift?index=${i}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <li class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                                        <a class="page-link" href="ListShift?index=${currentPage + 1}">&raquo;</a>
                                    </li>
                                </ul>
                            </div>
                        </footer>
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
