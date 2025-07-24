/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ShiftDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Shift;

/**
 *
 * @author nguye
 */
@WebServlet(name = "ListShift", urlPatterns = {"/ListShift"})
public class ListShift extends HttpServlet {

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
            out.println("<title>Servlet ListShift</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListShift at " + request.getContextPath() + "</h1>");
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
// 1. Lấy filter từ request
        String keyword = request.getParameter("keyword");
        String fromTime = request.getParameter("fromTime");
        String toTime = request.getParameter("toTime");
        String weekday = request.getParameter("weekday");

        // 2. Phân trang
        String indexPage = request.getParameter("index");
        int currentPage = 1;
        if (indexPage != null) {
            try {
                currentPage = Integer.parseInt(indexPage);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        int pageSize = 3; // Số bản ghi trên mỗi trang

        // 3. Lấy dữ liệu filter và phân trang từ DAO
        ShiftDAO dao = new ShiftDAO();

        int totalShift = dao.getTotalShiftWithFilter(keyword, fromTime, toTime, weekday);
        int endPage = totalShift / pageSize;
        if (totalShift % pageSize != 0) {
            endPage++;
        }

        List<Shift> shiftList = dao.pagingShiftWithFilter(
                keyword, fromTime, toTime, weekday, currentPage, pageSize
        );

        // 4. Truyền dữ liệu cho JSP
        request.setAttribute("shiftList", shiftList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("endPage", endPage);

        // Giữ lại trạng thái filter
        request.setAttribute("param.keyword", keyword);
        request.setAttribute("param.fromTime", fromTime);
        request.setAttribute("param.toTime", toTime);
        request.setAttribute("param.weekday", weekday);

        request.getRequestDispatcher("view/shift-list.jsp").forward(request, response);
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
        processRequest(request, response);
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
