package Servlets;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Database.LoginDB;
import General.SessionHandler;
import General.Sha1Hex;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//Database handler
	LoginDB db;
	//URL path
	String contextPath;
		
	/**
	 * Constructor
	 */
    public LoginServlet() {
        super();
        db = new LoginDB();
    }

    /**
     * Redirect to login/jsp
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		contextPath = request.getContextPath();
		response.sendRedirect(contextPath + "/login.jsp");
	}

	/**
     * Handle login process
     */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("user");
		String password = request.getParameter("pwd");
		contextPath = request.getContextPath();
		
		//encrypting password
		String hashed = null;
		Sha1Hex sha1 = new Sha1Hex();
		try {
			hashed = sha1.makeSHA1Hash(password);
		} catch (NoSuchAlgorithmException e) {
			System.out.println("Error creating hash: "+e);
		}		
		final String encPassword = hashed;	
		
		//If fields are empty - display error
		if(username=="" || password==""){
			response.sendRedirect(contextPath + "/login.jsp?err=1");
		}
		//check if the user's account is not activated
		else if(db.doesExist(username, encPassword)==0)
		{
			response.sendRedirect(contextPath + "/login.jsp?err=3");
		}
		//Check if user exists in database and his account is activated
		else if(db.doesExist(username, encPassword)==1)
		{
			HttpSession session = request.getSession();
	
			//Check if user is already logged in, if not - finish process, if yes - display error
			if(session.getAttribute("loggedIn")!=null && session.getAttribute("loggedIn").equals(true)){
				response.sendRedirect(contextPath + "/login.jsp?err=4");
			}
			else{
				session.setAttribute("loggedIn", true);
				session.setAttribute("username", username);
				response.sendRedirect(request.getContextPath()+"/home.jsp");
			}
		}
		//If user doesn't exist in database - display error
		else{
            response.sendRedirect(contextPath + "/login.jsp?err=2");
        }
	}

}
