package Database;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BattleDB extends DbConnectionAPI {
	
	/**
	 * GameDB constructor
	 */
	public BattleDB(){
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
