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
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <!-- FontAwesome (nếu cần) -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


        <style>
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
                .nav-link:hover {
                    color: #696cff;
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
                .row a {
                    display: block !important;
                    margin-bottom: 6px;
                }
            </style>
            
            
            <style>
                .customer-footer .footer-link {
                    display: block;
                    margin-bottom: 6px;
                    color: #ffffff;
                    text-decoration: none;
                }

                .customer-footer .footer-link:hover {
                    text-decoration: underline;
                }

                .customer-footer .footer-title {
                    font-weight: 600;
                    margin-bottom: 1rem;
                    display: block;
                }

                .customer-footer .social-icons a {
                    display: inline-block;
                    margin-right: 10px;
                    font-size: 1.2rem;
                    color: #ffffff;
                }

                .customer-footer .footer-bottom {
                    margin-top: 2rem;
                    text-align: center;
                    font-size: 0.9rem;
                    border-top: 1px solid rgba(255,255,255,0.1);
                    padding-top: 1rem;
                }
            </style>


        </head>




        <body class="font-sans bg-gray-50">
            <!--                     Header 
            -->                    <header class="bg-white shadow-md">
                <div class="container mx-auto px-4 py-4 flex justify-between items-center">
                    <div class="flex items-center">

                        <a href="customer-home" class="text-xl font-bold text-gray-800"><span class="text-[#696cff]">Convema</span></a>
                    </div>
                    <!--                            <nav class="hidden md:flex space-x-8">
                                                    <a href="#" class="text-gray-600 hover:text-indigo-600">Trang chủ</a>
                                                    <a href="#" class="text-gray-600 hover:text-indigo-600">Về chúng tôi</a>
                                                    <a href="#" class="text-gray-600 hover:text-indigo-600">Tuyển dụng</a>
                                                    <a href="#" class="text-gray-600 hover:text-indigo-600">Liên hệ</a>
                                                </nav>-->
                    <button class="md:hidden text-gray-600">
                            <i class="fas fa-bars text-2xl"></i>
                        </button>
                    </div>
                </header><!--

         Hero Section -->
                <section style="background: linear-gradient(45deg, #667eea, #764ba2);
                height: 60%;" class=" text-white py-20 md:py-32">
                    <div class="container mx-auto px-4 text-center">
                        <h1 class="text-4xl md:text-6xl font-bold mb-6">CƠ HỘI NGHỀ NGHIỆP</h1>
                        <p class="text-xl md:text-2xl max-w-3xl mx-auto mb-8">Gia nhập đội ngũ năng động của Convema - Nơi bạn có thể phát triển bản thân và xây dựng sự nghiệp trong môi trường chuyên nghiệp</p>
                        <button onclick="scrollToJobs()" class="bg-white hover:bg-gray-100 text-[#696cff] font-bold py-3 px-8 rounded-full text-lg transition duration-300">Xem vị trí tuyển dụng</button>
                    </div>
                </section>

                <!-- Why Join Us -->
                <section class="py-16 bg-white">
                    <div class="container mx-auto px-4">
                        <div class="text-center mb-12">

                            <h2 class="text-3xl font-bold text-gray-800 mt-2">Tại sao nên làm việc tại Convema?</h2>
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
                        <h2 class="text-3xl font-bold mb-8 text-gray-800">Vị trí đang tuyển dụng</h2>

                        <form action="ListJobCustomer" method="post">

                            <!-- Filter Section --> 
                            <div class="bg-white p-6 rounded-lg shadow-md mb-8">
                                <h3 class="text-xl font-semibold mb-4">Lọc công việc</h3>
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

                                    <!-- Tìm kiếm theo tên -->
                                    <div>
                                        <label   class="block text-gray-700 mb-2 font-medium">Tìm theo tên công việc</label>
                                        <input style="width: 300px" type="text" id="jobName" name="jobTitle" placeholder="Nhập tên công việc..." class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent">
                                    </div>


                                    <!-- Khu vực - dropdown -->
                                    <div>
                                        <label  class="block text-gray-700 mb-2 font-medium">Khu vực</label>
                                        <select  class="w-full py-2 px-3 border border-gray-200 rounded-md focus:outline-none focus:ring-2 focus:ring-[#696cff]"
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
                                        <select  class="w-full py-2 px-3 border border-gray-200 rounded-md focus:outline-none focus:ring-2 focus:ring-[#696cff]"
                                                 name="jobType">
                                            <option value="All Type" ${"All Type".equals(jobType) ? "selected" : ""}>Tất cả loại hình</option>
                                            <c:forEach items="${jobtype}" var="jt">
                                                <option value="${jt.getId()}" ${jt.equals(jobType) ? "selected" : ""}>${jt.getName()}</option>
                                            </c:forEach>
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
                            <c:forEach items="${job}" var="j">
                                <div class="job-card bg-white p-6 rounded-lg shadow-sm border border-gray-100 transition duration-300" data-region="hcm" data-type="fulltime">
                                    <div class="flex flex-col md:flex-row md:justify-between md:items-center">
                                        <div class="mb-4 md:mb-0">
                                            <h3 class="text-xl font-bold text-[#696cff]">${j.getTitle()}</h3>
                                            <div class="flex items-center mt-2 text-gray-600">
                                                <i class="fas fa-map-marker-alt mr-2"></i>
                                                <span class="mr-4">${j.getJobLocation().getName()}</span>
                                                <i class="fas fa-clock mr-2"></i>
                                                <span class="mr-4">${j.getJobTypes().getName()}</span>
                                                <i class="fas fa-times mr-2"></i>
                                                <span>${j.getDeadline()}</span>
                                            </div>
                                        </div>
                                        <a href="AddJobCustomer?job_id=${j.getId()}" onclick="" class="bg-[#696cff] hover:bg-[#5f61e6] text-white font-bold py-2 px-6 rounded-full transition duration-300 inline-flex items-center">Ứng tuyển ngay</a>
                                    </div>
                                    <div class="mt-4 pt-4 border-t border-gray-200">
                                        <p class="text-gray-700 mb-4">${j.getDescription()}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                </section>


            <footer style="background-color: #2c3e50;" class="text-white py-5 mt-5">
                <div class="container">
                    <div class="row">
                        <div class="col-12 customer-footer">
                            <jsp:include page="/common/customer-footer.jsp" />
                        </div>
                    </div>
                </div>
            </footer>


            <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
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