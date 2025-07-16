<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/22/2025
  Time: 9:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    request.setAttribute("pageTitle", "Hồ sơ cá nhân");
%>
<jsp:include page="/common/header.jsp"/>
<jsp:include page="/common/customer-nav-bar.jsp"/>
<body class="bg-light">
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom shadow-sm">
    <div class="container">
        <a class="navbar-brand text-white fw-bold fs-4" href="customer-home">
            <i class="bi bi-shop me-2"></i>Gian Hàng
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link text-white-50 fw-medium px-3 py-2 rounded-pill me-2" href="customer-home">
                        <i class="bi bi-house me-1"></i>Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link  fw-medium px-3 py-2 rounded-pill me-2 bg-opacity-20" href="customer-profile">
                        <i class="bi bi-person-circle me-1"></i>Hồ sơ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white-50 fw-medium px-3 py-2 rounded-pill" href="customer-logout">
                        <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Profile Header -->
<section class="profile-header text-white py-5 mb-4">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-3 text-center">
                <div class="rounded-circle bg-opacity-20 border border-white border-opacity-30 d-flex align-items-center justify-content-center mx-auto mb-3"
                     style="width: 120px; height: 120px; background-color: #6c757d;">
                    <c:choose>
                        <c:when test="${not empty customer.avatarUrl}">
                            <img src="uploads/${customer.avatarUrl}" alt="Avatar" class="rounded-circle"
                                 style="width: 100%; height: 100%; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-person-fill"
                               style="font-size: 4rem; position: relative; z-index: 1; color: white;"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="col-md-9 text-center text-md-start">
                <h1 class="display-5 fw-bold mb-3">
                    <c:choose>
                        <c:when test="${not empty sessionScope.customer.name}">
                            ${sessionScope.customer.name}
                        </c:when>
                        <c:otherwise>
                            Khách hàng
                        </c:otherwise>
                    </c:choose>
                </h1>
                <div class="text-white-50 mb-3">
                    <i class="bi bi-telephone me-2"></i>
                    ${sessionScope.customer.phone}
                </div>
                <div class="d-flex justify-content-center justify-content-md-start align-items-center flex-wrap gap-2">
                    <span class="points-badge text-white px-3 py-2 rounded-pill fw-semibold">
                        <i class="bi bi-star-fill me-1"></i>
                        ${sessionScope.customer.point} điểm
                    </span>
                    <span class="type-badge type-${sessionScope.customer.type_id == 1 ? 'standard' : sessionScope.customer.type_id == 2 ? 'silver' : sessionScope.customer.type_id == 3 ? 'gold' : 'platinum'} px-3 py-2 rounded-pill fw-semibold">
                        <c:choose>
                            <c:when test="${sessionScope.customer.type_id == 1}">
                                <i class="bi bi-person me-1"></i>Thành viên thường
                            </c:when>
                            <c:when test="${sessionScope.customer.type_id == 2}">
                                <i class="bi bi-award me-1"></i>Thành viên bạc
                            </c:when>
                            <c:when test="${sessionScope.customer.type_id == 3}">
                                <i class="bi bi-gem me-1"></i>Thành viên vàng
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-crown me-1"></i>Thành viên bạch kim
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Main Content -->
<div class="container">
    <div class="row">
        <!-- Profile Information -->
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 rounded-3 mb-4">
                <div class="card-header bg-light border-0 rounded-top-3 p-4">
                    <h3 class="card-title mb-0 fw-semibold text-dark d-flex align-items-center">
                        <i class="bi bi-person-lines-fill text-primary me-2"></i>
                        Thông tin cá nhân
                    </h3>
                </div>
                <div class="card-body p-4">
                    <div class="row mb-3 pb-3 border-bottom">
                        <div class="col-md-3">
                            <div class="fw-semibold text-muted d-flex align-items-center">
                                <i class="bi bi-hash text-primary me-2"></i>
                                ID:
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="fw-medium text-dark">${sessionScope.customer.id}</div>
                        </div>
                    </div>
                    <div class="row mb-3 pb-3 border-bottom">
                        <div class="col-md-3">
                            <div class="fw-semibold text-muted d-flex align-items-center">
                                <i class="bi bi-person text-primary me-2"></i>
                                Họ tên:
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="fw-medium text-dark">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.customer.name}">
                                        ${sessionScope.customer.name}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Chưa cập nhật</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 pb-3 border-bottom">
                        <div class="col-md-3">
                            <div class="fw-semibold text-muted d-flex align-items-center">
                                <i class="bi bi-telephone text-primary me-2"></i>
                                Số điện thoại:
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="fw-medium text-dark">${sessionScope.customer.phone}</div>
                        </div>
                    </div>
                    <div class="row mb-3 pb-3 border-bottom">
                        <div class="col-md-3">
                            <div class="fw-semibold text-muted d-flex align-items-center">
                                <i class="bi bi-gender-ambiguous text-primary me-2"></i>
                                Giới tính:
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="fw-medium text-dark">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.customer.gender}">
                                        ${sessionScope.customer.gender}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Chưa cập nhật</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 pb-3 border-bottom">
                        <div class="col-md-3">
                            <div class="fw-semibold text-muted d-flex align-items-center">
                                <i class="bi bi-star text-primary me-2"></i>
                                Điểm tích lũy:
                            </div>
                        </div>
                        <div class="col-md-9">
                            <span class="points-badge text-white px-3 py-2 rounded-pill fw-semibold">
                                <i class="bi bi-star-fill me-1"></i>
                                ${sessionScope.customer.point} điểm
                            </span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="fw-semibold text-muted d-flex align-items-center">
                                <i class="bi bi-award text-primary me-2"></i>
                                Loại thành viên:
                            </div>
                        </div>
                        <div class="col-md-9">
                            <span class="type-badge type-${sessionScope.customer.type_id == 1 ? 'standard' : sessionScope.customer.type_id == 2 ? 'silver' : sessionScope.customer.type_id == 3 ? 'gold' : 'platinum'} px-3 py-2 rounded-pill fw-semibold">
                                <c:choose>
                                    <c:when test="${sessionScope.customer.type_id == 1}">
                                        <i class="bi bi-person me-1"></i>Thành viên thường
                                    </c:when>
                                    <c:when test="${sessionScope.customer.type_id == 2}">
                                        <i class="bi bi-award me-1"></i>Thành viên bạc
                                    </c:when>
                                    <c:when test="${sessionScope.customer.type_id == 3}">
                                        <i class="bi bi-gem me-1"></i>Thành viên vàng
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-crown me-1"></i>Thành viên bạch kim
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-transparent p-4 text-center">
                    <button type="button"
                            class="btn btn-primary-custom text-white fw-semibold px-4 py-2 rounded-pill me-2 mb-2"
                            data-bs-toggle="modal" data-bs-target="#editProfileModal">
                        <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa thông tin
                    </button>
                    <a href="purchase-history?"
                       class="btn btn-outline-secondary fw-semibold px-4 py-2 rounded-pill me-2 mb-2">
                        <i class="bi bi-clock-history me-2"></i>Lịch sử mua hàng
                    </a>
                    <a href="customer-home" class="btn btn-outline-secondary fw-semibold px-4 py-2 rounded-pill mb-2">
                        <i class="bi bi-arrow-left me-2"></i>Quay lại trang chủ
                    </a>
                </div>
            </div>
        </div>

        <!-- Statistics -->
        <div class="col-lg-4">
            <div class="row g-3">
                <div class="col-12">
                    <div class="card shadow-sm border-0 rounded-3 text-center p-4">
                        <div class="rounded-circle bg-success d-flex align-items-center justify-content-center mx-auto mb-3 text-white"
                             style="width: 60px; height: 60px;">
                            <i class="bi bi-star-fill fs-4"></i>
                        </div>
                        <div class="display-6 fw-bold text-dark">${sessionScope.customer.point}</div>
                        <div class="text-muted fw-medium">Điểm tích lũy</div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="card shadow-sm border-0 rounded-3 text-center p-4">
                        <div class="rounded-circle bg-primary d-flex align-items-center justify-content-center mx-auto mb-3 text-white"
                             style="width: 60px; height: 60px;">
                            <i class="bi bi-bag-check fs-4"></i>
                        </div>
                        <div class="display-6 fw-bold text-dark">${totalOrders}</div>
                        <div class="text-muted fw-medium">Đơn hàng đã mua</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Edit Profile Modal -->
