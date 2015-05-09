package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.StyledEditorKit.BoldAction;

//import java.util.ArrayList;

import com.mysql.fabric.xmlrpc.base.Data;


import Database.DbConnectionAPI;


/**
 * Servlet implementation class Admin_Panel_Servlet
 */
@WebServlet("/Admin_Panel_Servlet")
public class Admin_Panel_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	DbConnectionAPI db;
	
	public Admin_Panel_Servlet() {
        super();
        
        //connect to DB
        db = new DbConnectionAPI();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//String dataArray[] = getDataArray();
		//request.setAttribute("dataArray",dataArray);
		//request.getRequestDispatcher("/admin_panel.jsp").forward(request,response);	
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String submitAction= request.getParameter("submitAction");
			
					
		
			if (submitAction != null) 
			{
				if (submitAction.equals("Search")){
	            	Search(request, response);
	            }
			}
		
	}

//	protected String[] getDataArray(){
//		ResultSet rs = null; 
//		String query = "SELECT username FROM users";
//		
//		rs = db.readFromDatabase(query);
//		String[] arr = null;
//		
//		try {
//			ArrayList<String> list = new ArrayList<String>();
//			if (rs.next()){
//			    do{
//			    	//list.add(rs.getString("username"));
//			    	System.out.print(list.add(rs.getString("username")));
//			    }while(rs.next());
//			    arr = list.toArray(new String[list.size()]);
//			    
//			}
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return arr;
//	}
	
	
	protected void Search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException	
	{
		//String dataArray[] = getDataArray();
		//request.setAttribute("dataArray",dataArray);
		
		Boolean flag=true;
		String radio=request.getParameter("Search_radio");
		String usernamebox= request.getParameter("Search");
		String list= request.getParameter("userlist");
		String username=null;
		ResultSet rs = null; 
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin_panel.jsp");
	    PrintWriter out= response.getWriter();
		
		    
		if(radio.equals("box_radio"))
			if(usernamebox!="")
				username=usernamebox;
			else {
				out.println("<font color=red>You must enter a username.</font>");
			    rd.include(request, response);
			    flag=false;
			}
			
			else if(radio.equals("dropdown_radio"))
				if(list!="")
					username=list;
				else {
					out.println("<font color=red>You must choose a username.</font>");
				    rd.include(request, response);
				    flag=false;
				}
					
		
		if(flag){
			String query = "SELECT * FROM users WHERE username='"+username+"'";
			rs = db.readFromDatabase(query);
			try {
				if(rs.next()){
					request.setAttribute("user",rs.getString("username"));
					request.setAttribute("pwd",rs.getString("password"));
					request.setAttribute("email",rs.getString("Email"));
					request.setAttribute("rank",rs.getString("rank"));
					request.setAttribute("activated",rs.getString("activated"));
					
					request.getRequestDispatcher("/admin_panel.jsp").forward(request, response);
					
				}else {
					
				    out.println("<font color=red>User name doesn't exist.</font>");
				    //rd.include(request, response);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
}
