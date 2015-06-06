package Servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import General.MuteList;

/**
 * Servlet implementation class MuteServlet
 */
@WebServlet("/MuteServlet")
public class MuteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private MuteList mList;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MuteServlet() {
        super();
        mList = new MuteList();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		MuteList ml = new MuteList();
		String name= request.getParameter("name");
		ml.addToList(name);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if(action.equals("addMutee")){
			String mutee = request.getParameter("mutee");
			System.out.println("~~~~~~~~~~"+mutee);
			
			mList.addToList(mutee);
		}
		
		if(action.equals("getList")){
			ArrayList muted_list = mList.getList();
			String json = new Gson().toJson(muted_list);
			response.setContentType("text/plain");  
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(json);
		}
	}

}
