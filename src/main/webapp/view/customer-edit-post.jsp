<!-- customer-create-post.jsp (updated to support both create + edit mode) -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Determine form mode: create or edit --%>
<c:set var="isEdit" value="${mode eq 'edit'}" />

<%-- Inside the form: update action + title + button label --%>
<form id="postForm" class="p-6" action="${isEdit ? 'edit-post' : 'customer-create-post'}" method="post" enctype="multipart/form-data">
    <c:if test="${isEdit}">
        <input type="hidden" name="postId" value="${post.id}" />
    </c:if>

    <!-- Title Input -->
    <input type="text" id="title" name="title" 
           value="${isEdit ? post.title : ''}"
           placeholder="Thêm chủ đề..." required />

    <!-- Sections (pre-populate if edit) -->
    <div id="sections-container">
        <c:choose>
            <c:when test="${isEdit}">
                <c:forEach var="section" items="${sections}">
                    <div class="section ...">
                        <input type="text" name="sectionTitles" value="${section.sectionTitle}" ...>
                        <textarea name="sectionContents">${section.sectionContent}</textarea>
                        <input type="file" name="sectionImages" accept="image/*">
                        <button type="button" class="remove-section">Xóa</button>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="section ...">
                    <input type="text" name="sectionTitles" placeholder="Tiêu đề đoạn">
                    <textarea name="sectionContents"></textarea>
                    <input type="file" name="sectionImages" accept="image/*">
                    <button type="button" class="remove-section">Xóa</button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Tags -->
    <select id="tagIds" name="tagIds" multiple>
        <c:forEach var="tag" items="${tagList}">
            <option value="${tag.id}" ${isEdit and selectedTags.contains(tag.id) ? 'selected' : ''}>${tag.name}</option>
        </c:forEach>
    </select>

    <!-- Submit button -->
    <button type="submit">
        ${isEdit ? 'Lưu chỉnh sửa' : 'Đăng'}
    </button>
</form>
