<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Post Details | Blog</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">  
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css?family=Public+Sans:300,400,500,600,700" rel="stylesheet">

        <style>
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
    <body class="bg-gray-50">
        <!-- Navigation -->
        <nav class="bg-white shadow-sm">
            <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between h-16">
                    <div class="flex items-center">
                        <a href="customer-home" class="text-xl font-bold text-indigo-600">Convema</a>
                    </div>
                    <div class="flex items-center space-x-4">
                        <a href="blog" class="text-gray-600 hover:text-indigo-600">Trang chủ Blog</a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8 fade-in">
            <!-- Post Header -->
            <div class="mb-8">
                <div class="flex items-center mb-4">
                    <img src="${pageContext.request.contextPath}/assets/img/blog/avatar.png"
                         class="w-10 h-10 rounded-full mr-3" alt="Author">
                    <div>
                        <p class="font-medium">${post.userName}</p>
                        <p class="text-gray-500 text-sm">
                            Ngày đăng: <fmt:formatDate value="${post.createdAt}" pattern="dd-MM-yyyy" />
                        </p>
                    </div>
                </div>

                <h1 class="text-3xl md:text-4xl font-bold mb-4">${post.title}</h1>

                <div class="relative h-80 rounded-xl overflow-hidden mb-6">
                    <img src="${pageContext.request.contextPath}/assets/img/blog/${post.postImage.imageUrl}"
                         alt="Post cover" class="w-full h-full object-cover">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/30 to-transparent"></div>
                </div>
            </div>

            <!-- Post Content -->
            <article class="post-content prose max-w-none mb-12">
                <c:forEach var="section" items="${sections}">
                    <c:if test="${not empty section.sectionTitle}">
                        <h2>${section.sectionTitle}</h2>
                    </c:if>
                    <c:if test="${not empty section.sectionContent}">
                        <p>${section.sectionContent}</p>
                    </c:if>
                    <c:if test="${not empty section.sectionImageUrl}">
                        <img src="${section.sectionImageUrl}" alt="Section Image">
                    </c:if>
                </c:forEach>
            </article>

            <!-- Like Button -->
            <div class="mb-6">
                <form action="${pageContext.request.contextPath}/like-post" method="post" class="inline">
                    <input type="hidden" name="post_id" value="${post.id}">
                    <button type="submit" class="like-btn flex items-center space-x-2 text-red-500 hover:text-red-600 transition">
                        <i class="fa${hasLiked ? 's' : 'r'} fa-heart text-xl"></i>
                        <span>${likeCount}</span>
                    </button>
                </form>
            </div>


            <!-- Comments Section -->
            <div class="mb-12">
                <h3 class="text-xl font-bold mb-6">Comments (28)</h3>

                <div class="mb-6">
                    <textarea class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" rows="3" placeholder="Add a comment..."></textarea>
                    <div class="flex justify-end mt-2">
                        <button class="bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700 transition">Send</button>
                    </div>
                </div>

                <!-- Comment List -->
                <div class="space-y-6">
                    <!-- Comment 1 -->
                    <div class="flex">
                        <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="User" class="w-10 h-10 rounded-full mr-4">
                        <div class="flex-1">
                            <div class="bg-white p-4 rounded-lg shadow-sm">
                                <div class="flex justify-between mb-2">
                                    <span class="font-medium">Sarah Johnson</span>
                                    <span class="text-gray-500 text-sm">2 days ago</span>
                                </div>
                                <p class="text-gray-700">Great insights! I've been experimenting with AI code assistants and they've significantly improved my workflow. The suggestions are surprisingly accurate most of the time.</p>
                                <div class="flex items-center mt-3 text-sm text-gray-500">
                                    <button class="flex items-center mr-4 hover:text-indigo-600">
                                        <i class="far fa-thumbs-up mr-1"></i> 5
                                    </button>
                                    <button class="flex items-center hover:text-indigo-600">
                                        <i class="far fa-comment mr-1"></i> Reply
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

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
            // Smooth scroll for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    document.querySelector(this.getAttribute('href')).scrollIntoView({
                        behavior: 'smooth'
                    });
                });
            });

            // Add fade-in animation when page loads
            document.addEventListener('DOMContentLoaded', () => {
                document.querySelector('main').classList.add('fade-in');
            });
        </script>
    </body>
</html>