package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import model.CartItem;
//import model.Coupons;
import model.Order;
import model.OrderDetails;
import model.Products;

public class OrderDAO extends DBContext {

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.customer_coupon_id, c.customer_name, o.order_date, o.order_total_amount, \n"
                + "       o.order_status, e.employee_name, co.coupon_code, o.employee_id "
                + "FROM Orders o "
                + "LEFT JOIN Customers c ON o.customer_id = c.customer_id "
                + "LEFT JOIN Employees e ON o.employee_id = e.employee_id "
                + "LEFT JOIN CustomerCoupon cc ON o.customer_coupon_id = cc.customer_coupon_id "
                + "LEFT JOIN Coupons co ON cc.coupon_id = co.coupon_id";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerCouponId(rs.getObject("customer_coupon_id") != null ? rs.getInt("customer_coupon_id") : null);
                order.setCustomerName(rs.getString("customer_name"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setOrderTotalAmount(rs.getInt("order_total_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setEmployeeName(rs.getString("employee_name"));
                order.setCouponCode(rs.getString("coupon_code"));
                order.setEmployeeId(rs.getInt("employee_id"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close ResultSet, PreparedStatement
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return orders;
    }

//    public Order getOrderById(int orderId) {
//        Order order = null;
//        String sql = "SELECT o.order_id, o.customer_id, c.customer_name, o.order_date, "
//                + "o.order_total_amount, o.order_status, e.employee_name, co.coupon_code "
//                + "FROM Orders o "
//                + "LEFT JOIN Customers c ON o.customer_id = c.customer_id "
//                + "LEFT JOIN Employees e ON o.employee_id = e.employee_id "
//                + "LEFT JOIN CustomerCoupon cc ON o.customer_coupon_id = cc.customer_coupon_id "
//                + "LEFT JOIN Coupons co ON cc.coupon_id = co.coupon_id "
//                + "WHERE o.order_id = ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, orderId);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                order = new Order();
//                order.setOrderId(rs.getInt("order_id"));
//                order.setCustomerId(rs.getInt("customer_id")); // Thêm dòng này
//                order.setCustomerName(rs.getString("customer_name"));
//                order.setOrderDate(rs.getDate("order_date"));
//                order.setOrderTotalAmount(rs.getInt("order_total_amount"));
//                order.setOrderStatus(rs.getString("order_status"));
//                order.setEmployeeName(rs.getString("employee_name"));
//                order.setCouponCode(rs.getString("coupon_code"));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return order;
//    }
    //2. Temporary
    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT o.order_id, o.customer_id, c.customer_name, o.order_date, "
                + "o.order_total_amount, o.order_status, e.employee_name "
                + "FROM Orders o "
                + "LEFT JOIN Customers c ON o.customer_id = c.customer_id "
                + "LEFT JOIN Employees e ON o.employee_id = e.employee_id "
                + "WHERE o.order_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setOrderTotalAmount(rs.getInt("order_total_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setEmployeeName(rs.getString("employee_name"));
                order.setCouponCode(null); // Vì bạn chưa làm phần coupon
            } else {
                System.out.println("⚠️ Không tìm thấy đơn hàng với ID: " + orderId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    // Method to get order details by orderId
    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetails> orderDetails = new ArrayList<>();
        String sql = "SELECT p.product_name, od.quantity, od.unit_price, od.total_price "
                + "FROM OrdersDetails od "
                + "LEFT JOIN Products p ON od.product_id = p.product_id "
                + "WHERE od.order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetails detail = new OrderDetails();
                detail.setProductName(rs.getString("product_name"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setUnitPrice(rs.getDouble("unit_price"));
                detail.setTotalPrice(rs.getDouble("total_price"));
                orderDetails.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public boolean updateOrderStatus(Order order) {
        String sql = "UPDATE Orders SET order_status = ? WHERE order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, order.getOrderStatus());
            ps.setInt(2, order.getOrderId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteOrder(int orderId) {
        String deleteOrderDetailsSql = "DELETE FROM OrdersDetails WHERE order_id = ?";
        String deleteOrderSql = "DELETE FROM Orders WHERE order_id = ?";

        try {
            connection.setAutoCommit(false);

            // Delete order details first
            try (PreparedStatement psDetails = connection.prepareStatement(deleteOrderDetailsSql)) {
                psDetails.setInt(1, orderId);
                psDetails.executeUpdate();
            }

            // Then delete the order
            try (PreparedStatement psOrder = connection.prepareStatement(deleteOrderSql)) {
                psOrder.setInt(1, orderId);
                int rowsAffected = psOrder.executeUpdate();

                if (rowsAffected > 0) {
                    connection.commit();
                    return true;
                } else {
                    connection.rollback();
                    return false;
                }
            }
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Products> getAllProducts() {
        List<Products> products = new ArrayList<>();
        try {
            String sql = "SELECT product_id, product_name, product_price FROM Products";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getInt("product_price"));
                products.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllProducts: " + e);
        }
        return products;
    }

    //Add product to cart 
    public void addProductToCart(int customerId, int productId, int quantity) throws Exception {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be greater than 0");
        }

        // Create an order if one doesn't exist for the customer
        String createOrderSql = "INSERT INTO Orders (customer_id, order_date, order_status)"
                + " VALUES (?, GETDATE(), 'pending')"; // You might use a more specific status

        try (PreparedStatement createOrderStm = connection.prepareStatement(createOrderSql, new String[]{"order_id"})) {
            createOrderStm.setInt(1, customerId);

            int affectedRows = createOrderStm.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            ResultSet generatedKeys = createOrderStm.getGeneratedKeys();

            if (generatedKeys.next()) {
                int orderId = generatedKeys.getInt(1);

                //Insert product and OrderDetails
                String addProductToCartSql = "INSERT INTO OrdersDetails (product_id, quantity, unit_price, total_price, order_id)"
                        + "SELECT ?, ?, product_price, ? * product_price, ? FROM Products WHERE product_id = ?";
                try (PreparedStatement addProductStm = connection.prepareStatement(addProductToCartSql)) {
                    addProductStm.setInt(1, productId);
                    addProductStm.setInt(2, quantity);
                    addProductStm.setInt(3, quantity);
                    addProductStm.setInt(4, orderId);
                    addProductStm.setInt(5, productId);

                    addProductStm.executeUpdate();

                    // Update inventory after successful cart addition 
                    String updateInventorySql = "UPDATE Inventory SET current_stock = current_stock - ?"
                            + " WHERE product_id = ?";
                    try (PreparedStatement updateInventoryStm = connection.prepareStatement(updateInventorySql)) {
                        updateInventoryStm.setInt(1, quantity);
                        updateInventoryStm.setInt(2, productId);

                        updateInventoryStm.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Failed to add product to cart: " + e.getMessage());
            //rollback
            connection.rollback();
            throw new Exception("Failed to add product to cart.");
        }
    }

//    public int createOrder(int customerId, double totalAmount, List<CartItem> items, Coupons appliedCoupon, Integer employeeId, int paymentMethodId) throws SQLException {
//        try {
//            connection.setAutoCommit(false);
//
//            String orderSql = "INSERT INTO Orders (customer_id, order_date, order_total_amount, order_status, employee_id, customer_coupon_id) "
//                    + "VALUES (?, GETDATE(), ?, 'COMPLETED', ?, ?)";
//
//            int orderId;
//            try (PreparedStatement ps = connection.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
//                ps.setInt(1, customerId);
//                ps.setDouble(2, totalAmount);
//                ps.setObject(3, employeeId);
//
//                if (appliedCoupon != null) {
//                    int customerCouponId = createCustomerCoupon(customerId, appliedCoupon.getCoupon_id());
//                    ps.setInt(4, customerCouponId);
//                } else {
//                    ps.setNull(4, java.sql.Types.INTEGER);
//                }
//
//                ps.executeUpdate();
//
//                ResultSet rs = ps.getGeneratedKeys();
//                if (!rs.next()) {
//                    throw new SQLException("Failed to create order");
//                }
//                orderId = rs.getInt(1);
//            }
//
//            processOrderDetails(orderId, items);
//            createInvoice(orderId, customerId, totalAmount, employeeId, paymentMethodId);
//
//            // Cộng điểm cho khách hàng (Hiện tại: 1 điểm cho mỗi đơn hàng)
//            updateCustomerPoints(customerId, 1);
//            connection.commit();
//            return orderId;
//
//        } catch (SQLException e) {
//            connection.rollback();
//            throw e;
//        } finally {
//            connection.setAutoCommit(true);
//        }
//    }
    private int createCustomerCoupon(int customerId, int couponId) throws SQLException {
        String sql = "INSERT INTO CustomerCoupon (customer_id, coupon_id) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, customerId);
            ps.setInt(2, couponId);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                throw new SQLException("Failed to create CustomerCoupon");
            }
        }
    }

    public void processOrderDetails(int orderId, List<CartItem> items) throws SQLException {
        String detailSql = "INSERT INTO OrdersDetails (order_id, product_id, quantity, unit_price, total_price, store_stock_id) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        String updateStockSql = "UPDATE StoreStock SET quantity_in_stock = quantity_in_stock - ? "
                + "WHERE store_stock_id = ? AND quantity_in_stock >= ?";

        try (PreparedStatement detailStm = connection.prepareStatement(detailSql); PreparedStatement stockStm = connection.prepareStatement(updateStockSql)) {

            for (CartItem item : items) {
                // Validate item
                if (item.getQuantity() <= 0 || item.getPrice() <= 0) {
                    throw new SQLException("Invalid item data");
                }

                // Insert order detail
                detailStm.setInt(1, orderId);
                detailStm.setInt(2, item.getProduct().getId());
                detailStm.setInt(3, item.getQuantity());
                detailStm.setDouble(4, item.getPrice());
                detailStm.setDouble(5, item.getQuantity() * item.getPrice());
                detailStm.setInt(6, item.getStoreStock().getStoreStockId());
                detailStm.executeUpdate();

                // Update stock
                stockStm.setInt(1, item.getQuantity());
                stockStm.setInt(2, item.getStoreStock().getStoreStockId());
                stockStm.setInt(3, item.getQuantity());

                int rowsAffected = stockStm.executeUpdate();
                if (rowsAffected == 0) {
                    throw new SQLException("Insufficient stock for product: " + item.getProduct().getName());
                }
            }
        }
    }

//    public void createInvoice(int orderId, int customerId, double totalAmount, int employeeId, int paymentMethodId) throws SQLException {
//        ShiftDAO shiftDAO = new ShiftDAO();
//        Integer shiftManagerId = shiftDAO.getCurrentShiftManagerId(employeeId);
//
//        if (shiftManagerId == null) {
//            throw new SQLException("No active shift found for employee " + employeeId);
//        }
//
//        String invoiceSql = "INSERT INTO Invoices (order_id, invoice_date, invoice_total_amount, invoice_status, "
//                + "payment_method_id, employee_id, customer_id, shift_manager_id) "
//                + "VALUES (?, GETDATE(), ?, 'COMPLETED', ?, ?, ?, ?)";
//
//        try (PreparedStatement ps = connection.prepareStatement(invoiceSql)) {
//            ps.setInt(1, orderId);
//            ps.setDouble(2, totalAmount);
//            ps.setInt(3, paymentMethodId);
//            ps.setInt(4, employeeId);
//            ps.setInt(5, customerId);
//            ps.setInt(6, shiftManagerId);
//            ps.executeUpdate();
//        }
//    }

    public int createPendingOrder(int customerId, int employeeId, double totalAmount) throws SQLException {
        String sql = "INSERT INTO Orders (customer_id, order_date, order_total_amount, order_status, employee_id) "
                + "VALUES (?, GETDATE(), ?, 'PENDING', ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, customerId);
            ps.setDouble(2, totalAmount);
            ps.setInt(3, employeeId);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
                throw new SQLException("Creating order failed, no ID obtained.");
            }
        }
    }

    public void updateCustomerPoints(int customerId, int pointsToAdd) throws SQLException {
        String sql = "UPDATE Customers SET point = point + ? WHERE customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, pointsToAdd);
            ps.setInt(2, customerId);
            ps.executeUpdate();
        }
    }

    public List<Order> getOrdersWithFilter(String customerName, String startDate, String endDate,
            String status, String employeeName, int page, int pageSize) {
        List<Order> orders = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT o.order_id, c.customer_name, o.order_date, o.order_total_amount, ")
                .append("o.order_status, e.employee_name, co.coupon_code, o.employee_id ")
                .append("FROM Orders o ")
                .append("LEFT JOIN Customers c ON o.customer_id = c.customer_id ")
                .append("LEFT JOIN Employees e ON o.employee_id = e.employee_id ")
                .append("LEFT JOIN CustomerCoupon cc ON o.customer_coupon_id = cc.customer_coupon_id ")
                .append("LEFT JOIN Coupons co ON cc.coupon_id = co.coupon_id ")
                .append("WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (customerName != null && !customerName.trim().isEmpty()) {
            sql.append("AND c.customer_name COLLATE Latin1_General_CI_AI LIKE ? ");
            params.add("%" + customerName + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND o.order_status = ? ");
            params.add(status);
        }

        if (employeeName != null && !employeeName.trim().isEmpty()) {
            sql.append("AND e.employee_name COLLATE Latin1_General_CI_AI LIKE ? ");
            params.add("%" + employeeName + "%");
        }

        if (startDate != null && !startDate.isEmpty()
                && endDate != null && !endDate.isEmpty()) {
            sql.append("AND CONVERT(DATE, o.order_date) BETWEEN ? AND ? ");
            params.add(startDate);
            params.add(endDate);
        }

        sql.append("ORDER BY o.order_date DESC ")
                .append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        params.add(offset);
        params.add(pageSize);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setOrderTotalAmount(rs.getInt("order_total_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setEmployeeName(rs.getString("employee_name"));
                order.setCouponCode(rs.getString("coupon_code"));
                order.setEmployeeId(rs.getInt("employee_id"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int getTotalOrders(String customerName, String startDate, String endDate, String status, String employeeName) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM Orders o ")
                .append("LEFT JOIN Customers c ON o.customer_id = c.customer_id ")
                .append("LEFT JOIN Employees e ON o.employee_id = e.employee_id ")
                .append("WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (customerName != null && !customerName.trim().isEmpty()) {
            sql.append("AND c.customer_name LIKE ? ");
            params.add("%" + customerName + "%");
        }

        if (startDate != null && !startDate.isEmpty()
                && endDate != null && !endDate.isEmpty()) {
            sql.append("AND CONVERT(DATE, o.order_date) BETWEEN ? AND ? ");
            params.add(startDate);
            params.add(endDate);
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND o.order_status = ? ");
            params.add(status);
        }

        if (employeeName != null && !employeeName.trim().isEmpty()) {
            sql.append("AND e.employee_name LIKE ? ");
            params.add("%" + employeeName + "%");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalOrders() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Orders";
        try (
                PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public boolean updateOrder(Order order) throws SQLException {
        String sql = "UPDATE Orders SET order_status = ?, order_total_amount = ? WHERE order_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, order.getOrderStatus());
            ps.setDouble(2, order.getOrderTotalAmount());
            ps.setInt(3, order.getOrderId());
            return ps.executeUpdate() > 0;
        }
    }

    public void cleanupIncompleteOrders() throws SQLException {
        String sql = "DELETE FROM Orders WHERE order_total_amount IS NULL AND order_status = 'PENDING'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.executeUpdate();
        }
    }

    public void scheduleCleanup() {
        Timer timer = new Timer(true);
        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                try {
                    cleanupIncompleteOrders();
                } catch (SQLException ex) {
                    // Log error
                }
            }
        }, 0, 15 * 60 * 1000); // Chạy mỗi 15 phút
    }

    public int getTotalPriceOrder() {
        int totalPriceOrder = 0;
        String sql = "	select Sum(order_total_amount) as Total_Price_Order from Orders where order_status = 'COMPLETED'";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalPriceOrder = rs.getInt("Total_Price_Order");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalPriceOrder;
    }

    public double getTotalOrderSale() {
        double totalOrderSale = 0;
        String sql = "	SELECT COUNT(order_id) AS total_order_sales FROM Orders where order_status = 'COMPLETED'";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                totalOrderSale = rs.getDouble("total_order_sales");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalOrderSale;
    }

    public double getTotalOrderAvg() {
        double totalAvg = 0;
        String sql = "SELECT Avg(Orders.order_total_amount) AS total_avg FROM Orders  where order_status = 'COMPLETED'";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                totalAvg = rs.getDouble("total_avg");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalAvg;
    }

    public double getTotalMax() {
        double totalMax = 0;
        String sql = "SELECT MAX(Orders.order_total_amount) AS max_price FROM Orders  where order_status = 'COMPLETED'";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                totalMax = rs.getDouble("max_price");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalMax;
    }

    public List<Order> getOrdersWithPaging(int page, int pageSize) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.customer_coupon_id, c.customer_name, o.order_date, o.order_total_amount, \n"
                + "       o.order_status, e.employee_name, co.coupon_code, o.employee_id "
                + "FROM Orders o "
                + "LEFT JOIN Customers c ON o.customer_id = c.customer_id "
                + "LEFT JOIN Employees e ON o.employee_id = e.employee_id "
                + "LEFT JOIN CustomerCoupon cc ON o.customer_coupon_id = cc.customer_coupon_id "
                + "LEFT JOIN Coupons co ON cc.coupon_id = co.coupon_id "
                + "ORDER BY o.order_id DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int offset = (page - 1) * pageSize;
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order(); // hoặc dùng builder nếu bạn đã có
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerCouponId(rs.getObject("customer_coupon_id") != null ? rs.getInt("customer_coupon_id") : null);
                order.setCustomerName(rs.getString("customer_name"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setOrderTotalAmount(rs.getInt("order_total_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setEmployeeName(rs.getString("employee_name"));
                order.setCouponCode(rs.getString("coupon_code"));
                order.setEmployeeId(rs.getInt("employee_id"));
                orders.add(order);
            }
        }
        return orders;
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();

        order.setOrderId(rs.getInt("order_id"));
        order.setCustomerId(rs.getInt("customer_id"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setOrderTotalAmount(rs.getInt("order_total_amount")); // sẽ là 0.0 nếu null, bạn có thể kiểm tra null nếu cần
        order.setOrderStatus(rs.getString("order_status"));
        order.setCustomerCouponId(rs.getInt("customer_coupon_id")); // có thể null
        order.setEmployeeId(rs.getInt("employee_id"));

        // Optional: Nếu bạn có cột employee_name hoặc customer_name được JOIN, thì thêm set vào đây
        // order.setEmployeeName(rs.getString("employee_name"));
        // order.setCustomerName(rs.getString("customer_name"));
        return order;
    }
}
