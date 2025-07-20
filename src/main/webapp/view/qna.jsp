<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/21/2025
  Time: 3:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html
        lang="en"
        class="light-style layout-menu-fixed"
        dir="ltr"
        data-theme="theme-default"
        data-assets-path="/assets/"
        data-template="vertical-menu-template-free"
>
<%
    request.setAttribute("pageTitle", "Hỏi đáp");
%>
<jsp:include page="/common/header.jsp"/>
<jsp:include page="/common/customer-nav-bar.jsp"/>
<body>
<!-- Add padding to account for fixed navbar -->
<div style="padding-top: 80px;"></div>
<div class="container-fluid">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header qna-header border-0 rounded-top">
                    <div class="d-flex align-items-center">
                        <i class="bi bi-chat-dots-fill fs-2 me-3"></i>
                        <div>
                            <h2 class="mb-1 fw-bold">Q&A - Hỏi đáp</h2>
                            <p class="mb-0 opacity-75">Đặt câu hỏi và nhận câu trả lời từ chúng tôi</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-4 mb-4">
            <!-- Question Form -->
            <div class="card question-form border-0">
                <div class="card-header bg-primary text-white border-0 rounded-top">
                    <h5 class="card-title mb-0">
                        <i class="bi bi-question-circle-fill me-2"></i>
                        Đặt câu hỏi mới
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="qna" method="POST">
                        <input type="hidden" name="action" value="addQuestion"/>

                        <div class="mb-3">
                            <label for="customerName" class="form-label fw-semibold">
                                <i class="bi bi-person-fill me-1"></i>
                                Tên của bạn
                            </label>
                            <input type="text"
                                   class="form-control form-control-lg"
                                   id="customerName"
                                   name="customerName"
                                   placeholder="Nhập tên của bạn..."
                                   required/>
                        </div>

                        <div class="mb-4">
                            <label for="question" class="form-label fw-semibold">
                                <i class="bi bi-chat-text-fill me-1"></i>
                                Câu hỏi
                            </label>
                            <textarea class="form-control"
                                      id="question"
                                      name="question"
                                      rows="4"
                                      placeholder="Nhập câu hỏi của bạn..."
                                      required></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary btn-lg w-100">
                            <i class="bi bi-send-fill me-2"></i>
                            Gửi câu hỏi
                        </button>
                    </form>
                </div>
            </div>

            <!-- Stats Card -->
            <div class="card mt-4 border-0 shadow-sm">
                <div class="card-body text-center">
                    <div class="row">
                        <div class="col-6">
                            <div class="border-end">
                                <h4 class="text-primary mb-1">${qnaList.size()}</h4>
                                <small class="text-muted">Tổng câu hỏi</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <h4 class="text-success mb-1">
                                <c:set var="answeredCount" value="0"/>
                                <c:forEach var="q" items="${qnaList}">
                                    <c:if test="${not empty q.answer}">
                                        <c:set var="answeredCount" value="${answeredCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${answeredCount}
                            </h4>
                            <small class="text-muted">Đã trả lời</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <!-- Q&A List Header -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="mb-0 fw-bold">
                    <i class="bi bi-list-ul me-2 text-primary"></i>
                    Danh sách câu hỏi & trả lời
                </h4>
                <div class="d-flex gap-2">
                    <%--                    <button class="btn btn-outline-secondary btn-sm">--%>
                    <%--                        <i class="bi bi-funnel me-1"></i>--%>
                    <%--                        Bộ lọc--%>
                    <%--                    </button>--%>
                    <%--                    <button class="btn btn-outline-primary btn-sm">--%>
                    <%--                        <i class="bi bi-arrow-clockwise me-1"></i>--%>
                    <%--                        Làm mới--%>
                    <%--                    </button>--%>
                </div>
            </div>

            <!-- Q&A Items -->
            <c:choose>
                <c:when test="${empty qnaList}">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center py-5">
                            <i class="bi bi-chat-dots display-1 text-muted mb-3"></i>
                            <h5 class="text-muted mb-2">Chưa có câu hỏi nào</h5>
                            <p class="text-muted">Hãy là người đầu tiên đặt câu hỏi!</p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="q" items="${qnaList}" varStatus="status">
                        <div class="card qna-item mb-3 border-0">
                            <div class="card-body p-4">
                                <!-- Question Section -->
                                <div class="d-flex align-items-start mb-3">
                                    <div class="user-avatar me-3">
                                            ${q.customerName.substring(0, 1).toUpperCase()}
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <div>
                                                <h6 class="mb-0 fw-bold">${q.customerName}</h6>
                                                <span class="timestamp">
                                                        <i class="bi bi-clock me-1"></i>
                                                        ${q.createdAt}
                                                    </span>
                                            </div>
                                            <c:choose>
                                                <c:when test="${empty q.answer}">
                                                        <span class="badge bg-warning status-badge">
                                                            <i class="bi bi-hourglass-split me-1"></i>
                                                            Chờ trả lời
                                                        </span>
                                                </c:when>
                                                <c:otherwise>
                                                        <span class="badge bg-success status-badge">
                                                            <i class="bi bi-check-circle-fill me-1"></i>
                                                            Đã trả lời
                                                        </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="question-text p-3">
                                            <i class="bi bi-quote text-primary me-2"></i>
                                            <span>${q.question}</span>
                                        </div>
                                    </div>
                                </div>
                                <!-- Answer Section -->
                                <!-- Answer Section -->
                                <c:if test="${not empty q.answer}">
                                    <!-- Display Answer -->
                                    <div class="d-flex align-items-start ms-5">
                                        <div class="admin-avatar me-3">
                                            <i class="bi bi-person-badge-fill"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <h6 class="mb-0 fw-semibold text-success">
                                                    <i class="bi bi-shield-check me-1"></i>
                                                    Admin
                                                </h6>
                                                <span class="timestamp">
                    <i class="bi bi-clock me-1"></i>
                    ${q.answeredAt}
                </span>
                                            </div>
                                            <div class="answer-text p-3">
                                                <i class="bi bi-reply-fill text-success me-2"></i>
                                                <span>${q.answer}</span>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>

                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<jsp:include page="/common/customer-footer.jsp"/>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Auto-resize textareas
    document.querySelectorAll('textarea').forEach(textarea => {
        textarea.addEventListener('input', function () {
            this.style.height = 'auto';
            this.style.height = this.scrollHeight + 'px';
        });
    });

    // Smooth scroll to new questions
    document.querySelector('form[action="qna"]').addEventListener('submit', function () {
        setTimeout(() => {
            window.scrollTo({top: 0, behavior: 'smooth'});
        }, 100);
    });
</script>
</body>
</html>