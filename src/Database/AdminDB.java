package Database;

import java.sql.ResultSet;
//import java.sql.SQLException;

public class AdminDB extends DbConnectionAPI {

	//DbConnectionAPI db;
	
	public AdminDB(){
		super();
	}
	
	public ResultSet Search(String username){
		ResultSet rs = null; 
		//Query establishment
		String query = "SELECT * FROM users WHERE username='"+username+"'";
		//try{
			rs = readFromDatabase(query);
		//}catch ()
		
		
		return rs;
	
	}
	
	public boolean Update_To_Normal(String username){
		//System.out.println(username);
		String query = "UPDATE users SET rank=0 WHERE username='"+username+"'";
		return modifyDatabase(query);
	}
	
	public boolean Update_To_Moderator(String username){
		//System.out.println(username);
		String query = "UPDATE users SET rank=1 WHERE username='"+username+"'";
		return modifyDatabase(query);
	}
	
	public boolean Update_To_ban(String username){
		//System.out.println(username);
		String query = "UPDATE users SET ban=1 WHERE username='"+username+"'";
		return modifyDatabase(query);
	}
	
	public boolean Update_To_unban(String username){
		//System.out.println(username);
		String query = "UPDATE users SET ban=0 WHERE username='"+username+"'";
		return modifyDatabase(query);
	}
	
	
}
