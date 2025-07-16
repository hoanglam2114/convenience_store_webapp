<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/10/2025
  Time: 7:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
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
<%
    request.setAttribute("pageTitle", "Chuỗi cửa hàng");
%>
<jsp:include page="/common/header.jsp" />
<jsp:include page="/common/customer-nav-bar.jsp" />
<body class="bg-light">
<!-- Main Content -->
<div style="padding-top: 80px;"></div>

<div class="container-fluid py-4">
    <div class="row">
        <div class="col-12">
            <div class="branch-info text-center">
                <h1 class="display-5 fw-bold mb-3">
                    <i class="fas fa-map-marker-alt me-2"></i>
                    Hệ thống chi nhánh
                </h1>
                <p class="lead mb-0">Khám phá mạng lưới cửa hàng Circle K trên toàn quốc</p>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-map me-2"></i>
                        Bản đồ chi nhánh
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div id="map" style="height: 500px; width: 100%;"></div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-success text-white">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-store me-2"></i>
                        Danh sách chi nhánh
                    </h5>
                </div>
                <div class="card-body pt-4">
                    <div class="row g-3" id="branchList">
                        <c:forEach items="${shopList}" var="shop">
                            <div class="col-12">
                                <div class="card border-0 bg-light h-100">
                                    <div class="card-body p-3">
                                        <h6 class="card-title mb-2">
                                            <i class="fas fa-store-alt text-primary me-2"></i>
                                                ${shop.shopName}
                                        </h6>
                                        <p class="card-text small mb-2">
                                            <i class="fas fa-map-marker-alt text-danger me-1"></i>
                                                ${shop.shopAddress}
                                        </p>
                                        <c:if test="${not empty shop.shopPhone}">
                                            <p class="card-text small mb-0">
                                                <i class="fas fa-phone text-success me-1"></i>
                                                    ${shop.shopPhone}
                                            </p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="card shadow-sm border-0 mt-3">
                <div class="card-header bg-info text-white">
                    <h6 class="card-title mb-0">
                        <i class="fas fa-chart-bar me-2"></i>
                        Thống kê
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row text-center pt-3">
                        <div class="col-6">
                            <div class="border-end">
                                <h4 class="text-primary fw-bold mb-1" id="totalBranches">${shopList.size()}</h4>
                                <small class="text-muted">Tổng chi nhánh</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <h4 class="text-success fw-bold mb-1">${shopList.size()}</h4>
                            <small class="text-muted">Khu vực</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/common/customer-footer.jsp" />

<!-- Leaflet CSS (must be before JS) -->
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Font Awesome -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<!-- Leaflet JS -->
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize the map centered on Vietnam
        const map = L.map('map').setView([21.0285, 105.8542], 6); // Hanoi coordinates as default center

        // Add OpenStreetMap tiles
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Shop data from servlet
        const shops = [
            <c:forEach items="${shopList}" var="shop" varStatus="status">
            {
                id: ${shop.shopId},
                name: "${shop.shopName}",
                address: "${shop.shopAddress}",
                phone: "${shop.shopPhone}",
                latitude: ${shop.latitude != null ? shop.latitude : 21.0285},
                longitude: ${shop.longitude != null ? shop.longitude : 105.8542}
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        // Custom marker icon
        const customIcon = L.icon({
            iconUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon.png',
            shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-shadow.png',
            iconSize: [25, 41],
            iconAnchor: [12, 41],
            popupAnchor: [1, -34],
            shadowSize: [41, 41]
        });

        // Add markers for each shop
        const markers = [];
        shops.forEach(function(shop) {
            const marker = L.marker([shop.latitude, shop.longitude], {icon: customIcon})
                .addTo(map)
                .bindPopup(
                    '<div class="popup-content">' +
                    '<h6 class="mb-2"><i class="fas fa-store text-primary me-2"></i>' + shop.name + '</h6>' +
                    '<p class="mb-1 small"><i class="fas fa-map-marker-alt text-danger me-1"></i>' + shop.address + '</p>' +
                    (shop.phone ? '<p class="mb-0 small"><i class="fas fa-phone text-success me-1"></i>' + shop.phone + '</p>' : '') +
                    '</div>'
                );
            markers.push(marker);
        });

        // Fit map to show all markers
        if (markers.length > 0) {
            const group = new L.featureGroup(markers);
            map.fitBounds(group.getBounds().pad(0.1));
        }

        // Add click event to branch list items to focus on map markers
        document.querySelectorAll('#branchList .card').forEach(function(card, index) {
            card.style.cursor = 'pointer';
            card.addEventListener('click', function() {
                if (markers[index]) {
                    map.setView([shops[index].latitude, shops[index].longitude], 15);
                    markers[index].openPopup();
                }
            });

            // Add hover effect
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px)';
                this.style.boxShadow = '0 4px 8px rgba(0,0,0,0.15)';
                this.style.transition = 'all 0.3s ease';
            });

            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = '';
            });
        });
    });
</script>

<style>
    /* Custom popup styles */
    .leaflet-popup-content {
        margin: 8px 12px;
        line-height: 1.4;
    }

    .popup-content h6 {
        color: #333;
        margin-bottom: 8px;
    }

    .popup-content p {
        margin-bottom: 4px;
        color: #666;
    }

    /* Branch list card hover effects */
    #branchList .card {
        transition: all 0.3s ease;
    }

    #branchList .card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    }

    /* Map container */
    #map {
        border-radius: 0 0 0.375rem 0.375rem;
    }
</style>

</body>
</html>