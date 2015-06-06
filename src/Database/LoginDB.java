package Database;


import java.sql.ResultSet;
import java.sql.SQLException;


public class LoginDB extends DbConnectionAPI {

	/**
	 * Constructor
	 */
	public LoginDB(){
		super();
	}
	
	/**
	 * Check if the given user exists in the DB
	 * @param username
	 * @param password
	 * @return 1 if the account is activated, 0 if it's not
	 */
	public int doesExist(String username, String password)
	{
		String query = "SELECT * FROM users WHERE username='"+username+"' AND password='"+password+"'";		
		
		try {			
			ResultSet rs = readFromDatabase(query);	
			if(rs.next())
				return rs.getInt("activated");
		} catch (SQLException e) {
			System.out.println("Error in LoginDB - doesExists query: "+e);
		}		
		return -1;
	}
	
	public String rank_check(String userName)
	{
		//Query establishment
		String query = "SELECT rank FROM users WHERE username='"+userName+"'";		
		try {			
			ResultSet rs = readFromDatabase(query);	
			if(rs.next())
				return Integer.toString(rs.getInt("rank"));
		} catch (SQLException e) {
			System.out.println("Error in LoginDB - rank_check query: "+e);
		}		
		return "-1";			
	}

	public boolean isBanned(String username) {
		
		//Query establishment
		String query = "SELECT ban FROM users WHERE username='"+username+"'";		
		try {			
			ResultSet rs = readFromDatabase(query);	
			if(rs.next()){
				if(rs.getInt("ban") == 1)
					return true;
				else
					return false;
			}
		} catch (SQLException e) {
			System.out.println("Error in LoginDB - isBanned query: "+e);
		}		
		return false;
	}
}



