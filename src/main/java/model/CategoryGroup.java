package model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author hoang on 7/16/2025-3:58 PM
 * IntelliJ IDEA
 */
@Getter
@Setter
@ToString
public class CategoryGroup {
    private int id;
    private String name;
    public CategoryGroup() {}

    public CategoryGroup(int id, String name) {
        this.id = id;
        this.name = name;
    }
}
