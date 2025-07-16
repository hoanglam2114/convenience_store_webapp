package model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {

    private List<CartItem> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public List<CartItem> getItems() {
        return items;
    }

    public int getQuantityById(int storeStockId) {
        return getItemById(storeStockId).getQuantity();
    }

    public CartItem getItemById(int storeStockId) {
        for (CartItem item : items) {
            if (item.getStoreStock().getStoreStockId() == storeStockId) {
                return item;
            }
        }
        return null;
    }

    public void addItem(CartItem newItem) {
        if (getItemById(newItem.getStoreStock().getStoreStockId()) != null) {
            CartItem oldItem = getItemById(newItem.getStoreStock().getStoreStockId());
            oldItem.setQuantity(oldItem.getQuantity() + newItem.getQuantity());
        } else {
            items.add(newItem);
        }
    }

    public void increaseQuantity(int storeStockId) {
        for (CartItem item : items) {
            if (item.getStoreStock().getStoreStockId() == storeStockId) {
                item.setQuantity(item.getQuantity() + 1);
                break;
            }
        }
    }

    public void decreaseQuantity(int storeStockId) {
        for (CartItem item : items) {
            if (item.getStoreStock().getStoreStockId() == storeStockId) {
                if (item.getQuantity() > 1) {
                    item.setQuantity(item.getQuantity() - 1);
                } else {
                    items.remove(item);
                }
                break;
            }
        }
    }

    public void removeItem(int storeStockId) {
        items.removeIf(item -> item.getStoreStock().getStoreStockId() == storeStockId);
    }

    public void printCart() {
        System.out.println("Cart items: " + items.size());
        for (CartItem item : items) {
            System.out.println("StoreStockId: " + item.getStoreStock().getStoreStockId());
        }
    }

    public double getTotalMoney() {
        if (items == null || items.isEmpty()) {
            return 0;
        }
        return items.stream()
                .mapToDouble(item -> item.getQuantity() * item.getPrice())
                .sum();
    }

    public CartItem findItem(int storeStockId) {
        return items.stream()
                .filter(item -> item.getStoreStock().getStoreStockId() == storeStockId)
                .findFirst()
                .orElse(null);
    }
}
