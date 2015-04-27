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
	 * <b>closeConnection()</b> - closes the DB connection - use this only when user logs out<br>
	 * <b>printData(ResultSet rs)</b> - prints data from the result set received. <br>
	 * <b>printDataSourceStats()</b> - prints num of active and idle connections - for internal testing <br>
	 * <b>readFromDatabase(String query)</b> - reads from database according to the query received, returns the Result Set. <br>
	 * <b>modifyDatabase(String query)</b> - update the database according to the query received, returns true if success.
	 **/
	
	
	private static BasicDataSource ds;
	private static Connection con;
	
	
	/**
	 * Class Constructor - constructs the class and connects to the MySQL database
	 */
	public DbConnectionAPI()
	{
		//setup database connection settings
		ds = new BasicDataSource();
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUsername("root");
		ds.setPassword("root");
		ds.setUrl("jdbc:mysql://localhost/database");
		
		//connect
		try {
			con = ds.getConnection();	
		} catch (SQLException e) {
			System.out.println("Error in connecting DB: "+e);
		}	 
	}
	
	
	
	/**
	 * print stats for database - for internal testing
	 */
    public void printDataSourceStats() {
    	//print number of active connections and idle connections
        System.out.println("NumActive: " + ds.getNumActive());
        System.out.println("NumIdle: " + ds.getNumIdle());
    }
	
	
    
	/**
	 * closes the DB connection - use this only when user logs out? 
	 */
    //not sure when to use//
    //********************//
	public void closeConnection()
	{	
		try {
			con.close();
		} catch (SQLException e) {
			System.out.println("Error closing connection: " + e);
		}
	}
	
	
	
	/**
	 * print result data from result set object
	 * @param rs - result set to print
	 */
	public void printData(ResultSet rs) {
		try {
			System.out.println("Table: " + rs.getMetaData().getTableName(1));
			
			//print column names
			for(int i=1;i<=rs.getMetaData().getColumnCount(); i++) 
				System.out.print("Column "+i+" - "+rs.getMetaData().getColumnName(i) + "  ");
			
			//print data
			while(rs.next())
				System.out.print("/n");
				for(int i=1;i<=rs.getMetaData().getColumnCount(); i++) 
					System.out.print(rs.getObject(i) + "  ");
			
		} catch (SQLException e) {
	
			e.printStackTrace();
		}
	}

	
	
	/**
	 * read from database query function, returns the result set
	 * @param query - the SQL query to execute
	 */
	public ResultSet readFromDatabase(String query) {
		
		ResultSet rs = null; 	
		
		try {			
			
			//create statement object
			Statement stmt = con.createStatement();
			
			//execute query
			rs = stmt.executeQuery(query);		
			
		} catch (SQLException e) {		
			System.out.println("Error in read query: "+e);
		}
		
		return rs;
	}
		

	/**
	 * inserts/updates/deletes from database using the query function - returns the true if successful
	 * @param query - the SQL query to execute
	 */
	public boolean modifyDatabase(String query) {
		
		try {
					
			//create statement object
			Statement stmt = con.createStatement();
			
			//execute query
			if(stmt.executeUpdate(query) == 1) 
				return true;
				
		} catch (SQLException e) {
			System.out.println("Error in modify query: "+e);
		}
			
		return false;	
		
	}
	
	
	
	
	
	
	//***********************//
	//MOVE INTO LOGIN SERVLET//
	//***********************//
	public boolean doesExist(String userName, String password)
	{
		//Query establishment
		ResultSet rs = null; 
		String query = "SELECT * FROM users WHERE username='"+userName+"' AND password='"+password+"'";		
		
		rs = readFromDatabase(query);
			
		try {
			if(rs.next()){
				printData(rs);
				return true;
			}
		} catch (SQLException e) {
			System.out.println("Error in query: "+e);
		}		
		
		return false;
	}
	
	
	
	
	
}
