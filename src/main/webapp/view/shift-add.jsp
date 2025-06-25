<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
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
                        <!-- Empty navbar -->
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

                            <!-- Add Shift Form -->
                            <form action="AddShiftServlet" method="POST" class="card p-4">
                                <input type="hidden" name="action" value="add"/>

                                <!-- Shift Name -->
                                <div class="mb-3">
                                    <label for="shiftName" class="form-label">Tên ca *</label>
                                    <input type="text" class="form-control" id="shiftName" name="shiftName" required />
                                </div>

                                <!-- Start Time -->
                                <div class="mb-3">
                                    <label for="startTime" class="form-label">Giờ bắt đầu *</label>
                                    <input type="time" class="form-control" id="startTime" name="startTime" required />
                                </div>

                                <!-- End Time -->
                                <div class="mb-3">
                                    <label for="endTime" class="form-label">Giờ kết thúc *</label>
                                    <input type="time" class="form-control" id="endTime" name="endTime" required />
                                </div>

                                <!-- Working Days -->
                                <div class="mb-3">
                                    <label class="form-label d-block">Các ngày làm việc:</label>
                                    <c:forEach var="day" items="${['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']}">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" name="workingDays" value="${day}" id="${day}">
                                            <label class="form-check-label" for="${day}">${day}</label>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Description -->
                                <div class="mb-3">
                                    <label for="description" class="form-label">Ghi chú</label>
                                    <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                                </div>

                                <!-- Submit -->
                                <button type="submit" class="btn btn-success">
                                    <i class="bx bx-save"></i> Lưu
                                </button>
                            </form>

                            <div class="mt-3 text-muted small">
                                <ul>
                                    <li><strong>Days</strong>: danh sách các ngày làm việc.</li>
                                    <li>Nhân viên không thể điểm danh vào các ngày không được chọn.</li>
                                </ul>
                            </div>
                        </div>

                        <!-- Footer -->
                        <footer class="content-footer footer bg-footer-theme mt-3">
                            <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                                <div>© 2025, Sneat Admin Template</div>
                                <div>Developed by You</div>
                            </div>
                        </footer>
                    </div>
                </div>
            </div>
        </div>

        <!-- Core JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/libs/popper/popper.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/js/main.js"></script>

        <script>
            document.querySelector("form").addEventListener("submit", function (e) {
                const name = document.getElementById("shiftName").value.trim();
                const start = document.getElementById("startTime").value;
                const end = document.getElementById("endTime").value;
                const days = document.querySelectorAll('input[name="workingDays"]:checked');

                // Validate tên ca
                if (name === "") {
                    alert("Vui lòng nhập tên ca.");
                    e.preventDefault();
                    return;
                }

                const onlyDigits = /^\d+$/;
                if (onlyDigits.test(name)) {
                    alert("Tên ca không được chỉ chứa số.");
                    e.preventDefault();
                    return;
                }

                // Validate giờ bắt đầu và kết thúc
                if (!start || !end) {
                    alert("Vui lòng nhập đầy đủ giờ bắt đầu và kết thúc.");
                    e.preventDefault();
                    return;
                }

                if (start === end) {
                    alert("Giờ bắt đầu và giờ kết thúc không được trùng nhau.");
                    e.preventDefault();
                    return;
                }

                const startTimeObj = new Date(`1970-01-01T${start}:00`);
                const endTimeObj = new Date(`1970-01-01T${end}:00`);
                let duration = (endTimeObj - startTimeObj) / (1000 * 60 * 60); // đơn vị giờ

                if (duration < 0) {
                    duration += 24; // xử lý ca đêm (qua ngày)
                }

                if (duration > 12) {
                    alert("Thời lượng ca làm không được vượt quá 12 tiếng.");
                    e.preventDefault();
                    return;
                }

                // Validate ngày làm việc
                if (days.length === 0) {
                    alert("Vui lòng chọn ít nhất một ngày làm việc.");
                    e.preventDefault();
                    return;
                }
            });
        </script>



    </body>
</html>
