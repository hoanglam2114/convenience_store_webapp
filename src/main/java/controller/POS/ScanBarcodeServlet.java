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

public class ScanBarcodeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ScanBarcodeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ScanBarcodeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String barcode = request.getParameter("barcode");
        System.out.println("DEBUG barcode nhận được: " + barcode);

        if (barcode == null || barcode.trim().isEmpty()) {
            System.out.println("DEBUG: barcode rỗng");
            response.sendRedirect("loadProducts?error=empty");
            return;
        }

        if (barcode.length() != 13 || !barcode.matches("\\d+")) {
            System.out.println("DEBUG: Barcode không hợp lệ - " + barcode);
            response.sendRedirect("loadProducts?error=invalid");
            return;
        }

        StoreStockDAO stockDAO = new StoreStockDAO();
        StoreStock stock = stockDAO.getStoreStockByBarcode(barcode.trim());

        if (stock == null) {
            System.out.println("DEBUG: Không tìm thấy sản phẩm với barcode " + barcode);
            response.sendRedirect("loadProducts?error=notfound");
            return;
        }

        System.out.println("DEBUG: Đã tìm thấy sản phẩm: " + stock.getInventory().getProduct().getName());

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }

        CartItem item = new CartItem();
        item.setStoreStock(stock);
        item.setQuantity(1);
        if (stock.getDiscount() != null) {
            item.setPrice(stock.getDiscount().getPriceSell());
        } else {
            item.setPrice(stock.getInventory().getProduct().getPrice());
        }

        cart.addItem(item);
        session.setAttribute("cart", cart);

        System.out.println("DEBUG: Thêm thành công vào giỏ hàng");
        response.sendRedirect("loadProducts?barcode=" + barcode);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
