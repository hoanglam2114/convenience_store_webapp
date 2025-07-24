package controller.POS;

import dao.CouponDAO;
import dao.CustomerDAO;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.List;
import model.Cart;
import model.CartItem;
import model.Coupons;
import model.Order;

public class CheckoutServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("view/pos-home.jsp");
            return;
        }

        try {
            // Lấy thông tin khách hàng
            Integer customerId = (Integer) session.getAttribute("customerId");
            String customerName = (String) session.getAttribute("customerName");
            if (customerId == null || customerName == null) {
                response.sendRedirect("loadProducts?error=missingCustomer");
                return;
            }

            // Lấy nhân viên từ session
            Integer employeeId = (Integer) session.getAttribute("staffId");
            if (employeeId == null) {
                employeeId = 2; // fallback tạm thời
            }

            int paymentMethodId = 1; // tiền mặt
            double totalAmount = cart.getTotalMoney();

            // Lấy coupon áp dụng từ session
            Coupons appliedCoupon = (Coupons) session.getAttribute("appliedCoupon");
            if (appliedCoupon != null) {
                totalAmount -= appliedCoupon.getDiscount_amount();
                if (totalAmount < 0) {
                    totalAmount = 0;
                }
            }

            // Tạo đơn hàng
            OrderDAO orderDAO = new OrderDAO();
            int orderId = orderDAO.createOrder(customerId, totalAmount, cart.getItems(), appliedCoupon, employeeId, paymentMethodId);

            // 4. Gán giỏ hàng trước khi xóa
            request.setAttribute("cartItems", cart.getItems());

            // 5. Xóa session
            session.removeAttribute("cart");
            session.removeAttribute("appliedCoupon");
            session.removeAttribute("appliedCouponCode");
            session.removeAttribute("couponError");

            // 6. Lấy và hiển thị hoá đơn
            Order order = orderDAO.getOrderById(orderId);
            request.setAttribute("order", order);
            request.getRequestDispatcher("view/receipt.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi khi xử lý thanh toán: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
