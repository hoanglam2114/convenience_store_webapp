<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/22/2025
  Time: 9:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hồ Sơ Khách Hàng</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --card-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
      --hover-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
    }

    body {
      background-color: #f8f9fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* Navbar Styling */
    .navbar-custom {
      background: var(--primary-gradient);
      box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
      padding: 1rem 0;
    }

    .navbar-brand {
      font-weight: 700;
      font-size: 1.5rem;
      color: white !important;
    }

    .navbar-nav .nav-link {
      color: rgba(255, 255, 255, 0.9) !important;
      font-weight: 500;
      margin: 0 0.5rem;
      padding: 0.5rem 1rem !important;
      border-radius: 25px;
      transition: all 0.3s ease;
    }

    .navbar-nav .nav-link:hover {
      background-color: rgba(255, 255, 255, 0.1);
      color: white !important;
      transform: translateY(-1px);
    }

    .navbar-nav .nav-link.active {
      background-color: rgba(255, 255, 255, 0.2);
      color: white !important;
    }

    /* Profile Header */
    .profile-header {
      background: var(--primary-gradient);
      color: white;
      padding: 3rem 0 2rem;
      margin-bottom: 2rem;
    }

    .profile-avatar {
      width: 120px;
      height: 120px;
      background: rgba(255, 255, 255, 0.2);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 3rem;
      margin: 0 auto 1rem;
      border: 4px solid rgba(255, 255, 255, 0.3);
    }

    .profile-name {
      font-size: 2rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }

    .profile-info {
      opacity: 0.9;
    }

    /* Cards */
    .info-card {
      background: white;
      border-radius: 15px;
      box-shadow: var(--card-shadow);
      border: none;
      transition: all 0.3s ease;
      margin-bottom: 2rem;
    }

    .info-card:hover {
      transform: translateY(-2px);
      box-shadow: var(--hover-shadow);
    }

    .card-header-custom {
      background: linear-gradient(45deg, #f8f9fa, #e9ecef);
      border-bottom: 1px solid #dee2e6;
      border-radius: 15px 15px 0 0 !important;
      padding: 1.5rem;
    }

    .card-title-custom {
      margin: 0;
      font-weight: 600;
      color: #2c3e50;
      display: flex;
      align-items: center;
    }

    .card-title-custom i {
      margin-right: 0.5rem;
      color: #667eea;
    }

    /* Info Items */
    .info-item {
      display: flex;
      align-items: center;
      padding: 1rem 0;
      border-bottom: 1px solid #f1f3f4;
    }

    .info-item:last-child {
      border-bottom: none;
    }

    .info-label {
      font-weight: 600;
      color: #6c757d;
      min-width: 120px;
      display: flex;
      align-items: center;
    }

    .info-label i {
      margin-right: 0.5rem;
      color: #667eea;
    }

    .info-value {
      color: #2c3e50;
      font-weight: 500;
    }

    /* Points Badge */
    .points-badge {
      background: linear-gradient(45deg, #28a745, #20c997);
      color: white;
      padding: 0.5rem 1rem;
      border-radius: 25px;
      font-weight: 600;
      display: inline-flex;
      align-items: center;
    }

    .points-badge i {
      margin-right: 0.5rem;
    }

    /* Customer Type Badge */
    .type-badge {
      padding: 0.4rem 1rem;
      border-radius: 20px;
      font-weight: 600;
      font-size: 0.9rem;
    }

    .type-standard {
      background: #e3f2fd;
      color: #1976d2;
    }

    .type-silver {
      background: #f3e5f5;
      color: #7b1fa2;
    }

    .type-gold {
      background: #fff8e1;
      color: #f57c00;
    }

    .type-platinum {
      background: #e8f5e8;
      color: #388e3c;
    }

    /* Action Buttons */
    .btn-action {
      border-radius: 25px;
      padding: 0.75rem 2rem;
      font-weight: 600;
      transition: all 0.3s ease;
      margin: 0.25rem;
    }

    .btn-primary-custom {
      background: var(--primary-gradient);
      border: none;
      color: white;
    }

    .btn-primary-custom:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
      color: white;
    }

    .btn-secondary-custom {
      background: transparent;
      border: 2px solid #6c757d;
      color: #6c757d;
    }

    .btn-secondary-custom:hover {
      background: #6c757d;
      color: white;
    }

    /* Statistics Cards */
    .stat-card {
      background: white;
      border-radius: 15px;
      padding: 1.5rem;
      text-align: center;
      box-shadow: var(--card-shadow);
      border: none;
      transition: all 0.3s ease;
    }

    .stat-card:hover {
      transform: translateY(-3px);
      box-shadow: var(--hover-shadow);
    }

    .stat-icon {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 1rem;
      font-size: 1.5rem;
      color: white;
    }

    .stat-number {
      font-size: 2rem;
      font-weight: 700;
      color: #2c3e50;
    }

    .stat-label {
      color: #6c757d;
      font-weight: 500;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .profile-name {
        font-size: 1.5rem;
      }

      .profile-avatar {
        width: 80px;
        height: 80px;
        font-size: 2rem;
      }

      .info-label {
        min-width: 100px;
        font-size: 0.9rem;
      }
    }
  </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
  <div class="container">
    <a class="navbar-brand" href="customer-home">
      <i class="bi bi-shop me-2"></i>Gian Hàng
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="customer-home">
            <i class="bi bi-house me-1"></i>Trang chủ
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="customer-profile">
            <i class="bi bi-person-circle me-1"></i>Hồ sơ
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="customer-logout">
            <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Profile Header -->
<section class="profile-header">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-md-3 text-center">
        <div class="profile-avatar">
          <i class="bi bi-person-fill"></i>
        </div>
      </div>
      <div class="col-md-9 text-center text-md-start">
        <h1 class="profile-name">
          <c:choose>
            <c:when test="${not empty sessionScope.customer.name}">
              ${sessionScope.customer.name}
            </c:when>
            <c:otherwise>
              Khách hàng
            </c:otherwise>
          </c:choose>
        </h1>
        <div class="profile-info">
          <p class="mb-2">
            <i class="bi bi-telephone me-2"></i>
            ${sessionScope.customer.phone}
          </p>
          <div class="d-flex justify-content-center justify-content-md-start align-items-center flex-wrap">
                            <span class="points-badge me-3">
                                <i class="bi bi-star-fill"></i>
                                ${sessionScope.customer.point} điểm
                            </span>
            <span class="type-badge type-${sessionScope.customer.type_id == 1 ? 'standard' : sessionScope.customer.type_id == 2 ? 'silver' : sessionScope.customer.type_id == 3 ? 'gold' : 'platinum'}">
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
  </div>
</section>

<!-- Main Content -->
<div class="container">
  <div class="row">
    <!-- Profile Information -->
    <div class="col-lg-8">
      <div class="card info-card">
        <div class="card-header card-header-custom">
          <h3 class="card-title-custom">
            <i class="bi bi-person-lines-fill"></i>
            Thông tin cá nhân
          </h3>
        </div>
        <div class="card-body p-4">
          <div class="info-item">
            <div class="info-label">
              <i class="bi bi-hash"></i>
              ID:
            </div>
            <div class="info-value">${sessionScope.customer.id}</div>
          </div>
          <div class="info-item">
            <div class="info-label">
              <i class="bi bi-person"></i>
              Họ tên:
            </div>
            <div class="info-value">
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
          <div class="info-item">
            <div class="info-label">
              <i class="bi bi-telephone"></i>
              Số điện thoại:
            </div>
            <div class="info-value">${sessionScope.customer.phone}</div>
          </div>
          <div class="info-item">
            <div class="info-label">
              <i class="bi bi-star"></i>
              Điểm tích lũy:
            </div>
            <div class="info-value">
                                <span class="points-badge">
                                    <i class="bi bi-star-fill"></i>
                                    ${sessionScope.customer.point} điểm
                                </span>
            </div>
          </div>
          <div class="info-item">
            <div class="info-label">
              <i class="bi bi-award"></i>
              Loại thành viên:
            </div>
            <div class="info-value">
                                <span class="type-badge type-${sessionScope.customer.type_id == 1 ? 'standard' : sessionScope.customer.type_id == 2 ? 'silver' : sessionScope.customer.type_id == 3 ? 'gold' : 'platinum'}">
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
        <div class="card-footer bg-transparent p-4">
          <div class="text-center">
            <button type="button" class="btn btn-action btn-primary-custom" data-bs-toggle="modal" data-bs-target="#editProfileModal">
              <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa thông tin
            </button>
            <a href="customer-home" class="btn btn-action btn-secondary-custom">
              <i class="bi bi-arrow-left me-2"></i>Quay lại trang chủ
            </a>
          </div>
        </div>
      </div>
    </div>

    <!-- Statistics -->
    <div class="col-lg-4">
      <div class="row g-3">
        <div class="col-12">
          <div class="card stat-card">
            <div class="stat-icon" style="background: linear-gradient(45deg, #28a745, #20c997);">
              <i class="bi bi-star-fill"></i>
            </div>
            <div class="stat-number">${sessionScope.customer.point}</div>
            <div class="stat-label">Điểm tích lũy</div>
          </div>
        </div>
        <div class="col-12">
          <div class="card stat-card">
            <div class="stat-icon" style="background: linear-gradient(45deg, #667eea, #764ba2);">
              <i class="bi bi-bag-check"></i>
            </div>
            <div class="stat-number">0</div>
            <div class="stat-label">Đơn hàng</div>
          </div>
        </div>
        <div class="col-12">
          <div class="card stat-card">
            <div class="stat-icon" style="background: linear-gradient(45deg, #f093fb, #f5576c);">
              <i class="bi bi-heart-fill"></i>
            </div>
            <div class="stat-number">0</div>
            <div class="stat-label">Yêu thích</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Edit Profile Modal -->
<div class="modal fade" id="editProfileModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="border-radius: 15px; border: none;">
      <div class="modal-header" style="background: var(--primary-gradient); color: white; border-radius: 15px 15px 0 0;">
        <h5 class="modal-title">
          <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa thông tin
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <form action="edit-profile" method="post">
        <div class="modal-body p-4">
          <div class="mb-3">
            <label for="customerName" class="form-label fw-semibold">
              <i class="bi bi-person me-2"></i>Họ và tên
            </label>
            <input type="text"
                   class="form-control"
                   id="customerName"
                   name="name"
                   value="${sessionScope.customer.name}"
                   placeholder="Nhập họ và tên của bạn">
          </div>
          <div class="mb-3">
            <label for="customerPhone" class="form-label fw-semibold">
              <i class="bi bi-telephone me-2"></i>Số điện thoại
            </label>
            <input type="tel"
                   class="form-control"
                   id="customerPhone"
                   name="phone"
                   value="${sessionScope.customer.phone}"
                   readonly
                   style="background-color: #f8f9fa;">
            <div class="form-text">
              <i class="bi bi-info-circle me-1"></i>
              Số điện thoại không thể thay đổi
            </div>
          </div>
          <input type="hidden" name="id" value="${sessionScope.customer.id}">
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
          <button type="submit" class="btn btn-primary-custom">
            <i class="bi bi-check-lg me-2"></i>Lưu thay đổi
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
  document.addEventListener('DOMContentLoaded', function() {
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
      editForm.addEventListener('submit', function(e) {
        const nameInput = this.querySelector('input[name="name"]');
        if (!nameInput.value.trim()) {
          e.preventDefault();
          nameInput.focus();
          nameInput.classList.add('is-invalid');

          // Remove invalid class after input
          nameInput.addEventListener('input', function() {
            this.classList.remove('is-invalid');
          }, { once: true });
        }
      });
    }
  });
</script>
</body>
</html>