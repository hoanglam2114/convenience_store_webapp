<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/10/2025
  Time: 7:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
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
<!-- Add padding to account for fixed navbar -->
<div style="padding-top: 80px;"></div>

<div class="container-fluid py-4">
    <div class="row">
        <div class="col-12">
            <!-- Header Section -->
            <div class="branch-info text-center">
                <h1 class="display-4 fw-bold mb-3">
                    <i class="fas fa-map-marker-alt me-2"></i>
                    Hệ thống chi nhánh
                </h1>
                <p class="lead mb-0">Khám phá mạng lưới cửa hàng Circle K trên toàn quốc</p>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Map Section -->
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-map me-2"></i>
                        Bản đồ chi nhánh
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div id="map"></div>
                </div>
            </div>
        </div>

        <!-- Branch List Section -->
        <div class="col-lg-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-success text-white">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-store me-2"></i>
                        Danh sách chi nhánh
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3" id="branchList">
                        <!-- Branch cards will be populated by JavaScript -->
                    </div>
                </div>
            </div>

            <!-- Statistics Card -->
            <div class="card shadow-sm border-0 mt-3">
                <div class="card-header bg-info text-white">
                    <h6 class="card-title mb-0">
                        <i class="fas fa-chart-bar me-2"></i>
                        Thống kê
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-6">
                            <div class="border-end">
                                <h4 class="text-primary fw-bold mb-1" id="totalBranches">3</h4>
                                <small class="text-muted">Tổng chi nhánh</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <h4 class="text-success fw-bold mb-1">3</h4>
                            <small class="text-muted">Khu vực</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer -->
<jsp:include page="/common/customer-footer.jsp" />

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
<!-- Leaflet JS -->
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    // Initialize map
    const map = L.map('map').setView([21.025133, 105.850965], 10);

    // Add tile layer
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors',
    }).addTo(map);

    // Branch data
    const branches = [
        {
            name: "Convema Đông Anh",
            lat: 21.150669,
            lng: 105.848677,
            address: "Đường Đản Mỗ, Đông Anh, Hà Nội",
            phone: "028-1234-5678",
            status: "Đang hoạt động"
        },
        {
            name: "Convema Đống Đa",
            lat: 21.012704,
            lng: 105.822851,
            address: "141 P. Đặng Tiến Đông, Trung Liệt, Đống Đa, Hà Nội, Vietnam",
            phone: "0254-987-6543",
            status: "Đang hoạt động"
        },
        {
            name: "Convema Cầu Giấy",
            lat: 21.030197,
            lng: 105.789253,
            address: "TP. Thành Thái, Dịch Vọng, Cầu Giấy, Hà Nội, Vietnam",
            phone: "0251-456-7890",
            status: "Đang hoạt động"
        }
    ];

    // Add markers to map
    branches.forEach((branch, index) => {
        const marker = L.marker([branch.lat, branch.lng])
            .addTo(map)
            .bindPopup(`
                    <div class="p-2">
                        <h6 class="fw-bold text-primary mb-2">${branch.name}</h6>
                        <p class="mb-1 small"><i class="fas fa-map-marker-alt text-danger me-1"></i>${branch.address}</p>
                        <p class="mb-1 small"><i class="fas fa-phone text-success me-1"></i>${branch.phone}</p>
                        <p class="mb-0 small"><i class="fas fa-circle text-success me-1"></i>${branch.status}</p>
                    </div>
                `);

        // Add click event to focus on branch
        marker.on('click', function() {
            highlightBranchCard(index);
        });
    });

    // Populate branch list
    function populateBranchList() {
        const branchList = document.getElementById('branchList');
        branchList.innerHTML = '';

        branches.forEach((branch, index) => {
            const branchCard = document.createElement('div');
            branchCard.className = 'col-12';
            branchCard.innerHTML = `
                    <div class="card branch-card h-100 cursor-pointer" onclick="focusOnBranch(${index})" id="branch-card-${index}">
                        <div class="card-body p-3">
                            <h6 class="card-title text-primary fw-bold mb-2">${branch.name}</h6>
                            <p class="card-text small mb-1">
                                <i class="fas fa-map-marker-alt text-muted me-1"></i>
                                ${branch.address}
                            </p>
                            <p class="card-text small mb-1">
                                <i class="fas fa-phone text-muted me-1"></i>
                                ${branch.phone}
                            </p>
                            <span class="badge bg-success small">${branch.status}</span>
                        </div>
                    </div>
                `;
            branchList.appendChild(branchCard);
        });
    }

    // Focus on specific branch
    function focusOnBranch(index) {
        const branch = branches[index];
        map.setView([branch.lat, branch.lng], 15);

        // Highlight selected card
        highlightBranchCard(index);
    }

    // Highlight branch card
    function highlightBranchCard(index) {
        // Remove previous highlights
        document.querySelectorAll('.branch-card').forEach(card => {
            card.classList.remove('border-primary', 'shadow');
        });

        // Add highlight to selected card
        const selectedCard = document.getElementById(`branch-card-${index}`);
        if (selectedCard) {
            selectedCard.classList.add('border-primary', 'shadow');
        }
    }

    // Initialize branch list on page load
    document.addEventListener('DOMContentLoaded', function() {
        populateBranchList();
    });

    // Add custom CSS for cursor pointer
    const style = document.createElement('style');
    style.textContent = `
            .cursor-pointer {
                cursor: pointer;
            }
            .cursor-pointer:hover {
                box-shadow: 0 4px 8px rgba(0,0,0,0.15) !important;
            }
        `;
    document.head.appendChild(style);
</script>
</body>
</html>