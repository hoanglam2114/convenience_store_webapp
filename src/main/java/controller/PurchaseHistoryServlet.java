package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customers;
import model.Order;

import java.io.IOException;
import java.util.List;

/**
 * @author hoang on 7/15/2025-9:59 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "PurchaseHistoryServlet", urlPatterns = {"/purchase-history"})
public class PurchaseHistoryServlet extends HttpServlet {

    private final OrderDAO ordersDAO = new OrderDAO(); // hoặc inject nếu có sẵn

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy khách hàng từ session
        Customers customer = (Customers) req.getSession().getAttribute("customer");
        if (customer == null) {
            resp.sendRedirect("customer-login"); // chưa login thì đá ra login
            return;
        }

        int customerId = customer.getId();

        // Phân trang
        int page = 1;
        int pageSize = 5;

        String pageParam = req.getParameter("page");
        if (pageParam != null && pageParam.matches("\\d+")) {
            page = Integer.parseInt(pageParam);
        }

        int offset = (page - 1) * pageSize;

        // Lấy danh sách đơn hàng và tổng số
        List<Order> orders = ordersDAO.getOrdersByCustomerId(customerId, offset, pageSize);
        int totalOrders = ordersDAO.countOrdersByCustomerId(customerId);
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);

        // Đẩy sang view
        req.setAttribute("orders", orders);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.getSession().setAttribute("customer", customer);
        req.getRequestDispatcher("/view/customer-purchase-history.jsp").forward(req, resp);
    }
}

