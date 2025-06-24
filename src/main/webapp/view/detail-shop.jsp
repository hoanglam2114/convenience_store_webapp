<%-- 
    Document   : AddUnit
    Created on : Jun 3, 2025, 3:59:29 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Thêm đơn vị</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />
        <!-- Font and icon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />


    </head>



    <title>Chi tiết cửa hàng - </title>
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
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .info-row {
            margin-bottom: 15px;
        }

        .info-row label {
            font-weight: bold;
            display: inline-block;
            width: 160px;
        }

        .store-img {
            max-width: 350px;
            border-radius: 8px;
            margin-top: 10px;
            box-shadow: 0 0 5px rgba(0,0,0,0.2);
        }

        .map-container {
            margin-top: 30px;
        }

        iframe {
            width: 100%;
            height: 400px;
            border: none;
            border-radius: 10px;
        }

        .back-button {
            margin-top: 20px;
        }

        .back-button a {
            text-decoration: none;
            padding: 8px 20px;
            background-color: #007BFF;
            color: white;
            border-radius: 5px;
            font-weight: bold;
        }

        .back-button a:hover {
            background-color: #0056b3;
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
            <div class="layout-page" >
                <!-- Navbar -->
                <%@ include file="/common/nav-bar.jsp" %>
                <!-- / Navbar -->

                <div class="container-xxl flex-grow-1 container-p-y">

                    <c:set value="${Shop}" var="s" />
                    <div class="container">
                        <h2>Chi tiết cửa hàng</h2>

                        <div class="info-row">
                            <label>Tên cửa hàng: </label> ${s.getShopName()}
                        </div>

                        <div class="info-row">
                            <label>Số điện thoại: </label> ${s.getShopPhone()}
                        </div>

                        <div class="info-row">
                            <label>Email: </label> ${s.getShopEmail()}
                        </div>

                        <div class="info-row">
                            <label>Địa chỉ: </label> ${s.getShopAddress()}
                        </div>

                        <div class="info-row">
                            <label>Thời gian hoạt động: </label> ${s.getShopOpeningHours()}
                        </div>

                        

                        <div class="map-container">
                            <label>Địa chỉ cửa hàng trên maps:</label><br>
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.5062169039725!2d105.52271427379662!3d21.012421688342386!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2sFPT%20University!5e0!3m2!1sen!2s!4v1750585632929!5m2!1sen!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">

                            </iframe>
                        </div>

                        <div class="back-button">
                            <a href="store-list.jsp">← Quay lại danh sách</a>
                        </div>
                    </div>

                </div>
            </div>
            <!-- /Layout page -->

        </div>
        <!-- /Layout container -->
    </div>
    <!-- /Layout wrapper -->  
    
    <!-- CHÈN SCRIPT GOOGLE MAPS -->
<script>
    // Lấy thông tin từ server-side thông qua JSTL/EL
    const storeName = "${s.getShopName()}";
    const storePhone = "${s.getShopPhone()}";
    const storeAddress = "${s.getShopAddress()}";

    function initMap() {
        const map = new google.maps.Map(document.getElementById("map"), {
            zoom: 15,
            center: { lat: 10.762622, lng: 106.660172 } // fallback nếu geocode thất bại
        });

        const geocoder = new google.maps.Geocoder();

        geocoder.geocode({ address: storeAddress }, function(results, status) {
            if (status === "OK") {
                map.setCenter(results[0].geometry.location);

                const marker = new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location
                });

                const infoWindow = new google.maps.InfoWindow({
                    content: `<strong>${storeName}</strong><br>Địa chỉ: ${storeAddress}<br>SĐT: ${storePhone}`
                });

                marker.addListener("click", () => {
                    infoWindow.open(map, marker);
                });

                infoWindow.open(map, marker); // tự mở khi load
            } else {
                alert("Không tìm thấy địa chỉ bản đồ: " + status);
            }
        });
    }
</script>

<!-- Nhúng Google Maps JavaScript API -->
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=YOUR_GOOGLE_API_KEY&callback=initMap">
</script>

    <!-- Sneat JS -->
    <script src="assets/vendor/libs/jquery/jquery.js"></script>
    <script src="assets/vendor/js/bootstrap.js"></script>
    <script src="assets/vendor/js/menu.js"></script>
    <script src="assets/vendor/js/helpers.js"></script>
    <script src="assets/js/config.js"></script>
    <script src="assets/js/main.js"></script> <!-- Quan trọng -->

</body>
</html>
