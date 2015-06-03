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
			System.out.println("Error in does exists query: "+e);
		}		
		return -1;
	}
	


	

	
	

	
	

	
	
}



