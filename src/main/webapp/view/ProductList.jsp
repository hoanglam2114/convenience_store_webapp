<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Product List</title>

        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />


        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

        <!-- Favicon -->
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
                                           href="PriceEdit.jsp?id=1" class="btn btn-info btn-sm">
                                            <i class="bx bx-show"></i>
                                        </a>

                                        <a data-bs-toggle="tooltip" data-bs-placement="top" title="Chỉnh sửa thông tin" 
                                           href="UpdateProduct?product_id=${p.getId()} " class="btn btn-warning btn-sm">
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
        </div>
        <c:forEach begin="1" end="${endPage}" var="i">
            <a href="ListProduct?index=${i}">${i}</a>
        </c:forEach>

        <!-- Sneat JS -->
        <script src="assets/vendor/js/core.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/main.js"></script>
        <script src="assets/js/title_icon.js"></script>

    </body>
</html>