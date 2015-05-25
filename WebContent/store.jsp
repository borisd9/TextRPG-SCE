<!DOCTYPE html>

<html >
<head>

<title>Online Store - HOME </title>

<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
<%@ page import="Database.*" %>

<%@ page language="java" import="java.sql.*" errorPage="" %>
<%
String loggedIn = (String)session.getAttribute("username");
//System.out.println(loggedIn);
        DbConnectionAPI db=new DbConnectionAPI();
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
%>
<center><h1>Online Store </h1></center>

</head>
<body>
  <div id="main">
  
  <div id="content">
           <center>  <img src="images/rsz_slots_club_iap.jpg"/></center>
                                    
      
      <div id="left">
      
    <br/><br/>
    
<p/>  

  <b>Hello  <%=loggedIn %>:

	   								
  
   
   </tr>
 
  
   <tr>
   <form>
<%  
   session.setAttribute("money", true);
	session.setAttribute("money", money);%>
	
    Money you have: <%=money%>$ <input type="hidden" name="money" value="<%=money%>"><br>
        <td>Coins you have:</td>
      <td> <%=coins%> </font><input type="hidden" name="cash" value="<%=coins%>"></td><br><br></b>
<b> You  can view your shopping cart! </b><br/>
	<b> Click <a href="ShoppingCart.jsp">here</a> to view cart.</b>   
     </tr>
    </form>
   
   
  <br>
 
 
  <table width="75%" border="1">
  <tr> 
    <td><form name="f1" method="post" action="servlet/CartServlet">
    		<img src="images\unnamed.jpg"/><br>
    
 <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong> Price:</strong> 
       5 dollar</font><input type="hidden" name="price" value="5">
      <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Description:</strong> 
        pay 5$ for 100 coins </font><input type="hidden" name="description" value="100 coins"></p>
        <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Quantity:<input type="text" size="2" value="1" name="quantity"></strong></font></p>
      <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Coins:</strong> 
       100</font><input type="hidden" name="coins" value="100"></p>
       <input type="hidden" name="action" value="add"><input type="submit" name="addToCart" value="Add To Cart">
                   </form></td>
       
      
      <br>
    <td><form name="f2" method="post" action="servlet/CartServlet">
    		<img src="images\unnamed.jpg"/><br>
    
 <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong> Price:</strong> 
       25 dollar</font><input type="hidden" name="price" value="25">
      <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Description:</strong> 
        pay 50$ for 500 coins </font><input type="hidden" name="description" value="500 coins"></p>
        <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Quantity:<input type="text" size="2" value="1" name="quantity"></strong></font></p>
      <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Coins:</strong> 
       500</font><input type="hidden" name="coins" value="500"></p>
       
       <input type="hidden" name="action" value="add"><input type="submit" name="addToCart" value="Add To Cart">
                   </form></td>
       
      
      </br>
      </tr>
      <td><form name="f3" method="post" action="servlet/CartServlet">
    		<img src="images\unnamed.jpg"/><br>
      
 <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong> Price:</strong> 
       50 dollar</font><input type="hidden" name="price" value="50">
      <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Description:</strong> 
        pay 50$ for 1,000 coins </font><input type="hidden" name="description" value="1,000 coins"></p>
        <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Quantity:<input type="text" size="2" value="1" name="quantity"></strong></font></p>
      <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Coins:</strong> 
       1,000</font><input type="hidden" name="coins" value="1000"></p>
       
       <input type="hidden" name="action" value="add"><input type="submit" name="addToCart" value="Add To Cart">
                   </form></td>
       
      
      </br>
      <br>
      
         <td><form name="f4" method="post" action="servlet/CartServlet">
    		<img src="images\unnamed.jpg"/><br>
         
 <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong> Price:</strong> 
       100 dollar</font><input type="hidden" name="price" value="100">
      <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Description:</strong> 
        pay 100$ for 2,000 coins </font><input type="hidden" name="description" value="2,000 coins"></p>
        <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Quantity:<input type="text" size="2" value="1" name="quantity"></strong></font></p>
      <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Coins:</strong> 
       2,000</font><input type="hidden" name="coins" value="2000"></p>
       <input type="hidden" name="action" value="add"><input type="submit" name="addToCart" value="Add To Cart">
                   </form></td>
       
     
      
      
      </br>
       
</table>
</div>
	</div>
	
 </div>
</body>
</html>


    

      
  

