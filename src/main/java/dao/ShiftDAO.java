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
import model.Shifts;

/**
 *
 * @author nguye
 */
public class ShiftDAO extends DBContext {
    public List<Shifts> getAll() {
        List<Shifts> list = new ArrayList<>();
        String sql = "SELECT SM.shift_manager_id, SM.shift_start_time, SM.shift_end_time, "
                + "SM.total_revenue, SM.total_hours, SM.notes, SM.employee_id, E.employee_name "
                + "FROM ShiftManagers SM "
                + "LEFT JOIN Employees E ON SM.employee_id = E.employee_id";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Shifts shift = new Shifts(
                        rs.getInt("shift_manager_id"),
                        rs.getTimestamp("shift_start_time") != null ? rs.getTimestamp("shift_start_time").toLocalDateTime() : null,
                        rs.getTimestamp("shift_end_time") != null ? rs.getTimestamp("shift_end_time").toLocalDateTime() : null,
                        rs.getBigDecimal("total_revenue"),
                        rs.getBigDecimal("total_hours"),
                        rs.getString("notes"),
                        rs.getInt("employee_id"),
                        rs.getString("employee_name")
                );
                list.add(shift);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching shifts: " + e.getMessage());
        }
        return list;
    }

    // Lấy thông tin ca làm của nhân viên theo id
    public Shifts getShiftById(int shiftManagerId) {
        Shifts shift = null;
        String sql = "SELECT ShiftManagers.*, Employees.employee_name "
                + "FROM ShiftManagers "
                + "JOIN Employees ON ShiftManagers.employee_id = Employees.employee_id WHERE shift_manager_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, shiftManagerId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                shift = new Shifts(
                        rs.getInt("shift_manager_id"),
                        rs.getTimestamp("shift_start_time") != null ? rs.getTimestamp("shift_start_time").toLocalDateTime() : null,
                        rs.getTimestamp("shift_end_time") != null ? rs.getTimestamp("shift_end_time").toLocalDateTime() : null,
                        rs.getBigDecimal("total_revenue"),
                        rs.getBigDecimal("total_hours"),
                        rs.getString("notes"),
                        rs.getInt("employee_id"),
                        rs.getString("employee_name")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shift;
    }

    // Cập nhật thông tin ca làm
    public void updateShift(Shifts shift) {
        String sql = "UPDATE ShiftManagers SET total_revenue = ? WHERE shift_manager_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setBigDecimal(1, shift.getTotalRevenue());
            statement.setInt(2, shift.getShiftManageId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa ca làm
    public void deleteShift(String id) {
        String sql = "DELETE FROM ShiftManagers WHERE shift_manager_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Integer getCurrentShiftManagerId(int employeeId) throws SQLException {
        String sql = "SELECT TOP 1 shift_manager_id FROM ShiftManagers "
                + "WHERE employee_id = ? AND shift_end_time IS NULL "
                + "ORDER BY shift_start_time DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("shift_manager_id");
                }
            }
        }
        return null; // Trả về null nếu không tìm thấy ca làm việc hiện tại
    }
}
