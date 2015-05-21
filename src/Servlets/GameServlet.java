package Servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

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
		
		if(action.equals("getCharStatus")){
			String username = request.getParameter("username");
			ResultSet rs = db.getPlayerInfo(username);
			Map<String, String> status = new LinkedHashMap<String, String>();
			try {
				if(rs.next()){
					status.put("Level", rs.getString("level"));
					status.put("Exp", rs.getString("exp"));
					status.put("HP", rs.getString("hp"));
					status.put("Attack", rs.getString("attack"));
					status.put("Defense", rs.getString("defense"));
					status.put("Speed", rs.getString("speed"));
					
					String json = new Gson().toJson(status);
					
					response.setContentType("text/plain");  
				    response.setCharacterEncoding("UTF-8"); 
				    response.getWriter().write(json); 
				}
			} catch (SQLException e) {
				System.out.println("Error reading char status: "+e);
			}
		}
		
	    //response.setContentType("text/plain");  
	    //response.setCharacterEncoding("UTF-8"); 
	    //response.getWriter().write(a);       
	}

	/**
	 * 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
