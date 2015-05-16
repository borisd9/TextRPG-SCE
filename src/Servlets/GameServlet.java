package Servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GameServlet
 */
@WebServlet("/GameServlet")
public class GameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	String contextPath;

	/**
     * @see HttpServlet#HttpServlet()
     */
    public GameServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		contextPath = request.getContextPath();
		response.sendRedirect(contextPath + "/game_console.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String msg = request.getParameter("msg");
		System.out.println(msg);
		
		if(msg == "/start"){}
		else
			request.setAttribute("line", "<font color=red>Error: '"+msg+"' is not a valid command.<br>Type /cmd to see the available commands.");
		//RequestDispatcher dispatcher = request.getRequestDispatcher("/game_console.jsp");
		//dispatcher.forward(request, response);
		response.sendRedirect("/text-rpg/game_console.jsp");
	}

}
