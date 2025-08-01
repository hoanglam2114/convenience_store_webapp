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
    public List<ProductCategories> getAllCategoriesWithGroup() {
        List<ProductCategories> list = new ArrayList<>();
        String sql = "SELECT category_id, category_name, group_id FROM Product_Categories ORDER BY category_name";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ProductCategories(rs.getInt("category_id"), rs.getString("category_name"), rs.getInt("group_id")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<ProductCategories> getCategoriesByGroup(int groupId) {
        List<ProductCategories> list = new ArrayList<>();
        String sql = "SELECT category_id, category_name, group_id FROM Product_Categories WHERE group_id = ? ORDER BY category_name";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, groupId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new ProductCategories(rs.getInt("id"), rs.getString("name"), rs.getInt("group_id")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
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

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<ProductCategories> findCategoryByName(String category_name) {
        String sql = "select * from Product_Categories where category_name COLLATE Latin1_General_CI_AI LIKE ?";
        List<ProductCategories> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + category_name + "%");
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
    
    
    public void insertCategory(ProductCategories c) {
        String sql = "insert into Product_Categories values(?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getName());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    
    
     public ProductCategories getCategoryByName(String category_name) {
        String sql = "select * from Product_Categories where category_name like ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, category_name);
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
    
    
    public void updateCategory(ProductCategories c) {
        String sql = "UPDATE [dbo].[Product_Categories]\n"
                + "   SET [category_name] = ?\n"
                + " WHERE category_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getName());
            st.setInt(2, c.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void deleteCategory(int id) {
        String sql = "delete from Product_Categories where category_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        ProductCategoriesDAO dao = new ProductCategoriesDAO();
        List<ProductCategories> list = dao.getAllCategoriesWithGroup();
        for (ProductCategories pc : list) {
            System.out.println(pc);
        }
    }
}
