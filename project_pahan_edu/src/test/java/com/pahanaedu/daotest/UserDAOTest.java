package com.pahanaedu.daotest;

import com.pahanaedu.dao.UserDao;
import com.pahanaedu.model.User;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class UserDAOTest {

    private static Connection conn;
    private static UserDao userDao;

    @BeforeAll
    public static void setup() throws Exception {
        // ⚠️ Change URL, user, and password according to your test DB
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu_test", "root", "password");
        userDao = new UserDao(conn);

        // Prepare test data
        try (Statement stmt = conn.createStatement()) {
            stmt.execute("DELETE FROM users"); // clean old data
            stmt.execute("INSERT INTO users (id, name, email, password, role) VALUES (1, 'Admin User', 'admin@test.com', 'admin123', 'admin')");
            stmt.execute("INSERT INTO users (id, name, email, password, role) VALUES (2, 'Staff User', 'staff@test.com', 'staff123', 'staff')");
        }
    }

    @Test
    @Order(1)
    public void testValidLogin_Admin() {
        User user = userDao.login("admin@test.com", "admin123");
        assertNotNull(user);
        assertEquals("Admin User", user.getName());
        assertEquals("admin", user.getRole());
    }

    @Test
    @Order(2)
    public void testValidLogin_Staff() {
        User user = userDao.login("staff@test.com", "staff123");
        assertNotNull(user);
        assertEquals("Staff User", user.getName());
        assertEquals("staff", user.getRole());
    }

    @Test
    @Order(3)
    public void testInvalidLogin() {
        User user = userDao.login("wrong@test.com", "wrongpass");
        assertNull(user, "Invalid login should return null");
    }

    @AfterAll
    public static void cleanup() throws Exception {
        if (conn != null && !conn.isClosed()) {
            conn.close();
        }
    }
}
