package dao;

import model.EmployeeStoreAssignment;
import java.sql.*;
import java.util.*;

public class EmployeeStoreAssignmentDAO extends DBContext {

    // 1. Gán nhân viên vào cửa hàng
    public boolean assignEmployeeToShopWithShift(int employeeId, int shopId, int shiftId) {
        String sql = "INSERT INTO EmployeeStoreAssignment (employee_id, shop_id, shift_id) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ps.setInt(2, shopId);
            ps.setInt(3, shiftId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("assignEmployeeToShopWithShift ERROR: " + e.getMessage());
            return false;
        }
    }

    public boolean assignEmployeeToShop(int employeeId, int shopId) {
        String sql = "INSERT INTO EmployeeStoreAssignment (employee_id, shop_id) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ps.setInt(2, shopId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("assignEmployeeToShop ERROR: " + e.getMessage());
            return false;
        }
    }

    public boolean employeeIsAssigned(int employeeId) {
        String sql = "SELECT COUNT(*) FROM EmployeeStoreAssignment WHERE employee_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("employeeIsAssigned ERROR: " + e.getMessage());
        }
        return false;
    }

    // 2. Kiểm tra cửa hàng đã có manager chưa (qua liên kết account -> role_id = 3 là 'manager')
    public boolean shopHasManager(int shopId) {
        String sql = "SELECT COUNT(*) AS total\n"
                + "FROM EmployeeStoreAssignment esa\n"
                + "JOIN Employees e ON esa.employee_id = e.employee_id\n"
                + "JOIN Accounts a ON e.account_id = a.account_id\n"
                + "WHERE esa.shop_id = ? AND a.role_id = 3";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, shopId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total") > 0;
            }
        } catch (SQLException e) {
            System.out.println("shopHasManager ERROR: " + e.getMessage());
        }
        return false;
    }

    public List<EmployeeStoreAssignment> getAllAssignmentsWithDetails() {
        List<EmployeeStoreAssignment> list = new ArrayList<>();

        String sql = """
        SELECT esa.employee_id, e.employee_name, r.role_name,
                       esa.shop_id, s.shop_name, w.name
                FROM EmployeeStoreAssignment esa
                JOIN Employees e ON esa.employee_id = e.employee_id
                JOIN Accounts a ON e.account_id = a.account_id
                JOIN Roles r ON a.role_id = r.role_id
                JOIN ShopDetails s ON esa.shop_id = s.shop_id
        	JOIN Warehouses w on w.warehouse_id = s.warehouse_id
               
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                EmployeeStoreAssignment a = new EmployeeStoreAssignment();
                a.setEmployee_id(rs.getInt("employee_id"));
                a.setEmployeeName(rs.getString("employee_name"));
                a.setRoleName(rs.getString("role_name"));
                a.setStore_id(rs.getInt("shop_id"));
                a.setShopName(rs.getString("shop_name"));
                a.setWarehouseName(rs.getString("name"));
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println("getAllAssignmentsWithDetails ERROR: " + e.getMessage());
        }

        return list;
    }

    public boolean updateAssignment(int oldEmpId, int oldShopId, int newEmpId, int newShopId) {
        String sql = "UPDATE EmployeeStoreAssignment SET employee_id = ?, shop_id = ? WHERE employee_id = ? AND shop_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newEmpId);
            ps.setInt(2, newShopId);
            ps.setInt(3, oldEmpId);
            ps.setInt(4, oldShopId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("updateAssignment ERROR: " + e.getMessage());
            return false;
        }
    }

    public boolean assignmentExists(int employeeId, int shopId) {
        String sql = "SELECT COUNT(*) FROM EmployeeStoreAssignment WHERE employee_id = ? AND shop_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ps.setInt(2, shopId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("assignmentExists ERROR: " + e.getMessage());
        }
        return false;
    }

    public boolean removeShiftFromAssignment(int employeeId, int shopId) {
        String sql = "DELETE FROM EmployeeStoreAssignment WHERE employee_id = ? AND shop_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ps.setInt(2, shopId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("removeShiftFromAssignment ERROR: " + e.getMessage());
            return false;
        }
    }
    
    public boolean hasOtherManagerInShop(int excludeEmpId, int shopId) {
    String sql = "SELECT COUNT(*) " +
                 "FROM EmployeeStoreAssignment esa " +
                 "JOIN Employees e ON esa.employee_id = e.employee_id " +
                 "JOIN Accounts a ON e.account_id = a.account_id " +
                 "WHERE esa.shop_id = ? AND a.role_id = 3 AND e.employee_id <> ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, shopId);
        ps.setInt(2, excludeEmpId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (SQLException e) {
        System.out.println("hasOtherManagerInShop ERROR: " + e.getMessage());
    }
    return false;
}


    // TEST MAIN
//    public static void main(String[] args) {
//        EmployeeStoreAssignmentDAO dao = new EmployeeStoreAssignmentDAO();
//        boolean hasManager = dao.shopHasManager(2);
//        System.out.println("Shop 1 has manager: " + hasManager);
//
//        boolean result = dao.assignEmployeeToShop(1, 2);
//        System.out.println("Assign success: " + result);
//
//        Map<String, Integer> stats = dao.countEmployeesByRole();
//        stats.forEach((role, count) -> System.out.println(role + ": " + count));
//    }
}
