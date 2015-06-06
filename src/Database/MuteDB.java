package Database;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MuteDB extends DbConnectionAPI{
	
	public MuteDB(){
		super();
	}
	
	public int getRank(String username){
		String query = "SELECT rank FROM users WHERE username='"+username+"'";
		ResultSet rs = readFromDatabase(query);
		try {
			if(rs.next())
				return rs.getInt("rank");
		}catch (SQLException e) {
			System.out.println("Error in muteDB - getRank query: "+e);
		}		
		
		return -1;
	}
}
