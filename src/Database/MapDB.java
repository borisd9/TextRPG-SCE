package Database;


import java.sql.ResultSet;
import java.sql.SQLException;


public class MapDB extends DbConnectionAPI {
	
	private String location, x, y, up, down, right, left, ac1, ac2, ac3, ac4; 
	private String[] actions = new String[4];

	//constructor
	public MapDB(){
		super();
	}
	
	public void update() {
		String query = "SELECT * FROM map ";
		try {
			ResultSet rs = readFromDatabase(query);
			if(rs.next()){
				location = rs.getString("location");
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
	 * @return the location
	 */
	public String getLocation() {
		return location;
	}


	/**
	 * @return the x
	 */
	public String getx() {
		return x;
	}
	

	/**
	 * @return the y
	 */
	public String gety() {
		return y;
	}

	
	/**
	 * @return the up
	 */
	public String getUp() {
		return up;
	}
	
	/**
	 * @return the down
	 */
	public String getDown() {
		return down;
	}

	/**
	 * @return the right
	 */
	public String getRight() {
		return right;
	}
	
	/**
	 * @return the left
	 */
	public String getLeft() {
		return left;
	}

	
	/**
	 * @return an array of actions, max of 4 actions
	 */
	public String[] actions() {
		return actions;
	}

	
	
}



