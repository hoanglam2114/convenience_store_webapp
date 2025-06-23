package model;

/**
 *
 * @author nguye
 */
public class EmployeeStoreAssignment {
    private int assignment_id;
    private int employee_id;
    private int store_id;

    // Các trường mở rộng
    private String employeeName;
    private String roleName;
    private String shopName;

    // 👉 Trường mới thêm
    private int warehouseId;
    private String warehouseName;

    public EmployeeStoreAssignment() {
    }

    public EmployeeStoreAssignment(int assignment_id, int employee_id, int store_id) {
        this.assignment_id = assignment_id;
        this.employee_id = employee_id;
        this.store_id = store_id;
    }

    // Getter & Setter cũ
    public int getAssignment_id() {
        return assignment_id;
    }

    public void setAssignment_id(int assignment_id) {
        this.assignment_id = assignment_id;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public int getStore_id() {
        return store_id;
    }

    public void setStore_id(int store_id) {
        this.store_id = store_id;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    // 👉 Getter & Setter mới thêm
    public int getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(int warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }
}
