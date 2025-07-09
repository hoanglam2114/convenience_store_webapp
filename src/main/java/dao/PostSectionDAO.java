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
import model.PostSection;

public class PostSectionDAO extends DBContext{

    public List<PostSection> getSectionsByPostId(int postId) {
        List<PostSection> list = new ArrayList<>();
        String sql = "SELECT section_id, post_id, section_title, section_content, section_html, section_image_url, sort_order " +
                     "FROM PostSection WHERE post_id = ? ORDER BY sort_order ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PostSection section = new PostSection();
                section.setSectionId(rs.getInt("section_id"));
                section.setPostId(rs.getInt("post_id"));
                section.setSectionTitle(rs.getString("section_title"));
                section.setSectionContent(rs.getString("section_content"));
                section.setSectionHtml(rs.getString("section_html"));
                section.setSectionImageUrl(rs.getString("section_image_url"));
                section.setSortOrder(rs.getInt("sort_order"));
                list.add(section);
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
        return list;
    }

    // Thêm mới 1 section cho bài viết
    public void insertSection(PostSection section) {
        String sql = "INSERT INTO PostSections (post_id, section_title, section_content, section_html, section_image_url, sort_order) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, section.getPostId());
            ps.setString(2, section.getSectionTitle());
            ps.setString(3, section.getSectionContent());
            ps.setString(4, section.getSectionHtml());
            ps.setString(5, section.getSectionImageUrl());
            ps.setInt(6, section.getSortOrder());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa toàn bộ section theo postId (ví dụ khi xóa bài viết)
    public void deleteSectionsByPostId(int postId) {
        String sql = "DELETE FROM PostSections WHERE post_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
