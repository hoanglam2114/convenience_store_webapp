<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="assets/"
      data-template="vertical-menu-template-free">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Ca Làm</title>
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
    </head>

    <body>
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <%@ include file="/common/site-bar.jsp" %>

                <div class="layout-page">
                    <nav class="layout-navbar container-xxl navbar navbar-expand-xl">
                        <!-- Thanh điều hướng trống -->
                    </nav>

                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="fw-bold">Thêm Ca Làm</h4>
                                <a href="ListShift" class="btn btn-outline-secondary">
                                    <i class="bx bx-arrow-back"></i> Trở về
                                </a>
                            </div>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>

                            <!-- Form Thêm Ca -->
                            <form action="AddShiftServlet" method="POST" class="card p-4">
                                <input type="hidden" name="action" value="add"/>

                                <!-- Tên Ca -->
                                <div class="mb-3">
                                    <label for="shiftName" class="form-label">Tên ca *</label>
                                    <input type="text" class="form-control" id="shiftName" name="shiftName"
                                           required value="${shiftName != null ? shiftName : ''}" />
                                </div>

                                <!-- Giờ Bắt Đầu -->
                                <div class="mb-3">
                                    <label for="startTime" class="form-label">Giờ bắt đầu *</label>
                                    <input type="time" class="form-control" id="startTime" name="startTime"
                                           required value="${startTime != null ? startTime : ''}" />
                                </div>

                                <!-- Giờ Kết Thúc -->
                                <div class="mb-3">
                                    <label for="endTime" class="form-label">Giờ kết thúc *</label>
                                    <input type="time" class="form-control" id="endTime" name="endTime"
                                           required value="${endTime != null ? endTime : ''}" />
                                </div>

                                <!-- Ngày Làm Việc -->
                                <div class="mb-3">
                                    <label class="form-label d-block">Các ngày làm việc:</label>
                                    <c:set var="selectedList" value="${selectedDays != null ? selectedDays : []}" />
                                    <c:set var="dayLabels" value="${['Thứ Hai','Thứ Ba','Thứ Tư','Thứ Năm','Thứ Sáu','Thứ Bảy','Chủ Nhật']}" />
                                    <c:set var="dayValues" value="${['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']}" />
                                    <c:forEach var="i" begin="0" end="6">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" name="workingDays" value="${dayValues[i]}" id="${dayValues[i]}"
                                                   <c:if test="${fn:contains(selectedList, dayValues[i])}">checked</c:if> />
                                            <label class="form-check-label" for="${dayValues[i]}">${days[i]}</label>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Ghi chú -->
                                <div class="mb-3">
                                    <label for="description" class="form-label">Ghi chú</label>
                                    <textarea class="form-control" id="description" name="description" rows="3">${description != null ? description : ''}</textarea>
                                </div>

                                <!-- Nút Lưu -->
                                <button type="submit" class="btn btn-success">
                                    <i class="bx bx-save"></i> Lưu
                                </button>
                            </form>

                            <div class="mt-3 text-muted small">
                                <ul>
                                    <li><strong>Ngày làm việc</strong>: Danh sách các ngày nhân viên sẽ làm việc.</li>
                                    <li>Nhân viên không thể điểm danh vào các ngày không được chọn.</li>
                                </ul>
                            </div>
                        </div>

                        <!-- JS kiểm tra dữ liệu -->
                        <script>
                            document.querySelector("form").addEventListener("submit", function (e) {
                                const shiftName = document.getElementById("shiftName").value.trim();
                                const startTime = document.getElementById("startTime").value;
                                const endTime = document.getElementById("endTime").value;
                                const workingDays = document.querySelectorAll("input[name='workingDays']:checked");

                                let errorMessages = [];

                                // 1. Tên ca không rỗng và không có ký tự đặc biệt
                                if (shiftName === "") {
                                    errorMessages.push("Tên ca không được để trống.");
                                } else if (!/^[a-zA-Z0-9\sÀ-ỹ]+$/.test(shiftName)) {
                                    errorMessages.push("Tên ca không được chứa ký tự đặc biệt.");
                                }

                                // 2. Kiểm tra giờ
                                if (!startTime || !endTime) {
                                    errorMessages.push("Vui lòng nhập giờ bắt đầu và giờ kết thúc.");
                                } else if (startTime >= endTime) {
                                    errorMessages.push("Giờ kết thúc phải lớn hơn giờ bắt đầu.");
                                }

                                // 3. Chọn ngày làm việc
                                if (workingDays.length === 0) {
                                    errorMessages.push("Vui lòng chọn ít nhất một ngày làm việc.");
                                }

                                // Nếu có lỗi, hiện alert và ngăn submit
                                if (errorMessages.length > 0) {
                                    e.preventDefault();
                                    alert(errorMessages.join("\\n"));
                                }
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
