<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="model.Shift" %>
<!DOCTYPE html>
<html lang="vi" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="assets/"
      data-template="vertical-menu-template-free">

    <head>
        <meta charset="UTF-8">
        <title>Chỉnh sửa Ca Làm</title>
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
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold mb-4">Chỉnh sửa Ca Làm</h4>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>

                            <form id="editShiftForm" action="EditShift" method="post" class="card p-4">
                                <input type="hidden" name="action" value="edit"/>
                                <input type="hidden" name="shiftId" value="${shift != null ? shift.shiftId : shiftId}"/>

                                <div class="mb-3">
                                    <label class="form-label">Tên ca</label>
                                    <input type="text" name="shiftName" id="shiftName" class="form-control"
                                           value="${shiftName != null ? shiftName : (shift != null ? shift.shiftName : '')}" required/>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Giờ bắt đầu</label>
                                    <input type="time" name="startTime" id="startTime" class="form-control"
                                           value="${startTime != null ? startTime : (shift != null ? shift.startTime : '')}" required/>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Giờ kết thúc</label>
                                    <input type="time" name="endTime" id="endTime" class="form-control"
                                           value="${endTime != null ? endTime : (shift != null ? shift.endTime : '')}" required/>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label d-block">Các ngày làm việc:</label>
                                    <c:set var="selectedList"
                                           value="${selectedDays != null ? selectedDays : (shift != null ? shift.workingDays : [])}" />
                                    <c:set var="dayLabels" value="${['Thứ Hai','Thứ Ba','Thứ Tư','Thứ Năm','Thứ Sáu','Thứ Bảy','Chủ Nhật']}" />
                                    <c:set var="dayValues" value="${['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']}" />
                                    <c:forEach var="i" begin="0" end="6">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox"
                                                   name="workingDays" value="${dayValues[i]}" id="${dayValues[i]}"
                                                   <c:if test="${fn:contains(selectedList, dayValues[i])}">checked</c:if> />
                                            <label class="form-check-label" for="${dayValues[i]}">${dayLabels[i]}</label>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Ghi chú</label>
                                    <textarea name="description" class="form-control" rows="3">${description != null ? description : (shift != null ? shift.description : '')}</textarea>
                                </div>

                                <button type="submit" class="btn btn-primary">
                                    <i class="bx bx-save"></i> Lưu thay đổi
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- JavaScript kiểm tra dữ liệu -->
        <script>
            document.getElementById("editShiftForm").addEventListener("submit", function (e) {
                const shiftName = document.getElementById("shiftName").value.trim();
                const startTime = document.getElementById("startTime").value;
                const endTime = document.getElementById("endTime").value;
                const workingDays = document.querySelectorAll("input[name='workingDays']:checked");

                let errors = [];

                // 1. Tên ca không được để trống và không có ký tự đặc biệt
                if (shiftName === "") {
                    errors.push("Tên ca không được để trống.");
                } else if (!/^[a-zA-Z0-9\sÀ-ỹ]+$/.test(shiftName)) {
                    errors.push("Tên ca không được chứa ký tự đặc biệt.");
                }

                // 2. Giờ bắt đầu < giờ kết thúc
                if (!startTime || !endTime) {
                    errors.push("Giờ bắt đầu và kết thúc không được để trống.");
                } else if (startTime >= endTime) {
                    errors.push("Giờ kết thúc phải lớn hơn giờ bắt đầu.");
                }

                // 3. Phải chọn ít nhất một ngày làm việc
                if (workingDays.length === 0) {
                    errors.push("Vui lòng chọn ít nhất một ngày làm việc.");
                }

                if (errors.length > 0) {
                    e.preventDefault();
                    alert(errors.join("\n"));
                }
            });
        </script>

    </body>
</html>
