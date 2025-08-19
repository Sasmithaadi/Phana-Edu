package com.pahanaedu.service;

import com.pahanaedu.dao.ProductDAO;
import com.pahanaedu.model.Product;

import java.util.List;

public class ProductService {

    // Singleton instance
    private static ProductService instance;
    private final ProductDAO dao;

    private ProductService() {
        dao = new ProductDAO();
    }

    // Thread-safe singleton getter
    public static synchronized ProductService getInstance() {
        if (instance == null) {
            instance = new ProductService();
        }
        return instance;
    }

    // Retrieve all products
    public List<Product> getAllProducts() {
        return dao.getAllProducts();
    }

    // Retrieve single product by ID
    public Product getProductById(int id) { // FIXED: Method name from getproductById to getProductById
        return dao.getProductById(id); // FIXED: Assuming DAO method is also corrected
    }

    // Add new product
    public void addProduct(Product product) {
        if (product != null) {
            dao.addProduct(product);
        }
    }

    // Update existing product
    public void updateProduct(Product product) {
        if (product != null && product.getProductId() > 0) {
            dao.updateProduct(product);
        }
    }

    // Delete product by ID
    public void deleteProduct(int id) {
        if (id > 0) {
            dao.deleteProduct(id);
        }
    }
}