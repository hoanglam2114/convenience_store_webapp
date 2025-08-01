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
import model.Notification;

/**
 *
 * @author lmq02
 */
public class DeleteEmployee extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteEmployee</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteEmployee at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            EmployeeDAO dao = new EmployeeDAO();

            dao.deleteEmployeeById(id);
            
            NotificationDAO notiDAO = new NotificationDAO();
            // Ghi thông báo
            String message = "Admin đã xoá nhân viên có ID: " + id + " khỏi hệ thống.";
            notiDAO.insert(new Notification(message, "Admin", "xoá"));

            // Chuyển hướng lại danh sách nhân viên
            response.sendRedirect("listEmployee");

        } catch (Exception e) {
            e.printStackTrace();
        }
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
