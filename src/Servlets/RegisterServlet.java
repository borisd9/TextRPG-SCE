package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;

import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Database.UsersQueries;
import General.SendMail;
import General.Sha1Hex;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     public static int flag=0;
	UsersQueries db;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();   
        db = new UsersQueries();
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
		
		String hashed = null;
		Sha1Hex sha1 = new Sha1Hex();
		try {
			hashed = sha1.makeSHA1Hash(username);
		} catch (NoSuchAlgorithmException e) {
			System.out.println("Error creating hash: "+e);
		}
		
		final String auth_code = hashed;
		
		db.insert(username, password, email);
		db.insert(username, auth_code);
		
		
		//Send mail
		Thread t = new Thread(new Runnable() {	
			@Override
			public void run() {
				SendMail sm = new SendMail(email, username, auth_code);
				try {
					sm.send();
					flag=1;
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		});
		t.start();
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/Register.jsp");
        PrintWriter out= response.getWriter();
        if(flag==1)
        	out.println("<font color=red>Registration complete! Please follow the steps provided in your mail's inbox to activate your account.</font><br/>");
        rd.include(request, response);
	}

}
