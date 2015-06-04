package Servlets;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Database.ChangePasswordDB;
import General.Sha1Hex;


/**
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//Database handler
	ChangePasswordDB db;
	//URL path
	String contextPath;
		
	/**
	 * Constructor
	 */
    public ChangePasswordServlet() {
        super();
        db = new ChangePasswordDB();
    }
	
    /**
     * Redirect to login/jsp
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		String username = (String)session.getAttribute("username");
		final String oldPass = request.getParameter("oldPass");
		final String newpass = request.getParameter("newpass");
		final String newpassR = request.getParameter("newpassR");
		contextPath = request.getContextPath();
		
		//System.out.println("~~~~"+contextPath);
		
		if(oldPass=="" || newpass=="" || newpassR=="")
			response.sendRedirect(contextPath + "/changePassword.jsp?err=1");
		else{
			final String oldpassword =oldPass;
			String oldhashedPassword = null;
			Sha1Hex sha1 = new Sha1Hex();
			try {
				oldhashedPassword = sha1.makeSHA1Hash(oldpassword);
			} catch (NoSuchAlgorithmException e) {
				System.out.println("Error creating hash: "+e);
			}
			
			final String auth_code_old = oldhashedPassword;
			
			if(!db.doesExist(username,auth_code_old))
				response.sendRedirect(contextPath + "/changePassword.jsp?err=2");
			else if(newpass.equals(newpassR)){
				
				
				final String newpassword =newpass;
				String newhashedpassword = null;
				Sha1Hex sha2 = new Sha1Hex();
				
				try {
					newhashedpassword = sha2.makeSHA1Hash(newpassword);
				} catch (NoSuchAlgorithmException e) {
					System.out.println("Error creating hash: "+e);
				}
				
				final String auth_code_new = newhashedpassword;
				
				
				if(db.UpdatePassword(username,auth_code_new))				
					response.sendRedirect(contextPath + "/changePassword.jsp?ok=1");
				
			}else response.sendRedirect(contextPath + "/changePassword.jsp?err=3");
				
		}
				
		
	}
	
}
