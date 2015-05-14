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
import javax.servlet.http.HttpSession;

//import java.util.ArrayList;



import com.mysql.fabric.xmlrpc.base.Data;




import Database.AdminDB;


/**
 * Servlet implementation class Admin_Panel_Servlet
 */
@WebServlet("/Admin_Panel_Servlet")
public class Admin_Panel_Servlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	//Database handler
	AdminDB db;
	//URL path
	String contextPath;
	
	/**
	 * Constructor
	 */
	public Admin_Panel_Servlet() {
        super();
        
        //connect to DB
        db = new AdminDB();
    }
	
	/**
     * Redirect to login/jsp
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		contextPath = request.getContextPath();
		response.sendRedirect(request.getContextPath() + "/admin_panel.jsp");
	}
	
	/**
     * Handle boten request
     */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String submitAction= request.getParameter("submitAction");
		HttpSession session = request.getSession();	
		String user=(String)request.getParameter("user").toString();
		//session.setAttribute("ranks","0");
		System.out.println(user);
			if (submitAction != null) 
			{
				
				if (submitAction.equals("Search")){
	            	Search(request, response);
	            }else if(submitAction.equals("change to Normal"))
	            {
	            	
	            	if(db.Update_To_Normal(user));
	            	{
	            		request.setAttribute("user",request.getParameter("user"));
						request.setAttribute("email",request.getParameter("email"));
						request.setAttribute("activated",request.getParameter("activated"));
						
	            		request.setAttribute("rank","Normal");
	            		session.setAttribute("ranks","1");
	            		
	            		//Search(request, response);
						request.getRequestDispatcher("/admin_panel.jsp").forward(request, response);
	            		
	            	}
	            	
	            }else if(submitAction.equals("change to Moderator"))
	            {
	            	if(db.Update_To_Moderator(user))
	            	{
	            		request.setAttribute("user",request.getParameter("user"));
						request.setAttribute("email",request.getParameter("email"));
						request.setAttribute("activated",request.getParameter("activated"));
						
	            		request.setAttribute("rank","Moderator");
	            		session.setAttribute("ranks","2");
	            		//Search(request, response);
						request.getRequestDispatcher("/admin_panel.jsp").forward(request, response);
	            	}
	            }
			}
		
	}

	
	
	
	protected void Search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException	
	{
		String activated="activated";
		String not_activated="not activated";
		
		contextPath = request.getContextPath();
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
				//response.sendRedirect(contextPath + "/login.jsp?err=1");
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
					
		String not="not _activated";
		String rank="";
		HttpSession session = request.getSession();
		if(flag){
			rs = db.Search(username);
			try {
				if(rs.next()){
					request.setAttribute("user",rs.getString("username"));
					request.setAttribute("pwd",rs.getString("password"));
					request.setAttribute("email",rs.getString("Email"));
					
					if(rs.getInt("rank") == 0){
						request.setAttribute("rank","Normal");
						rank="1";
					}
					else if(rs.getInt("rank") == 1){
						request.setAttribute("rank","Moderator");
						rank="2";
					}
					else {
						request.setAttribute("rank","Admin");
						rank="3";
					}
					
					if(rs.getInt("activated") == 0)
						request.setAttribute("activated","not_activated");
					else
						request.setAttribute("activated","activated");
					
					session.setAttribute("ranks",rank);
					
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
