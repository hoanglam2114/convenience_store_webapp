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
                .managerName(rs.getObject("manager_name", String.class))
                .build();
    }


    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> warehouses = new ArrayList<>();
        String query = "SELECT w.*,\n" +
                "       wa.employee_id,\n" +
                "       u.employee_name AS manager_name,\n" +
                "       s.shop_name\n" +
                "FROM Warehouses w\n" +
                "         LEFT JOIN WarehouseAssignments wa ON w.warehouse_id = wa.warehouse_id\n" +
                "         LEFT JOIN Employees u ON wa.employee_id = u.employee_id\n" +
                "         LEFT JOIN ShopDetails s ON w.store_linked_id = s.shop_id";
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

    public List<Warehouse> getWarehousesPaging(int offset, int limit) {
        List<Warehouse> warehouses = new ArrayList<>();
        String query = "SELECT \n" +
                "    w.warehouse_id,\n" +
                "    w.name,\n" +
                "    w.address,\n" +
                "    w.phone,\n" +
                "    w.working_hours,\n" +
                "    w.status,\n" +
                "    w.note,\n" +
                "    wa.employee_id AS manager_id,\n" +
                "    e.employee_name AS manager_name\n" +
                "FROM Warehouses w\n" +
                "LEFT JOIN WarehouseAssignments wa \n" +
                "    ON w.warehouse_id = wa.warehouse_id \n" +
                "    AND wa.assignment_role = 'Manager'\n" +
                "    AND wa.is_active = 1\n" +
                "LEFT JOIN Employees e \n" +
                "    ON wa.employee_id = e.employee_id\n" +
                "ORDER BY w.warehouse_id " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, offset);
            ps.setInt(2, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    warehouses.add(buildWarehouse(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return warehouses;
    }

    public int countAll() {
        String query = "SELECT COUNT(*) FROM Warehouses";
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Warehouse> searchAndFilterPaging(String search, String status, int offset, int limit) {
        List<Warehouse> list = new ArrayList<>();

        String query = "SELECT w.*, " +
                "wa.employee_id, u.employee_name AS manager_name, s.shop_name " +
                "FROM Warehouses w " +
                "LEFT JOIN WarehouseAssignments wa ON w.warehouse_id = wa.warehouse_id " +
                "LEFT JOIN Employees u ON wa.employee_id = u.employee_id " +
                "LEFT JOIN ShopDetails s ON w.store_linked_id = s.shop_id " +
                "WHERE wa.assignment_role = 'Manager' ";

        if (search != null && !search.trim().isEmpty()) {
            query += "AND w.name LIKE ? ";
        }
        if (status != null && !status.trim().isEmpty()) {
            query += "AND w.status = ? ";
        }

        query += "ORDER BY w.warehouse_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            int paramIndex = 1;

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Warehouse w = buildWarehouse(rs);
                list.add(w);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // Đếm số lượng sau khi search + filter
    public int countFiltered(String search, String status) {
        int count = 0;

        String query = "SELECT COUNT(*) FROM Warehouses w WHERE 1=1 ";

        if (search != null && !search.trim().isEmpty()) {
            query += "AND w.name LIKE ? ";
        }
        if (status != null && !status.trim().isEmpty()) {
            query += "AND w.status = ? ";
        }

        try (PreparedStatement ps = connection.prepareStatement(query)) {

            int paramIndex = 1;

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex, status);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
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
        String query = "SELECT w.*, " +
                "wa.employee_id, " +
                "u.employee_name AS manager_name, " +
                "s.shop_name " +
                "FROM Warehouses w " +
                "LEFT JOIN WarehouseAssignments wa ON w.warehouse_id = wa.warehouse_id " +
                "LEFT JOIN Employees u ON wa.employee_id = u.employee_id " +
                "LEFT JOIN ShopDetails s ON w.store_linked_id = s.shop_id " +
                "WHERE w.warehouse_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, warehouseID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return Warehouse.builder()
                        .warehouseID(rs.getInt("warehouse_id"))
                        .name(rs.getString("name"))
                        .address(rs.getString("address"))
                        .phone(rs.getString("phone"))
                        .workingHours(rs.getString("working_hours"))
                        .status(WarehouseStatus.valueOf(rs.getString("status")))
                        .note(rs.getString("note") == null ? "N/A" : rs.getString("note"))
                        .managerID(rs.getObject("employee_id", Integer.class))
                        .managerName(rs.getObject("manager_name", String.class))
                        .build();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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
        List<Warehouse> w = dao.getWarehousesPaging(0,3);
        System.out.println(w);
    }
}