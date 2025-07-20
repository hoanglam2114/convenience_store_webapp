package model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @author hoang on 7/20/2025-11:37 PM
 * IntelliJ IDEA
 */
@Getter
@Setter
@ToString
public class InventoryBatch {
    private int batchId;
    private int inventoryId;
    private int productId;
    private int warehouseId;
    private int quantity;
    private Timestamp importDate;
    private Date expiryDate;
    private Date manufactureDate;
    private String note;

    public InventoryBatch() {
    }

    public InventoryBatch(int batchId, int quantity,  Timestamp importDate, Date manufactureDate, Date expiryDate) {
        this.batchId = batchId;
        this.quantity = quantity;
        this.importDate = importDate;
        this.manufactureDate = manufactureDate;
        this.expiryDate = expiryDate;
    }

    public InventoryBatch(int batchId, int inventoryId, int productId, int warehouseId, int quantity, Timestamp importDate, Date expiryDate, String note) {
        this.batchId = batchId;
        this.inventoryId = inventoryId;
        this.productId = productId;
        this.warehouseId = warehouseId;
        this.quantity = quantity;
        this.importDate = importDate;
        this.expiryDate = expiryDate;
        this.note = note;
    }

}
