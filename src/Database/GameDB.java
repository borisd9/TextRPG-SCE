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
