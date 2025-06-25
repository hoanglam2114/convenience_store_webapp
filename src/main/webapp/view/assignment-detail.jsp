<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.ShopAssignment, model.WarehouseAssignment" %>
<%
    Object assignmentObj = request.getAttribute("assignment");
    String type = (String) request.getAttribute("type");
%>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="${pageContext.request.contextPath}/assets/"
      data-template="vertical-menu-template-free">

<head>
    <meta charset="UTF-8"/>
    <title>Chi tiết phân công</title>

    <!-- Sneat CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/core.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/theme-default.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/fonts/boxicons.css"/>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>
</head>

<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">

        <%@ include file="/common/site-bar.jsp" %>

        <div class="layout-page">

            <%@ include file="/common/nav-bar.jsp" %>

            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">
                    <h4 class="fw-bold py-3 mb-4">
                        <span class="text-muted fw-light">Quản Lý /</span> Chi Tiết Phân Công
                    </h4>

                    <div class="card mb-4">
                        <h5 class="card-header">Thông tin phân công</h5>
                        <div class="card-body">
                            <dl class="row">
                                <dt class="col-sm-3">ID Phân công</dt>
                                <dd class="col-sm-9">
                                    <c:out value="${assignment.assignmentId}" />
                                </dd>

                                <dt class="col-sm-3">Tên nhân viên</dt>
                                <dd class="col-sm-9">
                                    <c:out value="${assignment.employeeName}" />
                                </dd>

                                <dt class="col-sm-3">Số điện thoại</dt>
                                <dd class="col-sm-9">
                                    <c:out value="${assignment.employeePhone}" />
                                </dd>

                                <dt class="col-sm-3">Vai trò</dt>
                                <dd class="col-sm-9">
                                    <span class="badge 
                                        ${assignment.assignmentRole eq 'Manager' ? 'bg-danger' : 'bg-primary'}">
                                        ${assignment.assignmentRole}
                                    </span>
                                </dd>

                                <c:if test="${type eq 'shop'}">
                                    <dt class="col-sm-3">Cửa hàng</dt>
                                    <dd class="col-sm-9">
                                        ${assignment.shopName} - ${assignment.shopAddress}
                                    </dd>
                                </c:if>
                                <c:if test="${type eq 'warehouse'}">
                                    <dt class="col-sm-3">Kho hàng</dt>
                                    <dd class="col-sm-9">
                                        ${assignment.warehouseName} - ${assignment.warehouseAddress}
                                    </dd>
                                </c:if>

                                <dt class="col-sm-3">Ngày bắt đầu</dt>
                                <dd class="col-sm-9">
                                    <fmt:formatDate value="${assignment.startDate}" pattern="dd/MM/yyyy"/>
                                </dd>

                                <dt class="col-sm-3">Ngày kết thúc</dt>
                                <dd class="col-sm-9">
                                    <c:choose>
                                        <c:when test="${assignment.endDate != null}">
                                            <fmt:formatDate value="${assignment.endDate}" pattern="dd/MM/yyyy"/>
                                        </c:when>
                                        <c:otherwise>Chưa kết thúc</c:otherwise>
                                    </c:choose>
                                </dd>

                                <dt class="col-sm-3">Trạng thái</dt>
                                <dd class="col-sm-9">
                                    <span class="badge ${assignment.active ? 'bg-success' : 'bg-secondary'}">
                                        ${assignment.active ? "Đang hoạt động" : "Ngưng hoạt động"}
                                    </span>
                                </dd>
                            </dl>

                            <div class="mt-4">
                                <a href="${pageContext.request.contextPath}/assignment-management" class="btn btn-outline-secondary">
                                    <i class="bx bx-arrow-back"></i> Quay lại danh sách
                                </a>
                            </div>
                        </div>
                    </div>

                </div>

                <%--<%@ include file="/common/footer.jsp" %>--%>
            </div>
        </div>
    </div>
</div>

<!-- Sneat JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/helpers.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
