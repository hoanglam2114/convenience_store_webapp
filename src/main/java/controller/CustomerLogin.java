package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * @author hoang on 6/22/2025-8:35 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "CustomerLogin", urlPatterns = "/customer-login")
public class CustomerLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("/view/login-customer.jsp").forward(req, resp);
    }
}
