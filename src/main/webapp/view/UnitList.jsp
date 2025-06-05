<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">

    <head>
        <meta charset="UTF-8" />
        <title>Danh sách đơn vị</title>
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
                    window.location = "DeleteUnit?unit_id=" + id;
                }
            }
        </script>
        
    </head>

    <body>
        <div class="container-xxl flex-grow-1 container-p-y">
            <h4 class="fw-bold py-3 mb-4">Danh sách đơn vị</h4>

            <div class="card">
                <div class="card-body">
                    <p>

                    </p>

                    <div class="mb-3 d-flex justify-content-between align-items-center ">
                        <div>
                            <a href="AddUnit" class="btn btn-primary">
                                <i class="bx bx-plus"></i> Thêm đơn vị
                            </a>
                        </div>

                        <div class="d-flex align-items-center  mb-2">
                            <form action="FindUnit" class="d-flex align-items-center gap-1 w-100">


                                <input type="text" class="form-control flex-grow-1"" name="nameUnit" 
                                       placeholder="Tìm loại sản phẩm theo tên" />

                                <button style="width: 150px" class=" btn btn-outline-primary" >tìm kiếm</button>
                                <a href='ListUnit' style="width: 150px" class=" btn btn-outline-primary" >làm mới </a>


                            </form>

                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table ">
                            <thead class="table-light">
                                <tr>
                                    <th>Mã</th>
                                    <th>Tên Đơn Vị</th>
                                    <th class="text-center">Chức Năng Khác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listunit}" var="u">
                                    <tr>
                                        <td>${u.getId()}</td>
                                        <td>${u.getName()}</td>
                                        <td class="text-center">
                                            <a data-bs-toggle="tooltip" data-bs-placement="top" title="Chỉnh sửa thông tin" 
                                               href="UpdateUnit?weight_unit_id=${u.getId()}" class="btn btn-warning btn-sm">
                                                <i class="bx bx-edit"></i> 

                                            </a>
                                            <a data-bs-toggle="tooltip" data-bs-placement="top" title="Xóa sản phẩm"
                                               href="#" onclick="doDelete(${u.getId()})" class="btn btn-danger btn-sm" >
                                                <i class="bx bx-trash"></i>
                                            </a>

                                        </td>
                                    </tr>

                                </c:forEach>

                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
            <c:forEach begin="1" end="${endPage}" var="i">
                <a href="ListUnit?index=${i}">${i}</a>
            </c:forEach>
        </div>



        <!-- Sneat JS -->
        <script src="../assets/vendor/js/core.js"></script>
        <script src="../assets/js/main.js"></script>
    </body>

</html>
