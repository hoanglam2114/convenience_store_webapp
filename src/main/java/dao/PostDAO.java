package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Post;
import model.PostImage;

public class PostDAO extends DBContext {

    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts ORDER BY created_at DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setShopId(rs.getInt("shop_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setStatus(rs.getString("status"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setUpdatedAt(rs.getTimestamp("updated_at"));
                posts.add(post);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    public Post getPostById(int id) {
        Post post = null;
        String sql = """
            SELECT p.*, c.customer_name as customer_name, pi.image_url
            FROM Posts p
            JOIN Customers c ON p.user_id = c.customer_id
            JOIN PostImages pi on p.id = pi.post_id
            WHERE p.id = ?
        """;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                post = new Post();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setShopId(rs.getInt("shop_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setStatus(rs.getString("status"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setUpdatedAt(rs.getTimestamp("updated_at"));
                post.setUserName(rs.getString("customer_name"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }

    public List<Post> getLatestPosts(int limit) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Posts WHERE status = 'approved' ORDER BY created_at DESC";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setShopId(rs.getInt("shop_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setStatus(rs.getString("status"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setUpdatedAt(rs.getTimestamp("updated_at"));
                posts.add(post);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    public Post getFeaturedPost() {
        String sql = "SELECT TOP 1 *, c.customer_name as customer_name FROM Posts p JOIN Customers c on p.user_id = c.customer_id WHERE status = 'approved' ORDER BY created_at DESC";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setShopId(rs.getInt("shop_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setStatus(rs.getString("status"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setUpdatedAt(rs.getTimestamp("updated_at"));
                post.setUserName(rs.getString("customer_name"));
                rs.close();
                return post;
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getFirstImageByPostId(int postId) {
        String sql = "SELECT TOP 1 image_url FROM PostImages WHERE post_id = ?";
        try (
            PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String imageUrl = rs.getString("image_url");
                rs.close();
                return imageUrl;
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // hoặc trả về ảnh mặc định
    }

    public String getPrimaryTagNameByPostId(int postId) {
        String sql = """
            SELECT TOP 1 t.name
            FROM PostTags pt
            JOIN Tags t ON pt.tag_id = t.id
            WHERE pt.post_id = ?
        """;
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String tagName = rs.getString("name");
                rs.close();
                return tagName;
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
