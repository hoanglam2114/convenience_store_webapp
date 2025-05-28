
package dal;

import java.util.List;
import java.util.ArrayList;
import java.sql.*;
import model.Employees;

public class EmployeeDAO extends DBContext{
    public List<Employees> getAllEmployee(){
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
    
    public void addEmployee(Employees employee){
        try{
            String sql = "Insert into Employees (employee_name, employee_phone, employee_address, account_id)"
                    + "values (Dung, 0937283432, Ha Noi, 2)";
            PreparedStatement stm = connection.prepareStatement(sql);
            
            stm.setString(1, employee.getName());
            stm.setString(2, employee.getPhone());
            stm.setString(3, employee.getAddress());
            stm.setInt(4, employee.getAccountId());
            
            stm.executeUpdate();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        EmployeeDAO dao = new EmployeeDAO();
        for(Employees e: dao.getAllEmployee()){
            System.out.println(e);
        }
    }
}
