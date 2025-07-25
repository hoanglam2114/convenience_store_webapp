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
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <!-- FontAwesome (nếu cần) -->
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

    <body class="bg-gray-50 font-sans">

        <header class="bg-white shadow-sm">
            <div class="container mx-auto px-4 py-4 flex justify-between items-center">
                <div class="flex items-center">

                    <h1 class="text-xl font-bold text-gray-800">Convema</h1>
                </div>
                <nav class="hidden md:flex space-x-8">
                    <a href="ListJobCustomer" class="text-gray-600 hover:text-indigo-600">Trang chủ</a>
                    <a href="#" class="text-indigo-600 font-medium">Việc làm</a>
                    <a href="#" class="text-gray-600 hover:text-indigo-600">Blog</a>
                </nav>
                <div class="flex items-center space-x-4">
                    <button class="md:hidden text-gray-600">
                        <i class="fas fa-bars text-xl"></i>
                    </button>

                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="container mx-auto px-4 py-8">
            <div class="flex flex-col lg:flex-row gap-8">
                <!-- Job Details Section -->
                <div class="lg:w-2/3">
                    <!-- Back Button -->
                    <a href="ListJobCustomer" class="inline-flex items-center text-indigo-600 mb-6 hover:underline">
                        <i class="fas fa-arrow-left mr-2"></i> Quay lại danh sách
                    </a>



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
                                       class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent"
                                       value="${param.fullname != null ? param.fullname : ''}"
                                       placeholder="Nhập Họ và Tên"
                                       />                                  
                                <c:if test="${not empty errorName}">
                                    <p class="text-red-500 text-sm mt-1">${errorName}</p>
                                </c:if>
                            </div>

                            <div class="mb-4">
                                <label for="email" class="block text-gray-700 font-medium mb-2">Email <span class="text-red-500">*</span></label>
                                <input type="email" id="email" name="email" required 
                                       class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent"
                                       value="${param.email != null ? param.email : ''}"
                                       placeholder="Nhập email"
                                       />
                                <c:if test="${not empty errorEmail}">
                                    <p class="text-red-500 text-sm mt-1">${errorEmail}</p>
                                </c:if>
                            </div>

                            <div class="mb-4">
                                <label for="phone" class="block text-gray-700 font-medium mb-2">Số điện thoại <span class="text-red-500">*</span></label>
                                <input type="number"  name="phone" required 
                                       class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent"
                                       value="${param.phone != null ? param.phone : ''}"
                                       placeholder="Nhập Số Điện Thoại"/>
                                <c:if test="${not empty errorPhone}">
                                    <p class="text-red-500 text-sm mt-1">${errorPhone}</p>
                                </c:if>
                            </div>

                            <div class="mb-4">

                                <label for="gender" class="block text-gray-700 font-medium mb-2">Giới tính <span class="text-red-500">*</span></label></label>
                                <select id="gender" name="gender"
                                        class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent">
                                    <c:forEach items="${gender}" var="gd">
                                        <option value="${gd.getId()}">${gd.getName()}</option>
                                    </c:forEach>
                                </select>

                            </div>

                            <div class="mb-4">
                                <label for="linkedin" class="block text-gray-700 font-medium mb-2">Ngày tháng năm sinh <span class="text-red-500">*</span></label></label>
                                <input type="date"  name="dateofbirth" required
                                       class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent"
                                       value="${param.dateofbirth != null ? param.dateofbirth : ''}"
                                       />
                                <c:if test="${not empty errorDOB}">
                                    <p class="text-red-500 text-sm mt-1">${errorDOB}</p>
                                </c:if>
                            </div>

                            <div class="mb-4">
                                <label for="portfolio" class="block text-gray-700 font-medium mb-2">Địa chỉ hiện tại <span class="text-red-500">*</span></label></label>
                                <input type="text"  name="address" required
                                       class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent" 
                                       value="${param.address != null ? param.address : ''}"
                                       placeholder="Nhập địa chỉ hiện tại"
                                       />
                                <c:if test="${not empty errorAddress}">
                                    <p class="text-red-500 text-sm mt-1">${errorAddress}</p>
                                </c:if>
                            </div>

                            <div class="mb-4">
                                <label for="gender" class="block text-gray-700 font-medium mb-2">Quận/Huyện ứng tuyển <span class="text-red-500">*</span></label></label>
                                <select id="gender" name="district"
                                        class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent">
                                    <c:forEach items="${district}" var="d">
                                        <option value="${d.getId()}">${d.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>


                            <div class="mb-4">
                                <label for="linkedin" class="block text-gray-700 font-medium mb-2">Vui lòng chọn ngày tham gia phỏng vấn(Vui lòng không chọn chứ 7, chủ nhật) <span class="text-red-500">*</span></label></label>
                                <input type="date"  name="interviewdate" required
                                       class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent" 
                                       value="${param.interviewdate != null ? param.interviewdate : ''}"
                                       />
                                <c:if test="${not empty errorInterviewDate}">
                                    <p class="text-red-500 text-sm mt-1">${errorInterviewDate}</p>
                                </c:if>
                            </div>

                            <div class="mb-4">
                                <label for="gender" class="block text-gray-700 font-medium mb-2">Bạn biết thông tin tuyển dụng qua đâu?<span class="text-red-500">*</span></label></label>
                                <select  name="source"
                                         class="w-full border border-gray-200 rounded-md py-2 px-3 focus:outline-none focus:ring-2 focus:ring-[#696cff] focus:border-transparent">
                                    <c:forEach items="${source}" var="s">
                                        <option value="${s.getId()}">${s.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>




                            <div class="flex items-center mb-4">
                                <input id="agree-terms" type="checkbox" required 
                                       class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500">
                                <label for="agree-terms" class="ml-2 text-sm text-gray-600">
                                    Tôi đồng ý với <a required href="#" class="text-indigo-600 hover:underline">Điều khoản & Chính sách</a>
                                </label>
                            </div>

                            <button type="submit" 
                                    class="w-full bg-indigo-600 text-white py-3 px-4 rounded-md font-medium hover:bg-indigo-700 transition duration-300 flex items-center justify-center">
                                <i class="fas fa-paper-plane mr-2 animate-bounce-slow"></i> Gửi đơn ứng tuyển
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </main>


        <footer style="background-color: #2c3e50;" class="text-white py-5 mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-12 customer-footer">
                        <jsp:include page="/common/customer-footer.jsp" />
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