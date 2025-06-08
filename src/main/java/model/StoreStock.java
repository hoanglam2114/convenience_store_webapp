package model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;

/**
 * @author hoang on 6/8/2025-10:50 AM
 * IntelliJ IDEA
 */
@Getter
@Setter
@ToString
public class StoreStock {
    private int storeStockId;
    private Inventory inventory;
    private int stock;
    private LocalDate lastStockCheckDate;
    private DiscountProduct discount;
    private String alert;
}