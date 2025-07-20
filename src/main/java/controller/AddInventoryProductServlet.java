package controller;

import dao.InventoryDAO;
import dao.ProductsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Inventory;
import model.Products;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;

/**
 * @author hoang on 6/8/2025-1:46 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "AddInventoryProductServlet", urlPatterns = {"/add-inventory-product"})
public class AddInventoryProductServlet extends HttpServlet {
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddNewProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewProductServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        InventoryDAO inventoryDAO = new InventoryDAO();
        int warehouseId = Integer.parseInt(request.getParameter("warehouse_id"));
        List<Products> products = inventoryDAO.getProductsNotInInventory(warehouseId);
        request.setAttribute("products", products);

        request.getRequestDispatcher("/view/add-product-inventory.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int warehouseId = Integer.parseInt(request.getParameter("warehouse_id"));
        int productId = Integer.parseInt(request.getParameter("product_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        InventoryDAO id = new InventoryDAO();
        ProductsDAO pd = new ProductsDAO();

        Products pNew = pd.getProductById(productId);
        String status;
        String alert;
        if (quantity <= 0) {
            status = "Hết hàng";
            alert = "Khẩn cấp";
        } else if (0 < quantity && quantity <= 50) {
            status = "Sắp hết";
            alert = "Cảnh báo";
        } else {
            status = "Còn hàng";
            alert = "Không";
        }
        LocalDateTime lastUpdate = LocalDateTime.now();
        Inventory iNew = new Inventory(pNew, quantity, status, lastUpdate, alert);
        id.addInventoryProduct(iNew);
        response.sendRedirect("import-inventory");
    }
}
