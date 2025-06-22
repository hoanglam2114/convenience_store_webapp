
package model;

public class CartItem {

    private StoreStock storeStock;
    private int quantity;
    private double price;

    public CartItem() {
    }

    public CartItem(StoreStock storeStock, int quantity, double price) {
        this.storeStock = storeStock;
        this.quantity = quantity;
        this.price = price;
    }

    public StoreStock getStoreStock() {
        return storeStock;
    }

    public void setStoreStock(StoreStock storeStock) {
        this.storeStock = storeStock;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getSubTotal() {
        return this.quantity * this.price;
    }

    public Products getProduct() {
        if (storeStock != null && storeStock.getInventory() != null) {
            return storeStock.getInventory().getProduct();
        }
        return null;
    }
}
