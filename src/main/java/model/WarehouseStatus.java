package model;

import lombok.Getter;
/**
 * @author hoang on 6/21/2025-1:32 AM
 * IntelliJ IDEA
 */
@Getter
public enum WarehouseStatus {
    ACTIVE("Đang hoạt động"),
    MAINTENANCE("Bảo trì"),
    CLOSED("Đóng cửa");

    private final String label;

    WarehouseStatus(String label) {
        this.label = label;
    }
}