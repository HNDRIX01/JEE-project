<%@ include file="navbar.jsp" %>
<%@ page import="java.util.Map" %>
<%@ page import="product.Product" %>
<%@ page import="product.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="product.DatabaseConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="product.Cart" %>

<div class="container mt-5">
    <div class="row">
        <div class="col">
            <%
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null || cart.getProducts().isEmpty()) {
            %>
                <div class="text-center">
                    <h3>Your cart is empty.</h3>
                </div>
            <%
                } else {
                    Map<Integer, Integer> cartItems = cart.getProducts();
            %>
            <h2 class="mb-4">Your Cart</h2>
            <div class="table-responsive">
                <table class="table table-bordered" style="background-color: white;">
                    <thead style="background: linear-gradient(90deg, #4caf50, #81c784); color: white; font-family: 'Montserrat', sans-serif;">
                        <tr>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            double grandTotal = 0.0;
                            for (Map.Entry<Integer, Integer> entry : cartItems.entrySet()) {
                                int productId = entry.getKey();
                                int quantity = entry.getValue();

                                String query = "SELECT * FROM produits WHERE id = ?";
                                try (Connection conn = DatabaseConnection.getConnection();
                                     PreparedStatement stmt = conn.prepareStatement(query)) {
                                    stmt.setInt(1, productId);
                                    ResultSet rs = stmt.executeQuery();
                                    if (rs.next()) {
                                        double price = rs.getDouble("prix");
                                        double total = price * quantity;
                                        grandTotal += total;
                        %>
                        <tr>
                            <td><%= rs.getString("nom") %></td>
                            <td>
                                <form action="update-cart" method="post" style="display:inline;">
                                    <input type="number" name="quantity" value="<%= quantity %>" min="1" class="form-control d-inline-block" style="width:80px;">
                                    <input type="hidden" name="product_id" value="<%= productId %>">
                                    <button type="submit" class="btn btn-secondary btn-sm">Update</button>
                                </form>
                            </td>
                            <td><%= price %> DT</td>
                            <td><%= total %> DT</td>
                            <td>
                                <a href="remove-from-cart?product_id=<%= productId %>" class="btn btn-danger btn-sm">Remove</a>
                            </td>
                        </tr>
                        <%
                                    }
                                }
                            }
                        %>
                        <tr class="font-weight-bold">
                            <td colspan="3" class="text-right">Grand Total</td>
                            <td><%= grandTotal %> DT</td>
                            <td>
                                <form action="validate-cart" method="post">
                                    <button type="submit" class="btn btn-success">Validate Order</button>
                                </form>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>
