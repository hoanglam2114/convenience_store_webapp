<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Customer Management</title>

        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" /> 
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <!-- Boxicons -->
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="java.util.*, model.Customers" %>
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
                    <nav class="layout-navbar container-xxl navbar navbar-expand-xl">
                        <!-- Navbar -->
                    </nav>

                    <!-- Content wrapper -->
                    <div class="content-wrapper">

                        <!-- Main content -->
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-3 mb-4">
                                <span class="text-muted fw-light">Quản Lý /</span> Quản Lý Khách Hàng
                            </h4>

                            <!-- Add Customer Button -->
                            <div class="mb-3">
                                <a href="addCustomer" class="btn btn-primary">
                                    <i class="bx bx-plus"></i> Thêm
                                </a>
                            </div>

                            <!--Add Staff Search-->                            
                            <div class="mb-3" style="max-width: 300px;">
                                <form action="searchCustomer" method="POST">
                                    <div class="input-group input-group-merge">
                                        <input
                                            type="text"
                                            id="customerSearch"
                                            name="customerSearch"
                                            class="form-control"
                                            placeholder="Search..."
                                            aria-label="Search"
                                            aria-describedby="basic-addon-search"
                                            />
                                        <button class="btn btn-outline-secondary" type="submit" id="btnSearch">
                                            <i class="bx bx-search"></i>
                                        </button>
                                        <button class="btn btn-outline-secondary" type="button" id="btnReset" onclick="window.location.href='listCustomer'">
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
                                                <th>Điểm</th>
                                                <th>Trạng Thái</th>
                                                <th>Hoạt Động</th>
                                            </tr> 
                                        </thead> 
                                        <tbody class="table-border-bottom-0"> 
                                            <% 
                                            List<Customers> customerList = (List<Customers>) request.getAttribute("customerList");
                                            if (customerList != null && !customerList.isEmpty()) {
                                            for (Customers customer : customerList) { 
                                            %>
                                            <tr>
                                                <td><%= customer.getName()%></td>
                                                <td><%= customer.getPhone()%></td>
                                                <td><%= customer.getPoint()%></td>
                                                <td><span class="badge bg-success">Active</span></td>
                                                <td> 
                                                    <a href="editCustomer?id=<%= customer.getId()%>" class="btn btn-sm btn-icon btn-outline-primary" data-bs-toggle="tooltip" title="Edit">
                                                        <i class="bx bx-edit"></i>
                                                    </a> 
                                                    <button type="button" class="btn btn-sm btn-icon btn-outline-danger" onclick="confirmDelete(<%= customer.getId()%>)">
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
                                    <a class="page-link" href="listCustomer?index=${currentPage - 1}"><</a>
                                </div>

                                <c:forEach begin="1" end="${endPage}" var="i">
                                    <div class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="listCustomer?index=${i}">${i}</a>
                                    </div>
                                </c:forEach>

                                <div class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                                    <a class="page-link" href="listCustomer?index=${currentPage + 1}">></a>
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

        <!-- Core JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/libs/popper/popper.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/js/main.js"></script>
        <script src="assets/js/customer.js"></script>
    </body>

</html>
