

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String html_loginid= req.getParameter("userName");
		String html_loginpassword=req.getParameter("userPass");
		Connection con=null;
		Statement st = null;
		ResultSet rt =null;
		int found=0;
		try
		{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3307/realestate", "root", "root");
		st=con.createStatement();
		rt = st.executeQuery("select loginid,loginpwd from login");
		while(rt.next())
		{
		String db_loginid=rt.getString("loginid");
		String db_loginpwd = rt.getString("loginpwd");
		if( db_loginid.equals(html_loginid))
		{
		if( db_loginpwd.equals(html_loginpassword))
		{
		found=1;
		break;
		}
		}
		}
		rt.close();
		st.close();
		con.close();
		}
		catch(Exception e)
		{
		System.out.println(e);
		}
		
		if(found == 1)
		{
			res.sendRedirect("PropertyListServlet");
	
		}
		else
		{
		RequestDispatcher rd= req.getRequestDispatcher("/WEB-INF/failure.jsp");
		rd. forward (req, res);
		
		}


}
	}


