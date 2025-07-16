/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PromotionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author admin
 */
public class AddPromotionServlet extends HttpServlet {

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
            out.println("<title>Servlet AddPromotionServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPromotionServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        PromotionDAO pd = new PromotionDAO();
        List<String> status = pd.getStatuses();
        session.setAttribute("statuses", status);
        request.getRequestDispatcher("/view/add-promotion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String code = request.getParameter("code").trim();
        String description = request.getParameter("description").trim();
        Double discount = Double.valueOf(request.getParameter("discountPercentage"));
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        String status = request.getParameter("status");
        PromotionDAO promotionDAO = new PromotionDAO();

        LocalDate currentDate = LocalDate.now();

        boolean hasError = false;

        // Validate mã khuyến mãi
        if (code.startsWith(" ") || code.length() > 40 || !code.matches("^[\\p{L}0-9 ]+$")) {
            request.setAttribute("errorCode", "Mã khuyển mãi không hợp lệ. Không bắt đầu bằng dấu cách, không vượt quá 40 ký tự và không chứa ký tự đặc biệt.");
            hasError = true;
        }

        if (description.startsWith(" ") || description.length() > 70 || !description.matches("^[\\p{L}0-9 ]+$")) {
            request.setAttribute("errorDes", "Miêu tả không hợp lệ. Không bắt đầu bằng dấu cách, không vượt quá 40 ký tự và không chứa ký tự đặc biệt.");
            hasError = true;
        }

        // Trả về nếu có lỗi
        if (hasError) {
            request.getRequestDispatcher("/view/add-promotion.jsp").forward(request, response);
            return;
        }

        if (endDate.before(startDate)) {
            request.setAttribute("errorMessage", "Ngày kết thúc phải sau ngày bắt đầu.");
            request.getRequestDispatcher("/view/add-promotion.jsp").forward(request, response);
        } else if (endDate.before(Date.valueOf(currentDate))) {
            request.setAttribute("errorMessage", "Ngày kết thúc phải sau ngày hiện tại.");
            request.getRequestDispatcher("/view/add-promotion.jsp").forward(request, response);
        } else {
            promotionDAO.createPromotion(code, description, startDate, endDate, discount, status);
            response.sendRedirect("PromotionManage");
        }
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
