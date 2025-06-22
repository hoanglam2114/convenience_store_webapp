/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Employees;

public class ListEmployee extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListEmployee</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListEmployee at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String indexPage = request.getParameter("index");
        int currentPage = 1;

        if (indexPage != null) {
            try {
                currentPage = Integer.parseInt(indexPage);
            } catch (NumberFormatException e) {
            }
        }else{
            indexPage = "1";
        }

        int index = Integer.parseInt(indexPage);
        EmployeeDAO dao = new EmployeeDAO();
        int count = dao.getTotalEmployee();
        int endPage = count / 5;
        if (count % 5 != 0) {
            endPage++;
        }
        List<Employees> employeeList = dao.pagingEmployee(index);

        request.setAttribute("employeeList", employeeList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("endPage", endPage);
        request.getRequestDispatcher("view/employee-management.jsp").forward(request, response);
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
