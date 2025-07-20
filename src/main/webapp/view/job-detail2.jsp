<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CƠ HỘI NGHỀ NGHIỆP</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .hero-bg {
                background-image: linear-gradient(rgba(105, 108, 255, 0.8), rgba(105, 108, 255, 0.8)), url('https://images.unsplash.com/photo-1521791136064-7986c2920216?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2069&q=80');
                background-size: cover;
                background-position: center;
            }

            .job-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(105, 108, 255, 0.1);
                border-left: 4px solid #696cff;
            }

            .filter-active {
                background-color: #696cff;
                color: white;
            }

            .modal {
                transition: opacity 0.3s ease, visibility 0.3s ease;
            }
            
            .nav-link:hover {
                color: #696cff;
            }
            
            .nav-link.active {
                color: #696cff;
                position: relative;
            }
            
            .nav-link.active:after {
                content: '';
                position: absolute;
                bottom: -6px;
                left: 0;
                width: 100%;
                height: 2px;
                background-color: #696cff;
            }
        </style>
    </head>
    <body class="font-sans bg-gray-50">
        <!-- Header -->
        <header class="bg-white shadow-sm">
            <div class="container mx-auto px-4 py-4 flex justify-between items-center">
                <div class="flex items-center">
                    <h1 class="text-xl font-bold text-gray-800"><span class="text-[#696cff]">Convenma</span></h1>
                </div>
                <nav class="hidden md:flex space-x-8">
                    <a href="#" class="nav-link active text-gray-600">Trang chủ</a>
                    <a href="#" class="nav-link text-gray-600">Về chúng tôi</a>
                    <a href="#" class="nav-link text-gray-600">Tuyển dụng</a>
                    <a href="#" class="nav-link text-gray-600">Liên hệ</a>
                </nav>
                <div class="flex items-center space-x-4">
                    <button class="bg-[#696cff] hover:bg-[#5f61e6] text-white font-medium py-2 px-4 rounded-md">
                        Đăng nhập
                    </button>
                    <button class="md:hidden text-gray-600">
                        <i class="fas fa-bars text-2xl"></i>
                    </button>
                </div>
            </div>
        </header>

        <!-- Hero Section -->
        <section class="hero-bg text-white py-20 md:py-32">
            <div class="container mx-auto px-4 text-center">
                <h1 class="text-4xl md:text-6xl font-bold mb-6">CƠ HỘI NGHỀ NGHIỆP</h1>
                <p class="text-xl md:text-2xl max-w-3xl mx-auto mb-8">Gia nhập đội ngũ năng động của Convenma - Nơi bạn có thể phát triển bản thân và xây dựng sự nghiệp trong môi trường chuyên nghiệp</p>
                <button onclick="scrollToJobs()" class="bg-white hover:bg-gray-100 text-[#696cff] font-bold py-3 px-8 rounded-full text-lg transition duration-300 shadow-md">
                    Xem vị trí tuyển dụng
                </button>
            </div>
        </section>

        <!-- Why Join Us -->
        <section class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <div class="text-center mb-12">
                    <span class="text-[#696cff] font-semibold">TẠI SAO CHỌN CHÚNG TÔI</span>
                    <h2 class="text-3xl font-bold text-gray-800 mt-2">Tại sao nên làm việc tại Convenma?</h2>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="text-center p-6 rounded-lg border border-gray-100 hover:border-[#696cff] transition duration-300 hover:shadow-lg">
                        <div class="bg-[#696cff] w-16 h-16 mx-auto rounded-full flex items-center justify-center mb-4 text-white">
                            <i class="fas fa-chart-line text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold mb-3">Cơ hội phát triển</h3>
                        <p class="text-gray-600">Chương trình đào tạo bài bản và lộ trình thăng tiến rõ ràng giúp bạn phát triển sự nghiệp</p>
                    </div>
                    <div class="text-center p-6 rounded-lg border border-gray-100 hover:border-[#696cff] transition duration-300 hover:shadow-lg">
                        <div class="bg-[#696cff] w-16 h-16 mx-auto rounded-full flex items-center justify-center mb-4 text-white">
                            <i class="fas fa-users text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold mb-3">Môi trường năng động</h3>
                        <p class="text-gray-600">Làm việc trong môi trường trẻ trung, sáng tạo và chuyên nghiệp</p>
                    </div>
                    <div class="text-center p-6 rounded-lg border border-gray-100 hover:border-[#696cff] transition duration-300 hover:shadow-lg">
                        <div class="bg-[#696cff] w-16 h-16 mx-auto rounded-full flex items-center justify-center mb-4 text-white">
                            <i class="fas fa-hand-holding-usd text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold mb-3">Đãi ngộ hấp dẫn</h3>
                        <p class="text-gray-600">Mức lương cạnh tranh cùng nhiều chế độ phúc lợi hấp dẫn</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Job Listings -->
        <section id="job-listings" class="py-16 bg-gray-50">
            <div class="container mx-auto px-4">
                <div class="mb-8">
                    <span class="text-[#696cff] font-semibold">TUYỂN DỤNG</span>
                    <h2 class="text-3xl font-bold text-gray-800 mt-2">Vị trí đang tuyển dụng</h2>
                </div>

                <form action="ListJobCustomer" method="post">
                    <!-- Filter Section -->
                    <div class="bg-white p-6 rounded-lg shadow-sm mb-8 border border-gray-100">
                        <h3 class="text-xl font-semibold mb-4 text-gray-800">Lọc công việc</h3>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <!-- Tìm kiếm theo tên -->
                            <div>
                                <label class="block text-gray-700 mb-2 font-medium">Tìm theo tên công việc</label>
                                <div class="relative">
                                    <input style="width: 300px" type="text" id="jobName" name="jobTitle" placeholder="Nhập tên công việc..." 
                                        class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent">
                                    <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
                                </div>
                            </div>
                            
                            <!-- Khu vực - dropdown -->
                            <div>
                                <label class="block text-gray-700 mb-2 font-medium">Khu vực</label>
                                <select class="w-full py-2 px-3 border border-gray-200 rounded-md focus:outline-none focus:ring-2 focus:ring-[#696cff]"
                                        name="jobLocation">
                                    <option value="All location">Tất cả khu vực</option>
                                    <option value="hcm">TP. Hồ Chí Minh</option>
                                    <option value="hn">Hà Nội</option>
                                    <option value="dn">Đà Nẵng</option>
                                </select>
                            </div>

                            <!-- Loại hình - dropdown -->
                            <div>
                                <label class="block text-gray-700 mb-2 font-medium">Loại hình</label>
                                <select class="w-full py-2 px-3 border border-gray-200 rounded-md focus:outline-none focus:ring-2 focus:ring-[#696cff]"
                                        name="jobType">
                                    <option value="All Type">Tất cả loại hình</option>
                                    <option value="fulltime">Toàn thời gian</option>
                                    <option value="parttime">Bán thời gian</option>
                                    <option value="remote">Làm việc từ xa</option>
                                </select>
                            </div>
                            
                            <!-- Nút tìm kiếm -->
                            <div class="md:col-span-3 flex justify-end mt-4">
                                <button onclick="applyFilters()" class="bg-[#696cff] hover:bg-[#5f61e6] text-white font-medium py-2 px-6 rounded-md transition duration-300 flex items-center">
                                    <i class="fas fa-search mr-2"></i> Tìm kiếm
                                </button>
                            </div>
                        </div>
                    </div>
                </form>

                <!-- Job Cards -->
                <div class="grid grid-cols-1 gap-6" id="job-container">
                    <!-- Job 1 -->
                    <div class="job-card bg-white p-6 rounded-lg shadow-sm border border-gray-100 transition duration-300" data-region="hcm" data-type="fulltime">
                        <div class="flex flex-col md:flex-row md:justify-between md:items-center">
                            <div class="mb-4 md:mb-0">
                                <h3 class="text-xl font-bold text-[#696cff]">Trưởng Phòng Kinh Doanh</h3>
                                <div class="flex items-center mt-2 text-gray-600">
                                    <i class="fas fa-map-marker-alt mr-2"></i>
                                    <span class="mr-4">TP. Hồ Chí Minh</span>
                                    <i class="fas fa-clock mr-2"></i>
                                    <span class="mr-4">Toàn thời gian</span>
                                    <i class="fas fa-calendar-times mr-2"></i>
                                    <span>30/11/2023</span>
                                </div>
                            </div>
                            <a href="#" onclick="openApplyModal('Trưưởng Phòng Kinh Doanh')" class="bg-[#696cff] hover:bg-[#5f61e6] text-white font-bold py-2 px-6 rounded-full transition duration-300 inline-flex items-center">
                                Ứng tuyển ngay <i class="fas fa-arrow-right ml-2"></i>
                            </a>
                        </div>
                        <div class="mt-4 pt-4 border-t border-gray-200">
                            <p class="text-gray-700 mb-4">Chúng tôi đang tìm kiếm một Trưưởng Phòng Kinh Doanh có kinh nghiệm để dẫn dắt đội ngũ kinh doanh của công ty. Bạn sẽ chịu trách nhiệm phát triển chiến lược kinh doanh, quản lý đội ngũ và đạt được các chỉ tiêu doanh số.</p>
                            <div class="flex flex-wrap gap-2">
                                <span class="bg-[#696cff]/10 text-[#696cff] text-xs px-3 py-1 rounded-full">Quản lý</span>
                                <span class="bg-[#696cff]/10 text-[#696cff] text-xs px-3 py-1 rounded-full">Kinh nghiệm 5 năm</span>
                                <span class="bg-[#696cff]/10 text-[#696cff] text-xs px-3 py-1 rounded-full">Lương thưưởng hấp dẫn</span>
                            </div>
                        </div>
                    </div>

                    <!-- Job 2 -->
                    <div class="job-card bg-white p-6 rounded-lg shadow-sm border border-gray-100 transition duration-300" data-region="hn" data-type="fulltime">
                        <div class="flex flex-col md:flex-row md:justify-between md:items-center">
                            <div class="mb-4 md:mb-0">
                                <h3 class="text-xl font-bold text-[#696cff]">Lập Trình Viên Full-stack</h3>
                                <div class="flex items-center mt-2 text-gray-600">
                                    <i class="fas fa-map-marker-alt mr-2"></i>
                                    <span class="mr-4">Hà Nội</span>
                                    <i class="fas fa-clock mr-2"></i>
                                    <span class="mr-4">Toàn thời gian</span>
                                    <i class="fas fa-calendar-times mr-2"></i>
                                    <span>15/12/2023</span>
                                </div>
                            </div>
                            <a href="#" onclick="openApplyModal('Lập Trình Viên Full-stack')" class="bg-[#696cff] hover:bg-[#5f61e6] text-white font-bold py-2 px-6 rounded-full transition duration-300 inline-flex items-center">
                                Ứng tuyển ngay <i class="fas fa-arrow-right ml-2"></i>
                            </a>
                        </div>
                        <div class="mt-4 pt-4 border-t border-gray-200">
                            <p class="text-gray-700 mb-4">Chúng tôi cần một Lập Trình Viên Full-stack có kinh nghiệm với React.js và Node.js để tham gia vào đội ngũ phát triển sản phẩm. Bạn sẽ tham gia vào tất cả các giai đoạn phát triển phần mềm từ thiết kế đến triển khai.</p>
                            <div class="flex flex-wrap gap-2">
                                <span class="bg-[#696cff]/10 text-[#696cff] text-xs px-3 py-1 rounded-full">Công nghệ</span>
                                <span class="bg-[#696cff]/10 text-[#696cff] text-xs px-3 py-1 rounded-full">Kinh nghiệm 2 năm</span>
                                <span class="bg-[#696cff]/10 text-[#696cff] text-xs px-3 py-1 rounded-full">Linh hoạt</span>
                            </div>
                        </div>
                    </div>

                    <!-- Job 3 -->
                    <div class="job-card bg-white p-6 rounded-lg shadow-sm border border-gray-100 transition duration-300" data-region="dn" data-type="remote">
                        <div class="flex flex-col md:flex-row md:justify-between md:items-center">
                            <div class="mb-4 md:mb-0">
                                <h3 class="text-xl font-bold text-[#696cff]">Chuyên Viên Marketing</h3>
                                <div class="flex items-center mt-2 text-gray-600">
                                    <i class="fas fa-map-marker-alt mr-2"></i>
                                    <span class="mr-4">Đà Nẵng</span>
                                    <i class="fas fa-clock mr-2"></i>
                                    <span class="mr-4">Làm việc từ xa</span>
                                    <i class="fas fa-calendar-times mr-2"></i>
                                    <span>20/12/2023</span>
                                </div>
                            </div>
                            <a href="#" onclick="openApplyModal('Chuyên Viên Marketing')" class="bg-[#696cff] hover:bg-[#5f61e6] text-white font-bold py-2 px-6 rounded-full transition duration-300 inline-flex items-center">
                                Ứng tuyển ngay <i class="fas fa-arrow-right ml-2"></i>
                            </a>
                        </div>
                        <div class="mt-4 pt-4 border-t border-gray-200">
                            <p class="text-gray-700 mb-4">Chúng tôi đang tìm kiếm một Chuyên Viên Marketing sáng tạo và năng động để tham gia vào đội ngũ marketing. Bạn sẽ chịu trách nhiệm phát triển và thực hiện các chiến dịch marketing trên nhiều kênh khác nhau.</p>
                            <div class="flex flex-wrap gap-2">
                                <span class="bg-[#696cff]/10 text-[#696cff] text-xs px-3 py-1 rounded-full">Sáng tạo</span>
                                <span class="bg-[#696cff]/10 text-[#696cff] text-xs px-3 py-1 rounded-full">Kinh nghiệm 3 năm</span>
                                <span class="bg-[#696cff]/10 text-[#696cff] text-xs px-3 py-1 rounded-full">Linh hoạt</span>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-10">
                        <button class="border-2 border-[#696cff] text-[#696cff] hover:bg-[#696cff] hover:text-white font-bold py-2 px-8 rounded-full transition duration-300">
                            Xem thêm vị trí
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Testimonials -->
        <section class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <div class="text-center mb-12">
                    <span class="text-[#696cff] font-semibold">CẢM NHẬN</span>
                    <h2 class="text-3xl font-bold text-gray-800 mt-2">Nhân viên nói gì về chúng tôi</h2>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="p-6 rounded-lg border border-gray-100 hover:border-[#696cff] transition duration-300">
                        <div class="flex items-center mb-4">
                            <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Nguyễn Thị Mai" class="w-12 h-12 rounded-full mr-4">
                            <div>
                                <h4 class="font-semibold">Nguyễn Thị Mai</h4>
                                <p class="text-gray-500 text-sm">Nhân viên Kinh doanh</p>
                            </div>
                        </div>
                        <p class="text-gray-600">"Tôi đã làm việc tại Convenma được 3 năm và thực sự cảm thấy đây là môi trường tuyệt vời để phát triển bản thân. Công ty luôn tạo điều kiện để nhân viên học h hỏi và thăng tiến."</p>
                        <div class="mt-4 text-yellow-400">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                    <div class="p-6 rounded-lg border border-gray-100 hover:border-[#696cff] transition duration-300">
                        <div class="flex items-center mb-4">
                            <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Trần Văn Nam" class="w-12 h-12 rounded-full mr-4">
                            <div>
                                <h4 class="font-semibold">Trần Văn Nam</h4>
                                <p class="text-gray-500 text-sm">Lập trình viên</p>
                            </div>
                        </div>
                        <p class="text-gray-600">"Môi trường làm việc tại Convenma rất chuyên nghiệp và thân thiện. Tôi được làm việc với những công nghệ mới nhất và có cơ hội phát triển kỹ năng liên tục."</p>
                        <div class="mt-4 text-yellow-400">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </div>
                    </div>
                    <div class="p-6 rounded-lg border border-gray-100 hover:border-[#696cff] transition duration-300">
                        <div class="flex items-center mb-4">
                            <img src="https://randomuser.me/api/portraits/women/68.jpg" alt="Lê Thị Hương" class="w-12 h-12 rounded-full mr-4">
                            <div>
                                <h4 class="font-semibold">Lê Thị Hương</h4>
                                <p class="text-gray-500 text-sm">Trưưởng phòng Marketing</p>
                            </div>
                        </div>
                        <p class="text-gray-600">"Convenma không chỉ là nơi làm việc mà còn là ngôi nhà thứ hai của tôi. Văn hóa công ty rất tốt, đồng nghiệp thân thiện và luôn sẵn sàng h hỗ trợ lẫn nhau."</p>
                        <div class="mt-4 text-yellow-400">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="py-16 bg-[#696cff] text-white">
            <div class="container mx-auto px-4 text-center">
                <h2 class="text-3xl font-bold mb-6">Sẵn sàng gia nhập đội ngũ của chúng tôi?</h2>
                <p class="text-xl max-w-3xl mx-auto mb-8">Hãy gửi hồ sơ của bạn ngay hôm nay và bắt đầu hành trình phát triển sự nghiệp tại Convenma</p>
                <button onclick="scrollToJobs()" class="bg-white hover:bg-gray-100 text-[#696cff] font-bold py-3 px-8 rounded-full text-lg transition duration-300 shadow-md">
                    Ứng tuyển ngay
                </button>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-gray-900 text-white py-12">
            <div class="container mx-auto px-4">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                    <div>
                        <h3 class="text-xl font-bold mb-4 flex items-center">
                            <span class="text-[#696cff]">Convenma</span>
                        </h3>
                        <p class="text-gray-400 mb-4">Mang đến những trải nghiệm làm việc tuyệt vời và cơ hội phát triển nghề nghiệp bền vững.</p>
                        <div class="flex space-x-4">
                            <a href="#" class="w-10 h-10 bg-gray-800 rounded-full flex items-center justify-center hover:bg-[#696cff] transition">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a href="#" class="w-10 h-10 bg-gray-800 rounded-full flex items-center justify-center hover:bg-[#696cff] transition">
                                <i class="fab fa-linkedin-in"></i>
                            </a>
                            <a href="#" class="w-10 h-10 bg-gray-800 rounded-full flex items-center justify-center hover:bg-[#696cff] transition">
                                <i class="fab fa-youtube"></i>
                            </a>
                        </div>
                    </div>
                    <div>
                        <h4 class="font-semibold mb-4">Thông tin</h4>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-400 hover:text-white transition">Về chúng tôi</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition">Tuyển dụng</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition">Tin tức</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition">Liên hệ</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-semibold mb-4">Hỗ trợ</h4>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-400 hover:text-white transition">Câu hỏi thường gặp</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition">Chính sách bảo mật</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition">Điều khoản sử dụng</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white transition">Chính sách tuyển dụng</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-semibold mb-4">Liên hệ</h4>
                        <ul class="space-y-3 text-gray-400">
                            <li class="flex items-start">
                                <i class="fas fa-map-marker-alt mt-1 mr-3 text-[#696cff]"></i>
                                <span>Tòa nhà Convenma, 123 Đường ABC, Quận 1, TP.HCM</span>
                            </li>
                            <li class="flex items-center">
                                <i class="fas fa-phone-alt mr-3 text-[#696cff]"></i>
                                <span>(+84) 123 456 789</span>
                            </li>
                            <li class="flex items-center">
                                <i class="fas fa-envelope mr-3 text-[#696cff]"></i>
                                <a href="mailto:tuyendung@convenma.com" class="hover:text-white transition">tuyendung@convenma.com</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="border-t border-gray-800 mt-8 pt-8 text-center text-gray-400">
                    <p>© 2023 Convenma. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Apply Modal -->
        <div id="apply-modal" class="fixed inset-0 z-50 invisible opacity-0 flex items-center justify-center bg-black bg-opacity-50 modal">
            <div class="bg-white rounded-lg shadow-xl w-full max-w-2xl mx-4">
                <div class="p-6">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-2xl font-bold text-gray-800">Ứng tuyển: <span id="job-title" class="text-[#696cff]">Trưưởng Phòng Kinh Doanh</span></h3>
                        <button onclick="closeApplyModal()" class="text-gray-400 hover:text-gray-600">
                            <i class="fas fa-times text-2xl"></i>
                        </button>
                    </div>
                    <form class="space-y-4">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-gray-700 mb-2">Họ và tên</label>
                                <input type="text" class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent">
                            </div>
                            <div>
                                <label class="block text-gray-700 mb-2">Email</label>
                                <input type="email" class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent">
                            </div>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-gray-700 mb-2">Số điện thoại</label>
                                <input type="tel" class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent">
                            </div>
                            <div>
                                <label class="block text-gray-700 mb-2">Vị trí ứng tuyển</label>
                                <input type="text" class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent" id="modal-job-title" readonly>
                            </div>
                        </div>
                        <div>
                            <label class="block text-gray-700 mb-2">Tải lên CV</label>
                            <div class="border-2 border-dashed border-gray-200 rounded-md p-4 text-center">
                                <i class="fas fa-cloud-upload-alt text-3xl text-[#696cff] mb-2"></i>
                                <p class="text-gray-500">Kéo thả file vào đây hoặc click để chọn file</p>
                                <input type="file" class="hidden">
                            </div>
                        </div>
                        <div>
                            <label class="block text-gray-700 mb-2">Giới thiệu bản thân</label>
                            <textarea rows="4" class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent"></textarea>
                        </div>
                        <div class="flex justify-end space-x-4 pt-4">
                            <button type="button" onclick="closeApplyModal()" class="border border-gray-300 text-gray-700 font-medium py-2 px-6 rounded-md hover:bg-gray-100 transition">
                                Hủy
                            </button>
                            <button type="submit" class="bg-[#696cff] hover:bg-[#5f61e6] text-white font-medium py-2 px-6 rounded-md transition">
                                Gửi đơn ứng tuyển
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            // Scroll to job listings
            function scrollToJobs() {
                document.getElementById('job-listings').scrollIntoView({behavior: 'smooth'});
            }

            // Filter jobs function
            function filterJobs(filterType) {
                const jobCards = document.querySelectorAll('.job-card');
                const filterBtns = document.querySelectorAll('.filter-btn');

                // Update active filter button
                if (filterType.includes('region')) {
                    filterBtns.forEach(btn => {
                        if (btn.dataset.filter.includes('region')) {
                            btn.classList.remove('filter-active', 'bg-[#696cff]', 'text-white');
                        }
                    });
                } else if (filterType.includes('type')) {
                    filterBtns.forEach(btn => {
                        if (btn.dataset.filter.includes('type')) {
                            btn.classList.remove('filter-active', 'bg-[#696cff]', 'text-white');
                        }
                    });
                }

                document.querySelector(`.filter-btn[data-filter="${filterType}"]`).classList.add('filter-active', 'bg-[#696cff]', 'text-white');

                // Get current active filters
                const activeRegion = document.querySelector('.filter-btn.filter-active[data-filter*="region"]').dataset.filter;
                const activeType = document.querySelector('.filter-btn.filter-active[data-filter*="type"]').dataset.filter;

                // Filter job cards
                jobCards.forEach(card => {
                    const cardRegion = card.dataset.region;
                    const cardType = card.dataset.type;

                    const showRegion = activeRegion === 'all-region' || cardRegion === activeRegion;
                    const showType = activeType === 'all-type' || cardType === activeType;

                    if (showRegion && showType) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            }

            // Application modal functions
            function openApplyModal(jobTitle) {
                document.getElementById('job-title').textContent = jobTitle;
                document.getElementById('modal-job-title').value = jobTitle;
                document.getElementById('apply-modal').classList.remove('invisible', 'opacity-0');
                document.body.style.overflow = 'hidden';
            }

            function closeApplyModal() {
                document.getElementById('apply-modal').classList.add('invisible', 'opacity-0');
                document.body.style.overflow = 'auto';
            }

            // Close modal when clicking outside
            document.getElementById('apply-modal').addEventListener('click', function (e) {
                if (e.target === this) {
                    closeApplyModal();
                }
            });

            // Mobile menu toggle
            document.querySelector('.md\\:hidden').addEventListener('click', function() {
                // Implement mobile menu toggle functionality here
                alert('Mobile menu would open here');
            });
        </script>
    </body>
</html>