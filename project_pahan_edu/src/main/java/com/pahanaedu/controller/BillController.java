package com.pahanaedu.controller;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.ProductDAO;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Product;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Bill")
public class BillController extends HttpServlet {

    private CustomerDAO customerDAO;
    private ProductDAO productDAO;
    private BillDAO billDAO;

    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        productDAO = new ProductDAO();
        billDAO = new BillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("form".equals(action)) {
            // Load customers and products for the form
            List<Customer> customers = CustomerDAO.getAllCustomers();
            List<Product> products = productDAO.getAllProducts();

            request.setAttribute("customers", customers);
            request.setAttribute("products", products);

            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/bill-form.jsp");
            rd.forward(request, response);
        } else {
            // fallback redirect
            response.sendRedirect(request.getContextPath() + "/adminPage.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String[] productIds = request.getParameterValues("productId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] prices = request.getParameterValues("price[]");

            List<BillItem> items = new ArrayList<>();
            double total = 0;

            if (productIds != null) {
                for (int i = 0; i < productIds.length; i++) {
                    int productId = Integer.parseInt(productIds[i]);
                    int qty = Integer.parseInt(quantities[i]);
                    double price = Double.parseDouble(prices[i]);

                    if (qty > 0) {
                        total += qty * price;
                        items.add(new BillItem(0, productId, qty, price));
                    }
                }
            }

            // Create Bill
            Bill bill = new Bill();
            bill.setBillId(billDAO.nextId());  // Generate next ID
            bill.setCustomerId(customerId);
            bill.setTotalAmount(total);
            bill.setItems(items);

            // Attach billId to each item
            for (BillItem item : items) {
                item.setBillId(bill.getBillId());
            }

            // Save Bill + Items
            billDAO.save(bill);

            // Redirect back with success message
            response.sendRedirect(request.getContextPath() +
                    "/Bill?action=form&success=true&billId=" + bill.getBillId());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error creating bill: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/bill-form.jsp");
            rd.forward(request, response);
        }
    }
}
