<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/10/2025
  Time: 7:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bản đồ Chi nhánh Free</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        #map {
            height: 500px;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<h2>Hệ thống chi nhánh</h2>
<div id="map"></div>

<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script>
    const map = L.map('map').setView([10.7769, 106.7009], 10);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap',
    }).addTo(map);

    const branches = [
        { name: "Circle K Quận 1", lat: 10.7769, lng: 106.7009 },
        { name: "Circle K Vũng Tàu", lat: 10.346, lng: 107.0843 },
        { name: "Circle K Long Thành", lat: 10.7876, lng: 107.0124 },
    ];

    branches.forEach(branch => {
        L.marker([branch.lat, branch.lng])
            .addTo(map)
            .bindPopup(`<b>${branch.name}</b>`)
            .openPopup();
    });
</script>
</body>
</html>