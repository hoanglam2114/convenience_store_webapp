package controller.POS;

import dao.StoreStockDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.CartItem;
import model.StoreStock;

public class AddToCart extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddToCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCart at " + request.getContextPath() + "</h1>");
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
        // Lấy và kiểm tra tham số
        String storeStockIdStr = request.getParameter("storeStockId");
        String quantityStr = request.getParameter("quantity");

        if (storeStockIdStr == null || quantityStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu storeStockId hoặc quantity");
            return;
        }

        int storeStockId;
        int quantity;

        try {
            storeStockId = Integer.parseInt(storeStockIdStr);
            quantity = Integer.parseInt(quantityStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "storeStockId hoặc quantity không hợp lệ");
            return;
        }

        // Lấy cart từ session (nếu chưa có thì tạo mới)
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart); // thiếu dòng này gây mất cart
        }

        try {
            // Lấy StoreStock từ DB
            StoreStockDAO stockDAO = new StoreStockDAO();
            StoreStock storeStock = stockDAO.getStoreStockById(storeStockId);

            if (storeStock != null && quantity > 0) {
                // Tính giá: dùng giá giảm nếu có, không thì giá gốc
                double price = (storeStock.getDiscount() != null)
                        ? storeStock.getDiscount().getPriceSell()
                        : storeStock.getInventory().getProduct().getPrice();

                CartItem item = new CartItem(storeStock, quantity, price);
                cart.addItem(item);
            }
            System.out.println("StoreStock ID: " + storeStockId);
            System.out.println("Tên sản phẩm: " + storeStock.getInventory().getProduct().getName());
            System.out.println("Cart size: " + cart.getItems().size());

        } catch (Exception e) {
            e.printStackTrace(); // Có thể log lỗi ở đây
        }

        // preserve customer info if any
        String phone = (String) session.getAttribute("phone");
        String name = (String) session.getAttribute("name");

        response.sendRedirect("loadProducts");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
