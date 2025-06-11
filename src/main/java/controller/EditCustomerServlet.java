
package controller;

import dao.CustomerDAO;
import dao.NotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
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
        String pointRaw = request.getParameter("point");
        
        List<String> errors = new ArrayList<>();

        if (!name.matches("^[a-zA-ZÀ-Ỹà-ỹ]+(\\s[a-zA-ZÀ-Ỹà-ỹ]+)*$")) {
            errors.add("Tên không hợp lệ.");
        }
        if (!phone.matches("^0\\d{9}$")) {
            errors.add("Phone number must contain 10 to digits.");
        }
        
        int point = -1;
        try {
            point = Integer.parseInt(pointRaw);
            if (point <= 0) {
                errors.add("Điểm phải lớn hơn 0.");
            }
        } catch (NumberFormatException e) {
            errors.add("Điểm không hợp lệ.");
        }

        // Nếu có lỗi quay lại trang form và hiển thị danh sách lỗi
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("name", name);
            request.setAttribute("phone", phone);
            request.setAttribute("point", point);
            request.getRequestDispatcher("view/customer-edit.jsp").forward(request, response);
            return;
        }

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
