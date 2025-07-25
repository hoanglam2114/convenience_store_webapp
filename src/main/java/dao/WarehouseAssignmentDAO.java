package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.WarehouseAssignment;

public class WarehouseAssignmentDAO extends DBContext {

    // Get all warehouse assignments with employee and warehouse details
    public List<WarehouseAssignment> getAllWarehouseAssignments() {
        List<WarehouseAssignment> assignments = new ArrayList<>();
        String sql = "SELECT wa.assignment_id, wa.employee_id, wa.warehouse_id, wa.assignment_role, "
                + "wa.start_date, wa.end_date, wa.is_active, wa.created_at, wa.updated_at, "
                + "e.employee_name, e.employee_phone, e.employee_address, "
                + "w.name as warehouse_name, w.address as warehouse_address, w.phone as warehouse_phone, "
                + "w.working_hours as warehouse_working_hours "
                + "FROM [WarehouseAssignments] wa "
                + "JOIN [Employees] e ON wa.employee_id = e.employee_id "
                + "JOIN [Warehouses] w ON wa.warehouse_id = w.warehouse_id "
                + "ORDER BY w.name, wa.assignment_role DESC, e.employee_name";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WarehouseAssignment assignment = new WarehouseAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setEmployeeId(rs.getInt("employee_id"));
                assignment.setWarehouseId(rs.getInt("warehouse_id"));
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

                // Warehouse details
                assignment.setWarehouseName(rs.getString("warehouse_name"));
                assignment.setWarehouseAddress(rs.getString("warehouse_address"));
                assignment.setWarehousePhone(rs.getString("warehouse_phone"));
                assignment.setWarehouseWorkingHours(rs.getString("warehouse_working_hours"));

                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return assignments;
    }

    // Get assignments by warehouse ID
    public List<WarehouseAssignment> getAssignmentsByWarehouseId(int warehouseId) {
        List<WarehouseAssignment> assignments = new ArrayList<>();
        String sql = "SELECT wa.assignment_id, wa.employee_id, wa.warehouse_id, wa.assignment_role, "
                + "wa.start_date, wa.end_date, wa.is_active, wa.created_at, wa.updated_at, "
                + "e.employee_name, e.employee_phone, e.employee_address, "
                + "w.name as warehouse_name, w.address as warehouse_address, w.phone as warehouse_phone, "
                + "w.working_hours as warehouse_working_hours "
                + "FROM [WarehouseAssignments] wa "
                + "JOIN [Employees] e ON wa.employee_id = e.employee_id "
                + "JOIN [Warehouses] w ON wa.warehouse_id = w.warehouse_id "
                + "WHERE wa.warehouse_id = ? "
                + "ORDER BY wa.assignment_role DESC, e.employee_name";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, warehouseId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WarehouseAssignment assignment = new WarehouseAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setEmployeeId(rs.getInt("employee_id"));
                assignment.setWarehouseId(rs.getInt("warehouse_id"));
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

                // Warehouse details
                assignment.setWarehouseName(rs.getString("warehouse_name"));
                assignment.setWarehouseAddress(rs.getString("warehouse_address"));
                assignment.setWarehousePhone(rs.getString("warehouse_phone"));
                assignment.setWarehouseWorkingHours(rs.getString("warehouse_working_hours"));

                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return assignments;
    }

