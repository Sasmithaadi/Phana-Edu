package com.pahanaedu.service;

import com.pahanaedu.dao.UserDao;
import com.pahanaedu.model.User;

public class UserService {
    private UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public User authenticate(String email, String password) {
        return userDao.login(email, password);
    }
}
