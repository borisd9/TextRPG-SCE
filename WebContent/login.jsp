<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />
<%@ page language="java" import="java.sql.*" errorPage="" %>
<%@ page import="General.SessionListener" %>


</head>
<body style="color: black">
<div id="main">
  <jsp:include page="header.jsp"/>
  
  <div id="content">
    <jsp:include page="sidebar.jsp"/>
  <div id="left">
    <br>
      <center><h1>Welcome to TextRPG</h1></center>
      <br/>

<br>
<% String loggedIn = (String)session.getAttribute("username");
		if(loggedIn == null){%>

		<form name="form1" action="LoginServlet" method="post" >
 
		Username: <br><input type="text" name="user"  style="background-color:#eeeeee; border:1px solid grey"/>
		<br>
		Password:<br> <input type="password" name="pwd"  style="background-color:#eeeeee; border:1px solid grey"/>
		<br><br>
		<a style="font-size: 100%" href="ForgotPassword.jsp">Forgot Password?</a>
		<center><input type="submit" value="Login" style="background-color:#eeeeee; border:1px solid grey;"/></center>
		</form>
			
		<br>
      <center><a style="font-size: 100%" href="register.jsp">New User? Register Here</a></center>
    <%
    	
   		String err = request.getParameter("err");
      	if(err!=null){
      		if(err.equals("1")){
    %>
    <font color="red"><b>Fields cannot be empty!</b></font>
    <br><br>
	<%
      		}
      		else if(err.equals("2")){
	%>   
	<font color="red"><b>Wrong username or password!</b></font>
	<br><br>
	<%
      		}
      		else if(err.equals("3")){
	%>   
	<font color="red"><b>Your account is not activated. Please click the link provided in your mail to activate your account.</b></font>
	<br><br>
	<%
      		}
      		else if(err.equals("4")){
	%>
	<font color="red"><b>You are already logged in!</b></font>
	
	<% 
      		}
      		else if(err.equals("5")){
      			%>   
      			<font color="red"><b>Your Account Has Been Banned!</b>
      			<br>You are welcome to <a href="contact.jsp">contact</a> us if you feel this ban was unrightful<br></font>
      			<br><br>
      			<%
      		}   		
      	}
      	
    %>
    
    <% 
			} else{
	%>  
	   
	<font color="red"><b>You are currently logged in</b></br>
	
	<b><form action="LogoutServlet" method="post"></b></font>
	<input type="submit" value="Logout">
	</form></b>
	
	<% } %>
  		
    </div>
    
  </div>
 
		
  		
		
  <jsp:include page="footer.jsp" />
</div>
</body>
</html>
