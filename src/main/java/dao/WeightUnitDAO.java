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
import model.WeightUnit;

/**
 *
 * @author admin
 */
public class WeightUnitDAO extends DBContext {
      public List<WeightUnit> getAll() {
        List<WeightUnit> list = new ArrayList<>();
        String sql = "select * from Weight_unit";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                WeightUnit pc = new WeightUnit(rs.getInt("weight_unit_id"),
                        rs.getString("unit_name"));
                list.add(pc);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
      
      
      
       public WeightUnit getUnitById(int weight_unit_id) {
        String sql = "select * from Weight_unit where weight_unit_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, weight_unit_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                WeightUnit pc = new WeightUnit(rs.getInt("weight_unit_id"),
                        rs.getString("unit_name"));
                return pc;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
      
      
      
      
      
      
      
      
      
    public static void main(String[] args) {
        WeightUnitDAO dao = new WeightUnitDAO();
//        List<WeightUnit>list = dao.getAll();
//        for(WeightUnit o: list){
//            System.out.println(o);
//        }
       WeightUnit wu = dao.getUnitById(1);
        System.out.println(wu);
    }
}
