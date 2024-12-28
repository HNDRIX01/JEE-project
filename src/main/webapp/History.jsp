<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="navbar.jsp" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="product.DatabaseConnection" %>

<%
    Integer userId = (Integer) session.getAttribute("user_id");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<String[]> orders = new ArrayList<>();
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM commandes WHERE utilisateur_id = ? ORDER BY date ASC")) {
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            int orderId = rs.getInt("id");
            String date = rs.getString("date");
            String status = rs.getString("statut");
            orders.add(new String[]{String.valueOf(orderId), date, status});
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Order History</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
        }
        .modal-content {
            max-width: 800px;
            margin: auto;
        }
        table th {
            background: linear-gradient(90deg, #4caf50, #81c784);
            color: white;
        }
        h2{
        color: white;
        
        }
        .container h2 {
            margin-bottom: 20px;
        }
        .table th, .table td {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2>Order History</h2>
        <table class="table table-bordered" style="background-color: white;">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int counter = 1;
                    if (!orders.isEmpty()) {
                        for (String[] order : orders) {
                            out.println("<tr>");
                            out.println("<td>" + counter++ + "</td>");
                            out.println("<td>" + order[1] + "</td>");
                            out.println("<td>" + order[2] + "</td>");
                            out.println("<td><a href='OrderDetailsServlet?id=" + order[0] + "' class='btn btn-info btn-sm'>View Details</a></td>");
                            out.println("</tr>");
                        }
                    } else {
                        out.println("<tr><td colspan='4'>No orders found.</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
