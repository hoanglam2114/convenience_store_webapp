
package model;

public class PostSection {

    private int sectionId;
    private int postId;
    private String sectionTitle;
    private String sectionContent;
    private String sectionHtml;
    private String sectionImageUrl;
    private int sortOrder;
    private String postImageUrl;

    public PostSection() {
    }

    public PostSection(int sectionId, int postId, String sectionTitle, String sectionContent, String sectionHtml, String sectionImageUrl, int sortOrder) {
        this.sectionId = sectionId;
        this.postId = postId;
        this.sectionTitle = sectionTitle;
        this.sectionContent = sectionContent;
        this.sectionHtml = sectionHtml;
        this.sectionImageUrl = sectionImageUrl;
        this.sortOrder = sortOrder;
    }

    public int getSectionId() {
        return sectionId;
    }

    public void setSectionId(int sectionId) {
        this.sectionId = sectionId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getSectionTitle() {
        return sectionTitle;
    }

    public void setSectionTitle(String sectionTitle) {
        this.sectionTitle = sectionTitle;
    }

    public String getSectionContent() {
        return sectionContent;
    }

    public void setSectionContent(String sectionContent) {
        this.sectionContent = sectionContent;
    }

    public String getSectionHtml() {
        return sectionHtml;
    }

    public void setSectionHtml(String sectionHtml) {
        this.sectionHtml = sectionHtml;
    }

    public String getSectionImageUrl() {
        return sectionImageUrl;
    }

    public void setSectionImageUrl(String sectionImageUrl) {
        this.sectionImageUrl = sectionImageUrl;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public String getPostImageUrl() {
        return postImageUrl;
    }

    public void setPostImageUrl(String postImageUrl) {
        this.postImageUrl = postImageUrl;
    }
    
    
}
