/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.POS;

import dao.CustomerDAO;
import dao.ProductCategoriesDAO;
import dao.ProductsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customers;

public class CustomerLookup extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerLookup</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerLookup at " + request.getContextPath() + "</h1>");
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
        String phone = request.getParameter("customer_phone");
        CustomerDAO dao = new CustomerDAO();
        Customers customer = dao.findByPhone(phone);

        HttpSession session = request.getSession();
        if (customer != null) {
            session.setAttribute("phone", customer.getPhone());
            session.setAttribute("name", customer.getName());

            // Thêm hai dòng này:
            session.setAttribute("customerId", customer.getId());
            session.setAttribute("customerName", customer.getName());  // đúng theo tên bạn dùng trong CheckoutServlet
        } else {
            session.setAttribute("phone", phone);
            session.setAttribute("name", null);

            // Clear nếu trước đó có tồn tại
            session.removeAttribute("customerId");
            session.removeAttribute("customerName");
        }
        response.sendRedirect("loadProducts");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
