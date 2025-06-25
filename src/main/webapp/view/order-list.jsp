<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Đơn Hàng</title>

        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <!-- Boxicons & Tailwind & FontAwesome -->
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            ::-webkit-scrollbar {
                width: 8px;
                height: 8px;
            }
            ::-webkit-scrollbar-track {
                background: #f1f1f1;
            }
            ::-webkit-scrollbar-thumb {
                background: #888;
                border-radius: 4px;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: #555;
            }
            @keyframes pulse {
                0% {
                    opacity: 0.8;
                }
                50% {
                    opacity: 1;
                }
                100% {
                    opacity: 0.8;
                }
            }
            .status-pending {
                animation: pulse 2s infinite;
            }
        </style>
    </head>

    <body class="bg-gray-50 font-sans">
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">

                <!-- Sidebar -->
                <%@ include file="/common/site-bar.jsp" %>

                <!-- Layout page -->
                <div class="layout-page">

                    <!-- Navbar -->


                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">

                            <div class="container mx-auto px-4 py-8">
                                <div class="bg-white rounded-xl shadow-md overflow-hidden mb-8">
                                    <div class="p-6 bg-gradient-to-r from-blue-600 to-indigo-700 text-white">
                                        <h1 class="text-2xl font-bold">Quản Lý Đơn Hàng</h1>
                                        <p class="opacity-90 mt-1">Xem và quản lý đơn hàng</p>
                                    </div>
                                    <div class="p-6 border-b border-gray-200 bg-gray-50">
                                        <form action="searchOrder" method="get">
                                            <div class="flex flex-col md:flex-row gap-4">
                                                <div style="width: 700px">

                                                    <label class="block text-sm font-medium text-gray-700 mb-1">Tìm kiếm</label>
                                                    <div class="relative">
                                                        <input type="text" name="keyword" placeholder="Tìm kiếm đơn hàng..." class="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                                        <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                                                    </div>
                                                </div>
                                                <div>
                                                    <label class="block text-sm font-medium text-gray-700 mb-1">Trạng thái</label>
                                                    <select name="status" class="w-full md:w-40 px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                                        <option value="">Tất cả</option>
                                                        <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                                        <option value="COMPLETED" ${param.status == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                                                    </select>
                                                </div>
                                                <div class="flex flex-row gap-4">
                                                    <div>
                                                        <label class="block text-sm font-medium text-gray-700 mb-1">Từ ngày</label>
                                                        <input type="date" name="startDate" value="${param.startDate}"
                                                               class="w-full md:w-40 px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
                                                    </div>

                                                    <div>
                                                        <label class="block text-sm font-medium text-gray-700 mb-1">Đến ngày</label>
                                                        <input type="date" name="endDate" value="${param.endDate}"
                                                               class="w-full md:w-40 px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
                                                    </div>
                                                </div>
                                                <div class="flex items-end space-x-2">
                                                    <button type="submit"
                                                            class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition duration-200 flex items-center">
                                                        <i class="fas fa-filter mr-2"></i> Lọc
                                                    </button>

                                                    <a href="searchOrder"
                                                       class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition duration-200 flex items-center">
                                                        <i class="fas fa-undo mr-2"></i> Mới
                                                    </a>
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                    <!-- Order Table -->
                                    <div class="overflow-x-auto">
                                        <table class="min-w-full divide-y divide-gray-200">
                                            <thead class="bg-gray-50">
                                                <tr>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Mã</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Khách Hàng</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Ngày Tạo Đơn</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tổng Tiền</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Trạng Thái</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Mã Giảm Giá</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nhân Viên</th>
                                                    <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Hoạt Động</th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-gray-200">
                                                <c:forEach var="order" items="${orderList}">
                                                    <tr class="hover:bg-gray-50">
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-blue-600">
                                                            #HD${order.orderId}
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                                                            ${order.customerName}
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                            <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy HH:mm:ss"/>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                            <fmt:formatNumber value="${order.orderTotalAmount}" type="currency" currencySymbol="₫"/>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap">
                                                            <span class="px-2 py-1 text-xs rounded-full
                                                                  <c:choose>
                                                                      <c:when test="${order.orderStatus eq 'PENDING'}"> bg-yellow-100 text-yellow-800 </c:when>
                                                                      <c:when test="${order.orderStatus eq 'COMPLETED'}"> bg-green-100 text-green-800 </c:when>
                                                                      <c:otherwise> bg-gray-100 text-gray-800 </c:otherwise>
                                                                  </c:choose>">
                                                                ${order.orderStatus}
                                                            </span>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                            <c:out value="${empty order.customerCouponId ? '-' : order.customerCouponId}" />
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                            ${order.employeeName}
                                                        </td>
                                                        <td class="px-6 py-4 text-center text-sm font-medium">
                                                            <a href="orderDetail?orderId=${order.orderId}"
                                                               class="text-blue-600 hover:text-blue-900">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="editOrder?orderId=${order.orderId}"
                                                               class="text-yellow-500 hover:text-yellow-700">
                                                                <i class="fas fa-pen"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Tạo chuỗi filter query -->
                                    <c:set var="filterQuery">
                                        &keyword=${fn:escapeXml(param.keyword)}
                                        &status=${param.status}
                                        &startDate=${param.startDate}
                                        &endDate=${param.endDate}
                                        &employee=${param.employee}
                                    </c:set>

                                    <!-- Pagination -->
                                    <div class="px-6 py-4 bg-gray-50 flex flex-col md:flex-row items-center justify-between border-t border-gray-200">
                                        <div class="mb-4 md:mb-0">
                                            <p class="text-sm text-gray-700">
                                                Hiện
                                                <span class="font-medium">
                                                    ${((currentPage - 1) * ordersPerPage) + 1}
                                                </span>
                                                đến
                                                <span class="font-medium">
                                                    <c:choose>
                                                        <c:when test="${currentPage * ordersPerPage < totalOrders}">
                                                            ${currentPage * ordersPerPage}
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${totalOrders}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                                trong
                                                <span class="font-medium">${totalOrders}</span> đơn hàng
                                            </p>
                                        </div>

                                        <div class="flex space-x-2">
                                            <!-- Previous -->
                                            <c:if test="${currentPage > 1}">
                                                <a href="searchOrder?page=${currentPage - 1}${filterQuery}"
                                                   class="px-3 py-1 border rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">&lt;</a>
                                            </c:if>

                                            <!-- Page numbers -->
                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <a href="searchOrder?page=${i}${filterQuery}"
                                                   class="px-3 py-1 border rounded-md text-sm font-medium
                                                   ${i == currentPage ? 'bg-blue-600 text-white' : 'text-gray-700 bg-white hover:bg-gray-50'}">
                                                    ${i}
                                                </a>
                                            </c:forEach>

                                            <!-- Next -->
                                            <c:if test="${currentPage < totalPages}">
                                                <a href="searchOrder?page=${currentPage + 1}${filterQuery}"
                                                   class="px-3 py-1 border rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">&gt;</a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- /Content wrapper -->

                </div>
                <!-- /Layout page -->

            </div>
            <!-- /Layout container -->
        </div>
        <!-- /Layout wrapper -->

        <script>
            

            // Sample order items for modal
            const orderItems = [
            {product: "Wireless Headphones", price: 99.99, qty: 2, subtotal: 199.98},
            {product: "Smartphone Case", price: 24.99, qty: 1, subtotal: 24.99},
            {product: "USB-C Cable", price: 15.99, qty: 3, subtotal: 47.97},
            {product: "Screen Protector", price: 12.99, qty: 2, subtotal: 25.98}
            ];
            // Function to format date
            function formatDate(dateString) {
            const options = {year: 'numeric', month: 'short', day: 'numeric'};
            return new Date(dateString).toLocaleDateString('en-US', options);
            }

            // Function to get status badge class
            function getStatusBadgeClass(status) {
            switch (status) {
            case 'pending':
                    return 'bg-yellow-100 text-yellow-800 status-pending';
            case 'paid':
                    return 'bg-green-100 text-green-800';
            case 'shipped':
                    return 'bg-blue-100 text-blue-800';
            case 'cancelled':
                    return 'bg-red-100 text-red-800';
            default:
                    return 'bg-gray-100 text-gray-800';
            }
            }


            });
        </script>

        <!-- Sneat JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html>
