package Store;
 
import java.util.ArrayList;
 
/**
 * Shopping Cart implementation class ,the cart represented as ArrayList
 *  use functions like add,remove,update items in cart
 *  calculate total order price in cart
 */
public class Cart {
 private ArrayList<Items> CartItems ;
 private double TotalOrder ;
  
 
 public Cart()
 {
	 CartItems = new ArrayList<Items>();
 }
 
 /**
  * function to return  number of items that in cart  */
 public int getLineItemCount() {
  return CartItems.size();
 }
  
 
 /**
  * 
  * function to delete items from cart,
  * and calculate total price in cart 
  */
 public void deleteCartItem(String strItemIndex) {
  int iItemIndex = 0;
  try {
   iItemIndex = Integer.parseInt(strItemIndex);
   CartItems.remove(iItemIndex - 1);
   calculateOrderTotal();
  } catch(NumberFormatException nfe) {
   System.out.println("Error while deleting cart item: "+nfe.getMessage());
   nfe.printStackTrace();
  }
 }
  
 
 /**
  * 
  * function to update items from cart,
  * and calculate total price in cart according to items price and quantity 
  */
 public void updateCartItem(String strItemIndex, String strQuantity) {
  double dblTotalCost = 0.0;
  double dblUnitCost = 0.0;
  int iQuantity = 0;
  int iItemIndex = 0;
  Items cartItem = null;
  try {
   iItemIndex = Integer.parseInt(strItemIndex);
   iQuantity = Integer.parseInt(strQuantity);
   if(iQuantity>0) {
    cartItem = (Items)CartItems.get(iItemIndex-1);
    dblUnitCost = cartItem.getUnitCost();
    dblTotalCost = dblUnitCost*iQuantity;
    cartItem.setQuantity(iQuantity);
    cartItem.setTotalCost(dblTotalCost);
    calculateOrderTotal();
   }
  } catch (NumberFormatException nfe) {
   System.out.println("Error while updating cart: "+nfe.getMessage());
   nfe.printStackTrace();
  }
   
 }
  
 /**
  * 
  * function to add items from cart,
  * and calculate total price in cart according to items price,quantity
  */
 public void addCartItem(String strModelNo, String strDescription,
String strUnitCost, String strQuantity) {
  double dblTotalCost = 0.0;
  double dblUnitCost = 0.0;
  int iQuantity = 0;
  Items cartItem = new Items();
  try {
   dblUnitCost = Double.parseDouble(strUnitCost);
   iQuantity = Integer.parseInt(strQuantity);
   if(iQuantity>0) {
    dblTotalCost = dblUnitCost*iQuantity;
    cartItem.setPartNumber(strModelNo);
    cartItem.setDescription(strDescription);
    cartItem.setUnitCost(dblUnitCost);
    cartItem.setQuantity(iQuantity);
    cartItem.setTotalCost(dblTotalCost);
    CartItems.add(cartItem);
    calculateOrderTotal();
   }
    
  } catch (NumberFormatException nfe) {
   System.out.println("Error while parsing from String to primitive types: "+nfe.getMessage());
   nfe.printStackTrace();
  }
 }
  
 //add item to arrayList
 public void addCartItem(Items cartItem) {
  CartItems.add(cartItem);
 }
  

  
 public ArrayList<Items> getCartItems() {
  return CartItems;
 }

 public double getOrderTotal() {
  return TotalOrder;
 }
 public void setOrderTotal(double TotalOrder) {
  this.TotalOrder = TotalOrder;
 }
  
 //calculate total price in cart
 protected void calculateOrderTotal() {
  double dblTotal = 0;
  for(int counter=0;counter<CartItems.size();counter++) {
	  Items cartItem = (Items) CartItems.get(counter);
   dblTotal+=cartItem.getTotalCost();
    
  }
  setOrderTotal(dblTotal);
 }
 
 
 //order number
 protected static int nextOrderNumber = 1231564;

/**
 * Submit the order and return a confirmation number.
 * 
 */
 public String completeOrder()  
 {
     	
         int orderNumber = 0;

//Make sure no other threads can be generating an order number.
         synchronized (this)
         {
             orderNumber = nextOrderNumber;
             nextOrderNumber = nextOrderNumber + 1;
         }
        
      // Return a confirmation number (the order number as a string in this case).
         return ""+orderNumber;
    
 }
 
}