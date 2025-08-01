/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.HistoryPrice;
import model.ProductCategories;
import model.Products;
import model.Suppliers;
import model.WeightUnit;

/**
 *
 * @author admin
 */
public class ProductsDAO extends DBContext {
    public List<Products> getAllProduct() {
        List<Products> listProducts = new ArrayList<>();
        String sql = "Select [product_id],\n"
                + "       [category_id],\n"
                + "       [barcode],\n"
                + "       [product_name],\n"
                + "       [product_price],\n"
                + "       [weight_unit_id],\n"
                + "       [supplier_id],\n"
                + "       [product_image]\n"
                + " from Products\n";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("product_id"));
                p.setBarcode(rs.getString("barcode"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getFloat("product_price"));
                p.setImage(rs.getString("product_image"));
                ProductCategories pc = getCategoryById(rs.getInt("category_id"));
                p.setProductCategories(pc);
                WeightUnit wu = getWUById(rs.getInt("weight_unit_id"));
                p.setWeightUnit(wu);
                Suppliers sup = getSupById(rs.getInt("supplier_id"));
                p.setSuppliers(sup);
                listProducts.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listProducts;
    }

    public WeightUnit getWUById(int weight_unit_id) {
        String sql = "select * from Weight_unit where weight_unit_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, weight_unit_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                WeightUnit wu = new WeightUnit(rs.getInt("weight_unit_id"),
                        rs.getString("unit_name"));
                return wu;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Suppliers getSupById(int supplier_id) {
        String sql = "select * from Suppliers where supplier_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, supplier_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Suppliers sup = new Suppliers(
                        rs.getInt("supplier_id"),
                        rs.getString("supplier_name"),
                        rs.getString("supplier_address"),
                        rs.getString("supplier_phone"),
                        rs.getString("supplier_email"),
                        rs.getString("supplier_contact_person"),
                        rs.getString("image"),
                        rs.getString("status")
                );
                return sup;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ProductCategories getCategoryById(int category_id) {
        String sql = "select * from Product_Categories where category_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, category_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductCategories pc = new ProductCategories(rs.getInt("category_id"),
                        rs.getString("category_name"));
                return pc;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int getTotalProduct() {
        String sql = "select COUNT(*) from [dbo].[Products]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public Products getProductById(int product_id) {
        String sql = "select * from Products where product_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, product_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("product_id"));
                p.setBarcode(rs.getString("barcode"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getFloat("product_price"));
                p.setImage(rs.getString("product_image"));
                ProductCategories pc = getCategoryById(rs.getInt("category_id"));
                p.setProductCategories(pc);
                WeightUnit wu = getWUById(rs.getInt("weight_unit_id"));
                p.setWeightUnit(wu);
                Suppliers sup = getSupById(rs.getInt("supplier_id"));
                p.setSuppliers(sup);

                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Products getProductByIdHasDes(int product_id) {
        String sql = "select * from Products where product_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, product_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("product_id"));
                p.setBarcode(rs.getString("barcode"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getFloat("product_price"));
                p.setImage(rs.getString("product_image"));
                p.setDescription(rs.getString("description"));
                ProductCategories pc = getCategoryById(rs.getInt("category_id"));
                p.setProductCategories(pc);
                WeightUnit wu = getWUById(rs.getInt("weight_unit_id"));
                p.setWeightUnit(wu);
                Suppliers sup = getSupById(rs.getInt("supplier_id"));
                p.setSuppliers(sup);

                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Products> pagingProducts(int index) {
        List<Products> list = new ArrayList<>();
        String sql = "select [product_id],\n"
                + "       [category_id],\n"
                + "       [barcode],\n"
                + "       [product_name],\n"
                + "       [product_price],\n"
                + "       [weight_unit_id],\n"
                + "       [supplier_id],\n"
                + "       [product_image]\n"
                + "from Products\n"
                + "order by product_id\n"
                + "offset ?  rows fetch next 5 rows only";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (index - 1) * 5);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("product_id"));
                p.setBarcode(rs.getString("barcode"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getFloat("product_price"));
                p.setImage(rs.getString("product_image"));
                ProductCategories pc = getCategoryById(rs.getInt("category_id"));
                p.setProductCategories(pc);
                WeightUnit wu = getWUById(rs.getInt("weight_unit_id"));
                p.setWeightUnit(wu);
                Suppliers sup = getSupById(rs.getInt("supplier_id"));
                p.setSuppliers(sup);
                list.add(p);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public List<Products> searchProductByName(String product_name) {
        String sql = "select * from Products where product_name like ?";
        List<Products> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + product_name + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("product_id"));
                p.setBarcode(rs.getString("barcode"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getFloat("product_price"));
                p.setImage(rs.getString("product_image"));
                ProductCategories pc = getCategoryById(rs.getInt("category_id"));
                p.setProductCategories(pc);
                WeightUnit wu = getWUById(rs.getInt("weight_unit_id"));
                p.setWeightUnit(wu);
                Suppliers sup = getSupById(rs.getInt("supplier_id"));
                p.setSuppliers(sup);

                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Products getProductByName(String product_name) {
        String sql = "select * from Products where product_name like ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, product_name);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("product_id"));
                p.setBarcode(rs.getString("barcode"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getFloat("product_price"));
                p.setImage(rs.getString("product_image"));
                ProductCategories pc = getCategoryById(rs.getInt("category_id"));
                p.setProductCategories(pc);
                WeightUnit wu = getWUById(rs.getInt("weight_unit_id"));
                p.setWeightUnit(wu);
                Suppliers sup = getSupById(rs.getInt("supplier_id"));
                p.setSuppliers(sup);

                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void insertPro(Products p) {
        String sql = "INSERT INTO SWP_PROJECT.dbo.Products (\n" +
                "    category_id,\n" +
                "    barcode,\n" +
                "    product_name,\n" +
                "    product_price,\n" +
                "    weight_unit_id,\n" +
                "    supplier_id,\n" +
                "    product_image\n" +
                ") VALUES (\n" +
                "    ?, ?, ?, ?, ?, ?, ?\n" +
                ");\n";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, p.getProductCategories().getId());
            st.setString(2, p.getBarcode());
            st.setString(3, p.getName());
            st.setFloat(4, p.getPrice());
            st.setInt(5, p.getWeightUnit().getId());
            st.setInt(6, p.getSuppliers().getId());
            st.setString(7, p.getImage());

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateProduct(Products p) {
        String sql = "UPDATE [dbo].[Products]\n"
                + "   SET [category_id] = ? \n"
                + "      ,[barcode] = ?\n"
                + "      ,[product_name] = ?\n"
                + "      ,[product_price] = ?\n"
                + "      ,[weight_unit_id] = ?\n"
                + "      ,[supplier_id] = ?\n"
                + "      ,[product_image] = ?\n"
                + " WHERE product_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, p.getProductCategories().getId());
            st.setString(2, p.getBarcode());
            st.setString(3, p.getName());
            st.setFloat(4, p.getPrice());
            st.setInt(5, p.getWeightUnit().getId());
            st.setInt(6, p.getSuppliers().getId());
            st.setString(7, p.getImage());
            st.setInt(8, p.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    /**
     * This method retrieves the latest product from the Products table. It uses
     * a SQL query to select the top 1 product ordered by product_id in
     * descending order.
     *
     * @return the latest Products object or null if no product is found
     */
    public Products getLatestProduct() {
        String sql = "SELECT TOP 1 * FROM Products\n"
                + "ORDER BY product_id DESC;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("product_id"));
                p.setBarcode(rs.getString("barcode"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getFloat("product_price"));
                p.setImage(rs.getString("product_image"));
                ProductCategories pc = getCategoryById(rs.getInt("category_id"));
                p.setProductCategories(pc);
                WeightUnit wu = getWUById(rs.getInt("weight_unit_id"));
                p.setWeightUnit(wu);
                Suppliers sup = getSupById(rs.getInt("supplier_id"));
                p.setSuppliers(sup);

                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null; // Trả về null nếu không tìm thấy sản phẩm
    }

    public void deleteProduct(int id) {
        String sql = "delete from Products where product_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insertHisPrice(HistoryPrice h) {
        String sql = "INSERT INTO HistoryPrice VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, h.getProduct().getId());
            st.setFloat(2, h.getPrice());
            st.setFloat(3, h.getPriceBefore());
            st.setTimestamp(4, Timestamp.valueOf(h.getUpdatedAt()));
            st.setString(5, h.getStatus());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateProductPrice(int productId, float newPrice) {
        String sql = "UPDATE Products SET product_price = ? WHERE product_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setFloat(1, newPrice); // Set giá mới
            st.setInt(2, productId); // Set product_id
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<HistoryPrice> getHistoryById(int product_id) {
        List<HistoryPrice> list = new ArrayList<>();

        String sql = "select * from HistoryPrice where product_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, product_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                HistoryPrice h = new HistoryPrice();
                h.setHistoryId(rs.getInt("history_id"));
                Products p = getProductById(rs.getInt("product_id"));
                h.setProduct(p);
                h.setPrice(rs.getFloat("price"));
                h.setPriceBefore(rs.getFloat("price_before"));
                h.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                h.setStatus(rs.getString("status"));
                list.add(h);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    /**
     * This method retrieves a list of products that are not present in the
     * inventory. It uses a SQL query to select products from the Products table
     * where there is no corresponding entry in the Inventory table.
     *
     * @return a list of Products that are not in the inventory
     */
    public List<Products> getProductNotInInventory() {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT p.*\n"
                + "FROM Products p\n"
                + "WHERE NOT EXISTS (\n"
                + "    SELECT 1\n"
                + "    FROM Inventory i\n"
                + "    WHERE p.product_id = i.product_id\n"
                + ");";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("product_id"));
                p.setBarcode(rs.getString("barcode"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getFloat("product_price"));
                p.setImage(rs.getString("product_image"));
                ProductCategories pc = getCategoryById(rs.getInt("category_id"));
                p.setProductCategories(pc);
                WeightUnit wu = getWUById(rs.getInt("weight_unit_id"));
                p.setWeightUnit(wu);
                Suppliers sup = getSupById(rs.getInt("supplier_id"));
                p.setSuppliers(sup);

                list.add(p);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void deleteHis(int id) {
        String sql = "DELETE FROM HistoryPrice where history_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean isBarcodeExists(String barcode) {
        boolean exists = false;
        String sql = "SELECT 1 FROM Products WHERE barcode = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, barcode);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    exists = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }

    public List<Products> searchProducts(String keyword, Integer categoryId) {
        List<Products> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND product_name LIKE ?");
        }
        if (categoryId != null) {
            sql.append(" AND category_id = ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
            }
            if (categoryId != null) {
                ps.setInt(index++, categoryId);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("product_id"));
                p.setBarcode(rs.getString("barcode"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getFloat("product_price"));
                p.setImage(rs.getString("product_image"));
                ProductCategories pc = getCategoryById(rs.getInt("category_id"));
                p.setProductCategories(pc);
                WeightUnit wu = getWUById(rs.getInt("weight_unit_id"));
                p.setWeightUnit(wu);
                Suppliers sup = getSupById(rs.getInt("supplier_id"));
                p.setSuppliers(sup);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        ProductsDAO dao = new ProductsDAO();
        Products p = dao.getProductById(1);
        System.out.println(p.toString());
    }

}
