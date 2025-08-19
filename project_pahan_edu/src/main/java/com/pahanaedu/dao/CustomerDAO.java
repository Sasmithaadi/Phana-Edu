package com.pahanaedu.dao;

import com.pahanaedu.model.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

	public static List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM customer";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                customers.add(new Customer(
                        rs.getInt("accountNumber"),
                        rs.getString("name"),
                         rs.getString("address"),
                        rs.getString("telephone")
                ));
            }
        }
        return customers;
    }

    public Customer selectCustomer(int accountNumber) throws SQLException {
        String query = "SELECT * FROM customer WHERE accountNumber = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, accountNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Customer(
                            rs.getInt("accountNumber"),
                            rs.getString("name"),
                            rs.getString("address"),
                            rs.getString("telephone")
                    );
                }
            }
        }
        return null;
    }

    public void insertCustomer(Customer customer) throws SQLException {
        String query = "INSERT INTO customer (accountNumber, name, address, telephone) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, customer.getAccountNumber());
            stmt.setString(2, customer.getName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getTelephone());
            stmt.executeUpdate();
        }
    }

    public void updateCustomer(Customer customer) throws SQLException {
        String query = "UPDATE customer SET name=?, address=?, telephone=? WHERE accountNumber=?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getTelephone());
            stmt.setInt(4, customer.getAccountNumber());
            stmt.executeUpdate();
        }
    }

    public void deleteCustomer(int accountNumber) throws SQLException {
        String query = "DELETE FROM customer WHERE accountNumber=?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, accountNumber);
            stmt.executeUpdate();
        }
    }
}
