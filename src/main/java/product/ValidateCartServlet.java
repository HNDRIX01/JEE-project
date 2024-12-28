package product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ValidateCartServlet
 */
@WebServlet("/validate-cart")
public class ValidateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidateCartServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        Integer userId = (Integer) session.getAttribute("user_id"); // Use Integer type

        System.out.println("User ID retrieved from session: " + userId);

        // Check if user_id is null
        if (userId == null) {
            response.sendRedirect("login.jsp?error=Please log in to place an order.");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Check if the user is blocked
            String statusQuery = "SELECT status FROM utilisateurs WHERE id = ?";
            PreparedStatement statusStmt = conn.prepareStatement(statusQuery);
            statusStmt.setInt(1, userId);
            ResultSet statusRs = statusStmt.executeQuery();

            if (statusRs.next()) {
                String status = statusRs.getString("status");
                if ("blocked".equals(status)) {
                    // If the user is blocked, prevent order placement
                    response.sendRedirect("blocked.jsp?error=Your account is blocked. You cannot place an order.");
                    return;
                }
            } else {
                // Handle case where user is not found (optional)
                response.sendRedirect("error.jsp");
                return;
            }

            // Proceed with order placement if the user is not blocked
            if (cart == null || cart.getProducts().isEmpty()) {
                response.sendRedirect("cart.jsp?error=Cart is empty.");
                return;
            }

            // Insert order
            String orderQuery = "INSERT INTO commandes (utilisateur_id, statut) VALUES (?, 'en cours') RETURNING id";
            PreparedStatement orderStmt = conn.prepareStatement(orderQuery);
            orderStmt.setInt(1, userId);

            ResultSet rs = orderStmt.executeQuery();

            if (rs.next()) {
                int orderId = rs.getInt(1);

                // Insert order details
                String detailQuery = "INSERT INTO details_commande (commande_id, produit_id, quantite, prix_total) VALUES (?, ?, ?, ?)";
                PreparedStatement detailStmt = conn.prepareStatement(detailQuery);

                for (Map.Entry<Integer, Integer> entry : cart.getProducts().entrySet()) {
                    int productId = entry.getKey();
                    int quantity = entry.getValue();

                    // Get product price
                    String productQuery = "SELECT prix FROM produits WHERE id = ?";
                    PreparedStatement productStmt = conn.prepareStatement(productQuery);
                    productStmt.setInt(1, productId);
                    ResultSet productRs = productStmt.executeQuery();

                    if (productRs.next()) {
                        double price = productRs.getDouble(1);
                        detailStmt.setInt(1, orderId);
                        detailStmt.setInt(2, productId);
                        detailStmt.setInt(3, quantity);
                        detailStmt.setDouble(4, price * quantity);
                        detailStmt.addBatch();
                    }
                }

                detailStmt.executeBatch();
                cart.clear();
                session.setAttribute("cart", cart);

                response.sendRedirect("userDashboard.jsp?message=Order placed successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=An error occurred while placing the order.");
        }
    }
}
