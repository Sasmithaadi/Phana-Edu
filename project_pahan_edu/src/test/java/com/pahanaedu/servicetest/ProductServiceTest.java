package com.pahanaedu.servicetest;

import com.pahanaedu.dao.ProductDAO;
import com.pahanaedu.model.Product;
import com.pahanaedu.service.ProductService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class ProductServiceTest {

    @Mock
    private ProductDAO mockDao;
    
    private ProductService productService;

    @BeforeEach
    void setUp() throws Exception {
        // Reset singleton instance before each test
        resetSingleton();
        productService = ProductService.getInstance();
        
        // Inject mock DAO using reflection
        Field daoField = ProductService.class.getDeclaredField("dao");
        daoField.setAccessible(true);
        daoField.set(productService, mockDao);
    }

    @Test
    void testGetInstance_ReturnsSingletonInstance() {
        ProductService instance1 = ProductService.getInstance();
        ProductService instance2 = ProductService.getInstance();
        
        assertSame(instance1, instance2, "Should return the same singleton instance");
    }

    @Test
    void testGetAllProducts_ReturnsAllProducts() {
        // Arrange
        List<Product> expectedProducts = Arrays.asList(
            createProduct(1, "Product1", 10.0),
            createProduct(2, "Product2", 20.0)
        );
        when(mockDao.getAllProducts()).thenReturn(expectedProducts);

        // Act
        List<Product> actualProducts = productService.getAllProducts();

        // Assert
        assertEquals(expectedProducts, actualProducts);
        verify(mockDao, times(1)).getAllProducts();
    }

    @Test
    void testGetProductById_ValidId_ReturnsProduct() {
        // Arrange
        int productId = 1;
        Product expectedProduct = createProduct(productId, "Test Product", 15.0);
        when(mockDao.getProductById(productId)).thenReturn(expectedProduct);

        // Act
        Product actualProduct = productService.getProductById(productId);

        // Assert
        assertEquals(expectedProduct, actualProduct);
        verify(mockDao, times(1)).getProductById(productId);
    }

    @Test
    void testGetProductById_InvalidId_ReturnsNull() {
        // Arrange
        int productId = 999;
        when(mockDao.getProductById(productId)).thenReturn(null);

        // Act
        Product actualProduct = productService.getProductById(productId);

        // Assert
        assertNull(actualProduct);
        verify(mockDao, times(1)).getProductById(productId);
    }

    @Test
    void testAddProduct_ValidProduct_CallsDAO() {
        // Arrange
        Product product = createProduct(1, "New Product", 25.0);

        // Act
        productService.addProduct(product);

        // Assert
        verify(mockDao, times(1)).addProduct(product);
    }

    @Test
    void testAddProduct_NullProduct_DoesNotCallDAO() {
        // Act
        productService.addProduct(null);

        // Assert
        verify(mockDao, never()).addProduct(any());
    }

    @Test
    void testUpdateProduct_ValidProduct_CallsDAO() {
        // Arrange
        Product product = createProduct(1, "Updated Product", 30.0);

        // Act
        productService.updateProduct(product);

        // Assert
        verify(mockDao, times(1)).updateProduct(product);
    }

    @Test
    void testUpdateProduct_NullProduct_DoesNotCallDAO() {
        // Act
        productService.updateProduct(null);

        // Assert
        verify(mockDao, never()).updateProduct(any());
    }

    @Test
    void testUpdateProduct_ProductWithZeroId_DoesNotCallDAO() {
        // Arrange
        Product product = createProduct(0, "Product", 10.0);

        // Act
        productService.updateProduct(product);

        // Assert
        verify(mockDao, never()).updateProduct(any());
    }

    @Test
    void testUpdateProduct_ProductWithNegativeId_DoesNotCallDAO() {
        // Arrange
        Product product = createProduct(-1, "Product", 10.0);

        // Act
        productService.updateProduct(product);

        // Assert
        verify(mockDao, never()).updateProduct(any());
    }

    @Test
    void testDeleteProduct_ValidId_CallsDAO() {
        // Arrange
        int productId = 1;

        // Act
        productService.deleteProduct(productId);

        // Assert
        verify(mockDao, times(1)).deleteProduct(productId);
    }

    @Test
    void testDeleteProduct_ZeroId_DoesNotCallDAO() {
        // Act
        productService.deleteProduct(0);

        // Assert
        verify(mockDao, never()).deleteProduct(anyInt());
    }

    @Test
    void testDeleteProduct_NegativeId_DoesNotCallDAO() {
        // Act
        productService.deleteProduct(-1);

        // Assert
        verify(mockDao, never()).deleteProduct(anyInt());
    }

    // Helper method to create Product objects for testing
    private Product createProduct(int id, String name, double price) {
        Product product = new Product();
        product.setProductId(id);
        product.setName(name);
        product.setPrice(price);
        return product;
    }

    // Helper method to reset singleton instance using reflection
    private void resetSingleton() throws Exception {
        Field instanceField = ProductService.class.getDeclaredField("instance");
        instanceField.setAccessible(true);
        instanceField.set(null, null);
    }
}