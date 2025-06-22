/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.POS;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Order;

public class VNPayReturnServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VNPayReturnServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VNPayReturnServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String responseCode = request.getParameter("vnp_ResponseCode");
        String orderIdStr = request.getParameter("vnp_TxnRef");
        String amountStr = request.getParameter("vnp_Amount");

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        Object customerIdObj = session.getAttribute("customerId");
        Object customerNameObj = session.getAttribute("customerName");

        if (orderIdStr == null || responseCode == null || cart == null
                || customerIdObj == null || customerNameObj == null) {
            response.sendRedirect("view/pos-home.jsp");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);
        int customerId = (Integer) customerIdObj;
        String customerName = (String) customerNameObj;

        try {
            OrderDAO orderDAO = new OrderDAO();

            if ("00".equals(responseCode)) {
                // ✅ Thanh toán thành công

                // 1. Cập nhật trạng thái đơn
                Order order = new Order();
                order.setOrderId(orderId);
                order.setOrderStatus("PAID");
                order.setOrderTotalAmount((int) cart.getTotalMoney());
                orderDAO.updateOrder(order);

                // 2. Ghi chi tiết đơn hàng + cập nhật kho
                orderDAO.processOrderDetails(orderId, cart.getItems());

                // 3. Cập nhật điểm thưởng khách hàng
                orderDAO.updateCustomerPoints(customerId, 1);

                // 4. Reset giỏ hàng và thông tin khách
                session.removeAttribute("cart");
                session.removeAttribute("customerId");
                session.removeAttribute("customerName");
                session.removeAttribute("phone");
                session.removeAttribute("name");

                // 5. Lấy đơn hàng đã cập nhật để hiển thị
                Order updatedOrder = orderDAO.getOrderById(orderId);
                request.setAttribute("order", updatedOrder);
                request.setAttribute("cartItems", cart.getItems());
                request.getRequestDispatcher("view/receipt.jsp").forward(request, response);
            } else {
                // Thanh toán thất bại
                response.sendRedirect("view/pos-home.jsp?error=payment_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi xử lý phản hồi từ VNPay: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Xử lý kết quả trả về từ VNPay";
    }

}
