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
import java.util.List;
import model.Order;

/**
 *
 * @author Admin
 */
public class SearchOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchOrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchOrderServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private String trimParam(String value) {
        return (value != null) ? value.trim() : null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();

        // Lấy các tham số từ form
        String keyword = trimParam(request.getParameter("keyword"));
        String status = trimParam(request.getParameter("status"));
        String startDate = trimParam(request.getParameter("startDate"));
        String endDate = trimParam(request.getParameter("endDate"));
        String employee = trimParam(request.getParameter("employee"));

        // Xử lý phân trang
        int page = 1;
        int pageSize = 10;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (Exception ignored) {
        }

        // Gọi DAO để lấy dữ liệu lọc
        List<Order> filteredOrders = orderDAO.getOrdersWithFilter(
                keyword, // customerName
                startDate,
                endDate,
                status,
                employee,
                page,
                pageSize
        );

        // Tính tổng số bản ghi theo bộ lọc tương tự
        int totalOrders = orderDAO.getTotalOrders(
                keyword, startDate, endDate, status, employee
        );

        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);

        // Trả dữ liệu ra JSP
        request.setAttribute("orderList", filteredOrders);
        request.setAttribute("currentPage", page);
        request.setAttribute("ordersPerPage", pageSize);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalPages", totalPages);

        // Trả lại lại các filter đã chọn (để giữ lại trên form)
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("employee", employee);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);

        System.out.println("Trang hiện tại: " + page);
        System.out.println("Tổng số đơn hàng sau lọc: " + totalOrders);
        System.out.println("filteredOrders size: " + filteredOrders.size());
        System.out.println("Offset: " + ((page - 1) * pageSize));

        request.getRequestDispatcher("view/order-list.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
