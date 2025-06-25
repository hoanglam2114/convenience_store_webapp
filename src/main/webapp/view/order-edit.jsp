<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">
    <head>
        <meta charset="UTF-8">
        <title>Chỉnh Sửa Đơn Hàng</title>
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">

                <!-- Sidebar -->
                <%@ include file="/common/site-bar.jsp" %>

                <!-- Layout page -->
                <div class="layout-page">
                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <div class="container mx-auto px-4 py-6">
                                <div class="bg-white rounded-lg shadow-md p-6">
                                    <h2 class="text-2xl font-bold mb-4">Chỉnh Sửa Đơn Hàng</h2>
                                    <form action="editOrder" method="post" class="space-y-4">
                                        <input type="hidden" name="orderId" value="${order.orderId}" />

                                        <!-- Thông tin khách hàng -->
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                            <div>
                                                <label class="text-sm font-medium text-gray-700">Khách hàng</label>
                                                <input type="text" class="w-full border rounded px-3 py-2 bg-gray-100" value="${order.customerName}" readonly />
                                            </div>
                                            <div>
                                                <label class="text-sm font-medium text-gray-700">Nhân viên</label>
                                                <input type="text" class="w-full border rounded px-3 py-2 bg-gray-100" value="${order.employeeName}" readonly />
                                            </div>
                                            <div>
                                                <label class="text-sm font-medium text-gray-700">Ngày tạo đơn</label>
                                                <input type="text" class="w-full border rounded px-3 py-2 bg-gray-100"
                                                       value="<fmt:formatDate value='${order.orderDate}' pattern='dd-MM-yyyy HH:mm:ss'/>" readonly />
                                            </div>
                                            <div>
                                                <label class="text-sm font-medium text-gray-700">Tổng tiền</label>
                                                <input type="text" class="w-full border rounded px-3 py-2 bg-gray-100"
                                                       value="<fmt:formatNumber value='${order.orderTotalAmount}' type='currency' currencySymbol='₫'/>" readonly />
                                            </div>
                                        </div>

                                        <!-- Trạng thái -->
                                        <div>
                                            <label class="text-sm font-medium text-gray-700">Trạng thái đơn hàng</label>
                                            <select name="status" class="w-full border rounded px-3 py-2">
                                                <option value="PENDING" ${order.orderStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                                <option value="COMPLETED" ${order.orderStatus == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                                            </select>
                                        </div>

                                        <!-- Submit -->
                                        <div class="flex justify-end space-x-2 pt-4">
                                            <a href="orderDetail?orderId=${order.orderId}" class="px-4 py-2 rounded bg-gray-300 hover:bg-gray-400">Hủy</a>
                                            <button type="submit" class="px-4 py-2 rounded bg-blue-600 text-white hover:bg-blue-700">
                                                Lưu thay đổi
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /Content wrapper -->
                </div>
                <!-- /Layout page -->
            </div>
        </div>

        <!-- Scripts -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/js/config.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html>