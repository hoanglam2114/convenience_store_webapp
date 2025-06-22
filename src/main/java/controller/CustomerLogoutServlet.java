package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * @author hoang on 6/22/2025-10:22 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "CustomerLogoutServlet",urlPatterns = "/customer-logout")
public class CustomerLogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        request.getRequestDispatcher("/view/customer-home.jsp").forward(request, response);
    }
}
