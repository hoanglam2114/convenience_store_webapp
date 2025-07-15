<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 6/22/2025
  Time: 5:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<head>
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>Edit Warehouse</title>

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
        .form-control.is-invalid {
            border-color: #dc3545;
        }

        .form-control.is-valid {
            border-color: #198754;
        }

        .invalid-feedback {
            display: block;
        }

        .valid-feedback {
            display: block;
        }

        .error-icon {
            color: #dc3545;
        }

        .success-icon {
            color: #198754;
        }

        .container {
            max-width: 600px;
            margin-top: 2rem;
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
                    <div class="row justify-content-center">
                        <div class="col-md-8 col-lg-6">
                            <div class="card shadow">
                                <div class="card-header bg-primary text-white">
                                    <h4 class="mb-0"><i class="fas fa-warehouse me-2"></i>Update Warehouse</h4>
                                </div>
                                <div class="card-body">
                                    <form action="edit-warehouse" method="post">
                                        <input type="hidden" name="warehouse_id" value="${warehouse.warehouseID}"/>

                                        <!-- Warehouse Name -->
                                        <div class="mb-3">
                                            <label for="name" class="form-label">
                                                Tên Nhà Kho <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" class="form-control" id="name" name="name" required
                                                   value="${warehouse.name}" minlength="2" maxlength="100">
                                            <div class="invalid-feedback"></div>
                                        </div>

                                        <!-- Address -->
                                        <div class="mb-3">
                                            <label for="address" class="form-label">
                                                Địa Chỉ <span class="text-danger">*</span>
                                            </label>
                                            <textarea class="form-control" id="address" name="address" rows="3"
                                                      required minlength="10"
                                                      maxlength="500">${warehouse.address}</textarea>
                                            <div class="invalid-feedback"></div>
                                        </div>

                                        <!-- Phone -->
                                        <div class="mb-3">
                                            <label for="phone" class="form-label">
                                                SDT Liên Hệ <span class="text-danger">*</span>
                                            </label>
                                            <input type="tel" class="form-control" id="phone" name="phone" required
                                                   value="${warehouse.phone}">
                                            <div class="invalid-feedback"></div>
                                        </div>

                                        <!-- Working Hours -->
                                        <div class="mb-3">
                                            <label for="workingHours" class="form-label">Giờ Hoạt Động</label>
                                            <div class="row g-2">
                                                <div class="col-md-5">
                                                    <label for="startTime" class="form-label small">Từ</label>
                                                    <input type="time" class="form-control" id="startTime"
                                                           name="startTime">
                                                    <div class="invalid-feedback"></div>
                                                </div>
                                                <div class="col-md-5">
                                                    <label for="endTime" class="form-label small">Đến</label>
                                                    <input type="time" class="form-control" id="endTime" name="endTime">
                                                    <div class="invalid-feedback"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Status -->
                                        <div class="mb-3">
                                            <label for="status" class="form-label">Trạng Thái</label>
                                            <select name="status" id="status" class="form-select" required>
                                                <option value="ACTIVE" ${warehouse.status == 'ACTIVE' ? 'selected' : ''}>
                                                    Đang hoạt động
                                                </option>
                                                <option value="MAINTENANCE" ${warehouse.status == 'MAINTENANCE' ? 'selected' : ''}>
                                                    Bảo trì
                                                </option>
                                                <option value="CLOSED" ${warehouse.status == 'CLOSED' ? 'selected' : ''}>
                                                    Đóng cửa
                                                </option>
                                            </select>

                                        </div>
                                        <!-- Store Linked ID -->
                                        <div class="mb-3">
                                            <label for="shop_link" class="form-label">Trạng Thái</label>
                                            <select name="storeLinkedID" id="shop_link" class="form-select">
                                                <option value="">-- Chọn cửa hàng --</option>
                                                <c:forEach var="shop" items="${shopList}">
                                                    <option value="${shop.shopId}" ${shop.shopId == warehouse.storeLinkedID ? 'selected' : ''}>
                                                            ${shop.shopName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <!-- Note -->
                                        <div class="mb-3">
                                            <label for="note" class="form-label">Ghi chú</label>
                                            <textarea class="form-control" id="note" name="note" rows="3"
                                                      maxlength="1000">
                                                ${warehouse.note}</textarea>
                                            <div class="invalid-feedback"></div>
                                            <div class="form-text">
                                                <span id="noteCounter">0</span>/1000 ký tự.
                                            </div>
                                        </div>

                                        <!-- Submit Button -->
                                        <div class="d-grid gap-2">
                                            <button type="submit" class="btn btn-primary btn-lg" id="submitBtn">
                                                <i class="fas fa-plus me-2"></i>Đồng ý
                                            </button>
                                            <a href="list-warehouse" class="btn btn-secondary">Quay lại danh sách</a>
                                        </div>
                                    </form>
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
                            �
                            <script>
                                document.write(new Date().getFullYear());
                            </script>
                            , made with ?? by
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
    class WarehouseFormValidator {
        constructor() {
            this.form = document.getElementById('warehouseForm');
            this.fields = {
                name: document.getElementById('name'),
                address: document.getElementById('address'),
                phone: document.getElementById('phone'),
                startTime: document.getElementById('startTime'),
                endTime: document.getElementById('endTime'),
                storeLinkedID: document.getElementById('storeLinkedID'),
                note: document.getElementById('note')
            };
            this.submitBtn = document.getElementById('submitBtn');
            this.resetBtn = document.getElementById('resetBtn');
            this.noteCounter = document.getElementById('noteCounter');

            this.init();
        }

        init() {
// Add event listeners for real-time validation
            Object.keys(this.fields).forEach(fieldName => {
                const field = this.fields[fieldName];
                field.addEventListener('blur', () => this.validateField(fieldName));
                field.addEventListener('input', () => this.validateField(fieldName));
            });

// Special handling for note character counter
            this.fields.note.addEventListener('input', () => this.updateNoteCounter());

// Form submission handler
            this.form.addEventListener('submit', (e) => this.handleSubmit(e));

// Reset button handler
            this.resetBtn.addEventListener('click', () => this.resetForm());
        }

        validateField(fieldName) {
            const field = this.fields[fieldName];
            const value = field.value.trim();
            let isValid = true;
            let errorMessage = '';

// Reset classes
            field.classList.remove('is-valid', 'is-invalid');

            switch (fieldName) {
                case 'name':
                    if (!value) {
                        isValid = false;
                        errorMessage = 'Tên kho hàng là bắt buộc.';
                    } else if (value.length < 2) {
                        isValid = false;
                        errorMessage = 'Tên kho hàng phải có ít nhất 2 ký tự.';
                    } else if (value.length > 100) {
                        isValid = false;
                        errorMessage = 'Tên kho hàng không được vượt quá 100 ký tự.';
                    } else if (!/^[a-zA-Z0-9\s\-\.àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ]*$/.test(value)) {
                        isValid = false;
                        errorMessage = 'Tên kho hàng chứa ký tự không hợp lệ.';
                    }
                    break;

                case 'address':
                    if (!value) {
                        isValid = false;
                        errorMessage = 'Địa chỉ là bắt buộc.';
                    } else if (value.length < 10) {
                        isValid = false;
                        errorMessage = 'Vui lòng cung cấp địa chỉ đầy đủ (ít nhất 10 ký tự).';
                    } else if (value.length > 500) {
                        isValid = false;
                        errorMessage = 'Địa chỉ không được vượt quá 500 ký tự.';
                    }
                    break;

                case 'phone':
                    if (!value) {
                        isValid = false;
                        errorMessage = 'Số điện thoại là bắt buộc.';
                    } else if (!this.isValidPhone(value)) {
                        isValid = false;
                        errorMessage = 'Vui lòng nhập số điện thoại hợp lệ (ví dụ: +84-123-456-7890 hoặc 01234567890).';
                    }
                    break;

                case 'startTime':
                    if (value && !this.isValidTime(value)) {
                        isValid = false;
                        errorMessage = 'Vui lòng chọn thời gian bắt đầu hợp lệ.';
                    }
                    if (value && this.fields.endTime.value) {
                        if (!this.isValidTimeRange(value, this.fields.endTime.value)) {
                            isValid = false;
                            errorMessage = 'Thời gian bắt đầu phải trước thời gian kết thúc.';
                        }
                    }
                    break;

                case 'endTime':
                    if (value && !this.isValidTime(value)) {
                        isValid = false;
                        errorMessage = 'Vui lòng chọn thời gian kết thúc hợp lệ.';
                    }
                    if (value && this.fields.startTime.value) {
                        if (!this.isValidTimeRange(this.fields.startTime.value, value)) {
                            isValid = false;
                            errorMessage = 'Thời gian kết thúc phải sau thời gian bắt đầu.';
                        }
                    }
                    break;

                case 'storeLinkedID':
                    if (value) {
                        const id = parseInt(value);
                        if (isNaN(id) || id < 1 || id > 999999) {
                            isValid = false;
                            errorMessage = 'ID cửa hàng phải là số từ 1 đến 999999.';
                        }
                    }
                    break;

                case 'note':
                    if (value.length > 1000) {
                        isValid = false;
                        errorMessage = 'Ghi chú không được vượt quá 1000 ký tự.';
                    }
                    break;
            }

            if (isValid && (field.hasAttribute('required') || value)) {
                field.classList.add('is-valid');
                if (fieldName === 'startTime' || fieldName === 'endTime') {
                    const parentDiv = field.closest('.mb-3');
                    const validFeedback = parentDiv.querySelector('.valid-feedback');
                    if (this.fields.startTime.value && this.fields.endTime.value &&
                        this.fields.startTime.classList.contains('is-valid') &&
                        this.fields.endTime.classList.contains('is-valid')) {
                        validFeedback.style.display = 'block';
                    }
                }
            } else if (!isValid) {
                field.classList.add('is-invalid');
                const feedback = field.parentNode.querySelector('.invalid-feedback');
                if (feedback) {
                    feedback.textContent = errorMessage;
                }
                if (fieldName === 'startTime' || fieldName === 'endTime') {
                    const parentDiv = field.closest('.mb-3');
                    const validFeedback = parentDiv.querySelector('.valid-feedback');
                    validFeedback.style.display = 'none';
                }
            } else {
                if (fieldName === 'startTime' || fieldName === 'endTime') {
                    const parentDiv = field.closest('.mb-3');
                    const validFeedback = parentDiv.querySelector('.valid-feedback');
                    validFeedback.style.display = 'none';
                }
            }

            return isValid;
        }

        isValidPhone(phone) {
            const cleaned = phone.replace(/\D/g, '');
            if (cleaned.length < 10 || cleaned.length > 15) {
                return false;
            }
            const patterns = [
                /^\+?84?[-.\s]?\(?[0-9]{3}\)?[-.\s]?[0-9]{3}[-.\s]?[0-9]{4}$/, // Việt Nam format
                /^\+?[1-9]\d{1,14}$/, // International format
                /^[0-9]{10,15}$/ // Simple digit format
            ];
            return patterns.some(pattern => pattern.test(phone));
        }

        isValidWorkingHours(hours) {
            const patterns = [
                /^\d{1,2}:\d{2}\s?(AM|PM)\s?-\s?\d{1,2}:\d{2}\s?(AM|PM)$/i,
                /^\d{1,2}:\d{2}\s?-\s?\d{1,2}:\d{2}$/,
                /^\d{1,2}(AM|PM)\s?-\s?\d{1,2}(AM|PM)$/i,
                /^24\/7$|^24 hours$/i,
                /^closed$/i
            ];
            return patterns.some(pattern => pattern.test(hours.trim()));
        }

        isValidTime(time) {
            const timeRegex = /^([01]?[0-9]|2[0-3]):[0-5][0-9]$/;
            return timeRegex.test(time);
        }

        isValidTimeRange(startTime, endTime) {
            if (!startTime || !endTime) return true;
            const startMinutes = this.timeToMinutes(startTime);
            const endMinutes = this.timeToMinutes(endTime);
            return startMinutes < endMinutes;
        }

        timeToMinutes(time) {
            const [hours, minutes] = time.split(':').map(Number);
            return hours * 60 + minutes;
        }

        updateNoteCounter() {
            const noteLength = this.fields.note.value.length;
            this.noteCounter.textContent = noteLength;
            if (noteLength > 900) {
                this.noteCounter.style.color = '#dc3545';
            } else if (noteLength > 800) {
                this.noteCounter.style.color = '#fd7e14';
            } else {
                this.noteCounter.style.color = '#6c757d';
            }
        }

        validateForm() {
            let isFormValid = true;
            Object.keys(this.fields).forEach(fieldName => {
                const fieldValid = this.validateField(fieldName);
                if (!fieldValid) {
                    isFormValid = false;
                }
            });
            return isFormValid;
        }

        handleSubmit(e) {
            if (!this.validateForm()) {
                e.preventDefault();
                e.stopPropagation();
                this.showAlert('Vui lòng sửa các lỗi trong biểu mẫu trước khi gửi.', 'danger');
                const firstInvalidField = this.form.querySelector('.is-invalid');
                if (firstInvalidField) {
                    firstInvalidField.focus();
                }
            } else {

                this.showAlert('Biểu mẫu hợp lệ và sẵn sàng gửi!', 'success');
                e.preventDefault(); // Ngăn submit để demo
            }
        }

        resetForm() {
            Object.values(this.fields).forEach(field => {
                field.classList.remove('is-valid', 'is-invalid');
            });
            this.noteCounter.textContent = '0';
            this.noteCounter.style.color = '#6c757d';
            const existingAlert = document.querySelector('.alert');
            if (existingAlert) {
                existingAlert.remove();
            }
        }

        showAlert(message, type) {
            const existingAlert = document.querySelector('.alert');
            if (existingAlert) {
                existingAlert.remove();
            }
            const alert = document.createElement('div');
            alert.className = `alert alert-${type} alert-dismissible fade show`;
            alert.innerHTML = `
<i class="fas fa-${type eq 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
${message}
<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
`;
            this.form.parentNode.insertBefore(alert, this.form);
            setTimeout(() => {
                if (alert.parentNode) {
                    alert.remove();
                }
            }, 5000);
        }
    }

    document.addEventListener('DOMContentLoaded', () => {
        new WarehouseFormValidator();
    });
</script>
<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>