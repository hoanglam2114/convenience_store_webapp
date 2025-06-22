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
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * @author hoang on 6/21/2025-11:27 AM
 * IntelliJ IDEA
 */
@WebServlet(name =  "AddWarehouseServlet", urlPatterns = "/add-warehouse")
public class AddWarehouseServlet extends HttpServlet {
    private WarehouseDAO warehouseDAO;

    @Override
    public void init() throws ServletException {
        warehouseDAO = new WarehouseDAO();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/add-warehouse.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Khởi tạo Logger
        Logger logger = Logger.getLogger(this.getClass().getName());

        try {
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String workingHours = request.getParameter("workingHours");
            String managerIDRaw = request.getParameter("managerID");
            String storeLinkedIDRaw = request.getParameter("storeLinkedID");
            String statusRaw = request.getParameter("status");
            WarehouseStatus status = (statusRaw == null || statusRaw.isEmpty())
                    ? WarehouseStatus.ACTIVE
                    : WarehouseStatus.valueOf(statusRaw);


            logger.log(Level.INFO, "Received parameters: name={0}, address={1}, phone={2}, workingHours={3}, managerIDRaw={4}, storeLinkedIDRaw={5}",
                    new Object[]{name, address, phone, workingHours, managerIDRaw, storeLinkedIDRaw});

            Integer managerID = null;
            if (managerIDRaw != null && !managerIDRaw.trim().isEmpty()) {
                try {
                    managerID = Integer.parseInt(managerIDRaw);
                } catch (NumberFormatException e) {
                    logger.log(Level.WARNING, "Invalid managerID format: {0}", managerIDRaw);
                }
            }

            Integer storeLinkedID = null;
            try {
                storeLinkedID = (storeLinkedIDRaw != null && !storeLinkedIDRaw.isEmpty()) ? Integer.parseInt(storeLinkedIDRaw) : null;
            } catch (NumberFormatException e) {
                logger.log(Level.WARNING, "Invalid storeLinkedID format: {0}", storeLinkedIDRaw);
            }

            // Tạo đối tượng Warehouse
            Warehouse warehouse = Warehouse.builder()
                    .name(name)
                    .address(address)
                    .phone(phone)
                    .workingHours(workingHours)
                    .managerID(managerID)
                    .storeLinkedID(storeLinkedID)
                    .status(status)
                    .build();

            // Ghi log trước khi thêm kho
            logger.log(Level.INFO, "Attempting to add warehouse: {0}", warehouse.toString());

            // Thêm kho vào cơ sở dữ liệu
            boolean success = warehouseDAO.addWarehouse(warehouse);

            if (success) {
                logger.log(Level.INFO, "Warehouse added successfully: {0}", warehouse.getName());
                response.sendRedirect("list-warehouse");
            } else {
                logger.log(Level.SEVERE, "Failed to add warehouse: {0}", warehouse.getName());
                request.setAttribute("errorMessage", "Failed to add warehouse.");
                request.getRequestDispatcher("/view/add-warehouse.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Ghi log cho bất kỳ lỗi không mong muốn nào
            logger.log(Level.SEVERE, "Unexpected error while processing warehouse addition", e);
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("/view/add-warehouse.jsp").forward(request, response);
        }
    }
}