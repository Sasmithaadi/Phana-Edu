package com.pahanaedu.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.pahanaedu.model.User;

@WebServlet("/adminPage")
public class AdminPageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        if(currentUser != null && "admin".equalsIgnoreCase(currentUser.getRole())) {
            request.getRequestDispatcher("/WEB-INF/view/AdminPage.jsp").forward(request, response);
        } else {
        	 request.getRequestDispatcher("/WEB-INF/view/AdminPage.jsp").forward(request, response);
        }
    }
}
