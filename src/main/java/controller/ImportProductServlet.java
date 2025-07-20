package controller;

import dao.InventoryDAO;
import dao.ProductCategoriesDAO;
import dao.ProductsDAO;
import dao.SuppliersDAO;
import dao.WeightUnitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDate;

import model.*;

/**
 * @author hoang on 6/8/2025-2:39 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "ImportProductServlet", urlPatterns = {"/import-product"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ImportProductServlet extends HttpServlet {
    private InventoryDAO inventoryDAO = new InventoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int inventoryId = Integer.parseInt(req.getParameter("inventory_id"));
        Inventory inventory = inventoryDAO.getInventoryById(inventoryId);
        req.setAttribute("inventory", inventory);
        req.getRequestDispatcher("/view/import-product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int inventoryId = Integer.parseInt(req.getParameter("inventory_id"));
            int productId = Integer.parseInt(req.getParameter("product_id"));
            int warehouseId = Integer.parseInt(req.getParameter("warehouse_id"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            String mfgDateStr = req.getParameter("manufactureDate");
            String expDateStr = req.getParameter("expirationDate");
            LocalDate mfgDate = LocalDate.parse(mfgDateStr);
            LocalDate expDate = LocalDate.parse(expDateStr);

            if (expDate.isBefore(mfgDate)) {
                req.setAttribute("errorDate", "Ngày hết hạn phải sau ngày sản xuất.");
                req.getRequestDispatcher("/view/import-product.jsp").forward(req, resp);
                return;
            }

            // 1. Thêm lô mới
            inventoryDAO.addBatch(inventoryId, productId, warehouseId, quantity, mfgDate, expDate);

            // 2. Update inventory tổng
            inventoryDAO.updateStockAfterImport(inventoryId, quantity);

            resp.sendRedirect("inventory?warehouse_id=" + warehouseId);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi khi nhập kho!");
            req.getRequestDispatcher("/view/import-product.jsp").forward(req, resp);
        }
    }
}