package dao;

import java.util.List;
import java.util.ArrayList;
import java.sql.*;
import model.Employees;

public class EmployeeDAO extends DBContext {

    public List<Employees> getAllEmployee() {
        List<Employees> employeeList = new ArrayList<>();
        try {
            String sql = "Select * from Employees";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Employees employee = new Employees();
                employee.setId(rs.getInt(1));
                employee.setName(rs.getString(2));
                employee.setPhone(rs.getString(3));
                employee.setAddress(rs.getString(4));
                employee.setAccountId(rs.getInt(5));

                employeeList.add(employee);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employeeList;
    }

    public Employees getEmployeeById(int id) {
        Employees emp = null;
        String sql = "SELECT employee_id, employee_name, employee_phone, employee_address, account_id FROM Employees WHERE employee_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                emp = new Employees();
                emp.setId(rs.getInt("employee_id"));
                emp.setName(rs.getString("employee_name"));
                emp.setPhone(rs.getString("employee_phone"));
                emp.setAddress(rs.getString("employee_address"));
                emp.setAccountId(rs.getInt("account_id"));
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return emp;
    }

    public void addEmployee(Employees employee) {
        try {
            String sql = "Insert into Employees (employee_name, employee_phone, employee_address, account_id)"
                    + "values (?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            stm.setString(1, employee.getName());
            stm.setString(2, employee.getPhone());
            stm.setString(3, employee.getAddress());
            stm.setInt(4, employee.getAccountId());

            stm.executeUpdate();

            // Lấy ID tự tăng và gán lại cho đối tượng nếu cần
            try (ResultSet rs = stm.getGeneratedKeys()) {
                if (rs.next()) {
                    employee.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error when inserting employee", e);
        }
    }

    public List<Employees> searchEmployee(String keyword) throws SQLException {
        List<Employees> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees WHERE LOWER(employee_name) LIKE ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword.toLowerCase() + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Employees emp = new Employees(
                        rs.getString("employee_name"),
                        rs.getString("employee_phone"),
                        rs.getString("employee_address"),
                        rs.getInt("account_id")
                );
                employees.add(emp);
            }
        }
        return employees;
    }

    public void deleteEmployeeById(int id) {
        String sql = "DELETE FROM Employees WHERE employee_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateEmployeeById(Employees emp) {
        String sql = "UPDATE Employees SET employee_name = ?, employee_phone = ?, employee_address = ? WHERE employee_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, emp.getName());
            ps.setString(2, emp.getPhone());
            ps.setString(3, emp.getAddress());
            ps.setInt(4, emp.getId());
            
            int rowsUpdated = ps.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Integer getEmployeeIdByAccountId(int accountId) {
        String sql = "select employee_id from employees where account_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("employee_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    

//    public static void main(String[] args) {
//        EmployeeDAO dao = new EmployeeDAO();
//        Integer id = dao.getEmployeeIdByAccountId(2);
//            System.out.println(id);
//    }
}
