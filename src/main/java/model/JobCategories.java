/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class JobCategories {

    private int id;
    private String name;

    public JobCategories() {
    }

    public JobCategories(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public JobCategories(String name) {
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
        return "JobCategories{" + "id=" + id + ", name=" + name + '}';
    }

   
}
