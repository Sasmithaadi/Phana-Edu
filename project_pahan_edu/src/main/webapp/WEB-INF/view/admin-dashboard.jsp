<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.pahanaedu.model.User" %>
<%
User currentUser = (User) session.getAttribute("currentUser");
if(currentUser == null || !currentUser.getRole().equalsIgnoreCase("admin")) {
response.sendRedirect(request.getContextPath() + "/login");
return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
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
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.dashboard-card {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 20px;
    padding: 3rem;
    backdrop-filter: blur(20px);
    box-shadow: 
        0 8px 32px rgba(0, 0, 0, 0.3),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
    text-align: center;
    max-width: 600px;
    width: 100%;
    position: relative;
    overflow: hidden;
}

.dashboard-card::before {
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
    font-size: 2.5rem;
    font-weight: 900;
    background: linear-gradient(135deg, #00d4ff, #7c3aed, #f59e0b);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 2rem;
    text-transform: uppercase;
    letter-spacing: 2px;
    position: relative;
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

.user-info {
    font-size: 1.2rem;
    margin-bottom: 3rem;
    opacity: 0.9;
}

.nav-links {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
    align-items: center;
}

.nav-link {
    display: inline-block;
    padding: 1rem 2.5rem;
    background: linear-gradient(135deg, rgba(0, 212, 255, 0.1), rgba(124, 58, 237, 0.1));
    border: 2px solid transparent;
    border-radius: 50px;
    color: #e0e6ed;
    text-decoration: none;
    font-weight: 600;
    font-size: 1.1rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
    min-width: 200px;
}

.nav-link::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
    transition: left 0.5s ease;
}

.nav-link:hover::before {
    left: 100%;
}

.nav-link:hover {
    background: linear-gradient(135deg, rgba(0, 212, 255, 0.2), rgba(124, 58, 237, 0.2));
    border-color: rgba(0, 212, 255, 0.5);
    transform: translateY(-2px);
    box-shadow: 
        0 10px 25px rgba(0, 212, 255, 0.2),
        0 0 20px rgba(124, 58, 237, 0.1);
}

.admin-link {
    background: linear-gradient(135deg, rgba(245, 158, 11, 0.1), rgba(239, 68, 68, 0.1));
}

.admin-link:hover {
    background: linear-gradient(135deg, rgba(245, 158, 11, 0.2), rgba(239, 68, 68, 0.2));
    border-color: rgba(245, 158, 11, 0.5);
    box-shadow: 
        0 10px 25px rgba(245, 158, 11, 0.2),
        0 0 20px rgba(239, 68, 68, 0.1);
}

.logout-link {
    background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(220, 38, 127, 0.1));
}

.logout-link:hover {
    background: linear-gradient(135deg, rgba(239, 68, 68, 0.2), rgba(220, 38, 127, 0.2));
    border-color: rgba(239, 68, 68, 0.5);
    box-shadow: 
        0 10px 25px rgba(239, 68, 68, 0.2),
        0 0 20px rgba(220, 38, 127, 0.1);
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
    left: 10%;
    animation-delay: 0s;
}

.book-icon:nth-child(2) {
    top: 20%;
    right: 15%;
    animation-delay: 2s;
}

.book-icon:nth-child(3) {
    bottom: 15%;
    left: 15%;
    animation-delay: 4s;
}

@keyframes float {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    33% { transform: translateY(-20px) rotate(5deg); }
    66% { transform: translateY(10px) rotate(-5deg); }
}

/* Responsive design */
@media (max-width: 768px) {
    .container {
        padding: 1rem;
    }
    
    .dashboard-card {
        padding: 2rem;
    }
    
    h1 {
        font-size: 2rem;
    }
    
    .nav-link {
        padding: 0.8rem 2rem;
        font-size: 1rem;
        min-width: 180px;
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

.dashboard-card {
    animation: fadeInUp 0.8s ease-out;
}

.nav-links > * {
    animation: fadeInUp 0.8s ease-out forwards;
    opacity: 0;
}

.nav-links > *:nth-child(1) { animation-delay: 0.2s; }
.nav-links > *:nth-child(2) { animation-delay: 0.4s; }
</style>
</head>
<body>
    <!-- Decorative book icons -->
    <div class="book-icon">📚</div>
    <div class="book-icon">📖</div>
    <div class="book-icon">📕</div>

    <div class="container">
        <div class="dashboard-card">
            <h1>Admin Command Center</h1>
            <div class="user-info">
                Welcome, <%= currentUser.getName() %>
            </div>
            
            <div class="nav-links">
                <!-- Link back to index.jsp -->
                <<a href="<%= request.getContextPath() %>/adminPage" class="nav-link admin-link">
                 📊 Go to Admin Page
                 </a>


                
                <!-- Logout link -->
                <a href="<%= request.getContextPath() %>/logout.jsp" class="nav-link logout-link">
                    🚪 Logout
                </a>
            </div>
        </div>
    </div>
</body>
</html>