package Servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Database.GameDB;
import Database.MapDB;

import com.google.gson.Gson;


/**
 * Servlet implementation class GameServlet
 */
@WebServlet("/gameservlet")
public class GameServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	ResultSet rs;   
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
		
		//Adding a new player to the database
		if(action.equals("newPlayer")){
			String username = request.getParameter("username");
			String charName = request.getParameter("charName");
			db.addPlayer(username, charName);
		}
		
		//Return character's status
		if(action.equals("getCharStatus")){
			String username = request.getParameter("username");
			rs = db.getPlayerInfo(username);
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
		
		//Return player's status
		if(action.equals("getMyStatus")){
			String username = request.getParameter("username");
			 rs = db.getPlayerInfo(username);
			Map<String, String> status = new LinkedHashMap<String, String>();
			try {
				if(rs.next()){
					status.put("Username", rs.getString("username"));
					status.put("Location", rs.getString("location"));
					status.put("Character", rs.getString("character"));
					status.put("Money", rs.getString("money"));
					status.put("Cash", rs.getString("cash"));
					status.put("Item", rs.getString("item"));
					status.put("Wins", rs.getString("wins"));
					status.put("Loses", rs.getString("loses"));
					
					String json = new Gson().toJson(status);
					
					response.setContentType("text/plain");  
				    response.setCharacterEncoding("UTF-8"); 
				    response.getWriter().write(json); 
				}
			} catch (SQLException e) {
				System.out.println("Error reading char status: "+e);
			}
		}

		
		//Return location information
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
			String json = new Gson().toJson(mapStatus);
			response.setContentType("text/plain");  
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(json);    
	
		}
		
		//Battle (between 2 players) is over
		if(action.equals("battleOver")){
			String winner = request.getParameter("winner");
			String loser = request.getParameter("loser");
			float exp = Float.parseFloat(request.getParameter("exp"));
			String levelup = request.getParameter("levelup");
			db.updateBattleResults(winner, loser, exp, levelup);
		}
		
		//Map movement command
		if(action.equals("moveTo")){
			String direction = request.getParameter("direction").substring(1);
			//get current map location and move player
			if(direction.equals("up"))
				map.move(map.getUp());
			if(direction.equals("down"))
				map.move(map.getDown());
			if(direction.equals("left"))
				map.move(map.getLeft());
			if(direction.equals("right"))
				map.move(map.getRight());
			
		}
		
		if(action.equals("moveSomewhere")){
			
			String direction = request.getParameter("direction").substring(0);
			//get current map location and move player
			if(direction.equals("Home"))
				map.move("Home");
			else if(direction.equals("Chimaki Hospital"))
				map.move("Chimaki Hospital");
			else if(direction.equals("The Screamers Prison"))
				map.move("The Screamers Prison");
			else if(direction.equals("Torchwood"))
				map.move("Torchwood");
			
		}
		

		if(action.equals("buyFromStore")){
			String username = request.getParameter("username");
			//String location = request.getParameter("location");
			String itemList = request.getParameter("itemList");
			
			
			int money= db.getMoney(username);
			int price= db.getItemPrice(itemList);
			System.out.println("price"+price);
			System.out.println("money"+money);
			
			int buy=money-price;
			System.out.println("buy"+buy);
			String ans;
			
			if(buy>=0 && price!=-1)
			{	
				db.updatePurchaseItem(username,itemList,buy);
				ans = "1";
			}
			else{
				ans = "0";	
			}
			response.setContentType("text/plain");  
		    response.setCharacterEncoding("UTF-8"); 
		    response.getWriter().write(ans);
			
		}
		
		if(action.equals("updatefight")){
			int flag = Integer.parseInt(request.getParameter("flag"));
			if(flag==1){
				int exp = Integer.parseInt(request.getParameter("expto"));
				int coins = Integer.parseInt(request.getParameter("coinsto"));
				String username = request.getParameter("username");
	
				db.updatefight(username, exp, coins,flag);
			}
			else {
				int exp = Integer.parseInt(request.getParameter("expto"));
				int coins = Integer.parseInt(request.getParameter("coinsto"));
				String username = request.getParameter("username");
	
				db.updatefight(username, exp, coins,flag);
			}
		}


		
		if(action.equals("premItem")){
			String playername = request.getParameter("username");
			String price = request.getParameter("price");
			String item=request.getParameter("item");
			db.updatePlayerMoney(playername, price);
			db.updatePlayerItem(playername, item);
		}
		 
		if(action.equals("getMoney")){
			String playername = request.getParameter("username");
			String price=request.getParameter("price");
			int cash=db.getPlayerMoney(playername);
			Map<String, String> coins = new LinkedHashMap<String, String>();
			int iPrice=Integer.parseInt(price);		
			if(cash<iPrice)
				coins.put("this item is too expensive for you", "1");
			else{
				int update=cash-iPrice;
				String strUpdate= ""+update;
				coins.put("Money you have:",strUpdate );
			}
			String json = new Gson().toJson(coins);
			
			response.setContentType("text/plain");  
			response.setCharacterEncoding("UTF-8"); 
			response.getWriter().write(json); 
		}	
		
		if(action.equals("getItemsDB")){
			String username = request.getParameter("username");
			rs = db.getStoreItems(username);
			List<Map<String,String>> lst = new ArrayList<Map<String,String>>();

			try {
				while(rs.next()){
					Map<String,String> item= new LinkedHashMap<String,String>();
				
					item.put("Item", rs.getString("item"));
					item.put("Description", rs.getString("description"));
					item.put("Bonus1", rs.getString("bonus1"));
					item.put("Bonus2", rs.getString("bonus2"));
					item.put("Price", rs.getString("price"));
					
					lst.add(item);
				}
			} catch (SQLException e) {
				System.out.println("Error reading char status: "+e);
			}
			
			String json = new Gson().toJson(lst);
			
			response.setContentType("text/plain");  
			response.setCharacterEncoding("UTF-8"); 
			response.getWriter().write(json); 
			
		}
	}
	/**
	 * 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
