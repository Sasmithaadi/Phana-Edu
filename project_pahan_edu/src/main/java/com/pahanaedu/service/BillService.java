package com.pahanaedu.service;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.ProductItem;

import java.sql.SQLException;
import java.util.List;

public class BillService {

    private final BillDAO billDAO = new BillDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();

    public Bill create(int customerId, List<ProductItem> items) throws SQLException {
        Customer customer = customerDAO.selectCustomer(customerId);
        if (customer == null) throw new SQLException("Customer not found with ID: " + customerId);

        Bill bill = new Bill();
        bill.setBillId(billDAO.nextId());
        bill.setCustomerId(customer.getAccountNumber());
        bill.setCustomerName(customer.getName());
        bill.setProductItems(items); // FIXED: Using setProductItems instead of setItems
        recomputeTotal(bill);
        billDAO.save(bill);

        return bill;
    }

    public void update(int billId, int customerId, List<ProductItem> items) throws SQLException {
        Bill existing = billDAO.findById(billId);
        if (existing == null) return;

        Customer customer = customerDAO.selectCustomer(customerId);
        if (customer == null) throw new SQLException("Customer not found with ID: " + customerId);

        existing.setCustomerId(customer.getAccountNumber());
        existing.setCustomerName(customer.getName());
        existing.setProductItems(items); // FIXED: Using setProductItems instead of setItems
        recomputeTotal(existing);
        billDAO.update(existing);
    }

    public void delete(int billId) { billDAO.delete(billId); }
    public Bill get(int billId) { return billDAO.findById(billId); }
    public List<Bill> list() { return billDAO.findAll(); }

    public void recomputeTotal(Bill bill) {
        double total = 0;
        if (bill.getProductItems() != null) {
            for (ProductItem it : bill.getProductItems()) {
                total += it.getQuantity() * it.getPrice();
            }
        }
        bill.setTotalAmount(Math.round(total * 100.0) / 100.0);
    }
}