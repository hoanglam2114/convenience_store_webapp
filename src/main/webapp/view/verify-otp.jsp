<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/22/2025
  Time: 8:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Xác minh OTP</title>
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

    .otp-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .otp-inputs {
      display: flex;
      gap: 10px;
      justify-content: center;
      margin: 2rem 0;
    }

    .otp-input {
      width: 50px;
      height: 50px;
      text-align: center;
      font-size: 1.5rem;
      font-weight: bold;
      border: 2px solid #e9ecef;
      border-radius: 10px;
      background: white;
      transition: all 0.3s ease;
    }

    .otp-input:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
      outline: none;
    }

    .otp-input.filled {
      border-color: #28a745;
      background-color: #f8fff9;
    }

    .btn-verify {
      background: linear-gradient(45deg, #667eea, #764ba2);
      border: none;
      border-radius: 25px;
      padding: 12px 30px;
      font-weight: 600;
      color: white;
      transition: all 0.3s ease;
      width: 100%;
    }

    .btn-verify:hover:not(:disabled) {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
      color: white;
    }

    .btn-verify:disabled {
      opacity: 0.6;
      cursor: not-allowed;
    }

    .btn-resend {
      background: transparent;
      border: 2px solid #667eea;
      color: #667eea;
      border-radius: 25px;
      padding: 10px 25px;
      font-weight: 600;
      transition: all 0.3s ease;
      width: 100%;
    }

    .btn-resend:hover:not(:disabled) {
      background: #667eea;
      color: white;
    }

    .btn-resend:disabled {
      opacity: 0.5;
      cursor: not-allowed;
    }

    .security-icon {
      color: #667eea;
    }

    .timer {
      font-weight: bold;
      color: #e74c3c;
    }

    .timer.expired {
      color: #dc3545;
    }

    .success-animation {
      animation: bounce 0.6s ease-in-out;
    }

    @keyframes bounce {
      0%, 20%, 50%, 80%, 100% {
        transform: translateY(0);
      }
      40% {
        transform: translateY(-10px);
      }
      60% {
        transform: translateY(-5px);
      }
    }

    .error-shake {
      animation: shake 0.5s ease-in-out;
    }

    @keyframes shake {
      0%, 100% { transform: translateX(0); }
      25% { transform: translateX(-5px); }
      75% { transform: translateX(5px); }
    }

    @media (max-width: 576px) {
      .otp-inputs {
        gap: 8px;
      }

      .otp-input {
        width: 45px;
        height: 45px;
        font-size: 1.3rem;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6 col-lg-5 col-xl-4">
      <div class="card otp-card border-0">
        <div class="card-body p-5">
          <!-- Header with icon -->
          <div class="text-center mb-4">
            <div class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
              <i class="bi bi-shield-lock security-icon" style="font-size: 2rem;"></i>
            </div>
            <h2 class="card-title mt-3 mb-1 fw-bold text-dark">Xác minh OTP</h2>
            <p class="text-muted">Nhập mã 6 chữ số đã được gửi đến điện thoại của bạn</p>
          </div>

          <!-- Phone number display (if available from session) -->
          <div class="text-center mb-4">
            <small class="text-muted">
              <i class="bi bi-phone me-1"></i>
              Mã đã được gửi đến: <strong>***-***-**78</strong>
            </small>
          </div>

          <!-- OTP Form -->
          <form action="verify-otp" method="post" id="otpForm">
            <!-- Custom OTP Input Grid -->
            <div class="otp-inputs">
              <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
              <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
              <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
              <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
              <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
              <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
            </div>

            <!-- Hidden input for actual form submission -->
            <input type="hidden" name="otp" id="otpValue">

            <!-- Timer display -->
            <div class="text-center mb-4">
              <small class="text-muted">
                Mã sẽ hết hạn sau: <span class="timer" id="timer">05:00</span>
              </small>
            </div>

            <!-- Submit button -->
            <div class="d-grid mb-3">
              <button type="submit" class="btn btn-verify" id="verifyBtn" disabled>
                <i class="bi bi-check-circle me-2"></i>Xác minh OTP
              </button>
            </div>

            <!-- Resend button -->
            <div class="d-grid">
              <button type="button" class="btn btn-resend" id="resendBtn" disabled>
                <i class="bi bi-arrow-clockwise me-2"></i>Gửi lại mã OTP
              </button>
            </div>
          </form>

          <!-- Help Section -->
          <div class="text-center mt-4">
            <small class="text-muted">
              <i class="bi bi-info-circle me-1"></i>
              Không nhận được mã? Kiểm tra tin nhắn rác hoặc thử gửi lại
            </small>
          </div>

          <!-- Security notice -->
          <div class="text-center mt-3">
            <small class="text-muted">
              <i class="bi bi-shield-check me-1"></i>
              Không chia sẻ mã OTP với bất kỳ ai
            </small>
          </div>

          <!-- Back to login link -->
          <div class="text-center mt-3">
            <small class="text-muted">
              <a href="customer-login" class="text-decoration-none">
                <i class="bi bi-arrow-left me-1"></i>Quay lại đăng nhập
              </a>
            </small>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const otpInputs = document.querySelectorAll('.otp-input');
    const otpValue = document.getElementById('otpValue');
    const verifyBtn = document.getElementById('verifyBtn');
    const resendBtn = document.getElementById('resendBtn');
    const timerElement = document.getElementById('timer');
    const form = document.getElementById('otpForm');

    let timeLeft = 300;
    let timerInterval;

    function updateTimerDisplay() {
      const minutes = Math.floor(timeLeft / 60).toString().padStart(2, '0');
      const seconds = (timeLeft % 60).toString().padStart(2, '0');
      timerElement.textContent = minutes + ':' + seconds;
    }

    // Start countdown timer
    function startTimer() {
      // Clear any existing timer first
      if (timerInterval) {
        clearInterval(timerInterval);
      }

      updateTimerDisplay(); // Show initial time

      timerInterval = setInterval(() => {
        timeLeft--;

        if (timeLeft <= 0) {
          clearInterval(timerInterval);
          timerElement.textContent = 'Hết hạn';
          timerElement.classList.add('expired');

          // Disable verify button when timer expires
          verifyBtn.disabled = true;

          // Enable resend button when timer expires
          resendBtn.disabled = false;

          // Disable all OTP inputs
          otpInputs.forEach(input => {
            input.disabled = true;
            input.style.opacity = '0.5';
          });

          return;
        }

        updateTimerDisplay();
      }, 1000);
    }

    // Initialize timer
    startTimer();

    // OTP input handling
    otpInputs.forEach((input, index) => {
      input.addEventListener('input', function(e) {
        // Only allow numbers
        this.value = this.value.replace(/[^0-9]/g, '');

        if (this.value) {
          this.classList.add('filled');
          // Move to next input
          if (index < otpInputs.length - 1) {
            otpInputs[index + 1].focus();
          }
        } else {
          this.classList.remove('filled');
        }

        updateOTPValue();
      });

      input.addEventListener('keydown', function(e) {
        // Handle backspace
        if (e.key === 'Backspace' && !this.value && index > 0) {
          otpInputs[index - 1].focus();
          otpInputs[index - 1].value = '';
          otpInputs[index - 1].classList.remove('filled');
          updateOTPValue();
        }

        // Handle arrow keys
        if (e.key === 'ArrowLeft' && index > 0) {
          otpInputs[index - 1].focus();
        } else if (e.key === 'ArrowRight' && index < otpInputs.length - 1) {
          otpInputs[index + 1].focus();
        }
      });

      // Handle paste
      input.addEventListener('paste', function(e) {
        e.preventDefault();
        const pastedData = e.clipboardData.getData('text').replace(/[^0-9]/g, '');

        if (pastedData.length === 6) {
          otpInputs.forEach((inp, idx) => {
            if (idx < pastedData.length) {
              inp.value = pastedData[idx];
              inp.classList.add('filled');
            }
          });
          updateOTPValue();
        }
      });
    });

    function updateOTPValue() {
      const otp = Array.from(otpInputs).map(input => input.value).join('');
      otpValue.value = otp;
      verifyBtn.disabled = otp.length !== 6 || timeLeft <= 0;

      // Add success animation when complete
      if (otp.length === 6) {
        otpInputs.forEach(input => {
          input.classList.add('success-animation');
          setTimeout(() => input.classList.remove('success-animation'), 600);
        });
      }
    }

    // Form submission
    form.addEventListener('submit', function(e) {
      const otp = otpValue.value;
      if (otp.length !== 6) {
        e.preventDefault();
        showError('Vui lòng nhập đầy đủ 6 chữ số');
        return;
      }

      if (timeLeft <= 0) {
        e.preventDefault();
        showError('Mã OTP đã hết hạn');
        return;
      }

      // Show loading state
      verifyBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang xác minh...';
      verifyBtn.disabled = true;
    });

    // Resend OTP
    resendBtn.addEventListener('click', function() {
      // Reset timer
      clearInterval(timerInterval);
      timeLeft = 300;
      timerElement.classList.remove('expired');

      // Reset form
      otpInputs.forEach(input => {
        input.value = '';
        input.classList.remove('filled');
        input.disabled = false;
        input.style.opacity = '1';
      });

      otpValue.value = '';
      verifyBtn.disabled = true;
      resendBtn.disabled = true;

      // Show loading state for resend button
      const originalContent = this.innerHTML;
      this.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang gửi...';

      // Simulate API call
      setTimeout(() => {
        this.innerHTML = '<i class="bi bi-check-circle me-2"></i>Đã gửi mã mới!';

        // Start new timer
        startTimer();

        setTimeout(() => {
          this.innerHTML = originalContent;
        }, 2000);
      }, 1500);

      // Focus first input
      otpInputs[0].focus();
    });

    function showError(message) {
      // Add shake animation to inputs
      otpInputs.forEach(input => {
        input.classList.add('error-shake');
        input.style.borderColor = '#dc3545';
        setTimeout(() => {
          input.classList.remove('error-shake');
          input.style.borderColor = '';
        }, 500);
      });

      // You could also show a toast or alert here
      console.log('Error:', message);
      alert(message); // Simple alert for now
    }

    // Auto-focus first input
    otpInputs[0].focus();
  });
</script>
</body>
</html>