<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/22/2025
  Time: 8:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập khách hàng</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }
        .phone-icon {
            color: #667eea;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5 col-xl-4">
            <div class="card login-card border-0">
                <div class="card-body p-5">
                    <!-- Header with icon -->
                    <div class="text-center mb-4">
                        <div class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                            <i class="bi bi-phone phone-icon" style="font-size: 2rem;"></i>
                        </div>
                        <h2 class="card-title mt-3 mb-1 fw-bold text-dark">Đăng nhập</h2>
                        <p class="text-muted">Nhập số điện thoại để nhận mã OTP</p>
                    </div>

                    <!-- Login Form -->
                    <form action="send-otp" method="post">
                        <div class="mb-4">
                            <label for="phone" class="form-label fw-semibold text-dark">
                                <i class="bi bi-telephone me-2"></i>Số điện thoại
                            </label>
                            <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i class="bi bi-phone text-muted"></i>
                                    </span>
                                <input type="tel"
                                       class="form-control border-start-0 ps-0"
                                       name="phone"
                                       id="phone"
                                       placeholder="Nhập số điện thoại của bạn"
                                       pattern="[0-9]{10,11}"
                                       title="Vui lòng nhập số điện thoại hợp lệ (10-11 chữ số)"
                                       required>
                            </div>
                            <div class="form-text">
                                <i class="bi bi-info-circle me-1"></i>
                                Ví dụ: 0912345678 hoặc 84912345678
                            </div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="bi bi-send me-2"></i>Gửi mã OTP
                            </button>
                        </div>
                    </form>

                    <!-- Additional Info -->
                    <div class="text-center mt-4">
                        <small class="text-muted">
                            <i class="bi bi-shield-check me-1"></i>
                            Thông tin của bạn được bảo mật tuyệt đối
                        </small>
                    </div>

                    <!-- Help Section -->
                    <div class="text-center mt-3">
                        <small class="text-muted">
                            Gặp vấn đề?
                            <a href="#" class="text-decoration-none">Liên hệ hỗ trợ</a>
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<!-- Form Validation Script -->
<script>
    // Bootstrap form validation
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            var forms = document.getElementsByClassName('needs-validation');
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();

    // Phone number formatting
    document.getElementById('phone').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        e.target.value = value;
    });
</script>
</body>
</html>