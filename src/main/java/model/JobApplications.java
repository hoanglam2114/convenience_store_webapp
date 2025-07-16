/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;

/**
 *
 * @author admin
 */
public class JobApplications {

    private int id;
    private String name;
    private String email;
    private String phone;
    private LocalDate dateofbirth;
    private Gender gender;
    private String current_address;
    private DistrictApply district_apply;
    private LocalDate interview_date;
    private SourceAds source;

    public JobApplications() {
    }

    public JobApplications(int id, String name, String email, String phone, LocalDate dateofbirth, Gender gender, String current_address, DistrictApply district_apply, LocalDate interview_date, SourceAds source) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.dateofbirth = dateofbirth;
        this.gender = gender;
        this.current_address = current_address;
        this.district_apply = district_apply;
        this.interview_date = interview_date;
        this.source = source;
    }

    public JobApplications(String name, String email, String phone, LocalDate dateofbirth, Gender gender, String current_address, DistrictApply district_apply, LocalDate interview_date, SourceAds source) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.dateofbirth = dateofbirth;
        this.gender = gender;
        this.current_address = current_address;
        this.district_apply = district_apply;
        this.interview_date = interview_date;
        this.source = source;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public LocalDate getDateofbirth() {
        return dateofbirth;
    }

    public void setDateofbirth(LocalDate dateofbirth) {
        this.dateofbirth = dateofbirth;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getCurrent_address() {
        return current_address;
    }

    public void setCurrent_address(String current_address) {
        this.current_address = current_address;
    }

    public DistrictApply getDistrict_apply() {
        return district_apply;
    }

    public void setDistrict_apply(DistrictApply district_apply) {
        this.district_apply = district_apply;
    }

    public LocalDate getInterview_date() {
        return interview_date;
    }

    public void setInterview_date(LocalDate interview_date) {
        this.interview_date = interview_date;
    }

    public SourceAds getSource() {
        return source;
    }

    public void setSource(SourceAds source) {
        this.source = source;
    }

    @Override
    public String toString() {
        return "JobApplications{" + "id=" + id + ", name=" + name + ", email=" + email + ", phone=" + phone + ", dateofbirth=" + dateofbirth + ", gender=" + gender + ", current_address=" + current_address + ", district_apply=" + district_apply + ", interview_date=" + interview_date + ", source=" + source + '}';
    }

    

}
