<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Shopping Cart</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="styles.css" rel="stylesheet" type="text/css" />


</head>

<body>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ page import="Store.*" %>
<%@ page import="Database.*" %>
<%@ page language="java" import="java.sql.*" %>

 <div id="main">
  <div id="header"> 
    <div id="buttons">
      <ul>
   		<li class="first">
        <li><a href="home.jsp">Home</a></li>
        <li><a href="login.jsp">Login</a></li>
        <li><a href="view_game.jsp">View Game</a></li>
        <li><a href="guide.jsp" >Game Guide</a></li>
        <li><a href="store.jsp" >Store</a></li>
        <li><a href="about.jsp">About Us</a></li>
        <li><a href="contact.jsp">Contact Us</a></li>
        
      </ul>
    </div>
  </div>
  <div id="content">
        <div align="center">
     
      <center><h1>Please,This is your Shopping Cart</h1></center>
      <br/><%  DbConnectionAPI db=new DbConnectionAPI();
	      int money = 0,coins=0;
	    String username = (String)session.getAttribute("username");

		String query=  "SELECT * FROM players WHERE username='"+username+"'";
		ResultSet rs= db.readFromDatabase(query);
		 try {
			while(rs.next()){
				  money=rs.getInt("money");
				  coins=rs.getInt("cash");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 session.setAttribute("money", money);
		 
      	
%>
            Money you have:	<%=money %>$<br>
            Coins you have:<%=coins %><br>
        
<a href="enterStore.jsp" >Back to Store</a> 
<table width="75%" border="1">
  <tr bgcolor="#CCCCCC"> 
    <td><strong><font size="2" >Item 
      Description</font></strong></td>
    <td><strong><font size="2" >Price</font></strong></td>
      
    <td><strong><font size="2" >Quantity</font></strong></td>
   
    <td><strong><font size="2" >Total </font></strong></td>
  </tr>
  <jsp:useBean id="cart" scope="session" class="Store.Cart" />
  <c:if test="${cart.lineItemCount==0}">
  <tr>
  <td colspan="4"><font size="2" >- Cart is currently empty -<br/>
  </tr>
  </c:if>
  
  <c:forEach var="cartItem" items="${cart.cartItems}" varStatus="counter"> 
  <form name="item" method="POST" action="servlet/CartServlet">
  <tr> 
        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif" ><b><c:out value="${cartItem.itemDescription}"/></font></td></b><br/>
    <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif" ><b><c:out value="${cartItem.price}"/>$</b><br/>
    <td><font size="2" >
    <input type='hidden' name='itemIndex' value='<c:out value="${counter.count}"/>'><input type='text' name="quantity" value='<c:out value="${cartItem.quantity}"/>' size='2'> 
 <br/>    <input type="submit" name="action" value="Update">     <input type="submit" name="action" value="Delete"></font></td>
    <td><font size="2" ><c:out value="${cartItem.totalCoins}"/></font></td>
  </tr>
  </form>
  </c:forEach> 
  <tr> 
    <td colspan="2"> </td>
    <td> </td>
    <td><font size="2" >Subtotal:<br>Coins:<c:out value="${cart.orderTotal}"/><br></font></td>
  </tr>
</table>

<c:if test="${counter.count}*${cartItem.partNumber}><%=money %>">

<form >
       <br><font size="3" color="red">you must enter items to shopping cart to process!</font></br>

    
</form>
  </c:if>
  

<c:if test="${cart.lineItemCount!=0}">



	
	
	<form method="post" action="servlet/BuyServlet">
    <input type="submit" value="Buy  From your game money">
	</form>
	


  </c:if>
  
 <%  String ok = request.getParameter("ok");
 if(ok!=null){
		if(ok.equals("1")){
%>
 
 <font color="red"><b>Success to buy coins!</b></font>
    <br><br>
	<%}else if(ok.equals("2")){%>
		
	       <br><font size="3" color="red">you don't have enough money in game! Please use your credit card</font></br>
	       <form action="Checkout.jsp">
   			 <input type="submit" value="Purchase by credit Card">
			</form>
    <br><br>
 <%}
		} %>
	
      		
</body>
      
</html>


      
    </div>
  </div>
  <div id="footer">
    <p>Copyright &copy; 2015. Designed by SCE-Project-Team-8
  </div>
</div>
  
