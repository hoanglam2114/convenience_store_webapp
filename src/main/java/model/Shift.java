/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalTime;
import java.util.List;
/**
 *
 * @author nguye
 */
public class Shift {
     private int shiftId;
    private String shiftName;
    private LocalTime startTime;
    private LocalTime endTime;
    private List<String> workingDays; // e.g. ["Monday", "Wednesday", "Friday"]
    private String description;
    
    public Shift() {
    }
        
    public Shift(int shiftId, String shiftName, LocalTime startTime, LocalTime endTime, List<String> workingDays, String description) {
        this.shiftId = shiftId;
        this.shiftName = shiftName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.workingDays = workingDays;
        this.description = description;
    }

    public int getShiftId() {
        return shiftId;
    }

    public void setShiftId(int shiftId) {
        this.shiftId = shiftId;
    }

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public List<String> getWorkingDays() {
        return workingDays;
    }

    public void setWorkingDays(List<String> workingDays) {
        this.workingDays = workingDays;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
