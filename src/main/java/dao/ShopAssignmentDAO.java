package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ShopAssignment;

public class ShopAssignmentDAO extends DBContext {
    
    // Get all shop assignments with employee and shop details
    public List<ShopAssignment> getAllShopAssignments() {
        List<ShopAssignment> assignments = new ArrayList<>();
        String sql = "SELECT sa.assignment_id, sa.employee_id, sa.shop_id, sa.assignment_role, " +
                     "sa.start_date, sa.end_date, sa.is_active, sa.created_at, sa.updated_at, " +
                     "e.employee_name, e.employee_phone, e.employee_address, " +
                     "sd.shop_name, sd.shop_address, sd.shop_phone, " +
                      "sd.shop_email, sd.shop_opening_hours " +
                      "FROM [ShopAssignments] sa " +
                      "JOIN [Employees] e ON sa.employee_id = e.employee_id " +
                      "JOIN [ShopDetails] sd ON sa.shop_id = sd.shop_id " +
                      "ORDER BY sd.shop_name, sa.assignment_role DESC, e.employee_name";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ShopAssignment assignment = new ShopAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setEmployeeId(rs.getInt("employee_id"));
                assignment.setShopId(rs.getInt("shop_id"));
                assignment.setAssignmentRole(rs.getString("assignment_role"));
                assignment.setStartDate(rs.getTimestamp("start_date"));
                assignment.setEndDate(rs.getTimestamp("end_date"));
                assignment.setActive(rs.getBoolean("is_active"));
                assignment.setCreatedAt(rs.getTimestamp("created_at"));
                assignment.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                // Employee details
                assignment.setEmployeeName(rs.getString("employee_name"));
                assignment.setEmployeePhone(rs.getString("employee_phone"));
                assignment.setEmployeeAddress(rs.getString("employee_address"));
                
                // Shop details
                assignment.setShopName(rs.getString("shop_name"));
                assignment.setShopAddress(rs.getString("shop_address"));
                assignment.setShopPhone(rs.getString("shop_phone"));
                assignment.setShopEmail(rs.getString("shop_email"));
                assignment.setShopOpeningHours(rs.getString("shop_opening_hours"));
                
                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return assignments;
    }
    
    // Get assignments by shop ID
    public List<ShopAssignment> getAssignmentsByShopId(int shopId) {
        List<ShopAssignment> assignments = new ArrayList<>();
        String sql = "SELECT sa.assignment_id, sa.employee_id, sa.shop_id, sa.assignment_role, " +
                    "sa.start_date, sa.end_date, sa.is_active, sa.created_at, sa.updated_at, " +
                    "e.employee_name, e.employee_phone, e.employee_address, " +
                     "sd.shop_name, sd.shop_address, sd.shop_phone, " +
                     "sd.shop_email, sd.shop_opening_hours " +
                     "FROM [ShopAssignments] sa " +
                     "JOIN [Employees] e ON sa.employee_id = e.employee_id " +
                     "JOIN [ShopDetails] sd ON sa.shop_id = sd.shop_id " +
                     "WHERE sa.shop_id = ? " +
                     "ORDER BY sa.assignment_role DESC, e.employee_name";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, shopId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ShopAssignment assignment = new ShopAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setEmployeeId(rs.getInt("employee_id"));
                assignment.setShopId(rs.getInt("shop_id"));
                assignment.setAssignmentRole(rs.getString("assignment_role"));
                assignment.setStartDate(rs.getTimestamp("start_date"));
                assignment.setEndDate(rs.getTimestamp("end_date"));
                assignment.setActive(rs.getBoolean("is_active"));
                assignment.setCreatedAt(rs.getTimestamp("created_at"));
                assignment.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                // Employee details
                assignment.setEmployeeName(rs.getString("employee_name"));
                assignment.setEmployeePhone(rs.getString("employee_phone"));
                assignment.setEmployeeAddress(rs.getString("employee_address"));
                
                // Shop details
                assignment.setShopName(rs.getString("shop_name"));
                assignment.setShopAddress(rs.getString("shop_address"));
                assignment.setShopPhone(rs.getString("shop_phone"));
                assignment.setShopEmail(rs.getString("shop_email"));
                assignment.setShopOpeningHours(rs.getString("shop_opening_hours"));
                
                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return assignments;
    }
    
