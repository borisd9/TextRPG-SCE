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
@WebServlet("/AuthenticationServlet/*")
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
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String auth_code = request.getParameter("code");
		String username = db.doesExit(auth_code);
		
		if(username != null){
			db.activate(username);
			response.sendRedirect(request.getContextPath()+"/activate.jsp?username="+username);
		}
		else{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/activate.jsp");
	        PrintWriter out= response.getWriter();
	        out.println("<font color=red>Activation error!"+auth_code+" Please enter the correct code.</font><br/>");
	        rd.include(request, response);
		}
	}

}
