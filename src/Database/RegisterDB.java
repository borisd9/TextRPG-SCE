package Database;


public class RegisterDB extends DbConnectionAPI {

	/**
	 * Constructor
	 */
	public RegisterDB(){
		super();
	}
	
	
	/**
	 * Inserts user into Users DB
	 * @param username
	 * @param password
	 * @param email
	 * @return true upon success
	 */
	public boolean insert(String username, String password, String email){
		String query = "INSERT INTO users (username, password, email, rank, activated) VALUES ('"+username+"','"+password+"','"+email+"', 0, 0)";

		return modifyDatabase(query);
	}
	
	/**
	 * Inserts user into 'pending authorization' DB
	 * @param username
	 * @param code
	 * @return true upon success
	 */
	public boolean insert(String username, String code){
		String query = "INSERT INTO authentication (username, code) VALUES ('"+username+"','"+code+"')";
		
		return modifyDatabase(query);
	}

	
}



