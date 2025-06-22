<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Management</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            /* Custom scrollbar */
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

            /* Animation for status badges */
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
        <div class="container mx-auto px-4 py-8">
            <div class="bg-white rounded-xl shadow-md overflow-hidden mb-8">
                <div class="p-6 bg-gradient-to-r from-blue-600 to-indigo-700 text-white">
                    <h1 class="text-2xl font-bold">Quản Lý Đơn Hàng</h1>
                    <p class="opacity-90 mt-1">Xem và quản lý đơn hàng</p>
                </div>

                <!-- Filter and Search Section -->
                <div class="p-6 border-b border-gray-200 bg-gray-50">
                    <div class="flex flex-col md:flex-row gap-4">
                        <div class="flex-1">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Search</label>
                            <div class="relative">
                                <input type="text" placeholder="Search invoices..." class="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Status</label>
                            <select class="w-full md:w-40 px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                <option value="">All Status</option>
                                <option value="pending">Pending</option>
                                <option value="paid">Paid</option>
                                <option value="shipped">Shipped</option>
                                <option value="cancelled">Cancelled</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Date Range</label>
                            <select class="w-full md:w-40 px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                <option value="">All Time</option>
                                <option value="today">Today</option>
                                <option value="week">This Week</option>
                                <option value="month">This Month</option>
                            </select>
                        </div>
                        <div class="flex items-end">
                            <button class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition duration-200 flex items-center">
                                <i class="fas fa-filter mr-2"></i> Filter
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Order Table -->
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Customer</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Order Date</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Total</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Staff</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Coupon</th>
                                <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach var="order" items="${orderList}">
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-blue-600">
                                        #HD${order.orderId}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                                        ${order.customerId}
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
                                        ${order.employeeId}
                                    </td>
                                    <td class="px-6 py-4 text-right text-sm font-medium">
                                        <button class="text-blue-600 hover:text-blue-900 view-btn" data-id="${order.orderId}">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>

                    </table>
                </div>

                <!-- Pagination -->
                <div class="px-6 py-4 bg-gray-50 flex flex-col md:flex-row items-center justify-between border-t border-gray-200">
                    <div class="mb-4 md:mb-0">
                        <p class="text-sm text-gray-700">
                            Showing <span class="font-medium">1</span> to <span class="font-medium">10</span> of <span class="font-medium">24</span> invoices
                        </p>
                    </div>
                    <div class="flex space-x-2">
                        <button class="px-3 py-1 border rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">
                            Previous
                        </button>
                        <button class="px-3 py-1 border rounded-md text-sm font-medium bg-blue-600 text-white">
                            1
                        </button>
                        <button class="px-3 py-1 border rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">
                            2
                        </button>
                        <button class="px-3 py-1 border rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">
                            3
                        </button>
                        <button class="px-3 py-1 border rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">
                            Next
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Invoice Detail Modal (hidden by default) -->
        <div id="invoiceModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
            <div class="bg-white rounded-xl shadow-xl w-full max-w-4xl max-h-[90vh] overflow-y-auto">
                <div class="p-6 bg-gradient-to-r from-blue-600 to-indigo-700 text-white flex justify-between items-center">
                    <h2 class="text-xl font-bold">Invoice Details</h2>
                    <button id="closeModal" class="text-white hover:text-gray-200">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="p-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <div>
                            <h3 class="text-lg font-semibold mb-4 text-gray-800">Invoice Information</h3>
                            <div class="space-y-3">
                                <div class="flex">
                                    <span class="w-32 text-gray-600">Invoice ID:</span>
                                    <span class="font-medium" id="modalInvoiceId">INV-001</span>
                                </div>
                                <div class="flex">
                                    <span class="w-32 text-gray-600">Order Date:</span>
                                    <span id="modalOrderDate">May 15, 2023</span>
                                </div>
                                <div class="flex">
                                    <span class="w-32 text-gray-600">Status:</span>
                                    <span id="modalStatus" class="px-2 py-1 text-xs rounded-full">Pending</span>
                                </div>
                                <div class="flex">
                                    <span class="w-32 text-gray-600">Coupon:</span>
                                    <span id="modalCoupon">SUMMER10</span>
                                </div>
                            </div>
                        </div>
                        <div>
                            <h3 class="text-lg font-semibold mb-4 text-gray-800">Customer Information</h3>
                            <div class="space-y-3">
                                <div class="flex">
                                    <span class="w-32 text-gray-600">Customer:</span>
                                    <span class="font-medium" id="modalCustomer">John Doe</span>
                                </div>
                                <div class="flex">
                                    <span class="w-32 text-gray-600">Staff:</span>
                                    <span id="modalStaff">Sarah Johnson</span>
                                </div>
                                <div class="flex">
                                    <span class="w-32 text-gray-600">Phone:</span>
                                    <span>(123) 456-7890</span>
                                </div>
                                <div class="flex">
                                    <span class="w-32 text-gray-600">Email:</span>
                                    <span>john.doe@example.com</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <h3 class="text-lg font-semibold mb-4 text-gray-800">Order Items</h3>
                    <div class="border rounded-lg overflow-hidden mb-6">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Product</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Qty</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Subtotal</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200" id="modalItems">
                                <!-- Items will be loaded here -->
                            </tbody>
                        </table>
                    </div>

                    <div class="flex justify-end">
                        <div class="w-full md:w-1/3">
                            <div class="space-y-2">
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Subtotal:</span>
                                    <span>$450.00</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Discount (10%):</span>
                                    <span class="text-red-500">-$45.00</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Tax (8%):</span>
                                    <span>$32.40</span>
                                </div>
                                <div class="flex justify-between border-t border-gray-200 pt-2 mt-2">
                                    <span class="font-semibold">Total:</span>
                                    <span class="font-semibold" id="modalTotal">$437.40</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="p-4 bg-gray-50 flex justify-end space-x-3">
                    <button class="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">
                        <i class="fas fa-print mr-2"></i> Print
                    </button>
                    <button class="px-4 py-2 border border-transparent rounded-md text-sm font-medium text-white bg-green-600 hover:bg-green-700">
                        <i class="fas fa-check mr-2"></i> Mark as Paid
                    </button>
                </div>
            </div>
        </div>

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
    </body>
</html>