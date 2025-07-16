package model;

import java.sql.Timestamp;

public class ShopAssignment {
    private int assignmentId;
    private int employeeId;
    private int shopId;
    private String assignmentRole;
    private Timestamp startDate;
    private Timestamp endDate;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Additional fields for display
    private String employeeName;
    private String employeePhone;
    private String employeeAddress;
    private String shopName;

   
    private String shopAddress;
    private String shopPhone;
    private String shopEmail;
    private String shopOpeningHours;
    
    // Constructors
    public ShopAssignment() {}
    
    public ShopAssignment(int employeeId, int shopId, String assignmentRole, 
                         Timestamp startDate, boolean isActive) {
        this.employeeId = employeeId;
        this.shopId = shopId;
        this.assignmentRole = assignmentRole;
        this.startDate = startDate;
        this.isActive = isActive;
        this.createdAt = new Timestamp(System.currentTimeMillis());
        this.updatedAt = new Timestamp(System.currentTimeMillis());
    }
    
    // Getters and Setters
    public int getAssignmentId() {
        return assignmentId;
    }
    
    public void setAssignmentId(int assignmentId) {
        this.assignmentId = assignmentId;
    }
    
    public int getEmployeeId() {
        return employeeId;
    }
    
    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }
    
    public int getShopId() {
        return shopId;
    }
    
    public void setShopId(int shopId) {
        this.shopId = shopId;
    }
    
    public String getAssignmentRole() {
        return assignmentRole;
    }
    
    public void setAssignmentRole(String assignmentRole) {
        this.assignmentRole = assignmentRole;
    }
    
    public Timestamp getStartDate() {
        return startDate;
    }
    
    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }
    
    public Timestamp getEndDate() {
        return endDate;
    }
    
    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    // Additional getters and setters for display fields
    public String getEmployeeName() {
        return employeeName;
    }
    
    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }
    
    public String getEmployeePhone() {
        return employeePhone;
    }
    
    public void setEmployeePhone(String employeePhone) {
        this.employeePhone = employeePhone;
    }
    
    public String getEmployeeAddress() {
        return employeeAddress;
    }
    
    public void setEmployeeAddress(String employeeAddress) {
        this.employeeAddress = employeeAddress;
    }
    
    public String getShopName() {
        return shopName;
    }
    
    public void setShopName(String shopName) {
        this.shopName = shopName;
    }
    
    public String getShopAddress() {
        return shopAddress;
    }
    
    public void setShopAddress(String shopAddress) {
        this.shopAddress = shopAddress;
    }
    
    public String getShopPhone() {
        return shopPhone;
    }
    
    public void setShopPhone(String shopPhone) {
        this.shopPhone = shopPhone;
    }
    
    public String getShopEmail() {
        return shopEmail;
    }
    
    public void setShopEmail(String shopEmail) {
        this.shopEmail = shopEmail;
    }
    
    public String getShopOpeningHours() {
        return shopOpeningHours;
    }
    
    public void setShopOpeningHours(String shopOpeningHours) {
        this.shopOpeningHours = shopOpeningHours;
    }
     @Override
    public String toString() {
        return "ShopAssignment{" + "assignmentId=" + assignmentId + ", employeeId=" + employeeId + ", shopId=" + shopId + ", assignmentRole=" + assignmentRole + ", startDate=" + startDate + ", endDate=" + endDate + ", isActive=" + isActive + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", employeeName=" + employeeName + ", employeePhone=" + employeePhone + ", employeeAddress=" + employeeAddress + ", shopName=" + shopName + ", shopAddress=" + shopAddress + ", shopPhone=" + shopPhone + ", shopEmail=" + shopEmail + ", shopOpeningHours=" + shopOpeningHours + '}';
    }
}
