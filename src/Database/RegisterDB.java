package Database;


import java.sql.ResultSet;
import java.sql.SQLException;


public class RegisterDB extends DbConnectionAPI {

	//constructor
	public RegisterDB(){
		super();
	}
	
	
	
	public boolean insert(String username, String password, String email){
		String query = "INSERT INTO users (username, password, email, rank, activated) VALUES ('"+username+"','"+password+"','"+email+"', 0, 0)";

		return modifyDatabase(query);
	}
	
	public boolean insert(String username, String code){
		String query = "INSERT INTO authentication (username, code) VALUES ('"+username+"','"+code+"')";
		
		return modifyDatabase(query);
	}

	
}



