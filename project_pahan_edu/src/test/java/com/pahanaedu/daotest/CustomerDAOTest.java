package com.pahanaedu.daotest;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CustomerDAOTest {

    private static CustomerDAO customerDAO;
    private static int testAccountNumber = 1001;

    @BeforeAll
    public static void setup() throws Exception {
        // ⚠️ Change DB URL/username/password to match your environment
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu_test", "root", "password");
        customerDAO = new CustomerDAO();

        // Prepare test table with clean data
        try (Statement stmt = conn.createStatement()) {
            stmt.execute("DELETE FROM customer");
        }
        conn.close();
    }

    @Test
    @Order(1)
    public void testInsertCustomer() throws Exception {
        Customer customer = new Customer(testAccountNumber, "John Doe", "123 Main St", "0771234567");
        customerDAO.insertCustomer(customer);

        Customer fetched = customerDAO.selectCustomer(testAccountNumber);
        assertNotNull(fetched);
        assertEquals("John Doe", fetched.getName());
    }

    @Test
    @Order(2)
    public void testSelectCustomer() throws Exception {
        Customer customer = customerDAO.selectCustomer(testAccountNumber);
        assertNotNull(customer);
        assertEquals("123 Main St", customer.getAddress());
        assertEquals("0771234567", customer.getTelephone());
    }

    @Test
    @Order(3)
    public void testUpdateCustomer() throws Exception {
        Customer customer = new Customer(testAccountNumber, "Jane Doe", "456 Park Ave", "0719998888");
        customerDAO.updateCustomer(customer);

        Customer updated = customerDAO.selectCustomer(testAccountNumber);
        assertEquals("Jane Doe", updated.getName());
        assertEquals("456 Park Ave", updated.getAddress());
        assertEquals("0719998888", updated.getTelephone());
    }

    @Test
    @Order(4)
    public void testGetAllCustomers() throws Exception {
        List<Customer> customers = CustomerDAO.getAllCustomers();
        assertNotNull(customers);
        assertTrue(customers.size() > 0, "At least one customer should exist");
    }

    @Test
    @Order(5)
    public void testDeleteCustomer() throws Exception {
        customerDAO.deleteCustomer(testAccountNumber);
        Customer deleted = customerDAO.selectCustomer(testAccountNumber);
        assertNull(deleted, "Deleted customer should return null");
    }
}
