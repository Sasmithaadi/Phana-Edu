<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product List</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Exo+2:wght@300;400;500;600&display=swap');

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Exo 2', sans-serif;
    background: linear-gradient(135deg, #0a0a23 0%, #1a1a3e 25%, #2d1b69 50%, #1a1a3e 75%, #0a0a23 100%);
    min-height: 100vh;
    color: #e0e6ed;
    position: relative;
    overflow-x: hidden;
    padding: 2rem;
}

/* Animated background particles */
body::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: 
        radial-gradient(2px 2px at 20px 30px, rgba(255,255,255,0.1), transparent),
        radial-gradient(2px 2px at 40px 70px, rgba(255,255,255,0.05), transparent),
        radial-gradient(1px 1px at 90px 40px, rgba(255,255,255,0.08), transparent),
        radial-gradient(1px 1px at 130px 80px, rgba(255,255,255,0.06), transparent),
        radial-gradient(2px 2px at 160px 30px, rgba(255,255,255,0.04), transparent);
    background-repeat: repeat;
    background-size: 200px 150px;
    animation: particleFloat 20s linear infinite;
    pointer-events: none;
    z-index: 1;
}

@keyframes particleFloat {
    0% { transform: translateY(0px) translateX(0px); }
    50% { transform: translateY(-20px) translateX(10px); }
    100% { transform: translateY(0px) translateX(0px); }
}

.container {
    position: relative;
    z-index: 2;
    max-width: 1400px;
    margin: 0 auto;
}

.main-card {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 25px;
    padding: 3rem;
    backdrop-filter: blur(20px);
    box-shadow: 
        0 8px 32px rgba(0, 0, 0, 0.3),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
    position: relative;
    overflow: hidden;
    animation: fadeInUp 0.8s ease-out;
}

.main-card::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(45deg, transparent, rgba(0, 255, 255, 0.03), transparent);
    animation: shimmer 4s infinite;
    pointer-events: none;
}

@keyframes shimmer {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

h1 {
    font-family: 'Orbitron', monospace;
    font-size: 2.8rem;
    font-weight: 900;
    background: linear-gradient(135deg, #00d4ff, #7c3aed, #f59e0b);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 3rem;
    text-align: center;
    text-transform: uppercase;
    letter-spacing: 3px;
    position: relative;
}

h1::after {
    content: '';
    position: absolute;
    bottom: -15px;
    left: 50%;
    transform: translateX(-50%);
    width: 60%;
    height: 3px;
    background: linear-gradient(90deg, transparent, #00d4ff, #7c3aed, #f59e0b, transparent);
    animation: glow 2s ease-in-out infinite alternate;
}

@keyframes glow {
    from { opacity: 0.5; box-shadow: 0 0 15px rgba(0, 212, 255, 0.4); }
    to { opacity: 1; box-shadow: 0 0 25px rgba(0, 212, 255, 0.7); }
}

.table-container {
    background: rgba(255, 255, 255, 0.05);
    border-radius: 20px;
    overflow: hidden;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.1);
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
    margin-bottom: 2rem;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: transparent;
}

th, td {
    padding: 1.2rem 1.5rem;
    text-align: left;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

th {
    background: linear-gradient(135deg, rgba(0, 212, 255, 0.1), rgba(124, 58, 237, 0.1));
    color: #e0e6ed;
    font-family: 'Orbitron', monospace;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    font-size: 0.9rem;
    position: relative;
}

th::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, #00d4ff, #7c3aed, transparent);
}

td {
    color: #e0e6ed;
    font-weight: 500;
}

tr:nth-child(even) {
    background: rgba(255, 255, 255, 0.02);
}

tr:hover {
    background: rgba(0, 212, 255, 0.1);
    transform: scale(1.01);
    transition: all 0.3s ease;
}

/* Action links */
a[href*="edit"],
a[href*="delete"] {
    text-decoration: none;
    padding: 0.5rem 1rem;
    border-radius: 25px;
    transition: all 0.3s ease;
    font-weight: 600;
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-right: 0.5rem;
    position: relative;
    overflow: hidden;
}

a[href*="edit"] {
    background: linear-gradient(135deg, rgba(251, 191, 36, 0.1), rgba(245, 158, 11, 0.1));
    color: #fbbf24;
    border: 1px solid rgba(251, 191, 36, 0.3);
}

a[href*="edit"]:hover {
    background: linear-gradient(135deg, rgba(251, 191, 36, 0.2), rgba(245, 158, 11, 0.2));
    border-color: rgba(251, 191, 36, 0.6);
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(251, 191, 36, 0.3);
    color: #f59e0b;
}

a[href*="delete"] {
    background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(220, 38, 127, 0.1));
    color: #ef4444;
    border: 1px solid rgba(239, 68, 68, 0.3);
}

a[href*="delete"]:hover {
    background: linear-gradient(135deg, rgba(239, 68, 68, 0.2), rgba(220, 38, 127, 0.2));
    border-color: rgba(239, 68, 68, 0.6);
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(239, 68, 68, 0.3);
    color: #dc2626;
}

.btn {
    display: inline-block;
    padding: 1.2rem 3rem;
    color: #e0e6ed;
    text-decoration: none;
    border-radius: 50px;
    font-weight: 600;
    font-size: 1.1rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
    margin: 0.5rem;
    text-align: center;
    font-family: 'Exo 2', sans-serif;
}

.btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s ease;
}

