<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="product.DatabaseConnection" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="AdminNavbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Product</title>
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
            max-width: 700px;
            background-color: rgba(255, 255, 255, 0.1);
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

        .form-group label {
            font-weight: bold;
        }

        .form-control {
            border-radius: 0.5rem;
            border: 1px solid #ccc;
        }

        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
            border-radius: 0.5rem;
            padding: 0.5rem 1.5rem;
            font-weight: bold;
            margin-top: 1rem;
        }

        .btn-success:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <!-- Admin Navbar Included -->

    <%
        int id = Integer.parseInt(request.getParameter("id"));
        String name = "", description = "", image = "";
        BigDecimal price = null;
        int stock = 0;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM produits WHERE id = ?")) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("nom");
                description = rs.getString("description");
                price = rs.getBigDecimal("prix");
                stock = rs.getInt("stock");
                image = rs.getString("image");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <div class="container">
        <h2>Edit Product</h2>
        <form action="UpdateProductServlet" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <div class="form-group">
                <label for="productName">Name:</label>
                <input type="text" class="form-control" id="productName" name="productName" value="<%= name %>" required>
            </div>
            <div class="form-group">
                <label for="productDescription">Description:</label>
                <textarea class="form-control" id="productDescription" name="productDescription" rows="3" required><%= description %></textarea>
            </div>
            <div class="form-group">
                <label for="productPrice">Price:</label>
                <input type="number" class="form-control" id="productPrice" name="productPrice" step="0.01" value="<%= price %>" required>
            </div>
            <div class="form-group">
                <label for="productStock">Stock:</label>
                <input type="number" class="form-control" id="productStock" name="productStock" value="<%= stock %>" required>
            </div>
            <button type="submit" class="btn btn-success btn-block">Update</button>
        </form>
    </div>
</body>
</html>
