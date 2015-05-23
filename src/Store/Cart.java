package Store;
 
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Database.DbConnectionAPI;
 
/**
 * Shopping Cart implementation class ,the cart represented as ArrayList
 *  use functions like add,remove,update items in cart
 *  calculate total order price in cart
 */
public class Cart {
 private ArrayList<Items> CartItems ;
 private int orderTotal ;
 private int TotalPrice;
 private int iprice;
 private int quantity;
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
  * and calculate total price of coins in cart 
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
  * and calculate total coins in cart according to coins price and quantity 
  */
 public void updateCartItem(String strItemIndex, String strQuantity) {
  int total = 0;
  int price=0;
  int totalPrice=0;
  int coins = 0;
  int iQuantity = 0;
  int iItemIndex = 0;
  Items cartItem = null;
  try {
   iItemIndex = Integer.parseInt(strItemIndex);
   iQuantity = Integer.parseInt(strQuantity);
   if(iQuantity>0) {
    cartItem = (Items)CartItems.get(iItemIndex-1);
    coins = cartItem.getUnitCoin();
    total = coins*iQuantity;
    price=cartItem.getPrice();
    totalPrice=price*iQuantity;
    cartItem.setQuantity(iQuantity);
    cartItem.setTotalCost(total,totalPrice);
    calculateOrderTotal();
   }
  } catch (NumberFormatException nfe) {
   System.out.println("Error while updating cart: "+nfe.getMessage());
   nfe.printStackTrace();
  }
   
 }
  public void SetPrice(String price){
	  
	   iprice=Integer.parseInt(price);
  }
 public int getPrice()
 {
	 return iprice;
 }
 

 
 public int getQuantity(){
	 return quantity;
 }
 
 public void SetQuantity(String strQuantity){
	 this.quantity=Integer.parseInt(strQuantity);
 }
 /**
  * 
  * function to add coins to cart,
  * and calculate total price in cart according to coins price,quantity
  */
 public void addCartItem(String price, String strDescription,
String coin, String strQuantity) {
  int TotalCoins = 0;
  int totalPrice=0;
  int iprice=0;
  int coins = 0;
  int iQuantity = 0;
  Items cartItem = new Items();
  try {
	  coins = Integer.parseInt(coin);
   iQuantity = Integer.parseInt(strQuantity);
	iprice=Integer.parseInt(price);   

   if(iQuantity>0) {
	   TotalCoins = coins*iQuantity;
	   totalPrice= iprice*iQuantity;
    cartItem.setPrice(iprice);
    
    cartItem.setDescription(strDescription);
    cartItem.setUnitCost(coins);
    cartItem.setQuantity(iQuantity);
    cartItem.setTotalCost(TotalCoins,totalPrice);
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

 public int getOrderTotal() {
  return orderTotal;
 }
 
 public int getTotalPrice() {
	  return this.TotalPrice;
	 }
 public void setOrderTotal(int TotalOrder,int totalPrice) {
  this.orderTotal = TotalOrder;
  this.TotalPrice=totalPrice;
 }
  
 //calculate total price in cart
 public int calculateOrderTotal() {
  int TotalCoins = 0,Totalprice=0;
  for(int counter=0;counter<CartItems.size();counter++) {
	  Items cartItem = (Items) CartItems.get(counter);
	  TotalCoins+=cartItem.getTotalCoins();
   Totalprice+=cartItem.getTotalPrice();
   //System.out.println(Total);
  // System.out.println(Totalprice);

    
  }
  setOrderTotal(TotalCoins,Totalprice);

  return TotalPrice;

 }
 
 
 DbConnectionAPI db=new DbConnectionAPI();

 /**
  * 
  * @param username
  * @updated player money in the game according to his purchase 
  */
 public boolean updatePlayerMoney(String username)
 {
	 
	 int money = 0;
	int orderMoney=0;

	String query=  "SELECT * FROM players WHERE username='"+username+"'";
	ResultSet rs= db.readFromDatabase(query);
	 try {
		while(rs.next()){
			  money=rs.getInt("money");
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	  for(int i=0;i<CartItems.size();i++) {
		  Items cartItem = (Items) CartItems.get(i);
		  orderMoney+=cartItem.getTotalPrice();
	 
	  }
	  money=money-orderMoney;

	  String qr="UPDATE players SET money='"+money+"'WHERE username='"+username+"'";	  
	  return db.modifyDatabase(qr);
 }
 
 
 /**
  * 
  * @param username
  * @updated player coins in the game according to his purchase 
  */
 public boolean updatePlayerCoins(String username)
 {
	 int coins = 0;
	 int TotalCoins = 0;

	String query=  "SELECT * FROM players WHERE username='"+username+"'";
	ResultSet rs= db.readFromDatabase(query);
	 try {
		while(rs.next()){
			  coins=rs.getInt("cash");
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	  for(int i=0;i<CartItems.size();i++) {
		  Items cartItem = (Items) CartItems.get(i);
		  TotalCoins+=cartItem.getTotalCoins();
	 
	  }

	  coins=coins+TotalCoins;

	  String qr="UPDATE players SET cash='"+coins+"'WHERE username='"+username+"'";	  
	  return db.modifyDatabase(qr);
 }
 
 
 
 
 
}