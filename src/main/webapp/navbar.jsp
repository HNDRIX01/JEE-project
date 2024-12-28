<!DOCTYPE html>
<html lang="en">
<head>
    <title>Menu</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #123456, #123456); /* Consistent solid color gradient */
            color: #fff;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background: rgba(0, 0, 0, 0.7); /* Semi-transparent dark background */
            padding: 15px 30px;
            margin-top: 1rem; /* To provide spacing like mt-3 */
        }

        .navbar-brand, .nav-link {
            font-weight: 600;
            font-size: 18px;
            color: #fff !important;
        }

        .navbar-nav .nav-item .nav-link {
            padding: 8px 20px;
        }

        .navbar-nav .nav-item .nav-link:hover {
            background-color: rgba(0, 0, 0, 0.2);
            border-radius: 5px;
            color: #123456 !important; /* Subtle hover effect to match theme */
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="userDashboard.jsp">E-Shopify</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="userDashboard.jsp">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cart.jsp">Cart</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="History.jsp">History</a>
                </li>
                <% if (session.getAttribute("nom") == null) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">Logout</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </nav>
</body>
</html>
