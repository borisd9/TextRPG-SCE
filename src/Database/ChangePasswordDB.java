package Database;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ChangePasswordDB extends DbConnectionAPI{

	public ChangePasswordDB(){
		super();
	}
	
	public Boolean doesExist(String userName, String password)
	{
		//Query establishment
		String query = "SELECT * FROM users WHERE username='"+userName+"' AND password='"+password+"'";		
		
		try {			
			ResultSet rs = readFromDatabase(query);	
			if(rs.next())
				return true;
		} catch (SQLException e) {
			System.out.println("Error in does exists query: "+e);
		}		
		return false;
	}
	
	public boolean UpdatePassword(String username,String Password){
		//System.out.println(username);
		String query = "UPDATE users SET password='"+Password+"' WHERE username='"+username+"'";
		return modifyDatabase(query);
	}
}
