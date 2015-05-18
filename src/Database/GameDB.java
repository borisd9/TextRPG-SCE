package Database;

import java.sql.ResultSet;
import java.sql.SQLException;

public class GameDB extends DbConnectionAPI
{
	
	public GameDB(){
		super();
	}
	
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
	
	public ResultSet getChars(){
		String query = "SELECT name FROM characters";
		
		ResultSet rs = readFromDatabase(query);	
		return rs;		
		//return null;
	}
	
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

	public boolean addPlayer(String username, String charName){
		String query1 = "SELECT * FROM characters WHERE name='"+charName+"'";
		int attack, defense, hp, speed;
		
		ResultSet rs = readFromDatabase(query1);
		
		try {
			if(rs.next()){
				attack = rs.getInt("attack");
				defense = rs.getInt("defense");
				hp = rs.getInt("hp");
				speed = rs.getInt("speed");
			}
		} catch (SQLException e) {
			System.out.println("Error in add player query: "+e);
		}
	
		
		//String query = "INSERT INTO players VALUES ('"+username+"',Home,)";
		
		return true;
	}
}
