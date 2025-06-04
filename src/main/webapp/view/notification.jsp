<!DOCTYPE html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Notification</title>

        <!-- Sneat CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
        <link rel="stylesheet" href="assets/css/demo.css" />
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

        <%@ page import="java.util.List" %>
        <%@ page import="model.Notification" %>
    </head>

    <body>
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">

                <!-- Sidebar -->
                <%@ include file="/common/site-bar.jsp" %>

                <div class="layout-page">
                    <!-- Navbar -->
                    <nav class="layout-navbar">
                        <!-- Navbar n?u có -->
                    </nav>

                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">

                            <!-- Notification Card -->
                            <%
                                List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
                            %>
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Notifications</h5>
                                </div>
                                <div class="card-body">
                                    <ul class="list-group">
                                        <% if (notifications != null && !notifications.isEmpty()) {
                                            for (Notification n : notifications) { %>
                                        <li class="list-group-item">
                                            <strong><%= n.getActor() %></strong> - <%= n.getMessage() %> <br/>
                                            <small><%= n.getCreatedAt() %></small>
                                        </li>
                                        <% }} else { %>
                                        <li class="list-group-item">No notifications.</li>
                                            <% } %>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Footer -->
                        <footer class="content-footer footer bg-footer-theme">
                            <div class="container-xxl d-flex justify-content-between py-2 flex-md-row flex-column">
                                <div class="mb-2 mb-md-0">© 2025, Sneat Admin</div>
                            </div>
                        </footer>
                    </div>
                </div>

            </div>
        </div>

        <!-- Core JS -->
        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/libs/popper/popper.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="assets/js/main.js"></script>
    </body>

</html>
