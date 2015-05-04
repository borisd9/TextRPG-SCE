package Servlets;

import java.io.IOException;

import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Database.AuthenticationDB;

/**
 * Servlet implementation class AuthenticationServlet
 */
@WebServlet("/AuthenticationServlet")
public class AuthenticationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private AuthenticationDB db;   
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthenticationServlet() {
        super();
        db = new AuthenticationDB();
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
		String auth_code = request.getParameter("code");
		String username = db.doesExit(auth_code);
		
		if(username != null){
			db.activate(username);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/activate.jsp");
	        PrintWriter out= response.getWriter();
	        out.println("<font color=blue>You account has been succesfully updated! Enjoy your stay. :)</font><br/>");
	        rd.include(request, response);
		}
		else{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/activate.jsp");
	        PrintWriter out= response.getWriter();
	        out.println("<font color=red>Activation error! Please enter the correct code.</font><br/>");
	        rd.include(request, response);
		}
	}

}
