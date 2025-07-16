<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Email Template Form</title>
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

        <style>
            body {
                background: #f7f7fa;
                min-height: 100vh;
            }
            .card {
                border-radius: 14px;
                box-shadow: 0 4px 24px rgba(80,51,255,0.04);
                border: none;
                background: #fff;
            }
            .form-label {
                font-weight: 600;
                color: #484865;
            }
            .form-control, .form-select {
                border-radius: 10px;
                border: 1px solid #ece7ff;
                background: #fafbfc;
                color: #2d2d39;
            }
            .form-control:focus, .form-select:focus {
                border-color: #a3b3fa;
                box-shadow: 0 0 0 0.08rem #b49bfc30;
            }
            .btn {
                border-radius: 10px !important;
                font-weight: 600;
                letter-spacing: 0.01em;
                transition: background 0.22s, box-shadow 0.16s;
            }
            .btn-primary {
                background: #6e8efb !important;
                border: none;
                color: #fff !important;
            }
            .btn-primary:hover {
                background: #5661e8 !important;
                color: #fff !important;
            }
            .btn-outline-secondary {
                color: #6e8efb;
                border-color: #a3b3fa;
                background: none;
            }
            .btn-outline-secondary:hover {
                background: #f3f0fd;
                color: #3f51b5;
            }
            .btn-danger {
                background: #f44336 !important;
                color: #fff !important;
                border: none;
            }
            .btn-danger:hover {
                background: #cf2a1c !important;
            }
            .card-title {
                color: #484865;
            }
        </style>
    </head>
    <body>
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <%@ include file="/common/site-bar.jsp" %>
                <div class="layout-page">
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <div class="col-lg-8 col-md-10 mx-auto">
                                <div class="card mt-4">
                                    <div class="card-header border-bottom-0 pb-0 bg-white">
                                        <h5 class="card-title mb-0">
                                            ${template != null ? 'Sửa' : 'Thêm'} Mẫu Email
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <!-- HIỂN THỊ LỖI (nếu có) -->
                                        <% String error = (String) request.getAttribute("error");
                                   if (error != null) { %>
                                        <div style="color: #f44336; font-weight: 600; margin-bottom: 20px; font-size: 1.09rem; border-left: 4px solid #f44336; padding-left: 12px;">
                                            <%= error %>
                                        </div>
                                        <% } %>
                                        <form action="emailTemplates" method="post" autocomplete="off">
                                            <input type="hidden" name="action" value="${template != null ? 'update' : 'create'}">
                                            <c:if test="${template != null}">
                                                <input type="hidden" name="id" value="${input_id != null ? input_id : template.templateId}">
                                            </c:if>
                                            <div class="mb-3">
                                                <label class="form-label">Tên mẫu <span style="color:red">*</span></label>
                                                <input type="text" class="form-control" placeholder="Nhập tên mẫu" required name="templateName"
                                                       value="${input_templateName != null ? input_templateName : (template != null ? template.templateName : '')}">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Chủ đề <span style="color:red">*</span></label>
                                                <input type="text" class="form-control" placeholder="Nhập chủ đề" required name="subject"
                                                       value="${input_subject != null ? input_subject : (template != null ? template.subject : '')}">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Nội dung <span style="color:red">*</span></label>
                                                <textarea class="form-control" rows="6" placeholder="Nhập nội dung" required name="content">${input_content != null ? input_content : (template != null ? template.content : '')}</textarea>
                                            </div>
                                            <div class="mb-4">
                                                <label class="form-label">Variables</label>
                                                <input type="text" class="form-control" placeholder="Ví dụ: username, code (phân cách bằng dấu phẩy)" name="variables"
                                                       value="${input_variables != null ? input_variables : (template != null ? template.variables : '')}">
                                            </div>
                                            <div class="d-flex gap-3">
                                                <button type="submit" class="btn btn-primary px-4">Lưu</button>
                                                <button type="reset" class="btn btn-outline-secondary">Đặt lại</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <footer class="content-footer footer bg-footer-theme mt-4" style="background:rgba(255,255,255,0.9);">
                            <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                                <div class="text-muted">
                                    © <script>document.write(new Date().getFullYear())</script> POS Admin
                                </div>
                                <div>
                                    <a href="#">Privacy Policy</a> | <a href="#">Terms of Use</a>
                                </div>
                            </div>
                        </footer>
                    </div>
                </div>
            </div>
        </div>
        <!-- Scripts -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html>
