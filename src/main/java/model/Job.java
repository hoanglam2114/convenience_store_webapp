/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author admin
 */
public class Job {
    private int id;
    private String title;
    private JobTypes jobTypes;
    private JobLocation jobLocation;
    private LocalDate deadline;
    private LocalDateTime createdDate;
    private JobCategories jobCategories;
    private String description;
    private String status;

    public Job() {
    }

    public Job(String title, JobTypes jobTypes, JobLocation jobLocation, LocalDate deadline, LocalDateTime  createdDate, JobCategories jobCategories, String description, String status) {
        this.title = title;
        this.jobTypes = jobTypes;
        this.jobLocation = jobLocation;
        this.deadline = deadline;
        this.createdDate = createdDate;
        this.jobCategories = jobCategories;
        this.description = description;
        this.status = status;
    }

    public Job(int id, String title, JobTypes jobTypes, JobLocation jobLocation, LocalDate deadline, LocalDateTime  createdDate, JobCategories jobCategories, String description, String status) {
        this.id = id;
        this.title = title;
        this.jobTypes = jobTypes;
        this.jobLocation = jobLocation;
        this.deadline = deadline;
        this.createdDate = createdDate;
        this.jobCategories = jobCategories;
        this.description = description;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public JobTypes getJobTypes() {
        return jobTypes;
    }

    public void setJobTypes(JobTypes jobTypes) {
        this.jobTypes = jobTypes;
    }

    public JobLocation getJobLocation() {
        return jobLocation;
    }

    public void setJobLocation(JobLocation jobLocation) {
        this.jobLocation = jobLocation;
    }

    public LocalDate getDeadline() {
        return deadline;
    }

    public void setDeadline(LocalDate deadline) {
        this.deadline = deadline;
    }

    public LocalDateTime  getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime  createdDate) {
        this.createdDate = createdDate;
    }

    public JobCategories getJobCategories() {
        return jobCategories;
    }

    public void setJobCategories(JobCategories jobCategories) {
        this.jobCategories = jobCategories;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Job{" + "id=" + id + ", title=" + title + ", jobTypes=" + jobTypes + ", jobLocation=" + jobLocation + ", deadline=" + deadline + ", createdDate=" + createdDate + ", jobCategories=" + jobCategories + ", description=" + description + ", status=" + status + '}';
    }
    
    
    
    
    
    
    
}