<div class="modal fade" id="editProfileModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-3">
            <div class="modal-header navbar-custom text-white rounded-top-3 px-3">
                <h5 class="modal-title">
                    <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa thông tin
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="edit-profile" method="post" enctype="multipart/form-data">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label for="customerAvatar" class="form-label fw-semibold">
                            <i class="bi bi-person me-2"></i>Ảnh đại diện
                        </label>
                        <input type="file" class="form-control" id="customerAvatar" name="avatar" accept="image/*">
                    </div>
                    <div class="mb-3">
                        <label for="customerName" class="form-label fw-semibold">
                            <i class="bi bi-person me-2"></i>Họ và tên
                        </label>
                        <input type="text" class="form-control" id="customerName" name="name"
                               value="${sessionScope.customer.name}" placeholder="Nhập họ và tên của bạn">
                    </div>
                    <div class="mb-3">
                        <label for="gender" class="form-label fw-semibold">
                            <i class="bi bi-gender-ambiguous me-2"></i>Giới tính
                        </label>
                        <select class="form-select" id="gender" name="gender">
                            <option value="">-- Chọn giới tính --</option>
                            <option value="Nam" ${sessionScope.customer.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                            <option value="Nữ" ${sessionScope.customer.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                            <option value="Khác" ${sessionScope.customer.gender == 'Khác' ? 'selected' : ''}>Khác
                            </option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="customerPhone" class="form-label fw-semibold">
                            <i class="bi bi-telephone me-2"></i>Số điện thoại
                        </label>
                        <input type="tel" class="form-control bg-light" id="customerPhone" name="phone"
                               value="${sessionScope.customer.phone}" readonly>
                        <div class="form-text">
                            <i class="bi bi-info-circle me-1"></i>
                            Số điện thoại không thể thay đổi
                        </div>
                    </div>
                    <input type="hidden" name="id" value="${sessionScope.customer.id}">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary rounded-pill px-3" data-bs-dismiss="modal">Hủy
                    </button>
                    <button type="submit" class="btn btn-primary-custom text-white rounded-pill px-3">
                        <i class="bi bi-check-lg me-2"></i>Lưu thay đổi
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!--footer-->
<jsp:include page="/common/customer-footer.jsp"/>
<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Add some interactive features
        const editBtn = document.querySelector('[data-bs-target="#editProfileModal"]');
        const statCards = document.querySelectorAll('.stat-card');

        // Animate stat cards on load
        statCards.forEach((card, index) => {
            setTimeout(() => {
                card.style.transform = 'translateY(20px)';
                card.style.opacity = '0';
                card.style.transition = 'all 0.6s ease';

                setTimeout(() => {
                    card.style.transform = 'translateY(0)';
                    card.style.opacity = '1';
                }, 100);
            }, index * 200);
        });

        // Form validation for edit profile
        const editForm = document.querySelector('form[action="update-profile"]');
        if (editForm) {
            editForm.addEventListener('submit', function (e) {
                const nameInput = this.querySelector('input[name="name"]');
                if (!nameInput.value.trim()) {
                    e.preventDefault();
                    nameInput.focus();
                    nameInput.classList.add('is-invalid');

                    // Remove invalid class after input
                    nameInput.addEventListener('input', function () {
                        this.classList.remove('is-invalid');
                    }, {once: true});
                }
            });
        }
    });
</script>
</body>
</html>