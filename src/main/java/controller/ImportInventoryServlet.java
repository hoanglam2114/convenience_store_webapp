package controller;

import dao.InventoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Inventory;
import model.InventoryDetails;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

/**
 * @author hoang on 6/8/2025-2:00 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "ImportInventoryServlet", urlPatterns = {"/import-log-inventory"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ImportInventoryServlet extends HttpServlet {
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
            out.println("<title>Servlet ImportInventoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImportInventoryServlet at " + request.getContextPath() + "</h1>");
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
        InventoryDAO inventoryd = new InventoryDAO();
        Inventory inven = inventoryd.getInventoryLast();
        session.setAttribute("inventory", inven);
        int warehouseId = Integer.parseInt(request.getParameter("warehouse_id"));
        request.setAttribute("warehouseID", warehouseId);
        request.getRequestDispatcher("/view/import-log-inventory.jsp").forward(request, response);
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
        InventoryDAO inventoryd = new InventoryDAO();

        String warehouseIdRaw = request.getParameter("warehouse_id");
        int warehouseId = Integer.parseInt(warehouseIdRaw);

        Inventory inven = inventoryd.getInventoryLast();
        String q_raw = request.getParameter("quantityInven");
        int q = Integer.parseInt(q_raw);

        String deliveredBy = request.getParameter("deliveredBy");
        String receivedBy = request.getParameter("receivedBy");
        String note = request.getParameter("note");

        String statusDetails = "Nhập hàng";
        LocalDate updateAt = LocalDate.now();

        InventoryDetails detail = new InventoryDetails(inven, q, updateAt, statusDetails, deliveredBy, receivedBy, note, warehouseId);

        inventoryd.insertInventoryDetails(detail);
        response.sendRedirect("log-inventory");
    }

}
