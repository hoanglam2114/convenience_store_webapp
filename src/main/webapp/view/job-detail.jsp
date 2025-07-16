<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết công việc | Tuyển dụng</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .job-description ul {
                list-style-type: disc;
                margin-left: 1.5rem;
                margin-bottom: 1rem;
            }
            .job-description ol {
                list-style-type: decimal;
                margin-left: 1.5rem;
                margin-bottom: 1rem;
            }
            .animate-bounce-slow {
                animation: bounce 2s infinite;
            }
            @keyframes bounce {
                0%, 100% {
                    transform: translateY(0);
                }
                50% {
                    transform: translateY(-10px);
                }
            }
        </style>
    </head>
    <body class="bg-gray-50 font-sans">
        <!-- Header -->
        <header class="bg-white shadow-sm">
            <div class="container mx-auto px-4 py-4 flex justify-between items-center">
                <div class="flex items-center">
                    <div class="w-10 h-10 bg-red-600 rounded-full flex items-center justify-center text-white font-bold mr-3">JD</div>
                    <h1 class="text-xl font-bold text-gray-800">JobDream</h1>
                </div>
                <nav class="hidden md:flex space-x-8">
                    <a href="#" class="text-gray-600 hover:text-red-600">Trang chủ</a>
                    <a href="#" class="text-red-600 font-medium">Việc làm</a>
                    <a href="#" class="text-gray-600 hover:text-red-600">Công ty</a>
                    <a href="#" class="text-gray-600 hover:text-red-600">Blog</a>
                </nav>
                <div class="flex items-center space-x-4">
                    <button class="md:hidden text-gray-600">
                        <i class="fas fa-bars text-xl"></i>
                    </button>
                    <button class="hidden md:block px-4 py-2 text-red-600 border border-red-600 rounded-md hover:bg-red-50">Đăng nhập</button>
                    <button class="hidden md:block px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700">Đăng ký</button>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="container mx-auto px-4 py-8">
            <div class="flex flex-col lg:flex-row gap-8">
                <!-- Job Details Section -->
                <div class="lg:w-2/3">
                    <!-- Back Button -->
                    <a href="ListJobCustomer" class="inline-flex items-center text-red-600 mb-6 hover:underline">
                        <i class="fas fa-arrow-left mr-2"></i> Quay lại danh sách
                    </a>

                    <!-- Job Header -->
                    <div class="bg-white rounded-xl shadow-sm p-6 mb-6">
                        <div class="flex flex-col md:flex-row md:items-center md:justify-between">
                            <div>
                                <h1 class="text-2xl font-bold text-gray-800 mb-2">Lập Trình Viên Frontend (ReactJS)</h1>
                                <div class="flex items-center text-gray-600 mb-4">
                                    <i class="fas fa-building mr-2"></i>
                                    <span class="mr-4">Công ty ABC Technology</span>
                                    <i class="fas fa-map-marker-alt mr-2"></i>
                                    <span>Hà Nội</span>
                                </div>
                            </div>
                            <div class="flex items-center space-x-3">
                                
                                <button class="w-10 h-10 flex items-center justify-center border border-gray-300 rounded-md hover:bg-gray-100">
                                    <i class="far fa-heart text-gray-500"></i>
                                </button>
                            </div>
                        </div>

                        
                    </div>

                    <!-- Job Description -->
                    <div class="bg-white rounded-xl shadow-sm p-6 mb-6 job-description">
                        <h2 class="text-xl font-bold text-gray-800 mb-4">Mô tả công việc</h2>
                        <div class="prose max-w-none text-gray-700">

                            <c:forEach items="${jobtext}" var="jt" >
                                <h3 class="font-bold mt-6 mb-3">${jt.getTexttitle()}</h3>
                                <ul>
                                    <c:forEach items="${jt.contentList}" var="item">
                                        <li>${item}</li>
                                        </c:forEach>
                                </ul>
                            </c:forEach>
                        </div>
                    </div>


                </div>

                <!-- Application Form -->
                <div class="lg:w-1/3">
                    <div class="bg-white rounded-xl shadow-sm p-6 sticky top-6">
                        <h2 class="text-xl font-bold text-gray-800 mb-6">Ứng tuyển vị trí này</h2>

                        <form method="post" action="AddJobCustomer" >
                            <div class="mb-4">
                                <label for="fullname" class="block text-gray-700 font-medium mb-2">Họ và tên <span class="text-red-500">*</span></label>
                                <input type="text" id="fullname" name="fullname" required 
                                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500"
                                       placeholder="Nhập Họ và Tên">
                            </div>

                            <div class="mb-4">
                                <label for="email" class="block text-gray-700 font-medium mb-2">Email <span class="text-red-500">*</span></label>
                                <input type="email" id="email" name="email" required 
                                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       placeholder="Nhập email">
                            </div>

                            <div class="mb-4">
                                <label for="phone" class="block text-gray-700 font-medium mb-2">Số điện thoại <span class="text-red-500">*</span></label>
                                <input type="number"  name="phone" required 
                                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       placeholder="Nhập Số Điện Thoại">
                            </div>

                            <div class="mb-4">

                                <label for="gender" class="block text-gray-700 font-medium mb-2">Giới tính <span class="text-red-500">*</span></label></label>
                                <select id="gender" name="gender"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <c:forEach items="${gender}" var="gd">
                                        <option value="${gd.getId()}">${gd.getName()}</option>
                                    </c:forEach>
                                </select>

                            </div>

                            <div class="mb-4">
                                <label for="linkedin" class="block text-gray-700 font-medium mb-2">Ngày tháng năm sinh <span class="text-red-500">*</span></label></label>
                                <input type="date"  name="dateofbirth" 
                                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                                       >
                            </div>

                            <div class="mb-4">
                                <label for="portfolio" class="block text-gray-700 font-medium mb-2">Địa chỉ hiện tại <span class="text-red-500">*</span></label></label>
                                <input type="text"  name="address" 
                                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                                       placeholder="Nhập địa chỉ hiện tại">
                            </div>

                            <div class="mb-4">
                                <label for="gender" class="block text-gray-700 font-medium mb-2">Quận/Huyện ứng tuyển <span class="text-red-500">*</span></label></label>
                                <select id="gender" name="district"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <c:forEach items="${district}" var="d">
                                        <option value="${d.getId()}">${d.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>


                            <div class="mb-4">
                                <label for="linkedin" class="block text-gray-700 font-medium mb-2">Vui lòng chọn ngày tham gia phỏng vấn(Vui lòng không chọn chứ 7, chủ nhật) <span class="text-red-500">*</span></label></label>
                                <input type="date"  name="interviewdate" 
                                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
                                       >
                            </div>

                            <div class="mb-4">
                                <label for="gender" class="block text-gray-700 font-medium mb-2">Bạn biết thông tin tuyển dụng qua đâu?<span class="text-red-500">*</span></label></label>
                                <select  name="source"
                                         class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <c:forEach items="${source}" var="s">
                                        <option value="${s.getId()}">${s.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>


   

                            <div class="flex items-center mb-4">
                                <input id="agree-terms" type="checkbox" required 
                                       class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500">
                                <label for="agree-terms" class="ml-2 text-sm text-gray-600">
                                    Tôi đồng ý với <a href="#" class="text-red-600 hover:underline">Điều khoản & Chính sách</a>
                                </label>
                            </div>

                            <button type="submit" 
                                    class="w-full bg-red-600 text-white py-3 px-4 rounded-md font-medium hover:bg-red-700 transition duration-300 flex items-center justify-center">
                                <i class="fas fa-paper-plane mr-2 animate-bounce-slow"></i> Gửi đơn ứng tuyển
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </main>

       

        <!-- Footer -->
        <footer class="bg-gray-800 text-white py-12">
            <div class="container mx-auto px-4">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                    <div>
                        <div class="flex items-center mb-4">
                            <div class="w-10 h-10 bg-red-600 rounded-full flex items-center justify-center text-white font-bold mr-3">JD</div>
                            <h3 class="text-xl font-bold">JobDream</h3>
                        </div>
                        <p class="text-gray-400 mb-4">Nền tảng kết nối nhà tuyển dụng và ứng viên hàng đầu Việt Nam.</p>
                        <div class="flex space-x-4">
                            <a href="#" class="text-gray-400 hover:text-white"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="text-gray-400 hover:text-white"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-gray-400 hover:text-white"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="text-gray-400 hover:text-white"><i class="fab fa-instagram"></i></a>
                        </div>
                    </div>

                    <div>
                        <h4 class="text-lg font-bold mb-4">Về chúng tôi</h4>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-400 hover:text-white">Giới thiệu</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Đội ngũ</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Tin tức</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Tuyển dụng</a></li>
                        </ul>
                    </div>

                    <div>
                        <h4 class="text-lg font-bold mb-4">Dành cho ứng viên</h4>
                        <ul class="space-y-2">
                            <li><a href="#" class="text-gray-400 hover:text-white">Tìm việc làm</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Tạo hồ sơ</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Blog nghề nghiệp</a></li>
                            <li><a href="#" class="text-gray-400 hover:text-white">Câu hỏi thường gặp</a></li>
                        </ul>
                    </div>

                    <div>
                        <h4 class="text-lg font-bold mb-4">Liên hệ</h4>
                        <ul class="space-y-2 text-gray-400">
                            <li class="flex items-start">
                                <i class="fas fa-map-marker-alt mt-1 mr-3"></i>
                                <span>Tầng 5, Tòa nhà FPT, 17 Duy Tân, Cầu Giấy, Hà Nội</span>
                            </li>
                            <li class="flex items-center">
                                <i class="fas fa-phone-alt mr-3"></i>
                                <span>(+84) 24 1234 5678</span>
                            </li>
                            <li class="flex items-center">
                                <i class="fas fa-envelope mr-3"></i>
                                <span>contact@jobdream.vn</span>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="border-t border-gray-700 mt-10 pt-6 flex flex-col md:flex-row justify-between items-center">
                    <p class="text-gray-400 mb-4 md:mb-0">© 2023 JobDream. All rights reserved.</p>
                    <div class="flex space-x-6">
                        <a href="#" class="text-gray-400 hover:text-white">Điều khoản</a>
                        <a href="#" class="text-gray-400 hover:text-white">Bảo mật</a>
                        <a href="#" class="text-gray-400 hover:text-white">Cookies</a>
                    </div>
                </div>
            </div>
        </footer>

        <script>
            // Form submission handling
            document.getElementById('applicationForm').addEventListener('submit', function (e) {
                e.preventDefault();

                // Get form values
                const fullname = document.getElementById('fullname').value;
                const email = document.getElementById('email').value;

                // Simple validation
                if (!fullname || !email) {
                    alert('Vui lòng điền đầy đủ thông tin bắt buộc');
                    return;
                }

                // In a real app, you would send this data to your server
                console.log('Form submitted:', {
                    fullname,
                    email,
                    phone: document.getElementById('phone').value,
                    linkedin: document.getElementById('linkedin').value,
                    portfolio: document.getElementById('portfolio').value,
                    message: document.getElementById('message').value
                });

                // Show success message
                alert(`Cảm ơn ${fullname} đã ứng tuyển! Chúng tôi sẽ liên hệ với bạn qua email ${email} trong thời gian sớm nhất.`);

                // Reset form
                this.reset();
            });

            // File upload display
            const fileInput = document.getElementById('dropzone-file');
            const dropzone = fileInput.parentElement;

            //        fileInput.addEventListener('change', function() {
            //            if (this.files.length > 0) {
            //                const fileName = this.files[0].name;
            //                dropzone.innerHTML = `
            //                    <div class="flex flex-col items-center justify-center pt-5 pb-6">
            //                        <i class="fas fa-file-pdf text-3xl text-red-500 mb-2"></i>
            //                        <p class="text-sm text-gray-700 font-medium"></p>
            //                        <p class="text-xs text-gray-500"> MB</p>
            //                    </div>
            //                `;
            //            }
            //        });
        </script>
    </body>
</html>