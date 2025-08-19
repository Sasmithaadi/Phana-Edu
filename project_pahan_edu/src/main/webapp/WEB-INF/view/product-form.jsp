<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add / Edit Product</title>
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
    padding: 2rem 1rem;
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
    max-width: 800px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    min-height: 100vh;
    justify-content: center;
}

.form-card {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 20px;
    padding: 3rem;
    backdrop-filter: blur(20px);
    box-shadow: 
        0 8px 32px rgba(0, 0, 0, 0.3),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
    width: 100%;
    max-width: 600px;
    position: relative;
    overflow: hidden;
}

.form-card::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(45deg, transparent, rgba(0, 255, 255, 0.03), transparent);
    animation: shimmer 3s infinite;
    pointer-events: none;
}

@keyframes shimmer {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

h1 {
    font-family: 'Orbitron', monospace;
    font-size: 2.2rem;
    font-weight: 900;
    background: linear-gradient(135deg, #00d4ff, #7c3aed, #f59e0b);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 2.5rem;
    text-transform: uppercase;
    letter-spacing: 2px;
    position: relative;
    text-align: center;
}

h1::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 60%;
    height: 2px;
    background: linear-gradient(90deg, transparent, #00d4ff, #7c3aed, #f59e0b, transparent);
    animation: glow 2s ease-in-out infinite alternate;
}

@keyframes glow {
    from { opacity: 0.5; box-shadow: 0 0 10px rgba(0, 212, 255, 0.3); }
    to { opacity: 1; box-shadow: 0 0 20px rgba(0, 212, 255, 0.6); }
}

form {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.input-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

label {
    color: #e0e6ed;
    font-weight: 600;
    font-size: 1rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    opacity: 0.9;
    margin-bottom: 5px;
}

input[type="text"],
input[type="number"] {
    padding: 1rem 1.25rem;
    border: 2px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    font-size: 1rem;
    transition: all 0.3s ease;
    background: rgba(255, 255, 255, 0.1);
    color: #e0e6ed;
    backdrop-filter: blur(10px);
    font-family: 'Exo 2', sans-serif;
}

input[type="text"]::placeholder,
input[type="number"]::placeholder {
    color: rgba(224, 230, 237, 0.5);
}

input[type="text"]:focus,
input[type="number"]:focus {
    outline: none;
    border-color: #00d4ff;
    box-shadow: 0 0 0 3px rgba(0, 212, 255, 0.2);
    background: rgba(255, 255, 255, 0.15);
    transform: translateY(-2px);
}

input[type="hidden"] {
    display: none;
}

input[type="submit"] {
    background: linear-gradient(135deg, #00d4ff, #7c3aed);
    color: white;
    padding: 1rem 2rem;
    border: none;
    border-radius: 50px;
    font-size: 1.1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-top: 1rem;
    position: relative;
    overflow: hidden;
    font-family: 'Exo 2', sans-serif;
}

input[type="submit"]::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s ease;
}

input[type="submit"]:hover::before {
    left: 100%;
}

input[type="submit"]:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(0, 212, 255, 0.3);
    background: linear-gradient(135deg, #0ea5e9, #8b5cf6);
}

input[type="submit"]:active {
    transform: translateY(-1px);
}

.back-link {
    display: inline-block;
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.1), rgba(16, 185, 129, 0.1));
    border: 2px solid rgba(34, 197, 94, 0.3);
    color: #e0e6ed;
    padding: 1rem 2rem;
    border-radius: 50px;
    text-decoration: none;
    font-weight: 600;
    font-size: 1rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: all 0.3s ease;
    text-align: center;
    margin-top: 2rem;
    position: relative;
    overflow: hidden;
}

.back-link::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
    transition: left 0.5s ease;
}

.back-link:hover::before {
    left: 100%;
}

.back-link:hover {
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.2), rgba(16, 185, 129, 0.2));
    border-color: rgba(34, 197, 94, 0.5);
    transform: translateY(-2px);
    box-shadow: 
        0 8px 20px rgba(34, 197, 94, 0.2),
        0 0 15px rgba(16, 185, 129, 0.1);
}

/* Decorative elements */
.book-icon {
    position: absolute;
    font-size: 4rem;
    opacity: 0.1;
    color: #00d4ff;
    animation: float 6s ease-in-out infinite;
}

.book-icon:nth-child(1) {
    top: 10%;
    left: 5%;
    animation-delay: 0s;
}

.book-icon:nth-child(2) {
    top: 15%;
    right: 8%;
    animation-delay: 2s;
}

.book-icon:nth-child(3) {
    bottom: 15%;
    left: 8%;
    animation-delay: 4s;
}

.book-icon:nth-child(4) {
    bottom: 20%;
    right: 12%;
    animation-delay: 1s;
}

@keyframes float {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    33% { transform: translateY(-20px) rotate(5deg); }
    66% { transform: translateY(10px) rotate(-5deg); }
}

/* Responsive design */
@media (max-width: 768px) {
    body {
        padding: 1rem 0.5rem;
    }
    
    .form-card {
        padding: 2rem;
        margin: 1rem 0;
    }
    
    h1 {
        font-size: 1.8rem;
    }
    
    input[type="text"],
    input[type="number"] {
        padding: 0.8rem 1rem;
    }
    
    input[type="submit"],
    .back-link {
        padding: 0.8rem 1.5rem;
        font-size: 1rem;
    }
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

.form-card {
    animation: fadeInUp 0.8s ease-out;
}

.input-group {
    animation: fadeInUp 0.8s ease-out forwards;
    opacity: 0;
}

.input-group:nth-child(1) { animation-delay: 0.2s; }
.input-group:nth-child(2) { animation-delay: 0.3s; }
.input-group:nth-child(3) { animation-delay: 0.4s; }
.input-group:nth-child(4) { animation-delay: 0.5s; }

input[type="submit"] {
    animation: fadeInUp 0.8s ease-out forwards;
    opacity: 0;
    animation-delay: 0.6s;
}

.back-link {
    animation: fadeInUp 0.8s ease-out forwards;
    opacity: 0;
    animation-delay: 0.7s;
}
</style>
</head>
<body>
    <!-- Decorative book icons -->
    <div class="book-icon">&#128218;</div>
    <div class="book-icon">&#128214;</div>
    <div class="book-icon">&#128213;</div>
    <div class="book-icon">&#128216;</div>

    <div class="container">
        <div class="form-card">
            <h1>${param.id != null ? "Edit Product" : "Add Product"}</h1>
            <form action="Product?action=${param.id != null ? 'update' : 'insert'}" method="post">
                <c:if test="${param.id != null}">
                    <input type="hidden" name="id" value="${param.id}" />
                </c:if>
                
                <div class="input-group">
                    <label>Name:</label>
                    <input type="text" name="name" value="${product != null ? product.name : ''}" required>
                </div>
                
                <div class="input-group">
                    <label>Price:</label>
                    <input type="number" step="0.01" name="price" value="${product != null ? product.price : ''}" required>
                </div>
                
                <div class="input-group">
                    <label>Description:</label>
                    <input type="text" name="description" value="${product != null ? product.description : ''}">
                </div>
                
                <input type="submit" value="${param.id != null ? 'Update Product' : 'Add Product'}">
            </form>
            
            <a href="<%= request.getContextPath() %>/adminPage" class="back-link">
                &#8592; Back
            </a>
        </div>
    </div>
</body>
</html>