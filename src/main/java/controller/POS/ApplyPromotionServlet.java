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
import model.Cart;
import model.Coupons;

/**
 *
 * @author Admin
 */
public class ApplyPromotionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ApplyPromotionServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplyPromotionServlet at " + request.getContextPath () + "</h1>");
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
        String code = request.getParameter("promotionCode");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        // Kiểm tra giỏ hàng và mã có hợp lệ không
        if (cart == null || cart.getItems().isEmpty() || code == null || code.trim().isEmpty()) {
            session.setAttribute("promotionMessage", "Vui lòng nhập mã và chọn sản phẩm trước.");
            response.sendRedirect("loadProducts");
            return;
        }

        CouponDAO couponDAO = new CouponDAO();
        Coupons coupon = couponDAO.getCouponByCode(code.trim());

        if (coupon == null) {
            session.setAttribute("promotionMessage", "Mã không hợp lệ, đã hết hạn hoặc không còn áp dụng.");
            // Reset nếu trước đó từng có mã
            session.removeAttribute("discountAmount");
            session.removeAttribute("appliedCoupon");
        } else {
            // Áp dụng mức giảm vào session
            session.setAttribute("discountAmount", coupon.getDiscount_amount());
            session.setAttribute("appliedCoupon", coupon.getCoupon_code());
            session.setAttribute("promotionMessage", "Áp dụng mã thành công: -" + coupon.getDiscount_amount() + "đ");
        }

        response.sendRedirect("loadProducts");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
