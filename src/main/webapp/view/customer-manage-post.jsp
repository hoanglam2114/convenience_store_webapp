<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý bài viết</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    </head>
    <body class="min-h-screen bg-gradient-to-r from-[#667eea] to-[#764ba2] font-sans text-gray-800">

        <div class="max-w-7xl mx-auto py-12 px-6">

            <!-- Nút quay lại -->
            <div class="mb-6">
                <a href="blog" class="inline-flex items-center text-white hover:text-yellow-300 transition">
                    <i class="fa-solid fa-arrow-left mr-2"></i>
                    <span class="text-sm font-medium">Quay lại</span>
                </a>
            </div>

            <!-- Tiêu đề -->
            <div class="text-center mb-10 text-white drop-shadow-sm">
                <h1 class="text-4xl font-bold">Quản lý bài viết</h1>
                <p class="text-lg mt-2 text-violet-100">Xem và quản lý các bài viết bạn đã tạo</p>
            </div>

            <!-- Nếu không có bài viết -->
            <c:if test="${empty posts}">
                <div class="text-center p-8 bg-white/70 backdrop-blur rounded-lg shadow text-gray-600">
                    <p class="text-lg">Bạn chưa có bài viết nào.</p>
                </div>
            </c:if>

            <!-- Nếu có bài viết -->
            <c:if test="${not empty posts}">
                <div class="overflow-hidden shadow ring-1 ring-white/30 sm:rounded-lg bg-white/80 backdrop-blur-md">
                    <table class="min-w-full divide-y divide-gray-300 text-sm">
                        <thead class="bg-white/90 text-gray-700 uppercase text-xs">
                            <tr>
                                <th class="px-6 py-3 text-left">Tiêu đề</th>
                                <th class="px-6 py-3 text-left">Trạng thái</th>
                                <th class="px-6 py-3 text-center">Ngày tạo</th>
                                <th class="px-6 py-3 text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <c:forEach var="post" items="${posts}">
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4 font-medium text-gray-800">
                                        ${post.title}
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="px-3 py-1 inline-flex text-xs font-semibold rounded-full
                                              <c:choose>
                                                  <c:when test="${post.status == 'approved'}">bg-green-100 text-green-800</c:when>
                                                  <c:when test="${post.status == 'pending'}">bg-yellow-100 text-yellow-800</c:when>
                                                  <c:otherwise>bg-red-100 text-red-700</c:otherwise>
                                              </c:choose>">
                                            ${post.status}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-center text-gray-600">
                                        <fmt:formatDate value="${post.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </td>
                                    <td class="px-6 py-4 text-center space-x-3">
                                        <c:if test="${post.status == 'approved'}">
                                            <a href="post-detail?id=${post.id}" class="text-blue-600 hover:text-blue-800" title="Xem">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${post.status == 'pending' || post.status == 'rejected'}">
                                            <a href="get-post-detail?id=${post.id}" class="text-blue-600 hover:text-blue-800" title="Xem">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>
                                            <a href="customer-edit-post?id=${post.id}" class="text-yellow-500 hover:text-yellow-700" title="Sửa">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                            <a href="delete-post?id=${post.id}" class="text-red-600 hover:text-red-800" title="Xóa"
                                               onclick="return confirm('Bạn có chắc muốn xóa bài viết này?');">
                                                <i class="fa-solid fa-trash"></i>
                                            </a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>

    </body>
</html>
