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
import model.Suppliers;
import model.WeightUnit;

/**
 *
 * @author admin
 */
public class SuppliersDAO extends DBContext {

    public List<Suppliers> getAll() {
        List<Suppliers> list = new ArrayList<>();
        String sql = "select * from Suppliers";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Suppliers pc = new Suppliers(
                        rs.getInt("supplier_id"),
                        rs.getString("supplier_name"),
                        rs.getString("supplier_address"),
                        rs.getString("supplier_phone"),
                        rs.getString("supplier_email"),
                        rs.getString("supplier_contact_person"),
                        rs.getString("image")
                );
                list.add(pc);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Suppliers getSupById(int supplier_id) {
        String sql = "select * from Suppliers where supplier_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, supplier_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Suppliers s = new Suppliers(
                        rs.getInt("supplier_id"),
                        rs.getString("supplier_name"),
                        rs.getString("supplier_address"),
                        rs.getString("supplier_phone"),
                        rs.getString("supplier_email"),
                        rs.getString("supplier_contact_person"),
                        rs.getString("image")
                );
                return s;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        SuppliersDAO dao = new SuppliersDAO();
//        List<Suppliers> list = dao.getAll();
//        for (Suppliers o : list) {
//            System.out.println(o);
//        }
        Suppliers s = dao.getSupById(1);
        System.out.println(s);
    }
}
