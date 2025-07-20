package model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

/**
 * @author hoang on 7/20/2025-11:49 PM
 * IntelliJ IDEA
 */
@Getter
@Setter
@ToString
public class InventorySummary {
    private int inventoryId;
    private int productId;
    private String productName;
    private String image;
    private int totalStock;
    private Timestamp lastRestock;
    private String inventoryStatus;
    private String alert;

    public InventorySummary(int inventoryId,int productId, String productName, String image, int totalStock, Timestamp lastRestock, String inventoryStatus, String alert) {
        this.inventoryId = inventoryId;
        this.productId = productId;
        this.productName = productName;
        this.image = image;
        this.totalStock = totalStock;
        this.lastRestock = lastRestock;
        this.inventoryStatus = inventoryStatus;
        this.alert = alert;
    }
}
