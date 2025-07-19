<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html
        lang="en"
        class="light-style layout-menu-fixed"
        dir="ltr"
        data-theme="theme-default"
        data-assets-path="/assets/"
        data-template="vertical-menu-template-free"
>
<head>
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>Dashboard - Home</title>

    <meta name="description" content=""/>

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/fonts/boxicons.css"/>

    <!-- Core CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/core.css"
          class="template-customizer-core-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/theme-default.css"
          class="template-customizer-theme-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo.css"/>

    <!-- Vendors CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/libs/apex-charts/apex-charts.css"/>

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="${pageContext.request.contextPath}/assets/vendor/js/helpers.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
</head>
<body>

<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">

        <!-- Site Bar -->
        <%@ include file="/common/site-bar.jsp" %>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar -->
            <%@ include file="/common/nav-bar.jsp" %>
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->

                <div class="container-xxl flex-grow-1 container-p-y">
                    <!-- Welcome Section -->
                    <div class="row">
                        <div class="col-lg-12 mb-4 order-0">
                            <div class="card">
                                <div class="d-flex align-items-end row">
                                    <div class="col-sm-7">
                                        <div class="card-body">
                                            <h5 class="card-title text-primary">Welcome to Convema! </h5>
                                            <p class="mb-4">
                                                Here's your business overview for today. Check out your key metrics and recent activities.
                                            </p>
                                        </div>
                                    </div>
                                    <div class="col-sm-5 text-center text-sm-left">
                                        <div class="card-body pb-0 px-0 px-md-4">
                                            <img
                                                    src="${pageContext.request.contextPath}/assets/img/illustrations/man-with-laptop-light.png"
                                                    height="140"
                                                    alt="View Badge User"
                                                    data-app-dark-img="illustrations/man-with-laptop-dark.png"
                                                    data-app-light-img="illustrations/man-with-laptop-light.png"
                                            />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- KPI Cards Row -->
                    <div class="row">
                        <!-- Products Card -->
                        <div class="col-lg-3 col-md-6 col-6 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="card-title d-flex align-items-start justify-content-between">
                                        <div class="avatar flex-shrink-0">
                                            <i class='bx bx-package text-success' style="font-size: 2rem;"></i>
                                        </div>
                                    </div>
                                    <span class="fw-semibold d-block mb-1">Products in Stock</span>
                                    <h3 class="card-title mb-2">245</h3>
                                    <small class="text-success fw-semibold"><i class='bx bx-up-arrow-alt'></i> Total Items</small>
                                </div>
                            </div>
                        </div>

                        <!-- Orders Card -->
                        <div class="col-lg-3 col-md-6 col-6 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="card-title d-flex align-items-start justify-content-between">
                                        <div class="avatar flex-shrink-0">
                                            <i class='bx bx-shopping-bag text-warning' style="font-size: 2rem;"></i>
                                        </div>
                                    </div>
                                    <span class="fw-semibold d-block mb-1">Total Orders</span>
                                    <h3 class="card-title mb-2">0</h3>
                                    <small class="text-warning fw-semibold"><i class='bx bx-receipt'></i> All Time</small>
                                </div>
                            </div>
                        </div>

                        <!-- Customers Card -->
                        <div class="col-lg-3 col-md-6 col-6 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="card-title d-flex align-items-start justify-content-between">
                                        <div class="avatar flex-shrink-0">
                                            <i class='bx bx-user text-info' style="font-size: 2rem;"></i>
                                        </div>
                                    </div>
                                    <span class="fw-semibold d-block mb-1">Total Customers</span>
                                    <h3 class="card-title mb-2">156</h3>
                                    <small class="text-info fw-semibold"><i class='bx bx-user-plus'></i> Registered</small>
                                </div>
                            </div>
                        </div>

                        <!-- Employees Card -->
                        <div class="col-lg-3 col-md-6 col-6 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="card-title d-flex align-items-start justify-content-between">
                                        <div class="avatar flex-shrink-0">
                                            <i class='bx bx-group text-primary' style="font-size: 2rem;"></i>
                                        </div>
                                    </div>
                                    <span class="fw-semibold d-block mb-1">Total Employees</span>
                                    <h3 class="card-title mb-2">12</h3>
                                    <small class="text-primary fw-semibold"><i class='bx bx-id-card'></i> Staff Members</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Products & Notifications Row -->
                    <div class="row">
                        <!-- Recent Products -->
                        <div class="col-md-8 mb-4">
                            <div class="card">
                                <div class="card-header d-flex align-items-center justify-content-between">
                                    <h5 class="card-title m-0 me-2">Recent Products</h5>
                                    <a href="${pageContext.request.contextPath}/products" class="btn btn-sm btn-outline-primary">View All</a>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-borderless">
                                            <thead>
                                            <tr>
                                                <th>Product Name</th>
                                                <th>Price</th>
                                                <th>Stock</th>
                                                <th>Added Date</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="avatar avatar-sm me-3">
                                                            <i class='bx bx-package'></i>
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-0">Hao Hao Instant Noodles</h6>
                                                            <small class="text-muted">ID: P001</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>$2.50</td>
                                                <td>
                                                    <span class="badge bg-danger">8</span>
                                                </td>
                                                <td>2025-07-18</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="avatar avatar-sm me-3">
                                                            <i class='bx bx-package'></i>
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-0">Oreo Cookies</h6>
                                                            <small class="text-muted">ID: P002</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>$3.75</td>
                                                <td>
                                                    <span class="badge bg-danger">5</span>
                                                </td>
                                                <td>2025-07-17</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="avatar avatar-sm me-3">
                                                            <i class='bx bx-package'></i>
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-0">Coca Cola 500ml</h6>
                                                            <small class="text-muted">ID: P003</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>$1.25</td>
                                                <td>
                                                    <span class="badge bg-success">45</span>
                                                </td>
                                                <td>2025-07-16</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="avatar avatar-sm me-3">
                                                            <i class='bx bx-package'></i>
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-0">Pringles Original</h6>
                                                            <small class="text-muted">ID: P004</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>$4.20</td>
                                                <td>
                                                    <span class="badge bg-success">23</span>
                                                </td>
                                                <td>2025-07-15</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="avatar avatar-sm me-3">
                                                            <i class='bx bx-package'></i>
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-0">Green Tea Matcha</h6>
                                                            <small class="text-muted">ID: P005</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>$5.60</td>
                                                <td>
                                                    <span class="badge bg-success">18</span>
                                                </td>
                                                <td>2025-07-14</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Notifications & Alerts -->
                        <div class="col-md-4 mb-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title m-0">Notifications</h5>
                                </div>
                                <div class="card-body">
                                    <!-- Promotion Alert -->
                                    <div class="alert alert-info alert-dismissible" role="alert">
                                        <i class='bx bx-gift'></i>
                                        <span class="fw-semibold">Summer Promotion 2025!</span><br>
                                        <small>Get 20% off on all products. Limited time offer!</small>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>

                                    <!-- Low Stock Alert -->
                                    <div class="alert alert-warning alert-dismissible" role="alert">
                                        <i class='bx bx-error'></i>
                                        <span class="fw-semibold">Low Stock Alert!</span><br>
                                        <small>Inventory under 10 products: Hao Hao noodles, Oreo cookies, Pepsi 330ml...</small>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>

                                    <!-- No Orders Alert -->
                                    <div class="alert alert-secondary" role="alert">
                                        <i class='bx bx-shopping-bag'></i>
                                        <span class="fw-semibold">No orders yet!</span><br>
                                        <small class="d-block mb-2">Ready to get your first order?</small>
                                        <a href="${pageContext.request.contextPath}/orders/create" class="btn btn-sm btn-primary">Create Order</a>
                                    </div>

                                    <!-- System Update Notice -->
                                    <div class="alert alert-success alert-dismissible" role="alert">
                                        <i class='bx bx-check-circle'></i>
                                        <span class="fw-semibold">System Updated!</span><br>
                                        <small>Dashboard has been updated with new features and improvements.</small>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Actions -->
                            <div class="card mt-3">
                                <div class="card-header">
                                    <h5 class="card-title m-0">Quick Actions</h5>
                                </div>
                                <div class="card-body">
                                    <div class="d-grid gap-2">
                                        <a href="${pageContext.request.contextPath}/products/add" class="btn btn-primary">
                                            <i class='bx bx-plus'></i> Add Product
                                        </a>
                                        <a href="${pageContext.request.contextPath}/customers/add" class="btn btn-info">
                                            <i class='bx bx-user-plus'></i> Add Customer
                                        </a>
                                        <a href="${pageContext.request.contextPath}/orders/create" class="btn btn-warning">
                                            <i class='bx bx-shopping-bag'></i> Create Order
                                        </a>
                                        <a href="${pageContext.request.contextPath}/reports" class="btn btn-success">
                                            <i class='bx bx-bar-chart'></i> View Reports
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- / Content -->

                <!-- Footer -->
                <footer class="content-footer footer bg-footer-theme">
                    <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                        <div class="mb-2 mb-md-0">
                            ©
                            <script>
                                document.write(new Date().getFullYear());
                            </script>
                            , made with ❤️ by
                            <a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
                        </div>
                        <div>
                            <a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a>
                            <a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More
                                Themes</a>

                            <a
                                    href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/"
                                    target="_blank"
                                    class="footer-link me-4"
                            >Documentation</a
                            >

                            <a
                                    href="https://github.com/themeselection/sneat-html-admin-template-free/issues"
                                    target="_blank"
                                    class="footer-link me-4"
                            >Support</a
                            >
                        </div>
                    </div>
                </footer>
                <!-- / Footer -->

                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
</div>
<!-- / Layout wrapper -->

<!-- Core JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/popper/popper.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>
<!-- endbuild -->
<!-- Vendors JS -->
<script src="${pageContext.request.contextPath}/assets/vendor/libs/apex-charts/apexcharts.js"></script>
<!-- Main JS -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<!-- Page JS -->
<script src="${pageContext.request.contextPath}/assets/js/dashboards-analytics.js"></script>
<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>