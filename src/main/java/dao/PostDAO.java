package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Post;
import model.PostSection;
import model.Tag;

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
        LEFT JOIN PostImages pi on p.id = pi.post_id
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
        String sql = """
        SELECT TOP 1 
            p.*, 
            c.customer_name, 
            COUNT(pl.user_id) AS like_count
        FROM Posts p
        JOIN Customers c ON p.user_id = c.customer_id
        LEFT JOIN PostLikes pl ON p.id = pl.post_id
        WHERE p.status = 'approved'
        GROUP BY 
            p.id, p.user_id, p.shop_id, p.title, p.content, p.status, 
            p.created_at, p.updated_at, c.customer_name
        ORDER BY like_count DESC
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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
                post.setLikes(rs.getInt("like_count"));
                rs.close();
                return post;
            }
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

//    public List<Post> getPopularPosts(int limit) throws SQLException {
//        List<Post> posts = new ArrayList<>();
//        String sql = """
//        SELECT p.id, p.title, p.created_at, pi.image_url, COUNT(pl.user_id) AS like_count
//        FROM Posts p
//        LEFT JOIN PostLikes pl ON p.id = pl.post_id
//        LEFT JOIN PostImages pi ON p.id = pi.post_id
//        WHERE p.status = 'approved'
//        GROUP BY p.id, p.title, p.created_at, pi.image_url
//        ORDER BY like_count DESC
//        LIMIT ?
//    """;
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, limit);
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    Post post = new Post();
//                    post.setId(rs.getInt("id"));
//                    post.setTitle(rs.getString("title"));
//                    post.setCreatedAt(rs.getTimestamp("created_at"));
//                    post.setImage(rs.getString("image_url"));
//                    post.setLikes(rs.getInt("like_count"));
//                    posts.add(post);
//                }
//            }
//        }
//        return posts;
//    }
    public List<Map<String, Object>> getPopularTags() {
        List<Map<String, Object>> tags = new ArrayList<>();

        String sql = """
        SELECT t.id, t.name, COUNT(pt.post_id) AS post_count
        FROM Tags t
        JOIN PostTags pt ON t.id = pt.tag_id
        GROUP BY t.id, t.name
        ORDER BY post_count DESC
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> tag = new HashMap<>();
                tag.put("id", rs.getInt("id"));
                tag.put("name", rs.getString("name"));
                tag.put("postCount", rs.getInt("post_count"));
                tags.add(tag);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tags;
    }

    public List<Map<String, Object>> getPostsByTagId(int tagId) {
        List<Map<String, Object>> posts = new ArrayList<>();
        String sql = """
        SELECT p.id, p.title, p.content, p.created_at, pi.image_url
        FROM Posts p
        JOIN PostTags pt ON p.id = pt.post_id
        LEFT JOIN PostImages pi ON p.id = pi.post_id
        WHERE pt.tag_id = ? AND p.status = 'approved'
        GROUP BY p.id, p.title, p.content, p.created_at, pi.image_url
        ORDER BY p.created_at DESC
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, tagId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> post = new HashMap<>();
                    int postId = rs.getInt("id");
                    post.put("id", rs.getInt("id"));
                    post.put("title", rs.getString("title"));
                    post.put("content", rs.getString("content"));
                    post.put("createdAt", rs.getTimestamp("created_at"));
                    post.put("image", rs.getString("image_url"));
                    post.put("tag", getPrimaryTagNameByPostId(postId));
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public String getTagNameById(int tagId) {
        String sql = "SELECT name FROM Tags WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, tagId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Không rõ";
    }

    public boolean hasUserLiked(int postId, int userId) {
        String sql = "SELECT 1 FROM PostLikes WHERE post_id = ? AND user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void addLike(int postId, int userId) {
        String sql = "INSERT INTO PostLikes (post_id, user_id, created_at) VALUES (?, ?, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int countLikes(int postId) {
        String sql = "SELECT COUNT(*) FROM PostLikes WHERE post_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Map<String, Object>> getLatestPostsAsMap() {
        List<Post> posts = getLatestPosts(10); // hoặc bao nhiêu tùy bạn
        List<Map<String, Object>> list = new ArrayList<>();

        for (Post post : posts) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", post.getId());
            map.put("title", post.getTitle());
            map.put("content", post.getContent());
            map.put("createdAt", post.getCreatedAt());
            map.put("image", getFirstImageByPostId(post.getId()));
            map.put("tag", getPrimaryTagNameByPostId(post.getId()));
            list.add(map);
        }

        return list;
    }

    public int insertPost(Post post) {
        String sql = "INSERT INTO Posts (user_id, shop_id, title, content, status, created_at) VALUES (?, NULL, ?, ?, ?, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, post.getUserId());
            ps.setString(2, post.getTitle());
            ps.setString(3, post.getContent());
            ps.setString(4, post.getStatus());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void insertPostImage(int postId, String imageUrl) {
        String sql = "INSERT INTO PostImages (post_id, image_url) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ps.setString(2, imageUrl);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertTagIfNotExists(String tagName, int postId) {
        try {
            // Kiểm tra tag tồn tại chưa
            String checkSql = "SELECT id FROM Tags WHERE name = ?";
            PreparedStatement ps = connection.prepareStatement(checkSql);
            ps.setString(1, tagName);
            ResultSet rs = ps.executeQuery();

            int tagId;
            if (rs.next()) {
                tagId = rs.getInt("id");
            } else {
                // Nếu chưa tồn tại thì insert
                String insertTag = "INSERT INTO Tags (name) VALUES (?)";
                ps = connection.prepareStatement(insertTag, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, tagName);
                ps.executeUpdate();
                rs = ps.getGeneratedKeys();
                rs.next();
                tagId = rs.getInt(1);
            }

            // Gắn tag vào bài viết
            String linkSql = "INSERT INTO PostTags (post_id, tag_id) VALUES (?, ?)";
            ps = connection.prepareStatement(linkSql);
            ps.setInt(1, postId);
            ps.setInt(2, tagId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Tag> getAllTags() {
        List<Tag> tags = new ArrayList<>();
        String sql = "SELECT id, name FROM Tags";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                tags.add(new Tag(rs.getInt("id"), rs.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tags;
    }

    public void linkPostWithTag(int postId, int tagId) {
        String sql = "INSERT INTO PostTags (post_id, tag_id) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ps.setInt(2, tagId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Post> searchPosts(String keyword, String status, Date startDate, Date endDate, int offset, int limit) {
        List<Post> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT p.*, c.customer_name AS customerName FROM Posts p "
                + "JOIN Customers c ON p.user_id = c.customer_id WHERE 1=1"
        );

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND p.title COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ?");
        }
        if (status != null && !status.equalsIgnoreCase("all")) {
            sql.append(" AND p.status = ?");
        }
        if (startDate != null) {
            sql.append(" AND p.created_at >= ?");
        }
        if (endDate != null) {
            sql.append(" AND p.created_at <= ?");
        }

        sql.append(" ORDER BY p.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int i = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(i++, "%" + keyword + "%");
            }
            if (status != null && !status.equalsIgnoreCase("all")) {
                ps.setString(i++, status);
            }
            if (startDate != null) {
                ps.setDate(i++, new java.sql.Date(startDate.getTime()));
            }
            if (endDate != null) {
                ps.setDate(i++, new java.sql.Date(endDate.getTime()));
            }

            ps.setInt(i++, offset);
            ps.setInt(i, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setStatus(rs.getString("status"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserName(rs.getString("customerName"));
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countFilteredPosts(String keyword, String status, Date startDate, Date endDate) {
        int total = 0;
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM Posts p JOIN Customers c ON p.user_id = c.customer_id WHERE 1=1"
        );

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND p.title COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ?");
        }
        if (status != null && !status.equalsIgnoreCase("all")) {
            sql.append(" AND p.status = ?");
        }
        if (startDate != null) {
            sql.append(" AND p.created_at >= ?");
        }
        if (endDate != null) {
            sql.append(" AND p.created_at <= ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int i = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(i++, "%" + keyword + "%");
            }
            if (status != null && !status.equalsIgnoreCase("all")) {
                ps.setString(i++, status);
            }
            if (startDate != null) {
                ps.setDate(i++, new java.sql.Date(startDate.getTime()));
            }
            if (endDate != null) {
                ps.setDate(i++, new java.sql.Date(endDate.getTime()));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public void updatePostStatus(int postId, String status) {
        String sql = "UPDATE Posts SET status = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, postId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Post> getAllPendingPosts() {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT p.*, c.customer_name AS userName FROM Posts p JOIN Customers c ON p.user_id = c.customer_id WHERE p.status = 'pending' ORDER BY p.created_at DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setStatus(rs.getString("status"));
                post.setUserId(rs.getInt("user_id"));
                post.setUserName(rs.getString("userName"));
                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void insertPostSection(PostSection section) {
        String sql = "INSERT INTO PostSection (post_id, section_title, section_content, section_image_url, sort_order) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, section.getPostId());
            ps.setString(2, section.getSectionTitle());
            ps.setString(3, section.getSectionContent());
            ps.setString(4, section.getSectionImageUrl()); // Có thể null nếu không có ảnh
            ps.setInt(5, section.getSortOrder());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