.btn:hover::before {
    left: 100%;
}

.add-btn {
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.1), rgba(22, 163, 74, 0.1));
    border: 2px solid rgba(34, 197, 94, 0.4);
    color: #22c55e;
}

.add-btn:hover {
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.2), rgba(22, 163, 74, 0.2));
    border-color: rgba(34, 197, 94, 0.6);
    transform: translateY(-3px);
    box-shadow: 
        0 12px 30px rgba(34, 197, 94, 0.3),
        0 0 25px rgba(34, 197, 94, 0.2);
    color: #16a34a;
}

.back-btn {
    background: linear-gradient(135deg, rgba(0, 212, 255, 0.1), rgba(124, 58, 237, 0.1));
    border: 2px solid rgba(0, 212, 255, 0.3);
    color: #00d4ff;
}

.back-btn:hover {
    background: linear-gradient(135deg, rgba(0, 212, 255, 0.2), rgba(124, 58, 237, 0.2));
    border-color: rgba(0, 212, 255, 0.6);
    transform: translateY(-3px);
    box-shadow: 
        0 12px 30px rgba(0, 212, 255, 0.3),
        0 0 25px rgba(124, 58, 237, 0.2);
    color: #0ea5e9;
}

.button-group {
    text-align: center;
    margin-top: 2rem;
}

/* Decorative elements */
.product-icon {
    position: absolute;
    font-size: 4rem;
    opacity: 0.08;
    color: #00d4ff;
    animation: float 8s ease-in-out infinite;
    z-index: 0;
}

.product-icon:nth-child(1) {
    top: 10%;
    left: 5%;
    animation-delay: 0s;
}

.product-icon:nth-child(2) {
    top: 20%;
    right: 8%;
    animation-delay: 3s;
}

.product-icon:nth-child(3) {
    bottom: 15%;
    left: 10%;
    animation-delay: 6s;
}

@keyframes float {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    33% { transform: translateY(-25px) rotate(3deg); }
    66% { transform: translateY(15px) rotate(-3deg); }
}

/* Loading animation */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsive design */
@media (max-width: 1200px) {
    .container {
        padding: 1rem;
    }
    
    .main-card {
        padding: 2rem;
    }
    
    table {
        font-size: 0.9rem;
    }
    
    th, td {
        padding: 1rem;
    }
}

@media (max-width: 768px) {
    h1 {
        font-size: 2.2rem;
        letter-spacing: 2px;
    }
    
    .btn {
        padding: 1rem 2rem;
        font-size: 1rem;
        margin: 0.3rem;
    }
    
    th, td {
        padding: 0.8rem;
        font-size: 0.8rem;
    }
    
    .table-container {
        overflow-x: auto;
    }
}

/* Smooth scrollbar */
::-webkit-scrollbar {
    width: 8px;
}

::-webkit-scrollbar-track {
    background: rgba(255, 255, 255, 0.1);
}

::-webkit-scrollbar-thumb {
    background: linear-gradient(135deg, #00d4ff, #7c3aed);
    border-radius: 10px;
}
</style>
</head>
<body>
    <!-- Decorative product icons -->
    <div class="product-icon">&#128230;</div>
    <div class="product-icon">&#128179;</div>
    <div class="product-icon">&#128218;</div>

    <div class="container">
        <div class="main-card">
            <h1>Product List</h1>
            
            <div class="table-container">
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Actions</th>
                    </tr>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.productId}</td>
                            <td>${product.name}</td>
                            <td>${product.price}</td>
                            <td>${product.description}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/Product?action=edit&id=${product.productId}">Edit</a>
                                <a href="${pageContext.request.contextPath}/Product?action=delete&id=${product.productId}" 
                                   onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div class="button-group">
                <a href="${pageContext.request.contextPath}/Product?action=add" class="btn add-btn">Add New Product</a>
                <a href="${pageContext.request.contextPath}/adminPage" class="btn back-btn">Back</a>
            </div>
        </div>
    </div>
</body>
</html>