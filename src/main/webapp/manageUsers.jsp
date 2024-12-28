<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="product.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="AdminNavbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Users</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #123456, #123456);
            margin: 0;
            padding: 0;
        }

        .container {
            margin-top: 2rem;
            background-color: #9db5c9;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            color: black;
        }

        h2 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }

        .table th, .table td {
            color: black;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-weight: bold;
            border-radius: 0.5rem;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: black;
        }

        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
    <!-- Admin Navbar Included -->

    <div class="container">
        <h2>Manage Users</h2>
        <table class="table table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection conn = DatabaseConnection.getConnection();
                         Statement stmt = conn.createStatement()) {

                        String sql = "SELECT * FROM utilisateurs WHERE role != 'administrateur' ";
                        ResultSet rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("nom");
                            String email = rs.getString("email");
                            String role = rs.getString("role");
                            String status = rs.getString("status");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= email %></td>
                    <td><%= role %></td>
                    <td><%= status.equals("active") ? "Active" : "Blocked" %></td>
                    <td>
                        <div class="action-buttons">
                            <a href="DeleteUserServlet?id=<%= id %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
                            <% if (status.equals("active")) { %>
                                <a href="BlockUserServlet?id=<%= id %>" class="btn btn-warning btn-sm">Block</a>
                            <% } else { %>
                                <a href="ActivateUserServlet?id=<%= id %>" class="btn btn-success btn-sm">Activate</a>
                            <% } %>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
