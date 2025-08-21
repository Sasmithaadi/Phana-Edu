package com.pahanaedu.controllertest;

import com.pahanaedu.controller.CustomerController;
import com.pahanaedu.model.Customer;
import com.pahanaedu.service.CustomerService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Field;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CutomerControllerTest {

    @Mock
    private CustomerService mockCustomerService;
    
    @Mock
    private HttpServletRequest mockRequest;
    
    @Mock
    private HttpServletResponse mockResponse;
    
    @Mock
    private RequestDispatcher mockRequestDispatcher;

    private CustomerController customerController;

    @BeforeEach
    void setUp() throws Exception {
        customerController = new CustomerController();
        
        // Inject mock service using reflection
        Field serviceField = CustomerController.class.getDeclaredField("customerService");
        serviceField.setAccessible(true);
        serviceField.set(customerController, mockCustomerService);
    }

    // ========== doGet() Tests ==========

    @Test
    void testDoGet_ActionList_DisplaysCustomerList() throws ServletException, IOException, SQLException {
        // Arrange
        List<Customer> customerList = Arrays.asList(
            createCustomer(12345, "John Doe", "123 Main St", "123-456-7890"),
            createCustomer(67890, "Jane Smith", "456 Oak Ave", "098-765-4321")
        );
        
        when(mockRequest.getParameter("action")).thenReturn("list");
        when(mockCustomerService.getAllCustomers()).thenReturn(customerList);
        when(mockRequest.getRequestDispatcher("/WEB-INF/view/customerList.jsp")).thenReturn(mockRequestDispatcher);

        // Act
        customerController.doGet(mockRequest, mockResponse);

        // Assert
        verify(mockCustomerService, times(1)).getAllCustomers();
        verify(mockRequest, times(1)).setAttribute("customers", customerList);
        verify(mockRequestDispatcher, times(1)).forward(mockRequest, mockResponse);
    }

    @Test
    void testDoGet_ActionNull_DefaultsToList() throws ServletException, IOException, SQLException {
        // Arrange
        List<Customer> customerList = Arrays.asList(createCustomer(12345, "John Doe", "123 Main St", "123-456-7890"));
        
        when(mockRequest.getParameter("action")).thenReturn(null);
        when(mockCustomerService.getAllCustomers()).thenReturn(customerList);
        when(mockRequest.getRequestDispatcher("/WEB-INF/view/customerList.jsp")).thenReturn(mockRequestDispatcher);

        // Act
        customerController.doGet(mockRequest, mockResponse);

        // Assert
        verify(mockCustomerService, times(1)).getAllCustomers();
        verify(mockRequest, times(1)).setAttribute("customers", customerList);
        verify(mockRequestDispatcher, times(1)).forward(mockRequest, mockResponse);
    }

    @Test
    void testDoGet_ActionForm_ForwardsToCustomerForm() throws ServletException, IOException {
        // Arrange
        when(mockRequest.getParameter("action")).thenReturn("form");
        when(mockRequest.getRequestDispatcher("/WEB-INF/view/customer.jsp")).thenReturn(mockRequestDispatcher);

        // Act
        customerController.doGet(mockRequest, mockResponse);

        // Assert
        verify(mockRequest, times(1)).getRequestDispatcher("/WEB-INF/view/customer.jsp");
        verify(mockRequestDispatcher, times(1)).forward(mockRequest, mockResponse);
        verifyNoInteractions(mockCustomerService);
    }

    @Test
    void testDoGet_ActionEdit_LoadsCustomerForEdit() throws ServletException, IOException, SQLException {
        // Arrange
        int accountNumber = 12345;
        Customer customer = createCustomer(accountNumber, "John Doe", "123 Main St", "123-456-7890");
        
        when(mockRequest.getParameter("action")).thenReturn("edit");
        when(mockRequest.getParameter("accountNumber")).thenReturn(String.valueOf(accountNumber));
        when(mockCustomerService.getCustomer(accountNumber)).thenReturn(customer);
        when(mockRequest.getRequestDispatcher("/WEB-INF/view/customer.jsp")).thenReturn(mockRequestDispatcher);

        // Act
        customerController.doGet(mockRequest, mockResponse);

        // Assert
        verify(mockCustomerService, times(1)).getCustomer(accountNumber);
        verify(mockRequest, times(1)).setAttribute("customer", customer);
        verify(mockRequestDispatcher, times(1)).forward(mockRequest, mockResponse);
    }

    @Test
    void testDoGet_ActionDelete_DeletesCustomerAndRedirects() throws ServletException, IOException, SQLException {
        // Arrange
        int accountNumber = 12345;
        
        when(mockRequest.getParameter("action")).thenReturn("delete");
        when(mockRequest.getParameter("accountNumber")).thenReturn(String.valueOf(accountNumber));
        when(mockRequest.getContextPath()).thenReturn("/myapp");
        doNothing().when(mockCustomerService).deleteCustomer(accountNumber);

        // Act
        customerController.doGet(mockRequest, mockResponse);

        // Assert
        verify(mockCustomerService, times(1)).deleteCustomer(accountNumber);
        verify(mockResponse, times(1)).sendRedirect("/myapp/customer?action=list");
    }

    @Test
    void testDoGet_InvalidAccountNumberForEdit_ThrowsNumberFormatException() throws SQLException {
        // Arrange
        when(mockRequest.getParameter("action")).thenReturn("edit");
        when(mockRequest.getParameter("accountNumber")).thenReturn("invalid");

        // Act & Assert
        // The NumberFormatException is not caught by the controller, so it propagates directly
        assertThrows(NumberFormatException.class, 
            () -> customerController.doGet(mockRequest, mockResponse));
        verifyNoInteractions(mockCustomerService);
    }

    @Test
    void testDoGet_InvalidAccountNumberForDelete_ThrowsNumberFormatException() throws SQLException {
        // Arrange
        when(mockRequest.getParameter("action")).thenReturn("delete");
        when(mockRequest.getParameter("accountNumber")).thenReturn("invalid");

        // Act & Assert
        // The NumberFormatException is not caught by the controller, so it propagates directly
        assertThrows(NumberFormatException.class, 
            () -> customerController.doGet(mockRequest, mockResponse));
        verifyNoInteractions(mockCustomerService);
    }

    @Test
    void testDoGet_SqlExceptionThrown_ThrowsServletException() throws SQLException {
        // Arrange
        when(mockRequest.getParameter("action")).thenReturn("list");
        when(mockCustomerService.getAllCustomers()).thenThrow(new SQLException("Database error"));

        // Act & Assert
        ServletException exception = assertThrows(ServletException.class,
            () -> customerController.doGet(mockRequest, mockResponse));
        assertTrue(exception.getCause() instanceof SQLException);
        assertEquals("Database error", exception.getCause().getMessage());
    }

    // ========== doPost() Tests ==========

    @Test
    void testDoPost_AddNewCustomer_AddsCustomerAndRedirects() throws ServletException, IOException, SQLException {
        // Arrange
        when(mockRequest.getParameter("accountNumber")).thenReturn("12345");
        when(mockRequest.getParameter("name")).thenReturn("John Doe");
        when(mockRequest.getParameter("address")).thenReturn("123 Main St");
        when(mockRequest.getParameter("telephone")).thenReturn("123-456-7890");
        when(mockRequest.getParameter("action")).thenReturn("add");
        when(mockRequest.getContextPath()).thenReturn("/myapp");
        
        doNothing().when(mockCustomerService).addCustomer(any(Customer.class));

        // Act
        customerController.doPost(mockRequest, mockResponse);

        // Assert
        verify(mockCustomerService, times(1)).addCustomer(any(Customer.class));
        verify(mockResponse, times(1)).sendRedirect("/myapp/customer?action=list");
    }

    @Test
    void testDoPost_UpdateExistingCustomer_UpdatesCustomerAndRedirects() throws ServletException, IOException, SQLException {
        // Arrange
        when(mockRequest.getParameter("accountNumber")).thenReturn("12345");
        when(mockRequest.getParameter("name")).thenReturn("John Doe Updated");
        when(mockRequest.getParameter("address")).thenReturn("123 Updated St");
        when(mockRequest.getParameter("telephone")).thenReturn("123-456-7890");
        when(mockRequest.getParameter("action")).thenReturn("update");
        when(mockRequest.getContextPath()).thenReturn("/myapp");
        
        doNothing().when(mockCustomerService).updateCustomer(any(Customer.class));

        // Act
        customerController.doPost(mockRequest, mockResponse);

        // Assert
        verify(mockCustomerService, times(1)).updateCustomer(any(Customer.class));
        verify(mockCustomerService, never()).addCustomer(any(Customer.class));
        verify(mockResponse, times(1)).sendRedirect("/myapp/customer?action=list");
    }

    @Test
    void testDoPost_InvalidAccountNumber_ThrowsNumberFormatException() {
        // Arrange
        when(mockRequest.getParameter("accountNumber")).thenReturn("invalid");
        when(mockRequest.getParameter("name")).thenReturn("John Doe");
        when(mockRequest.getParameter("address")).thenReturn("123 Main St");
        when(mockRequest.getParameter("telephone")).thenReturn("123-456-7890");

        // Act & Assert
        // The NumberFormatException is not caught by the controller, so it propagates directly
        assertThrows(NumberFormatException.class,
            () -> customerController.doPost(mockRequest, mockResponse));
        verifyNoInteractions(mockCustomerService);
    }

    @Test
    void testDoPost_SqlExceptionOnAdd_ThrowsServletException() throws SQLException {
        // Arrange
        when(mockRequest.getParameter("accountNumber")).thenReturn("12345");
        when(mockRequest.getParameter("name")).thenReturn("John Doe");
        when(mockRequest.getParameter("address")).thenReturn("123 Main St");
        when(mockRequest.getParameter("telephone")).thenReturn("123-456-7890");
        when(mockRequest.getParameter("action")).thenReturn("add");
        
        doThrow(new SQLException("Insert failed")).when(mockCustomerService).addCustomer(any(Customer.class));

        // Act & Assert
        ServletException exception = assertThrows(ServletException.class,
            () -> customerController.doPost(mockRequest, mockResponse));
        assertTrue(exception.getCause() instanceof SQLException);
        assertEquals("Insert failed", exception.getCause().getMessage());
    }

    @Test
    void testDoPost_SqlExceptionOnUpdate_ThrowsServletException() throws SQLException {
        // Arrange
        when(mockRequest.getParameter("accountNumber")).thenReturn("12345");
        when(mockRequest.getParameter("name")).thenReturn("John Doe");
        when(mockRequest.getParameter("address")).thenReturn("123 Main St");
        when(mockRequest.getParameter("telephone")).thenReturn("123-456-7890");
        when(mockRequest.getParameter("action")).thenReturn("update");
        
        doThrow(new SQLException("Update failed")).when(mockCustomerService).updateCustomer(any(Customer.class));

        // Act & Assert
        ServletException exception = assertThrows(ServletException.class,
            () -> customerController.doPost(mockRequest, mockResponse));
        assertTrue(exception.getCause() instanceof SQLException);
        assertEquals("Update failed", exception.getCause().getMessage());
    }

    @Test
    void testDoPost_NullParameters_CreatesCustomerWithNullValues() throws ServletException, IOException, SQLException {
        // Arrange
        when(mockRequest.getParameter("accountNumber")).thenReturn("0");
        when(mockRequest.getParameter("name")).thenReturn(null);
        when(mockRequest.getParameter("address")).thenReturn(null);
        when(mockRequest.getParameter("telephone")).thenReturn(null);
        when(mockRequest.getParameter("action")).thenReturn("add");
        when(mockRequest.getContextPath()).thenReturn("/myapp");
        
        doNothing().when(mockCustomerService).addCustomer(any(Customer.class));

        // Act
        customerController.doPost(mockRequest, mockResponse);

        // Assert
        verify(mockCustomerService, times(1)).addCustomer(any(Customer.class));
        verify(mockResponse, times(1)).sendRedirect("/myapp/customer?action=list");
    }

    @Test
    void testDoPost_EmptyContextPath_RedirectsWithoutContextPath() throws ServletException, IOException, SQLException {
        // Arrange
        when(mockRequest.getParameter("accountNumber")).thenReturn("12345");
        when(mockRequest.getParameter("name")).thenReturn("John Doe");
        when(mockRequest.getParameter("address")).thenReturn("123 Main St");
        when(mockRequest.getParameter("telephone")).thenReturn("123-456-7890");
        when(mockRequest.getParameter("action")).thenReturn("add");
        when(mockRequest.getContextPath()).thenReturn("");
        
        doNothing().when(mockCustomerService).addCustomer(any(Customer.class));

        // Act
        customerController.doPost(mockRequest, mockResponse);

        // Assert
        verify(mockCustomerService, times(1)).addCustomer(any(Customer.class));
        verify(mockResponse, times(1)).sendRedirect("/customer?action=list");
    }

    // Helper method to create Customer objects for testing
    private Customer createCustomer(int accountNumber, String name, String address, String telephone) {
        return new Customer(accountNumber, name, address, telephone);
    }
}