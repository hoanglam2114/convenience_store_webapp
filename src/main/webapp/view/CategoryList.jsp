<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi" class="light-style layout-navbar-fixed" dir="ltr"
  data-theme="theme-default" data-assets-path="../assets/" data-template="vertical-menu-template-free">

<head>
 
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">

      <!-- Layout page -->
      <div class="layout-page">
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">

            <div class="d-flex justify-content-between align-items-center mb-3">
              <div>
                <h4 class="fw-bold">Danh sách loại sản phẩm</h4>
                <p class="mb-0 text-muted">
                  Danh sách loại sản phẩm là tập hợp các nhóm hoặc danh mục sản phẩm được phân loại theo tính chất, chức năng hoặc mục đích sử dụng.
                </p>
              </div>
              <button class="btn btn-primary">
                <i class="bx bx-plus me-1"></i> Thêm loại sản phẩm
              </button>
            </div>

            <div class="row mb-3">
              <div class="col-md-6">
                <input type="text" class="form-control" placeholder="Tìm kiếm loại sản phẩm theo tên">
              </div>
              <div class="col-auto">
                <button class="btn btn-outline-primary"><i class="bx bx-search"></i> Tìm kiếm</button>
                <button class="btn btn-outline-info"><i class="bx bx-show"></i> Xem toàn bộ loại sản phẩm</button>
              </div>
            </div>

            <div class="card">
              <div class="table-responsive text-nowrap">
                <table class="table">
                  <thead class="table-light text-center">
                    <tr>
                      <th>Mã</th>
                      <th>Loại Sản Phẩm</th>
                      <th>Chức Năng Khác</th>
                    </tr>
                  </thead>
                  <tbody class="text-center">
                    <tr>
                      <td>1</td>
                      <td class="text-start">Thực phẩm tươi</td>
                      <td>
                        <button class="btn btn-icon btn-success me-2"><i class="bx bx-edit"></i></button>
                        <button class="btn btn-icon btn-danger"><i class="bx bx-trash"></i></button>
                      </td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td class="text-start">Thực phẩm khô</td>
                      <td>
                        <button class="btn btn-icon btn-success me-2"><i class="bx bx-edit"></i></button>
                        <button class="btn btn-icon btn-danger"><i class="bx bx-trash"></i></button>
                      </td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td class="text-start">Thực phẩm chế biến sẵn</td>
                      <td>
                        <button class="btn btn-icon btn-success me-2"><i class="bx bx-edit"></i></button>
                        <button class="btn btn-icon btn-danger"><i class="bx bx-trash"></i></button>
                      </td>
                    </tr>
                    <tr>
                      <td>4</td>
                      <td class="text-start">Đồ uống</td>
                      <td>
                        <button class="btn btn-icon btn-success me-2"><i class="bx bx-edit"></i></button>
                        <button class="btn btn-icon btn-danger"><i class="bx bx-trash"></i></button>
                      </td>
                    </tr>
                    <tr>
                      <td>5</td>
                      <td class="text-start">Gia vị</td>
                      <td>
                        <button class="btn btn-icon btn-success me-2"><i class="bx bx-edit"></i></button>
                        <button class="btn btn-icon btn-danger"><i class="bx bx-trash"></i></button>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
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
</body>

</html>
