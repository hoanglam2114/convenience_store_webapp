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
    <body class="bg-gray-100 text-gray-800 font-sans">

        <div class="max-w-6xl mx-auto px-6 py-8">
            <h1 class="text-3xl font-bold mb-6 text-gray-700">📚 Quản lý bài viết của bạn</h1>

            <c:if test="${empty posts}">
                <div class="p-4 bg-white border rounded shadow text-gray-500">
                    Bạn chưa có bài viết nào.
                </div>
            </c:if>

            <c:if test="${not empty posts}">
                <div class="bg-white shadow-md rounded-lg overflow-hidden">
                    <table class="min-w-full table-auto text-sm">
                        <thead class="bg-gray-50 text-gray-600 uppercase text-xs">
                            <tr>
                                <th class="px-6 py-3 text-left">Tiêu đề</th>
                                <th class="px-6 py-3 text-left">Trạng thái</th>
                                <th class="px-6 py-3">Ngày tạo</th>
                                <th class="px-6 py-3">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <c:forEach var="post" items="${posts}">
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4">
                                        <div class="font-semibold text-gray-800">${post.title}</div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="inline-block px-2 py-1 text-xs font-medium rounded-full
                                              <c:choose>
                                                  <c:when test="${post.status == 'approved'}">bg-green-100 text-green-700</c:when>
                                                  <c:when test="${post.status == 'pending'}">bg-yellow-100 text-yellow-800</c:when>
                                                  <c:otherwise>bg-red-100 text-red-700</c:otherwise>
                                              </c:choose>
                                              ">
                                            ${post.status}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <fmt:formatDate value="${post.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </td>
                                    <td class="px-6 py-4 text-center space-x-2">

                                        <c:if test="${post.status == 'approved'}">
                                            <a href="post-detail?id=${post.id}" class="text-blue-600 hover:text-blue-800" title="Xem">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${post.status == 'pending' || post.status == 'rejected'}">
                                            <a href="get-post-detail?id=${post.id}" class="text-blue-600 hover:text-blue-800" title="Xem">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${post.status == 'pending' || post.status == 'rejected'}">
                                            <a href="customer-edit-post?id=${post.id}" class="text-yellow-600 hover:text-yellow-800" title="Sửa">
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
