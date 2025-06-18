/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.POS;

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
import model.Order;

/**
 *
 * @author Admin
 */
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
        int employeeId = 1; // tạm thời cố định
        int paymentMethodId = 1; // 1 = tiền mặt, bạn gán theo enum hoặc bảng PaymentMethod nếu có

        try {
            int orderId = orderDAO.createOrder(customerId, totalAmount, cart.getItems(), null, employeeId, paymentMethodId);

            session.removeAttribute("cart");

            request.setAttribute("orderId", orderId);
            request.setAttribute("order", orderDAO.getOrderById(orderId));
            request.setAttribute("cartItems", cart.getItems());

            request.getRequestDispatcher("/view/receipt.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi xử lý đơn hàng");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
