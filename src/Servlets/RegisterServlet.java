package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Database.RegisterDB;
import General.SendMail;
import General.Sha1Hex;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	RegisterDB db;
	String contextPath;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();   
        db = new RegisterDB();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		final String username = request.getParameter("user");
		String password = request.getParameter("pwd");
		final String email = request.getParameter("email");
		contextPath = request.getContextPath();
		
		//check if the fields are blank
		if(username=="" || password=="" || email=="")
			response.sendRedirect(contextPath + "/register.jsp?err=1");
		//check if email is valid
		else if(!isValidEmail(email))
			response.sendRedirect(contextPath + "/register.jsp?err=2");
		else{
			String hashedUsername = null, hashedPassword = null;
			Sha1Hex sha1 = new Sha1Hex();
			try {
				hashedUsername = sha1.makeSHA1Hash(username);
				hashedPassword = sha1.makeSHA1Hash(password);
			} catch (NoSuchAlgorithmException e) {
				System.out.println("Error creating hash: "+e);
			}
			
			final String auth_code = hashedUsername;
			final String encPassword = hashedPassword;
			
			if(!db.insert(username, encPassword, email))
				response.sendRedirect(contextPath + "/register.jsp?err=3");
			else{
				db.insert(username, auth_code);
				
				//Send mail
				Thread t = new Thread(new Runnable() {	
					@Override
					public void run() {
						SendMail sm = new SendMail();
						sm.registerMail(email, username, auth_code);
						try {
							sm.send();
						} catch (MessagingException e) {
							System.out.println("Error sending mail: "+e);
						}
					}
				});
				t.start();
				
				response.sendRedirect(contextPath + "/register.jsp?ok=1");
			}	
		}
	}

	public static boolean isValidEmail(String email) {
	   boolean result = true;
	   try {
	      InternetAddress emailAddr = new InternetAddress(email);
	      emailAddr.validate();
	   } catch (AddressException ex) {
	      result = false;
	   }
	   return result;
	}
}
