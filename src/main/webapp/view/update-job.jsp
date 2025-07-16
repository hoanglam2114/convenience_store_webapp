<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh Sách Khuyến Mãi - Sneat Style</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />

        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />
        <!-- Font and icon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
        <style>
            .btn-primary-custom {
                background-color: #6C5DD3;
                color: #fff;
            }
            .btn-reset-custom {
                background-color: #a1aab2;
                color: #fff;
            }
        </style>
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

                        <div class="container mt-5">
                            <div class="card p-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="mb-0">Cập nhật công việc</h4>
                                    <a href="ListJob" class="btn btn-info">Trở về danh sách công việc</a>
                                </div>
                                <c:set var="j"   value="${job}" />
                                <form method="post" action="UpdateJob" >
                                    <input type="hidden" name="jobID" value="${j.getId()}" />
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Hình thức công việc</label>
                                            <select class="form-select" name="jobtype">
                                                <c:forEach items="${jobtypes}" var="jobtypes">
                                                    <option value="${jobtypes.getId()}"
                                                         <c:if test="${jobtypes.getId() == j.jobTypes.getId()}">selected</c:if>    
                                                            >${jobtypes.getName()}</option>
                                                </c:forEach>

                                            </select>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Tên công việc</label>
                                            <input type="text" class="form-control" value="${j.getTitle()}"
                                                   name="title" placeholder="Enter title" >
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Mô tả</label>
                                            <input type="text" class="form-control" value="${j.getDescription()}"
                                                   name="description" placeholder="Enter description">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Địa điểm làm việc</label>
                                            <select class="form-select" name="location">
                                                <c:forEach items="${joblocation}" var="joblocation">
                                                    <option value="${joblocation.getId()}"
                                                        <c:if test="${joblocation.getId() == j.jobLocation.getId()}">selected</c:if>    
                                                            >${joblocation.getName()}</option>
                                                </c:forEach>

                                            </select>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Loại công việc</label>
                                            <select class="form-select" name="jobcate" >
                                                <c:forEach items="${jobcate}" var="jobcate">
                                                    <option value="${jobcate.getId()}"
                                                        <c:if test="${jobcate.getId() == j.jobCategories.getId()}">selected</c:if>  
                                                        >${jobcate.getName()}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Ngày hết hạn ứng tuyển</label>
                                            <input type="date" class="form-control" value="${j.getDeadline()}"
                                                   name="deadline">
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Trạng thái</label>
                                            <select class="form-select" name="status" >
                                                <c:forEach items="${statuses}" var="status">
                                                    <option>${status}</option>
                                                </c:forEach>
                                            </select>
                                        </div>


                                        <div class="col-12 d-flex gap-2">
                                            <button type="submit" class="btn btn-primary-custom">Cập nhật công việc mới</button> 
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
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
