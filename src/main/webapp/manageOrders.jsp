<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ include file="AdminNavbar.jsp" %>

<%
    List<String[]> orders = (List<String[]>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Orders</title>
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

        h3 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }

        table {
            color: black;
        }

        .form-inline {
            display: flex;
            gap: 10px;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-weight: bold;
            border-radius: 0.5rem;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <!-- Admin Navbar Included -->

    <div class="container">
        <h3>Manage Orders</h3>
        <table class="table table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (orders != null && !orders.isEmpty()) {
                        for (String[] order : orders) {
                %>
                <tr>
                    <td><%= order[0] %></td>
                    <td><%= order[1] %></td>
                    <td><%= order[2] %></td>
                    <td><%= order[3] %></td>
                    <td>
                        <form action="ManageOrdersServlet" method="POST" class="form-inline">
                            <input type="hidden" name="orderId" value="<%= order[0] %>">
                            <select name="status" class="form-control">
                                <option value="en cours" <%= "en cours".equals(order[3]) ? "selected" : "" %>>In Progress</option>
                                <option value="livrée" <%= "livrée".equals(order[3]) ? "selected" : "" %>>Delivered</option>
                                <option value="annulée" <%= "annulée".equals(order[3]) ? "selected" : "" %>>Canceled</option>
                            </select>
                            <button type="submit" class="btn btn-primary btn-sm">Update</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">No orders found.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
