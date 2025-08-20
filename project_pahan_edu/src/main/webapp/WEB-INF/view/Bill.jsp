<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>${mode == 'edit' ? 'Edit Bill' : 'New Bill'}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background:#fafafa; }
        .card { background:#fff; padding:16px; border-radius:10px; box-shadow:0 2px 6px rgba(0,0,0,0.08); }
        table { border-collapse: collapse; width: 100%; margin-top:12px; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background:#f4f4f4; }
        .btn { padding: 6px 10px; text-decoration: none; border: 1px solid #888; border-radius: 6px; background:#fff; cursor:pointer; }
        .btn:hover { background:#f0f0f0; }
        .row-actions button { margin-right: 6px; }
        .toolbar { margin-top: 12px; display:flex; gap:8px; }
        input[type=number] { width: 120px; }
        .right { text-align:right; }
    </style>
</head>
<body>
<div class="card">
    <h2>${mode == 'edit' ? 'Edit Bill' : 'Create Bill'}</h2>

    <form method="post" action="${pageContext.request.contextPath}/Bill">
        <input type="hidden" name="mode" value="${mode}"/>
        <c:if test="${mode == 'edit'}">
            <input type="hidden" name="billId" value="${bill.billId}"/>
        </c:if>

        <label>Customer Name:
            <input type="text" name="customerID" required
                   value="${mode == 'edit' ? bill.customerName : ''}">
        </label>

        <table id="itemsTable">
            <thead>
            <tr>
                <th>Product Name</th>
                <th>Qty</th>
                <th>Unit Price</th>
                <th class="right">Line Total</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="tbody">
            <c:choose>
                <c:when test="${mode == 'edit'}">
                    <c:forEach var="it" items="${bill.items}">
                        <tr>
                            <td><input type="text" name="productName[]" value="${it.productName}" required></td>
                            <td><input type="number" name="quantity[]" min="1" value="${it.quantity}" required oninput="recalc(this)"></td>
                            <td><input type="number" name="price[]" step="0.01" min="0" value="${it.price}" required oninput="recalc(this)"></td>
                            <td class="right lineTotal">0.00</td>
                            <td class="row-actions">
                                <button type="button" class="btn" onclick="removeRow(this)">Remove</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td><input type="text" name="productName[]" required></td>
                        <td><input type="number" name="quantity[]" min="1" value="1" required oninput="recalc(this)"></td>
                        <td><input type="number" name="price[]" step="0.01" min="0" value="0.00" required oninput="recalc(this)"></td>
                        <td class="right lineTotal">0.00</td>
                        <td class="row-actions">
                            <button type="button" class="btn" onclick="removeRow(this)">Remove</button>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

        <div class="toolbar">
            <button type="button" class="btn" onclick="addRow()">+ Add Item</button>
            <button type="button" class="btn" onclick="recalcAll()">Recalculate</button>
            <a class="btn" href="${pageContext.request.contextPath}/Bill?action=list">Back</a>
            <button type="submit" class="btn">Save</button>
        </div>

        <h3>Total: <span id="grandTotal">0.00</span></h3>
    </form>
</div>

<script>
    function addRow() {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td><input type="text" name="productName[]" required></td>
            <td><input type="number" name="quantity[]" min="1" value="1" required oninput="recalc(this)"></td>
            <td><input type="number" name="price[]" step="0.01" min="0" value="0.00" required oninput="recalc(this)"></td>
            <td class="right lineTotal">0.00</td>
            <td class="row-actions">
                <button type="button" class="btn" onclick="removeRow(this)">Remove</button>
            </td>`;
        document.getElementById('tbody').appendChild(tr);
        recalcAll();
    }

    function removeRow(btn) {
        const tr = btn.closest('tr');
        tr.parentNode.removeChild(tr);
        recalcAll();
    }

    function recalc(input) {
        const tr = input.closest('tr');
        const qty = parseFloat(tr.querySelector('input[name="quantity[]"]').value || 0);
        const price = parseFloat(tr.querySelector('input[name="price[]"]').value || 0);
        const total = Math.round(qty * price * 100) / 100;
        tr.querySelector('.lineTotal').innerText = total.toFixed(2);
        recalcGrand();
    }

    function recalcAll() {
        document.querySelectorAll('#tbody tr').forEach(tr => {
            const qty = parseFloat(tr.querySelector('input[name="quantity[]"]')?.value || 0);
            const price = parseFloat(tr.querySelector('input[name="price[]"]')?.value || 0);
            const total = Math.round(qty * price * 100) / 100;
            const cell = tr.querySelector('.lineTotal');
            if (cell) cell.innerText = total.toFixed(2);
        });
        recalcGrand();
    }

    function recalcGrand() {
        let sum = 0;
        document.querySelectorAll('.lineTotal').forEach(td => sum += parseFloat(td.innerText || 0));
        document.getElementById('grandTotal').innerText = sum.toFixed(2);
    }

    // initial recompute on load
    window.addEventListener('load', recalcAll);
</script>
</body>
</html>
