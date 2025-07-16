/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.CouponDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.List;
import model.Coupons;

/**
 *
 * @author nguye
 */
@WebServlet(name="CouponUpdateServlet", urlPatterns={"/couponUpdate"})
public class CouponUpdateServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet CouponUpdateServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CouponUpdateServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        CouponDAO couponDAO = new CouponDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        Coupons c = couponDAO.getCouponById(id);
        List<String> statuses = couponDAO.getStatuses();
        request.setAttribute("coupon", c);
        request.setAttribute("statuses", statuses);
        request.getRequestDispatcher("view/coupon-update.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       int id = Integer.parseInt(request.getParameter("couponId"));
        String code = request.getParameter("code");
        Double discount = Double.valueOf(request.getParameter("discountPercentage"));
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        String status = request.getParameter("status");
        CouponDAO couponDAO = new CouponDAO();
        if (couponDAO.isCouponCodeExistForUpdate(code, id)) {
        List<String> statuses = couponDAO.getStatuses();

        // GIỮ LẠI DỮ LIỆU ĐÃ NHẬP
        request.setAttribute("input_id", id);
        request.setAttribute("input_code", code);
        request.setAttribute("input_discount", discount);
        request.setAttribute("input_startDate", startDate.toString());
        request.setAttribute("input_endDate", endDate.toString());
        request.setAttribute("input_status", status);

        request.setAttribute("statuses", statuses);
        request.setAttribute("error", "Mã coupon đã tồn tại!");

        // forward lại trang update, giữ dữ liệu đã nhập
        request.getRequestDispatcher("view/coupon-update.jsp").forward(request, response);
        return;
    }
        couponDAO.updateCoupon(code, discount, startDate, endDate, status, id);
        response.sendRedirect("couponManage");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
