<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/21/2025
  Time: 3:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html
        lang="en"
        class="light-style layout-menu-fixed"
        dir="ltr"
        data-theme="theme-default"
        data-assets-path="/assets/"
        data-template="vertical-menu-template-free"
>
<head>
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>Admin Q&A Management</title>

    <meta name="description" content=""/>

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/fonts/boxicons.css"/>

    <!-- Core CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/core.css"
          class="template-customizer-core-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/theme-default.css"
          class="template-customizer-theme-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo.css"/>

    <!-- Vendors CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/libs/apex-charts/apex-charts.css"/>

    <!-- Page CSS -->
    <style>
        .admin-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 12px;
            margin-bottom: 1.5rem;
        }

        .qna-item {
            background: white;
            border-radius: 10px;
            border: 1px solid #e3e6f0;
            transition: all 0.3s;
            margin-bottom: 1.5rem;
        }

        .qna-item:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }

        .question-section {
            background: #f8f9ff;
            border-left: 4px solid #5a67d8;
            border-radius: 8px;
        }

        .answer-section {
            background: #f0fff4;
            border-left: 4px solid #48bb78;
            border-radius: 8px;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.1rem;
        }

        .admin-avatar {
            width: 35px;
            height: 35px;
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 0.9rem;
        }

        .status-badge {
            font-size: 0.75rem;
            padding: 0.4rem 0.8rem;
        }

        .action-buttons {
            gap: 0.5rem;
        }

        .btn-action {
            padding: 0.375rem 0.75rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.2s;
        }

        .btn-action:hover {
            transform: translateY(-1px);
        }

        .stats-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            border: 1px solid #e3e6f0;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .answer-form {
            background: #fff8dc;
            border: 1px solid #f6e05e;
            border-radius: 8px;
        }

        .edit-form {
            background: #e6fffa;
            border: 1px solid #81e6d9;
            border-radius: 8px;
        }

        .timestamp {
            font-size: 0.85rem;
            color: #718096;
        }

        .question-text {
            font-size: 1rem;
            line-height: 1.6;
            color: #2d3748;
        }

        .answer-text {
            font-size: 0.95rem;
            line-height: 1.6;
            color: #2d3748;
        }

        .delete-form {
            display: inline-block;
        }
    </style>

    <!-- Helpers -->
    <script src="${pageContext.request.contextPath}/assets/vendor/js/helpers.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
</head>
<body>

