package model;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author hoang on 6/8/2025-10:51 AM
 * IntelliJ IDEA
 */
@Getter
@Setter
@ToString
public class DiscountProduct {
    private int discountProductId;
    private int productId;
    private double priceSell;

    public DiscountProduct() {
    }

    public DiscountProduct(int productId, double priceSell) {
        this.productId = productId;
        this.priceSell = priceSell;
    }

    public DiscountProduct(int discountProductId, int productId, double priceSell) {
        this.discountProductId = discountProductId;
        this.productId = productId;
        this.priceSell = priceSell;
    }
    
}
