package dao;

import java.security.interfaces.RSAKey;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DiscountProduct;

public class DiscountProductDAO extends DBContext {

    public void insertPro(DiscountProduct p) {
        String sql = "INSERT INTO DiscountProduct VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, p.getProductId());
            st.setDouble(2, p.getPriceSell());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<DiscountProduct> getAllProductDiscount() {
        List<DiscountProduct> list = new ArrayList<>();

        String sql = "SELECT * from DiscountProduct";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                DiscountProduct p = new DiscountProduct();
                p.setDiscountProductId(rs.getInt(1));
                p.setProductId(rs.getInt(2));
                p.setPriceSell(rs.getDouble(3));

                list.add(p);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public boolean isProductExists(int productId) {
        String query = "SELECT COUNT(*) FROM DiscountProduct WHERE product_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, productId); // Gán giá trị cho placeholder

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0; // Nếu count lớn hơn 0, sản phẩm tồn tại
                }
            }
        } catch (SQLException e) {
        }

        return false; // Sản phẩm không tồn tại
    }

    public void updateProduct(DiscountProduct p) {
        String sql = "UPDATE [dbo].[DiscountProduct]\n"
                + "   SET [price_sell] = ?\n"
                + " WHERE product_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDouble(1, p.getPriceSell());
            st.setInt(2, p.getProductId());

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public DiscountProduct getDiscountById(int discountId) {
        String sql = "SELECT * FROM DiscountProduct WHERE discount_product_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, discountId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                DiscountProduct p = new DiscountProduct();
                p.setDiscountProductId(rs.getInt("discount_product_id"));
                p.setProductId(rs.getInt("product_id"));
                p.setPriceSell(rs.getDouble("price_sell"));
                return p;
            }
        } catch (SQLException e) {
            Logger.getLogger(DiscountProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public static void main(String[] args) {
        DiscountProductDAO d = new DiscountProductDAO();
        System.out.println(d.isProductExists(7));

    }
}
