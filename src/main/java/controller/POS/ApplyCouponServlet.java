/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.POS;

import dao.CouponDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Coupons;

/**
 *
 * @author Admin
 */
public class ApplyCouponServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ApplyCouponServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplyCouponServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String couponCode = request.getParameter("couponCode");
        HttpSession session = request.getSession();

        // Xóa coupon cũ trước nếu có
        session.removeAttribute("appliedCoupon");
        session.removeAttribute("appliedCouponCode");
        session.removeAttribute("couponError");

        if (couponCode == null || couponCode.trim().isEmpty()) {
            session.setAttribute("couponError", "Vui lòng nhập mã giảm giá.");
            response.sendRedirect("view/pos-home.jsp");
            return;
        }

        CouponDAO couponDAO = new CouponDAO();
        Coupons coupon = couponDAO.getCouponByCode(couponCode.trim());

        Integer customerId = (Integer) session.getAttribute("customerId");

        if (coupon == null) {
            session.setAttribute("couponError", "Mã giảm giá không hợp lệ hoặc đã hết hạn.");
        } else {
            try {
                boolean eligible = couponDAO.isCustomerEligibleForCoupon(customerId, coupon.getCoupon_id());
                if (eligible) {
                    session.setAttribute("appliedCoupon", coupon);
                    session.setAttribute("appliedCouponCode", coupon.getCoupon_code());
                } else {
                    session.setAttribute("couponError", "Khách hàng đã sử dụng mã này rồi.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("couponError", "Có lỗi xảy ra khi kiểm tra mã.");
            }
        }

        // Quay lại màn hình POS
        response.sendRedirect("loadProducts");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
