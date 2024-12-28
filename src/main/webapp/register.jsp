<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="product.DatabaseConnection" %>

<%
    // Initialize a message variable to display feedback to the user
    String registrationMessage = "";

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (name != null && !name.isEmpty() && email != null && !email.isEmpty() &&
            password != null && !password.isEmpty() && confirmPassword != null && !confirmPassword.isEmpty()) {
            if (!password.equals(confirmPassword)) {
                registrationMessage = "Passwords do not match. Please try again.";
            } else {
                String insertUserSQL = "INSERT INTO utilisateurs (nom, email, mot_de_passe, role) VALUES (?, ?, ?, 'utilisateur')";

                try (Connection conn = DatabaseConnection.getConnection();
                     PreparedStatement stmt = conn.prepareStatement(insertUserSQL)) {
                    stmt.setString(1, name);
                    stmt.setString(2, email);
                    stmt.setString(3, password);

                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        registrationMessage = "Registration successful! You can now log in.";
                    } else {
                        registrationMessage = "Registration failed. Please try again.";
                    }
                } catch (SQLException e) {
                    registrationMessage = "An error occurred: " + e.getMessage();
                    e.printStackTrace();
                }
            }
        } else {
            registrationMessage = "All fields are required.";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg,#123456, #123456);
            margin: 0;
            padding: 0;
            color: white;
        }

        .navbar {
            background: rgba(0, 0, 0, 0.7);
            padding: 15px 30px;
            margin-top: 1rem;
        }

        .navbar-brand, .nav-link {
            font-weight: 600;
            font-size: 18px;
        }

        .navbar-nav .nav-item .nav-link:hover {
            background-color: rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }

        .register-container {
            margin-top: 5%;
            display: flex;
            justify-content: center;
        }

        .register-card {
            width: 100%;
            max-width: 500px;
            padding: 2rem;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            color: white;
        }

        .form-control {
            border-radius: 0.5rem;
            border: 1px solid #ccc;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 0.5rem;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        h2 {
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .alert {
            background-color: rgba(0, 255, 0, 0.2);
            color: white;
            border-radius: 0.5rem;
            text-align: center;
        }
    </style>
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            if (password !== confirmPassword) {
                alert("Passwords do not match. Please try again.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="index.jsp">E-Shopify</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Register</a>
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

    <div class="container register-container">
        <div class="card register-card">
            <h2>Register</h2>
            <% if (!registrationMessage.isEmpty()) { %>
                <div class="alert"><%= registrationMessage %></div>
            <% } %>
            <form method="POST" action="register.jsp" onsubmit="return validateForm()" class="mt-4">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Register</button>
            </form>
        </div>
    </div>

</body>
</html>
