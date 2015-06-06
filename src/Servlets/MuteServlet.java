package Servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Database.MuteDB;
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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		MuteDB mdb = new MuteDB();
		
		response.setContentType("text/plain");  
	    response.setCharacterEncoding("UTF-8");
	    
		if(action.equals("addMutee")){
			String mutee = request.getParameter("mutee");			
			String muter = request.getParameter("muter");
			int mutee_rank = mdb.getRank(mutee);
			int muter_rank = mdb.getRank(muter);
			
			if(muter_rank < 1)
				response.getWriter().write("bad rank");
			else if(mutee_rank > muter_rank)
				response.getWriter().write("low rank");
			else{
				if(!mList.addToList(mutee))
					response.getWriter().write("exists");
				else response.getWriter().write("ok");
			}	
		}
		
		if(action.equals("removeMutee")){
			String mutee = request.getParameter("mutee");			
			String muter = request.getParameter("muter");
			
			if(mdb.getRank(muter) < 1)
				response.getWriter().write("bad rank");
			else{
				if(!mList.removeFromList(mutee))
					response.getWriter().write("exists");
				else response.getWriter().write("ok");
			}
		}
		
		if(action.equals("getList")){
			ArrayList<String> muted_list = mList.getList();
			String json = new Gson().toJson(muted_list);
		    response.getWriter().write(json);
		}
		;
	}

}
