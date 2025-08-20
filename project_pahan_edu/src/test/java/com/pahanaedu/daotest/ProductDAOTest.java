package com.pahanaedu.daotest;

import com.pahanaedu.dao.ProductDAO;
import com.pahanaedu.model.Product;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class ProductDAOTest {

    private static ProductDAO productDAO;
    private static int testProductId;

    @BeforeAll
    public static void setup() {
        productDAO = new ProductDAO();
    }

    @Test
    @Order(1)
    public void testAddProduct() {
        Product product = new Product(0, "Test Product", "JUnit Test Description", 99.99);
        productDAO.addProduct(product);

        // Fetch all products and get the last inserted one
        List<Product> products = productDAO.getAllProducts();
        assertFalse(products.isEmpty());

        Product lastProduct = products.get(products.size() - 1);
        testProductId = lastProduct.getProductId(); // store ID for later tests

        assertEquals("Test Product", lastProduct.getName());
        assertEquals("JUnit Test Description", lastProduct.getDescription());
        assertEquals(99.99, lastProduct.getPrice());
    }

    @Test
    @Order(2)
    public void testGetProductById() {
        Product product = productDAO.getProductById(testProductId);
        assertNotNull(product);
        assertEquals("Test Product", product.getName());
    }

    @Test
    @Order(3)
    public void testUpdateProduct() {
        Product product = productDAO.getProductById(testProductId);
        product.setName("Updated Product");
        product.setPrice(199.99);
        productDAO.updateProduct(product);

        Product updated = productDAO.getProductById(testProductId);
        assertEquals("Updated Product", updated.getName());
        assertEquals(199.99, updated.getPrice());
    }

    @Test
    @Order(4)
    public void testGetAllProducts() {
        List<Product> products = productDAO.getAllProducts();
        assertNotNull(products);
        assertTrue(products.size() > 0);
    }

    @Test
    @Order(5)
    public void testDeleteProduct() {
        productDAO.deleteProduct(testProductId);
        Product deleted = productDAO.getProductById(testProductId);
        assertNull(deleted);
    }
}
