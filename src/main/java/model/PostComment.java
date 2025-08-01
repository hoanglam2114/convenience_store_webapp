
package model;

import java.sql.Timestamp;

public class PostComment {
    private int id;
    private int postId;
    private int userId;
    private String comment;
    private Timestamp createdAt;

    public PostComment() {
    }

    public PostComment(int id, int postId, int userId, String comment, Timestamp createdAt) {
        this.id = id;
        this.postId = postId;
        this.userId = userId;
        this.comment = comment;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
}
