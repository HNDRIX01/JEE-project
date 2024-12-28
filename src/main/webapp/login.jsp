<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: #fff;
            font-family: Arial, sans-serif;
        }
        .login-container {
            margin-top: 10%;
            display: flex;
            justify-content: center;
            }
            
         h2 {
			    font-family: 'Montserrat', sans-serif;
			    text-align: center;
			    font-weight: 500;
			    background: linear-gradient(to right, #6a11cb, #2575fc); /* Gradient from purple to blue */
			    -webkit-background-clip: text;
			    -webkit-text-fill-color: transparent;
			}
			h3 {
			    font-family: 'Montserrat', sans-serif;
			    text-align: center;
			    font-weight: 500;
			/*  background: linear-gradient(to right, #6a11cb, #2575fc); /* Gradient from purple to blue */
			  /*  -webkit-background-clip: text;
			   -webkit-text-fill-color: transparent;*/
			}

        .login-card {
            width: 100%;
            max-width: 400px;
            padding: 2rem;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
            background-color: #ffffff;
            color: #000;
        }
        .form-group label {
            font-weight: bold;
        }
        .form-control {
            border-radius: 0.5rem;
            border: 1px solid #ccc;
        }
        .btn-primary {
            border-radius: 0.5rem;
            background-color: #6a11cb;
            border: none;
        }
        .btn-primary:hover {
            background-color: #2575fc;
        }
        .error-message {
            background-color: #ff4d4d;
            color: white;
            border-radius: 0.5rem;
            padding: 0.75rem;
            text-align: center;
            margin-bottom: 1rem;
        }
        .navbar {
            margin-bottom: 2rem;
            background-color: #000;
        }
        .navbar-brand {
		    font-family: 'Montserrat', sans-serif; /* Changes the font for the "My Shop" brand */
		    font-size: 1.5rem; /* Adjust size as needed */
		    font-weight: 700; /* Makes it bold */
		}

		.nav-link {
		    font-family: 'Montserrat', sans-serif; /* Changes the font for navigation links */
		    font-size: 1rem; /* Adjust size as needed */
		    font-weight: 500; /* Makes it semi-bold */
		    color: #ffffff !important; /* Ensures white color for links */
		}

		.nav-link:hover {
		    color: #6a11cb !important; /* Changes color on hover */
		}

        
        
        
        
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="index.jsp">My Shop</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Register</a>
                </li>
                <% if (session.getAttribute("nom") == null) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">Logout</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </nav>

    <div class="container login-container">
        <div class="card login-card">
            <h2 class="text-center">Welcome to E-Shopify</h2>
            
            <!-- Display Error Message if Query Parameter 'error' Exists -->
           
            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="nom">Name:</label>
                    <input type="text" class="form-control" id="nom" name="nom" required>
                </div>
                <div class="form-group">
                    <label for="mot_de_passe">Password:</label>
                    <input type="password" class="form-control" id="mot_de_passe" name="mot_de_passe" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Login</button>
            </form>
            <br>
             <% String errorMessage = request.getParameter("error"); %>
            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                <div class="error-message"><%= errorMessage %></div>
            <% } %>
            
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
