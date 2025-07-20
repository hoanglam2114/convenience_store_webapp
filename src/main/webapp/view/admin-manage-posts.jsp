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
        <title>Quản Lý Bài Viết</title>

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
                                        <h1 class="text-2xl font-bold">Quản Lý Bài Viết</h1>
                                        <p class="opacity-90 mt-1">Xem và quản lý bài viết của khách hàng</p>
                                    </div>
                                    <div class="p-6 border-b border-gray-200 bg-gray-50">
                                        <form action="admin-post-manage" method="get">
                                            <div class="flex flex-col md:flex-row gap-4">
                                                <div style="width: 700px">

                                                    <label class="block text-sm font-medium text-gray-700 mb-1">Tìm kiếm</label>
                                                    <div class="relative">
                                                        <input type="text" name="keyword" placeholder="Tìm kiếm bài viết..." class="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                                        <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                                                    </div>
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

                                                    <a href="admin-post-manage"
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
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Khách Hàng</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Ngày Tạo</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Blog</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Trạng Thái</th>
                                                    <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Hoạt Động</th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-gray-200">
                                                <c:forEach var="post" items="${postList}">
                                                    <tr class="hover:bg-gray-50">
                                                        <!-- Mã bài viết -->
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-blue-600">
                                                            ${post.id}
                                                        </td>

                                                        <!-- Tên người viết -->
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                                                            ${post.userName}
                                                        </td>

                                                        <!-- Ngày tạo -->
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                            <fmt:formatDate value="${post.createdAt}" pattern="dd-MM-yyyy HH:mm:ss"/>
                                                        </td>

                                                        <!-- Tiêu đề bài viết -->
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                            ${post.title}
                                                        </td>

                                                        <!-- Trạng thái -->
                                                        <td class="px-6 py-4 whitespace-nowrap">
                                                            <span class="px-2 py-1 text-xs rounded-full
                                                                  <c:choose>
                                                                      <c:when test="${post.status eq 'pending'}"> bg-yellow-100 text-yellow-800 </c:when>
                                                                      <c:when test="${post.status eq 'approved'}"> bg-green-100 text-green-800 </c:when>
                                                                      <c:when test="${post.status eq 'rejected'}"> bg-red-100 text-red-800 </c:when>
                                                                      <c:otherwise> bg-gray-100 text-gray-800 </c:otherwise>
                                                                  </c:choose>">
                                                                ${post.status}
                                                            </span>
                                                        </td>

                                                        <!-- Hành động: Xem / Duyệt / Từ chối -->
                                                        <td class="px-6 py-4 text-center text-sm font-medium space-x-2">
                                                            <a href="get-post-detail?id=${post.id}" class="text-blue-600 hover:text-blue-900" title="Xem">
                                                                <i class="fas fa-eye"></i>
                                                            </a>

                                                            <c:if test="${post.status eq 'pending'}">
                                                                <form action="admin-post-action" method="post" class="inline">
                                                                    <input type="hidden" name="postId" value="${post.id}" />
                                                                    <button name="action" value="approve" class="text-green-600 hover:text-green-800" title="Duyệt">
                                                                        <i class="fas fa-check-circle"></i>
                                                                    </button>
                                                                    <button name="action" value="reject" class="text-red-600 hover:text-red-800 ml-2" title="Từ chối">
                                                                        <i class="fas fa-times-circle"></i>
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>

                                        </table>
                                    </div>

                                    <!-- Tạo chuỗi filter query -->
                                    <c:set var="filterQuery">
                                        <c:if test="${not empty param.keyword}">
                                            &keyword=${fn:escapeXml(param.keyword)}
                                        </c:if>
                                        <c:if test="${not empty param.status}">
                                            &status=${param.status}
                                        </c:if>
                                        <c:if test="${not empty param.startDate}">
                                            &startDate=${param.startDate}
                                        </c:if>
                                        <c:if test="${not empty param.endDate}">
                                            &endDate=${param.endDate}
                                        </c:if>
                                    </c:set>


                                    <!-- Pagination -->
                                    <div class="flex justify-between items-center py-4">
                                        <div>
                                            <p class="text-sm">
                                                Hiện
                                                <span class="font-medium">${((currentPage - 1) * postsPerPage) + 1}</span> đến
                                                <span class="font-medium">
                                                    <c:choose>
                                                        <c:when test="${currentPage * postsPerPage < totalPosts}">
                                                            ${currentPage * postsPerPage}
                                                        </c:when>
                                                        <c:otherwise>${totalPosts}</c:otherwise>
                                                    </c:choose>
                                                </span> trong <span class="font-medium">${totalPosts}</span> bài viết
                                            </p>
                                        </div>
                                        <div class="flex space-x-1">
                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <a href="admin-post-manage?page=${i}${filterQuery}"
                                                   class="px-3 py-1 border rounded
                                                   ${i == currentPage ? 'bg-blue-600 text-white' : 'bg-white text-gray-800'}">
                                                    ${i}
                                                </a>
                                            </c:forEach>
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
            document.querySelectorAll(".view-post-btn").forEach(btn => {
            btn.addEventListener("click", function (e) {
            e.preventDefault();
            const postId = this.dataset.id;
            fetch(`get-post-detail?id=${postId}`)
                    .then(res => res.json())
                    .then(data => {
                    document.getElementById("modalTitle").textContent = data.title;
                    document.getElementById("modalUser").textContent = data.userName;
                    document.getElementById("modalDate").textContent = data.createdAt;
                    document.getElementById("modalStatus").textContent = data.status;
                    document.getElementById("modalStatus").className = getStatusBadgeClass(data.status);
                    document.getElementById("modalContent").innerHTML = data.content;
                    document.getElementById("modalImage").src = data.imageUrl || '';
                    document.getElementById("postModal").classList.remove("hidden");
                    });
            });
            });
            document.getElementById("closeModal").addEventListener("click", function () {
            document.getElementById("postModal").classList.add("hidden");
            });
            function getStatusBadgeClass(status) {
            switch (status.toLowerCase()) {
            case "approved": return "bg-green-100 text-green-800";
            case "rejected": return "bg-red-100 text-red-800";
            case "pending": return "bg-yellow-100 text-yellow-800";
            default: return "bg-gray-100 text-gray-800";
            }
            }

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
