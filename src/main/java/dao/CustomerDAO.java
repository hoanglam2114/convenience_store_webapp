package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Customers;

public class CustomerDAO extends DBContext {

    public List<Customers> getAllCustomer() {
        List<Customers> customerList = new ArrayList<>();
        try {
            String sql = "Select * from Customers";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Customers customer = new Customers();
                customer.setId(rs.getInt(1));
                customer.setName(rs.getString(2));
                customer.setPhone(rs.getString(3));
                customer.setPoint(rs.getInt(4));
                customer.setType_id(rs.getInt(5));
                customer.setGender(rs.getString(6));
                customer.setAvatarUrl(rs.getString(7));

                customerList.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customerList;
    }

    public void addCustomer(Customers customer) {
        try {
            String sql = "Insert into Customers (customer_name, customer_phone, point, customer_type_id)"
                    + "values (?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            stm.setString(1, customer.getName());
            stm.setString(2, customer.getPhone());
            stm.setInt(3, customer.getPoint());
            stm.setInt(4, customer.getType_id());

            stm.executeUpdate();

            // Lấy ID tự tăng và gán lại cho đối tượng nếu cần
            try (ResultSet rs = stm.getGeneratedKeys()) {
                if (rs.next()) {
                    customer.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error when inserting customer", e);
        }
    }

    public List<Customers> searchCustomer(String keyword) throws SQLException {
        List<Customers> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE customer_name COLLATE Latin1_General_CI_AI LIKE ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword.toLowerCase() + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Customers customer = new Customers(
                        rs.getString("customer_name"),
                        rs.getString("customer_phone"),
                        rs.getInt("point"),
                        rs.getInt("customer_type_id"),
                        rs.getString("gender"),
                        rs.getString("avatar_url")
                );
                customers.add(customer);
            }
        }
        return customers;
    }

    public void deleteCustomerById(int id) {
        String sql = "DELETE FROM Customers WHERE customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCustomerById(Customers customer) {
        String sql = "UPDATE Customers SET customer_name = ?, customer_phone = ?, point = ? WHERE customer_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, customer.getName());
            ps.setString(2, customer.getPhone());
            ps.setInt(3, customer.getPoint());
            ps.setInt(4, customer.getId());

            int rowsUpdated = ps.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean editCustomerById(int customerId, String newName, String gender, String avatarPath) {
        String sql = "UPDATE Customers SET customer_name = ?, gender = ?, avatar_url = ? WHERE customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, newName);
            ps.setString(2, gender);
            ps.setString(3, avatarPath);

            ps.setInt(4, customerId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Customers getCustomerById(int id) {
        String sql = "SELECT * FROM Customers WHERE customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Customers.builder()
                            .id(rs.getInt("customer_id"))
                            .name(rs.getString("customer_name"))
                            .phone(rs.getString("customer_phone"))
                            .gender(rs.getString("gender"))
                            .point(rs.getInt("point"))
                            .avatarUrl(rs.getString("avatar_url"))
                            .type_id(rs.getInt("customer_type_id"))
                            .build();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Customers> pagingCustomer(int index) {
        List<Customers> list = new ArrayList<>();
        String sql = "SELECT [customer_id],\n"
                + "       [customer_name],\n"
                + "       [customer_phone],\n"
                + "       [point],\n"
                + "       [customer_type_id] \n"
                + "from Customers\n"
                + "order by customer_id\n"
                + "offset ?  rows fetch next 5 rows only";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (index - 1) * 5);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Customers c = new Customers();
                c.setId(rs.getInt("customer_id"));
                c.setName(rs.getString("customer_name"));
                c.setPhone(rs.getString("customer_phone"));
                c.setPoint(rs.getInt("point"));
                c.setType_id(rs.getInt("customer_type_id"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public int getTotalCustomer() {
        String sql = "SELECT COUNT(*) from [dbo].[Customers]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public Customers findByPhone(String phone) {
        String sql = "SELECT * FROM Customers WHERE customer_phone = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, phone.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Customers(
                            rs.getInt("customer_id"),
                            rs.getString("customer_name"),
                            rs.getString("customer_phone"),
                            rs.getInt("point"),
                            rs.getInt("customer_type_id"),
                            rs.getString("gender"),
                            rs.getString("avatar_url")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Integer getCustomerIdByPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return null;
        }

        String sql = "SELECT customer_id FROM Customers WHERE customer_phone = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, phone.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("customer_id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null; 
    }


    public static void main(String[] args) {
        CustomerDAO dao = new CustomerDAO();
        Customers c = dao.findByPhone("0886801877");
        System.out.println(c.toString());
    }
}
