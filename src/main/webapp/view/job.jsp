<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CƠ HỘI NGHỀ NGHIỆP</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .hero-bg {
                background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://images.unsplash.com/photo-1521791136064-7986c2920216?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2069&q=80');
                background-size: cover;
                background-position: center;
            }

            .job-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            }

            .filter-active {
                background-color: #e53e3e;
                color: white;
            }

            .modal {
                transition: opacity 0.3s ease, visibility 0.3s ease;
            }
        </style>
    </head>
    <body class="font-sans bg-gray-50">
        <!-- Header -->
        <header class="bg-white shadow-md">
            <div class="container mx-auto px-4 py-4 flex justify-between items-center">
                <div class="flex items-center">

                    <h1 class="text-xl font-bold text-gray-800">Convenma</h1>
                </div>
                <nav class="hidden md:flex space-x-8">
                    <a href="#" class="text-gray-600 hover:text-red-600">Trang chủ</a>
                    <a href="#" class="text-gray-600 hover:text-red-600">Về chúng tôi</a>
                    <a href="#" class="text-gray-600 hover:text-red-600">Tuyển dụng</a>
                    <a href="#" class="text-gray-600 hover:text-red-600">Liên hệ</a>
                </nav>
                <button class="md:hidden text-gray-600">
                    <i class="fas fa-bars text-2xl"></i>
                </button>
            </div>
        </header>

        <!-- Hero Section -->
        <section class="hero-bg text-white py-20 md:py-32">
            <div class="container mx-auto px-4 text-center">
                <h1 class="text-4xl md:text-6xl font-bold mb-6">CƠ HỘI NGHỀ NGHIỆP</h1>
                <p class="text-xl md:text-2xl max-w-3xl mx-auto mb-8">Gia nhập đội ngũ năng động của Convenma - Nơi bạn có thể phát triển bản thân và xây dựng sự nghiệp trong môi trường chuyên nghiệp</p>
                <button onclick="scrollToJobs()" class="bg-red-600 hover:bg-red-700 text-white font-bold py-3 px-8 rounded-full text-lg transition duration-300">Xem vị trí tuyển dụng</button>
            </div>
        </section>

        <!-- Why Join Us -->
        <section class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <h2 class="text-3xl font-bold text-center mb-12 text-gray-800">Tại sao nên làm việc tại Convenma?</h2>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="text-center p-6 rounded-lg hover:bg-red-50 transition duration-300">
                        <div class="bg-red-100 w-16 h-16 mx-auto rounded-full flex items-center justify-center mb-4">
                            <i class="fas fa-chart-line text-red-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold mb-3">Cơ hội phát triển</h3>
                        <p class="text-gray-600">Chương trình đào tạo bài bản và lộ trình thăng tiến rõ ràng giúp bạn phát triển sự nghiệp</p>
                    </div>
                    <div class="text-center p-6 rounded-lg hover:bg-red-50 transition duration-300">
                        <div class="bg-red-100 w-16 h-16 mx-auto rounded-full flex items-center justify-center mb-4">
                            <i class="fas fa-users text-red-600 text-2xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold mb-3">Môi trường năng động</h3>
                        <p class="text-gray-600">Làm việc trong môi trường trẻ trung, sáng tạo và chuyên nghiệp</p>
                    </div>
                    <div class="text-center p-6 rounded-lg hover:bg-red-50 transition duration-300">
                        <div class="bg-red-100 w-16 h-16 mx-auto rounded-full flex items-center justify-center mb-4">
                            <i class="fas fa-hand-holding-usd text-red-600 text-2xl"></i>
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
                <h2 class="text-3xl font-bold mb-8 text-gray-800">Vị trí đang tuyển dụng</h2>

                <form action="ListJobCustomer" method="post">

                    <!-- Filter Section --> 
                    <div class="bg-white p-6 rounded-lg shadow-md mb-8">
                        <h3 class="text-xl font-semibold mb-4">Lọc công việc</h3>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

                            <!-- Tìm kiếm theo tên -->
                            <div>
                                <label   class="block text-gray-700 mb-2 font-medium">Tìm theo tên công việc</label>
                                <input style="width: 300px" type="text" id="jobName" name="jobTitle" placeholder="Nhập tên công việc..." class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent">
                            </div>


                            <!-- Khu vực - dropdown -->
                            <div>
                                <label  class="block text-gray-700 mb-2 font-medium">Khu vực</label>
                                <select  class="w-full py-2 px-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                                         name="jobLocation">
                                    <option value="All location" ${"All location".equals(jobLocation) ? "selected" : ""}>Tất cả khu vực</option>
                                    <c:forEach items="${joblocate}" var="jl">
                                        <option value="${jl.getId()}" ${jl.equals(jobLocation) ? "selected" : ""}>${jl.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Loại hình - dropdown -->
                            <div>
                                <label  class="block text-gray-700 mb-2 font-medium">Loại hình</label>
                                <select  class="w-full py-2 px-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                                         name="jobType">
                                    <option value="All Type" ${"All Type".equals(jobType) ? "selected" : ""}>Tất cả loại hình</option>
                                    <c:forEach items="${jobtype}" var="jt">
                                        <option value="${jt.getId()}" ${jt.equals(jobType) ? "selected" : ""}>${jt.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>




                            <!-- Nút tìm kiếm -->
                            <div class="md:col-span-3 flex justify-end mt-4">
                                <button onclick="applyFilters()" class="bg-red-600 hover:bg-red-700 text-white font-medium py-1.5 px-6 rounded-md transition duration-300 text-sm">
                                    <i class="fas fa-search mr-2"></i> Tìm kiếm
                                </button>
                            </div>
                        </div>
                    </div>
                </form>

                <!-- Job Cards -->
                <div class="grid grid-cols-1 gap-6" id="job-container">
                    <!-- Job 1 -->
                    <c:forEach items="${job}" var="j">
                        <div class="job-card bg-white p-6 rounded-lg shadow-md transition duration-300" data-region="hcm" data-type="fulltime">
                            <div class="flex flex-col md:flex-row md:justify-between md:items-center">
                                <div class="mb-4 md:mb-0">
                                    <h3 class="text-xl font-bold text-red-600">${j.getTitle()}</h3>
                                    <div class="flex items-center mt-2 text-gray-600">
                                        <i class="fas fa-map-marker-alt mr-2"></i>
                                        <span class="mr-4">${j.getJobLocation().getName()}</span>
                                        <i class="fas fa-clock mr-2"></i>
                                        <span class="mr-4">${j.getJobTypes().getName()}</span>
                                        <i class="fas fa-times mr-2"></i>
                                        <span>${j.getDeadline()}</span>
                                    </div>
                                </div>
                                <a href="AddJobCustomer?job_id=${j.getId()}" onclick="" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-6 rounded-full transition duration-300">Ứng tuyển ngay</a>
                            </div>
                            <div class="mt-4 pt-4 border-t border-gray-200">
                                <p class="text-gray-700 mb-4">${j.getDescription()}</p>
                                <div class="flex flex-wrap gap-2">
                                    <span class="bg-red-100 text-red-800 text-xs px-3 py-1 rounded-full">Quản lý</span>
                                    <span class="bg-red-100 text-red-800 text-xs px-3 py-1 rounded-full">Kinh nghiệm 2 năm</span>
                                    <span class="bg-red-100 text-red-800 text-xs px-3 py-1 rounded-full">Lương thưởng hấp dẫn</span>
                                </div>
                            </div>
                        </div>


                    </c:forEach>
                    <div class="text-center mt-10">
                        <button class="border-2 border-red-600 text-red-600 hover:bg-red-600 hover:text-white font-bold py-2 px-8 rounded-full transition duration-300">Xem thêm vị trí</button>
                    </div>
                </div>

        </section>



        <!-- Footer -->
        <footer class="bg-gray-800 text-white py-12">
            <div class="container mx-auto px-4">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                    <div>
                        <h3 class="text-xl font-bold mb-4">Circle K Vietnam</h3>
                        <p class="text-gray-400">Mang đến những trải nghiệm mua sắm tiện lợi và dịch vụ khách hàng tuyệt vời.</p>
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
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-semibold mb-4">Kết nối với chúng tôi</h4>
                        <div class="flex space-x-4 mb-4">
                            <a href="#" class="w-10 h-10 bg-gray-700 rounded-full flex items-center justify-center hover:bg-red-600 transition">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a href="#" class="w-10 h-10 bg-gray-700 rounded-full flex items-center justify-center hover:bg-red-600 transition">
                                <i class="fab fa-linkedin-in"></i>
                            </a>
                            <a href="#" class="w-10 h-10 bg-gray-700 rounded-full flex items-center justify-center hover:bg-red-600 transition">
                                <i class="fab fa-youtube"></i>
                            </a>
                        </div>
                        <p class="text-gray-400">Email: <a href="mailto:tuyendung@circlek.com.vn" class="hover:text-white transition">tuyendung@circlek.com.vn</a></p>
                    </div>
                </div>
                <div class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-400">
                    <p>© 2023 Circle K Vietnam. All rights reserved.</p>
                </div>
            </div>
        </footer>

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
                            btn.classList.remove('filter-active', 'bg-red-600', 'text-white');
                        }
                    });
                } else if (filterType.includes('type')) {
                    filterBtns.forEach(btn => {
                        if (btn.dataset.filter.includes('type')) {
                            btn.classList.remove('filter-active', 'bg-red-600', 'text-white');
                        }
                    });
                }

                document.querySelector(`.filter-btn[data-filter="${filterType}"]`).classList.add('filter-active', 'bg-red-600', 'text-white');

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
        </script>
    </body>
</html>