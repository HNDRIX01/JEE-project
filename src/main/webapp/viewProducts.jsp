<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="product.DatabaseConnection" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="AdminNavbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Products</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #123456, #123456); /* Consistent solid gradient */
            color: white;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-top: 2rem;
            background-color: #9db5c9;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
            text-align: center;
        }

        table {
            color: white;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .table img {
            width: 100px; /* Larger image display */
            height: auto;
            border-radius: 5px;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-weight: bold;
            border-radius: 0.5rem;
        }

        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: black;
        }

        .btn-warning:hover {
            background-color: #e0a800;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .action-buttons {
            display: flex;
            gap: 10px; /* Add spacing between buttons */
        }
    </style>
</head>
<body>
    <!-- Admin Navbar Included -->

    <div class="container">
        <h2>Manage Products</h2>
        <table class="table table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection conn = DatabaseConnection.getConnection();
                         Statement stmt = conn.createStatement()) {

                        String sql = "SELECT * FROM produits";
                        ResultSet rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("nom");
                            String description = rs.getString("description");
                            BigDecimal price = rs.getBigDecimal("prix");
                            int stock = rs.getInt("stock");
                            String image = rs.getString("image");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= description %></td>
                    <td><%= price %></td>
                    <td><%= stock %></td>
                    <td>
                        <% if (image != null && !image.isEmpty()) { %>
                            <img src="uploads/<%= image %>" alt="<%= name %>">
                        <% } else { %>
                            <span>No Image</span>
                        <% } %>
                    </td>
                    <td>
                        <div class="action-buttons">
                            <a href="editProduct.jsp?id=<%= id %>" class="btn btn-warning btn-sm">Edit</a>
                            <a href="DeleteProductServlet?id=<%= id %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
