<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Details</title>
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

        .property-detail {
            background-color: white;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .property-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }

        .property-details {
            padding: 15px;
        }

        .property-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .property-description {
            font-size: 16px;
            color: #555;
            margin-bottom: 10px;
        }

        .property-price {
            font-size: 20px;
            color: #004b97;
            font-weight: bold;
        }

        .contact-form {
            margin-top: 20px;
        }

        .contact-form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .contact-form input, .contact-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .contact-form button {
            padding: 10px 20px;
            background-color: #004b97;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .contact-form button:hover {
            background-color: #00387d;
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
        <h1>Property Details</h1>
        <form class="logout-form" action="./index.html" method="get">
            <button class="logout-button" type="submit">Logout</button>
        </form>
    </div>

    <div class="container">
        <% 
            String propertyId = request.getParameter("id");
            if (propertyId != null && !propertyId.isEmpty()) {
                String url = "jdbc:mysql://localhost:3307/realestate";
                String user = "root";
                String password = "root";
                
                try (Connection con = DriverManager.getConnection(url, user, password);
                     PreparedStatement ps = con.prepareStatement("SELECT * FROM properties WHERE id = ?")) {
                    
                    ps.setInt(1, Integer.parseInt(propertyId));
                    ResultSet rs = ps.executeQuery();
                    
                    if (rs.next()) {
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        String price = rs.getString("price");
                        String imageUrl = rs.getString("image_url");
            %>
            <div class="property-detail">
                <img src="<%= imageUrl %>" alt="Property Image" class="property-image">
                <div class="property-details">
                    <h2 class="property-title"><%= title %></h2>
                    <p class="property-description"><%= description %></p>
                    <p class="property-price"><%= price %></p>
                </div>

                <h3>Contact Us</h3>
                <form class="contact-form" action="PropertyInquiryServlet" method="post">
                    <input type="hidden" name="propertyId" value="<%= propertyId %>">
                    
                    <label for="name">Name:</label>
                    <input type="text" name="name" id="name" required>
                    
                    <label for="email">Email:</label>
                    <input type="email" name="email" id="email" required>
                    
                    <label for="phone">Phone:</label>
                    <input type="text" name="phone" id="phone" required>
                    
                    <label for="message">Message:</label>
                    <textarea name="message" id="message" rows="4" required></textarea>
                    
                    <button type="submit">Submit</button>
                </form>
            </div>
            <% 
                    } else {
                        out.println("Property not found.");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } else {
                out.println("Invalid property ID.");
            }
        %>
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
