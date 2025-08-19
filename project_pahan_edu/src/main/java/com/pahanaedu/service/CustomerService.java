package com.pahanaedu.service;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;

import java.sql.SQLException;
import java.util.List;

public class CustomerService {
    private final CustomerDAO customerDAO = new CustomerDAO();

    public void addCustomer(Customer customer) throws SQLException {
        customerDAO.insertCustomer(customer);
    }

    public void updateCustomer(Customer customer) throws SQLException {
        customerDAO.updateCustomer(customer);
    }

    public void deleteCustomer(int accountNumber) throws SQLException {
        customerDAO.deleteCustomer(accountNumber);
    }

    public Customer getCustomer(int accountNumber) throws SQLException {
        return customerDAO.selectCustomer(accountNumber);
    }

    public List<Customer> getAllCustomers() throws SQLException {
        return customerDAO.getAllCustomers();
    }
}
