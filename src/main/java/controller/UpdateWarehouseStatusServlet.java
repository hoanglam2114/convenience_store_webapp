package controller;

import dao.WarehouseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.WarehouseStatus;

import java.io.IOException;

/**
 * @author hoang on 6/22/2025-5:49 PM
 * IntelliJ IDEA
 */
@WebServlet("/update-warehouse-status")
public class UpdateWarehouseStatusServlet extends HttpServlet {
    private final WarehouseDAO warehouseDAO = new WarehouseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int warehouseID = Integer.parseInt(request.getParameter("warehouse_id"));
            String statusRaw = request.getParameter("status");

            if (statusRaw == null || statusRaw.isEmpty()) {
                throw new IllegalArgumentException("Trạng thái không được để trống");
            }

            WarehouseStatus status = WarehouseStatus.valueOf(statusRaw);

            boolean success = warehouseDAO.updateStatus(warehouseID, status);

            if (success) {
                response.sendRedirect("list-warehouse"); // hoặc warehouse.jsp
            } else {
                request.setAttribute("errorMessage", "Không thể cập nhật trạng thái.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

