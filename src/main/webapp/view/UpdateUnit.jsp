<%-- 
    Document   : UpdateUnit
    Created on : Jun 3, 2025, 11:20:03 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Cập nhật đơn vị</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />
        <!-- Font and icon -->
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





                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0 font-size: 3rem;">Cập nhật đơn vị</h5>
                            <a href="ListUnit" class="btn btn-info text-white">
                                <i class="bx bx-left-arrow"></i> Trở về danh sách đơn vị
                            </a>
                        </div>


                        <div class="card " style="padding: 20px">
                            <c:set value="${unit}" var="u"/>
                            <form action="UpdateUnit" method="post">
                                <div class="mb-3">
                                    <label for="unitName" class="form-label">Mã đơn vị</label>
                                    <input type="text" name="unitId" class="form-control" value="${u.getId()}"  readonly />
                                </div>
                                <div class="mb-3">
                                    <label for="unitName" class="form-label">Tên đơn vị</label>
                                    <input type="text" name="unitName"  value="${u.getName()}"  
                                           class="form-control ${not empty error ? 'is-invalid' : ''}"
                                           class="form-control"  placeholder="Nhập tên đơn vị mới" 
                                           value="${param.nameUnit != null ? param.nameUnit : ''}"
                                           />
                                    <c:if test="${not empty error}">
                                        <div class="invalid-feedback">
                                            ${error}
                                        </div>
                                    </c:if>
                                </div>
                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-outline-info" >Cập nhật đơn vị mới</button>
                                    <button  type="reset" class="btn btn-outline-secondary" >Làm mới</button>
                                </div>
                            </form>
                    
                        </div>
                    </div>
                </div>
                <!-- /Layout page -->

            </div>
            <!-- /Layout container -->
        </div>
        <!-- /Layout wrapper -->  
    </body>
</html>
