package dao;

import model.Warehouse;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDAO extends DBContext{
    
    
    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> warehouses = new ArrayList<>();
        String sql = "SELECT warehouse_id, name, address, phone, working_hours FROM [dbo].[Warehouses]";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Warehouse warehouse = new Warehouse();
                warehouse.setWarehouseId(rs.getInt("warehouse_id"));
                warehouse.setName(rs.getString("name"));
                warehouse.setAddress(rs.getString("address"));
                warehouse.setPhone(rs.getString("phone"));
                warehouse.setWorkingHours(rs.getString("working_hours"));
                warehouses.add(warehouse);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return warehouses;
    }
    
    public Warehouse getWarehouseById(int warehouseId) {
        String sql = "SELECT warehouse_id, name, address, phone, working_hours FROM [dbo].[Warehouses] WHERE warehouse_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, warehouseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Warehouse warehouse = new Warehouse();
                    warehouse.setWarehouseId(rs.getInt("warehouse_id"));
                    warehouse.setName(rs.getString("name"));
                    warehouse.setAddress(rs.getString("address"));
                    warehouse.setPhone(rs.getString("phone"));
                    warehouse.setWorkingHours(rs.getString("working_hours"));
                    return warehouse;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}