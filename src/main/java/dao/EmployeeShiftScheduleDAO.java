package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.EmployeeShiftSchedule;
import model.Employees;
import model.Shift;
import java.sql.Date;

public class EmployeeShiftScheduleDAO extends DBContext {

    private EmployeeShiftSchedule getFromResultSet(ResultSet rs) throws SQLException {
        EmployeeShiftSchedule schedule = new EmployeeShiftSchedule();
        schedule.setScheduleId(rs.getInt("schedule_id"));
        schedule.setEmployeeId(rs.getInt("employee_id"));
        schedule.setShiftId(rs.getInt("shift_id"));
        
        // Handle nullable integer fields
        int shopId = rs.getInt("shop_id");
        if (rs.wasNull()) {
            schedule.setShopId(null);
        } else {
            schedule.setShopId(shopId);
        }

        int warehouseId = rs.getInt("warehouse_id");
        if (rs.wasNull()) {
            schedule.setWarehouseId(null);
        } else {
            schedule.setWarehouseId(warehouseId);
        }
        
        schedule.setWorkDate(rs.getDate("work_date"));
        return schedule;
    }

    public boolean addEmployeeShiftSchedule(EmployeeShiftSchedule schedule) {
        String sql = "INSERT INTO [dbo].[EmployeeShiftSchedule] (employee_id, shift_id, shop_id, warehouse_id, work_date) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, schedule.getEmployeeId());
            ps.setInt(2, schedule.getShiftId());
            
            if (schedule.getShopId() != null) {
                ps.setInt(3, schedule.getShopId());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            
            if (schedule.getWarehouseId() != null) {
                ps.setInt(4, schedule.getWarehouseId());
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }
            
            ps.setDate(5, schedule.getWorkDate());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteEmployeeShiftSchedule(int scheduleId) {
        String sql = "DELETE FROM [dbo].[EmployeeShiftSchedule] WHERE schedule_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<EmployeeShiftSchedule> getSchedulesByShopAndDate(int shopId, Date workDate) {
        List<EmployeeShiftSchedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[EmployeeShiftSchedule] WHERE shop_id = ? AND work_date = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, shopId);
            ps.setDate(2, workDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                schedules.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }
    
    public List<EmployeeShiftSchedule> getSchedulesByWarehouseAndDate(int warehouseId, Date workDate) {
        List<EmployeeShiftSchedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[EmployeeShiftSchedule] WHERE warehouse_id = ? AND work_date = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, warehouseId);
            ps.setDate(2, workDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                schedules.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }
    
    public List<EmployeeShiftSchedule> getSchedulesByEmployeeAndDate(int employeeId, Date workDate) {
        List<EmployeeShiftSchedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[EmployeeShiftSchedule] WHERE employee_id = ? AND work_date = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ps.setDate(2, workDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                schedules.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }
} 