    // Get assignment by ID
    public WarehouseAssignment getAssignmentById(int assignmentId) {
        WarehouseAssignment assignment = null;
        String sql = "SELECT wa.assignment_id, wa.employee_id, wa.warehouse_id, wa.assignment_role, "
                + "wa.start_date, wa.end_date, wa.is_active, wa.created_at, wa.updated_at, "
                + "e.employee_name, e.employee_phone, e.employee_address, "
                + "w.name as warehouse_name, w.address as warehouse_address, w.phone as warehouse_phone, "
                + "w.working_hours as warehouse_working_hours "
                + "FROM [WarehouseAssignments] wa "
                + "JOIN [Employees] e ON wa.employee_id = e.employee_id "
                + "JOIN [Warehouses] w ON wa.warehouse_id = w.warehouse_id "
                + "WHERE wa.assignment_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                assignment = new WarehouseAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setEmployeeId(rs.getInt("employee_id"));
                assignment.setWarehouseId(rs.getInt("warehouse_id"));
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

                // Warehouse details
                assignment.setWarehouseName(rs.getString("warehouse_name"));
                assignment.setWarehouseAddress(rs.getString("warehouse_address"));
                assignment.setWarehousePhone(rs.getString("warehouse_phone"));
                assignment.setWarehouseWorkingHours(rs.getString("warehouse_working_hours"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return assignment;
    }

    // Get warehouses grouped by location
    public List<WarehouseAssignment> getWarehousesGrouped() {
        List<WarehouseAssignment> warehouses = new ArrayList<>();
        String sql = "SELECT DISTINCT w.warehouse_id, w.name as warehouse_name, w.address as warehouse_address, "
                + "w.phone as warehouse_phone, w.working_hours as warehouse_working_hours "
                + "FROM [Warehouses] w "
                + "ORDER BY w.name";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WarehouseAssignment warehouse = new WarehouseAssignment();
                warehouse.setWarehouseId(rs.getInt("warehouse_id"));
                warehouse.setWarehouseName(rs.getString("warehouse_name"));
                warehouse.setWarehouseAddress(rs.getString("warehouse_address"));
                warehouse.setWarehousePhone(rs.getString("warehouse_phone"));
                warehouse.setWarehouseWorkingHours(rs.getString("warehouse_working_hours"));

                warehouses.add(warehouse);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return warehouses;
    }

    // Add new assignment
    public boolean addAssignment(WarehouseAssignment assignment) {
        String sql = "INSERT INTO [WarehouseAssignments] (employee_id, warehouse_id, assignment_role, "
                + "start_date, end_date, is_active, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignment.getEmployeeId());
            ps.setInt(2, assignment.getWarehouseId());
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
    public boolean updateAssignment(WarehouseAssignment assignment) {
        String sql = "UPDATE [WarehouseAssignments] SET employee_id = ?, warehouse_id = ?, "
                + "assignment_role = ?, start_date = ?, end_date = ?, is_active = ?, "
                + "updated_at = ? WHERE assignment_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignment.getEmployeeId());
            ps.setInt(2, assignment.getWarehouseId());
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

    // Check if assignment exists for employee and warehouse
    public WarehouseAssignment getAssignmentByEmployeeAndWarehouse(int employeeId, int warehouseId) {
        WarehouseAssignment assignment = null;
        String sql = "SELECT wa.assignment_id, wa.employee_id, wa.warehouse_id, wa.assignment_role, "
                + "wa.start_date, wa.end_date, wa.is_active, wa.created_at, wa.updated_at, "
                + "e.employee_name, e.employee_phone, e.employee_address, "
                + "w.name as warehouse_name, w.address as warehouse_address, w.phone as warehouse_phone, "
                + "w.working_hours as warehouse_working_hours "
                + "FROM [WarehouseAssignments] wa "
                + "JOIN [Employees] e ON wa.employee_id = e.employee_id "
                + "JOIN [Warehouses] w ON wa.warehouse_id = w.warehouse_id "
                + "WHERE wa.employee_id = ? AND wa.warehouse_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ps.setInt(2, warehouseId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                assignment = new WarehouseAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setEmployeeId(rs.getInt("employee_id"));
                assignment.setWarehouseId(rs.getInt("warehouse_id"));
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

                // Warehouse details
                assignment.setWarehouseName(rs.getString("warehouse_name"));
                assignment.setWarehouseAddress(rs.getString("warehouse_address"));
                assignment.setWarehousePhone(rs.getString("warehouse_phone"));
                assignment.setWarehouseWorkingHours(rs.getString("warehouse_working_hours"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return assignment;
    }

    // Delete assignment
    public boolean deleteAssignment(int assignmentId) {
        String sql = "DELETE FROM [WarehouseAssignments] WHERE assignment_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean hasWarehouseManager(int employeeId) {
        String sql = "SELECT COUNT(*) FROM WarehouseAssignments "
                + "WHERE employee_id = ? "
                + "AND assignment_role IN (N'Quản lý', 'Manager') "
                + "AND is_active = 1";
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

    public boolean warehouseHasOtherManager(int warehouseId, int excludeAssignmentId) {
        String sql = "SELECT COUNT(*) FROM WarehouseAssignments "
                + "WHERE warehouse_id = ? AND assignment_role = 'Manager' AND is_active = 1 "
                + "AND assignment_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, warehouseId);
            ps.setInt(2, excludeAssignmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean employeeIsManagerElsewhere(int employeeId, int currentWarehouseId) {
        String sql = "SELECT COUNT(*) FROM WarehouseAssignments "
                + "WHERE employee_id = ? AND warehouse_id != ? AND assignment_role = 'Manager' AND is_active = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ps.setInt(2, currentWarehouseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean employeeHasActiveWarehouseElsewhere(int employeeId, int currentWarehouseId) {
        String sql = "SELECT COUNT(*) FROM [WarehouseAssignments] "
                + "WHERE employee_id = ? AND warehouse_id <> ? "
                + "AND is_active = 1 "
                + "AND (end_date IS NULL OR end_date > SYSDATETIME())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ps.setInt(2, currentWarehouseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        WarehouseAssignmentDAO d = new WarehouseAssignmentDAO();
        System.out.println(d.getAllWarehouseAssignments());
    }
}
