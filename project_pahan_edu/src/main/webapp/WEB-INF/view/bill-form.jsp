<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Billing Form</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        th { background: #f2f2f2; }
        .btn { padding: 6px 12px; border: none; cursor: pointer; border-radius: 4px; }
        .btn-add { background: green; color: white; }
        .btn-remove { background: red; color: white; }
        .btn-submit { background: blue; color: white; margin-top: 10px; }
    </style>
</head>
<body>

<h2>Create New Bill</h2>

<c:if test="${param.success == 'true'}">
    <p style="color: green;">Bill saved successfully! Bill ID: ${param.billId}</p>
</c:if>

<form action="${pageContext.request.contextPath}/Bill" method="post">

    <label>Customer:</label>
    <select name="customerId" required>
        <option value="">-- Select Customer --</option>
        <c:forEach var="c" items="${customers}">
            <option value="${c.accountNumber}">${c.name} - ${c.telephone}</option>
        </c:forEach>
    </select>
    <br><br>

    <table id="billTable">
        <thead>
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price (LKR)</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <select name="productId[]" onchange="updatePrice(this)" required>
                        <option value="">-- Select Product --</option>
                        <c:forEach var="p" items="${products}">
                            <option value="${p.productId}" data-price="${p.price}">
                                ${p.name} - ${p.price}
                            </option>
                        </c:forEach>
                    </select>
                </td>
                <td><input type="number" name="quantity[]" value="1" min="1" required oninput="updateTotal()"></td>
                <td><input type="number" step="0.01" name="price[]" value="0" readonly></td>
                <td><button type="button" class="btn btn-remove" onclick="removeRow(this)">X</button></td>
            </tr>
        </tbody>
    </table>

    <button type="button" class="btn btn-add" onclick="addRow()">+ Add Product</button>
    <br><br>
    <strong>Total: LKR <span id="total">0.00</span></strong>
    <br><br>
    <button type="submit" class="btn btn-submit">Save Bill</button>
</form>

<script>
function updatePrice(selectElement) {
    const price = selectElement.options[selectElement.selectedIndex].dataset.price;
    const priceInput = selectElement.parentNode.parentNode.querySelector('input[name="price[]"]');
    if (priceInput && price) {
        priceInput.value = price;
    }
    updateTotal();
}

function updateTotal() {
    let total = 0;
    document.querySelectorAll('#billTable tbody tr').forEach(row => {
        const qty = row.querySelector('input[name="quantity[]"]').value;
        const price = row.querySelector('input[name="price[]"]').value;
        total += (qty * price);
    });
    document.getElementById('total').innerText = total.toFixed(2);
}

function addRow() {
    const table = document.getElementById("billTable").querySelector("tbody");
    const newRow = table.rows[0].cloneNode(true);
    newRow.querySelectorAll("input").forEach(input => {
        if (input.type === "number") input.value = (input.name.includes("quantity")) ? 1 : 0;
    });
    newRow.querySelector("select").selectedIndex = 0;
    table.appendChild(newRow);
    updateTotal();
}

function removeRow(button) {
    const row = button.closest("tr");
    const tbody = row.parentNode;
    if (tbody.rows.length > 1) {
        tbody.removeChild(row);
    }
    updateTotal();
}
</script>

</body>
</html>
