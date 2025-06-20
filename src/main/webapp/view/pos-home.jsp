<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hệ Thống Bán Hàng POS</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <%@ page import="java.util.*, model.ProductCategories" %>
        <style>
            .custom-bg {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            }
            .card-hover:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
            .animate-fadeIn {
                animation: fadeIn 0.5s ease-in-out;
            }
        </style>
    </head>
    <body class="custom-bg min-h-screen font-sans">
        <!-- POS Header -->
        <header class="bg-blue-500 text-white shadow-md">
            <div class="container mx-auto px-4 py-4 flex justify-between items-center">
                <div class="flex items-center space-x-4">
                    <i class="fas fa-cash-register text-2xl"></i>
                    <h1 class="text-xl font-bold">Hệ Thống Bán Hàng POS</h1>
                </div>
                <div class="flex items-center space-x-4">
                    <span id="current-time" class="font-medium"></span>
                    <button class="bg-white text-blue-600 px-4 py-1 rounded font-medium hover:bg-blue-50">
                        <i class="fas fa-user mr-2"></i>Nhân Viên
                    </button>
                </div>
            </div>
        </header>

        <!-- POS Main Interface -->
        <main class="container mx-auto px-4 py-6">
            <div class="flex flex-col lg:flex-row gap-6">
                <!-- Product Selection Panel -->
                <div class="lg:w-2/3">
                    <div class="bg-white rounded-lg shadow-md p-4 mb-6">
                        <div class="flex justify-between items-center mb-4">
                            <h2 class="text-xl font-bold text-gray-800">Sản Phẩm</h2>

                            <div class="flex items-center gap-2">
                                <!-- Nút reset -->
                                <button
                                    type="button"
                                    onclick="window.location.href = 'loadProducts'"
                                    class="flex items-center justify-center w-10 h-10 bg-white text-gray-600 border border-gray-300 rounded hover:text-blue-600 hover:border-blue-400 shadow-sm transition"
                                    >
                                    <i class="bx bx-reset text-xl"></i>
                                </button>

                                <!-- Ô tìm kiếm -->
                                <form action="searchProduct" method="get" class="relative w-64">
                                    <input
                                        type="text"
                                        name="keyword"
                                        placeholder="Tìm sản phẩm..."
                                        value="${param.keyword}"
                                        class="w-full h-10 pl-10 pr-4 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                        />
                                    <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                                </form>
                            </div>

                        </div>

                        <!-- Product Categories -->
                        <div class="flex space-x-2 mb-4 overflow-x-auto pb-2">
                            <c:forEach var="cat" items="${listCategories}">
                                <a href="loadProducts?categoryId=${cat.id}"
                                   class="px-4 py-2 rounded-lg whitespace-nowrap
                                   ${param.categoryId == cat.id ? 'bg-blue-500 text-white' : 'bg-gray-100 text-gray-600'}">
                                    ${cat.name}
                                </a>
                            </c:forEach>
                        </div>

                        <!-- Product Grid -->
                        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                            <c:forEach var="product" items="${listProducts}">
                                <form action="addToCart" method="post">
                                    <input type="hidden" name="productId" value="${product.id}" />
                                    <button type="submit" class="w-full text-left">
                                        <div class="bg-white border rounded-lg p-3 hover:shadow-md transition cursor-pointer">
                                            <div class="h-32 bg-gray-100 rounded mb-2 flex items-center justify-center overflow-hidden">
                                                <img src="assets/img/product/${product.image}" class="w-[100px] h-[100px] object-contain" />
                                            </div>
                                            <h3 class="font-medium text-gray-800">${product.name}</h3>
                                            <p class="text-blue-600 font-bold mt-1">
                                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> đ
                                            </p>
                                        </div>
                                    </button>
                                </form>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Order Summary Panel -->
                <div class="lg:w-1/3">
                    <div class="bg-white rounded-lg shadow-md p-4 sticky top-4">
                        <div class="flex justify-between items-center mb-4">
                            <h2 class="text-xl font-bold text-gray-800">Hóa Đơn</h2>
                            <div class="flex items-center space-x-2">
                                <span class="text-sm text-gray-500">#HD12345</span>
                                <button class="bg-blue-500 text-white px-3 py-1 rounded text-sm hover:bg-blue-600">
                                    <i class="fas fa-plus mr-1"></i>Mới
                                </button>
                            </div>
                        </div>

                        <!-- Customer Information -->
                        <!-- Số điện thoại -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại</label>
                            <input type="text" name="customer_phone" placeholder="Nhập số điện thoại"
                                   class="w-full border rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>

                        <!-- Tên khách hàng -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Tên khách hàng</label>
                            <input type="text" name="customer_name" placeholder="Tên khách hàng"
                                   class="w-full border rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>

                        <!-- Tạo tài khoản -->
                        <div class="flex items-center text-sm text-gray-600">
                            <input type="checkbox" id="create-account" class="mr-2">
                            <label for="create-account">Tạo tài khoản tích điểm</label>
                        </div>

                        <!-- Trường email nếu tạo tài khoản -->
                        <div id="account-fields" class="hidden space-y-2">
                            <input type="email" placeholder="Email (tùy chọn)" 
                                   class="w-full border rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>


                        <!-- Order Items -->
                        <label class="block text-sm font-medium text-gray-700 mb-1">Sản Phẩm</label>
                        <div class="border rounded-lg mb-4 max-h-64 overflow-y-auto">
                            <c:forEach var="item" items="${sessionScope.cart.items}">
                                <div class="p-3 border-b flex justify-between">
                                    <div>
                                        <p class="font-medium">${item.product.name}</p>
                                        <p class="text-sm text-gray-500">
                                            <fmt:formatNumber value="${item.product.price}" type="number" groupingUsed="true"/> đ × ${item.quantity}
                                        </p>
                                    </div>
                                    <div class="flex items-center">
                                        <span class="font-bold">
                                            <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/> đ
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- More order items would be listed here -->
                        </div>

                        <!-- Discount and Payment -->
                        <div class="mb-4">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Mã giảm giá</label>
                            <div class="flex">
                                <input type="text" placeholder="Nhập mã" 
                                       class="flex-1 border rounded-l-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <button class="bg-blue-500 text-white px-4 rounded-r-lg hover:bg-blue-600">Áp dụng</button>
                            </div>
                        </div>

                        <!-- Payment Summary -->
                        <div class="space-y-2 mb-4">
                            <div class="flex justify-between">
                                <span>Tạm tính:</span>
                                <span>30.000đ</span>
                            </div>
                            <div class="flex justify-between">
                                <span>Giảm giá:</span>
                                <span class="text-green-500">0đ</span>
                            </div>
                            <div class="flex justify-between font-bold text-lg border-t pt-2">
                                <span>Tổng cộng:</span>
                                <span>
                                    <fmt:formatNumber value="${sessionScope.cart.totalAmount}" type="number" groupingUsed="true"/> đ
                                </span>
                            </div>

                        </div>

                        <!-- Payment Buttons -->
                        <div class="grid grid-cols-2 gap-2">
                            <button class="bg-green-500 text-white py-3 rounded-lg hover:bg-green-600 font-medium">
                                <i class="fas fa-money-bill-wave mr-2"></i>Tiền mặt
                            </button>
                            <button class="bg-blue-500 text-white py-3 rounded-lg hover:bg-blue-600 font-medium">
                                <i class="fas fa-qrcode mr-2"></i>QR Code
                            </button>
                            <button class="bg-purple-500 text-white py-3 rounded-lg hover:bg-purple-600 font-medium">
                                <i class="fas fa-credit-card mr-2"></i>Thẻ
                            </button>
                            <button class="bg-yellow-500 text-white py-3 rounded-lg hover:bg-yellow-600 font-medium">
                                <i class="fas fa-receipt mr-2"></i>In hóa đơn
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <script>
            const contextPath = "${pageContext.request.contextPath}";
            document.addEventListener("DOMContentLoaded", function () {
                console.log("✅ DOM đã sẵn sàng");

                const phoneInput = document.querySelector('input[name="customer_phone"]');
                const nameInput = document.querySelector('input[name="customer_name"]');
                const createCheckbox = document.getElementById('create-account');
                const accountFields = document.getElementById('account-fields');

                console.log("👉 Phone Input:", phoneInput);

                phoneInput.addEventListener('blur', function () {
                    const rawPhone = phoneInput.value.trim();
                    console.log("Phone value khi blur:", rawPhone);

                    if (rawPhone.length >= 8) {
                        const encodedPhone = encodeURIComponent(rawPhone);
                        const contextPath = "/" + window.location.pathname.split("/")[1];
                        const url = `/convenience_store_webapp/api/customer-lookup?customer_phone=${encodedPhone}`;

                                        console.log("Gửi fetch với URL:", url);

                                        fetch(url)
                                                .then(res => {
                                                    if (!res.ok)
                                                        throw new Error("❌ Lỗi gọi API: " + res.status);
                                                    return res.json();
                                                })
                                                .then(data => {
                                                    console.log("✅ Dữ liệu nhận được:", data);
                                                    if (data && data.name) {
                                                        nameInput.value = data.name;
                                                        createCheckbox.checked = false;
                                                        accountFields.classList.add('hidden');
                                                    } else {
                                                        nameInput.value = '';
                                                        if (confirm("Khách hàng mới. Tạo tài khoản tích điểm?")) {
                                                            createCheckbox.checked = true;
                                                            accountFields.classList.remove('hidden');
                                                        } else {
                                                            createCheckbox.checked = false;
                                                            accountFields.classList.add('hidden');
                                                        }
                                                    }
                                                })
                                                .catch(err => {
                                                    console.error("❌ Lỗi fetch dữ liệu khách hàng:", err);
                                                });
                                    }
                                });
                            });

        </script>

    </body>
</html>