package Store;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BuyServlet - 
 * Buy coins from player money,without credit card purchase(without SSL)
 */
@WebServlet("/BuyServlet")
public class BuyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String contextPath;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public BuyServlet() {
        super();
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
		  HttpSession session = request.getSession();
		  Cart cartBean = null;
		   
		  Object objCartBean = session.getAttribute("cart");
		 
		  if(objCartBean!=null) {
		   cartBean = (Cart) objCartBean ;
		  } else {
		   cartBean = new Cart();
		   session.setAttribute("cart", cartBean);
		  }
		  
		  	String user = (String)session.getAttribute("username");
		  	
		 
	      contextPath= request.getContextPath();
	         
	      int quantity=0,price=0,Imoney=0;
	      quantity =cartBean.getQuantity();
	      price= cartBean.getPrice();
	      Imoney = (int) session.getAttribute("money");
	      //System.out.println(quantity);
	     // System.out.println(price);
	      //System.out.println(Imoney);

	      if(price*quantity<=Imoney ){
	    	  cartBean.updatePlayerMoney(user);
			  cartBean.updatePlayerCoins(user);	
	    	  response.sendRedirect(contextPath+"/ShoppingCart.jsp?ok=1");
	    	  
	      }
	      else
	    	  response.sendRedirect(contextPath+"/ShoppingCart.jsp?ok=2");


	}

}
