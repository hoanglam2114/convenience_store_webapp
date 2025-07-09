<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Post Details | Blog</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        </style>
    </head>
    <body class="bg-gray-50">
        <!-- Navigation -->
        <nav class="bg-white shadow-sm">
            <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between h-16">
                    <div class="flex items-center">
                        <a href="blog" class="text-xl font-bold text-indigo-600">BlogHub</a>
                    </div>
                    <div class="flex items-center space-x-4">
                        <a href="#" class="text-gray-600 hover:text-indigo-600">Home</a>
                        <a href="#" class="text-gray-600 hover:text-indigo-600">Blog</a>
                        <a href="#" class="text-gray-600 hover:text-indigo-600">About</a>
                        <a href="#" class="text-gray-600 hover:text-indigo-600">Contact</a>
                        <button class="bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700 transition">
                            Subscribe
                        </button>
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

            <!-- Author Bio -->
            <div class="bg-gray-50 rounded-xl p-6 mb-12">
                <div class="flex items-center mb-4">
                    <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Author" class="w-16 h-16 rounded-full mr-4">
                    <div>
                        <h3 class="font-bold text-lg">John Doe</h3>
                        <p class="text-gray-600">Senior Web Developer & Tech Writer</p>
                    </div>
                </div>
                <p class="text-gray-700">John has been building web applications for over 10 years. He specializes in JavaScript frameworks and architecture design. When not coding, he enjoys writing about technology trends and mentoring junior developers.</p>
                <div class="flex space-x-4 mt-4">
                    <a href="#" class="text-indigo-600 hover:text-indigo-800"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-indigo-600 hover:text-indigo-800"><i class="fab fa-github"></i></a>
                    <a href="#" class="text-indigo-600 hover:text-indigo-800"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>

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

            <!-- Related Posts -->
            <div>
                <h3 class="text-xl font-bold mb-6">You Might Also Like</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <!-- Related Post 1 -->
                    <div class="bg-white rounded-xl overflow-hidden shadow-sm hover:shadow-md transition">
                        <img src="https://images.unsplash.com/photo-1620712943543-bcc4688e7485?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=765&q=80" 
                             alt="Related post" class="w-full h-48 object-cover">
                        <div class="p-4">
                            <span class="text-sm text-indigo-600 font-medium">Technology</span>
                            <h4 class="font-bold mt-1 mb-2">Understanding React Server Components</h4>
                            <p class="text-gray-600 text-sm">A deep dive into the new paradigm for React applications.</p>
                            <div class="flex items-center mt-3 text-sm text-gray-500">
                                <span>May 5, 2023</span>
                                <span class="mx-2">•</span>
                                <span>5 min read</span>
                            </div>
                        </div>
                    </div>

                    <!-- Related Post 2 -->
                    <div class="bg-white rounded-xl overflow-hidden shadow-sm hover:shadow-md transition">
                        <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" 
                             alt="Related post" class="w-full h-48 object-cover">
                        <div class="p-4">
                            <span class="text-sm text-green-600 font-medium">Productivity</span>
                            <h4 class="font-bold mt-1 mb-2">Developer Tools That Will Save You Hours</h4>
                            <p class="text-gray-600 text-sm">Essential tools every developer should have in their toolkit.</p>
                            <div class="flex items-center mt-3 text-sm text-gray-500">
                                <span>April 28, 2023</span>
                                <span class="mx-2">•</span>
                                <span>7 min read</span>
                            </div>
                        </div>
                    </div>

                    <!-- Related Post 3 -->
                    <div class="bg-white rounded-xl overflow-hidden shadow-sm hover:shadow-md transition">
                        <img src="https://images.unsplash.com/photo-1624953587687-daf255b6b80a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" 
                             alt="Related post" class="w-full h-48 object-cover">
                        <div class="p-4">
                            <span class="text-sm text-purple-600 font-medium">Design</span>
                            <h4 class="font-bold mt-1 mb-2">CSS Trends for Modern Web Applications</h4>
                            <p class="text-gray-600 text-sm">Exploring the latest CSS techniques that are changing how we style the web.</p>
                            <div class="flex items-center mt-3 text-sm text-gray-500">
                                <span>April 15, 2023</span>
                                <span class="mx-2">•</span>
                                <span>6 min read</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer class="bg-white py-8">
            <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                    <div>
                        <h3 class="text-lg font-bold mb-4">BlogHub</h3>
                        <p class="text-gray-600">Sharing knowledge and insights about web development, design, and technology.</p>
                    </div>
                    <div>
                        <h4 class="font-bold mb-4">Categories</h4>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-600 hover:text-indigo-600">Web Development</a></li>
                            <li><a href="#" class="text-gray-600 hover:text-indigo-600">JavaScript</a></li>
                            <li><a href="#" class="text-gray-600 hover:text-indigo-600">CSS</a></li>
                            <li><a href="#" class="text-gray-600 hover:text-indigo-600">Design</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-bold mb-4">Company</h4>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-600 hover:text-indigo-600">About</a></li>
                            <li><a href="#" class="text-gray-600 hover:text-indigo-600">Team</a></li>
                            <li><a href="#" class="text-gray-600 hover:text-indigo-600">Careers</a></li>
                            <li><a href="#" class="text-gray-600 hover:text-indigo-600">Contact</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-bold mb-4">Connect</h4>
                        <div class="flex space-x-4">
                            <a href="#" class="text-gray-600 hover:text-indigo-600"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-gray-600 hover:text-indigo-600"><i class="fab fa-github"></i></a>
                            <a href="#" class="text-gray-600 hover:text-indigo-600"><i class="fab fa-linkedin"></i></a>
                            <a href="#" class="text-gray-600 hover:text-indigo-600"><i class="fab fa-youtube"></i></a>
                        </div>
                    </div>
                </div>
                <div class="border-t border-gray-200 mt-8 pt-8 text-center text-gray-500">
                    <p>© 2023 BlogHub. All rights reserved.</p>
                </div>
            </div>
        </footer>

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