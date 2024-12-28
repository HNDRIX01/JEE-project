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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ManageOrdersServlet")
public class ManageOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String[]> orders = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT id, utilisateur_id, date, statut FROM commandes ORDER BY date ASC")) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orders.add(new String[]{
                    String.valueOf(rs.getInt("id")),
                    rs.getString("utilisateur_id"),
                    rs.getString("date"),
                    rs.getString("statut")
                });
            }

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("manageOrders.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        System.out.println("Status received: " + status);

        System.out.println("Received POST request with orderId: " + orderId + " and status: " + status);

        if (orderId != null && !orderId.isEmpty() && status != null && !status.isEmpty()) {
            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement("UPDATE commandes SET statut = ? WHERE id = ?")) {

                stmt.setString(1, status);
                stmt.setInt(2, Integer.parseInt(orderId));
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    System.out.println("Order ID " + orderId + " updated successfully to " + status);
                } else {
                    System.out.println("Order ID " + orderId + " not found.");
                }

                response.sendRedirect("ManageOrdersServlet");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Database error: " + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else {
            System.out.println("Invalid input: Order ID or status is missing.");
            response.sendRedirect("ManageOrdersServlet");
        }
    }
}
