<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BLOG</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">  
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css?family=Public+Sans:300,400,500,600,700" rel="stylesheet">
        <style>
            body {
                font-family: 'Public Sans', sans-serif;
            }

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

            .footer-title {
                font-size: 1.125rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
            }

            .footer-link {
                display: block;
                font-size: 0.875rem;
                color: #374151;
                margin-bottom: 0.25rem;
                text-decoration: none;
            }

            .footer-link:hover {
                color: #2563EB;
            }

            .footer-bottom {
                text-align: center;
                margin-top: 1.5rem;
                padding-top: 1rem;
                border-top: 1px solid #e5e7eb;
                color: #6b7280;
                font-size: 0.875rem;
            }

            .social-icons {
                display: flex;
                gap: 1rem;
                margin-top: 0.75rem;
            }

            .social-icon {
                color: #2563EB;
                transition: color 0.3s ease;
            }

            .social-icon:hover {
                color: #1e40af;
            }

            .bootstrap-footer-wrapper {
                font-size: 0.95rem;
                line-height: 1.7;
            }

            .bootstrap-footer-wrapper a {
                color: #ffffff !important;
                display: block;
                margin-bottom: 0.4rem !important;
                text-decoration: none;
                font-size: 0.95rem;
            }

            .bootstrap-footer-wrapper a:hover {
                color: #ffc107 !important;
                text-decoration: underline;
            }

            .bootstrap-footer-wrapper a:visited {
                color: #ffffff !important;
            }

            .bootstrap-footer-wrapper .col-lg-2,
            .bootstrap-footer-wrapper .col-lg-3,
            .bootstrap-footer-wrapper .col-lg-5 {
                padding-left: 1rem;
                padding-right: 1rem;
            }

            .bootstrap-footer-wrapper,
            .bootstrap-footer-wrapper p,
            .bootstrap-footer-wrapper span,
            .bootstrap-footer-wrapper li {
                color: #ffffff !important;
            }

            .bootstrap-footer-wrapper h4,
            .bootstrap-footer-wrapper h5,
            .bootstrap-footer-wrapper .footer-title {
                font-size: 1.1rem;
                font-weight: 600;
                margin-bottom: 0.75rem;
                color: #ffffff;
            }

            /* Khoảng cách giữa các cột */
            .bootstrap-footer-wrapper .row > div {
                margin-bottom: 1rem;
            }
        </style>

    </head>
    <body class="font-sans gradient-bg">
        <!-- Header -->
        <header class="bg-white shadow-sm sticky top-0 z-10">
            <div class="container mx-auto px-4 max-w-screen-xl py-4 flex justify-between items-center">
                <div class="flex items-center">
                    <div class="bg-blue-600 text-white p-2 rounded-lg mr-3">
                        <i class="fas fa-store text-xl"></i>
                    </div>
                    <a href="${pageContext.request.contextPath}/customer-home">
                        <h1 class="text-2xl font-bold text-gray-800 cursor-pointer hover:opacity-80 transition">
                            <span class="text-blue-600">Convema</span>
                        </h1>
                    </a>
                </div>
            </div>
        </header>

        <!-- Hero Section -->
        <section class="bg-blue-600 text-white py-12" style="background: linear-gradient(45deg, #667eea, #764ba2); height: 100%;">
            <div class="blog-container mx-auto px-4 max-w-screen-xl text-center">
                <h2 class="text-3xl md:text 4xl font-bold mb-4">CHÀO MỪNG ĐẾN VỚI BLOG TIỆN LỢI CONVEMA</h2>
                <p class="text-lg md:text-xl max-w-2xl mx-auto">Nơi trò chuyện, chia sẻ các vấn đề thường gặp. Các trải nghiệm khi bạn mua sắm ở chuỗi cửa hàng tiện lợi CONVEMA của chúng tôi</p>
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
            <section class="blog-container mx-auto px-4 max-w-screen-xl py-10">
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
                            <div class="mt-2 text-sm text-gray-600 flex items-center gap-2">
                                <i class="fas fa-heart text-red-500"></i>
                                <span>${featuredPost.likes} lượt thích</span>
                            </div>
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
        <div class="blog-container mx-auto px-4 max-w-screen-xl py-4 flex flex-col md:flex-row">
            <!-- Blog Posts -->
            <main class="w-full md:w-2/3 md:pr-8">
                <h2 class="text-2xl font-bold text-gray-800 mb-6 border-b pb-2">Bài viết mới nhất</h2>

                <c:forEach var="item" items="${latestPosts}">
                    <c:set var="post" value="${item.post}" />
                    <c:set var="image" value="${item.image}" />
                    <c:set var="tag" value="${item.tag}" />

                    <article class="post-card mb-8 bg-white rounded-lg shadow-sm overflow-hidden transition duration-300">
                        <c:choose>
                            <c:when test="${not empty image}">
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
                                <a href="${pageContext.request.contextPath}/post-detail?id=${post.id}" class="read-more text-blue-600 hover:text-blue-800 text-sm font-medium flex items-center">
                                    Đọc tiếp <i class="fas fa-chevron-right ml-1"></i>
                                </a>
                            </div>
                        </div>
                    </article>
                </c:forEach>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="flex justify-center mt-8">
                        <nav class="inline-flex rounded-md shadow">
                            <!-- Previous button -->
                            <c:choose>
                                <c:when test="${currentPage > 1}">
                                    <a href="?page=${currentPage - 1}" class="px-3 py-2 rounded-l-md border border-gray-300 bg-white text-gray-700 hover:bg-gray-50">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="px-3 py-2 rounded-l-md border border-gray-300 bg-gray-100 text-gray-400 cursor-not-allowed">
                                        <i class="fas fa-chevron-left"></i>
                                    </span>
                                </c:otherwise>
                            </c:choose>

                            <!-- Page numbers -->
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="px-4 py-2 border-t border-b border-gray-300 bg-blue-600 text-white font-medium">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="?page=${i}" class="px-4 py-2 border-t border-b border-gray-300 bg-white text-gray-700 hover:bg-gray-50">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <!-- Next button -->
                            <c:choose>
                                <c:when test="${currentPage < totalPages}">
                                    <a href="?page=${currentPage + 1}" class="px-3 py-2 rounded-r-md border border-gray-300 bg-white text-gray-700 hover:bg-gray-50">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="px-3 py-2 rounded-r-md border border-gray-300 bg-gray-100 text-gray-400 cursor-not-allowed">
                                        <i class="fas fa-chevron-right"></i>
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </nav>
                    </div>
                </c:if>
                
            </main>

            <!-- Sidebar -->
            <aside class="w-full md:w-1/3 mt-8 md:mt-0">
                <!-- Create New Post -->
                <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                    <a href="${pageContext.request.contextPath}/customer-create-post" 
                       class="w-full block bg-blue-600 hover:bg-blue-700 text-white py-2 px-4 rounded-lg text-center">
                        <i class="fas fa-plus mr-2"></i> Tạo bài viết mới
                    </a>
                    <br/>
                    <a href="${pageContext.request.contextPath}/customer-manage-posts" 
                       class="w-full block bg-blue-600 hover:bg-blue-700 text-white py-2 px-4 rounded-lg text-center    ">
                        <i class="fas fa-store mr-2"></i> Quản lý bài viết của bạn
                    </a>
                </div>

                <!-- Categories -->
                <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                    <h3 class="text-lg font-bold text-gray-800 mb-4 border-b pb-2">Danh mục</h3>
                    <ul class="space-y-2">
                        <c:forEach var="tag" items="${tags}">
                            <li>
                                <a href="posts-by-tag?id=${tag.id}" class="flex justify-between items-center py-2 text-gray-700 hover:text-green-600">
                                    <span>${tag.name}</span>
                                    <span class="bg-green-100 text-green-800 text-xs font-semibold px-2 py-1 rounded-full">${tag.postCount}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>          
            </aside>
        </div>

        <!-- Newsletter -->
        <section class="bg-blue-700 text-white py-12 " style="background: linear-gradient(45deg, #667eea, #764ba2); height: 100%;">
            <div class="container mx-auto px-4 text-center max-w-screen-xl">
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
        <div class="bg-[#253746] text-white pt-5 mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="bootstrap-footer-wrapper">
                            <jsp:include page="/common/customer-footer.jsp" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

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