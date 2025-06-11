/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.EmployeeDAO;
import dao.NotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Employees;
import model.Notification;

/**
 *
 * @author lmq02
 */
public class EditEmployee extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditStaff at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy id nhân viên muốn sửa
        int id = Integer.parseInt(request.getParameter("id"));

        // Lấy thông tin nhân viên theo id
        EmployeeDAO dao = new EmployeeDAO();
        Employees emp = dao.getEmployeeById(id);

        // Gửi dữ liệu về JSP để hiển thị
        request.setAttribute("employee", emp);
        request.getRequestDispatcher("view/employee-edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Set UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        List<String> errors = new ArrayList<>();

        if (!name.matches("^[a-zA-ZÀ-Ỹà-ỹ]+(\\s[a-zA-ZÀ-Ỹà-ỹ]+)*$")) {
            errors.add("Name is invalid.");
        }
        if (!phone.matches("^0\\d{9}$")) {
            errors.add("Phone number must contain 10 to digits.");
        }
        if (!address.matches("^[a-zA-ZÀ-Ỹà-ỹ]+(\\s[a-zA-ZÀ-Ỹà-ỹ]+)*$")) {
            errors.add("Address is invalid.");
        }

        // Nếu có lỗi quay lại trang form và hiển thị danh sách lỗi
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("name", name);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.getRequestDispatcher("view/employee-edit.jsp").forward(request, response);
            return;
        }

        EmployeeDAO dao = new EmployeeDAO();
        Employees emp = new Employees(id, name, phone, address);

        // Gọi update
        dao.updateEmployeeById(emp);
        
        NotificationDAO notiDAO = new NotificationDAO();
        // Ghi thông báo
        String message = "Admin đã cập nhật thông tin nhân viên " + name + " trong hệ thống.";
        notiDAO.insert(new Notification(message, "Admin", "cập nhật"));

        // Sau khi update, thường nên redirect đến trang danh sách hoặc trang chi tiết
        response.sendRedirect("listEmployee");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
