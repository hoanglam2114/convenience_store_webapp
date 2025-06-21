package dao;

import model.Inventory;
import model.Warehouse;
import model.WarehouseStatus;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author hoang on 6/21/2025-1:36 AM
 * IntelliJ IDEA
 */
public class WarehouseDAO extends DBContext {

    private Warehouse buildWarehouse(ResultSet rs) throws SQLException {
        return Warehouse.builder()
                .warehouseID(rs.getInt("warehouse_id"))
                .name(rs.getString("name"))
                .address(rs.getString("address"))
                .phone(rs.getString("phone"))
                .workingHours(rs.getString("working_hours"))
                .status(WarehouseStatus.valueOf(rs.getString("status").toUpperCase()))
                .note(rs.getString("note") == null ? "N/A" : rs.getString("note"))
                .managerID(rs.getObject("manager_id", Integer.class))
                .storeLinkedID(rs.getObject("store_linked_id", Integer.class))
                .build();
    }


    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> warehouses = new ArrayList<>();
        String query = "SELECT * FROM Warehouses";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                warehouses.add(buildWarehouse(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(WarehouseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return warehouses;
    }

    public boolean addWarehouse(Warehouse warehouse) {
        String query = "INSERT INTO Warehouses (name, address, phone, working_hours, manager_id, store_linked_id, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, warehouse.getName());
            stmt.setString(2, warehouse.getAddress());
            stmt.setString(3, warehouse.getPhone());
            stmt.setString(4, warehouse.getWorkingHours());
            if (warehouse.getManagerID() != null) {
                stmt.setInt(5, warehouse.getManagerID());
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }
            if (warehouse.getStoreLinkedID() != null) {
                stmt.setInt(6, warehouse.getStoreLinkedID());
            } else {
                stmt.setNull(6, java.sql.Types.INTEGER);
            }
            stmt.setString(7, warehouse.getStatus().name());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public static void main(String[] args) {
        WarehouseDAO dao = new WarehouseDAO();

        Warehouse testWarehouse = Warehouse.builder()
                .name("Kho Quận 7")
                .address("123 Đường Tự Do")
                .phone("0123456789")
                .workingHours("8:00AM - 6:00PM")
                .managerID(null)
                .storeLinkedID(null)
                .status(WarehouseStatus.ACTIVE)
                .build();

        boolean added = dao.addWarehouse(testWarehouse);
        System.out.println("Inserted: " + added);
    }

}