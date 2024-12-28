<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="product.Product" %>
<%@ page import="product.DatabaseConnection" %>

<%
    // Fetch categories
    List<String> categories = new ArrayList<>();
    String categorySql = "SELECT DISTINCT category FROM produits";
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(categorySql);
         ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
            categories.add(rs.getString("category"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Fetch products by selected category or all products
    List<Product> productList = new ArrayList<>();
    String selectedCategory = request.getParameter("category");
    String productSql = "SELECT id, nom, description, prix, image, stock, category FROM produits" + 
                        (selectedCategory != null && !selectedCategory.isEmpty() ? " WHERE category = ?" : "");
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(productSql)) {
        if (selectedCategory != null && !selectedCategory.isEmpty()) {
            stmt.setString(1, selectedCategory);
        }
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            productList.add(new Product(
                rs.getInt("id"),
                rs.getString("nom"),
                rs.getString("description"),
                rs.getDouble("prix"),
                rs.getString("image"),
                rs.getInt("stock"),
                rs.getString("category")
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
            background: linear-gradient(135deg, #123456, #123456);
            color: white;
        }

        .navbar {
            background: rgba(0, 0, 0, 0.7);
            padding: 15px 30px;
            margin-top: 1rem; /* Keeps the navbar away from the top of the page */
        }

        .navbar-brand, .nav-link {
            font-weight: 600;
            font-size: 18px;
        }

        .category-nav {
            display: flex;
            overflow-x: auto;
            background-color: rgba(0, 0, 0, 0.8);
            padding: 0.5rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }

        .category-nav a {
            color: white;
            padding: 0.5rem 1rem;
            margin: 0 0.5rem;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .category-nav a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .category-nav a.active {
            background-color: #9db5c9;
        }

        .container {
            margin-top: 2rem;
        }

        .card {
            border: none;
            background-color: rgba(255, 255, 255, 0.1);
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

        .product-price {
            font-size: 16px;
            font-weight: 600;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        h2 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 2rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }
    </style>
    <script>
        function notifyLogin() {
            alert("You must be logged in to add items to the cart.");
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="index.jsp">E-Shopify</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
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

    <!-- Category Navigation -->
    <div class="container">
        <div class="category-nav">
            <a href="index.jsp" class="<%= selectedCategory == null ? "active" : "" %>">All</a>
            <% for (String category : categories) { %>
                <a href="index.jsp?category=<%= category %>" class="<%= category.equals(selectedCategory) ? "active" : "" %>"><%= category %></a>
            <% } %>
        </div>
    </div>

    <!-- Products -->
    <div class="container">
        <h2>Featured Products</h2>
        <div class="row">
            <% if (productList != null && !productList.isEmpty()) {
                for (Product product : productList) { %>
                <div class="col-md-4 col-lg-3 mb-4">
                    <div class="card">
                        <img class="card-img-top" src="<%= (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) ? request.getContextPath() + "/uploads/" + product.getImageUrl() : request.getContextPath() + "/images/placeholder.png" %>" alt="<%= product.getName() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= product.getName() %></h5>
                            <p class="card-text product-price">
                                <% if (product.getStock() == 0) { %>
                                    <span style="color: red;"><%= product.getPrice() %> DT (Out of stock)</span>
                                <% } else { %>
                                    <span><%= product.getPrice() %> DT</span>
                                <% } %>
                            </p>
                            <% if (product.getStock() > 0) { %>
                                <% if (session.getAttribute("nom") == null) { %>
                                    <button class="btn btn-primary btn-block" onclick="notifyLogin()">Add to Cart</button>
                                <% } else { %>
                                    <a href="AddToCartServlet?product_id=<%= product.getId() %>" class="btn btn-primary btn-block">Add to Cart</a>
                                <% } %>
                            <% } else { %>
                                <button class="btn btn-secondary btn-block" disabled>Out of Stock</button>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% }
            } else { %>
                <div class="col-12">
                    <p class="text-center text-danger">No products available.</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
