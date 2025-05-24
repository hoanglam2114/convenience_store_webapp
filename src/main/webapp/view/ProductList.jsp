<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Product List</title>

        <link rel="stylesheet" href="../assets/vendor/css/core.css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

        <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

        <style>
            .product-image {
                width: 60px;
                height: auto;
            }
            .product-table th, .product-table td {
                vertical-align: middle;
            }
        </style>
    </head>
    <body>
        <div class="container-xxl flex-grow-1 container-p-y">
            <h4 class="fw-bold py-3 mb-4">Product List</h4>

            <p class="mb-4 text-muted">

                This list can include many elements such as barcodes, images, descriptions,
                prices, and information related to each product.
            </p>

            <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
                <div class="d-flex  align-items-center gap-2 mb-2">
                    <input type="text" class="form-control" placeholder="Search products by name" />
                    <button class="btn btn-primary me-2"><i ></i> Search</button>
                </div>


                <div>
                    <a href="AddProduct.jsp" class="btn btn-primary">
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
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <tr>
                            <td>8930012345700</td>
                            <td><img src="https://upload.wikimedia.org/wikipedia/vi/2/24/Coca-Cola_330ml_can.png" class="product-image" alt="Coca Cola" /></td>
                            <td>Soft drink Coca-Cola</td>
                            <td>Drink</td>
                            <td>10000.0</td>
                            <td>Coca-Cola Company</td>
                            <td>Bottle</td>
                            <td>2024-01-01</td>
                            <td>2025-01-01</td>
                            <td>
                                <a href="PriceEdit.jsp?id=1" class="btn btn-info btn-sm">
                                    <i class="bx bx-show"></i>
                                </a>

                                <a href="PriceEdit.jsp" class="btn btn-warning btn-sm">
                                    <i class="bx bx-edit"></i> 

                                </a>

                                <button class="btn btn-danger btn-sm">
                                    <i class="bx bx-trash"></i>
                                </button>

                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Sneat JS -->
    <script src="assets/vendor/js/core.js"></script>
    <script src="assets/vendor/js/helpers.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>