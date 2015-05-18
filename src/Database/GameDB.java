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
		
		ResultSet rs = readFromDatabase(query1);
		
		try {
			if(rs.next()){
				int attack = rs.getInt("attack");
				int defense = rs.getInt("defense");
				int hp = rs.getInt("hp");
				int speed = rs.getInt("speed");
				
				String query2 = "INSERT INTO players VALUES ('"+username+"',Home,'"+charName+"',1,'"+attack+"','"+defense+"','"+speed+"','"+hp+"',0,0,0,None,0,0)";
				
				return modifyDatabase(query2);
			}
		} catch (SQLException e) {
			System.out.println("Error in add player query: "+e);
		}
		
		return false;
	}
}
