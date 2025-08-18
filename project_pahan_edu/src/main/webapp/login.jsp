<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
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
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
    position: relative;
    overflow-x: hidden;
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

.login-container {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(20px);
    padding: 40px;
    border-radius: 20px;
    box-shadow: 
        0 8px 32px rgba(0, 0, 0, 0.3),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
    width: 100%;
    max-width: 400px;
    position: relative;
    z-index: 2;
    overflow: hidden;
    animation: float 6s ease-in-out infinite;
}

.login-container::before {
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

@keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
}

h2 {
    color: #e0e6ed;
    text-align: center;
    margin-bottom: 15px;
    font-family: 'Orbitron', monospace;
    font-size: 28px;
    font-weight: 700;
    background: linear-gradient(135deg, #00d4ff, #7c3aed, #f59e0b);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    text-transform: uppercase;
    letter-spacing: 2px;
    position: relative;
}

h2::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 50px;
    height: 3px;
    background: linear-gradient(90deg, transparent, #00d4ff, #7c3aed, #f59e0b, transparent);
    border-radius: 2px;
    animation: glow 2s ease-in-out infinite alternate;
}

@keyframes glow {
    from { opacity: 0.5; box-shadow: 0 0 10px rgba(0, 212, 255, 0.3); }
    to { opacity: 1; box-shadow: 0 0 20px rgba(0, 212, 255, 0.6); }
}

form {
    display: flex;
    flex-direction: column;
}

.input-group {
    margin-bottom: 25px;
    position: relative;
}

label {
    display: block;
    margin-bottom: 8px;
    color: #e0e6ed;
    font-weight: 500;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 1px;
    opacity: 0.9;
}

input[type="email"],
input[type="password"] {
    width: 100%;
    padding: 15px 20px;
    border: 2px solid rgba(255, 255, 255, 0.1);
    border-radius: 10px;
    font-size: 16px;
    transition: all 0.3s ease;
    background: rgba(255, 255, 255, 0.1);
    color: #e0e6ed;
    backdrop-filter: blur(10px);
}

input[type="email"]::placeholder,
input[type="password"]::placeholder {
    color: rgba(224, 230, 237, 0.5);
}

input[type="email"]:focus,
input[type="password"]:focus {
    outline: none;
    border-color: #00d4ff;
    box-shadow: 0 0 0 3px rgba(0, 212, 255, 0.2);
    background: rgba(255, 255, 255, 0.15);
    transform: translateY(-2px);
}

input[type="submit"] {
    background: linear-gradient(135deg, #00d4ff, #7c3aed);
    color: white;
    padding: 15px 30px;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-top: 10px;
    position: relative;
    overflow: hidden;
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

.user-manual-btn {
    display: inline-block;
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.1), rgba(16, 185, 129, 0.1));
    border: 2px solid rgba(34, 197, 94, 0.3);
    color: #e0e6ed;
    padding: 12px 20px;
    border-radius: 50px;
    text-decoration: none;
    font-weight: 500;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: all 0.3s ease;
    text-align: center;
    margin-top: 15px;
    position: relative;
    overflow: hidden;
}

.user-manual-btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
    transition: left 0.5s ease;
}

.user-manual-btn:hover::before {
    left: 100%;
}

.user-manual-btn:hover {
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.2), rgba(16, 185, 129, 0.2));
    border-color: rgba(34, 197, 94, 0.5);
    transform: translateY(-2px);
    box-shadow: 
        0 8px 20px rgba(34, 197, 94, 0.2),
        0 0 15px rgba(16, 185, 129, 0.1);
}

.error-message {
    background: linear-gradient(45deg, rgba(239, 68, 68, 0.9), rgba(220, 38, 127, 0.9));
    color: white;
    padding: 15px 20px;
    border-radius: 10px;
    margin-top: 20px;
    text-align: center;
    font-weight: 500;
    box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
    animation: shake 0.5s ease-in-out;
    border: 1px solid rgba(239, 68, 68, 0.3);
}

@keyframes shake {
    0%, 100% { transform: translateX(0); }
    25% { transform: translateX(-5px); }
    75% { transform: translateX(5px); }
}

.welcome-text {
    text-align: center;
    color: rgba(224, 230, 237, 0.7);
    font-size: 14px;
    margin-bottom: 20px;
    font-style: italic;
}

/* Decorative elements */
.book-icon {
    position: absolute;
    font-size: 3rem;
    opacity: 0.1;
    color: #00d4ff;
    animation: floatBooks 8s ease-in-out infinite;
}

.book-icon:nth-child(1) {
    top: 15%;
    left: 10%;
    animation-delay: 0s;
}

.book-icon:nth-child(2) {
    top: 20%;
    right: 15%;
    animation-delay: 3s;
}

.book-icon:nth-child(3) {
    bottom: 20%;
    left: 12%;
    animation-delay: 6s;
}

@keyframes floatBooks {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    33% { transform: translateY(-15px) rotate(3deg); }
    66% { transform: translateY(8px) rotate(-3deg); }
}

/* Responsive design */
@media (max-width: 480px) {
    .login-container {
        padding: 30px 20px;
        margin: 10px;
    }
    
    h2 {
        font-size: 24px;
    }
    
    input[type="email"],
    input[type="password"] {
        padding: 12px 15px;
    }
    
    input[type="submit"] {
        padding: 12px 25px;
    }
    
    .user-manual-btn {
        padding: 10px 18px;
        font-size: 13px;
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

.login-container {
    animation: fadeInUp 0.8s ease-out, float 6s ease-in-out infinite 0.8s;
}
</style>
</head>
<body>
    <!-- Decorative book icons -->
    <div class="book-icon">&#128218;</div>
    <div class="book-icon">&#128214;</div>
    <div class="book-icon">&#128213;</div>

<div class="login-container">
<h2>Login</h2>
<p class="welcome-text">Welcome back! Please sign in to your account.</p>
<form action="${pageContext.request.contextPath}/login" method="post">
<div class="input-group">
<label for="email">Email:</label>
<input type="email" id="email" name="email" required />
</div>
<div class="input-group">
<label for="password">Password:</label>
<input type="password" id="password" name="password" required />
</div>

<!-- User Manual Button -->
<a href="#" class="user-manual-btn" onclick="alert('User Manual: Admin - Full access to all features. Staff - Limited access to products and customers. Use your assigned credentials to login.')">
    &#128214; User Manual
</a>

<input type="submit" value="Login" />
</form>

<c:if test="${not empty errorMessage}">
<div class="error-message">${errorMessage}</div>
</c:if>
</div>
</body>
</html>