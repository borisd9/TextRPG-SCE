package Servlets;

import java.io.IOException;

import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Database.DbConnectionAPI;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	DbConnectionAPI db;
	
    public LoginServlet() {
        super();
        
        //connect to db using the DB API
        db = new DbConnectionAPI();
        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("user");
		String password = request.getParameter("pwd");
		
		db.insertIntoDatabase("INSERT INTO users VALUES ('r','r')");
		
		if(db.doesExist(username, password))
		{
			response.sendRedirect(request.getContextPath()+"/LoginSuccess.jsp");			
		}
		else{
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/Login.jsp");
            PrintWriter out= response.getWriter();
            out.println("<font color=red>Either user name or password is wrong.</font>");
            rd.include(request, response);      
        }
		
		//print DB connection stats
		
		//db.printDataSourceStats();
		
	}

}
