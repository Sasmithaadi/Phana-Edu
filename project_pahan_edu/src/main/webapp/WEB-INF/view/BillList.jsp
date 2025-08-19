<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bill List</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background:#f7f7f7; }
        table { border-collapse: collapse; width: 100%; background:#fff; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align:left; }
        th { background:#f0f0f0; }
        .topbar { margin-bottom: 15px; }
        .btn { padding: 6px 10px; text-decoration: none; border: 1px solid #888; border-radius: 6px; background:#fff; }
        .btn:hover { background:#f0f0f0; }
        .actions a { margin-right: 6px; }
        .empty { padding: 18px; background:#fff; border:1px dashed #bbb; }
    </style>
</head>
<body>
<div class="topbar">
    <a class="btn" href="${pageContext.request.contextPath}/Bill?action=new">+ New Bill</a>
</div>

<c:choose>
    <c:when test="${empty bills}">
        <div class="empty">No bills yet. Click “New Bill” to create one.</div>
    </c:when>
    <c:otherwise>
        <table>
            <thead>
            <tr>
                <th>Bill ID</th>
                <th>Customer</th>
                <th>Total</th>
                <th style="width:260px;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="b" items="${bills}">
                <tr>
                    <td>${b.billId}</td>
                    <td>${b.customerName}</td>
                    <td>${b.totalAmount}</td>
                    <td class="actions">
                        <a class="btn" href="${pageContext.request.contextPath}/Bill?action=view&id=${b.billId}">View</a>
                        <a class="btn" href="${pageContext.request.contextPath}/Bill?action=edit&id=${b.billId}">Edit</a>
                        <a class="btn" href="${pageContext.request.contextPath}/Bill?action=delete&id=${b.billId}" onclick="return confirm('Delete bill #${b.billId}?')">Delete</a>
                        <a class="btn" href="${pageContext.request.contextPath}/Bill?action=view&id=${b.billId}" target="_blank">Print</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>

</body>
</html>
