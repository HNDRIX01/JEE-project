package product;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/AddProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddProductServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        String productPrice = request.getParameter("productPrice");
        String productStock = request.getParameter("productStock");
        String productCategory = request.getParameter("productCategory");
        Part filePart = request.getPart("productImage");

        if (productName == null || productDescription == null || productPrice == null || productStock == null || filePart == null) {
            response.getWriter().println("One of the form fields is missing. Please ensure all fields are filled out.");
            return;
        }

        String fileName = getFileName(filePart);
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

     // Create the uploads directory if it does not exist
     File uploadDir = new File(uploadPath);
     if (!uploadDir.exists()) {
         // Try creating the directory
         boolean dirCreated = uploadDir.mkdirs();
         if (!dirCreated) {
             throw new IOException("Failed to create upload directory");
         }
     }


        String filePath = uploadPath + File.separator + fileName;

        try (InputStream input = filePart.getInputStream()) {
            File file = new File(filePath);
            file.createNewFile();
            filePart.write(filePath);
        } catch (IOException e) {
            e.printStackTrace();
            response.getWriter().println("File upload failed: " + e.getMessage());
            return;
        }
        
        String sql = "INSERT INTO produits (nom, description, prix, image, stock, category) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, productName);
            statement.setString(2, productDescription);
            statement.setBigDecimal(3, new BigDecimal(productPrice));
            statement.setString(4, fileName);
            statement.setInt(5, Integer.parseInt(productStock));
            statement.setString(6, productCategory); // Set category


            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database operation failed: " + e.getMessage());
            return;
        }

        response.sendRedirect("adminDashboard.jsp");
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return "";
    }
}
