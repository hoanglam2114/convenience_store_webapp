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
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Inventory {
    private int inventoryID;
    private Products product;
    private int currentStock;
    private String inventoryStatus;
    private LocalDateTime lastRestockDate;
    private String alert;

    public Inventory(Products pNew, int q, String status, LocalDateTime lastUpdate, String alert) {
        this.product = pNew;
        this.currentStock = q;
        this.inventoryStatus = status;
        this.lastRestockDate = lastUpdate;
        this.alert = alert;
    }
}