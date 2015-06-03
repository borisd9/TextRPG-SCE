package Servlets;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import General.SendMail;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
	

	private static final long serialVersionUID = 1L;
	String contextPath;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContactServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		final String name = request.getParameter("name");
		final String subject = request.getParameter("subject");
		final String email = request.getParameter("email");
		final String message = request.getParameter("message");
		contextPath = request.getContextPath();

		//Checking if fields are empty
		if(email=="" || message==""){
			response.sendRedirect(contextPath + "/contact.jsp?err=1");
		}
		else{
			//Send mail
			Thread t = new Thread(new Runnable() {	
				@Override
				public void run() {
					SendMail sm = new SendMail();
					sm.contactMail(subject, message, name, email);
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