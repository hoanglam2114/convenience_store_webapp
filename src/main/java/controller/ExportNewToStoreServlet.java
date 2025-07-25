package controller;

import dao.InventoryDAO;
import dao.StoreStockDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Inventory;
import model.InventoryDetails;
import model.StoreStock;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * @author hoang on 6/8/2025-12:19 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "ExportNewToStoreServlet", urlPatterns = {"/export-new-to-store"})
public class ExportNewToStoreServlet extends HttpServlet {
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
            out.println("<title>Servlet ExportNewToStoreServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportNewToStoreServlet at " + request.getContextPath() + "</h1>");
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
        StoreStockDAO ssd = new StoreStockDAO();
        List<Inventory> in = ssd.getProductNotInStore();
        session.setAttribute("inventory", in);
        request.getRequestDispatcher("/view/export-to-store.jsp").forward(request, response);
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
        StoreStockDAO ssd = new StoreStockDAO();
        InventoryDAO inD = new InventoryDAO();
        String idInven = request.getParameter("idInven");
        String quantity = request.getParameter("quantity");
        String deliveredBy = request.getParameter("deliveredBy");
        String receivedBy = request.getParameter("receivedBy");
        String note = request.getParameter("note");
        int warehouseId = 1;
        int id = Integer.parseInt(idInven);
        int q = Integer.parseInt(quantity);

        Inventory in = inD.getInventoryById(id);
        if (in.getCurrentStock() < q) {
            request.setAttribute("errorMessage", "Số lượng nhập vượt quá số lượng có sẵn.");
            request.getRequestDispatcher("export-to-store.jsp").forward(request, response);
        } else {
            int stock = in.getCurrentStock();
            in.setCurrentStock(stock - q);
            String status;
            String alert;
            if (in.getCurrentStock() <= 0) {
                status = "Hết hàng";
                alert = "Khẩn cấp";
            } else if (0 < in.getCurrentStock() && in.getCurrentStock() <= 50) {
                status = "Sắp hết hàng";
                alert = "Cảnh báo";
            } else {
                status = "Còn hàng";
                alert = "Không";
            }
            LocalDateTime lastUpdate = LocalDateTime.now();
            in.setAlert(alert);
            in.setInventoryStatus(status);
            in.setLastRestockDate(lastUpdate);
            inD.updateInventoryDetail(in);

            String statusDetails = "Xuất hàng";
            LocalDate updateAt = LocalDate.now();
            InventoryDetails detail = new InventoryDetails(in, q, updateAt, statusDetails, deliveredBy, receivedBy, note, warehouseId);
            inD.insertInventoryDetails(detail);

            StoreStock ss = new StoreStock();
            ss.setInventory(in);
            ss.setStock(q);
            ss.setLastStockCheckDate(updateAt);
            ss.setDiscount(null);
            String alertStore;
            if (q <= 0) {
                alertStore = "Khẩn cấp";
            } else if (0 < q && q <= 50) {
                alertStore = "Cảnh báo";
            } else {
                alertStore = "Không";
            }
            ss.setAlert(alertStore);
            ssd.insertStore(ss);

            response.sendRedirect("list-store-stock");
        }

    }
}
