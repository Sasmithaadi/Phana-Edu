<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bill #${bill.billId}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .toolbar { margin-bottom: 12px; }
        .btn { padding: 6px 10px; text-decoration: none; border: 1px solid #888; border-radius: 6px; background:#fff; }
        .btn:hover { background:#f0f0f0; }
        .bill { max-width: 800px; margin: auto; border:1px solid #ccc; padding:16px; }
        h2 { margin-top:0; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background:#f4f4f4; }
        .right { text-align:right; }
        @media print {
            .toolbar { display: none; }
            .bill { border: none; }
        }
    </style>
</head>
<body>
<div class="toolbar">
    <a class="btn" href="${pageContext.request.contextPath}/Bill?action=list">Back</a>
    <a class="btn" href="${pageContext.request.contextPath}/Bill?action=edit&id=${bill.billId}">Edit</a>
    <button class="btn" onclick="window.print()">Print</button>
</div>

<div class="bill">
    <h2>Bill #${bill.billId}</h2>
    <p><strong>Customer:</strong> ${bill.customerName}</p>

    <table>
        <thead>
        <tr>
            <th>Product</th>
            <th class="right">Qty</th>
            <th class="right">Unit Price</th>
            <th class="right">Line Total</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="it" items="${bill.items}">
            <tr>
                <td>${it.productName}</td>
                <td class="right">${it.quantity}</td>
                <td class="right">${it.price}</td>
                <td class="right">${it.total}</td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
            <th colspan="3" class="right">Grand Total</th>
            <th class="right">${bill.totalAmount}</th>
        </tr>
        </tfoot>
    </table>
</div>

</body>
</html>
