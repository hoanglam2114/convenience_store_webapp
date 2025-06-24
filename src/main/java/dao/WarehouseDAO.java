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

    public List<Warehouse> searchAndFilter(String search, String status) {
        List<Warehouse> result = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Warehouses WHERE 1=1");

        if (search != null && !search.trim().isEmpty()) {
            query.append(" AND (name LIKE ? OR address LIKE ?)");
        }
        if (status != null && !status.trim().isEmpty()) {
            query.append(" AND status = ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(query.toString())) {

            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(index++, status);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Warehouse w = buildWarehouse(rs);
                result.add(w);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public Warehouse getWarehouseByID(int warehouseID) {
        Warehouse warehouse = null;
        String query = "SELECT * FROM Warehouses WHERE warehouse_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, warehouseID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                warehouse = buildWarehouse(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(WarehouseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return warehouse;
    }

    public boolean updateWarehouse(Warehouse warehouse) {
        String query = "UPDATE Warehouses SET name = ?, address = ?, phone = ?, working_hours = ?, manager_id = ?, store_linked_id = ?, status = ? WHERE warehouse_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, warehouse.getName());
            ps.setString(2, warehouse.getAddress());
            ps.setString(3, warehouse.getPhone());
            ps.setString(4, warehouse.getWorkingHours());

            if (warehouse.getManagerID() != null) {
                ps.setInt(5, warehouse.getManagerID());
            } else {
                ps.setNull(5, java.sql.Types.INTEGER);
            }

            if (warehouse.getStoreLinkedID() != null) {
                ps.setInt(6, warehouse.getStoreLinkedID());
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }

            ps.setString(7, warehouse.getStatus().name());
            ps.setInt(8, warehouse.getWarehouseID());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(int warehouseID, WarehouseStatus status) {
        String query = "UPDATE Warehouses SET status = ? WHERE warehouse_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, status.name());
            ps.setInt(2, warehouseID);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteWarehouseByID(int warehouseID) {
        String query = "DELETE FROM Warehouses WHERE warehouse_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, warehouseID);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public static void main(String[] args) {
        WarehouseDAO dao = new WarehouseDAO();

        Warehouse warehouse = dao.getWarehouseByID(1);
        System.out.println(warehouse);
    }
}