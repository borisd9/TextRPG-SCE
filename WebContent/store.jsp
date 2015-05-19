<!DOCTYPE html>

<html >
<head>

<title>Online Store - HOME </title>
<meta http-equiv="content-type"content="text/html; charset=utf-8" />

<%@ page language="java" import="java.sql.*" errorPage="" %>
<%
        Connection conn = null;
        
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        conn = DriverManager.getConnection("jdbc:mysql://localhost/database","root","root");
        
        PreparedStatement psSelectRecord=null;
        ResultSet rsSelectRecord=null;
        String sqlSelectRecord=null;
   
        sqlSelectRecord ="SELECT * FROM items";
        psSelectRecord=conn.prepareStatement(sqlSelectRecord);
        rsSelectRecord=psSelectRecord.executeQuery();
%>

<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
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
      <center><h1>Online Store </h1></center>
      <br>
<a href="ShoppingCart.jsp" mce_href="ShoppingCart.jsp">View Cart</a></br>
<p/>  

 <table border='4' cellpadding='6' width='700'>
 <tr>
    <td  bgcolor="#33CCCC">ItemNo.</td>
   <td  bgcolor="#33CCCC">item</td>
   <td  bgcolor="#33CCCC">description</td>
   <td  bgcolor="#33CCCC">bonus1</td>
   <td  bgcolor="#33CCCC">bonus2</td>
   <td  bgcolor="#33CCCC">location</td>
   <td  bgcolor="#33CCCC">Price</td> 
   <td  bgcolor="#33CCCC">Quantity</td> 
   <td  bgcolor="#33CCCC">ADD to CART</td> 
   
   </tr>
  <%
  int i=1;
  while(rsSelectRecord.next())
  {
  %>
  
   <tr>
   
   <td bgcolor="#FF9900"><%=i%></td>
   <form name="modelDetail1" method="POST" action="servlet/CartServlet">
   <td> <%=rsSelectRecord.getString("item")%> </font><input type="hidden" name="item" value="<%=rsSelectRecord.getString("item")%>"></td>
   <td>  <%=rsSelectRecord.getString("description")%> </font><input type="hidden" name="description" value="<%=rsSelectRecord.getString("description")%>"></td>
   <td><%=rsSelectRecord.getInt("bonus1")%></td>
   <td><%=rsSelectRecord.getInt("bonus2")%></td>
   <td><%=rsSelectRecord.getString("location")%></td> 
    <td> <%=rsSelectRecord.getInt("price")%></font><input type="hidden" name="price" value="<%=rsSelectRecord.getInt("price")%>">$</td> 
   <td><input type="text" size="2" value="1" name="quantity"></td>
   
   <td><b><input type="hidden" name="action" value="add"><input type="submit" name="addToCart" value="Add To Cart"></b></td>
   </tr>
    </form>
   
   <tr>
  <br>
  <%
   i++;   /// increment of counter
  } /// End of while loop
  %>
  </table>
 </div>
</body>
</html>
<%
try{
          if(psSelectRecord!=null)
          {
            psSelectRecord.close();
          }
          if(rsSelectRecord!=null)
          {
            rsSelectRecord.close();
          }
          
          
          if(conn!=null)
          {
           conn.close();
          }
        }
        catch(Exception e)
        {
          e.printStackTrace(); 
        }
%>

    <div id="left">
    <br>
      <br/>

      
    </div>
  </div>
  <div id="footer">
    <p>Copyright &copy; 2015. Designed by SCE-Project-Team-8
  </div>
</div>

