/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Suppliers {
     private int id;
    private String name, address, phone, email, contact,img;

    public Suppliers() {
    }

    public Suppliers(int id, String name, String address, String phone, String email, String contact, String img) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.contact = contact;
        this.img = img;
    }
    public Suppliers(String name, String address, String phone, String email, String contact, String img) {
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.contact = contact;
        this.img = img;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    @Override
    public String toString() {
        return "Suppliers{" + "id=" + id + ", name=" + name + ", address=" + address + ", phone=" + phone + ", email=" + email + ", contact=" + contact + ", img=" + img + '}';
    }

    
    
}
