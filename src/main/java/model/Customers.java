/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import com.google.gson.annotations.SerializedName;

public class Customers {
    @SerializedName("type_id")
    private int id;
    private String name;
    private String phone;
    private int point;
    private int type_id;

    public Customers() {
    }
    
    public Customers(String name, String phone, int point, int type_id) {
        this.name = name;
        this.phone = phone;
        this.point = point;
        this.type_id = type_id;
    }
    
    public Customers(int id, String name, String phone, int point) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.point = point;
    }

    public Customers(int id, String name, String phone, int point, int type_id) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.point = point;
        this.type_id = type_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public int getType_id() {
        return type_id;
    }

    public void setType_id(int type_id) {
        this.type_id = type_id;
    }

    @Override
    public String toString() {
        return "Customers{" + "id=" + id + ", name=" + name + ", phone=" + phone + ", point=" + point + ", type_id=" + type_id + '}';
    }
    
}
