package Database;


import java.sql.ResultSet;
import java.sql.SQLException;


public class MapDB extends DbConnectionAPI {
	
	public String location;
	public String x;
	public String y;
	
	
	//constructor
	public MapDB(){
		super();
	}
	
	public void test() {
		String query = "SELECT * FROM map ";
		try {
			ResultSet rs = readFromDatabase(query);
			if(rs.next()){
				location = rs.getString("location");
				x = rs.getString("x");
				y = rs.getString("y");
			}
		} catch (SQLException e) {
			System.out.println("Error in doesExists2 query: "+e);
		}		
	}
	


	
	
}



