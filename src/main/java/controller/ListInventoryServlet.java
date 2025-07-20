package controller;

import com.google.gson.Gson;
import dao.InventoryDAO;
import dao.ProductsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Inventory;
import model.InventorySummary;
import model.Products;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @author hoang on 5/26/2025-9:16 AM
 * IntelliJ IDEA
 */
@WebServlet(name = "ListInventoryServlet", urlPatterns = {"/inventory"})
public class ListInventoryServlet extends HttpServlet {

    private final InventoryDAO inventoryDAO = new InventoryDAO();
    private final ProductsDAO productsDAO = new ProductsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("warehouse_id");
            if (idParam == null) {
                response.sendRedirect("list-warehouse");
                return;
            }

            int warehouseId = Integer.parseInt(idParam);

            int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
            int pageSize = 10;
            int offset = (page - 1) * pageSize;

            List<InventorySummary> inven = inventoryDAO.getPagedInventoryByWarehouse(warehouseId, offset, pageSize);
            int total = inventoryDAO.countInventoryByWarehouse(warehouseId);
            int totalPages = (int) Math.ceil((double) total / pageSize);

            request.setAttribute("inven", inven);
            request.setAttribute("page", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("warehouseID", warehouseId);
            request.getRequestDispatcher("/view/inventory-dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println(e);
            response.sendRedirect("error.jsp");
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();

        switch (action) {
            case "/importProduct":
                handleImportProduct(req, resp);
                break;
            case "/exportProduct":
                handleExportProduct(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    /**
     * Handle main inventory dashboard
     */
    private void handleInventoryDashboard(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String warehouseIdParam = req.getParameter("warehouse_id");
        Integer warehouseId = null;
        if (warehouseIdParam != null && !warehouseIdParam.isEmpty()) {
            warehouseId = Integer.parseInt(warehouseIdParam);
        }

        // Get pagination parameters
        int page = 1;
        int pageSize = 20;
        try {
            page = Integer.parseInt(req.getParameter("page") != null ? req.getParameter("page") : "1");
            pageSize = Integer.parseInt(req.getParameter("pageSize") != null ? req.getParameter("pageSize") : "20");
        } catch (NumberFormatException e) {
            page = 1;
            pageSize = 20;
        }

        // Get filter parameters
        String productName = req.getParameter("namePro");
        String status = req.getParameter("status");
        String sortBy = req.getParameter("sortBy");

        // Get inventory data
        List<Inventory> inventoryList;
        int totalCount;

        if (productName != null && !productName.trim().isEmpty()) {
            inventoryList = inventoryDAO.getInventoryPaginated(page, pageSize, productName, status, sortBy, warehouseId);
            totalCount = inventoryDAO.getTotalInventoryCount(productName, status, warehouseId);
        } else {
            inventoryList = inventoryDAO.getInventoryPaginated(page, pageSize, null, status, sortBy, warehouseId);
            totalCount = inventoryDAO.getTotalInventoryCount(null, status, warehouseId);
        }

        // Get statistics for dashboard
        Map<String, Object> stats = inventoryDAO.getInventoryStatistics();

        // Calculate pagination info
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // Update inventory alerts before displaying
        inventoryDAO.updateInventoryAlerts();

        // Set attributes
        // inventory list
        req.setAttribute("inven", inventoryList);
        // inventory stats
        req.setAttribute("stats", stats);
        // pagination
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalCount", totalCount);
        req.setAttribute("pageSize", pageSize);
        //list term
        req.setAttribute("searchTerm", productName);
        //list status
        req.setAttribute("selectedStatus", status);
        //sort types
        req.setAttribute("selectedSort", sortBy);

        // Set encoding
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        req.getRequestDispatcher("/view/inventory-dashboard.jsp").forward(req, resp);
    }

    /**
     * Handle import product to inventory
     */
    private void handleImportProduct(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String productIdStr = req.getParameter("productId");
            String quantityStr = req.getParameter("quantity");
            String batch = req.getParameter("batch");
            String notes = req.getParameter("notes");

            if (productIdStr == null || quantityStr == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                return;
            }

            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            // Validate product exists
            Products product = productsDAO.getProductById(productId);
            if (product == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product not found");
                return;
            }

            boolean success = inventoryDAO.importProduct(productId, quantity, batch, notes);

            if (success) {
                // Return JSON success response
                resp.setContentType("application/json; charset=UTF-8");
                PrintWriter out = resp.getWriter();
                out.print("{\"success\": true, \"message\": \"Nhập kho thành công\"}");
                out.flush();
            } else {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Import failed");
            }

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage());
        }
    }

    /**
     * Handle export product from inventory
     */
    private void handleExportProduct(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String inventoryIdStr = req.getParameter("inventoryId");
            String quantityStr = req.getParameter("quantity");
            String reason = req.getParameter("reason");
            String notes = req.getParameter("notes");

            if (inventoryIdStr == null || quantityStr == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                req.setAttribute("toastMessage", "Không tìm thấy sản phẩm");
                return;
            }

            int inventoryId = Integer.parseInt(inventoryIdStr);
            int quantity = Integer.parseInt(quantityStr);

            // Validate inventory exists
            Inventory inventory = inventoryDAO.getInventoryById(inventoryId);
            if (inventory == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Kho hàng không tìm thấy");
                req.setAttribute("toastMessage", "Kho hàng không tìm thấy");
                return;
            }

            // Check stock availability
            if (inventory.getCurrentStock() < quantity) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không đủ số lượng sản phẩm trong kho để xuất");
                req.setAttribute("toastMessage", "Không đủ số lượng sản phẩm trong kho để xuất");
                return;
            }

            boolean success = inventoryDAO.exportProduct(inventoryId, quantity, reason, notes);

            if (success) {
                HttpSession session = req.getSession();
                req.setAttribute("toastMessage", "Xuất kho thành công");
                resp.sendRedirect(req.getContextPath() + "/inventory");
            } else {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Xuất kho thất bại");
                req.setAttribute("toastMessage", "Xuất kho thất bại");
            }

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Định dạng số không hợp lệ");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi máy chủ: " + e.getMessage());
        }
    }
}