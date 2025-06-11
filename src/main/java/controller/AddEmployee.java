
package controller;

import dao.EmployeeDAO;
import dao.NotificationDAO;
import model.Employees;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Notification;

public class AddEmployee extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddEmployee</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddEmployee at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/employee-add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        int accountId = -1;
        try {
            accountId = Integer.parseInt(request.getParameter("accountId"));
        } catch (NumberFormatException e) {
            errors.add("Invalid account ID.");
        }

        // Nếu có lỗi quay lại trang form và hiển thị danh sách lỗi
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("name", name);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("accountId", request.getParameter("accountId"));
            request.getRequestDispatcher("view/employee-add.jsp").forward(request, response);
            return;
        }
        
        NotificationDAO notiDAO = new NotificationDAO();
        // Ghi thông báo
        String message = "Admin đã thêm nhân viên " + name + " vào hệ thống.";
        notiDAO.insert(new Notification(message, "Admin", "add"));
        
        EmployeeDAO dao = new EmployeeDAO();
        Employees emp = new Employees(name, phone, address, accountId);
        dao.addEmployee(emp);
        response.sendRedirect("listEmployee");
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
