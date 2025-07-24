package model;

import java.util.Date;

public class Order {

    private int orderId;
    private int customerId;
    private String customerName;
    private Integer customerCouponId;
    private Date orderDate;
    private double orderTotalAmount;
    private String orderStatus;
    private String employeeName;
    private String couponCode;
    private int employeeId;
    private double discountAmount;

    public Order() {
    }

    public Order(int orderId, double orderTotalAmount, String orderStatus) {
        this.orderId = orderId;
        this.orderTotalAmount = orderTotalAmount;
        this.orderStatus = orderStatus;
    }

    public Order(int orderId, String customerName, Date orderDate, double orderTotalAmount, String orderStatus, String employeeName, String couponCode, int employeeId) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.orderDate = orderDate;
        this.orderTotalAmount = orderTotalAmount;
        this.orderStatus = orderStatus;
        this.employeeName = employeeName;
        this.couponCode = couponCode;
        this.employeeId = employeeId;
    }

    public Order(int orderId, int customerId, String customerName, Date orderDate, double orderTotalAmount, String orderStatus, String employeeName, String couponCode, int employeeId) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.customerName = customerName;
        this.orderDate = orderDate;
        this.orderTotalAmount = orderTotalAmount;
        this.orderStatus = orderStatus;
        this.employeeName = employeeName;
        this.couponCode = couponCode;
        this.employeeId = employeeId;
    }

    // Getters and setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Integer getCustomerCouponId() {
        return customerCouponId;
    }

    public void setCustomerCouponId(Integer customerCouponId) {
        this.customerCouponId = customerCouponId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getOrderTotalAmount() {
        return orderTotalAmount;
    }

    public void setOrderTotalAmount(double orderTotalAmount) {
        this.orderTotalAmount = orderTotalAmount;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }
}
