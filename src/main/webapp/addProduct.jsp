<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="AdminNavbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Add Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #123456, #123456); /* Consistent solid gradient */
            color: white;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-top: 2rem;
            max-width: 700px;
            background-color: rgba(255, 255, 255, 0.1);
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
            text-align: center;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-control, .form-control-file {
            border-radius: 0.5rem;
            border: 1px solid #ccc;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 0.5rem;
            padding: 0.5rem 1.5rem;
            font-weight: bold;
            margin-top: 1rem;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <!-- Admin Navbar Included -->
    <div class="container">
        <h2>Add New Product</h2>
        <form action="AddProductServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="productName">Product Name:</label>
                <input type="text" class="form-control" id="productName" name="productName" required>
            </div>
            <div class="form-group">
                <label for="productDescription">Product Description:</label>
                <textarea class="form-control" id="productDescription" name="productDescription" rows="3" required></textarea>
            </div>
            <div class="form-group">
                <label for="productPrice">Price:</label>
                <input type="number" class="form-control" id="productPrice" name="productPrice" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="productStock">Stock Quantity:</label>
                <input type="number" class="form-control" id="productStock" name="productStock" required>
            </div>
            <div class="form-group">
                <label for="productCategory">Category:</label>
                <select class="form-control" id="productCategory" name="productCategory" required>
                    <option value="Electronics">Electronics</option>
                    <option value="Clothing">Clothing</option>
                    <option value="Home and Kitchen">Home and Kitchen</option>
                    <option value="Books">Books</option>
                    <option value="Toys and Games">Toys and Games</option>
                    <option value="Beauty and Personal Care">Beauty and Personal Care</option>
                    <option value="Sports and Outdoors">Sports and Outdoors</option>
                    <option value="Automotive">Automotive</option>
                    <option value="Health and Wellness">Health and Wellness</option>
                    <option value="School">School</option>
                </select>
            </div>
            <div class="form-group">
                <label for="productImage">Product Image:</label>
                <input type="file" class="form-control-file" id="productImage" name="productImage">
            </div>
            <button type="submit" class="btn btn-primary btn-block">Add Product</button>
        </form>
    </div>
</body>
</html>
