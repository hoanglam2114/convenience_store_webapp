package controller;

import dao.InventoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Inventory;
import model.InventoryBatch;

import java.io.IOException;
import java.util.List;

/**
 * @author hoang on 7/21/2025-1:13 AM
 * IntelliJ IDEA
 */
@WebServlet(name = "InventoryBatchServlet", urlPatterns = {"/inventory-batch"})
public class InventoryBatchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String inventoryIdRaw = req.getParameter("inventory_id");
        int warehouseId = Integer.parseInt(req.getParameter("warehouse_id"));
        if (inventoryIdRaw == null) {
            resp.sendRedirect("inventory-list"); // fallback
            return;
        }

        int inventoryId = Integer.parseInt(inventoryIdRaw);
        InventoryDAO inventoryDAO = new InventoryDAO();
        Inventory inventory = inventoryDAO.getInventoryById(inventoryId);

        InventoryDAO dao = new InventoryDAO();
        List<InventoryBatch> batches = dao.getBatchesByInventoryId(inventoryId);

        req.setAttribute("inventory", inventory);
        req.setAttribute("batches", batches);
        req.setAttribute("warehouseID", warehouseId);
        req.getRequestDispatcher("/view/inventory-batch.jsp").forward(req, resp);
    }
}

