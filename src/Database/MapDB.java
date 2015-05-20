package Database;


import java.sql.ResultSet;
import java.sql.SQLException;


public class MapDB extends DbConnectionAPI {
	
	private String username, location, x, y, up, down, right, left; 
	private String[] actions = new String[4];
	

	//constructor
	public MapDB(){
		super();
	}
	
	/**
	 * get current map stats for a user
	 * @param username is the username to get the stats for
	 */
	public void update(String username) {
		this.username = username;
		String query1 = "SELECT location FROM players WHERE username='" + username + "'";
		String query2 = "SELECT * FROM map WHERE location='";
		try {
			//find user current location
			ResultSet rs = readFromDatabase(query1);
			if(rs.next()){
				location = rs.getString("location");
				query2 += location + "'";
				
				rs.close();
				
				//find user options from current location
				rs = readFromDatabase(query2);
				rs.next();
				
				x = rs.getString("x");
				y = rs.getString("y");
				up = rs.getString("up");
				down = rs.getString("down");
				right = rs.getString("right");
				left = rs.getString("left");
				actions[0] = rs.getString("act1");
				actions[1] = rs.getString("act2");
				actions[2] = rs.getString("act3");
				actions[3] = rs.getString("act4");					
			}
		} catch (SQLException e) {
			System.out.println("Error in map query: "+e);
		}		
	}
	
	
	/**
	 * moves the current user to a new location
	 * @param moveTo the new location
	 * @return true if success
	 */
	public boolean move(String moveTo)
	{	
		String query1 = "SELECT * FROM map WHERE location='" + moveTo + "'";
		String query2 = "UPDATE players SET location='" + moveTo + "WHERE username='" + username + "'";
			
		//check if moveTo parameter exists in map table
		try {			
			ResultSet rs = readFromDatabase(query1);	
			if(rs.next())
				return modifyDatabase(query2);		
				
		} catch (SQLException e) {
			System.out.println("Error in map moveTo query: "+e);
		}		
		return false;
		

	}
	

	/**
	 * get the location of the user
	 * @return string of the location
	 */
	public String getLocation() {
		return location;
	}


	/**
	 * get the x coordinates of the user - for map
	 * @return string of the x
	 */
	public String getx() {
		return x;
	}
	

	/**
	 * get the y coordinates of the user - for map
	 * @return string of the y
	 */
	public String gety() {
		return y;
	}

	
	/**
	 * get the up direction info
	 * @return string of the up direction
	 */
	public String getUp() {
		return up;
	}
	
	/**
	 * get the down direction info
	 * @return string of the down direction
	 */
	public String getDown() {
		return down;
	}

	/**
	 * get the right direction info
	 * @return string of the right direction
	 */
	public String getRight() {
		return right;
	}
	
	/**
	 * get the left direction info
	 * @return string of the left direction
	 */
	public String getLeft() {
		return left;
	}

	
	/**
	 * get the actions possible to be made at this location
	 * @return an array of string which contains the actions, max of 4 actions
	 */
	public String[] actions() {
		return actions;
	}

	
	
}



