/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Notification;
import java.sql.*;
import java.util.*;

public class NotificationDAO extends DBContext{
    
    public void insert(Notification n) {
        String sql = "INSERT INTO notifications (message, actor, type) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, n.getMessage());
            ps.setString(2, n.getActor());
            ps.setString(3, n.getType());
            ps.executeUpdate();
        }catch (SQLException e){
            System.out.println(e);
        }
    }

    public List<Notification> getAll() {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM Notifications ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notification n = new Notification();
                n.setId(rs.getInt("id"));
                n.setMessage(rs.getString("message"));
                n.setActor(rs.getString("actor"));
                n.setType(rs.getString("type"));
                n.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(n);
            }
        }catch (SQLException e){
            System.out.println(e);
        }
        return list;
    }
    
    public static void main(String[] args) {
        NotificationDAO dao = new NotificationDAO();
        List<Notification> notifications = dao.getAll();
        for (Notification notification : notifications) {
            System.out.println(notification);
        }
    }
}
