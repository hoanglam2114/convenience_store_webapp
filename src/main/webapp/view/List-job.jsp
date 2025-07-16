
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Danh sách việc làm</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />

        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />
        <!-- Font and icon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Bạn có muốn xóa sản phẩm có mã là " + id + " không ?")) {
                    window.location = "DeleteProduct?product_id=" + id;
                }
            }
        </script>

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
                    <!-- / Navbar -->

                    <!-- Main content -->
                    <div class="container-xxl flex-grow-1 container-p-y">

                        <div class="container py-5">
                            <div class="card p-4">

                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="mb-4">Job Postings Management</h4>
                                    <!-- Add New Button -->
                                    <a href="AddJob" class="btn btn-success">Add New Job</a>

                                </div>


                                <!-- Filter Form -->
                                <form method="post" action="FindJob" class="row g-3 mb-4">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" name="title" placeholder="Job Title">
                                    </div>


                                    <div class="col-md-2">
                                        <input type="date" class="form-control" name="deadline" placeholder="Deadline">
                                    </div>


                                    <div class="col-md-2">
                                        <select class="form-select" name="jobstatus">
                                            <option value="All Status" ${"All Status".equals(jobstatus) ? "selected" : ""}>All Status</option>
                                            <c:forEach items="${statuses}" var="status">
                                                <option value="${status}" ${status.equals(jobstatus) ? "selected" : ""}>${status}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-4 d-flex align-items-start gap-2">
                                        <!-- Nút Tìm kiếm -->
                                        <button type="submit" class="btn btn-primary ">Tìm kiếm</button>

                                        <!-- Nút Làm mới -->
                                        <a href="ListJob" class="btn btn-outline-secondary ">Làm mới</a>
                                    </div>
                                </form>

                                <!-- Job Table -->
                                <div class="table-responsive">
                                    <div class="table-responsive">
                                        <table class="table table-bordered align-middle">
                                            <tr>

                                                <th>Job Title</th>
                                                <th>Type</th>
                                                <th>Location</th>
                                                <th>Deadline</th>
                                                <th>Category</th>
                                                <th>Description</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${job}" var="j">
                                                    <tr>

                                                        <td>${j.getTitle()}</td>
                                                        <td>${j.getJobTypes().getName()}</td>
                                                        <td>${j.getJobLocation().getName()}</td>
                                                        <td>${j.getDeadline()}</td>
                                                        <td>${j.getJobCategories().getName()}</td>
                                                        <td>${j.getDescription()}</td>
                                                        <td>${j.getStatus()}</td>
                                                        <td>
                                                            <a href="UpdateJob?job_id=${j.getId()}" class="btn btn-sm btn-warning">Edit</a>
                                                            <a href="#" class="btn btn-sm btn-danger">Delete</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>


                                </div>
                                <!-- Footer -->
                                <footer class="content-footer footer bg-footer-theme">
                                    <div class="container-xxl d-flex justify-content-center py-3">
                                        <div class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="ListJob?index=${currentPage - 1}">Previous</a>
                                        </div>

                                        <c:forEach begin="1" end="${endPage}" var="i">
                                            <div class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="ListJob?index=${i}">${i}</a>
                                            </div>
                                        </c:forEach>

                                        <div class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                                            <a class="page-link" href="ListJob?index=${currentPage + 1}">Next</a>
                                        </div>
                                    </div>

                                </footer>
                                <!-- /Footer -->
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
                <script src="assets/js/main.js"></script> <!-- Quan trọng -->

                </body>
                </html>
