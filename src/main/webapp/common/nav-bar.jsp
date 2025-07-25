<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/3/2025
  Time: 3:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav
        class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
        id="layout-navbar"
>
    <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
        <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
            <i class="bx bx-menu bx-sm"></i>
        </a>
    </div>

    <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
        <!-- Search -->
        <div class="navbar-nav align-items-center">
            <div class="nav-item d-flex align-items-center">
                <i class="bx bx-search fs-4 lh-0"></i>
                <input
                        type="text"
                        class="form-control border-0 shadow-none"
                        placeholder="Search."
                        aria-label="Search."
                />
            </div>
        </div>
        <!-- /Search -->

        <ul class="navbar-nav flex-row align-items-center ms-auto">
            <!-- User -->
            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                <c:set var="account" value="${sessionScope.account}"/>
                <c:choose>
                    <c:when test="${account == null}">
                        <!-- Hiển thị nút Login nếu chưa đăng nhập -->
                        <a href="${pageContext.request.contextPath}/LoginServlet" class="btn btn-primary">Login</a>
                    </c:when>
                    <c:otherwise>
                        <!-- Hiển thị avatar và dropdown nếu đã đăng nhập -->
                        <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                            <div class="avatar avatar-online">
                                <img src="${pageContext.request.contextPath}/assets/img/avatars/default_avatar.png" alt
                                     class="w-px-40 h-auto rounded-circle"/>
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <div class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0 me-3">
                                            <div class="avatar avatar-online">
                                                <img src="${pageContext.request.contextPath}/assets/img/avatars/default_avatar.png"
                                                     alt class="w-px-40 h-auto rounded-circle"/>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <span class="fw-semibold d-block">${account.email}</span>
                                            <small class="text-muted">Role:
                                                <c:choose>
                                                    <c:when test="${account.role_id == 1}">Admin</c:when>
                                                    <c:when test="${account.role_id == 2}">Staff</c:when>
                                                    <c:when test="${account.role_id == 3}">Shop Manager</c:when>
                                                    <c:when test="${account.role_id == 4}">Warehouse Manager</c:when>
                                                    <c:otherwise>Undefined</c:otherwise>
                                                </c:choose>
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="dropdown-divider"></div>
                            </li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/LogoutServlet">
                                    <i class="bx bx-power-off me-2"></i>
                                    <span class="align-middle">Log Out</span>
                                </a>
                            </li>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </li>
            <!--/ User -->
        </ul>
    </div>
</nav>