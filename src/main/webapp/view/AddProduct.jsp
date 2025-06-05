<!-- Add Product Form (English) - Sneat Template Compatible -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Add Product</title>

    <link rel="stylesheet" href="assets/vendor/css/core.css" />
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
    <link rel="stylesheet" href="assets/css/demo.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
</head>




<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Add Product</h5>
        <a href="ListProduct"  class="btn btn-info"><i class="bx bx-arrow-back me-1"></i> Back to Product List</a>
    </div>
    <div class="card-body">
        <form action="AddProduct" method="post" enctype="multipart/form-data">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="productType" class="form-label">Product Category</label>
                    <select name="catePro" class="form-select" >
                        <c:forEach items="${cate}" var="cate">
                            <option value="${cate.getId()}">${cate.getName()}</option>
                        </c:forEach>


                    </select>
                </div>
                <div class="col-md-6">
                    <label for="barcode" class="form-label">Barcode <span class="text-danger">*</span></label>
                    <input name="barcode" type="text" class="form-control"  placeholder="Enter product barcode" required />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="productName" class="form-label">Product Name</label>
                    <input name="namePro" type="text" class="form-control"  placeholder="Enter product name" />
                </div>
                <div class="col-md-6">
                    <label for="unit" class="form-label">Unit <span class="text-danger">*</span></label>
                    <select name="unitPro" class="form-select" >
                        <c:forEach items="${unit}" var="unit">
                            <option value="${unit.getId()}">${unit.getName()}</option>
                        </c:forEach>

                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="price" class="form-label">Price <span class="text-danger">*</span></label>
                    <input name="pricePro" type="number" class="form-control" placeholder="Enter product price" required />
                </div>


                <div class="col-md-6">
                    <label for="supPro" class="form-label">Supplier <span class="text-danger">*</span></label>
                    <select name="suppPro" class="form-select" >
                        <c:forEach items="${sup}" var="sup">
                            <option value="${sup.getId()}">${sup.getName()}</option>
                        </c:forEach>

                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="manufactureDate" class="form-label">Manufacture Date</label>
                    <input type="date" class="form-control" id="manufactureDate" name="manufactureDate" />
                </div>
                <div class="col-md-6">
                    <label for="expiryDate" class="form-label">Expiration Date</label>
                    <input type="date" class="form-control"  id="expirationDate" name="expirationDate" />
                </div>
            </div>

            <div class="mb-3">
                <label for="productImage" class="form-label">Product Image</label>
                <input class="form-control" type="file" name="imgPro" accept="image/*"/>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    ${errorMessage}
                </div>
            </c:if>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary">Add Product</button>
                <button type="reset" class="btn btn-secondary">Reset</button>
            </div>
        </form>
    </div>
</div>
