<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
</head>
<body>
<h1>Add Product</h1>
<form action="Product?action=add" method="post">
    <label>Name:</label>
    <input type="text" name="name" required><br><br>

    <label>Price:</label>
    <input type="number" step="0.01" name="price" required><br><br>

    <label>Description:</label>
    <input type="text" name="description"><br><br>

    <input type="submit" value="Add Product">
</form>
<br>
<a href="Product?action=list">Back to List</a>
</body>
</html>