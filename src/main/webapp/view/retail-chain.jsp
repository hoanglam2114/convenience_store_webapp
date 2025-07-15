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
<div style="padding-top: 80px;"></div>

<div class="container-fluid py-4">
    <div class="row">
        <div class="col-12">
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

        <div class="col-lg-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-success text-white">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-store me-2"></i>
                        Danh sách chi nhánh
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3" id="branchList"></div>
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
    // Add CSS for map and cursor
    const style = document.createElement('style');
    style.textContent = `
        #map {
            height: 500px;
            width: 100%;
        }
        .cursor-pointer {
            cursor: pointer;
        }
        .cursor-pointer:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.15) !important;
        }

        /* Debug CSS */
        #branchList {
            background-color: #f8f9fa !important;
            border: 2px solid red !important;
            min-height: 200px !important;
        }
        .branch-card {
            background-color: white !important;
            border: 2px solid blue !important;
            margin-bottom: 10px !important;
            display: block !important;
            visibility: visible !important;
        }
        .branch-card .card-body {
            padding: 15px !important;
        }
    `;
    document.head.appendChild(style);

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

    // Global variables
    let map;
    let markers = [];

    // Enhanced popup content for map markers
    function initializeMap() {
        try {
            console.log('Initializing map...');
            map = L.map('map').setView([21.025133, 105.850965], 10);
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors',
            }).addTo(map);

            // Add markers to map with enhanced popups
            branches.forEach((branch, index) => {
                if (!branch.lat || !branch.lng) {
                    console.error(`Invalid coordinates for branch: ${branch.name}`);
                    return;
                }

                const marker = L.marker([branch.lat, branch.lng])
                    .addTo(map)
                    .bindPopup(`
                    <div class="p-3" style="min-width: 250px;">
                        <h6 class="fw-bold text-primary mb-3">
                            <i class="fas fa-store me-2"></i>${branch.name}
                        </h6>
                        <div class="mb-2">
                            <i class="fas fa-map-marker-alt text-danger me-2"></i>
                            <span class="small">${branch.address}</span>
                        </div>
                        <div class="mb-2">
                            <i class="fas fa-phone text-success me-2"></i>
                            <span class="small">${branch.phone}</span>
                        </div>
                        <div class="mb-2">
                            <i class="fas fa-circle text-success me-2"></i>
                            <span class="small">${branch.status}</span>
                        </div>
                        <div class="mt-3 text-center">
                            <button class="btn btn-sm btn-primary" onclick="focusOnBranch(${index})">
                                <i class="fas fa-eye me-1"></i>Xem chi tiết
                            </button>
                        </div>
                    </div>
                `, {
                        maxWidth: 300,
                        className: 'custom-popup'
                    });

                marker.on('click', function() {
                    console.log(`Marker clicked: ${branch.name}`);
                    highlightBranchCard(index);
                });

                markers.push(marker);
            });

            console.log('Map initialized successfully');
        } catch (error) {
            console.error('Error initializing map:', error);
        }
    }

    // Populate branch list - Fixed version
    function populateBranchList() {
        try {
            console.log('Populating branch list...');
            const branchList = document.getElementById('branchList');
            if (!branchList) {
                console.error('Element #branchList not found');
                return;
            }

            // Clear existing content
            branchList.innerHTML = '';

            branches.forEach((branch, index) => {
                // Create elements using DOM methods instead of innerHTML
                const colDiv = document.createElement('div');
                colDiv.className = 'col-12 mb-2';

                const cardDiv = document.createElement('div');
                cardDiv.className = 'card branch-card h-100 cursor-pointer';
                cardDiv.id = `branch-card-${index}`;
                cardDiv.style.cssText = 'border: 1px solid #dee2e6; background: white; transition: all 0.3s ease;';
                cardDiv.setAttribute('onclick', `focusOnBranch(${index})`);

                const cardBody = document.createElement('div');
                cardBody.className = 'card-body';

                // Branch name
                const nameDiv = document.createElement('h6');
                nameDiv.className = 'card-title text-primary fw-bold mb-2';
                nameDiv.innerHTML = `<i class="fas fa-store me-2"></i>${branch.name}`;

                // Address
                const addressDiv = document.createElement('p');
                addressDiv.className = 'card-text mb-1 small';
                addressDiv.innerHTML = `<i class="fas fa-map-marker-alt text-danger me-1"></i>${branch.address}`;

                // Phone
                const phoneDiv = document.createElement('p');
                phoneDiv.className = 'card-text mb-1 small';
                phoneDiv.innerHTML = `<i class="fas fa-phone text-success me-1"></i>${branch.phone}`;

                // Status
                const statusDiv = document.createElement('p');
                statusDiv.className = 'card-text mb-0 small';
                statusDiv.innerHTML = `<i class="fas fa-circle text-success me-1"></i>${branch.status}`;

                // Append elements
                cardBody.appendChild(nameDiv);
                cardBody.appendChild(addressDiv);
                cardBody.appendChild(phoneDiv);
                cardBody.appendChild(statusDiv);

                cardDiv.appendChild(cardBody);
                colDiv.appendChild(cardDiv);
                branchList.appendChild(colDiv);
            });

            console.log('Branch list populated successfully');

            // Add hover effects
            document.querySelectorAll('.branch-card').forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-2px)';
                    this.style.boxShadow = '0 4px 12px rgba(0,0,0,0.15)';
                });

                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = '0 2px 4px rgba(0,0,0,0.1)';
                });
            });

        } catch (error) {
            console.error('Error populating branch list:', error);
        }
    }

    // Focus on specific branch
    function focusOnBranch(index) {
        try {
            const branch = branches[index];
            if (map && branch.lat && branch.lng) {
                map.setView([branch.lat, branch.lng], 15);
                // Open popup for the selected marker
                if (markers[index]) {
                    markers[index].openPopup();
                }
            }
            highlightBranchCard(index);
        } catch (error) {
            console.error('Error focusing on branch:', error);
        }
    }


    // Enhanced highlight function
    function highlightBranchCard(index) {
        try {
            console.log(`Highlighting branch card: ${index}`);

            // Remove highlight from all cards
            document.querySelectorAll('.branch-card').forEach(card => {
                card.classList.remove('border-primary', 'shadow-lg');
                card.style.borderColor = '#dee2e6';
                card.style.borderWidth = '1px';
            });

            // Add highlight to selected card
            const selectedCard = document.getElementById(`branch-card-${index}`);
            if (selectedCard) {
                selectedCard.classList.add('border-primary', 'shadow-lg');
                selectedCard.style.borderColor = '#0d6efd';
                selectedCard.style.borderWidth = '2px';

                // Scroll to the selected card
                selectedCard.scrollIntoView({
                    behavior: 'smooth',
                    block: 'nearest'
                });
            } else {
                console.error(`Branch card not found: branch-card-${index}`);
            }
        } catch (error) {
            console.error('Error highlighting branch card:', error);
        }
    }

    // Simple initialization
    function initialize() {
        console.log('Starting initialization...');
        populateBranchList();

        // Wait for Leaflet to be ready
        if (typeof L !== 'undefined') {
            initializeMap();
        } else {
            console.log('Leaflet not ready, retrying...');
            setTimeout(initialize, 500);
        }
    }

    // Multiple initialization strategies
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initialize);
    } else {
        initialize();
    }

    // Backup initialization
    window.addEventListener('load', function() {
        console.log('Window loaded, checking initialization...');
        if (!document.getElementById('branchList').hasChildNodes()) {
            console.log('Branch list empty, re-initializing...');
            initialize();
        }
    });
</script>
</body>
</html>