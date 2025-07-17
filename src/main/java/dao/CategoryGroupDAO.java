package dao;

import model.CategoryGroup;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author hoang on 7/16/2025-4:00 PM
 * IntelliJ IDEA
 */
public class CategoryGroupDAO extends DBContext{
    public List<CategoryGroup> getAllGroups() {
        List<CategoryGroup> list = new ArrayList<>();
        String sql = "SELECT id, name FROM category_groups ORDER BY name";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new CategoryGroup(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
