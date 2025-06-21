package controller.POS;

import dao.CustomerDAO;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.List;
import model.Cart;
import model.CartItem;
import model.Order;

public class CheckoutServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        // Trường hợp không có giỏ hàng hoặc giỏ hàng trống
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("view/pos-home.jsp");
            return;
        }

        try {
            // Lấy thông tin khách hàng từ session
            Object customerIdObj = session.getAttribute("customerId");
            Object customerNameObj = session.getAttribute("customerName");

            // Kiểm tra nếu thiếu thông tin khách hàng
            if (customerIdObj == null || customerNameObj == null) {
                response.sendRedirect("loadProducts?error=missingCustomer");
                return;
            }

            int customerId = (Integer) customerIdObj;
            String customerName = (String) customerNameObj;
            double totalAmount = cart.getTotalMoney();

            int employeeId = 2; // Tạm thời fix cứng
            OrderDAO orderDAO = new OrderDAO();

            // B1: Tạo đơn hàng trạng thái PENDING, có tổng tiền
            int orderId = orderDAO.createPendingOrder(customerId, employeeId, totalAmount);

            // B2: Ghi chi tiết đơn hàng + cập nhật kho
            orderDAO.processOrderDetails(orderId, cart.getItems());

            // B3: Cập nhật điểm khách hàng
            orderDAO.updateCustomerPoints(customerId, 1);

            // B4: Reset giỏ hàng sau khi thanh toán
            session.removeAttribute("cart");

            // B5: Load lại đơn hàng để hiển thị
            Order order = orderDAO.getOrderById(orderId);
            request.setAttribute("order", order);
            request.setAttribute("cartItems", cart.getItems());
            request.getRequestDispatcher("view/receipt.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi xử lý thanh toán: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
