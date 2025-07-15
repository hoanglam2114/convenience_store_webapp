package dao;

import java.sql.Date;
import com.sun.jdi.connect.spi.Connection;
import java.util.ArrayList;
import java.util.List;
import model.StoreStock;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DiscountProduct;
import model.Inventory;
import model.Products;
import model.WeightUnit;

/**
 * @author hoang on 6/8/2025-10:47 AM IntelliJ IDEA
 */
public class StoreStockDAO extends DBContext {

    public Inventory getInventoryById(int inventory_id) {
        Inventory inventory = null;
        String sql = """
        SELECT i.inventory_id, i.current_stock, i.inventory_status, i.last_restock_date, i.alert,
               p.product_id, p.product_name, p.product_image, p.product_price
        FROM Inventory i
        JOIN Products p ON i.product_id = p.product_id
        WHERE i.inventory_id = ?
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, inventory_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                inventory = new Inventory();
                inventory.setInventoryID(rs.getInt("inventory_id"));
                inventory.setCurrentStock(rs.getInt("current_stock"));
                inventory.setInventoryStatus(rs.getString("inventory_status"));
                Date restockDate = rs.getDate("last_restock_date");
                if (restockDate != null) {
                    inventory.setLastRestockDate(restockDate.toLocalDate().atStartOfDay());
                }
                inventory.setAlert(rs.getString("alert"));

                // Gán sản phẩm
                Products product = new Products();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setImage(rs.getString("product_image"));
                product.setPrice(rs.getFloat("product_price"));

                inventory.setProduct(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inventory;
    }

    public DiscountProduct getDiscountProductById(int discountProductId) {
        String sql = "SELECT * FROM DiscountProduct WHERE discount_product_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, discountProductId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                double priceSell = rs.getDouble("price_sell");
                DiscountProduct dp = new DiscountProduct(discountProductId, productId, priceSell);
                return dp;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi truy vấn StoreStock: " + e.getMessage());
        }
        return null;
    }

    public List<StoreStock> getAllStoreStock() {
        List<StoreStock> list = new ArrayList<>();
        String sql = "SELECT * FROM StoreStock";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                StoreStock stock = new StoreStock();
                stock.setStoreStockId(rs.getInt("store_stock_id"));
                Inventory inventory = getInventoryById(rs.getInt("inventory_id"));
                stock.setInventory(inventory);
                stock.setStock(rs.getInt("quantity_in_stock"));
                stock.setLastStockCheckDate(rs.getDate("last_stock_check_date").toLocalDate());
                DiscountProduct dp = getDiscountProductById(rs.getInt("discount_product_id"));
                stock.setDiscount(dp);
                stock.setAlert(rs.getString("alert"));
                list.add(stock);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi truy vấn StoreStock: " + e.getMessage());
        }

        return list;
    }

    public List<StoreStock> findStoreByProName(String product_name) {
        List<StoreStock> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "      s.[store_stock_id],\n"
                + "      s.[inventory_id],\n"
                + "      s.[quantity_in_stock],\n"
                + "      s.[last_stock_check_date],\n"
                + "      s.[discount_product_id],\n"
                + "      s.[alert]\n"
                + "FROM [SWP_PROJECT].[dbo].[Inventory] i\n"
                + "JOIN [SWP_PROJECT].[dbo].[Products] p ON i.product_id = p.product_id\n"
                + "JOIN [SWP_PROJECT].[dbo].[StoreStock] s ON s.inventory_id = i.inventory_id\n"
                + "WHERE p.product_name LIKE ? ";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + product_name + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                StoreStock stock = new StoreStock();
                stock.setStoreStockId(rs.getInt("store_stock_id"));
                Inventory inventory = getInventoryById(rs.getInt("inventory_id"));
                stock.setInventory(inventory);
                stock.setStock(rs.getInt("quantity_in_stock"));
                stock.setLastStockCheckDate(rs.getDate("last_stock_check_date").toLocalDate());
                DiscountProduct dp = getDiscountProductById(rs.getInt("discount_product_id"));
                stock.setDiscount(dp);
                stock.setAlert(rs.getString("alert"));
                list.add(stock);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public StoreStock getStoreStockById(int store_stock_id) {
        String sql = "SELECT * FROM [dbo].[StoreStock] WHERE store_stock_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, store_stock_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                StoreStock stock = new StoreStock();
                stock.setStoreStockId(rs.getInt("store_stock_id"));
                Inventory inventory = getInventoryById(rs.getInt("inventory_id"));
                stock.setInventory(inventory);
                stock.setStock(rs.getInt("quantity_in_stock"));
                stock.setLastStockCheckDate(rs.getDate("last_stock_check_date").toLocalDate());
                int discountId = rs.getInt("discount_product_id");
                if (!rs.wasNull() && discountId > 0) {
                    DiscountProduct dp = getDiscountProductById(discountId);
                    stock.setDiscount(dp);
                }
                stock.setAlert(rs.getString("alert"));
                return stock;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;
    }

    public void updateStore() {
        String sql = "UPDATE ss\n"
                + "SET ss.discount_product_id = dp.discount_product_id\n"
                + "FROM StoreStock ss\n"
                + "JOIN Inventory i ON ss.inventory_id = i.inventory_id\n"
                + "JOIN DiscountProduct dp ON i.product_id = dp.product_id\n"
                + "WHERE ss.discount_product_id IS NULL";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Inventory> getInventoryNotInStore() {
        List<Inventory> list = new ArrayList<>();
        ProductsDAO pd = new ProductsDAO();
        String sql = "SELECT i.*\n"
                + "FROM Inventory i\n"
                + "WHERE NOT EXISTS (\n"
                + "    SELECT 1\n"
                + "    FROM StoreStock s\n"
                + "    WHERE s.inventory_id = i.inventory_id\n"
                + ");";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Inventory in = new Inventory();
                in.setInventoryID(rs.getInt("inventory_id"));
                Products p = pd.getProductById(rs.getInt("product_id"));
                in.setProduct(p);
                in.setCurrentStock(rs.getInt("current_stock"));
                in.setInventoryStatus(rs.getString("inventory_status"));
                in.setLastRestockDate(rs.getTimestamp("last_restock_date").toLocalDateTime());
                in.setAlert(rs.getString("alert"));
                list.add(in);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void insertStore(StoreStock s) {
        String sql = "INSERT INTO StoreStock VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, s.getInventory().getInventoryID());
            st.setInt(2, s.getStock());
            st.setDate(3, Date.valueOf(s.getLastStockCheckDate()));
            if (s.getDiscount() != null) {
                st.setInt(4, s.getDiscount().getDiscountProductId());
            } else {
                st.setNull(4, java.sql.Types.INTEGER);
            }
            st.setString(5, s.getAlert());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void exportStock(StoreStock s) {
        String sql = "UPDATE StoreStock SET quantity_in_stock = ?, last_stock_check_date = ? WHERE store_stock_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, s.getStock());
            st.setDate(2, Date.valueOf(s.getLastStockCheckDate()));
            st.setInt(3, s.getStoreStockId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteStock(int id) {
        String sql = "delete from StoreStock where store_stock_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        StoreStockDAO c = new StoreStockDAO();
        List<StoreStock> list = c.getAllStoreStock();
        for (StoreStock storeStock : list) {
            System.out.println(storeStock);
        }
    }

    public StoreStock findByBarcode(String barcode) {
        String sql = "SELECT ss.*, i.*, p.*, dp.* FROM StoreStock ss "
                + "INNER JOIN Inventory i ON ss.inventory_id = i.inventory_id "
                + "INNER JOIN Products p ON i.product_id = p.product_id "
                + "LEFT JOIN DiscountProduct dp ON p.product_id = dp.product_id "
                + "WHERE p.barcode = ? AND ss.quantity_in_stock > 0";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, barcode);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                StoreStock storeStock = new StoreStock();
                storeStock.setStoreStockId(rs.getInt("store_stock_id"));

                // Set inventory
                Inventory inventory = getInventoryById(rs.getInt("inventory_id"));
                storeStock.setInventory(inventory);

                // Set quantity
                storeStock.setStock(rs.getInt("quantity_in_stock"));

                // Set last check date
                storeStock.setLastStockCheckDate(rs.getDate("last_stock_check_date").toLocalDate());

                // Set discount if exists
                int discountProductId = rs.getInt("discount_product_id");
                if (!rs.wasNull()) {
                    DiscountProduct dp = getDiscountProductById(discountProductId);
                    storeStock.setDiscount(dp);
                }

                storeStock.setAlert(rs.getString("alert"));
                return storeStock;
            }
        } catch (SQLException e) {
            System.out.println("Error in findByBarcode: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    private StoreStock mapResultSetToStoreStock(ResultSet rs) throws SQLException {
        StoreStock stock = new StoreStock();
        stock.setStoreStockId(rs.getInt("store_stock_id"));
        stock.setStock(rs.getInt("quantity_in_stock"));
        Date sqlDate = rs.getDate("last_stock_check_date");
        if (sqlDate != null) {
            stock.setLastStockCheckDate(sqlDate.toLocalDate());
        }
        stock.setAlert(rs.getString("alert"));

        // Load Inventory
        int inventoryId = rs.getInt("inventory_id");
        InventoryDAO inventoryDAO = new InventoryDAO();
        Inventory inventory = inventoryDAO.getInventoryById(inventoryId);
        stock.setInventory(inventory);

        // Load Discount
        int discountId = rs.getInt("discount_product_id");
        if (!rs.wasNull()) {
            DiscountProductDAO discountDAO = new DiscountProductDAO();
            DiscountProduct discount = discountDAO.getDiscountById(discountId);
            stock.setDiscount(discount);
        }

        return stock;
    }

    public List<StoreStock> getAllInStock() {
        List<StoreStock> list = new ArrayList<>();
        String sql = "SELECT * FROM StoreStock WHERE quantity_in_stock > 0";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                StoreStock stock = new StoreStock();
                stock.setStoreStockId(rs.getInt("store_stock_id"));
                Inventory inventory = getInventoryById(rs.getInt("inventory_id"));
                stock.setInventory(inventory);
                stock.setStock(rs.getInt("quantity_in_stock"));
                stock.setLastStockCheckDate(rs.getDate("last_stock_check_date").toLocalDate());
                DiscountProduct dp = getDiscountProductById(rs.getInt("discount_product_id"));
                stock.setDiscount(dp);
                stock.setAlert(rs.getString("alert"));
                list.add(stock);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi truy vấn StoreStock: " + e.getMessage());
        }

        return list;
    }

    public List<StoreStock> searchInStockByName(String keyword) {
        List<StoreStock> list = new ArrayList<>();
        String sql = """
            SELECT ss.* FROM StoreStock ss
            JOIN Inventory i ON ss.inventory_id = i.inventory_id
            JOIN Products p ON i.product_id = p.product_id
            WHERE ss.quantity_in_stock > 0 AND p.product_name LIKE ?
            """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToStoreStock(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<StoreStock> getInStockByCategory(int categoryId) {
        List<StoreStock> list = new ArrayList<>();
        String sql = """
            SELECT ss.* FROM StoreStock ss
            JOIN Inventory i ON ss.inventory_id = i.inventory_id
            JOIN Products p ON i.product_id = p.product_id
            WHERE ss.quantity_in_stock > 0 AND p.category_id = ?
            """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToStoreStock(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
