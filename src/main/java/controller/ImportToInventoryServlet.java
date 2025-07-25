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

/**
 * @author hoang on 6/8/2025-2:55 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "ImportToInventoryServlet", urlPatterns = {"/import-to-inventory"})
public class ImportToInventoryServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet AddToInventoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToInventoryServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ProductsDAO pd = new ProductsDAO();
        Products p = pd.getLatestProduct();
        session.setAttribute("product", p);
        request.getRequestDispatcher("/view/add-to-inventory.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        InventoryDAO id = new InventoryDAO();
        ProductsDAO pd = new ProductsDAO();
        int warehouseId = Integer.parseInt(request.getParameter("warehouse_id"));

        String idPro_raw = request.getParameter("idPro");
        String quantity = request.getParameter("quantity");
        int idPro = Integer.parseInt(idPro_raw);
        Products pNew = pd.getProductById(idPro);
        int q = Integer.parseInt(quantity);
        String status;
        String alert;
        if (q == 0) {
            status = "Hết hàng";
            alert = "Khẩn cấp";
        } else if (0 < q && q <= 50) {
            status = "Sắp hết";
            alert = "Cảnh báo";
        } else {
            status = "Còn hàng";
            alert = "Không";
        }
        LocalDateTime lastUpdate = LocalDateTime.now();
        Inventory iNew = new Inventory(pNew, q, status, lastUpdate, alert,warehouseId);
        System.out.println(iNew);

        id.addInventoryProduct(iNew);
        response.sendRedirect("import-inventory");
    }
}
