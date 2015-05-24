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
import Database.MapDB;


/**
 * Servlet implementation class GameServlet
 */
@WebServlet("/gameservlet")
public class GameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	GameDB db;
	MapDB map;


	/**
     * @see HttpServlet#HttpServlet()
     */
    public GameServlet() {
        super();
        db = new GameDB();
        map = new MapDB();
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
		

		
		if(action.equals("getMapStatus")){
			
			//get current map location
			map.update(request.getParameter("username"));

			Map<String, String> mapStatus = new LinkedHashMap<String, String>();
			
			mapStatus.put("location", map.getLocation());
			mapStatus.put("x", map.getx());
			mapStatus.put("y", map.gety());
			mapStatus.put("up", map.getUp());
			mapStatus.put("down", map.getDown());
			mapStatus.put("left", map.getLeft());
			mapStatus.put("right", map.getRight());
			mapStatus.put("act1", map.getAct(1));
			mapStatus.put("act2", map.getAct(2));
			mapStatus.put("act3", map.getAct(3));
			mapStatus.put("act4", map.getAct(4));
			
			String json = new Gson().toJson(map);
			
			response.setContentType("text/plain");  
		    response.setCharacterEncoding("UTF-8"); 
		    response.getWriter().write(json); 
			
		
		}
		
		if(action.equals("buyFromStore")){
			String username = request.getParameter("username");
			//String location = request.getParameter("location");
			String itemsChars = request.getParameter("itemsChars");
			
			
			int money= db.getMoney(username);
			int price= db.getItemPrice(itemsChars);
			int buy=money-price;
			if(buy>=0)
			{
				db.updatePurchaseItem(username,itemsChars,buy);
				String ans = "1";
				response.getWriter().write(ans);
			}
			else{
				String ans = "0";
				response.getWriter().write(ans);
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
