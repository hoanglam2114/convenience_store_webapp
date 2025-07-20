package dao;

/**
 * @author hoang on 7/21/2025-3:08 AM
 * IntelliJ IDEA
 */

import jakarta.servlet.http.HttpServlet;
import model.QnA;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QnADAO extends DBContext {

    // Thêm câu hỏi
    public void addQuestion(String customerName, String question) throws SQLException {
        String sql = "INSERT INTO QnA (customer_name, question) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customerName);
            ps.setString(2, question);
            ps.executeUpdate();
        }
    }

    public void answerQuestion(int id, String answer) throws SQLException {
        String sql = "UPDATE QnA SET answer = ?, answered_at = SYSDATETIME() WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, answer);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }


    // Lấy tất cả QnA
    public List<QnA> getAll() throws SQLException {
        List<QnA> list = new ArrayList<>();
        String sql = "SELECT * FROM QnA ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                QnA q = new QnA();
                q.setId(rs.getInt("id"));
                q.setCustomerName(rs.getString("customer_name"));
                q.setQuestion(rs.getString("question"));
                q.setAnswer(rs.getString("answer"));
                q.setCreatedAt(rs.getTimestamp("created_at"));
                q.setAnsweredAt(rs.getTimestamp("answered_at"));
                list.add(q);
            }
        }
        return list;
    }
    public void deleteQuestion(int id) throws SQLException {
        String sql = "DELETE FROM QnA WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

}