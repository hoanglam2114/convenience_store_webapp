
package model;

public class PostImage {
    private int id;
    private int postId;
    private String imageUrl;

    public PostImage() {
    }

    public PostImage(int id, int postId, String imageUrl) {
        this.id = id;
        this.postId = postId;
        this.imageUrl = imageUrl;
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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    
}
