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

    public InventoryDetails() {
    }

    public InventoryDetails(int id, Inventory inventory, int quantity, LocalDate date, String status) {
        this.id = id;
        this.inventory = inventory;
        this.quantity = quantity;
        this.date = date;
        this.status = status;
    }

    public InventoryDetails(Inventory inventory, int quantity, LocalDate date, String status) {
        this.inventory = inventory;
        this.quantity = quantity;
        this.date = date;
        this.status = status;
    }
}