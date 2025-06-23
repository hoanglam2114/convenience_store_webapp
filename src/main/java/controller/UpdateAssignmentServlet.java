/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.EmployeeDAO;
import dao.EmployeeStoreAssignmentDAO;
import dao.ShopDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.EmployeeWithRole;
import model.Shop;

/**
 *
 * @author nguye
 */


public class UpdateAssignmentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateAssignmentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAssignmentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int employeeId = Integer.parseInt(request.getParameter("employeeId"));
        int shopId = Integer.parseInt(request.getParameter("shopId"));

        EmployeeDAO eDAO = new EmployeeDAO();
        ShopDAO sDAO = new ShopDAO();

        request.setAttribute("employeeId", employeeId);
        request.setAttribute("shopId", shopId);
        request.setAttribute("employeeList", eDAO.getAllEmployeesWithRoles());
        request.setAttribute("shopList", sDAO.getAll());

        request.getRequestDispatcher("view/updateAssignment.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String oldEmpRaw = request.getParameter("oldEmployeeId");
            String oldShopRaw = request.getParameter("oldShopId");
            String newEmpRaw = request.getParameter("newEmployeeId");
            String newShopRaw = request.getParameter("newShopId");

            if (oldEmpRaw == null || oldShopRaw == null || newEmpRaw == null || newShopRaw == null
                    || oldEmpRaw.isEmpty() || oldShopRaw.isEmpty() || newEmpRaw.isEmpty() || newShopRaw.isEmpty()) {
                request.setAttribute("error", "Thiếu dữ liệu. Vui lòng kiểm tra lại.");
                request.getRequestDispatcher("AssignEmployeeServlet").forward(request, response);
                return;
            }

            int oldEmpId = Integer.parseInt(oldEmpRaw);
            int oldShopId = Integer.parseInt(oldShopRaw);
            int newEmpId = Integer.parseInt(newEmpRaw);
            int newShopId = Integer.parseInt(newShopRaw);

            EmployeeStoreAssignmentDAO dao = new EmployeeStoreAssignmentDAO();
            boolean success = dao.updateAssignment(oldEmpId, oldShopId, newEmpId, newShopId);

            if (success) {
                request.setAttribute("message", "Cập nhật thành công.");
            } else {
                request.setAttribute("error", "Cập nhật thất bại.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ.");
        }

//        request.getRequestDispatcher("AssignEmployeeServlet").forward(request, response);
        response.sendRedirect("AssignEmployeeServlet");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}


