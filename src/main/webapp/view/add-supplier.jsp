<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/8/2025
  Time: 7:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/8/2025
  Time: 7:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

  <title>Add Supplier</title>

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

  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

  <!-- Page CSS -->
  <style>
    .enhanced-card {
      border: none;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      border-radius: 12px;
      transition: all 0.3s ease;
    }

    .enhanced-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
    }

    .table-enhanced thead th {
      background: linear-gradient(135deg, #495057 0%, #6c757d 100%);
      color: white !important;
      font-weight: 600;
      border: none;
      padding: 1rem 0.75rem;
    }

    .table-enhanced tbody tr {
      transition: all 0.2s ease;
    }

    .table-enhanced tbody tr:hover {
      background-color: #f8f9fa;
    }
    .error {
      border-color: #dc3545 !important;
      box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25) !important;
    }
    .valid {
      border-color: #28a745 !important;
      box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25) !important;
    }
    .help-block {
      color: #dc3545;
      font-size: 0.875rem;
      margin-top: 0.25rem;
      min-height: 1.2rem;
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

    <!-- Layout Page -->
    <div class="layout-page">
      <!-- Navbar -->
      <%@ include file="/common/nav-bar.jsp" %>

      <!-- Content Wrapper -->
      <div class="content-wrapper">
        <div class="container-xxl flex-grow-1 container-p-y">

          <div class="modal fade" id="new-order" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
              <div class="modal-content">
                <div class="modal-body">
                  <div class="popup text-left">
                    <h4 class="mb-3">New Order</h4>
                    <div class="content create-workform bg-body">
                      <div class="pb-3">
                        <label class="mb-2">Email</label>
                        <input type="text" class="form-control" placeholder="Enter Name or Email">
                      </div>
                      <div class="col-lg-12 mt-4">
                        <div class="d-flex flex-wrap align-items-ceter justify-content-center">
                          <div class="btn btn-primary mr-4" data-dismiss="modal">Cancel</div>
                          <div class="btn btn-outline-primary" data-dismiss="modal">Create</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Main Content -->
          <div class="content-page">
            <div class="container-fluid add-form-list">
              <div class="row">
                <div class="col-sm-12">
                  <div class="card">
                    <div class="card-header d-flex justify-content-between">
                      <div class="header-title">
                        <h4 class="card-title">Thêm nhà cung cấp</h4>
                      </div>
                      <a href="list-supplier" class="btn btn-primary add-list"><i class="las la-plus mr-3"></i>Trở
                        về danh sách nhà cung cấp</a>
                    </div>
                    <div class="card-body">
                      <form action="add-supplier" method="post" data-toggle="validator"
                            enctype="multipart/form-data">
                        <div class="row">
                          <div class="col-md-6">
                            <div class="form-group">
                              <label>Tên nhà cung cấp</label>
                              <input type="text" name="nameSup" class="form-control"
                                     placeholder="Nhập tên nhà cung cấp" required>
                              <div class="help-block with-errors"></div>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <div class="form-group">
                              <label>Email *</label>
                              <input type="text" name="emailSup" class="form-control"
                                     placeholder="Nhập email nhà cung cấp" required>
                              <div class="help-block with-errors"></div>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <div class="form-group">
                              <label>Số điện thoại *</label>
                              <input type="number" name="phoneSup" class="form-control"
                                     placeholder="Nhập số điện thoại nhà cung cấp" required>
                              <div class="help-block with-errors"></div>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <div class="form-group">
                              <label>Người đại diện</label>
                              <input type="text" name="personSup" class="form-control"
                                     placeholder="Nhập tên người đại diện" required>
                              <div class="help-block with-errors"></div>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-group">
                              <label>Địa chỉ</label>
                              <textarea name="addressSup" class="form-control" rows="4"></textarea>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-group">
                              <label>Hình ảnh</label>
                              <input type="file" class="form-control image-file" name="imgSup"
                                     accept="image/*">
                            </div>
                          </div>
                        </div>
                        <button type="submit" class="btn btn-primary mr-2">Thêm nhà cung cấp mới</button>
                        <button type="reset" class="btn btn-danger">Làm mới</button>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
              <!-- Page end  -->
            </div>
          </div>

          <!-- Modal Edit -->
          <div class="modal fade" id="edit-note" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
              <div class="modal-content enhanced-card">
                <div class="modal-body">
                  <div class="popup text-left">
                    <div class="media align-items-top justify-content-between mb-4">
                      <h3 class="mb-3">
                        <i class="bi bi-pencil-square me-2 text-primary"></i>Product
                      </h3>
                      <div class="btn-cancel p-0" data-dismiss="modal">
                        <i class="las la-times"></i>
                      </div>
                    </div>
                    <div class="content edit-notes">
                      <div class="card card-transparent card-block card-stretch event-note mb-0">
                        <div class="card-body px-0 bukmark">
                          <div class="d-flex align-items-center justify-content-between pb-2 mb-3 border-bottom">
                            <div class="quill-tool">
                            </div>
                          </div>
                          <div id="quill-toolbar1">
                            <p>Virtual Digital Marketing Course every week on Monday,
                              Wednesday and
                              Saturday.Virtual Digital Marketing Course every week on
                              Monday</p>
                          </div>
                        </div>
                        <div class="card-footer border-0">
                          <div class="d-flex flex-wrap align-items-ceter justify-content-end">
                            <div class="btn btn-primary mr-3" data-dismiss="modal">
                              Cancel
                            </div>
                            <div class="btn btn-outline-primary" data-dismiss="modal">
                              Save
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
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
<!-- Content wrapper -->
<!-- / Layout page -->

<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->
<script>
  // JavaScript validation for supplier form
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form[action="add-supplier"]');
    const nameInput = document.querySelector('input[name="nameSup"]');
    const emailInput = document.querySelector('input[name="emailSup"]');
    const phoneInput = document.querySelector('input[name="phoneSup"]');
    const personInput = document.querySelector('input[name="personSup"]');
    const addressInput = document.querySelector('textarea[name="addressSup"]');
    const imageInput = document.querySelector('input[name="imgSup"]');

    // Validation rules
    const validators = {
      name: {
        required: true,
        minLength: 2,
        maxLength: 100,
        pattern: /^[a-zA-ZÀ-ỹ\s]+$/
      },
      email: {
        required: true,
        pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/
      },
      phone: {
        required: true,
        pattern: /^(?:\+84|0)?(?:[3|5|7|8|9][0-9]{8}|2[0-9]{9}|(1800|1900)[0-9]{4,6}|11[0-9]|1[0-9]{2,3})$/
      },
      person: {
        required: true,
        minLength: 2,
        maxLength: 50,
        pattern: /^[a-zA-ZÀ-ỹ\s]+$/
      },
      address: {
        required: false,
        maxLength: 255
      },
      image: {
        required: false,
        types: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
        maxSize: 5 * 1024 * 1024 // 5MB
      }
    };

    // Validation functions
    function validateField(field, value, rules) {
      const errors = [];

      if (rules.required && (!value || value.trim() === '')) {
        errors.push('Trường này là bắt buộc');
      }

      if (value && value.trim() !== '') {
        if (rules.minLength && value.length < rules.minLength) {
          errors.push(`Tối thiểu ${rules.minLength} ký tự`);
        }

        if (rules.maxLength && value.length > rules.maxLength) {
          errors.push(`Tối đa ${rules.maxLength} ký tự`);
        }

        if (rules.pattern && !rules.pattern.test(value)) {
          switch (field) {
            case 'name':
              errors.push('Tên chỉ được chứa chữ cái và khoảng trắng');
              break;
            case 'email':
              errors.push('Email không hợp lệ');
              break;
            case 'phone':
              errors.push('Số điện thoại không hợp lệ (VD: 0987654321)');
              break;
            case 'person':
              errors.push('Tên người đại diện chỉ được chứa chữ cái và khoảng trắng');
              break;
          }
        }
      }

      return errors;
    }

    function validateFile(file, rules) {
      const errors = [];

      if (file) {
        if (rules.types && !rules.types.includes(file.type)) {
          errors.push('Chỉ chấp nhận file ảnh (JPG, PNG, GIF)');
        }

        if (rules.maxSize && file.size > rules.maxSize) {
          errors.push('Kích thước file không được vượt quá 5MB');
        }
      }

      return errors;
    }

    function showError(input, errors) {
      const helpBlock = input.parentNode.querySelector('.help-block');

      if (errors.length > 0) {
        input.classList.add('error');
        input.classList.remove('valid');
        helpBlock.textContent = errors[0];
      } else {
        input.classList.remove('error');
        if (input.value.trim() !== '') {
          input.classList.add('valid');
        }
        helpBlock.textContent = '';
      }
    }

    function validateInput(input, field) {
      const value = input.value;
      const rules = validators[field];
      const errors = validateField(field, value, rules);
      showError(input, errors);
      return errors.length === 0;
    }

    function validateFileInput(input, field) {
      const file = input.files[0];
      const rules = validators[field];
      const errors = validateFile(file, rules);
      showError(input, errors);
      return errors.length === 0;
    }

    // Add real-time validation
    nameInput.addEventListener('blur', () => validateInput(nameInput, 'name'));
    nameInput.addEventListener('input', () => {
      if (nameInput.classList.contains('error')) {
        validateInput(nameInput, 'name');
      }
    });

    emailInput.addEventListener('blur', () => validateInput(emailInput, 'email'));
    emailInput.addEventListener('input', () => {
      if (emailInput.classList.contains('error')) {
        validateInput(emailInput, 'email');
      }
    });

    phoneInput.addEventListener('blur', () => validateInput(phoneInput, 'phone'));
    phoneInput.addEventListener('input', () => {
      if (phoneInput.classList.contains('error')) {
        validateInput(phoneInput, 'phone');
      }
    });

    personInput.addEventListener('blur', () => validateInput(personInput, 'person'));
    personInput.addEventListener('input', () => {
      if (personInput.classList.contains('error')) {
        validateInput(personInput, 'person');
      }
    });

    addressInput.addEventListener('blur', () => validateInput(addressInput, 'address'));

    imageInput.addEventListener('change', () => validateFileInput(imageInput, 'image'));

    // Form submission validation
    form.addEventListener('submit', function(e) {
      let isValid = true;

      // Validate all fields
      const validations = [
        validateInput(nameInput, 'name'),
        validateInput(emailInput, 'email'),
        validateInput(phoneInput, 'phone'),
        validateInput(personInput, 'person'),
        validateInput(addressInput, 'address'),
        validateFileInput(imageInput, 'image')
      ];

      isValid = validations.every(result => result === true);

      if (!isValid) {
        e.preventDefault();

        // Focus on first error field
        const firstError = form.querySelector('.error');
        if (firstError) {
          firstError.focus();
          firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }

        // Show general error message
        alert('Vui lòng kiểm tra và sửa các lỗi trong form trước khi gửi.');
      }
    });

    // Reset form validation
    const resetButton = form.querySelector('button[type="reset"]');
    if (resetButton) {
      resetButton.addEventListener('click', function() {
        setTimeout(() => {
          // Clear all validation classes and messages
          const inputs = form.querySelectorAll('input, textarea');
          inputs.forEach(input => {
            input.classList.remove('error', 'valid');
          });

          const helpBlocks = form.querySelectorAll('.help-block');
          helpBlocks.forEach(block => {
            block.textContent = '';
          });
        }, 50);
      });
    }

    // Additional styling for better UX
    const style = document.createElement('style');
    style.textContent = `
        .error {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25) !important;
        }
        .valid {
            border-color: #28a745 !important;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25) !important;
        }
        .help-block {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            min-height: 1.2rem;
        }
    `;
    document.head.appendChild(style);
  });
</script>
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
<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>