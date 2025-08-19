<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    session.invalidate();  // clear session
    response.sendRedirect(request.getContextPath() + "/login.jsp"); // back to login page
%>
