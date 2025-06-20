/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.POS;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customers;

@WebServlet(name = "CustomerLookup", urlPatterns = {"/api/customer-lookup"})
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
        String phone = request.getParameter("customer_phone");
        System.out.println("Received phone: " + phone);
        response.setContentType("application/json;charset=UTF-8");

        try {
            CustomerDAO dao = new CustomerDAO();
            Customers customer = dao.findByPhone(phone);

            if (customer != null) {
                JsonObject json = new JsonObject();
                json.addProperty("id", customer.getId());
                json.addProperty("name", customer.getName());
                json.addProperty("phone", customer.getPhone());
                json.addProperty("point", customer.getPoint());
                json.addProperty("type_id", customer.getType_id());

                response.getWriter().write(json.toString());
            } else {
                response.getWriter().write("{}");
            }

        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("{\"error\":\"Internal Server Error\"}");
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
