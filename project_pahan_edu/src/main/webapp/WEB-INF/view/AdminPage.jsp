<!DOCTYPE html>
<html>
<head>
<title>Product & Customer Management</title>
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
    align-items: center;
    justify-content: center;
}

.management-card {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 20px;
    padding: 3rem;
    backdrop-filter: blur(20px);
    box-shadow: 
        0 8px 32px rgba(0, 0, 0, 0.3),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
    text-align: center;
    max-width: 800px;
    width: 100%;
    position: relative;
    overflow: hidden;
}

.management-card::before {
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
    margin-bottom: 3rem;
    text-transform: uppercase;
    letter-spacing: 2px;
    position: relative;
    line-height: 1.2;
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

h2 {
    font-family: 'Orbitron', monospace;
    font-size: 1.8rem;
    font-weight: 700;
    background: linear-gradient(135deg, #f59e0b, #ef4444);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin: 2rem 0 1.5rem 0;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.section {
    margin-bottom: 2.5rem;
}

.section-divider {
    width: 100%;
    height: 1px;
    background: linear-gradient(90deg, transparent, rgba(0, 212, 255, 0.3), transparent);
    margin: 2rem 0;
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
    min-width: 250px;
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

.product-link {
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.1), rgba(16, 185, 129, 0.1));
}

.product-link:hover {
    background: linear-gradient(135deg, rgba(34, 197, 94, 0.2), rgba(16, 185, 129, 0.2));
    border-color: rgba(34, 197, 94, 0.5);
    box-shadow: 
        0 10px 25px rgba(34, 197, 94, 0.2),
        0 0 20px rgba(16, 185, 129, 0.1);
}

.customer-link {
    background: linear-gradient(135deg, rgba(168, 85, 247, 0.1), rgba(147, 51, 234, 0.1));
}

.customer-link:hover {
    background: linear-gradient(135deg, rgba(168, 85, 247, 0.2), rgba(147, 51, 234, 0.2));
    border-color: rgba(168, 85, 247, 0.5);
    box-shadow: 
        0 10px 25px rgba(168, 85, 247, 0.2),
        0 0 20px rgba(147, 51, 234, 0.1);
}

.billing-link {
    background: linear-gradient(135deg, rgba(245, 158, 11, 0.1), rgba(239, 68, 68, 0.1));
}

.billing-link:hover {
    background: linear-gradient(135deg, rgba(245, 158, 11, 0.2), rgba(239, 68, 68, 0.2));
    border-color: rgba(245, 158, 11, 0.5);
    box-shadow: 
        0 10px 25px rgba(245, 158, 11, 0.2),
        0 0 20px rgba(239, 68, 68, 0.1);
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
    top: 5%;
    left: 5%;
    animation-delay: 0s;
}

.book-icon:nth-child(2) {
    top: 10%;
    right: 10%;
    animation-delay: 2s;
}

.book-icon:nth-child(3) {
    bottom: 10%;
    left: 8%;
    animation-delay: 4s;
}

.book-icon:nth-child(4) {
    bottom: 15%;
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
    .container {
        padding: 1rem;
    }
    
    .management-card {
        padding: 2rem;
    }
    
    h1 {
        font-size: 2rem;
    }
    
    h2 {
        font-size: 1.5rem;
    }
    
    .nav-link {
        padding: 0.8rem 2rem;
        font-size: 1rem;
        min-width: 220px;
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

.management-card {
    animation: fadeInUp 0.8s ease-out;
}

.nav-links > * {
    animation: fadeInUp 0.8s ease-out forwards;
    opacity: 0;
}

.nav-links > *:nth-child(1) { animation-delay: 0.2s; }
.nav-links > *:nth-child(2) { animation-delay: 0.3s; }
.nav-links > *:nth-child(3) { animation-delay: 0.4s; }
.nav-links > *:nth-child(4) { animation-delay: 0.5s; }
.nav-links > *:nth-child(5) { animation-delay: 0.6s; }
.nav-links > *:nth-child(6) { animation-delay: 0.7s; }

h2 {
    animation: fadeInUp 0.8s ease-out forwards;
    opacity: 0;
    animation-delay: 0.1s;
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
        <div class="management-card">
            <h1>Welcome to Pahana Edu Management System</h1>

            <div class="nav-links">
                <!-- Product Section -->
                <a href="${pageContext.request.contextPath}/Product?action=add" class="nav-link product-link">
                    &#10133; Add Product
                </a>
                
                <a href="${pageContext.request.contextPath}/Product?action=list" class="nav-link product-link">
                    &#128218; View Products
                </a>

                <div class="section-divider"></div>

                <!-- Customer Section -->
                <a href="${pageContext.request.contextPath}/customer?action=form" class="nav-link customer-link">
                    &#128100; Add Customer
                </a>
                
                <a href="${pageContext.request.contextPath}/customer?action=list" class="nav-link customer-link">
                    &#128203; View Customers
                </a>

                <h2>Billing Demo</h2>
                <a href="${pageContext.request.contextPath}/Bill?action=list" class="nav-link billing-link">
                    &#128179; Go to Bill List
                </a>
                
                <div class="section">
        <h3>Create a New Bill</h3>
        <!-- Include the bill form JSP here -->
        <jsp:include page="/WEB-INF/view/bill-form.jsp"/>
    </div>
                
            </div>
        </div>
    </div>
</body>
</html>