package model;

import java.sql.Timestamp;

public class WarehouseAssignment {
    private int assignmentId;
    private int employeeId;
    private int warehouseId;
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
    private String warehouseName;
    private String warehouseAddress;
    private String warehousePhone;
    private String warehouseWorkingHours;
    
    
    // Constructors
    public WarehouseAssignment() {}
    
    public WarehouseAssignment(int employeeId, int warehouseId, String assignmentRole, 
                         Timestamp startDate, boolean isActive) {
        this.employeeId = employeeId;
        this.warehouseId = warehouseId;
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
    
    public int getWarehouseId() {
        return warehouseId;
    }
    
    public void setWarehouseId(int warehouseId) {
        this.warehouseId = warehouseId;
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
    
    // Additional display fields getters and setters
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
    
    public String getWarehouseName() {
        return warehouseName;
    }
    
    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }
    
    public String getWarehouseAddress() {
        return warehouseAddress;
    }
    
    public void setWarehouseAddress(String warehouseAddress) {
        this.warehouseAddress = warehouseAddress;
    }
    
    public String getWarehousePhone() {
        return warehousePhone;
    }
    
    public void setWarehousePhone(String warehousePhone) {
        this.warehousePhone = warehousePhone;
    }
    
    public String getWarehouseWorkingHours() {
        return warehouseWorkingHours;
    }
    
    public void setWarehouseWorkingHours(String warehouseWorkingHours) {
        this.warehouseWorkingHours = warehouseWorkingHours;
    }
}
