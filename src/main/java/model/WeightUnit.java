/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class WeightUnit {
     private int id;
    private String name;

    public WeightUnit() {
    }

    public WeightUnit(int id, String name) {
        this.id = id;
        this.name = name;
    }
    
    public WeightUnit(String name) {
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

    @Override
    public String toString() {
        return "WeightUnit{" + "id=" + id + ", name=" + name + '}';
    }
    
    
}
