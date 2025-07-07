<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Chi Tiết Đơn Hàng</title>
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body class="bg-gray-50">
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <%@ include file="/common/site-bar.jsp" %>

                <div class="layout-page">
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">

                            <div class="container mx-auto px-4 py-8">
                                <div class="bg-white rounded-xl shadow-md overflow-hidden mb-8">
                                    <div class="p-6 bg-gradient-to-r from-blue-600 to-blue-700 text-white">
                                        <h1 class="text-2xl font-bold">Đơn Hàng #${order.orderId}</h1>
                                        <p class="opacity-90 mt-1">Thông tin chi tiết về đơn hàng</p>
                                    </div>

                                    <div class="p-6 bg-white grid grid-cols-1 md:grid-cols-2 gap-6 text-sm">
                                        <div>
                                            <p><strong>Khách hàng:</strong> ${order.customerName}</p>
                                            <p><strong>Ngày đặt hàng:</strong>
                                                <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy HH:mm:ss"/>
                                            </p>
                                            <p><strong>Trạng thái:</strong> ${order.orderStatus}</p>
                                        </div>
                                        <div>
                                            <p><strong>Nhân viên xử lý:</strong> ${order.employeeName}</p>
                                            <p><strong>Mã khuyến mãi:</strong> <c:out value="${empty order.couponCode ? '-' : order.couponCode}" /></p>
                                            <p><strong>Tổng tiền:</strong>
                                                <fmt:formatNumber value="${order.orderTotalAmount}" type="currency" currencySymbol="₫"/>
                                            </p>
                                        </div>
                                    </div>

                                    <div class="px-6 pb-6">
                                        <h2 class="text-lg font-semibold text-gray-700 mb-4">Danh sách sản phẩm</h2>
                                        <div class="overflow-x-auto">
                                            <table class="min-w-full divide-y divide-gray-200 text-sm">
                                                <thead class="bg-gray-100">
                                                    <tr>
                                                        <th class="px-6 py-3 text-left font-medium text-gray-500">Sản phẩm</th>
                                                        <th class="px-6 py-3 text-center font-medium text-gray-500">Số lượng</th>
                                                        <th class="px-6 py-3 text-right font-medium text-gray-500">Đơn giá</th>
                                                        <th class="px-6 py-3 text-right font-medium text-gray-500">Thành tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="bg-white divide-y divide-gray-200">
                                                    <c:forEach var="item" items="${orderItems}">
                                                        <tr>
                                                            <td class="px-6 py-4 text-gray-800">${item.productName}</td>
                                                            <td class="px-6 py-4 text-center">${item.quantity}</td>
                                                            <td class="px-6 py-4 text-right">
                                                                <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/>
                                                            </td>
                                                            <td class="px-6 py-4 text-right">
                                                                <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫"/>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                </div>

                                <div class="text-right">
                                    <a href="searchOrder" class="bg-gray-600 hover:bg-gray-700 text-white px-4 py-2 rounded-md text-sm">
                                        <i class="fas fa-arrow-left mr-2"></i>Quay lại danh sách
                                    </a>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html>
