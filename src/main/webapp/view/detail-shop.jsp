<%-- 
    Document   : ShopDetail
    Created on : Jun 3, 2025, 3:59:29 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Chi tiết cửa hàng</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        
        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />
        
        <!-- Font and icon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
        
        <!-- Goong CSS - Updated CDN link -->
        <link href="https://cdn.goong.io/goong-js/v1.0.9/goong-js.css" rel="stylesheet" />
        
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
                background: #f6f6f6;
            }

            .container {
                max-width: 1000px;
                margin: auto;
                background: white;
                padding: 30px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                border-radius: 8px;
            }

            h2 {
                margin-bottom: 20px;
                color: #333;
            }

            .info-row {
                margin-bottom: 15px;
                padding: 8px 0;
                border-bottom: 1px solid #eee;
            }

            .info-row label {
                font-weight: bold;
                display: inline-block;
                width: 180px;
                color: #555;
            }

            .info-value {
                color: #333;
            }

            .store-img {
                max-width: 350px;
                border-radius: 8px;
                margin-top: 10px;
                box-shadow: 0 0 5px rgba(0,0,0,0.2);
            }

            .map-container {
                margin-top: 30px;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
            }

            #map {
                height: 400px;
                width: 100%;
                border-radius: 8px;
                background: #f0f0f0;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #666;
            }

            .back-button {
                margin-top: 20px;
                text-align: left;
            }

            .back-button a {
                text-decoration: none;
                padding: 10px 20px;
                background-color: #007BFF;
                color: white;
                border-radius: 5px;
                font-weight: bold;
                display: inline-block;
                transition: background-color 0.3s;
            }

            .back-button a:hover {
                background-color: #0056b3;
            }

            .error-message {
                background: #fee;
                border: 1px solid #fcc;
                color: #c00;
                padding: 12px;
                border-radius: 4px;
                margin: 10px 0;
            }

            .loading-message {
                background: #e3f2fd;
                border: 1px solid #bbdefb;
                color: #1976d2;
                padding: 12px;
                border-radius: 4px;
                margin: 10px 0;
                text-align: center;
            }

            .fallback-map {
                text-align: center;
                padding: 40px 20px;
                background: #f8f9fa;
                border-radius: 8px;
            }

            .fallback-map h4 {
                color: #495057;
                margin-bottom: 10px;
            }

            .fallback-map a {
                color: #007BFF;
                text-decoration: none;
                font-weight: bold;
            }

            .fallback-map a:hover {
                text-decoration: underline;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                    margin: 10px;
                }
                
                .info-row label {
                    width: 100%;
                    display: block;
                    margin-bottom: 5px;
                }
            }
        </style>
    </head>

    <body>
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">

                <!-- Sidebar -->
                <%@ include file="/common/site-bar.jsp" %>
                
                <!-- Layout page -->
                <div class="layout-page">
                    <!-- Navbar -->
                    <%@ include file="/common/nav-bar.jsp" %>
                    <!-- / Navbar -->

                    <div class="container-xxl flex-grow-1 container-p-y">
                        <c:set value="${Shop}" var="s" />
                        
                        <div class="container">
                            <h2>Chi tiết cửa hàng</h2>

                            <!-- Shop Information -->
                            <div class="info-row">
                                <label>Tên cửa hàng:</label>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty s.shopName}">
                                            <c:out value="${s.shopName}" />
                                        </c:when>
                                        <c:otherwise>Chưa có thông tin</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <div class="info-row">
                                <label>Số điện thoại:</label>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty s.shopPhone}">
                                            <c:out value="${s.shopPhone}" />
                                        </c:when>
                                        <c:otherwise>Chưa có thông tin</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <div class="info-row">
                                <label>Email:</label>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty s.shopEmail}">
                                            <c:out value="${s.shopEmail}" />
                                        </c:when>
                                        <c:otherwise>Chưa có thông tin</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <div class="info-row">
                                <label>Địa chỉ:</label>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty s.shopAddress}">
                                            <c:out value="${s.shopAddress}" />
                                        </c:when>
                                        <c:otherwise>Chưa có thông tin</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <div class="info-row">
                                <label>Thời gian hoạt động:</label>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty s.shopOpeningHours}">
                                            <c:out value="${s.shopOpeningHours}" />
                                        </c:when>
                                        <c:otherwise>Chưa có thông tin</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <!-- Map Container -->
                            <div class="map-container">
                                <label><strong>Địa chỉ cửa hàng trên bản đồ:</strong></label>
                                <div id="map-status"></div>
                                <div id="map">
                                    <div class="loading-message">Đang tải bản đồ...</div>
                                </div>
                            </div>

                            <div class="back-button">
                                <a href="ListShop">← Quay lại danh sách</a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Layout page -->
            </div>
            <!-- /Layout container -->
        </div>
        <!-- /Layout wrapper -->

        <!-- Updated Goong JS CDN -->
        <script src="https://cdn.goong.io/goong-js/v1.0.9/goong-js.js"></script>
        
        <!-- Sneat JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/js/helpers.js"></script>
        <script src="assets/js/config.js"></script>
        
        <!-- Menu JS with error handling -->
        <script>
            // Safe menu loading
            if (typeof window.menu !== 'undefined' && window.menu.manageScroll) {
                try {
                    window.menu.manageScroll();
                } catch (error) {
                    console.warn('Menu scroll management error:', error);
                }
            }
        </script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/js/main.js"></script>

        <!-- Pass data to JavaScript safely -->
        <script>
            // Define data object to pass from JSP to JavaScript
            window.SHOP_DATA = {
                apiKey: 'tlWfVqcpe1HK5iC2Ev9mloR2Nc4AWDZJnmmaTzNI',
                shopAddress: '<c:out value="${s.shopAddress}" escapeXml="true" />',
                shopName: '<c:out value="${s.shopName}" escapeXml="true" />'
            };
        </script>
        
        <!-- Map Script -->
        <script>
            class ShopMapManager {
                constructor() {
                    // Get data from global object
                    this.apiKey = window.SHOP_DATA.apiKey;
                    this.shopAddress = window.SHOP_DATA.shopAddress;
                    this.shopName = window.SHOP_DATA.shopName;
                    this.map = null;
                    this.init();
                }

                init() {
                    // Wait for DOM to be ready
                    if (document.readyState === 'loading') {
                        document.addEventListener('DOMContentLoaded', () => this.initializeMap());
                    } else {
                        this.initializeMap();
                    }
                }

                async initializeMap() {
                    const mapStatus = document.getElementById('map-status');
                    const mapContainer = document.getElementById('map');

                    // Validate address
                    if (!this.shopAddress || this.shopAddress.trim() === '' || this.shopAddress === 'Chưa có thông tin') {
                        this.showError('Không có thông tin địa chỉ để hiển thị bản đồ');
                        return;
                    }

                    try {
                        // Check if Goong API is loaded
                        if (typeof goongjs === 'undefined') {
                            throw new Error('Goong API chưa được tải');
                        }

                        mapStatus.innerHTML = '<div class="loading-message">Đang tải bản đồ...</div>';

                        // Geocode address
                        const coordinates = await this.geocodeAddress(this.shopAddress);
                        
                        if (coordinates) {
                            await this.createMap(coordinates);
                            mapStatus.innerHTML = ''; // Clear status message
                        } else {
                            throw new Error('Không thể xác định tọa độ từ địa chỉ');
                        }

                    } catch (error) {
                        console.error('Map initialization error:', error);
                        this.showError('Lỗi tải bản đồ: ' + error.message);
                        this.showFallbackMap();
                    }
                }

                async geocodeAddress(address) {
                    if (!address || !this.apiKey) {
                        throw new Error('Thiếu địa chỉ hoặc API key');
                    }

                    const encodedAddress = encodeURIComponent(address.trim());
                    const url = 'https://rsapi.goong.io/Geocode?address=' + encodedAddress + '&api_key=' + this.apiKey;
                    
                    console.log('Geocoding address:', address);
                    console.log('API URL:', url);

                    try {
                        const response = await fetch(url);
                        
                        if (!response.ok) {
                            if (response.status === 403) {
                                throw new Error('API key không hợp lệ hoặc đã hết quota');
                            } else if (response.status === 404) {
                                throw new Error('Không tìm thấy địa chỉ');
                            }
                            throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                        }

                        const data = await response.json();
                        console.log('Geocoding response:', data);

                        // Validate response structure
                        if (data && data.results && Array.isArray(data.results) && data.results.length > 0) {
                            const result = data.results[0];
                            if (result.geometry && result.geometry.location) {
                                const location = result.geometry.location;
                                if (typeof location.lat === 'number' && typeof location.lng === 'number') {
                                    return {
                                        lat: location.lat,
                                        lng: location.lng
                                    };
                                }
                            }
                        }

                        throw new Error('Phản hồi API không chứa tọa độ hợp lệ');

                    } catch (error) {
                        console.error('Geocoding error:', error);
                        throw error;
                    }
                }

                async createMap(coordinates) {
                    try {
                        // Set access token
                        goongjs.accessToken = this.apiKey;

                        // Create map
                        this.map = new goongjs.Map({
                            container: 'map',
                            style: 'https://tiles.goong.io/assets/goong_map_web.json',
                            center: [coordinates.lng, coordinates.lat],
                            zoom: 15
                        });

                        // Wait for map to load
                        var self = this;
                        this.map.on('load', function() {
                            // Add marker
                            const marker = new goongjs.Marker({
                                color: '#FF0000'
                            })
                                .setLngLat([coordinates.lng, coordinates.lat])
                                .addTo(self.map);

                            // Add popup
                            const popup = new goongjs.Popup({ offset: 25 })
                                .setHTML('<div style="padding: 10px;"><h4 style="margin: 0 0 5px 0; color: #333;">' + (self.shopName || 'Cửa hàng') + '</h4><p style="margin: 0; color: #666; font-size: 14px;">' + self.shopAddress + '</p></div>');

                            marker.setPopup(popup);
                        });

                        // Handle map errors
                        this.map.on('error', function(error) {
                            console.error('Map error:', error);
                            self.showError('Lỗi hiển thị bản đồ');
                            self.showFallbackMap();
                        });

                    } catch (error) {
                        console.error('Map creation error:', error);
                        throw error;
                    }
                }

                showError(message) {
                    const mapStatus = document.getElementById('map-status');
                    if (mapStatus) {
                        mapStatus.innerHTML = '<div class="error-message">' + message + '</div>';
                    }
                }

                showFallbackMap() {
                    const mapContainer = document.getElementById('map');
                    if (mapContainer) {
                        mapContainer.innerHTML = '<div class="fallback-map"><h4>📍 ' + (this.shopName || 'Cửa hàng') + '</h4><p>' + this.shopAddress + '</p><a href="https://www.google.com/maps/search/?api=1&query=' + encodeURIComponent(this.shopAddress) + '" target="_blank" rel="noopener noreferrer">Xem trên Google Maps</a></div>';
                    }
                }
            }

            // Initialize map manager
            const shopMapManager = new ShopMapManager();
        </script>
    </body>
</html>