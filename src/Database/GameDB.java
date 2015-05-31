package Database;

import java.sql.ResultSet;
import java.sql.SQLException;

public class GameDB extends DbConnectionAPI
{
	/**
	 * GameDB constructor
	 */
	public GameDB(){
		super();
	}
	
	/**
	 * checks if user appears in database
	 * @param username
	 * @return true if user has already started a game
	 */
	public boolean doesExist(String username)
	{
		String query = "SELECT * FROM players WHERE username='"+username+"'";		
		
		try {			
			ResultSet rs = readFromDatabase(query);	
			if(rs.next())
				return true;
		} catch (SQLException e) {
			System.out.println("Error in does exists query: "+e);
		}		
		return false;
	}
	
	/**
	 * @return all characters from database
	 */
	public ResultSet getChars(){
		String query = "SELECT name FROM characters";
		ResultSet rs = readFromDatabase(query);	
		return rs;		
	}
	
	/**
	 * @return number of characters in database, -1 if it's empty
	 */
	public int charCount(){
		String query = "SELECT count(*) FROM characters";
		
		ResultSet rs = readFromDatabase(query);
		try {
			if(rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("Error in count query: "+e);
		}
		return -1;
	}

	/**
	 * adds new player to database
	 * @param username
	 * @param charName
	 */
	public void addPlayer(String username, String charName){
		String query1 = "SELECT * FROM characters WHERE name='"+charName+"'";
		
		ResultSet rs = readFromDatabase(query1);
		
		try {
			if(rs.next()){
				int attack = rs.getInt("attack");
				int defense = rs.getInt("defense");
				int hp = rs.getInt("hp");
				int speed = rs.getInt("speed");
				
				String query2 = "INSERT INTO players VALUES ('"+username+"','Home','"+charName+"',1,'"+attack+"','"+defense+"','"+speed+"','"
								+hp+"',0,1000,0,'Starter Kit',0,0)";
				
				modifyDatabase(query2);
			}
		} catch (SQLException e) {
			System.out.println("Error in add player query: "+e);
		}
	}

	

	
	/**
	 * get player information
	 * @param username
	 * @return relevant row from players database
	 */
	public ResultSet getPlayerInfo(String username){
		String query = "SELECT * FROM players WHERE username='"+username+"'";
		ResultSet rs = readFromDatabase(query);
		return rs;
	}
	
	
	
	/**
	 * @return all premium items from database
	 */
	public ResultSet getPremiumItems(){
		String query = "SELECT item FROM items WHERE premium='"+1+"'";
		ResultSet rs = readFromDatabase(query);	
		return rs;
	}






/**
	 * @return number of premiumItems in database, -1 if it's empty
	 */
	public int PremiumItemsCount(){
		String query = "SELECT count(*) FROM items WHERE premium='"+1+"'";
		
		ResultSet rs = readFromDatabase(query);
		try {
			if(rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("Error in count query: "+e);
		}
		return -1;
	}




/**
 * 
 * @param playerName
 * @param cash
 * updates player money after he buy an item from premium store 
 */
	public void updatePlayerMoney(String playerName, String price){
		String query1 = "SELECT * FROM players WHERE username='"+playerName+"'";
		ResultSet rs = readFromDatabase(query1);
		try {
			if(rs.next()){
				int money = rs.getInt("money");
				money=money-Integer.parseInt(price);
				String qr="UPDATE players SET money='"+money+"'WHERE username='"+playerName+"'";	  

				
				modifyDatabase(qr);
			}
		} catch (SQLException e) {
			System.out.println("Error in update player coins query: "+e);
		}
}
	
	
	/**
	 * 
	 * @param playerName, item
	 * updates player item field with itemName that he buy
	 */
	public void updatePlayerItem(String playerName, String item){
		String query1 = "SELECT * FROM players WHERE username='"+playerName+"'";
		ResultSet rs = readFromDatabase(query1);
		try {
			if(rs.next()){
				String qr="UPDATE players SET item='"+item+"'WHERE username='"+playerName+"'";	  

				
				modifyDatabase(qr);
			}
		} catch (SQLException e) {
			System.out.println("Error in update player item query: "+e);
		}
}
	
	
	/**
	 * 
	 * @param playerName
	 * @return player coins for buy items
	 */
	public int getPlayerMoney(String playerName){
		String query = "SELECT * FROM players WHERE username='"+playerName+"'";
		int coins=0;
		ResultSet rs = readFromDatabase(query);
		try {
			if(rs.next()){
				 coins = rs.getInt("money");}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return coins;
	
	}

	
	/**
	 * @return price of  items from database
	 */
	public int getItemPrice(String item){
		String query = "SELECT * FROM items WHERE item='"+item+"'";
		int price=0;
		ResultSet rs = readFromDatabase(query);
		try {
			if(rs.next()){
				 price = rs.getInt("price");}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return price;
	
	}



	public int getatk(String username){
		String atk = "SELECT attack FROM players WHERE username='"+username+"'";
		ResultSet rs = readFromDatabase(atk);
		try {
			if(rs.next())
				return rs.getInt("attack");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getdefense(String username){
		String defense = "SELECT defense FROM players WHERE username='"+username+"'";
		ResultSet rs = readFromDatabase(defense);
		try {
			if(rs.next())
				return rs.getInt("defense");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getspeed(String username){
		String speed = "SELECT speed FROM players WHERE username='"+username+"'";
		ResultSet rs = readFromDatabase(speed);
		try {
			if(rs.next())
				return rs.getInt("speed");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int gethp(String username){
		String hp = "SELECT hp FROM players WHERE username='"+username+"'";
		ResultSet rs = readFromDatabase(hp);
		try {
			if(rs.next())
				return rs.getInt("hp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int getexp(String username){
		String exp = "SELECT exp FROM players WHERE username='"+username+"'";
		ResultSet rs = readFromDatabase(exp);
		try {
			if(rs.next())
				return rs.getInt("exp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
	


}
