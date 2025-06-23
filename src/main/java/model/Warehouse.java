/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Warehouse {
    private int warehouseId;
    private String name;
    private String address;
    private String phone;
    private String workingHours;

    public Warehouse() {
    }

    public Warehouse(int warehouseId, String name, String address, String phone, String workingHours) {
        this.warehouseId = warehouseId;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.workingHours = workingHours;
    }

    public int getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(int warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getWorkingHours() {
        return workingHours;
    }

    public void setWorkingHours(String workingHours) {
        this.workingHours = workingHours;
    }

    @Override
    public String toString() {
        return "Warehouse{" + "warehouseId=" + warehouseId + ", name=" + name + ", address=" + address + ", phone=" + phone + ", workingHours=" + workingHours + '}';
    }
}