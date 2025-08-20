<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
</head>
<body>
<h1>Edit Product</h1>

<form action="Product" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="productId" value="${product.productId}">

    Name: <input type="text" name="name" value="${product.name}" required><br>
    Price: <input type="number" step="0.01" name="price" value="${product.price}" required><br>
    Description: <textarea name="description" required>${product.description}</textarea><br>
    <input type="submit" value="Update Product">
</form>

<a href="Product?action=list">Back to List</a>
</body>
</html>
