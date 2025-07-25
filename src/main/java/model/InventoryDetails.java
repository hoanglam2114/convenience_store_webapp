package model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;

/**
 * @author hoang on 6/8/2025-12:54 PM
 * IntelliJ IDEA
 */
@Getter
@Setter
@ToString
public class InventoryDetails {
    private int id;
    private Inventory inventory;
    private int quantity;
    private LocalDate date;
    private String status;
    private String deliveredBy;
    private String receivedBy;
    private String note;
    private int warehouseId;


    public InventoryDetails() {
    }

    public InventoryDetails(int id, Inventory inventory, int quantity, LocalDate date, String status) {
        this.id = id;
        this.inventory = inventory;
        this.quantity = quantity;
        this.date = date;
        this.status = status;
    }

    public InventoryDetails(Inventory inventory, int quantity, LocalDate date, String status, String deliveredBy, String receivedBy, String note, int warehouseId) {
        this.inventory = inventory;
        this.quantity = quantity;
        this.date = date;
        this.status = status;
        this.deliveredBy = deliveredBy;
        this.receivedBy = receivedBy;
        this.note = note;
        this.warehouseId = warehouseId;
    }
}