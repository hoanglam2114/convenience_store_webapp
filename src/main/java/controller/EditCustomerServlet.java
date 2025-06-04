
package controller;

import dao.CustomerDAO;
import dao.NotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customers;
import model.Notification;

/**
 *
 * @author Admin
 */
public class EditCustomerServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditCustomerServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCustomerServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy id nhân viên muốn sửa
        int id = Integer.parseInt(request.getParameter("id"));

        // Lấy thông tin nhân viên theo id
        CustomerDAO dao = new CustomerDAO();
        Customers customer = dao.getCustomerById(id);

        // Gửi dữ liệu về JSP để hiển thị
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("view/customer-edit.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        int point = Integer.parseInt(request.getParameter("point"));

        CustomerDAO dao = new CustomerDAO();
        Customers customer = new Customers(id, name, phone, point);

        dao.updateCustomerById(customer);
        
        NotificationDAO notiDAO = new NotificationDAO();
        // Ghi thông báo
        String message = "Admin đã cập nhật thông tin khách hàng " + name + " trong hệ thống.";
        notiDAO.insert(new Notification(message, "Admin", "cập nhật"));

        // Sau khi update, thường nên redirect đến trang danh sách hoặc trang chi tiết
        response.sendRedirect("listCustomer");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
