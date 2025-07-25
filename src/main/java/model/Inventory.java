package model;

import lombok.*;

import java.time.LocalDateTime;

/**
 * @author hoang on 5/26/2025-8:48 AM
 * IntelliJ IDEA
 */
@Builder
@Getter
@Setter
@ToString
public class Inventory {
    private int inventoryID;
    private Products product;
    private int currentStock;
    private String inventoryStatus;
    private LocalDateTime lastRestockDate;
    private String alert;
    private Warehouse warehouse;
    private int warehouseId;

    public Inventory() {
    }

    public Inventory(int inventoryID, Products product, int currentStock, String inventoryStatus,
                     LocalDateTime lastRestockDate, String alert, Warehouse warehouse, int warehouseId) {
        this.inventoryID = inventoryID;
        this.product = product;
        this.currentStock = currentStock;
        this.inventoryStatus = inventoryStatus;
        this.lastRestockDate = lastRestockDate;
        this.alert = alert;
        this.warehouse = warehouse;
        this.warehouseId = warehouseId;
    }

    public Inventory(Products pNew, int q, String status, LocalDateTime lastUpdate, String alert, int warehouseId) {
        this.product = pNew;
        this.currentStock = q;
        this.inventoryStatus = status;
        this.lastRestockDate = lastUpdate;
        this.alert = alert;
        this.warehouseId = warehouseId;
    }
}