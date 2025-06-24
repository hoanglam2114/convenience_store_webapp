package model;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author hoang on 6/21/2025-1:32 AM
 * IntelliJ IDEA
 */
@Getter
@Setter
@ToString
@Builder
public class Warehouse {
    private int warehouseID;
    private String name;
    private String address;
    private String phone;
    private String workingHours;
    private WarehouseStatus status;
    private String note;
    private Integer managerID;
    private Integer storeLinkedID;
}

