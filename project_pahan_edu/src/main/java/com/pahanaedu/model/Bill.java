package com.pahanaedu.model;

import java.util.List;

public class Bill {
    private int billId;
    private int customerId;
    private String customerName;
    private double totalAmount;
    private List<BillItem> items;
    private List<ProductItem> productItems; // Separate field for ProductItems

    public Bill() {}

    public Bill(int billId, int customerId, double totalAmount) {
        this.billId = billId;
        this.customerId = customerId;
        this.totalAmount = totalAmount;
    }

    // Basic getters and setters
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    // BillItem related methods
    public List<BillItem> getItems() { return items; }
    public void setItems(List<BillItem> items) { this.items = items; }
    
    // ProductItem related methods - FIXED: Different method names to avoid conflicts
    public List<ProductItem> getProductItems() { return productItems; }
    public void setProductItems(List<ProductItem> productItems) { this.productItems = productItems; }
}