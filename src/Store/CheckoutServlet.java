package Store;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CheckoutServlet
 * connects to checkout.jsp that secured over SSL ,and takes player credit payment details.
 */
@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String contextPath;
	public void doPost(HttpServletRequest request,
        HttpServletResponse response)
        throws IOException, ServletException
    {




        HttpSession session = request.getSession();
        
        //get all credit details from user ,from HTTPS(SSL) page checkout.jsp
        String nameOnCard = request.getParameter("nameOnCard");
        String creditCardNumber = request.getParameter("creditCardNumber");
		String creditCardExpiration = request.getParameter("creditCardExpiration");
         contextPath= request.getContextPath();
       //If fields are empty - display error
 		if(creditCardExpiration=="" || creditCardNumber=="" || nameOnCard==""){
 			response.sendRedirect(contextPath + "/Checkout.jsp?err=1");
 		}//if credit card number invalid display error
 		else if(isValidCC(creditCardNumber)==false)
 			response.sendRedirect(contextPath + "/Checkout.jsp?err=2");
 		
 		//if credit card expire date invalid- display error
 		else if(validateCardExpiryDate(creditCardExpiration)==false)
 			response.sendRedirect(contextPath + "/Checkout.jsp?err=3");

 		
        PrintWriter out = response.getWriter();
	  	String user = (String)session.getAttribute("username");
        Cart cart =(Cart) session.getAttribute("cart");
	    //String coins = (String)session.getAttribute("coins");

 		//send confirmation order number
        try
        {
            	if(cart.getCartItems().size()!=0)
            	{
            	  cart.updatePlayerCoins(user);	
      	    	  response.sendRedirect(contextPath + "/Checkout.jsp?ok=1");
            	}
        }
        catch (Exception exc)
        {

            out.println("<html><body><font size='3' color='red'> <h1>Error!!</h1>");
            out.println("The following error occurred while "+
                "processing your order: your shopping cart is empty");
            
            out.println("</font></body></html>");
            return;
        }
    }
	
	
	/** doGet calls doPost. Servlets that are
	   *  redirected to through SSL must have doGet.
	   */
	  
	  public void doGet(HttpServletRequest request,
	                    HttpServletResponse response)
	      throws ServletException, IOException {
	    doPost(request, response);
	  }
	  
	  
	  
	  
	  
	  /**
	   * 
	   * validation functions
	   */
	  //function validation for credit card number
	   boolean isValidCC(String number) {

		   try {
			   number = number.replaceAll("\\D", "");
	            char[]      ccNumberArry    = number.toCharArray();

	            int         checkSum        = 0;
	            for(int i = ccNumberArry.length - 1; i >= 0; i--){

	                char            ccDigit     = ccNumberArry[i];

	                if((ccNumberArry.length - i) % 2 == 0){
	                    int doubleddDigit = Character.getNumericValue(ccDigit) * 2;
	                    checkSum    += (doubleddDigit % 9 == 0 && doubleddDigit != 0) ? 9 : doubleddDigit % 9;

	                }else{
	                    checkSum    += Character.getNumericValue(ccDigit);
	                }

	            }

	            return (checkSum != 0 && checkSum % 10 == 0);

	        } catch (Exception e) {

	            e.printStackTrace();

	        }

	        return false;
}
	   
	   //function validation for expire date of creditCard
	   boolean validateCardExpiryDate(String expiryDate) {
		    return expiryDate.matches("(?:0[1-9]|1[0-2])/[0-9]{2}");
		}
	   
}