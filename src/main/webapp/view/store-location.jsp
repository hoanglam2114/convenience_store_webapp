<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tìm Circle K gần nhất</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
        }

        .banner {
            background-color: #ff6600;
            color: white;
            padding: 30px 20px;
            text-align: center;
            position: relative;
        }

        .banner h1 {
            margin: 0;
            font-size: 28px;
            text-transform: uppercase;
        }

        .banner p {
            margin-top: 10px;
            font-size: 15px;
        }

        .search-bar {
            background-color: white;
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .search-bar select,
        .search-bar input {
            padding: 8px;
            font-size: 14px;
        }

        .search-bar button {
            background-color: #d40000;
            color: white;
            padding: 8px 16px;
            border: none;
            font-weight: bold;
            cursor: pointer;
        }

        .search-bar .warning {
            width: 100%;
            color: red;
            text-align: center;
            font-size: 13px;
        }

        .map-section {
            display: flex;
            padding: 0;
            height: 600px;
        }

        .map-container {
            flex: 3;
            position: relative;
        }

        .map-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .store-list {
            flex: 1;
            background: #fff;
            overflow-y: auto;
            padding: 20px;
            border-left: 1px solid #ccc;
        }

        .store-list h3 {
            margin-top: 0;
        }

        .store-item {
            padding: 10px 0;
            border-bottom: 1px dashed #ccc;
        }

        .store-item span {
            font-weight: bold;
            color: red;
        }

        .store-item .address {
            margin-top: 5px;
            font-size: 14px;
        }

        .view-link {
            display: block;
            color: #007BFF;
            text-decoration: none;
            font-size: 13px;
            margin-top: 3px;
        }

    </style>
</head>
<body>

<!-- Banner -->
<div class="banner">
    <h1>Tìm Circle K gần nhất</h1>
    <p>Với hơn 500 cửa hàng tại TP. Hồ Chí Minh, Bình Dương, Vũng Tàu, Cần Thơ, Hà Nội, Hạ Long, Nha Trang và các thành phố khác.</p>
</div>

<!-- Search Bar -->
<div class="search-bar">
    <select name="city">
        <option value="">Tỉnh thành</option>
    </select>
    <select name="district">
        <option value="">Quận huyện</option>
    </select>
    <select name="service1">
        <option value="">Dịch vụ tiện ích</option>
    </select>
    <select name="service2">
        <option value="">Dịch vụ khác</option>
    </select>
    <input type="text" placeholder="Nhập tên đường" />
    <button>Tìm cửa hàng</button>
    <span class="warning">Vui lòng chọn tỉnh thành phố</span>
</div>

<!-- Map and Store List -->
<div class="map-section">
    <div class="map-container">
        <img src="images/8a28826b-c743-4cfb-b9b0-147432fe0164.png" alt="Map Image" />
    </div>

    <div class="store-list">
        <h3>501 cửa hàng được tìm thấy</h3>

        <div class="store-item">
            <span>📍 S11, BS10</span>
            <div class="address">Vinhomes Grand Park, Thủ Đức, TP.HCM</div>
            <a href="#" class="view-link">› Xem vị trí</a>
        </div>

        <div class="store-item">
            <span>📍 S02.BS07</span>
            <div class="address">Vinhomes Grand Park, Thủ Đức, TP.HCM</div>
            <a href="#" class="view-link">› Xem vị trí</a>
        </div>

        <div class="store-item">
            <span>📍 106 Hoàng Diệu</span>
            <div class="address">Phường 13, Quận 4, TP.HCM</div>
            <a href="#" class="view-link">› Xem vị trí</a>
        </div>

        <div class="store-item">
            <span>📍 126 Phó Quang</span>
            <div class="address">Phường 9, Quận Phú Nhuận, TP.HCM</div>
            <a href="#" class="view-link">› Xem vị trí</a>
        </div>
    </div>
</div>

</body>
</html>
