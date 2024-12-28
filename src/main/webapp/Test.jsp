<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="product.Product" %>
<%@ page import="product.DatabaseConnection" %>

<%
    // Fetch product data from the database
    List<Product> productList = new ArrayList<>();
    try (Connection connection = DatabaseConnection.getConnection();
         PreparedStatement statement = connection.prepareStatement("SELECT * FROM public.produits");
         ResultSet resultSet = statement.executeQuery()) {
        
        while (resultSet.next()) {
            productList.add(new Product(
                resultSet.getInt("id"),
                resultSet.getString("nom"),
                resultSet.getString("description"),
                resultSet.getDouble("prix"),
                resultSet.getString("image")
            ));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
            margin: 0;
            padding: 0;
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

        .card {
            border: none;
            background-color: rgba(255, 255, 255, 0.1); /* Transparent to maintain gradient */
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            transition: transform 0.2s ease-in-out;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card-img-top {
            height: 250px;
            object-fit: cover;
            border-radius: 8px 8px 0 0;
        }

        .card-body {
            color: white;
        }

        .container {
            margin-top: 30px;
        }

        .no-products {
            text-align: center;
            color: #ff4d4d;
            font-size: 1.2rem;
        }

        h2 {
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }
    </style>
</head>
<body>
    <!-- Navbar -->
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

    <!-- Main Content -->
    <div class="container mt-4">
        <h2>Featured Products</h2>
        <div class="row">
            <% if (productList != null && !productList.isEmpty()) { %>
                <% for (Product product : productList) { %>
                    <div class="col-md-4 col-lg-3 mb-4">
                        <div class="card">
                            <img class="card-img-top" src="<%= product.getImageUrl() != null && !product.getImageUrl().isEmpty() ? request.getContextPath() + "/uploads/" + product.getImageUrl() : request.getContextPath() + "/images/placeholder.png" %>" alt="<%= product.getName() %>">
                            <div class="card-body">
                                <h5 class="card-title"><%= product.getName() %></h5>
                                <p class="card-text"><strong><%= product.getPrice() %> DT</strong></p>
                                <% if (session.getAttribute("nom") == null) { %>
                                    <button class="btn btn-primary btn-block" onclick="alert('You must log in to add items to your cart.')">Add to Cart</button>
                                <% } else { %>
                                    <a href="AddToCartServlet?product_id=<%= product.getId() %>" class="btn btn-primary btn-block">Add to Cart</a>
                                <% } %>
                            </div>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="col-12">
                    <p class="no-products">No products available.</p>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
