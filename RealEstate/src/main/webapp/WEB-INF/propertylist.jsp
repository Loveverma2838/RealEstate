<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Real Estate Listings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }

        .header {
            background-color: #004b97;
            color: white;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .container {
            width: 80%;
            margin: 20px auto;
        }

        .search-bar {
            margin-bottom: 20px;
            text-align: center;
        }

        .search-input {
            width: 50%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .property-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .property-card {
            background-color: white;
            width: 30%;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }

        .property-card:hover {
            transform: scale(1.03);
        }

        .property-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .property-details {
            padding: 15px;
        }

        .property-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .property-description {
            font-size: 14px;
            color: #555;
            margin-bottom: 10px;
        }

        .property-price {
            font-size: 16px;
            color: #004b97;
            font-weight: bold;
        }

        .footer {
            text-align: center;
            padding: 20px;
            background-color: #004b97;
            color: white;
            margin-top: 20px;
        }

        .footer .footer-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .footer .company-details {
            margin-bottom: 10px;
        }

        .footer .social-links {
            margin-bottom: 10px;
        }

        .footer .social-links a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
            font-size: 18px;
        }

        .footer .social-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Real Estate Listings</h1>
        <form class="logout-form" action="./index.html" method="get">
            <button class="logout-button" type="submit">Logout</button>
        </form>
    </div>

    <div class="container">
        <div class="search-bar">
            <input type="text" class="search-input" placeholder="Search properties...">
        </div>

        <div class="property-list">
            <% 
                String url = "jdbc:mysql://localhost:3307/realestate";
                String user = "root";
                String password = "root";
                
                try (Connection con = DriverManager.getConnection(url, user, password);
                     Statement st = con.createStatement();
                     ResultSet rs = st.executeQuery("SELECT * FROM properties")) {
                    
                    while (rs.next()) {
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        String price = rs.getString("price");
                        String imageUrl = rs.getString("image_url");
            %>
<div class="property-card">
    <a href="propertydetails.jsp?id=<%= rs.getInt("id") %>">
        <img src="<%= rs.getString("image_url") %>" alt="Property Image" class="property-image">
        <div class="property-details">
            <h2 class="property-title"><%= rs.getString("title") %></h2>
            <p class="property-description"><%= rs.getString("description") %></p>
            <p class="property-price"><%= rs.getString("price") %></p>
        </div>
    </a>
</div>    <% 
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
            %>
                <p>Error retrieving properties. Please try again later.</p>
            <% 
                }
            %>
        </div>
    </div>

    <div class="footer">
        <div class="footer-content">
            <div class="company-details">
                <p>&copy; 2024 Real Estate Web Application. All rights reserved.</p>
                <p>123 Main Street, Anytown, AN 12345</p>
                <p>Email: info@realestate.com | Phone: (123) 456-7890</p>
            </div>
            <div class="social-links">
                <a href="https://facebook.com" target="_blank">Facebook</a>
                <a href="https://twitter.com" target="_blank">Twitter</a>
                <a href="https://instagram.com" target="_blank">Instagram</a>
            </div>
        </div>
    </div>
</body>
</html>
