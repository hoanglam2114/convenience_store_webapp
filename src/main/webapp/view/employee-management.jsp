<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quản Lý Nhân Viên</title>

        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" /> 
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <!-- Boxicons -->
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" /> 

        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="java.util.*, model.Employees" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    </head>

    <body>
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">

                <!-- Sidebar -->
                <%@ include file="/common/site-bar.jsp" %>

                <!-- Layout page -->
                <div class="layout-page">

                    <!-- Navbar -->
                    <%@ include file="/common/nav-bar.jsp" %>

                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">

                            <!-- Main content -->
                            <h4 class="fw-bold py-3 mb-4">
                                <span class="text-muted fw-light">Quản Lý /</span> Quản Lý Nhân Viên
                            </h4>

                            <!-- Add Staff Button -->
                            <div class="mb-3">
                                <a href="addEmployee" class="btn btn-primary">
                                    <i class="bx bx-plus"></i> Thêm
                                </a>
                            </div>

                            <!--Add Staff Search-->                            
                            <div class="mb-3" style="max-width: 300px;">
                                <form action="searchEmployee" method="POST">
                                    <div class="input-group input-group-merge">
                                        <input
                                            type="text"
                                            id="employeeSearch"
                                            name="employeeSearch"
                                            class="form-control"
                                            placeholder="Tìm kiếm..."
                                            aria-label="Search"
                                            aria-describedby="basic-addon-search"
                                            />
                                        <button class="btn btn-outline-secondary" type="submit" id="btnSearch">
                                            <i class="bx bx-search"></i>
                                        </button>
                                        <button class="btn btn-outline-secondary" type="button" id="btnReset" onclick="window.location.href = 'listEmployee'">
                                            <i class="bx bx-reset"></i>
                                        </button>
                                    </div>
                                </form>                               
                            </div>

                            <!-- Staff Table -->
                            <div class="card">
                                <div class="table-responsive text-nowrap">
                                    <table class="table"> 
                                        <thead class="table-light"> 
                                            <tr> 
                                                <th>Tên</th>
                                                <th>Số Điện Thoại</th>
                                                <th>Địa Chỉ</th>
                                                <th>Trạng Thái</th>
                                                <th>Hoạt Động</th>
                                            </tr> 
                                        </thead> 
                                        <tbody class="table-border-bottom-0"> 
                                            <% 
                                            List<Employees> employeeList = (List<Employees>) request.getAttribute("employeeList");
                                            if (employeeList != null && !employeeList.isEmpty()) {
                                            for (Employees emp : employeeList) { 
                                            %>
                                            <tr>
                                                <td><%= emp.getName()%></td>
                                                <td><%= emp.getPhone()%></td>
                                                <td><%= emp.getAddress()%></td>
                                                <td><span class="badge bg-success">Active</span></td>
                                                <td> 
                                                    <a href="editStaff?id=<%= emp.getId()%>" class="btn btn-sm btn-icon btn-outline-primary" data-bs-toggle="tooltip" title="Edit">
                                                        <i class="bx bx-edit"></i>
                                                    </a> 
                                                    <button type="button" class="btn btn-sm btn-icon btn-outline-danger" onclick="confirmDelete(<%= emp.getId()%>)">
                                                        <i class="bx bx-trash"></i>
                                                    </button> 
                                                </td>
                                            </tr>
                                            <% 
                                                } 
                                            }else{
                                            %>
                                            <tr><td colspan="5">Không có thông tin để hiển thị.</td></tr>
                                            <% 
                                                } 
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /Main content -->

                        <!-- Footer -->
                        <footer class="content-footer footer bg-footer-theme">
                            <div class="container-xxl d-flex justify-content-center py-3">
                                <div class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="listEmployee?index=${currentPage - 1}"><</a>
                                </div>

                                <c:forEach begin="1" end="${endPage}" var="i">
                                    <div class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="listEmployee?index=${i}">${i}</a>
                                    </div>
                                </c:forEach>

                                <div class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                                    <a class="page-link" href="listEmployee?index=${currentPage + 1}">></a>
                                </div>
                            </div>

                        </footer>
                        <!-- /Footer -->

                    </div>
                    <!-- /Content wrapper -->

                </div>
                <!-- /Layout page -->


            </div>
            <!-- /Layout container -->
        </div>  
        <!-- /Layout wrapper -->
        
        <!-- Sneat JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
        <script src="assets/js/main.js"></script>
        <script src="assets/js/employee.js"></script>
    </body>

</html>