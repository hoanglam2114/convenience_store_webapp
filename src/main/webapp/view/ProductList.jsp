<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Product List</title>
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




                        <h4 class="fw-bold py-3 mb-4">Danh sách sản phẩm</h4>

                        <p class="mb-4 text-muted">


                        </p>

                        <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
                            <form action="FindProduct"  method="get">
                                <div class="d-flex  align-items-center gap-2 mb-2">
                                    <input type="text" class="form-control" name="namePro" placeholder="Search products by name" />
                                    <button type="submit" class="btn btn-primary me-2"><i ></i> Search</button>
                                    <a href="ListProduct" class="btn btn-primary ">
                                        <i style="max-width: 50px"></i> Refresh
                                    </a>
                                </div>

                            </form>

                            <div>
                                <a href="AddProduct" class="btn btn-primary">
                                    <i class="bx bx-plus"></i> Add Product
                                </a>
                            </div>


                        </div>







                        <div class="card">
                            <div class="table-responsive text-nowrap">
                                <table class="table product-table">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Barcode</th>
                                            <th>Product</th>
                                            <th>Product Name</th>
                                            <th>Product Category</th>
                                            <th>Price</th>
                                            <th>Brand</th>
                                            <th>Unit</th>
                                            <th>Production Date</th>
                                            <th>Expiration date</th>
                                            <th>batch</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-border-bottom-0">
                                        <c:forEach items="${Pro}" var="p">

                                            <tr>
                                                <td>${p.getBarcode()}</td>
                                                <td><img src="assets/img/product/${p.getImage()}"  width="80px" height="80px" /></td>
                                                <td>${p.getName()}</td>
                                                <td>${p.productCategories.getName()}</td>
                                                <td>${p.getPrice()}</td>
                                                <td>${p.suppliers.getName()}</td>
                                                <td>${p.weightUnit.getName()}</td>
                                                <td>${p.getManufactureDate()}</td>
                                                <td>${p.getExpirationDate()}</td>
                                                <td>${p.getBatch()}</td>
                                                <td>
                                                    <div class="d-flex align-items-center list-action">
                                                        <a data-bs-toggle="tooltip" data-bs-placement="top" title="Lịch sử giá" 
                                                           href="ListPrice?product_id=${p.getId()}" class="btn btn-info btn-sm">
                                                            <i class="bx bx-show"></i>
                                                        </a>

                                                        <a data-bs-toggle="tooltip" data-bs-placement="top" title="Chỉnh sửa thông tin" 
                                                           href="UpdateProduct?product_id=${p.getId()} " class="btn btn-warning btn-sm">
                                                            <i class="bx bx-edit"></i> 

                                                        </a>

                                                        <a data-bs-toggle="tooltip" data-bs-placement="top" title="Chỉnh sửa giá" 
                                                           href="UpdatePrice?product_id=${p.getId()} " class="btn btn-warning btn-sm">
                                                            <i class="bx bx-edit"></i> 

                                                        </a>    

                                                        <a data-bs-toggle="tooltip" data-bs-placement="top" title="Xóa sản phẩm"
                                                           href="#" onclick="doDelete(${p.getId()})" class="btn btn-danger btn-sm" >
                                                            <i class="bx bx-trash"></i>
                                                        </a>

                                                    </div>


                                                </td>
                                            </tr>

                                        </c:forEach>


                                    </tbody>
                                </table>

                            </div>

                            <!-- Footer -->
                            <footer class="content-footer footer bg-footer-theme">
                                <div class="container-xxl d-flex justify-content-center py-3">
                                    <div class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="ListProduct?index=${currentPage - 1}">Previous</a>
                                    </div>

                                    <c:forEach begin="1" end="${endPage}" var="i">
                                        <div class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="ListProduct?index=${i}">${i}</a>
                                        </div>
                                    </c:forEach>

                                    <div class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                                        <a class="page-link" href="ListProduct?index=${currentPage + 1}">Next</a>
                                    </div>
                                </div>

                            </footer>
                            <!-- /Footer -->



                            <footer class="content-footer footer bg-footer-theme">
                                <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                                    <div class="mb-2 mb-md-0">© 2025, Sneat Admin Template</div>
                                    <div>Developed by You</div>
                                </div>
                            </footer>
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