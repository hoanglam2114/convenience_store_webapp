/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;

/**
 *
 * @author Admin
 */
public class EditOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditOrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditOrderServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            OrderDAO orderDAO = new OrderDAO();
            Order order = orderDAO.getOrderById(orderId);

            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đơn hàng");
                return;
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("view/order-edit.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi xử lý đơn hàng");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("status");

            // Gọi lại order từ DB 
            OrderDAO orderDAO = new OrderDAO();
            Order order = orderDAO.getOrderById(orderId);
            if (order == null) {
                request.setAttribute("error", "Không tìm thấy đơn hàng.");
                request.getRequestDispatcher("view/order-edit.jsp").forward(request, response);
                return;
            }

            order.setOrderStatus(newStatus); // Cập nhật status
            boolean success = orderDAO.updateOrderStatus(order);

            if (success) {
                response.sendRedirect("orderDetail?orderId=" + orderId);
            } else {
                request.setAttribute("error", "Cập nhật thất bại.");
                request.setAttribute("order", order);
                request.getRequestDispatcher("view/order-edit.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý cập nhật trạng thái.");
            request.getRequestDispatcher("view/order-edit.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
