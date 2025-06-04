
package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Notification {
    private int id;
    private String message;
    private String actor; 
    private String type;       
    private Timestamp createdAt;

    public Notification() {
    }

    public Notification(String message, String actor, String type) {
        this.message = message;
        this.actor = actor;
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getActor() {
        return actor;
    }

    public void setActor(String actor) {
        this.actor = actor;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Notification{" + "message=" + message + ", actor=" + actor + ", type=" + type + ", createdAt=" + createdAt + '}';
    }       
}
