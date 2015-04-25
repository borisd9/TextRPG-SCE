package Database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.tomcat.dbcp.dbcp.BasicDataSource;



public class DbConnectionAPI {

	/**
	 * Database Connection API class, it creates a database connection to MySQL server, and allows to execute simple commands</br>
	 * <i>Variables:</i></br>
	 * <b>Connection</b> con - connection object to DB</br>
	 * <i>Methods:</i><br>
	 * <b>DbConnectionAPI() </b> - constructor of DbConnectionAPI class<br>
	 * <b>closeConnection()</b> - closes the DB connection - use this only when user logs out
	 */
	
	private static BasicDataSource ds;
	private static Connection con;
	
	
	/**
	 * Class Constructor - constructs the class and connects to the MySQL database
	 */
	public DbConnectionAPI()
	{
		ds = new BasicDataSource();
		 ds.setDriverClassName("com.mysql.jdbc.Driver");
		 ds.setUsername("root");
		 ds.setPassword("root");
		 ds.setUrl("jdbc:mysql://localhost/test");
		 try {
			con = ds.getConnection();	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Error in connecting DB: "+e);
		}	 
	}
	
	
	
	/**
	 * print stats for database - for internal testing
	 */
    public void printDataSourceStats() {
        System.out.println("NumActive: " + ds.getNumActive());
        System.out.println("NumIdle: " + ds.getNumIdle());
    }
	
	
    
	/**
	 * closes the DB connection - use this only when user logs out?
	 */
	public void closeConnection()
	{
		try {
			ds.close();
		} catch (SQLException e) {
			System.out.println("Error closing connection: " + e);
		}
	}
	
	
	
	/**
	 * read from database query function
	 */
	public ResultSet readFromDatabase(String query) {
		
		ResultSet rs = null; 	
		
		try {			
			//executeQuery- read from database
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			stmt.close();
			//this.printData(resultSet);		
		} catch (SQLException e) {		
			System.out.println("Error in query: "+e);
		}
		
		return rs;
	}
	
	

	/**
	 * insert into database query function
	 * @param query
	 */
	public int insertIntoDatabase(String query) {
		
		try {
			
			/*RETURN_GENERATED_KEYS- Flag that tells him to return the last key inserted*/
			Statement stmt = con.createStatement();
			stmt.execute(query, Statement.RETURN_GENERATED_KEYS);
			stmt.getGeneratedKeys();
			
			
			/*getGeneratedKeys- return the PKID of last inserted row*/
			ResultSet rs = stmt.getGeneratedKeys();
			
			int id = -1;
			if(rs.next()) {
				id = rs.getInt(1);
			}
			if(stmt != null)
				stmt.close();
			if(rs != null)
				rs.close();
			
			return id;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Error in query: "+e);
		}
		return -1;
	}
		
	
	
	
	public boolean doesExist(String userName, String password)
	{
		//Query establishment
		ResultSet rs = null; 
		String query = "SELECT * FROM users WHERE username='"+userName+"' AND password='"+password+"'";		
		
		rs = readFromDatabase(query);
			
		try {
			if(rs.next())
				return true;
		} catch (SQLException e) {
			System.out.println("Error in query: "+e);
		}		

		return false;
	}


	
	
}
