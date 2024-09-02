import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/PropertyInquiryServlet")
public class PropertyInquiryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String propertyId = request.getParameter("propertyId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        String url = "jdbc:mysql://localhost:3307/realestate";
        String user = "root";
        String password = "root";

        try (Connection con = DriverManager.getConnection(url, user, password);
             PreparedStatement ps = con.prepareStatement("INSERT INTO inquiries (property_id, name, email, phone, message) VALUES (?, ?, ?, ?, ?)")) {

            ps.setInt(1, Integer.parseInt(propertyId));
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, message);

            int result = ps.executeUpdate();

            if (result > 0) {
            	RequestDispatcher rd= request.getRequestDispatcher("/WEB-INF/thankyou.jsp");
        		rd. forward (request, response);
            } else {
                response.sendRedirect("/WEB-INF/error.jsp"); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/WEB-INF/error.jsp");
        }
    }
}
