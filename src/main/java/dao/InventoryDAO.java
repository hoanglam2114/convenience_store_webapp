package dao;

import model.Inventory;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author hoang on 5/26/2025-8:53 AM IntelliJ IDEA
 */
public class InventoryDAO extends DBContext {

    private Inventory buildInventory(ResultSet rs) {
        try{
                return Inventory.builder()
                        .inventoryID(rs.getInt("inventory_id"))
                        .productID(rs.getInt("product_id"))
                        .currentStock(rs.getInt("current_stock"))
                        .inventoryStatus(rs.getString("inventory_status"))
                        .lastRestockDate(rs.getTimestamp("last_restock_date").toLocalDateTime())
                        .alert(rs.getString("alert"))
                        .build();
        }catch(SQLException ex){
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<Inventory> getAllInventory() {
        List<Inventory> inventory = new ArrayList<>();
        String query = "SELECT * FROM dbo.Inventory";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                inventory.add(buildInventory(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return inventory;
    }

    public static void main(String[] args) {
        InventoryDAO inventoryDAO = new InventoryDAO();

        List<Inventory> inventoryList = inventoryDAO.getAllInventory();

        if (inventoryList.isEmpty()) {
            System.out.println("No DATA");
        } else {
            for (Inventory item : inventoryList) {
                System.out.println(item);
            }
        }
    }
}
