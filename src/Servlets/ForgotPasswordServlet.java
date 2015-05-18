package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import javax.mail.MessagingException;
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
		
		if(db.doesExist(username, email))
		{
			final String password =Password();
			String hashed = null;
			Sha1Hex sha1 = new Sha1Hex();
			try {
				hashed = sha1.makeSHA1Hash(password);
			} catch (NoSuchAlgorithmException e) {
				System.out.println("Error creating hash: "+e);
			}
			
			final String auth_code = hashed;
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
						e.printStackTrace();
					}
				}
			});
			t.start();
			response.sendRedirect(contextPath + "/contact.jsp?ok=1");
			}
		}
	}
	protected String Password()
	{
		String pas=null;
		Random rand = new Random(); 
		for(int i=0; i<8;i++)
		{
			int value = rand.nextInt(26)+65; 
			pas+=(char)value;
			System.out.println(pas);
		}
		return pas;
	}
	
	
}
















