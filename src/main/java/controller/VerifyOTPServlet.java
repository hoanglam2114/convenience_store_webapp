package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customers;

import java.io.IOException;

/**
 * @author hoang on 6/22/2025-8:22 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "VerifyOTPServlet", urlPatterns = "/verify-otp")
public class VerifyOTPServlet extends HttpServlet {
    CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String sessionOtp = (String) session.getAttribute("otp");
        String inputOtp = request.getParameter("otp");
        String phone = (String) session.getAttribute("phone");

        if (sessionOtp != null && sessionOtp.equals(inputOtp)) {
            Customers customer = customerDAO.findByPhone(phone);

            if (customer == null) {
                customer = new Customers();
                customer.setPhone(phone);
                customer.setName("Người dùng mới");
                customer.setPoint(0);
                customer.setType_id(1); // default type

                customerDAO.addCustomer(customer);
                customer = customerDAO.findByPhone(phone);
            }

            session.setAttribute("customer", customer);
            response.sendRedirect("customer-home");
        } else {
            request.setAttribute("error", "Mã OTP không đúng.");
            request.getRequestDispatcher("/view/verify-otp.jsp").forward(request, response);
        }
    }
}