    // Get assignment by ID
    public ShopAssignment getAssignmentById(int assignmentId) {
        ShopAssignment assignment = null;
        String sql = "SELECT sa.assignment_id, sa.employee_id, sa.shop_id, sa.assignment_role, " +
                    "sa.start_date, sa.end_date, sa.is_active, sa.created_at, sa.updated_at, " +
                    "e.employee_name, e.employee_phone, e.employee_address, " +
                     "sd.shop_name, sd.shop_address, sd.shop_phone, " +
                     "sd.shop_email, sd.shop_opening_hours " +
                     "FROM [ShopAssignments] sa " +
                     "JOIN [Employees] e ON sa.employee_id = e.employee_id " +
                     "JOIN [ShopDetails] sd ON sa.shop_id = sd.shop_id " +
                     "WHERE sa.assignment_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                assignment = new ShopAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setEmployeeId(rs.getInt("employee_id"));
                assignment.setShopId(rs.getInt("shop_id"));
                assignment.setAssignmentRole(rs.getString("assignment_role"));
                assignment.setStartDate(rs.getTimestamp("start_date"));
                assignment.setEndDate(rs.getTimestamp("end_date"));
                assignment.setActive(rs.getBoolean("is_active"));
                assignment.setCreatedAt(rs.getTimestamp("created_at"));
                assignment.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                // Employee details
                assignment.setEmployeeName(rs.getString("employee_name"));
                assignment.setEmployeePhone(rs.getString("employee_phone"));
                assignment.setEmployeeAddress(rs.getString("employee_address"));
                
                // Shop details
                assignment.setShopName(rs.getString("shop_name"));
                assignment.setShopAddress(rs.getString("shop_address"));
                assignment.setShopPhone(rs.getString("shop_phone"));
                assignment.setShopEmail(rs.getString("shop_email"));
                assignment.setShopOpeningHours(rs.getString("shop_opening_hours"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return assignment;
    }
    
    // Get shops grouped by location
    public List<ShopAssignment> getShopsGrouped() {
        List<ShopAssignment> shops = new ArrayList<>();
        String sql = "SELECT DISTINCT sd.shop_id, sd.shop_name, sd.shop_address, " +
                    "sd.shop_phone, sd.shop_email, sd.shop_opening_hours " +
                    "FROM [ShopDetails] sd " +
                    "ORDER BY sd.shop_name";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ShopAssignment shop = new ShopAssignment();
                shop.setShopId(rs.getInt("shop_id"));
                shop.setShopName(rs.getString("shop_name"));
                shop.setShopAddress(rs.getString("shop_address"));
                shop.setShopPhone(rs.getString("shop_phone"));
                shop.setShopEmail(rs.getString("shop_email"));
                shop.setShopOpeningHours(rs.getString("shop_opening_hours"));
                
                shops.add(shop);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return shops;
    }
    
    // Add new assignment
    public boolean addAssignment(ShopAssignment assignment) {
        String sql = "INSERT INTO [ShopAssignments] (employee_id, shop_id, assignment_role, " +
                    "start_date, end_date, is_active, created_at, updated_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignment.getEmployeeId());
            ps.setInt(2, assignment.getShopId());
            ps.setString(3, assignment.getAssignmentRole());
            ps.setTimestamp(4, assignment.getStartDate());
            ps.setTimestamp(5, assignment.getEndDate());
            ps.setBoolean(6, assignment.isActive());
            ps.setTimestamp(7, assignment.getCreatedAt());
            ps.setTimestamp(8, assignment.getUpdatedAt());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update assignment
    public boolean updateAssignment(ShopAssignment assignment) {
        String sql = "UPDATE [ShopAssignments] SET employee_id = ?, shop_id = ?, " +
                    "assignment_role = ?, start_date = ?, end_date = ?, is_active = ?, " +
                    "updated_at = ? WHERE assignment_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignment.getEmployeeId());
            ps.setInt(2, assignment.getShopId());
            ps.setString(3, assignment.getAssignmentRole());
            ps.setTimestamp(4, assignment.getStartDate());
            ps.setTimestamp(5, assignment.getEndDate());
            ps.setBoolean(6, assignment.isActive());
            ps.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
            ps.setInt(8, assignment.getAssignmentId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Check if assignment exists for employee and shop
    public ShopAssignment getAssignmentByEmployeeAndShop(int employeeId, int shopId) {
        ShopAssignment assignment = null;
        String sql = "SELECT sa.assignment_id, sa.employee_id, sa.shop_id, sa.assignment_role, " +
                    "sa.start_date, sa.end_date, sa.is_active, sa.created_at, sa.updated_at, " +
                    "e.employee_name, e.employee_phone, e.employee_address, " +
                     "sd.shop_name, sd.shop_address, sd.shop_phone, " +
                     "sd.shop_email, sd.shop_opening_hours " +
                     "FROM [ShopAssignments] sa " +
                     "JOIN [Employees] e ON sa.employee_id = e.employee_id " +
                     "JOIN [ShopDetails] sd ON sa.shop_id = sd.shop_id " +
                     "WHERE sa.employee_id = ? AND sa.shop_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ps.setInt(2, shopId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                assignment = new ShopAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setEmployeeId(rs.getInt("employee_id"));
                assignment.setShopId(rs.getInt("shop_id"));
                assignment.setAssignmentRole(rs.getString("assignment_role"));
                assignment.setStartDate(rs.getTimestamp("start_date"));
                assignment.setEndDate(rs.getTimestamp("end_date"));
                assignment.setActive(rs.getBoolean("is_active"));
                assignment.setCreatedAt(rs.getTimestamp("created_at"));
                assignment.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                // Employee details
                assignment.setEmployeeName(rs.getString("employee_name"));
                assignment.setEmployeePhone(rs.getString("employee_phone"));
                assignment.setEmployeeAddress(rs.getString("employee_address"));
                
                // Shop details
                assignment.setShopName(rs.getString("shop_name"));
                assignment.setShopAddress(rs.getString("shop_address"));
                assignment.setShopPhone(rs.getString("shop_phone"));
                assignment.setShopEmail(rs.getString("shop_email"));
                assignment.setShopOpeningHours(rs.getString("shop_opening_hours"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return assignment;
    }
    
    public boolean hasShopManager(int employeeId) {
    String sql = "SELECT COUNT(*) FROM ShopAssignments " +
                 "WHERE employee_id = ? " +
                 "AND assignment_role IN (N'Quản lý', 'Manager') " +
                 "AND is_active = 1";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, employeeId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

    public boolean shopHasOtherManager(int shopId, int excludeAssignmentId) {
    String sql = "SELECT COUNT(*) FROM ShopAssignments " +
                 "WHERE shop_id = ? AND assignment_role = 'Manager' AND is_active = 1 " +
                 "AND assignment_id != ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, shopId);
        ps.setInt(2, excludeAssignmentId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1) > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

    public boolean employeeIsManagerElsewhere(int employeeId, int currentShopId) {
    String sql = "SELECT COUNT(*) FROM ShopAssignments " +
                 "WHERE employee_id = ? AND shop_id != ? AND assignment_role = 'Manager' AND is_active = 1";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, employeeId);
        ps.setInt(2, currentShopId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1) > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

    
    // Delete assignment
    public boolean deleteAssignment(int assignmentId) {
        String sql = "DELETE FROM [ShopAssignments] WHERE assignment_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
