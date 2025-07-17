package controller;

import dao.CustomerDAO;
import dao.OrderDAO;
import jakarta.mail.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customers;

import java.io.IOException;

/**
 * @author hoang on 6/22/2025-9:46 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "CustomerProfile", urlPatterns = "/customer-profile")
public class CustomerProfile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy session
        HttpSession session = req.getSession();
        String phoneNumber = (String) session.getAttribute("phone");

        if (phoneNumber != null) {
            CustomerDAO customerDAO = new CustomerDAO();
            Customers customer = customerDAO.findByPhone(phoneNumber);

            OrderDAO orderDAO = new OrderDAO();
            int totalOrders = orderDAO.countOrdersByCustomerId(customer.getId());
            req.setAttribute("customer", customer);
            req.setAttribute("totalOrders", totalOrders);
            req.getRequestDispatcher("/view/customer-profile.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/customer-login");
        }
    }
}
