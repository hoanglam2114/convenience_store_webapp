<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/15/2025
  Time: 9:47 PM
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
    request.setAttribute("pageTitle", "Convema");
%>
<jsp:include page="/common/header.jsp"/>
<jsp:include page="/common/customer-nav-bar.jsp"/>
<body>
<!-- Add padding to account for fixed navbar -->
<div style="padding-top: 120px;"></div>

<!--content-->
<div class="content-page wrapper d-flex flex-column min-vh-100">
    <main  class="container-fluid flex-grow-1">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-primary">
                        <h5 class="card-title mb-0 text-white">
                            <i class="bi bi-receipt me-2 text-white"></i>
                            Lịch sử mua hàng - ${sessionScope.customer.name}
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty orders}">
                            <div class="alert alert-info text-center">
                                <i class="bi bi-info-circle me-2"></i>
                                Bạn chưa có đơn hàng nào.
                            </div>
                        </c:if>

                        <c:if test="${not empty orders}">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                    <tr>
                                        <th scope="col">Mã đơn hàng</th>
                                        <th scope="col">Tên khách hàng</th>
                                        <th scope="col">Ngày đặt</th>
                                        <th scope="col">Tổng tiền</th>
                                        <th scope="col">Trạng thái</th>
                                        <th scope="col">Nhân viên xử lý</th>
                                        <th scope="col">Mã coupon</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td>
                                                <span class="badge bg-secondary">#O-${order.orderId}</span>
                                            </td>
                                            <td>
                                                <strong>${sessionScope.customer.name}</strong>
                                            </td>
                                            <td>
                                                <i class="bi bi-calendar3 me-1"></i>
                                                    ${order.orderDate}
                                            </td>
                                            <td>
                                                    <span class="text-success fw-bold">
                                                        ${Math.round(order.orderTotalAmount).intValue()}đ
                                                    </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.orderStatus == 'Completed'}">
                                                            <span class="badge bg-success">
                                                                <i class="bi bi-check-circle me-1"></i>
                                                                Hoàn thành
                                                            </span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'Pending'}">
                                                            <span class="badge bg-warning">
                                                                <i class="bi bi-clock me-1"></i>
                                                                Đang xử lý
                                                            </span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'Processing'}">
                                                            <span class="badge bg-info">
                                                                <i class="bi bi-gear me-1"></i>
                                                                Đang chuẩn bị
                                                            </span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'Cancelled'}">
                                                            <span class="badge bg-danger">
                                                                <i class="bi bi-x-circle me-1"></i>
                                                                Đã hủy
                                                            </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${order.orderStatus}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty order.employeeName}">
                                                        <i class="bi bi-person-badge me-1"></i>
                                                        ${order.employeeName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Chưa phân công</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty order.customerCouponId}">
                                                            <span class="badge bg-info">
                                                                <i class="bi bi-ticket-perforated me-1"></i>
                                                                #C-${order.customerCouponId}
                                                            </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Không có</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Phân trang -->
        <c:if test="${not empty totalPages and totalPages > 0}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="purchase-history?page=${currentPage - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="purchase-history?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="purchase-history?page=${currentPage + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>

    </main>
</div>
<!-- Footer -->
<jsp:include page="/common/customer-footer.jsp"/>
<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
    // Add some interactive features
    document.addEventListener('DOMContentLoaded', function () {
        // Add to cart button animation
        const addToCartButtons = document.querySelectorAll('.btn-add-cart');
        addToCartButtons.forEach(button => {
            button.addEventListener('click', function (e) {
                e.preventDefault();

                // Add temporary success state
                const originalText = this.innerHTML;
                this.innerHTML = '<i class="bi bi-check-circle me-2"></i>Đã thêm!';
                this.style.background = '#28a745';

                setTimeout(() => {
                    this.innerHTML = originalText;
                    this.style.background = '';
                }, 1500);
            });
        });

        // Search form enhancement
        const searchForm = document.querySelector('form[action="customer-home"]');
        if (searchForm) {
            const searchInput = searchForm.querySelector('input[name="keyword"]');
            if (searchInput) {
                searchInput.addEventListener('keypress', function (e) {
                    if (e.key === 'Enter') {
                        searchForm.submit();
                    }
                });
            }
        }

        // Add hover effect to table rows
        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.backgroundColor = '#f8f9fa';
            });
            row.addEventListener('mouseleave', function() {
                this.style.backgroundColor = '';
            });
        });
    });
</script>
</body>
</html>