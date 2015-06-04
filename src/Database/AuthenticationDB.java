package Database;


import java.sql.ResultSet;
import java.sql.SQLException;


public class AuthenticationDB extends DbConnectionAPI {

	/**
	 * Constructor
	 */
	public AuthenticationDB(){
		super();
	}
	
	/**
	 * Checks is user hasn't activated their account
	 * @param code
	 * @return user name related to the given 'code'
	 */
	public String doesExit(String code) {
		String query = "SELECT * FROM authentication WHERE code='"+code+"'";
		try {
			ResultSet rs = readFromDatabase(query);
			if(rs.next())
				return rs.getString("username");
		} catch (SQLException e) {
			System.out.println("Error in doesExists2 query: "+e);
		}		
		return null;
	}
	
	/**
	 * Update account status
	 * @param username
	 * @return true upon success
	 */
	public boolean activate(String username){
		
		String query1 = "DELETE FROM authentication WHERE username='" + username + "'";
		String query2 = "UPDATE users SET activated=1 WHERE username='" + username + "'";
		
		return modifyDatabase(query1) && modifyDatabase(query2);
	}

	

	
}



