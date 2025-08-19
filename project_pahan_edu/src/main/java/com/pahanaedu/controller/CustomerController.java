package com.pahanaedu.controller;

import com.pahanaedu.model.Customer;
import com.pahanaedu.service.CustomerService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/customer")
public class CustomerController extends HttpServlet {
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "form":
                    RequestDispatcher formView = request.getRequestDispatcher("/WEB-INF/view/customer.jsp");
                    formView.forward(request, response);
                    break;

                case "edit":
                    int editId = Integer.parseInt(request.getParameter("accountNumber"));
                    Customer customer = customerService.getCustomer(editId);
                    request.setAttribute("customer", customer);
                    RequestDispatcher editView = request.getRequestDispatcher("/WEB-INF/view/customer.jsp");
                    editView.forward(request, response);
                    break;

                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("accountNumber"));
                    customerService.deleteCustomer(deleteId);
                    response.sendRedirect(request.getContextPath() + "/customer?action=list");
                    break;

                case "list":
                default:
                    List<Customer> customers = customerService.getAllCustomers();
                    request.setAttribute("customers", customers);
                    RequestDispatcher listView = request.getRequestDispatcher("/WEB-INF/view/customerList.jsp");
                    listView.forward(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");

        Customer customer = new Customer(accountNumber, name, address, telephone);

        try {
            if ("update".equals(request.getParameter("action"))) {
                customerService.updateCustomer(customer);
            } else {
                customerService.addCustomer(customer);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        response.sendRedirect(request.getContextPath() + "/customer?action=list");
    }
}
