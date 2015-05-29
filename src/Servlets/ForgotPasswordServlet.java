package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Database.ForgotPasswordDB;
import Database.RegisterDB;
import General.SendMail;
import General.Sha1Hex;

/**
 * Servlet implementation class ForgotPasswordServlet
 */
@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	String contextPath;
	ForgotPasswordDB db;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotPasswordServlet() {
        super();   
        db = new ForgotPasswordDB();
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
		final String email = request.getParameter("email");
			contextPath = request.getContextPath();
		if(username=="" || email=="")
			response.sendRedirect(contextPath + "/ForgotPassword.jsp?err=1");
		else if(!isValidEmail(email))
			response.sendRedirect(contextPath + "/ForgotPassword.jsp?err=2");
		else if(db.doesExist(username, email))
		{
			final String password =Password();
			String hashedPassword = null;
			Sha1Hex sha1 = new Sha1Hex();
			try {
				hashedPassword = sha1.makeSHA1Hash(password);
			} catch (NoSuchAlgorithmException e) {
				System.out.println("Error creating hash: "+e);
			}
			
			final String auth_code = hashedPassword;
			if(db.UpdatePassword(username, auth_code)){
				
		
		
			//Send mail
			Thread t = new Thread(new Runnable() {	
				@Override
				public void run() {
					SendMail sm = new SendMail();
					sm.forgotPassword(email,password);
					try {
						sm.send();
					} catch (MessagingException e) {
						System.out.println("Error sending mail: "+e);
					}
				}
			});
			t.start();
			response.sendRedirect(contextPath + "/ForgotPassword.jsp?ok=1");
			}
		}else response.sendRedirect(contextPath + "/ForgotPassword.jsp?err=3");
	}
	
	protected String Password()
	{
		String pas="";
		Random rand = new Random(); 
		//System.out.println("wow1="+pas);
		for(int i=0; i<8;i++)
		{
			int value = rand.nextInt(26)+65; 
			pas+=(char)value;
			System.out.println(pas);
		}
		System.out.println("wow2= "+pas);
		return pas;
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
















