package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import java.util.ArrayList;
import Database.AdminDB;


/**
 * Servlet implementation class Admin_Panel_Servlet
 */
@WebServlet("/Admin_Panel_Servlet")
public class Admin_Panel_Servlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	//Database handler
	AdminDB db;
	boolean flag_userlist=false;
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
		String userlist= request.getParameter("userlist");
		
		
		
		if(!userlist.equals("-1")){
			flag_userlist=true;
			Search(request, response);
		}
		else if (submitAction != null) 
		{
			if (submitAction.equals("Search")){
            	Search(request, response);

            }

			if(submitAction.equals("change to Normal"))

            {
            	
            	if(db.Update_To_Normal(user));
            	{
            		request.setAttribute("user",request.getParameter("user"));
					request.setAttribute("email",request.getParameter("email"));
					request.setAttribute("activated",request.getParameter("activated"));
					session.setAttribute("ban",request.getParameter("ban"));
            		request.setAttribute("rank","Normal");
            		session.setAttribute("ranks","1");
					request.getRequestDispatcher("/admin_panel.jsp").forward(request, response);
            		
            	}
            	

            }
			
			if(submitAction.equals("change to Moderator"))

            {
            	if(db.Update_To_Moderator(user))
            	{
            		request.setAttribute("user",request.getParameter("user"));
					request.setAttribute("email",request.getParameter("email"));
					request.setAttribute("activated",request.getParameter("activated"));
					session.setAttribute("ban",request.getParameter("ban"));
            		request.setAttribute("rank","Moderator");
            		session.setAttribute("ranks","2");
					request.getRequestDispatcher("/admin_panel.jsp").forward(request, response);
            	}
            }else	if(submitAction.equals("ban user")){
            	if(db.Update_To_ban(user))
            	{
					request.setAttribute("user",request.getParameter("user"));
					request.setAttribute("email",request.getParameter("email"));
					request.setAttribute("activated",request.getParameter("activated"));
					session.setAttribute("ban","1");
		    		request.setAttribute("rank","Moderator");
		    		session.setAttribute("ranks","2");
					request.getRequestDispatcher("/admin_panel.jsp").forward(request, response);
            	}
			}else if(submitAction.equals("unban user")){
				if(db.Update_To_unban(user))
            	{
					request.setAttribute("user",request.getParameter("user"));
					request.setAttribute("email",request.getParameter("email"));
					request.setAttribute("activated",request.getParameter("activated"));
					session.setAttribute("ban","0");
		    		request.setAttribute("rank","Moderator");
		    		session.setAttribute("ranks","2");
					request.getRequestDispatcher("/admin_panel.jsp").forward(request, response);
            	}
			}
		}else 
			request.getRequestDispatcher("/admin_panel.jsp").forward(request, response);
	}

	
	protected void Search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException	
	{
		contextPath = request.getContextPath();
		Boolean flag=true;
		String usernamebox= request.getParameter("Search");
		String list= request.getParameter("userlist");
		String username=null;
		ResultSet rs = null; 
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin_panel.jsp");
	    PrintWriter out= response.getWriter();
	    
		if(!flag_userlist)
			if(usernamebox!="")
				username=usernamebox;
			else {
				response.sendRedirect(contextPath + "/admin_panel.jsp?err=1");
			    rd.include(request, response);
			    flag=false;
			}
			
		else if(list!=""){
			username=list;
			flag_userlist=false;
		}
					
		String rank="";
		HttpSession session = request.getSession();
		if(flag){
			rs = db.Search(username);
			try {
				if(rs.next()){
					request.setAttribute("user",rs.getString("username"));
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
					if(rs.getInt("ban") == 1)
						session.setAttribute("ban","1");
					else
						session.setAttribute("ban","0");
					
					session.setAttribute("ranks",rank);
					flag_userlist=false;
					request.getRequestDispatcher("/admin_panel.jsp").forward(request, response);
					
				}else {
				    response.sendRedirect(contextPath + "/admin_panel.jsp?err=2");
				    rd.include(request, response);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
