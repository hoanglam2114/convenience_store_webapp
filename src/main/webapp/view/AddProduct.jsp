<!-- Add Product Form (English) - Sneat Template Compatible -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Thêm sản phẩm</title>

    <link rel="stylesheet" href="assets/vendor/css/core.css" />
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
    <link rel="stylesheet" href="assets/css/demo.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
</head>

 <body>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">

        <!-- Sidebar -->
        <%@ include file="/common/site-bar.jsp" %>
        <!-- Layout page -->
        <div class="layout-page" >
            <!-- Navbar -->
            <%@ include file="/common/nav-bar.jsp" %>
            <!-- / Navbar -->

            <div class="container-xxl flex-grow-1 container-p-y">


                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Thêm sản phẩm mới</h5>
                        <a href="ListProduct"  class="btn btn-info"><i class="bx bx-arrow-back me-1"></i>Trở về danh sách sản phẩm</a>
                    </div>
                    <div class="card-body">
                        <form action="AddProduct" method="post" enctype="multipart/form-data">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="productType" class="form-label">Loại sản phẩm</label>
                                    <select name="catePro" class="form-select" >
                                        <c:forEach items="${cate}" var="cate">
                                            <option value="${cate.getId()}">${cate.getName()}</option>
                                        </c:forEach>


                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="barcode" class="form-label">Mã vạch<span class="text-danger">*</span></label>
                                    <input name="barcode" type="text" 
                                           class="form-control ${not empty errorbarcode ? 'is-invalid' : ''}"  
                                           placeholder="Enter product barcode"
                                           value="${param.barcode != null ? param.barcode : ''}"
                                           required />
                                    <c:if test="${not empty errorbarcode}">
                                        <div class="invalid-feedback">
                                            ${errorbarcode}
                                        </div>
                                    </c:if>
                                    
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="productName" class="form-label">Tên sản phẩm</label>
                                    <input name="namePro" type="text" 
                                           class="form-control ${not empty errornamePro ? 'is-invalid' : ''}"  
                                           placeholder="Enter product name" 
                                           value="${param.namePro != null ? param.namePro : ''}"
                                           required/>
                                    <c:if test="${not empty errornamePro}">
                                        <div class="invalid-feedback">
                                            ${errornamePro}
                                        </div>
                                    </c:if>
                                    
                                    
                                </div>
                                <div class="col-md-6">
                                    <label for="unit" class="form-label">Đơn vị<span class="text-danger">*</span></label>
                                    <select name="unitPro" class="form-select" >
                                        <c:forEach items="${unit}" var="unit">
                                            <option value="${unit.getId()}">${unit.getName()}</option>
                                        </c:forEach>

                                    </select>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="price" class="form-label">Giá tiền<span class="text-danger">*</span></label>
                                    <input name="pricePro" type="number" 
                                           class="form-control ${not empty errorpricePro ? 'is-invalid' : ''}" 
                                           placeholder="Enter product price"
                                           value="${param.pricePro != null ? param.pricePro : ''}"
                                           required />
                                    
                                     <c:if test="${not empty errorpricePro}">
                                        <div class="invalid-feedback">
                                            ${errorpricePro}
                                        </div>
                                    </c:if>
                                </div>


                                <div class="col-md-6">
                                    <label for="supPro" class="form-label">Nhà cung cấp<span class="text-danger">*</span></label>
                                    <select name="suppPro" class="form-select" >
                                        <c:forEach items="${sup}" var="sup">
                                            <option value="${sup.getId()}">${sup.getName()}</option>
                                        </c:forEach>

                                    </select>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="manufactureDate" class="form-label">Ngày sản xuất</label>
                                    <input type="date" class="form-control" id="manufactureDate" name="manufactureDate" />
                                </div>
                                <div class="col-md-6">
                                    <label for="expiryDate" class="form-label">Ngày hết hạn</label>
                                    <input type="date" class="form-control"  id="expirationDate" name="expirationDate" />
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="productImage" class="form-label">Hình ảnh sản phẩm</label>
                                <input class="form-control" type="file" name="imgPro" accept="image/*"/>
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">
                                    ${errorMessage}
                                </div>
                            </c:if>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">Thêm sản phẩm mới</button>
                                <button type="reset" class="btn btn-secondary">Làm mới</button>
                            </div>
                        </form>
                    </div>
                </div>
                
                    </div>
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
        <script src="assets/js/main.js"></script> <!-- Quan trọng -->
        
        
        
    </body>
</html>

