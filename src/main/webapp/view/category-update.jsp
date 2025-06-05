<%-- 
    Document   : category-update
    Created on : Jun 5, 2025, 11:55:00 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Danh sách loại sản phẩm</title>

        <!-- Sneat core CSS -->

        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />


        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
    </head>
    <body>
        <div class="container-xxl flex-grow-1 container-p-y">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 text-primary">Cập nhật loại sản phẩm</h5>
                    <a href="ListCate" class="btn btn-info text-white">
                        <i class="fas fa-list me-1"></i> Trở về danh sách loại sản phẩm
                    </a>
                </div>
                <div class="card-body">
                    <c:set value="${cate}" var="c" />
                    <form action="UpdateCate" method="post">
                        <div class="mb-3">
                            <label for="maLoai" class="form-label">Mã loại sản phẩm</label>
                            <input type="text" class="form-control"
                                    name="cateid" value="${c.getId()}" readonly/>
                        </div>

                        <div class="mb-3">
                            <label for="tenLoai" class="form-label">Tên loại sản phẩm<span class="text-danger">*</span></label>
                            <input type="text"class="form-control"id="tenLoai"
                              name="catename" placeholder="Nhập tên loại sản phẩm"
                              value="${c.getName()}"required/>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-1"></i> Cập nhật
                            </button>
                            <button type="reset" class="btn btn-secondary">
                                <i class="fas fa-undo me-1"></i> Làm mới
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Sneat JS -->
        <script src="assets/vendor/js/core.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/main.js"></script>
        <script src="assets/js/title_icon.js"></script>

    </body>
</html>
