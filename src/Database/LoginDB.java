package Database;


import java.sql.ResultSet;
import java.sql.SQLException;


public class LoginDB extends DbConnectionAPI {

	//constructor
	public LoginDB(){
		super();
	}
	
	
	public int doesExist(String userName, String password)
	{
		//Query establishment
		String query = "SELECT * FROM users WHERE username='"+userName+"' AND password='"+password+"'";		
		
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



