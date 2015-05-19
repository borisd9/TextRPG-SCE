package Servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Database.GameDB;

/**
 * Servlet implementation class GameServlet
 */
@WebServlet("/gameservlet")
public class GameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	GameDB db;

	/**
     * @see HttpServlet#HttpServlet()
     */
    public GameServlet() {
        super();
        db = new GameDB();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if(action.equals("newPlayer")){
			String username = request.getParameter("username");
			String charName = request.getParameter("charName");
			db.addPlayer(username, charName);
		}
		
	    //response.setContentType("text/plain");  
	    //response.setCharacterEncoding("UTF-8"); 
	    //response.getWriter().write(a);       
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
