
package model;

import com.google.gson.annotations.SerializedName;
import lombok.Builder;

@Builder
public class Customers {
    @SerializedName("type_id")
    private int id;
    private String name;
    private String phone;
    private int point;
    private int type_id;
    private String gender;
    private String avatarUrl;

    public Customers() {
    }
    
    public Customers(String name, String phone, int point, int type_id,String gender, String avatarUrl) {
        this.name = name;
        this.phone = phone;
        this.point = point;
        this.type_id = type_id;
        this.gender = gender;
        this.avatarUrl = avatarUrl;
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

    public Customers(int id, String name, String phone, int point, int type_id, String gender, String avatarUrl) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.point = point;
        this.type_id = type_id;
        this.gender = gender;
        this.avatarUrl = avatarUrl;
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

    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }
    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }
    @Override
    public String toString() {
        return "Customers{" + "id=" + id + ", name=" + name + ", phone=" + phone + ", point=" + point + ", type_id=" + type_id + '}';
    }
    
}
