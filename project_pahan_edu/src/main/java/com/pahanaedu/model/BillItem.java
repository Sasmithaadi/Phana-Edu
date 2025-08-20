package com.pahanaedu.model;

public class BillItem {
    private int itemId;
    private int billId;
    private int productId;
    private int quantity;
    private double price;

    public BillItem() {}

    public BillItem(int billId, int productId, int quantity, double price) {
        this.billId = billId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    // getters and setters
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
