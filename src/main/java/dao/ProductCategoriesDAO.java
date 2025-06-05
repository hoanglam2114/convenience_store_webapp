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
import model.ProductCategories;

/**
 *
 * @author admin
 */
public class ProductCategoriesDAO extends DBContext {

    public List<ProductCategories> getAll() {
        List<ProductCategories> list = new ArrayList<>();
        String sql = "select * from Product_Categories";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductCategories pc = new ProductCategories(rs.getInt("category_id"),
                        rs.getString("category_name"));
                list.add(pc);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
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
    
    
    public int getTotalProductCategory() {
        String sql = " select count(*) from [dbo].[Product_Categories]";
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

    public List<ProductCategories> pagingProductCategories(int index) {
        List<ProductCategories> list = new ArrayList<>();
        String sql = " select * from  [dbo].[Product_Categories]\n"
                + " order by category_id\n"
                + " offset ? rows fetch next 5 rows only";
         try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (index - 1) * 5);
            ResultSet rs = st.executeQuery();
             while (rs.next()) {
                ProductCategories pc = new ProductCategories();
                pc.setId(rs.getInt("category_id"));
                pc.setName(rs.getString("category_name"));
                list.add(pc);
             }
            
        }catch (SQLException e) {
               System.out.println(e);
        }
        return list;

    }

    public static void main(String[] args) {
        ProductCategoriesDAO dao = new ProductCategoriesDAO();
//        List<ProductCategories>list = dao.pagingProductCategories(2);
//        for(ProductCategories o: list){
//            System.out.println(o);
//        }
//        int count = dao.getTotalUnit();
//        System.out.println(count);

    }
}
