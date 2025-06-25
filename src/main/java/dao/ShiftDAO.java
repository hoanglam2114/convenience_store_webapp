/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.Shift;

/**
 *
 * @author nguye
 */
public class ShiftDAO extends DBContext {
    public boolean addShift(Shift shift) {
        String sql = "INSERT INTO Shifts (shift_name, start_time, end_time, working_days, description) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, shift.getShiftName());
            ps.setTime(2, Time.valueOf(shift.getStartTime()));
            ps.setTime(3, Time.valueOf(shift.getEndTime()));
            ps.setString(4, String.join(",", shift.getWorkingDays())); // e.g. "Monday,Wednesday"
            ps.setString(5, shift.getDescription());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteShift(int shiftId) {
    String sql = "DELETE FROM Shifts WHERE shift_id = ?";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, shiftId);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return false;
}

    
    public Shift getShiftById(int id) {
    String sql = "SELECT * FROM Shifts WHERE shift_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Shift s = new Shift();
            s.setShiftId(rs.getInt("shift_id"));
            s.setShiftName(rs.getString("shift_name"));
            s.setStartTime(rs.getTime("start_time").toLocalTime());
            s.setEndTime(rs.getTime("end_time").toLocalTime());
            String days = rs.getString("working_days");
            s.setWorkingDays((days != null && !days.isBlank()) ? Arrays.asList(days.split(",")) : List.of());
            s.setDescription(rs.getString("description"));
            return s;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

    public boolean updateShift(Shift shift) {
    String sql = "UPDATE Shifts SET shift_name = ?, start_time = ?, end_time = ?, " +
                 "working_days = ?, description = ? WHERE shift_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, shift.getShiftName());
        ps.setTime(2, Time.valueOf(shift.getStartTime()));
        ps.setTime(3, Time.valueOf(shift.getEndTime()));
        ps.setString(4, String.join(",", shift.getWorkingDays()));
        ps.setString(5, shift.getDescription());
        ps.setInt(6, shift.getShiftId());
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

    
    public List<Shift> getAllShifts() {
    List<Shift> shiftList = new ArrayList<>();
    String sql = "SELECT shift_id, shift_name, start_time, end_time, working_days, description " +
                 "FROM Shifts ORDER BY shift_id";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Shift shift = new Shift();
            shift.setShiftId(rs.getInt("shift_id"));
            shift.setShiftName(rs.getString("shift_name"));
            shift.setStartTime(rs.getTime("start_time").toLocalTime());
            shift.setEndTime(rs.getTime("end_time").toLocalTime());

            String days = rs.getString("working_days");
            List<String> workingDays = (days != null && !days.isBlank())
                    ? Arrays.asList(days.split(","))
                    : new ArrayList<>();
            shift.setWorkingDays(workingDays);

            shift.setDescription(rs.getString("description"));

            shiftList.add(shift);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return shiftList;
}
    
    public List<Shift> pagingShift(int index) {
    List<Shift> list = new ArrayList<>();
    String sql = "SELECT * FROM Shifts ORDER BY shift_id OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
    
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, (index - 1) * 3); // index = 1 → 0, index = 2 → 3
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Shift s = new Shift();
            s.setShiftId(rs.getInt("shift_id"));
            s.setShiftName(rs.getString("shift_name"));
            s.setStartTime(rs.getTime("start_time").toLocalTime());
            s.setEndTime(rs.getTime("end_time").toLocalTime());
            s.setWorkingDays(Arrays.asList(rs.getString("working_days").split(",")));
            s.setDescription(rs.getString("description"));
            list.add(s);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}


    public int getTotalShift() {
    String sql = "SELECT COUNT(*) FROM Shifts";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1); // Lấy tổng số ca làm
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}


}
