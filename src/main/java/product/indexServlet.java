package product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/indexServlet")
public class indexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> productList = new ArrayList<>();
        List<String> categories = new ArrayList<>();
        
        // Fetch distinct categories for the navigation bar
        String categorySql = "SELECT DISTINCT category FROM public.produits";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(categorySql);
             ResultSet rs = stmt.executeQuery()) {
             
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Fetch products based on the selected category or all products
        String selectedCategory = request.getParameter("category");
        String productSql = "SELECT id, nom, description, prix, image, stock, category FROM public.produits" +
                            (selectedCategory != null && !selectedCategory.isEmpty() ? " WHERE category = ?" : "");

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(productSql)) {
             
            if (selectedCategory != null && !selectedCategory.isEmpty()) {
                stmt.setString(1, selectedCategory); // Bind category parameter
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                    rs.getInt("id"),
                    rs.getString("nom"),
                    rs.getString("description"),
                    rs.getDouble("prix"),
                    rs.getString("image"),
                    rs.getInt("stock"),
                    rs.getString("category") // Include category
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("Product list size: " + productList.size()); // Debugging log
        System.out.println("Category list size: " + categories.size()); // Debugging log

        // Set attributes for products and categories
        request.setAttribute("productList", productList);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", selectedCategory); // For highlighting active category

        // Forward to the index page
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
