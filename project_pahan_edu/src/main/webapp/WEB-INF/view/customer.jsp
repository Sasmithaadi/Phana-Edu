<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${customer != null ? "Edit Customer" : "Add Customer"}</title>
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
    display: flex;
    align-items: center;
    justify-content: center;
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
    max-width: 600px;
    width: 100%;
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
    font-size: 2.5rem;
    font-weight: 900;
    background: linear-gradient(135deg, #00d4ff, #7c3aed, #f59e0b);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 3rem;
    text-align: center;
    text-transform: uppercase;
    letter-spacing: 2px;
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

.form-group {
    margin-bottom: 2rem;
    position: relative;
}

label {
    display: block;
    font-family: 'Orbitron', monospace;
    font-weight: 700;
    color: #00d4ff;
    font-size: 0.95rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 0.8rem;
    position: relative;
}

label::after {
    content: '';
    position: absolute;
    bottom: -3px;
    left: 0;
    width: 30px;
    height: 2px;
    background: linear-gradient(90deg, #00d4ff, #7c3aed);
    border-radius: 1px;
}

input[type="text"],
input[type="number"] {
    width: 100%;
    padding: 1.2rem 1.5rem;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 15px;
    color: #e0e6ed;
    font-size: 1.1rem;
    font-family: 'Exo 2', sans-serif;
    font-weight: 500;
    backdrop-filter: blur(10px);
    transition: all 0.3s ease;
    position: relative;
}

input[type="text"]:focus,
input[type="number"]:focus {
    outline: none;
    border-color: rgba(0, 212, 255, 0.6);
    background: rgba(255, 255, 255, 0.08);
    box-shadow: 
        0 0 20px rgba(0, 212, 255, 0.2),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
    transform: translateY(-2px);
}

input[type="text"]:hover,
input[type="number"]:hover {
    border-color: rgba(255, 255, 255, 0.2);
    background: rgba(255, 255, 255, 0.07);
}

input[readonly] {
    background: rgba(255, 255, 255, 0.02);
    border-color: rgba(255, 255, 255, 0.05);
    color: rgba(224, 230, 237, 0.6);
    cursor: not-allowed;
}

input[readonly]:hover {
    background: rgba(255, 255, 255, 0.02);
    border-color: rgba(255, 255, 255, 0.05);
    transform: none;
}

input::placeholder {
    color: rgba(224, 230, 237, 0.4);
    font-style: italic;
}

.btn {
    display: inline-block;
    padding: 1.2rem 3rem;
    color: #e0e6ed;
    text-decoration: none;
    border: none;
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
    cursor: pointer;
    border: 2px solid transparent;
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

.submit-btn {
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.1), rgba(22, 163, 74, 0.1));
    border-color: rgba(34, 197, 94, 0.4);
    color: #22c55e;
}

.submit-btn:hover {
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
    border-color: rgba(0, 212, 255, 0.3);
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
    margin-top: 3rem;
    position: relative;
    z-index: 2;
}

/* Decorative elements */
.customer-icon {
    position: absolute;
    font-size: 4rem;
    opacity: 0.08;
    color: #00d4ff;
    animation: float 8s ease-in-out infinite;
    z-index: 0;
}

.customer-icon:nth-child(1) {
    top: 10%;
    left: 5%;
    animation-delay: 0s;
}

.customer-icon:nth-child(2) {
    top: 20%;
    right: 8%;
    animation-delay: 3s;
}

.customer-icon:nth-child(3) {
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

/* Form validation styles */
input:invalid {
    border-color: rgba(239, 68, 68, 0.4);
}

input:invalid:focus {
    border-color: rgba(239, 68, 68, 0.6);
    box-shadow: 
        0 0 20px rgba(239, 68, 68, 0.2),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
}

/* Responsive design */
@media (max-width: 768px) {
    body {
        padding: 1rem;
    }
    
    .main-card {
        padding: 2rem;
    }
    
    h1 {
        font-size: 2rem;
        letter-spacing: 1px;
    }
    
    .btn {
        padding: 1rem 2rem;
        font-size: 1rem;
        margin: 0.3rem;
        width: 100%;
        max-width: 200px;
    }
    
    input[type="text"],
    input[type="number"] {
        padding: 1rem 1.2rem;
        font-size: 1rem;
    }
}

@media (max-width: 480px) {
    .container {
        max-width: 100%;
    }
    
    .button-group {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1rem;
    }
    
    .btn {
        width: 100%;
        max-width: none;
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
    <!-- Decorative customer icons -->
    <div class="customer-icon">&#128100;</div>
    <div class="customer-icon">&#128101;</div>
    <div class="customer-icon">&#128102;</div>

    <div class="container">
        <div class="main-card">
            <h1>${customer != null ? "Edit Customer" : "Add Customer"}</h1>
            
            <form action="${pageContext.request.contextPath}/customer" method="post">
                <input type="hidden" name="action" value="${customer != null ? 'update' : 'add'}"/>

                <div class="form-group">
                    <label for="accountNumber">Account Number:</label>
                    <input type="number" 
                           id="accountNumber"
                           name="accountNumber" 
                           value="${customer != null ? customer.accountNumber : ''}" 
                           ${customer != null ? 'readonly' : ''} 
                           required
                           placeholder="Enter account number"/>
                </div>

                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" 
                           id="name"
                           name="name" 
                           value="${customer != null ? customer.name : ''}" 
                           required
                           placeholder="Enter customer name"/>
                </div>

                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" 
                           id="address"
                           name="address" 
                           value="${customer != null ? customer.address : ''}" 
                           required
                           placeholder="Enter customer address"/>
                </div>

                <div class="form-group">
                    <label for="telephone">Telephone:</label>
                    <input type="text" 
                           id="telephone"
                           name="telephone" 
                           value="${customer != null ? customer.telephone : ''}" 
                           required
                           placeholder="Enter telephone number"/>
                </div>

                <div class="button-group">
                    <input type="submit" 
                           value="${customer != null ? 'Update' : 'Add'}" 
                           class="btn submit-btn"/>
                    <button type="button" 
                            onclick="window.location='${pageContext.request.contextPath}/adminPage'" 
                            class="btn back-btn">Back</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>