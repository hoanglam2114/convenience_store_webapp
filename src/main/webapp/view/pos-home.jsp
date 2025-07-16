<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*, model.ProductCategories" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Hệ Thống Bán Hàng POS</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
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
        <!-- Header -->
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

        <!-- Main -->
        <main class="container mx-auto px-4 py-6">
            <div class="flex flex-col lg:flex-row gap-6">
                <!-- Sản phẩm -->
                <div class="lg:w-2/3">
                    <div class="bg-white rounded-lg shadow-md p-4 mb-6">
                        <div class="flex justify-between items-center mb-4">
                            <h2 class="text-xl font-bold text-gray-800">Sản Phẩm</h2>
                            <div class="flex items-center gap-2">
                                <button type="button" onclick="window.location.href = 'loadProducts'" class="flex items-center justify-center w-10 h-10 bg-white text-gray-600 border border-gray-300 rounded hover:text-blue-600 hover:border-blue-400 shadow-sm transition">
                                    <i class="bx bx-reset text-xl"></i>
                                </button>
                                <form action="searchProduct" method="get" class="relative w-64">
                                    <input type="text" name="keyword" placeholder="Tìm sản phẩm..." value="${param.keyword}" class="w-full h-10 pl-10 pr-4 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                                    <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                                </form>
                            </div>
                        </div>

                        <!-- Danh mục -->
                        <div class="flex space-x-2 mb-4 overflow-x-auto pb-2">
                            <c:forEach var="cat" items="${listCategories}">
                                <a href="loadProducts?categoryId=${cat.id}" 
                                   class="px-4 py-2 rounded-lg whitespace-nowrap transition duration-200 transform hover:scale-105 hover:bg-blue-100 ${param.categoryId == cat.id ? 'bg-blue-500 text-white' : 'bg-gray-100 text-gray-600'}">
                                    ${cat.name}
                                </a>                             
                            </c:forEach>                               
                        </div>

                        <!-- Lưới sản phẩm -->
                        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                            <c:forEach var="stock" items="${listStocks}">
                                <c:set var="product" value="${stock.inventory.product}" />
                                <form action="addToCart" method="post" onsubmit="return validateCustomerInfo(event)">
                                    <input type="hidden" name="storeStockId" value="${stock.storeStockId}" />
                                    <input type="hidden" name="quantity" value="1" />
                                    <button type="submit" class="w-full text-left">
                                        <div class="bg-white border rounded-lg p-3 transition-transform duration-300 transform hover:scale-105 hover:shadow-lg cursor-pointer">
                                            <div class="h-32 bg-gray-100 rounded mb-2 flex items-center justify-center overflow-hidden">
                                                <img src="${pageContext.request.contextPath}/assets/img/product/${product.image}" class="w-[100px] h-[100px] object-contain" />
                                            </div>
                                            <h3 class="font-medium text-gray-800">${product.name}</h3>
                                            <p class="text-blue-600 font-bold mt-1">
                                                <fmt:formatNumber value="${stock.discount != null ? stock.discount.priceSell : product.price}" type="number" groupingUsed="true" /> đ
                                            </p>
                                            <p class="text-sm text-gray-500 mt-1">Còn lại: ${stock.stock}</p>

                                            <!-- Barcode -->
                                            <c:if test="${not empty product.barcode}">
                                                <div class="mt-1 flex justify-center">
                                                    <img src="${pageContext.request.contextPath}/barcode-image?code=${product.barcode}"
                                                         class="h-12 w-full object-contain"
                                                         alt="Barcode: ${product.barcode}" />
                                                </div>
                                            </c:if>
                                        </div>
                                    </button>
                                </form>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Hóa đơn -->
                <div class="lg:w-1/3">
                    <div class="bg-white rounded-lg shadow-md p-4 sticky top-4">
                        <div class="flex justify-between items-center mb-4">
                            <h2 class="text-xl font-bold text-gray-800">Hóa Đơn</h2>
                            <div class="flex items-center space-x-2">
                                <span class="text-sm text-gray-500">#HD12345</span>
                                <a href="resetOrder" class="bg-blue-500 text-white px-3 py-1 rounded text-sm hover:bg-blue-600">Làm Mới</a>
                            </div>
                        </div>

                        <!-- Lookup khách hàng -->
                        <form method="post" action="customerLookup" id="customerForm">
                            <!-- Số điện thoại -->
                            <label class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại</label>
                            <input type="text" name="customer_phone" id="customerPhoneInput"
                                   placeholder="Nhập số điện thoại"
                                   value="${sessionScope.phone != null ? sessionScope.phone : ''}"
                                   class="w-full border rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                   onblur="handlePhoneLookupSubmit()" required />

                            <!-- Tên khách hàng -->
                            <div class="mt-2">
                                <label class="block text-sm font-medium text-gray-700 mb-1">Tên khách hàng</label>
                                <input type="text" name="customer_name" id="customerNameInput"
                                       value="${sessionScope.name != null ? sessionScope.name : ''}"
                                       class="w-full border rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       ${sessionScope.name == null ? "" : "readonly"}
                                       required />
                            </div>
                        </form>

                        <!-- Gợi ý tạo mới nếu chưa có -->
                        <c:if test="${sessionScope.name == null && not empty sessionScope.phone}">
                            <div class="mt-2 text-sm text-red-500">
                                Khách hàng chưa tồn tại. Bạn có muốn tạo tài khoản tích điểm không?
                                <div class="mt-2 space-x-2">
                                    <button onclick="showModal()" type="button" class="bg-blue-500 text-white px-3 py-1 rounded">Có</button>
                                    <button onclick="allowManualName()" type="button" class="bg-gray-300 px-3 py-1 rounded">Không</button>
                                </div>
                            </div>
                        </c:if>

                        <!-- Modal tạo mới khách hàng -->
                        <div id="customerModal" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 hidden">
                            <div class="bg-white rounded-lg p-6 shadow-md w-full max-w-md">
                                <h3 class="text-lg font-bold mb-4">Tạo tài khoản khách hàng</h3>
                                <form method="post" action="addCustomerPos">
                                    <div class="mb-3">
                                        <label class="block text-sm font-medium">Số điện thoại</label>
                                        <input name="phone" value="${sessionScope.phone}" required class="border rounded px-3 py-2 w-full" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="block text-sm font-medium">Tên khách hàng</label>
                                        <input name="name" value="${sessionScope.name}" required class="border rounded px-3 py-2 w-full" />
                                    </div>
                                    <div class="flex justify-end gap-2">
                                        <button type="button" onclick="closeModal()" class="bg-gray-300 px-4 py-2 rounded">Hủy</button>
                                        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">Tạo</button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Giỏ hàng -->
                        <label class="block text-sm font-medium text-gray-700 mb-1">Sản Phẩm</label>
                        <div class="border rounded-lg mb-4 max-h-64 overflow-y-auto px-2 py-2">
                            <c:if test="${not empty sessionScope.cart and not empty sessionScope.cart.items}">
                                <c:forEach var="item" items="${sessionScope.cart.items}">
                                    <div class="flex items-center justify-between bg-white rounded-md shadow-sm px-3 py-2 mb-2 hover:shadow-md transition">

                                        <!-- Trái: Tên và đơn giá -->
                                        <div class="w-1/3">
                                            <p class="font-medium text-gray-800 truncate">${item.product.name}</p>
                                            <p class="text-sm text-gray-500">
                                                <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" /> đ
                                            </p>
                                        </div>

                                        <!-- Giữa: Số lượng -->
                                        <form action="update-cart" method="post" class="flex items-center gap-1 w-1/3 justify-center">
                                            <input type="hidden" name="storeStockId" value="${item.storeStock.storeStockId}" />
                                            <button name="action" value="decrease" class="w-7 h-7 bg-gray-200 hover:bg-gray-300 rounded-md text-sm font-bold">-</button>
                                            <span class="w-6 text-center text-sm">${item.quantity}</span>
                                            <button name="action" value="increase" class="w-7 h-7 bg-gray-200 hover:bg-gray-300 rounded-md text-sm font-bold">+</button>
                                        </form>

                                        <!-- Phải: Thành tiền + Xoá -->
                                        <div class="flex items-center justify-end w-1/3 gap-3">
                                            <p class="text-sm font-bold text-blue-600 whitespace-nowrap">
                                                <fmt:formatNumber value="${item.subTotal}" type="number" groupingUsed="true" /> đ
                                            </p>
                                            <form action="update-cart" method="post">
                                                <input type="hidden" name="storeStockId" value="${item.storeStock.storeStockId}" />
                                                <button name="action" value="remove"
                                                        class="text-gray-500 hover:text-red-600 text-lg" title="Xoá">
                                                    <i class="fas fa-trash-alt"></i> 
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty sessionScope.cart or empty sessionScope.cart.items}">
                                <p class="text-center text-gray-500 py-4">Chưa có sản phẩm trong giỏ hàng</p>
                            </c:if>
                        </div>

                        <!-- Tổng tiền -->
                        <div class="space-y-2 mb-4">
                            <div class="flex justify-between">
                                <span>Tạm tính:</span>
                                <span><fmt:formatNumber value="${sessionScope.cart.totalMoney}" type="number" groupingUsed="true"/> đ</span>
                            </div>
                            <div class="flex justify-between">
                                <span>Giảm giá:</span>
                                <span class="text-green-500">0đ</span>
                            </div>
                            <div class="flex justify-between font-bold text-lg border-t pt-2">
                                <span>Tổng cộng:</span>
                                <span><fmt:formatNumber value="${sessionScope.cart.totalMoney}" type="number" groupingUsed="true"/> đ</span>
                            </div>
                        </div>

                        <!-- Thanh toán -->
                        <c:if test="${not empty sessionScope.cart}">
                            <div class="grid grid-cols-2 gap-2">
                                <!-- Nút tiền mặt gửi đến CheckoutServlet -->
                                <form action="checkout" method="post" class="col-span-1">
                                    <button type="submit"
                                            class="w-full bg-green-500 text-white py-3 rounded-lg hover:bg-green-600 font-medium">
                                        <i class="fas fa-money-bill-wave mr-2"></i>Tiền mặt
                                    </button>
                                </form>

                                <!-- QR Payment button mở modal -->
                                <form action="createVNPayQR" method="post" class="col-span-1">
                                    <button type="submit"
                                            class="w-full bg-blue-500 text-white py-3 rounded-lg hover:bg-blue-600 font-medium">
                                        <i class="fas fa-qrcode mr-2"></i>QR Code
                                    </button>
                                </form>
                            </div>
                        </c:if>

                        <!-- FORM nhận barcode từ điện thoại hoặc máy quét -->
                        <form id="barcodeForm" action="scan-barcode" method="post">
                            <input type="text" id="barcodeInput" name="barcode"
                                   autocomplete="off"
                                   style="position: absolute; left: -9999px;" />
                        </form>

                    </div>
                </div>
            </div>
        </main>

        <script>            
            function allowManualName() {
                const nameInput = document.getElementById("customerNameInput");
                nameInput.removeAttribute("readonly");
                nameInput.focus();
            }

            function showModal() {
                document.getElementById('customerModal').classList.remove('hidden');
            }

            function closeModal() {
                document.getElementById('customerModal').classList.add('hidden');
            }

            function validateForm() {
                const phone = document.getElementById("customerPhoneInput").value.trim();
                const name = document.getElementById("customerNameInput").value.trim();

                const phoneRegex = /^0\d{9}$/;
                const nameRegex = /^[A-Za-zÀ-ỹ\s]+$/;

                if (!phoneRegex.test(phone)) {
                    alert("Số điện thoại phải bắt đầu bằng 0 và gồm đúng 10 chữ số.");
                    return false;
                }

                if (name === "") {
                    alert("Vui lòng nhập tên khách hàng.");
                    return false;
                }

                if (!nameRegex.test(name)) {
                    alert("Tên khách hàng không được chứa ký tự đặc biệt hoặc số.");
                    return false;
                }

                return true;
            }

            function handlePhoneLookupSubmit() {
                const phone = document.getElementById("customerPhoneInput").value.trim();
                const phoneRegex = /^0\d{9}$/;

                if (!phoneRegex.test(phone)) {
                    alert("Số điện thoại không hợp lệ. Phải bắt đầu bằng 0 và gồm đúng 10 chữ số.");
                    return;
                }

                document.getElementById("customerForm").submit();
            }

            function validateCustomerInfo(event) {
                const phone = document.getElementById("customerPhoneInput").value.trim();
                const name = document.getElementById("customerNameInput").value.trim();

                const phoneRegex = /^0\d{9}$/;
                const nameRegex = /^[A-Za-zÀ-ỹ\s]+$/;

                if (!phoneRegex.test(phone)) {
                    alert("Vui lòng nhập số điện thoại hợp lệ trước khi thêm sản phẩm.");
                    if (event)
                        event.preventDefault(); // CHẶN submit
                    return false;
                }

                if (name === "") {
                    alert("Vui lòng nhập tên khách hàng trước khi thêm sản phẩm.");
                    if (event)
                        event.preventDefault();
                    return false;
                }

                if (!nameRegex.test(name)) {
                    alert("Tên khách hàng không hợp lệ.");
                    if (event)
                        event.preventDefault();
                    return false;
                }

                return true;
            }

            //Giữ focus barcode nhưng không gây mất focus khi nhập thông tin khách hàng
            window.onload = function () {
                const barcodeInput = document.getElementById("barcodeInput");
                barcodeInput.focus();

                barcodeInput.addEventListener("input", function () {
                    const value = barcodeInput.value.trim();

                    // Nếu đủ 13 số → submit và clear
                    if (/^\d{13}$/.test(value)) {
                        console.log("Submitting barcode:", value);
                        document.getElementById("barcodeForm").submit();
                        barcodeInput.value = ""; // reset để đón barcode tiếp theo
                    }
                });

                // Đảm bảo input luôn được focus nếu không đang nhập ở ô khác
                document.addEventListener("click", function (event) {
                    const tag = event.target.tagName;
                    if (tag !== "INPUT" && tag !== "TEXTAREA") {
                        barcodeInput.focus();
                    }
                });
            };

        </script>
    </body>
    
    <jsp:include page="/common/faq_chatbox_iframe.jsp" />
    
</html>
