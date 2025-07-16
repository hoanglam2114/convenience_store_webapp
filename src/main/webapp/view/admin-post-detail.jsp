<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Xem Bài Viết</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 font-sans leading-relaxed tracking-wide">

        <div class="max-w-4xl mx-auto my-10 bg-white rounded-lg shadow-md p-8">
            <!-- Tiêu đề -->
            <h1 class="text-3xl font-bold text-gray-800 mb-2">${post.title}</h1>

            <!-- Tác giả và ngày -->
            <div class="flex items-center justify-between text-sm text-gray-500 mb-4">
                <span>Người đăng: <strong>${post.userName}</strong></span>
                <span>
                    Ngày tạo: <fmt:formatDate value="${post.createdAt}" pattern="dd-MM-yyyy HH:mm" />
                </span>
            </div>

            <!-- Trạng thái -->
            <div class="mb-6">
                <span class="inline-block px-3 py-1 text-xs font-medium rounded-full
                      <c:choose>
                      <c:when test="${post.status eq 'pending'}"> bg-yellow-100 text-yellow-700 </c:when>
                    <c:when test="${post.status eq 'approved'}"> bg-green-100 text-green-700 </c:when>
                    <c:when test="${post.status eq 'rejected'}"> bg-red-100 text-red-700 </c:when>
                    <c:otherwise> bg-gray-200 text-gray-800 </c:otherwise>
                    </c:choose>">
                    ${post.status}
                </span>
            </div>

            <!-- Ảnh đại diện -->
            <c:if test="${not empty post.postImage}">
                <img src="image/${post.postImage.imageUrl}" alt="Ảnh bài viết" class="w-full rounded-lg mb-6">
            </c:if>

            <!-- Nội dung -->
            <div class="prose prose-lg max-w-none">
                <c:out value="${post.content}" escapeXml="false"/>
            </div>

            <!-- Quay lại -->
            <div class="mt-10">
                <a href="admin-manage-posts" class="inline-block bg-indigo-600 text-white px-5 py-2 rounded hover:bg-indigo-700">
                    ← Quay lại quản lý
                </a>
            </div>
        </div>

    </body>
</html>
