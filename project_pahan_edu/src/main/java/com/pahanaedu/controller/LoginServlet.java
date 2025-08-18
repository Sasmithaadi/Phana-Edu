package com.pahanaedu.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.Connection;
import com.pahanaedu.model.User;
import com.pahanaedu.dao.UserDao;
import com.pahanaedu.service.UserService;
import com.pahanaedu.dao.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            UserDao userDao = new UserDao(conn);
            UserService userService = new UserService(userDao);

            User user = userService.authenticate(email, password);

            if(user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);

                // Forward to JSPs inside /WEB-INF
                if(user.getRole().equalsIgnoreCase("admin")) {
                    request.getRequestDispatcher("/WEB-INF/view/admin-dashboard.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/WEB-INF/view/staff-dashboard.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Invalid email or password!");
                request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            }

        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Server error. Please try again.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }

    // Optional: handle GET request to show login page
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }
}
