<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Blog Categories</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">  
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css?family=Public+Sans:300,400,500,600,700" rel="stylesheet">
        <style>
            .category-card:hover .category-icon {
                transform: translateY(-5px);
                transition: all 0.3s ease;
            }
            .post-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }
            .active-category {
                background-color: #3b82f6;
                color: white;
            }
            .post-content p {
                margin-bottom: 1.5rem;
                line-height: 1.8;
            }

            .post-content h2 {
                font-size: 1.5rem;
                font-weight: bold;
                margin: 2rem 0 1rem;
            }

            .post-content img {
                max-width: 100%;
                height: auto;
                border-radius: 0.5rem;
                margin: 1.5rem 0;
            }

            .tag:hover {
                transform: translateY(-2px);
            }

            .like-btn:hover {
                transform: scale(1.1);
            }

            .fade-in {
                animation: fadeIn 0.5s ease-in;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
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

            /* === BOOTSTRAP FOOTER OVERRIDES === */
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

            .bootstrap-footer-wrapper .row > div {
                margin-bottom: 1rem;
            }
        </style>
    </head>
    <body class="bg-gray-50 font-sans">
        <header class="bg-white shadow-sm sticky top-0 z-10">
            <div class="container mx-auto px-4 max-w-screen-lg py-4 flex justify-between items-center">
                <div class="flex items-center">
                    <div class="bg-blue-600 text-white p-2 rounded-lg mr-3">
                        <i class="fas fa-store text-xl"></i>
                    </div>
                    <a href="${pageContext.request.contextPath}/customer-home">
                        <h1 class="text-2xl font-bold text-gray-800 cursor-pointer hover:opacity-80 transition">
                            Convema <span class="text-green-600"></span>
                        </h1>
                    </a>
                </div>
                <nav class="hidden md:block">
                    <ul class="flex space-x-8">
                        <li><a href="blog" class="text-gray-800 hover:text-green-600 font-medium">Trang chủ Blog</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <!-- Hero Section -->
        <section class="bg-gradient-to-r from-blue-500 to-indigo-600 text-white py-16">
            <div class="container mx-auto px-4 text-center">
                <h2 class="text-4xl font-bold mb-4">Khám phá các bài viết theo chủ đề</h2>
                <p class="text-xl mb-8 max-w-2xl mx-auto">Chọn danh mục bạn quan tâm để xem các bài viết liên quan</p>
                <div class="relative max-w-md mx-auto">
                    <input type="text" placeholder="Tìm kiếm bài viết..." class="w-full py-3 px-4 rounded-full text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-300">
                    <button class="absolute right-2 top-1/2 transform -translate-y-1/2 bg-blue-600 text-white p-2 rounded-full hover:bg-blue-700">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </section>

        <!-- Main Content -->
        <main class="container max-w-7xl mx-auto px-4 py-12">
            <!-- Tag -->
            <div class="md:hidden mb-8">
                <select id="mobile-category-filter" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="all">Tất cả danh mục</option>
                    <option value="technology">Công nghệ</option>
                    <option value="travel">Du lịch</option>
                    <option value="food">Ẩm thực</option>
                    <option value="health">Sức khỏe</option>
                    <option value="education">Giáo dục</option>
                </select>
            </div>

            <div class="flex flex-col md:flex-row gap-8">
                <!-- Sidebar with Categories -->
                <aside class="md:w-1/4">
                    <div class="bg-white rounded-lg shadow-md p-6 sticky top-6">
                        <h3 class="text-xl font-bold mb-6 pb-2 border-b border-gray-200">Danh mục</h3>
                        <ul class="space-y-2">
                            <li>
                                <a href="${pageContext.request.contextPath}/posts-by-tag" 
                                   class="block px-4 py-2 rounded-lg hover:bg-blue-50 hover:text-blue-600 ${empty param.id ? 'active-category' : ''}">
                                    <i class="fas fa-th-list mr-2"></i> Tất cả
                                </a>
                            </li>
                            <c:forEach var="tag" items="${tags}">
                                <li>
                                    <a href="${pageContext.request.contextPath}/posts-by-tag?id=${tag.id}" 
                                       class="block px-4 py-2 rounded-lg hover:bg-blue-50 hover:text-blue-600 ${param.id == tag.id ? 'active-category' : ''}">
                                        <i class="fas fa-tag mr-2"></i> ${tag.name}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </aside>

                <!-- Blog Posts -->
                <div class="md:w-3/4">
                    <div class="flex justify-between items-center mb-8">
                        <h2 class="text-2xl font-bold">Bài viết <c:out value="${tagName}" /></h2>
                        <div class="hidden md:block">
                            <span class="text-gray-600 mr-2">Sắp xếp:</span>
                            <form method="get" id="sortForm" class="inline-block">
                                <input type="hidden" name="id" value="${param.id}" />
                                <select name="sort" onchange="document.getElementById('sortForm').submit();"
                                        class="p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="newest" ${sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                                    <option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
                                </select>
                            </form>
                        </div>
                    </div>


                    <!-- Category Tag (Shows when filtered) -->
                    <div id="category-tag" class="hidden mb-6">
                        <span class="inline-flex items-center px-4 py-2 rounded-full bg-blue-100 text-blue-800">
                            <span id="current-category-name">Công nghệ</span>
                            <button id="clear-filter" class="ml-2 text-blue-600 hover:text-blue-800">
                                <i class="fas fa-times"></i>
                            </button>
                        </span>
                    </div>

                    <!-- Blog Posts Grid -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="blog-posts-container">
                        <!-- Post -->
                        <c:forEach var="item" items="${posts}">
                            <article class="post-card bg-white rounded-lg shadow-md overflow-hidden transition-all duration-300">
                                <img src="${pageContext.request.contextPath}/assets/img/blog/${item.image}" alt="Ảnh bài viết" class="w-full h-48 object-cover" />
                                <div class="p-6">
                                    <div class="flex items-center mb-2">
                                        <span class="inline-block px-3 py-1 text-xs font-semibold bg-blue-100 text-blue-800 rounded-full">${item.tag}</span>
                                        <span class="text-gray-500 text-sm ml-auto">
                                            <fmt:formatDate value="${item.createdAt}" pattern="dd/MM/yyyy"/>
                                        </span>
                                    </div>
                                    <h3 class="text-xl font-bold mb-3 hover:text-blue-600">
                                        <a href="${pageContext.request.contextPath}/post-detail?id=${item.id}">${item.title}</a>
                                    </h3>
                                    <p class="text-gray-600 mb-4">
                                        <c:out value="${fn:substring(item.content, 0, 150)}"/>...
                                    </p>
                                    <div class="mt-4">
                                        <a href="${pageContext.request.contextPath}/post-detail?id=${item.id}" class="text-blue-600 hover:text-blue-800 text-sm font-medium">Đọc tiếp <i class="fas fa-arrow-right ml-1"></i></a>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                    </div>

                    <!--                     Pagination 
                                        <div class="mt-12 flex justify-center">
                                            <nav class="inline-flex rounded-md shadow">
                                                <a href="#" class="px-4 py-2 rounded-l-md border border-gray-300 bg-white text-gray-700 hover:bg-gray-50">
                                                    <i class="fas fa-chevron-left"></i>
                                                </a>
                                                <a href="#" class="px-4 py-2 border-t border-b border-gray-300 bg-white text-gray-700 hover:bg-gray-50">1</a>
                                                <a href="#" class="px-4 py-2 border-t border-b border-gray-300 bg-white text-blue-600 font-medium hover:bg-gray-50">2</a>
                                                <a href="#" class="px-4 py-2 border-t border-b border-gray-300 bg-white text-gray-700 hover:bg-gray-50">3</a>
                                                <a href="#" class="px-4 py-2 border-t border-b border-gray-300 bg-white text-gray-700 hover:bg-gray-50">4</a>
                                                <a href="#" class="px-4 py-2 rounded-r-md border border-gray-300 bg-white text-gray-700 hover:bg-gray-50">
                                                    <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </nav>
                                        </div>-->
                </div>
            </div>
        </main>

        <!-- Newsletter -->
        <section class="bg-gray-100 py-16">
            <div class="container mx-auto px-4 text-center">
                <h2 class="text-3xl font-bold mb-4">Đăng ký nhận tin mới</h2>
                <p class="text-gray-600 mb-8 max-w-2xl mx-auto">Nhận các bài viết mới nhất và thông tin hữu ích trực tiếp vào hộp thư của bạn</p>
                <div class="max-w-md mx-auto flex">
                    <input type="email" placeholder="Email của bạn" class="flex-grow py-3 px-4 rounded-l-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <button class="bg-blue-600 text-white py-3 px-6 rounded-r-lg hover:bg-blue-700 transition-colors">Đăng ký</button>
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

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Get all category links and posts
                const categoryLinks = document.querySelectorAll('.category-link');
                const mobileCategoryFilter = document.getElementById('mobile-category-filter');
                const blogPosts = document.querySelectorAll('.post-card');
                const categoryTag = document.getElementById('category-tag');
                const currentCategoryName = document.getElementById('current-category-name');
                const clearFilterBtn = document.getElementById('clear-filter');
                const blogPostsContainer = document.getElementById('blog-posts-container');

                // Function to filter posts by category
                function filterPosts(category) {
                    let hasPosts = false;

                    blogPosts.forEach(post => {
                        if (category === 'all' || post.dataset.category === category) {
                            post.style.display = 'block';
                            hasPosts = true;
                        } else {
                            post.style.display = 'none';
                        }
                    });

                    // Update active category in sidebar
                    categoryLinks.forEach(link => {
                        if (link.dataset.category === category) {
                            link.classList.add('active-category');
                        } else {
                            link.classList.remove('active-category');
                        }
                    });

                    // Update mobile filter
                    if (mobileCategoryFilter) {
                        mobileCategoryFilter.value = category;
                    }

                    // Show/hide category tag
                    if (category !== 'all') {
                        categoryTag.classList.remove('hidden');

                        // Set category name in tag
                        const activeLink = document.querySelector(`.category-link[data-category="${category}"]`);
                        if (activeLink) {
                            const categoryText = activeLink.textContent.trim();
                            currentCategoryName.textContent = categoryText;
                        }
                    } else {
                        categoryTag.classList.add('hidden');
                    }

                    // Scroll to top of posts container
                    blogPostsContainer.scrollIntoView({behavior: 'smooth', block: 'start'});
                }

                // Add click event to category links
                categoryLinks.forEach(link => {
                    link.addEventListener('click', function (e) {
                        e.preventDefault();
                        const category = this.dataset.category;
                        filterPosts(category);
                    });
                });

                // Add change event to mobile category filter
                if (mobileCategoryFilter) {
                    mobileCategoryFilter.addEventListener('change', function () {
                        filterPosts(this.value);
                    });
                }

                // Add click event to clear filter button
                if (clearFilterBtn) {
                    clearFilterBtn.addEventListener('click', function () {
                        filterPosts('all');
                    });
                }

                // Initialize with 'all' category
                filterPosts('all');
            });
        </script>
    </body>
</html>