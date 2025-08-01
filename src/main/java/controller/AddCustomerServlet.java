/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import dao.NotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Customers;
import model.Notification;

/**
 *
 * @author Admin
 */
public class AddCustomerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddCustomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCustomerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/customer-add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String pointRaw = request.getParameter("point");
        String typeIdRaw = request.getParameter("typeId");
        String gender = "";
        String avatarUrl = "";
        List<String> errors = new ArrayList<>();

        int typeId = -1;
        int point = -1;

        // Validate empty fields
        if (!name.matches("^[a-zA-ZÀ-Ỹà-ỹ]+(\\s[a-zA-ZÀ-Ỹà-ỹ]+)*$")) {
            errors.add("Tên không hợp lệ.");
        }
        if (!pointRaw.matches("^[0-9]+$")) {
            errors.add("Điểm không hợp lệ.");
        }
        if (!typeIdRaw.matches("^[0-9]+$")) {
            errors.add("ID không hợp lệ.");
        }

        // Validate phone format
        if (!phone.matches("^0\\d{9}$")) {
            errors.add("Số điện thoại cần bao gồm 10 chữ số.");
        }

        // Validate point is an integer
        try {
            point = Integer.parseInt(pointRaw);
            if (point < 0) {
                errors.add("Điểm phải lớn hơn 0.");
            }
        } catch (NumberFormatException e) {
            errors.add("Điểm không hợp lệ.");
        }

        // Validate typeId is an integer
        try {
            typeId = Integer.parseInt(typeIdRaw);
            if (typeId <= 0) {
                errors.add("Type ID phải lớn hơn 0.");
            }
        } catch (NumberFormatException e) {
            errors.add("Type ID không hợp lệ.");
        }
        
        // Nếu có lỗi quay lại trang form và hiển thị danh sách lỗi
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("name", name);
            request.setAttribute("phone", phone);
            request.setAttribute("point", point);
            request.setAttribute("typeId", request.getParameter("typeId"));
            request.getRequestDispatcher("view/customer-add.jsp").forward(request, response);
            return;
        }
        
        NotificationDAO notiDAO = new NotificationDAO();
        // Ghi thông báo
        String message = "Admin đã thêm khách hàng " + name + " vào hệ thống.";
        notiDAO.insert(new Notification(message, "Admin", "thêm"));
        
        CustomerDAO dao = new CustomerDAO();
        Customers customer = new Customers(name, phone, point, typeId, gender, avatarUrl);
        dao.addCustomer(customer);
        response.sendRedirect("listCustomer");
    }
        @Override
        public String getServletInfo() {
            return "Short description";
        }
}
