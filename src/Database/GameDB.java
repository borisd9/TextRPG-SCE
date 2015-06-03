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


	public void updatefight(String username, int exp, int coins,int flag){
		int intcheck=0;
		int intcoins=0;
		if(flag==1){
			String query = "UPDATE players SET exp=exp+"+exp+",money=money+"+coins+" WHERE username='"+username+"'";
			modifyDatabase(query);
		}
		else{
			String check = "SELECT * FROM players WHERE username='"+username+"'";
			ResultSet rs = readFromDatabase(check);
			try {
				if(rs.next()){
					intcheck = rs.getInt("exp");
					intcoins = rs.getInt("money");
					System.out.println(intcoins);
				}
			} catch (SQLException e) {
				System.out.println("Error in add player query: "+e);
			}
			if(intcheck-exp>=0 && intcoins-coins>=0){
				String query = "UPDATE players SET exp=exp-"+exp+",money=money-"+coins+" WHERE username='"+username+"'";
				modifyDatabase(query);
			}
			else if(intcoins-coins>=0){
				String query = "UPDATE players SET money=money-"+coins+" WHERE username='"+username+"'";
				modifyDatabase(query);
			}
			else if(intcheck-exp>=0){
				String query = "UPDATE players SET exp=exp-"+exp+" WHERE username='"+username+"'";
				modifyDatabase(query);
			}
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
	
	public ResultSet getStoreItems(String username){
		
		String location=playerLocation(username);
		
		String query = "SELECT * FROM items WHERE location='"+location+"'";
		//String query = "SELECT * FROM items WHERE location='"+username+"'";
		ResultSet rs = readFromDatabase(query);
		return rs;
	}
	

	/**
	 * get items Count
	 * @param location
	 * @return number of items in database, -1 if it's empty
	 */
	public int getItemsCount(String username){
		
		String location=playerLocation(username);
		//String location=username;
		if(location!="-1")
		{
		String query = "SELECT count(*) FROM items WHERE location='"+location+"'";
		
		ResultSet rs = readFromDatabase(query);
		try {
			if(rs.next()){
				System.out.println("getItemsCount:"+rs.getString(1));
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("Error in count query: "+e);
		}
		}
		return -1;
	}
	
	/**
	 * get Money
	 * @param username
	 * @return player amount of money , -1 if it's empty
	 */
	public int getMoney(String username){
		String query = "SELECT money FROM players WHERE username='"+username+"'";
		
		ResultSet rs = readFromDatabase(query);
		try {
			if(rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("Error in getMoney query: "+e);
		}
		return -1;
	}
	
	/**
	 * update Purchase Item
	 * @param username,item,money
	 * update the amount of money of player and the item
	 */
	public void updatePurchaseItem(String username,String item,int money){
		String query = "UPDATE players SET item='"+item+"' money='"+money+"'  WHERE username='"+username+"'";
		modifyDatabase(query);
	}
	
	/**
	 * get Item Price
	 * @param item
	 * @return get the price of the item , -1 if it's empty
	 */
	public int getItemPrice(String item){
		String query = "SELECT price FROM items WHERE item='"+item+"'";
		
		ResultSet rs = readFromDatabase(query);
		try {
			if(rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("Error in getMoney query: "+e);
		}
		return -1;
	}
	
	/**
	 * player Location
	 * @param username
	 * @return get the player Location, -1 if it's empty
	 */
	public String playerLocation(String username)
	{
		String query = "SELECT location FROM players WHERE username='"+username+"'";
		
		ResultSet rs = readFromDatabase(query);
		try {
			if(rs.next()){
				System.out.println("playerLocation:"+rs.getString(1));
				return rs.getString(1);
				
			}
		} catch (SQLException e) {
			System.out.println("Error in count query: "+e);
		}
		return "-1";
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
	/*public int getItemPrice(String item){
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
	
	}*/



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
	
	//////////////////////////
	//Battle related methods//
	//////////////////////////
	
	/**
	 * update battle results
	 * @param winner
	 * @param loser
	 * @param exp
	 */
	public void updateBattleResults(String winner, String loser, float exp, String levelup) {
		String query = "UPDATE players SET loses=loses+1 WHERE username='"+loser+"'";
		modifyDatabase(query);
		query = "UPDATE players SET wins=wins+1,exp=exp+"+exp+( (levelup.equals("true")) ? ",level=level+1" : "" )+" WHERE username='"+winner+"'";
		modifyDatabase(query);
	}
	
	/**
	 * get an opponent for username
	 * @param username
	 * @return name of opponent
	 */
	public String getOpponent(String username)
	{
		String query = "SELECT username FROM players WHERE username<>'"+username+"'";
		ResultSet rs = readFromDatabase(query);
		try {
			if(rs.next())
				return rs.getString("username");
		} catch (SQLException e) {
			System.out.println("Error in get opponent query: "+e);	
		}
		return null;
	}
	
	/**
	 * get character information
	 * @param username
	 * @return relevant row from players database
	 */
	public ResultSet getCharacterInfo(String username){
		String query = "SELECT * FROM players WHERE username='"+username+"'";
		ResultSet rs = readFromDatabase(query);
		return rs;
	}
	
	/**
	 * get character attacks
	 * @param username
	 * @return relevant row from players database
	 */
	public ResultSet getCharAttacks(String character){
		String query = "SELECT atk1,atk2 FROM characters WHERE name='"+character+"'";
		ResultSet rs = readFromDatabase(query);
		return rs;
	}
}