<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">

        <!-- Site Bar -->
        <%@ include file="/common/site-bar.jsp" %>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar -->
            <%@ include file="/common/nav-bar.jsp" %>
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->
                <div class="container-xxl flex-grow-1 container-p-y">

                    <!-- Header Section -->
                    <div class="card admin-header border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h2 class="mb-2 fw-bold text-white">
                                        <i class="bx bx-chat me-3"></i>
                                        Quản lý Q&A
                                    </h2>
                                    <p class="mb-0 text-white-50">
                                        Quản lý và trả lời các câu hỏi từ khách hàng
                                    </p>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-light btn-sm">
                                        <i class="bx bx-export me-1"></i>
                                        Xuất báo cáo
                                    </button>
                                    <button class="btn btn-outline-light btn-sm">
                                        <i class="bx bx-refresh me-1"></i>
                                        Làm mới
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3">
                            <div class="card stats-card border-0">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-primary-subtle text-primary me-3">
                                            <i class="bx bx-message-dots"></i>
                                        </div>
                                        <div>
                                            <h5 class="mb-0 fw-bold">${qnaList.size()}</h5>
                                            <small class="text-muted">Tổng câu hỏi</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card stats-card border-0">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-success-subtle text-success me-3">
                                            <i class="bx bx-check-circle"></i>
                                        </div>
                                        <div>
                                            <c:set var="answeredCount" value="0"/>
                                            <c:forEach var="q" items="${qnaList}">
                                                <c:if test="${not empty q.answer}">
                                                    <c:set var="answeredCount" value="${answeredCount + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            <h5 class="mb-0 fw-bold">${answeredCount}</h5>
                                            <small class="text-muted">Đã trả lời</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card stats-card border-0">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-warning-subtle text-warning me-3">
                                            <i class="bx bx-hourglass"></i>
                                        </div>
                                        <div>
                                            <h5 class="mb-0 fw-bold">${qnaList.size() - answeredCount}</h5>
                                            <small class="text-muted">Chờ trả lời</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card stats-card border-0">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-info-subtle text-info me-3">
                                            <i class="bx bx-trending-up"></i>
                                        </div>
                                        <div>
                                            <h5 class="mb-0 fw-bold">
                                                <c:choose>
                                                    <c:when test="${qnaList.size() > 0}">
                                                        ${Math.round((answeredCount * 100.0) / qnaList.size())}%
                                                    </c:when>
                                                    <c:otherwise>0%</c:otherwise>
                                                </c:choose>
                                            </h5>
                                            <small class="text-muted">Tỷ lệ phản hồi</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Q&A List -->
                    <c:choose>
                        <c:when test="${empty qnaList}">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body text-center py-5">
                                    <i class="bx bx-message-dots display-1 text-muted mb-3"></i>
                                    <h5 class="text-muted mb-2">Chưa có câu hỏi nào</h5>
                                    <p class="text-muted">Hiện tại chưa có câu hỏi nào từ khách hàng</p>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="q" items="${qnaList}" varStatus="status">
                                <div class="card qna-item border-0 shadow-sm">
                                    <div class="card-body p-4">

                                        <!-- Question Section -->
                                        <div class="d-flex align-items-start mb-4">
                                            <div class="user-avatar me-3">
                                                    ${q.customerName.substring(0, 1).toUpperCase()}
                                            </div>
                                            <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <div>
                                                        <h6 class="mb-1 fw-bold">${q.customerName}</h6>
                                                        <div class="timestamp">
                                                            <i class="bx bx-time-five me-1"></i>
                                                                ${q.createdAt}
                                                        </div>
                                                    </div>
                                                    <div class="d-flex gap-2 align-items-center">
                                                        <c:choose>
                                                            <c:when test="${empty q.answer}">
                                                                <span class="badge bg-warning status-badge">
                                                                    <i class="bx bx-hourglass me-1"></i>
                                                                    Chờ trả lời
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success status-badge">
                                                                    <i class="bx bx-check-circle me-1"></i>
                                                                    Đã trả lời
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <!-- Delete Button -->
                                                        <form action="qna" method="POST" class="delete-form">
                                                            <input type="hidden" name="action" value="delete"/>
                                                            <input type="hidden" name="id" value="${q.id}"/>
                                                            <button type="submit"
                                                                    class="btn btn-outline-danger btn-sm"
                                                                    onclick="return confirm('Bạn có chắc chắn muốn xóa câu hỏi này?')"
                                                                    title="Xóa câu hỏi">
                                                                <i class="bx bx-trash"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>

                                                <div class="question-section p-3">
                                                    <div class="d-flex align-items-start">
                                                        <i class="bx bx-help-circle text-primary me-2 mt-1"></i>
                                                        <p class="question-text mb-0">${q.question}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Answer Section -->
                                        <div class="ms-5">
                                            <c:choose>
                                                <c:when test="${empty q.answer}">
                                                    <!-- Answer Form -->
                                                    <div class="answer-form p-3">
                                                        <div class="d-flex align-items-start">
                                                            <div class="admin-avatar me-3 mt-1">
                                                                <i class="bx bx-user-check"></i>
                                                            </div>
                                                            <div class="flex-grow-1">
                                                                <h6 class="mb-3 fw-semibold text-warning">
                                                                    <i class="bx bx-edit me-1"></i>
                                                                    Nhập câu trả lời
                                                                </h6>
                                                                <form action="qna" method="POST">
                                                                    <input type="hidden" name="action" value="answer"/>
                                                                    <input type="hidden" name="id" value="${q.id}"/>
                                                                    <div class="mb-3">
                                                                        <textarea class="form-control"
                                                                                  name="answer"
                                                                                  rows="4"
                                                                                  placeholder="Nhập câu trả lời cho câu hỏi này..."
                                                                                  required></textarea>
                                                                    </div>
                                                                    <button type="submit" class="btn btn-success btn-action">
                                                                        <i class="bx bx-send me-1"></i>
                                                                        Gửi trả lời
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- Display Answer -->
                                                    <div class="answer-section p-3 mb-3">
                                                        <div class="d-flex align-items-start">
                                                            <div class="admin-avatar me-3">
                                                                <i class="bx bx-user-check"></i>
                                                            </div>
                                                            <div class="flex-grow-1">
                                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                                    <h6 class="mb-0 fw-semibold text-success">
                                                                        <i class="bx bx-shield-check me-1"></i>
                                                                        Admin đã trả lời
                                                                    </h6>
                                                                    <div class="timestamp">
                                                                        <i class="bx bx-time-five me-1"></i>
                                                                        <c:if test="${not empty q.answeredAt}">
                                                                            ${q.answeredAt}
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                                <div class="d-flex align-items-start">
                                                                    <i class="bx bx-message-square-detail text-success me-2 mt-1"></i>
                                                                    <p class="answer-text mb-0">${q.answer}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Edit Answer Form -->
                                                    <div class="edit-form p-3">
                                                        <div class="d-flex align-items-start">
                                                            <div class="admin-avatar me-3 mt-1">
                                                                <i class="bx bx-edit-alt"></i>
                                                            </div>
                                                            <div class="flex-grow-1">
                                                                <h6 class="mb-3 fw-semibold text-info">
                                                                    <i class="bx bx-edit me-1"></i>
                                                                    Chỉnh sửa câu trả lời
                                                                </h6>
                                                                <form action="qna" method="POST">
                                                                    <input type="hidden" name="action" value="edit"/>
                                                                    <input type="hidden" name="id" value="${q.id}"/>
                                                                    <div class="mb-3">
                                                                        <textarea class="form-control"
                                                                                  name="answer"
                                                                                  rows="4"
                                                                                  required>${q.answer}</textarea>
                                                                    </div>
                                                                    <button type="submit" class="btn btn-info btn-action">
                                                                        <i class="bx bx-save me-1"></i>
                                                                        Cập nhật
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- / Content -->

                <!-- Footer -->
                <footer class="content-footer footer bg-footer-theme">
                    <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                        <div class="mb-2 mb-md-0">
                            ©
                            <script>
                                document.write(new Date().getFullYear());
                            </script>
                            , made with ❤️ by
                            <a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
                        </div>
                        <div>
                            <a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a>
                            <a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More
                                Themes</a>

                            <a
                                    href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/"
                                    target="_blank"
                                    class="footer-link me-4"
                            >Documentation</a
                            >

                            <a
                                    href="https://github.com/themeselection/sneat-html-admin-template-free/issues"
                                    target="_blank"
                                    class="footer-link me-4"
                            >Support</a
                            >
                        </div>
                    </div>
                </footer>
                <!-- / Footer -->

                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
</div>
<!-- / Layout wrapper -->

<!-- Core JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/popper/popper.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>
<!-- endbuild -->
<!-- Vendors JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/apex-charts/apexcharts.js"></script>
<!-- Main JS -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<!-- Page JS -->
<script src="${pageContext.request.contextPath}/assets/js/dashboards-analytics.js"></script>

<script>
    // Auto-resize textareas
    document.querySelectorAll('textarea').forEach(textarea => {
        textarea.addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = this.scrollHeight + 'px';
        });
    });

    // Enhanced delete confirmation
    document.querySelectorAll('form[action="qna"] button[onclick*="confirm"]').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const result = confirm('⚠️ Bạn có chắc chắn muốn xóa câu hỏi này?\n\nHành động này không thể hoàn tác!');
            if (result) {
                this.closest('form').submit();
            }
        });
    });

    // Add loading state for form submissions
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function() {
            const submitBtn = this.querySelector('button[type="submit"]');
            if (submitBtn) {
                const originalText = submitBtn.innerHTML;
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-1" role="status"></span>Đang xử lý...';

                // Re-enable after 3 seconds to prevent permanent disable on error
                setTimeout(() => {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = originalText;
                }, 3000);
            }
        });
    });
</script>

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>