package model;

/**
 * @author hoang on 7/21/2025-3:07 AM
 * IntelliJ IDEA
 */

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;
@Getter
@Setter
@ToString
public class QnA {
    private int id;
    private String customerName;
    private String question;
    private String answer;
    private Timestamp createdAt;
    private Timestamp answeredAt;

    public QnA() {}

    public QnA(int id, String customerName, String question, String answer, Timestamp createdAt, Timestamp answeredAt) {
        this.id = id;
        this.customerName = customerName;
        this.question = question;
        this.answer = answer;
        this.createdAt = createdAt;
        this.answeredAt = answeredAt;
    }
}