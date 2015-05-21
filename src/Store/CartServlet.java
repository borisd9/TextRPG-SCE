package Store;
 
import Store.Cart;
 

import java.io.IOException;
 

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class CartServlet extends HttpServlet {
  
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Servlet implementation class CartServlet
	 *  connects to shoppingcart.jsp and do all actions like add item to cart,delete,update
	 */
  
 public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
 
  String strAction = request.getParameter("action");
   
   
  if(strAction!=null && !strAction.equals("")) {
   if(strAction.equals("add")) {
    addToCart(request);
   } else if (strAction.equals("Update")) {
    updateCart(request);
   } else if (strAction.equals("Delete")) {
    deleteCart(request);
   }
  }
  response.sendRedirect("../ShoppingCart.jsp");
 }
  
 protected void deleteCart(HttpServletRequest request) {
  HttpSession session = request.getSession();
  String strItemIndex = request.getParameter("itemIndex");
  Cart cart = null;
   
  Object objCartBean = session.getAttribute("cart");
  if(objCartBean!=null) {
	  cart = (Cart) objCartBean ;
  } else {
	  cart = new Cart();
  }
  cart.deleteCartItem(strItemIndex);
 }
  
 protected void updateCart(HttpServletRequest request) {
  HttpSession session = request.getSession();
  String strQuantity = request.getParameter("quantity");
  String strItemIndex = request.getParameter("itemIndex");
  
  Cart cart = null;
   
  Object objCartBean = session.getAttribute("cart");
  if(objCartBean!=null) {
	  cart = (Cart) objCartBean ;
  } else {
	  cart = new Cart();
  }
  cart.updateCartItem(strItemIndex, strQuantity);
 }
  
 protected void addToCart(HttpServletRequest request) {
  HttpSession session = request.getSession();
  String strModelNo = request.getParameter("modelNo");
  String strDescription = request.getParameter("description");
  String strPrice = request.getParameter("price");
  String strQuantity = request.getParameter("quantity");
   
  Cart cartBean = null;
   
  Object objCartBean = session.getAttribute("cart");
 
  if(objCartBean!=null) {
   cartBean = (Cart) objCartBean ;
  } else {
   cartBean = new Cart();
   session.setAttribute("cart", cartBean);
  }
   
  cartBean.addCartItem(strModelNo, strDescription, strPrice, strQuantity);
 }
 

 
}