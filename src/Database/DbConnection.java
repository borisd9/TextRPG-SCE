package Database;


import java.sql.ResultSet;
import java.sql.SQLException;


public class DbConnection extends DbConnectionAPI {

	//constructor
	public DbConnection(){
		super();
	}
	
	public boolean doesExist(String userName, String password)
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
	
	public String doesExit2(String code) {
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
	
	public boolean insert(String username, String password, String email){
		String query = "INSERT INTO users (username, password, email, rank, activated) VALUES ('"+username+"','"+password+"','"+email+"', 0, 0)";

		return modifyDatabase(query);
	}
	
	public boolean insert(String username, String code){
		String query = "INSERT INTO authentication (username, code) VALUES ('"+username+"','"+code+"')";
		
		return modifyDatabase(query);
	}
	
	public boolean activate(String username){
		String query1 = "DELETE FROM authentication WHERE username='" + username + "'";
		String query2 = "UPDATE users SET activated=1 WHERE username='" + username + "'";
		
		return modifyDatabase(query1) && modifyDatabase(query2);
	}
	
	
}



