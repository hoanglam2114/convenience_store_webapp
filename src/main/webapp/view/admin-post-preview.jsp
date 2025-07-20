<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Xem trước bài viết</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/core.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <!-- Boxicons & FontAwesome -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/fonts/boxicons.css" />
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico" />

        <!-- Tailwind CDN & FontAwesome -->
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    </head>
    <body class="bg-gray-50 text-gray-800">

        <!-- Main Content -->
        <main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10 fade-in">

            <!-- Thông báo chế độ xem trước -->
            <div class="mb-4 p-3 bg-yellow-50 border border-yellow-300 rounded text-yellow-800 text-sm">
                <i class="fas fa-eye mr-2"></i>Bạn đang xem trước bài viết của khách hàng
            </div>

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
                    <img src="${pageContext.request.contextPath}/image/${post.postImage.imageUrl}"
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
                        <img src="${pageContext.request.contextPath}/image/${section.sectionImageUrl}" alt="Section Image">
                    </c:if>
                </c:forEach>
            </article>

            <!-- Trạng thái bài viết -->
            <div class="mb-4">
                <span class="inline-block px-3 py-1 text-xs font-semibold rounded-full
                      <c:choose>
                          <c:when test="${post.status eq 'approved'}">bg-green-100 text-green-800</c:when>
                          <c:when test="${post.status eq 'rejected'}">bg-red-100 text-red-800</c:when>
                          <c:otherwise>bg-yellow-100 text-yellow-800</c:otherwise>
                      </c:choose>">
                    ${post.status}
                </span>
            </div>
        </main>

    </body>
</html>
