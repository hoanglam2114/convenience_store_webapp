/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.DiscountProduct;

/**
 *
 * @author admin
 */
public class DiscountProductDAO extends DBContext {

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

    public static void main(String[] args) {
        DiscountProductDAO dp = new DiscountProductDAO();
        List<DiscountProduct> list = dp.getAllProductDiscount();
        for (DiscountProduct discountProduct : list) {
            System.out.println(discountProduct);
        }
    }
}
