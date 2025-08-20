package com.pahanaedu.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionFactory {

    private static final String URL = "jdbc:mysql://localhost:3306/productdb";
    private static final String USER = "root"; 
    private static final String PASSWORD = "sasmitha@34";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
