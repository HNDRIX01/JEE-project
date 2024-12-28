<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="navbar.jsp" %>
<%@ page import="java.util.List" %>
<%
    List<String[]> orderDetails = (List<String[]>) request.getAttribute("orderDetails");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
        }
        .order-header {
            background: linear-gradient(45deg, #ff7e5f, #feb47b);
            color: white;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .order-date {
            font-size: 24px;
            color: white;
            font-weight: bold;
        }
        .table {
            background-color: white;
        }
        .table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .table td {
            color: #333; /* Ensure text is readable against the white background */
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="order-header">
            <h3>Order #<%= orderDetails.get(0)[0] %> Details</h3>
            <p class="order-date">Order Date: <%= orderDetails.get(0)[1] %></p>
        </div>

        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (orderDetails != null && !orderDetails.isEmpty()) {
                        for (String[] detail : orderDetails) {
                            out.println("<tr>");
                            out.println("<td>" + detail[3] + "</td>");
                            out.println("<td>" + detail[4] + " DT</td>");
                            out.println("<td>" + detail[5] + "</td>");
                            out.println("<td>" + detail[6] + " DT</td>");
                            out.println("</tr>");
                        }
                    } else {
                        out.println("<tr><td colspan='4'>No details found for this order.</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
