package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customers;

import java.io.IOException;

/**
 * @author hoang on 6/22/2025-10:02 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "EditProfileServlet", urlPatterns = {"/edit-profile"})
public class EditCustomerProfile extends HttpServlet {

    private final CustomerDAO customersDAO = new CustomerDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");

            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tên không được để trống.");
                request.getRequestDispatcher("/view/customer-profile.jsp").forward(request, response);
                return;
            }

            boolean updated = customersDAO.editCustomerNameById(id, name);

            if (updated) {
                // Cập nhật lại session
                Customers c = customersDAO.getCustomerById(id);
                request.getSession().setAttribute("customer", c);

                response.sendRedirect("customer-profile?updated=1");
            } else {
                request.setAttribute("errorMessage", "Cập nhật thất bại.");
                request.getRequestDispatcher("/view/customer-profile.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi cập nhật: " + e.getMessage());
            request.getRequestDispatcher("/view/customer-profile.jsp").forward(request, response);
        }
    }
}

