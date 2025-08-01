/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class ProductCategories {
    private int id;
    private String name;
    private int groupId;

    public ProductCategories() {
    }

    public ProductCategories(int id, String name) {
        this.id = id;
        this.name = name;
    }
    public ProductCategories(int id, String name, int groupId) {
        this.id = id;
        this.name = name;
        this.groupId = groupId;
    }
    
    public ProductCategories(String name) {
        this.name = name;
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
    public int getGroupId() {
        return groupId;
    }
    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    @Override
    public String toString() {
        return "ProductCategories{" + "id=" + id + ", name=" + name +  ", groupId=" + groupId + '}';
    }
    
}
