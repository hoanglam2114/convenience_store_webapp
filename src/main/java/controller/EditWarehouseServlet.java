package controller;

import dao.WarehouseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Warehouse;
import model.WarehouseStatus;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author hoang on 6/22/2025-4:55 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "EditWarehouseServlet", urlPatterns = {"/edit-warehouse"})
public class EditWarehouseServlet extends HttpServlet {
    private WarehouseDAO warehouseDAO = new WarehouseDAO();

    public void init() throws ServletException {
        warehouseDAO = new WarehouseDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int warehouseID = Integer.parseInt(request.getParameter("warehouse_id"));
            WarehouseDAO dao = new WarehouseDAO();
            Warehouse warehouse = dao.getWarehouseByID(warehouseID);
            request.setAttribute("warehouse", warehouse);
            request.getRequestDispatcher("/view/edit-warehouse.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Logger logger = Logger.getLogger(this.getClass().getName());

        try {
            int warehouseID = Integer.parseInt(request.getParameter("warehouse_id")); // hidden input trong form

            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String startTime = request.getParameter("startTime"); // Lấy startTime
            String endTime = request.getParameter("endTime");     // Lấy endTime
            String managerIDRaw = request.getParameter("managerID");
            String storeLinkedIDRaw = request.getParameter("storeLinkedID");
            String statusRaw = request.getParameter("status");

            String workingHours = (startTime != null && endTime != null && !startTime.isEmpty() && !endTime.isEmpty())
                    ? startTime.trim() + " - " + endTime.trim()
                    : null;
            if (statusRaw == null || statusRaw.isEmpty()) {
                throw new IllegalArgumentException("Status must not be empty.");
            }

            WarehouseStatus status = WarehouseStatus.valueOf(statusRaw);


            Integer managerID;
            if (managerIDRaw != null && !managerIDRaw.isEmpty()) {
                managerID = Integer.parseInt(managerIDRaw);
            } else {
                Warehouse oldWarehouse = warehouseDAO.getWarehouseByID(warehouseID);
                managerID = oldWarehouse.getManagerID();
            }
            Integer storeLinkedID = (storeLinkedIDRaw != null && !storeLinkedIDRaw.isEmpty()) ? Integer.parseInt(storeLinkedIDRaw) : null;

            Warehouse warehouse = Warehouse.builder()
                    .warehouseID(warehouseID)
                    .name(name)
                    .address(address)
                    .phone(phone)
                    .workingHours(workingHours)
                    .managerID(managerID)
                    .storeLinkedID(storeLinkedID)
                    .status(status)
                    .build();

            logger.log(Level.INFO, "Updating warehouse: {0}", warehouse.toString());

            boolean success = warehouseDAO.updateWarehouse(warehouse);

            if (success) {
                logger.log(Level.INFO, "Warehouse updated successfully: {0}", warehouse.getName());
                response.sendRedirect("list-warehouse");
            } else {
                logger.log(Level.SEVERE, "Failed to update warehouse: {0}", warehouse.getName());
                request.setAttribute("errorMessage", "Failed to update warehouse.");
                request.setAttribute("warehouse", warehouse); // để giữ dữ liệu khi lỗi
                request.getRequestDispatcher("/view/edit-warehouse.jsp").forward(request, response);
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Unexpected error while updating warehouse", e);
            request.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("/view/edit-warehouse.jsp").forward(request, response);
        }
    }

}