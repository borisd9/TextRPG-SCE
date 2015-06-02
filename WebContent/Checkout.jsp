<%@ page language="java" import="Store.*" %>
<html>
<head>
<title>CheckOut </title>
<meta http-equiv="content-type"content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />

</head>
<body  >
  
 <div id="main">
  <jsp:include page="header.jsp"/>
  <div id="content">   
    
      <center><h1>Please enter your billing information</h1></center>
      <br/>
    
<form name="form1" action="/text-rpg/servlet/CheckoutServlet"  method="post">

 <%
   		String err = request.getParameter("err");
      	if(err!=null){
      		if(err.equals("1")){
    %>
    <font color="red"><b>Fields cannot be empty!</b></font>
    <br><br>
   
    <% }
      		else if(err.equals("2")){ 
    			
    
    %>
    
    <font color="red"><b>credit card number is invalid!</b></font>
    <br><br>
    
    <% }
      		else if(err.equals("3")){ 
    			
    
    %>
    
    <font color="red"><b>expiration date is invalid!</b></font>
    <br><br>
   
    <% 
      		}
      	}
    %>
    
	<%   String ok = request.getParameter("ok");
	 if(ok!=null){
			if(ok.equals("1")){
	%>
	 
	 <font color="red"><b>Success to buy coins!</b></font><br>
	<b> Click <a href="http://localhost/text-rpg/enterStore.jsp">here</a> to back to store.</b>   
	    <br><br>
	    <%}
			}%>
			
			
		Name (as it appears on credit card):<br> <input type="text" name="nameOnCard"  style="background-color:#eeeeee; border:1px solid grey" />
		<br>
		Credit Card:<br><select name="creditCardType" style="background-color:#eeeeee; border:1px solid grey"> 
    <option value="amex">American Express</option>
    <option value="visa">Visa</option>
    <option value="mc">Mastercard</option>
    </select>  
	

<br>
		Credit Card Number:(eg. 4111-1111-1111-1111)<br> <input type="text" name="creditCardNumber"  style="background-color:#eeeeee; border:1px solid grey" />

<br>
		Expiration Date:<br><input type="text" name="creditCardExpiration"  style="background-color:#eeeeee; border:1px solid grey" />
<br>

<br><input type="submit" value="Complete Order" >


</form >
</div>
		  <jsp:include page="footer.jsp" />
  </div>
</body>
</html>
 