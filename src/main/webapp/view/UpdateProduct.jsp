<%-- 
    Document   : UpdateProductServlet
    Created on : May 29, 2025, 11:54:29 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Update Product</title>

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


                        <!-- BẮT ĐẦU: Content Wrapper Sneat -->
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <div class="card">

                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0">Chỉnh sửa sản phẩm</h5>
                                    <a href="ListProduct" class="btn btn-info text-white">
                                        <i class="bx bx-arrow-back me-1"></i> Trở về danh sách sản phẩm
                                    </a>
                                </div>
                                <div class="card-body">
                                    <c:set var="p"   value="${product}" />
                                    <form action="UpdateProduct" method="post" enctype="multipart/form-data">
                                        <div class="row">
                                            <input type="hidden" name="nameID" value="${p.getId()}" />
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="productType">Loại sản phẩm</label>
                                                <select id="productType" name="catePro" class="form-select">
                                                    <c:forEach items="${cate}" var="cate">
                                                        <option value="${cate.getId()}"
                                                                <c:if test="${cate.getId() == p.productCategories.getId()}">selected</c:if>>
                                                            ${cate.getName()}
                                                        </option>
                                                    </c:forEach>

                                                </select>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="productName">Tên sản phẩm</label>
                                                <input type="text" class="form-control ${not empty errornamePro ? 'is-invalid' : ''}" 
                                                       name="namePro" value="${p.getName()}" 
                                                       placeholder="Nhập tên sản phẩm mới"
                                                       value=" ${param.namePro != null ? param.namePro : ''}" />
                                                <c:if test="${not empty errornamePro}">
                                                    <div class="invalid-feedback">
                                                        ${errornamePro}
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="barcode">Mã vạch</label>
                                                <input type="text" class="form-control ${not empty errorbarcode ? 'is-invalid' : ''}"  
                                                       name="barcode" value="${p.getBarcode()}" 
                                                       value=" ${param.barcode != null ? param.barcode : ''}" />
                                                <c:if test="${not empty errorbarcode}">
                                                    <div class="invalid-feedback">
                                                        ${errorbarcode}
                                                    </div>
                                                </c:if>

                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="price">Giá</label>
                                                <input type="text" class="form-control"  name="pricePro" value="${p.getPrice()}" readonly />
                                            </div>



                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="unit">Đơn vị</label>
                                                <select  name="unitPro" class="form-select" >
                                                    <c:forEach items="${wu}" var="wu">
                                                        <option value="${wu.getId()}"
                                                                <c:if test="${wu.getId() == p.weightUnit.getId()}">selected</c:if>   
                                                                >${wu.getName()}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>



                                            <div class="col-md-6 mb-3">

                                                <label class="form-label" for="supplier">Nhà cung cấp</label>
                                                <select name="supPro" class="form-select">
                                                    <c:forEach items="${supp}" var="supp">
                                                        <option value="${supp.getId()}"
                                                                <c:if test="${supp.getId() == p.suppliers.getId()}">selected</c:if>   
                                                                >${supp.getName()}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>



                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="mfgDate">Ngày sản xuất</label>
                                                <input type="date" class="form-control"  name="ManufactureDate" value="${p.getManufactureDate()}" />
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="expDate">Ngày hết hạn</label>
                                                <input type="date" class="form-control"  name="ExpirationDate" value="${p. getExpirationDate()}" />
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="image">Hình ảnh</label>
                                                <input class="form-control" type="file"  name="imgPro" accept="img/* /">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="lot">Lô</label>
                                                <input type="cate" class="form-control"  name="batch" value="${p.getBatch()}" readonly />
                                            </div>
                                        </div>
                                        <c:if test="${not empty errorMessage}">
                                            <div class="alert alert-danger">
                                                ${errorMessage}
                                            </div>
                                        </c:if>
                                        <div class="mt-4">
                                            <button type="submit" class="btn btn-success">Cập nhật sản phẩm</button>
                                        </div>
                                    </form>
                                </div>
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


