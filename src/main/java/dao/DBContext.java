package dao;

//import java.sql.*;
//
//public class DBContext {
//
//    protected Connection connection;
//
//    public Connection getConnection() {
//        try {
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//            String url = "jdbc:sqlserver://localhost:1433;databaseName=SWP_PROJECT;encrypt=true;trustServerCertificate=true;sendStringParametersAsUnicode=true";
//            String user = "sa";
//            String password = "123";
//            connection = DriverManager.getConnection(url, user, password);
//            return connection;
//        } catch (ClassNotFoundException | SQLException e) {
//            System.err.println("Error " + e.getMessage() + " at DBContext");
//            return null;
//        }
//
//    }
//    public void logAction(String username, String tableName, String action) throws SQLException {
//        String sql = "INSERT INTO ActionLog (Username, TableName, Action, ActionTime) VALUES (?, ?, ?, ?)";
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, username);
//            ps.setString(2, tableName);
//            ps.setString(3, action);
//            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
//            ps.executeUpdate();
//        }
//    }
//
//    public static void main(String[] args) {
//        DBContext test = new DBContext();
//        test.connection = test.getConnection();
//        if(test.connection != null) {
//            System.out.println("ok");
//        }else {
//            System.out.println("fail");
//        }
//    }
//}

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    public Connection connection;

    public DBContext() {
        try {
            // Edit URL , username, password to authenticate with your MS SQL Server
            String url = "jdbc:sqlserver://localhost:1433;databaseName=SWP_PROJECT;encrypt=true;trustServerCertificate=true;sendStringParametersAsUnicode=true";
            String username = "sa";
            String password = "12345";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
    }

    public static void main(String[] args) {
        DBContext dBContext = new DBContext();
        if (dBContext.connection != null) {
            System.out.println("ok");
        } else {
            System.out.println("fail");
        }
    }
}