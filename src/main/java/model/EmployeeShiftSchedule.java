/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter

/**
 *
 * @author nguye
 */
public class EmployeeShiftSchedule {
    private Integer scheduleId;
    private Integer employeeId;
    private Integer shiftId;
    private Integer shopId;
    private Integer warehouseId;
    private Date workDate;
}
