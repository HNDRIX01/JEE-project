package product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String motDePasse = request.getParameter("mot_de_passe");

        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM public.utilisateurs WHERE nom = ? AND mot_de_passe = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, nom);
            stmt.setString(2, motDePasse);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // User found, create session and redirect to appropriate dashboard
                HttpSession session = request.getSession();
                session.setAttribute("nom", nom);
                session.setAttribute("role", rs.getString("role")); // Save role to use in the navbar or dashboard
                session.setAttribute("user_id", rs.getInt("id"));

                if ("administrateur".equalsIgnoreCase(rs.getString("role"))) {
                    response.sendRedirect("adminDashboard.jsp"); // Redirect to admin dashboard
                } else {
                	
                    response.sendRedirect("userDashboard.jsp"); // Redirect to user dashboard
                }
            } else {
                // User not found, show error message
                response.sendRedirect("login.jsp?error=Invalid credentials");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=An error occurred. Please try again.");
        }
    }
}
