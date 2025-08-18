package com.pahanaedu.dao;

import java.sql.*;
import com.pahanaedu.model.User;

public class UserDao {
    private Connection conn;

    public UserDao(Connection conn) {
        this.conn = conn;
    }

    public User login(String email, String password) {
        User user = null;
        try {
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if(rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
