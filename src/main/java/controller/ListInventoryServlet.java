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
import model.Products;

import java.io.IOException;
import java.io.PrintWriter;
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();

        switch (action) {
            case "/inventory":
                handleInventoryDashboard(req, resp);
                break;
            case "/findProInInven":
                handleSearchProducts(req, resp);
                break;
            case "/inventoryStats":
                handleInventoryStats(req, resp);
                break;
            case "/inventorySearch":
                handleAdvancedSearch(req, resp);
                break;
            default:
                handleInventoryDashboard(req, resp);
        }
    }

    private void handleInventoryStats(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        InventoryDAO inventoryDAO = new InventoryDAO();

        try {
            Map<String, Object> stats = inventoryDAO.getInventoryStatistics();
            req.setAttribute("stats", stats);

            req.getRequestDispatcher("/inventoryStats.jsp").forward(req, resp); // hoặc trang hiển thị stats
        } catch (Exception e) {
            req.setAttribute("toastMessage", "Không thể lấy thống kê kho hàng.");
            req.setAttribute("toastType", "error");
            req.getRequestDispatcher("/view/inventory-dashboard.jsp").forward(req, resp);
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
     * Handle product search
     */
    private void handleSearchProducts(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String productName = req.getParameter("namePro");
        String status = req.getParameter("status");
        String category = req.getParameter("category");
        String sortBy = req.getParameter("sortBy");

        List<Inventory> inventoryList;

        if (productName != null && !productName.trim().isEmpty()) {
            inventoryList = inventoryDAO.getInventoryWithFilters(productName, status, category, sortBy);
        } else {
            inventoryList = inventoryDAO.getAllInventory();
        }

        // Get statistics
        Map<String, Object> stats = inventoryDAO.getInventoryStatistics();

        // Set attributes
        req.setAttribute("inven", inventoryList);
        req.setAttribute("stats", stats);
        req.setAttribute("searchTerm", productName);
        req.setAttribute("selectedStatus", status);
        req.setAttribute("selectedCategory", category);
        req.setAttribute("selectedSort", sortBy);
        // Set encoding
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        req.getRequestDispatcher("/view/inventory-dashboard.jsp").forward(req, resp);
    }

    /**
     * Handle advanced search with AJAX
     */
    private void handleAdvancedSearch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String productName = req.getParameter("namePro");
        String status = req.getParameter("status");
        String category = req.getParameter("category");
        String sortBy = req.getParameter("sortBy");

        List<Inventory> inventoryList = inventoryDAO.getInventoryWithFilters(productName, status, category, sortBy);

        // Return JSON response for AJAX
        resp.setContentType("application/json; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        PrintWriter out = resp.getWriter();
        out.print(gson.toJson(inventoryList));
        out.flush();
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
                // Redirect to inventory page with success message
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