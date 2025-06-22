package dao;

import model.Inventory;
import model.InventoryDetails;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author hoang on 5/26/2025-8:53 AM IntelliJ IDEA
 */
public class InventoryDAO extends DBContext {

    private Inventory buildInventory(ResultSet rs) {
        ProductsDAO pd = new ProductsDAO();
        WarehouseDAO wd = new WarehouseDAO();
        try{
            return Inventory.builder()
                    .inventoryID(rs.getInt("inventory_id"))
                    .product(pd.getProductById(rs.getInt("product_id")))
                    .currentStock(rs.getInt("current_stock"))
                    .inventoryStatus(rs.getString("inventory_status"))
                    .lastRestockDate(rs.getTimestamp("last_restock_date").toLocalDateTime())
                    .alert(rs.getString("alert"))
                    .warehouse(wd.getWarehouseByID(rs.getInt("warehouse_id")))
                    .build();
        }catch(SQLException ex){
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<Inventory> getAllInventory() {
        List<Inventory> inventory = new ArrayList<>();
        String query = "SELECT * FROM dbo.Inventory ORDER BY last_restock_date DESC";
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

    /**
     * Search products in inventory by name
     */
    public List<Inventory> searchInventoryByProductName(String productName) {
        List<Inventory> inventory = new ArrayList<>();
        String query = "SELECT i.* FROM dbo.Inventory i " +
                "JOIN dbo.Products p ON i.product_id = p.product_id " +
                "WHERE p.product_name LIKE ? " +
                "ORDER BY p.product_name";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "%" + productName + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                inventory.add(buildInventory(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return inventory;
    }

    /**
     * Get inventory by status
     */
    public List<Inventory> getInventoryByStatus(String status) {
        List<Inventory> inventory = new ArrayList<>();
        String query = "SELECT * FROM dbo.Inventory WHERE inventory_status = ? ORDER BY last_restock_date DESC";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, status);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                inventory.add(buildInventory(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return inventory;
    }

    /**
     * Get inventory with advanced filtering
     */
    public List<Inventory> getInventoryWithFilters(String productName, String status, String category, String sortBy) {
        List<Inventory> inventory = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT i.* FROM dbo.Inventory i " +
                "JOIN dbo.Products p ON i.product_id = p.product_id WHERE 1=1");

        List<Object> parameters = new ArrayList<>();

        if (productName != null && !productName.trim().isEmpty()) {
            query.append(" AND (p.product_name LIKE ? OR p.product_id LIKE ?)");
            parameters.add("%" + productName + "%");
            parameters.add("%" + productName + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            query.append(" AND i.inventory_status = ?");
            parameters.add(status);
        }

        if (category != null && !category.trim().isEmpty()) {
            query.append(" AND p.category = ?");
            parameters.add(category);
        }

        // Add sorting
        switch (sortBy != null ? sortBy : "name_asc") {
            case "name_desc":
                query.append(" ORDER BY p.product_name DESC");
                break;
            case "stock_asc":
                query.append(" ORDER BY i.current_stock ASC");
                break;
            case "stock_desc":
                query.append(" ORDER BY i.current_stock DESC");
                break;
            case "date_updated":
                query.append(" ORDER BY i.last_restock_date DESC");
                break;
            default:
                query.append(" ORDER BY p.product_name ASC");
        }

        try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                inventory.add(buildInventory(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return inventory;
    }

    /**
     * Get inventory statistics for dashboard
     */
    public Map<String, Object> getInventoryStatistics() {
        Map<String, Object> stats = new HashMap<>();

        try {
            // Total products
            String totalQuery = "SELECT COUNT(*) as total FROM dbo.Inventory";
            try (PreparedStatement statement = connection.prepareStatement(totalQuery)) {
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    stats.put("totalProducts", rs.getInt("total"));
                }
            }

            // Low stock products (less than 10)
            String lowStockQuery = "SELECT COUNT(*) as low_stock FROM dbo.Inventory WHERE current_stock < 10";
            try (PreparedStatement statement = connection.prepareStatement(lowStockQuery)) {
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    stats.put("lowStock", rs.getInt("low_stock"));
                }
            }

            // Out of stock products
            String outOfStockQuery = "SELECT COUNT(*) as out_of_stock FROM dbo.Inventory WHERE current_stock = 0";
            try (PreparedStatement statement = connection.prepareStatement(outOfStockQuery)) {
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    stats.put("outOfStock", rs.getInt("out_of_stock"));
                }
            }

            // Products with alerts
            String alertQuery = "SELECT COUNT(*) as alerts FROM dbo.Inventory WHERE alert IS NOT NULL AND alert != ''";
            try (PreparedStatement statement = connection.prepareStatement(alertQuery)) {
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    stats.put("alerts", rs.getInt("alerts"));
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return stats;
    }

    /**
     * Import products to inventory
     */
    public boolean importProduct(int productId, int quantity, String batch, String notes) {
        String checkQuery = "SELECT inventory_id, current_stock FROM dbo.Inventory WHERE product_id = ?";
        String updateQuery = "UPDATE dbo.Inventory SET current_stock = current_stock + ?, " +
                "last_restock_date = ?, inventory_status = ? WHERE product_id = ?";
        String insertQuery = "INSERT INTO dbo.Inventory (product_id, current_stock, inventory_status, " +
                "last_restock_date, alert) VALUES (?, ?, ?, ?, ?)";

        try {
            connection.setAutoCommit(false);

            // Check if product exists in inventory
            boolean exists = false;
            try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
                checkStmt.setInt(1, productId);
                ResultSet rs = checkStmt.executeQuery();
                exists = rs.next();
            }

            if (exists) {
                // Update existing inventory
                try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                    updateStmt.setInt(1, quantity);
                    updateStmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
                    updateStmt.setString(3, "Còn hàng");
                    updateStmt.setInt(4, productId);
                    updateStmt.executeUpdate();
                }
            } else {
                // Insert new inventory record
                try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
                    insertStmt.setInt(1, productId);
                    insertStmt.setInt(2, quantity);
                    insertStmt.setString(3, quantity > 0 ? "Còn hàng" : "Hết hàng");
                    insertStmt.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
                    insertStmt.setString(5, null);
                    insertStmt.executeUpdate();
                }
            }

            connection.commit();
            return true;

        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, rollbackEx);
            }
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     * Export products from inventory
     */
    public boolean exportProduct(int inventoryId, int quantity, String reason, String notes) {
        String selectQuery = "SELECT product_id, current_stock FROM dbo.Inventory WHERE inventory_id = ?";
        String updateQuery = "UPDATE dbo.Inventory SET current_stock = current_stock - ?, " +
                "last_restock_date = ?, inventory_status = ?, alert = ? WHERE inventory_id = ?";

        try {
            connection.setAutoCommit(false);

            int productId = 0;
            int currentStock = 0;

            // Get current stock
            try (PreparedStatement selectStmt = connection.prepareStatement(selectQuery)) {
                selectStmt.setInt(1, inventoryId);
                ResultSet rs = selectStmt.executeQuery();
                if (rs.next()) {
                    productId = rs.getInt("product_id");
                    currentStock = rs.getInt("current_stock");
                }
            }

            if (currentStock < quantity) {
                throw new SQLException("Insufficient stock. Available: " + currentStock + ", Requested: " + quantity);
            }

            int newStock = currentStock - quantity;
            String newStatus = newStock == 0 ? "Hết hàng" : (newStock < 10 ? "Sắp hết" : "Còn hàng");
            String alert = newStock < 10 ? "Sản phẩm sắp hết hàng" : null;

            // Update inventory
            try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                updateStmt.setInt(1, quantity);
                updateStmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
                updateStmt.setString(3, newStatus);
                updateStmt.setString(4, alert);
                updateStmt.setInt(5, inventoryId);
                updateStmt.executeUpdate();
            }

            connection.commit();
            return true;

        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, rollbackEx);
            }
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     * Insert new inventory record
     * @param i Inventory object to insert
     */
    public void addInventoryProduct(Inventory i) {
        String sql = "INSERT INTO Inventory VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, i.getProduct().getId());
            st.setInt(2, i.getCurrentStock());
            st.setString(3, i.getInventoryStatus());
            st.setTimestamp(4, Timestamp.valueOf(i.getLastRestockDate()));
            st.setString(5, i.getAlert());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    /**
     * Delete product from inventory
     */
    public boolean deleteInventoryById(int inventoryId) {
        PreparedStatement ps1 = null, ps2 = null, ps3 = null;
        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // 1. Xóa InventoryDetails
            ps1 = connection.prepareStatement("DELETE FROM InventoryDetails WHERE inventory_id = ?");
            ps1.setInt(1, inventoryId);
            ps1.executeUpdate();

            // 2. Xóa StoreStock
            ps2 = connection.prepareStatement("DELETE FROM StoreStock WHERE inventory_id = ?");
            ps2.setInt(1, inventoryId);
            ps2.executeUpdate();

            // 3. Xóa chính Inventory
            ps3 = connection.prepareStatement("DELETE FROM Inventory WHERE inventory_id = ?");
            ps3.setInt(1, inventoryId);
            ps3.executeUpdate();

            connection.commit();
            return true;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps1 != null) ps1.close();
                if (ps2 != null) ps2.close();
                if (ps3 != null) ps3.close();
                connection.setAutoCommit(true); // Trả lại trạng thái ban đầu
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Get inventory by ID
     */
    public Inventory getInventoryById(int inventoryId) {
        String query = "SELECT * FROM dbo.Inventory WHERE inventory_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, inventoryId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return buildInventory(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Update inventory details
     * @param i Inventory object containing updated details
     */
    public void updateInventoryDetail(Inventory i) {
        String sql = "UPDATE [dbo].[Inventory]\n"
                + "   SET [product_id] = ?\n"
                + "      ,[current_stock] = ?\n"
                + "      ,[inventory_status] = ?\n"
                + "      ,[last_restock_date] = ?\n"
                + "      ,[alert] = ? \n"
                + " WHERE inventory_id = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, i.getProduct().getId());
            st.setInt(2, i.getCurrentStock());
            st.setString(3, i.getInventoryStatus());
            st.setTimestamp(4, Timestamp.valueOf(i.getLastRestockDate()));
            st.setString(5, i.getAlert());
            st.setInt(6, i.getInventoryID());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    /**
     * Insert inventory details
     * @param d InventoryDetails object containing details to insert
     */
    public void insertInventoryDetails(InventoryDetails d) {
        String sql = "INSERT INTO InventoryDetails  VALUES (?, ?, ?, ?) ";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, d.getInventory().getInventoryID());
            st.setInt(2, d.getQuantity());
            st.setDate(3, Date.valueOf(d.getDate()));
            st.setString(4, d.getStatus());
            st.executeUpdate();

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    /**
     * Update inventory status and alerts
     */
    public void updateInventoryAlerts() {
        String query = "UPDATE dbo.Inventory SET " +
                "inventory_status = CASE " +
                "    WHEN current_stock = 0 THEN N'Hết hàng' " +
                "    WHEN current_stock < 10 THEN N'Sắp hết' " +
                "    ELSE 'Còn hàng' " +
                "END, " +
                "alert = CASE " +
                "    WHEN current_stock = 0 THEN N'Sản phẩm đã hết hàng' " +
                "    WHEN current_stock < 5 THEN N'Nguy hiểm: Sắp hết hàng' " +
                "    WHEN current_stock < 10 THEN N'Cảnh báo: Tồn kho thấp' " +
                "    ELSE NULL " +
                "END";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get the last inventory record
     * @return Inventory object representing the last inventory record
     */
    public Inventory getInventoryLast() {
        String sql = "SELECT TOP 1 * FROM Inventory ORDER BY inventory_id DESC";
        ProductsDAO pd = new ProductsDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Inventory inventory = new Inventory();
                inventory.setInventoryID(rs.getInt("inventory_id"));
                inventory.setProduct(pd.getProductById(rs.getInt("product_id"))); // Giả sử bạn có hàm này để lấy Product
                inventory.setCurrentStock(rs.getInt("current_stock"));
                inventory.setInventoryStatus(rs.getString("inventory_status"));
                inventory.setLastRestockDate(rs.getTimestamp("last_restock_date").toLocalDateTime());
                inventory.setAlert(rs.getString("alert"));
                return inventory;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<InventoryDetails> getAllLogInventory() {
        List<InventoryDetails> list = new ArrayList<>();
        InventoryDAO invenD = new InventoryDAO();

        String sql = "SELECT [inventory_detail_id]\n"
                + "      ,[inventory_id]\n"
                + "      ,[quantity]\n"
                + "      ,[date]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[InventoryDetails]"
                + "  where 1=1\n";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                InventoryDetails in = new InventoryDetails();
                in.setId(rs.getInt("inventory_detail_id"));
                Inventory inven = invenD.getInventoryById(rs.getInt("inventory_id"));
                in.setInventory(inven);
                in.setQuantity(rs.getInt("quantity"));
                in.setDate(rs.getDate("date").toLocalDate());
                in.setStatus(rs.getString("status"));
                list.add(in);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    /**
     * Get paginated inventory results
     */
    public List<Inventory> getInventoryPaginated(int page, int pageSize, String productName, String status, String sortBy, Integer warehouseId) {
        List<Inventory> inventory = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder query = new StringBuilder("SELECT i.* FROM dbo.Inventory i " +
                "JOIN dbo.Products p ON i.product_id = p.product_id WHERE 1=1");

        List<Object> parameters = new ArrayList<>();

        if (productName != null && !productName.trim().isEmpty()) {
            query.append(" AND p.product_name LIKE ?");
            parameters.add("%" + productName + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            query.append(" AND i.inventory_status = ?");
            parameters.add(status);
        }

        // ✅ Thêm filter theo warehouseId nếu có
        if (warehouseId != null) {
            query.append(" AND i.warehouse_id = ?");
            parameters.add(warehouseId);
        }

        // Sorting
        query.append(" ORDER BY ");
        switch (sortBy != null ? sortBy : "name_asc") {
            case "name_desc":
                query.append("p.product_name DESC");
                break;
            case "stock_asc":
                query.append("i.current_stock ASC");
                break;
            case "stock_desc":
                query.append("i.current_stock DESC");
                break;
            case "date_updated":
                query.append("i.last_restock_date DESC");
                break;
            default:
                query.append("p.product_name ASC");
        }

        // Pagination
        query.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        parameters.add(offset);
        parameters.add(pageSize);

        try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                inventory.add(buildInventory(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return inventory;
    }

    /**
     * Get total count for pagination
     */
    public int getTotalInventoryCount(String productName, String status, Integer warehouseId) {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) as total FROM dbo.Inventory i " +
                "JOIN dbo.Products p ON i.product_id = p.product_id WHERE 1=1");

        List<Object> parameters = new ArrayList<>();

        if (productName != null && !productName.trim().isEmpty()) {
            query.append(" AND p.product_name LIKE ?");
            parameters.add("%" + productName + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            query.append(" AND i.inventory_status = ?");
            parameters.add(status);
        }

        if (warehouseId != null) {
            query.append(" AND i.warehouse_id = ?");
            parameters.add(warehouseId);
        }

        try (PreparedStatement statement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Inventory> getInventoryByWarehouse(int warehouseId) throws SQLException {
        String query = "SELECT * FROM Inventory WHERE warehouse_id = ?";
        List<Inventory> inventoryList = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, warehouseId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                inventoryList.add(buildInventory(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(InventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
        return inventoryList;
    }


    public static void main(String[] args) {
        InventoryDAO inventoryDAO = new InventoryDAO();

        List<Inventory> inventoryList = null;
        try {
            inventoryList = inventoryDAO.getInventoryByWarehouse(1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (inventoryList.isEmpty()) {
            System.out.println("No DATA");
        } else {
            for (Inventory item : inventoryList) {
                System.out.println(item);
            }
        }
    }
}