<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BLOG</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            /* Custom CSS nếu cần */
            .gradient-bg {
                background: linear-gradient(135deg, #f5f7fa 0%, #e4efe9 100%);
            }
            .post-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            }
            .read-more {
                transition: all 0.3s ease;
            }
            .read-more:hover {
                padding-right: 15px;
            }
        </style>
    </head>
    <body class="font-sans gradient-bg">
        <!-- Header -->
        <header class="bg-white shadow-sm sticky top-0 z-10">
            <div class="container mx-auto px-4 max-w-screen-lg py-4 flex justify-between items-center">
                <div class="flex items-center">
                    <div class="bg-blue-600 text-white p-2 rounded-lg mr-3">
                        <i class="fas fa-store text-xl"></i>
                    </div>
                    <h1 class="text-2xl font-bold text-gray-800">CONVENMA <span class="text-green-600">BLOG</span></h1>
                </div>
                <nav class="hidden md:block">
                    <ul class="flex space-x-8">
                        <li><a href="#" class="text-gray-800 hover:text-green-600 font-medium">Trang chủ</a></li>
                        <li><a href="#" class="text-gray-800 hover:text-green-600 font-medium">Khuyến mãi</a></li>
                        <li><a href="#" class="text-gray-800 hover:text-green-600 font-medium">Sản phẩm mới</a></li>
                        <li><a href="#" class="text-gray-800 hover:text-green-600 font-medium">Tin tức</a></li>
                        <li><a href="#" class="text-gray-800 hover:text-green-600 font-medium">Liên hệ</a></li>
                    </ul>
                </nav>
                <div class="flex items-center space-x-4">
                    <a href="#" class="hidden md:block bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg">
                        <i class="fas fa-plus mr-1"></i> Đăng bài
                    </a>
                    <button class="md:hidden text-gray-800">
                        <i class="fas fa-bars text-xl"></i>
                    </button>
                </div>
            </div>
        </header>

        <!-- Hero Section -->
        <section class="bg-blue-600 text-white py-12">
            <div class="container mx-auto px-4 max-w-screen-lg text-center">
                <h2 class="text-3xl md:text 4xl font-bold mb-4">CHÀO MỪNG ĐẾN VỚI BLOG TIỆN LỢI</h2>
                <p class="text-lg md:text-xl max-w-2xl mx-auto">Cập nhật tin tức khuyến mãi, sản phẩm mới và các chương trình ưu đãi từ hệ thống cửa hàng tiện lợi của chúng tôi</p>
                <div class="mt-6">
                    <input type="text" placeholder="Tìm kiếm bài viết..." class="px-4 py-2 rounded-l-lg w-64 text-gray-800 focus:outline-none">
                    <button class="bg-yellow-400 text-gray-800 px-4 py-2 rounded-r-lg font-medium hover:bg-yellow-500 transition">
                        <i class="fas fa-search"></i> Tìm kiếm
                    </button>
                </div>
            </div>
        </section>

        <!-- Featured Post -->
        <c:if test="${not empty featuredPost}">
            <section class="container mx-auto px-4 max-w-screen-lg py-10">
                <h2 class="text-3xl md:text 4xl font-bold mb-4">Bài viết nổi bật</h2>
                <div class="bg-white rounded-xl shadow-md overflow-hidden">
                    <div class="md:flex">
                        <div class="md:w-1/2">
                            <c:choose>
                                <c:when test="${not empty featuredImage}">
                                    <img class="w-full h-full object-cover"
                                         src="${pageContext.request.contextPath}/assets/img/blog/${featuredImage}"
                                         alt="Ảnh nổi bật">
                                </c:when>
                                <c:otherwise>
                                    <img class="w-full h-full object-cover"
                                         src="${pageContext.request.contextPath}/assets/img/blog/no-image.png"
                                         alt="Ảnh mặc định">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="p-8 md:w-1/2">
                            <div class="uppercase tracking-wide text-sm text-blue-600 font-semibold">
                                ${featuredTag}
                            </div>
                            <h2 class="mt-2 text-3xl font-bold text-gray-900">
                                ${featuredPost.title}
                            </h2>
                            <p class="mt-4 text-gray-600">
                                <c:out value="${fn:substring(featuredPost.content, 0, 180)}"/>...
                            </p>
                            <div class="mt-6">
                                <a href="${pageContext.request.contextPath}/post-detail?id=${featuredPost.id}" class="read-more inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded">
                                    Đọc tiếp <i class="fas fa-chevron-right ml-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </c:if>


        <!-- Main Content -->
        <div class="container mx-auto px-4 max-w-screen-lg py-4 flex flex-col md:flex-row">
            <!-- Blog Posts -->
            <main class="w-full md:w-2/3 md:pr-8">
                <h2 class="text-2xl font-bold text-gray-800 mb-6 border-b pb-2">Bài viết mới nhất</h2>

                <c:forEach var="item" items="${latestPosts}">
                    <c:set var="post" value="${item.post}" />
                    <c:set var="image" value="${item.image}" />
                    <c:set var="tag" value="${item.tag}" />

                    <article class="post-card mb-8 bg-white rounded-lg shadow-sm overflow-hidden transition duration-300">
                        <c:choose>
                                <c:when test="${not empty featuredImage}">
                                    <img class="w-full h-48 object-cover"
                                         src="${pageContext.request.contextPath}/assets/img/blog/${image}"
                                         alt="Ảnh nổi bật">
                                </c:when>
                                <c:otherwise>
                                    <img class="w-full h-48 object-cover"
                                         src="${pageContext.request.contextPath}/assets/img/blog/no-image.png"
                                         alt="Ảnh mặc định">
                                </c:otherwise>
                            </c:choose>
                        <div class="p-6">
                            <div class="flex items-center text-sm mb-2">
                                <span class="bg-green-100 text-green-800 px-2 py-1 rounded-full text-xs font-semibold">
                                    ${tag}
                                </span>
                                <span class="mx-2 text-gray-500">|</span>
                                <time class="text-gray-500">${post.createdAt}</time>
                            </div>
                            <h3 class="text-xl font-bold text-gray-900 mb-2">
                                ${post.title}
                            </h3>
                            <p class="text-gray-600 mb-4">
                                <c:out value="${fn:substring(post.content, 0, 180)}"/>...
                            </p>
                            <div class="flex justify-between items-center">
                                <span class="text-sm text-gray-600">#${post.id}</span>
                                <a href="${pageContext.request.contextPath}/post-detail?id=${post.id}" class="read-more text-blue-600 hover:text-blue-800 text-sm font-medium flex items-center">
                                    Đọc tiếp <i class="fas fa-chevron-right ml-1"></i>
                                </a>
                            </div>
                        </div>
                    </article>
                </c:forEach>


                <!-- Pagination -->
                <div class="flex justify-center mb-8">
                    <nav class="inline-flex rounded-md shadow">
                        <a href="#" class="px-3 py-2 rounded-l-md border border-gray-300 bg-white text-gray-500 hover:bg-gray-50">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                        <a href="#" class="px-4 py-2 border-t border-b border-gray-300 bg-white text-green-600 font-medium hover:bg-gray-50">1</a>
                        <a href="#" class="px-4 py-2 border-t border-b border-gray-300 bg-white text-gray-500 hover:bg-gray-50">2</a>
                        <a href="#" class="px-4 py-2 border-t border-b border-gray-300 bg-white text-gray-500 hover:bg-gray-50">3</a>
                        <a href="#" class="px-3 py-2 rounded-r-md border border-gray-300 bg-white text-gray-500 hover:bg-gray-50">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </nav>
                </div>
            </main>

            <!-- Sidebar -->
            <aside class="w-full md:w-1/3 mt-8 md:mt-0">
                <!-- Create New Post -->
                <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                    <h3 class="text-lg font-bold text-gray-800 mb-4 border-b pb-2">Đăng bài mới</h3>
                    <button class="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 px-4 rounded-lg">
                        <i class="fas fa-plus mr-2"></i> Tạo bài viết mới
                    </button>
                </div>

                <!-- Popular Posts -->
                <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                    <h3 class="text-lg font-bold text-gray-800 mb-4 border-b pb-2">Bài viết phổ biến</h3>
                    <ul class="space-y-4">
                        <li>
                            <a href="#" class="flex group">
                                <img class="h-14 w-14 rounded object-cover" src="https://images.unsplash.com/photo-1606787366850-de6330128bfc?ixlib=rb-1.2.1&auto=format&fit=crop&w=64&h=64&q=80" alt="Popular post">
                                <div class="ml-3">
                                    <h4 class="text-sm font-medium text-gray-900 group-hover:text-green-600">Siêu khuyến mãi cuối năm</h4>
                                    <time class="text-xs text-gray-500">Dec 15, 2023</time>
                                    <div class="flex items-center text-xs text-yellow-500 mt-1">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex group">
                                <img class="h-14 w-14 rounded object-cover" src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-1.2.1&auto=format&fit=crop&w=64&h=64&q=80" alt="Popular post">
                                <div class="ml-3">
                                    <h4 class="text-sm font-medium text-gray-900 group-hover:text-green-600">Lịch mở cửa dịp Tết Dương lịch</h4>
                                    <time class="text-xs text-gray-500">Nov 28, 2023</time>
                                    <div class="flex items-center text-xs text-yellow-500 mt-1">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex group">
                                <img class="h-14 w-14 rounded object-cover" src="https://images.unsplash.com/photo-1516594798947-e65505dbb29d?ixlib=rb-1.2.1&auto=format&fit=crop&w=64&h=64&q=80" alt="Popular post">
                                <div class="ml-3">
                                    <h4 class="text-sm font-medium text-gray-900 group-hover:text-green-600">Chương trình tích điểm đổi quà</h4>
                                    <time class="text-xs text-gray-500">Dec 10, 2023</time>
                                    <div class="flex items-center text-xs text-yellow-500 mt-1">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Categories -->
                <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                    <h3 class="text-lg font-bold text-gray-800 mb-4 border-b pb-2">Danh mục</h3>
                    <ul class="space-y-2">
                        <li>
                            <a href="#" class="flex justify-between items-center py-2 text-gray-700 hover:text-green-600">
                                <span>Khuyến mãi</span>
                                <span class="bg-green-100 text-green-800 text-xs font-semibold px-2 py-1 rounded-full">12</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex justify-between items-center py-2 text-gray-700 hover:text-green-600">
                                <span>Sản phẩm mới</span>
                                <span class="bg-blue-100 text-blue-800 text-xs font-semibold px-2 py-1 rounded-full">8</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex justify-between items-center py-2 text-gray-700 hover:text-green-600">
                                <span>Thông báo</span>
                                <span class="bg-purple-100 text-purple-800 text-xs font-semibold px-2 py-1 rounded-full">5</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="flex justify-between items-center py-2 text-gray-700 hover:text-green-600">
                                <span>Hướng dẫn</span>
                                <span class="bg-yellow-100 text-yellow-800 text-xs font-semibold px-2 py-1 rounded-full">3</span>
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Store Locations -->
                <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                    <h3 class="text-lg font-bold text-gray-800 mb-4 border-b pb-2">Cửa hàng gần bạn</h3>
                    <div class="relative">
                        <input type="text" class="w-full p-2 border border-gray-300 rounded-lg mb-3" placeholder="Nhập địa chỉ của bạn">
                        <button class="absolute right-3 top-2 text-gray-500">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                    <div class="h-48 bg-gray-100 rounded-lg flex items-center justify-center">
                        <p class="text-gray-500">Nhập địa chỉ để tìm cửa hàng gần nhất</p>
                    </div>
                    <button class="w-full mt-4 bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded-lg">
                        <i class="fas fa-map-marker-alt mr-2"></i> Xem tất cả cửa hàng
                    </button>
                </div>
            </aside>
        </div>

        <!-- Newsletter -->
        <section class="bg-blue-700 text-white py-12">
            <div class="container mx-auto px-4 text-center">
                <div class="max-w-2xl mx-auto">
                    <h2 class="text-2xl md:text-3xl font-bold mb-4">Đăng ký nhận tin khuyến mãi</h2>
                    <p class="mb-6">Nhận thông báo về các chương trình khuyến mãi mới nhất từ hệ thống cửa hàng tiện lợi của chúng tôi</p>
                    <div class="flex flex-col sm:flex-row gap-3 max-w-md mx-auto">
                        <input type="email" placeholder="Email của bạn" class="flex-grow px-4 py-2 rounded-lg text-gray-800 focus:outline-none">
                        <button class="bg-yellow-400 text-gray-800 px-6 py-2 rounded-lg font-medium hover:bg-yellow-500 transition whitespace-nowrap">
                            Đăng ký ngay
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-gray-800 text-white py-8">
            <div class="container mx-auto px-4">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                    <div>
                        <h3 class="text-xl font-bold mb-4">TIỆN LỢI <span class="text-blue-500">SHOP</span></h3>
                        <p class="text-gray-400">Hệ thống cửa hàng tiện lợi phục vụ khách hàng 24/7 với chất lượng phục vụ tốt nhất.</p>
                        <div class="mt-4 flex space-x-4">
                            <a href="#" class="text-gray-400 hover:text-white"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="text-gray-400 hover:text-white"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-gray-400 hover:text-white"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="text-gray-400 hover:text-white"><i class="fab fa-youtube"></i></a>
                        </div>
                    </div>
                    <div>
                        <h4 class="text-lg font-semibold mb-4">Liên kết nhanh</h4>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-400 hover:text-white">Trang chủ</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Bài viết</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Khuyến mãi</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Cửa hàng</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Liên hệ</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-lg font-semibold mb-4">Thông tin</h4>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-400 hover:text-white">Về chúng tôi</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Hỏi đáp</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Chính sách bảo mật</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Điều khoản sử dụng</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Tuyển dụng</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-lg font-semibold mb-4">Liên hệ</h4>
                        <ul class="space-y-2 text-gray-400">
                            <li class="flex items-center"><i class="fas fa-map-marker-alt mr-3 text-green-500"></i> Số 123, Đường ABC, Quận XYZ, TP.HCM</li>
                            <li class="flex items-center"><i class="fas fa-phone-alt mr-3 text-green-500"></i> 1900 1234</li>
                            <li class="flex items-center"><i class="fas fa-envelope mr-3 text-green-500"></i> info@tienloishop.com</li>
                            <li class="flex items-center"><i class="fas fa-clock mr-3 text-green-500"></i> Mở cửa 24/7</li>
                        </ul>
                    </div>
                </div>
                <div class="border-t border-gray-700 mt-8 pt-6 text-center text-gray-400">
                    <p>© 2023 Tiện Lợi Shop. Tất cả quyền được bảo lưu.</p>
                </div>
            </div>
        </footer>

        <!-- JavaScript -->
        <script>
            // Toggle mobile menu
            document.querySelector('header nav button').addEventListener('click', function () {
                document.querySelector('header nav ul').classList.toggle('hidden');
            });

            // Smooth scroll
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();

                    document.querySelector(this.getAttribute('href')).scrollIntoView({
                        behavior: 'smooth'
                    });
                });
            });

            // Toggle mobile menu
            document.querySelector('header nav button').addEventListener('click', function () {
                document.querySelector('header nav ul').classList.toggle('hidden');
            });

            // Smooth scroll
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();

                    document.querySelector(this.getAttribute('href')).scrollIntoView({
                        behavior: 'smooth'
                    });
                });
            });
        </script>
    </body>
</html>