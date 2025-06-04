/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.EmployeeDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Employees;

/**
 *
 * @author lmq02
 */
public class SearchEmployee extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchEmployee</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchEmployee at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("listEmployee");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("employeeSearch");
        List<Employees> employeeList = null;
        EmployeeDAO dao = new EmployeeDAO();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            try {
                employeeList = dao.searchEmployee(keyword);
            } catch (SQLException ex) {
                Logger.getLogger(SearchEmployee.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            employeeList = dao.getAllEmployee(); // lấy toàn bộ nếu không tìm kiếm
        }

        request.setAttribute("employeeList", employeeList);
        request.getRequestDispatcher("view/employee-management.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
