<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer List</title>
</head>
<body>
<h1>Customer List</h1>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>Account Number</th>
        <th>Name</th>
        <th>Address</th>
        <th>Telephone</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="customer" items="${customers}">
        <tr>
            <td>${customer.accountNumber}</td>
            <td>${customer.name}</td>
            <td>${customer.address}</td>
            <td>${customer.telephone}</td>
            <td>
                <a href="${pageContext.request.contextPath}/customer?action=edit&accountNumber=${customer.accountNumber}">Edit</a>
                <a href="${pageContext.request.contextPath}/customer?action=delete&accountNumber=${customer.accountNumber}" 
                   onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="${pageContext.request.contextPath}/customer?action=form">Add New Customer</a> |
<a href="${pageContext.request.contextPath}/adminPage">Back </a>

</body>
</html>
