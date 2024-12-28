<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="AdminNavbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #123456, #123456); /* Consistent gradient */
            color: white;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-top: 2rem;
        }

        h2 {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 2rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
            text-align: center;
        }

        .btn-block {
            font-weight: 600;
            border-radius: 0.5rem;
            padding: 1rem;
            color: white;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-info {
            background-color: #17a2b8;
            border-color: #17a2b8;
        }

        .btn-info:hover {
            background-color: #0f6674;
        }

        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }

        .btn-success:hover {
            background-color: #1e7e34;
        }

        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: black;
        }

        .btn-warning:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>
    <!-- Navbar is included from adminnavbar.jsp -->

    <div class="container text-center">
        <h2>Welcome, Admin!</h2>
        <div class="row justify-content-center">
            <div class="col-md-4 mb-4">
                <a href="addProduct.jsp" class="btn btn-primary btn-block">Add Product</a>
            </div>
            <div class="col-md-4 mb-4">
                <a href="viewProducts.jsp" class="btn btn-info btn-block">Manage Products</a>
            </div>
            <div class="col-md-4 mb-4">
                <a href="manageUsers.jsp" class="btn btn-success btn-block">Manage Users</a>
            </div>
            <div class="col-md-4 mb-4">
                <a href="ManageOrdersServlet" class="btn btn-warning btn-block">Manage Orders</a>
            </div>
        </div>
    </div>
</body>
</html>
