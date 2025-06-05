<%-- 
    Document   : category-add.jsp
    Created on : Jun 5, 2025, 10:27:50 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Product List</title>

        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />


        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

      
        
        
        
    </head>
    <body>
        <!-- Form Thêm loại sản phẩm mới -->
<div class="card">
  <div class="card-header d-flex justify-content-between align-items-center">
    <h5 class="mb-0">Thêm loại sản phẩm mới</h5>
    <a href="ListCate" class="btn btn-info">
      <i class="bx bx-arrow-back"></i> Trở về danh sách loại sản phẩm
    </a>
  </div>

  <div class="card-body">
    <form action="AddCate" method="POST">
      <div class="mb-3">
        <label  class="form-label">Tên loại sản phẩm: <span class="text-danger">*</span></label>
        <input type="text" class="form-control"  name="nameCate" placeholder="Nhập loại sản phẩm" required />
      </div>

      <button type="submit" class="btn btn-outline-info">
        <i class="bx bx-plus"></i> Thêm loại sản phẩm
      </button>
      <button type="reset" class="btn btn-outline-primary">
        <i class="bx bx-refresh"></i> Làm mới
      </button>
    </form>
  </div>
</div>
  <!-- Sneat JS -->
    <script src="assets/vendor/libs/jquery/jquery.js"></script>
    <script src="assets/vendor/js/bootstrap.js"></script>
    <script src="assets/vendor/js/menu.js"></script>
    </body>
</html>
