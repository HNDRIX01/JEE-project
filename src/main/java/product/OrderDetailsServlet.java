package product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/OrderDetailsServlet")
public class OrderDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("id");
        if (orderId != null && orderId.matches("\\d+")) {
            List<String[]> orderDetails = new ArrayList<>();
            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(
                     "SELECT c.id AS commande_id, c.date, c.statut, " +
                     "p.nom AS produit_nom, p.prix, dc.quantite, dc.prix_total " +
                     "FROM commandes c " +
                     "JOIN details_commande dc ON c.id = dc.commande_id " +
                     "JOIN produits p ON dc.produit_id = p.id " +
                     "WHERE c.id = ?")) {
                stmt.setInt(1, Integer.parseInt(orderId));
                ResultSet rs = stmt.executeQuery();
                
                // Date format for "yy-mm-dd HH:MM:SS"
                SimpleDateFormat dateFormat = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
                
                while (rs.next()) {
                    String formattedDate = dateFormat.format(rs.getTimestamp("date"));
                    
                    orderDetails.add(new String[] {
                        String.valueOf(rs.getInt("commande_id")),
                        formattedDate,  // Use the formatted date here
                        rs.getString("statut"),
                        rs.getString("produit_nom"),
                        rs.getString("prix"),
                        rs.getString("quantite"),
                        rs.getString("prix_total")
                    });
                }
                request.setAttribute("orderDetails", orderDetails);
                request.getRequestDispatcher("getOrderDetails.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else {
            response.sendRedirect("History.jsp");
        }
    }
}
