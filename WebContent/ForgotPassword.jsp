<!DOCTYPE html>
<html>

<head>
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />
<%@ page language="java" import="java.sql.*" errorPage="" %>


</head>
<body style="color: black" onload='document.form1.email.focus()'>
<div id="main">
  <jsp:include page="header.jsp"/>
  
  <div id="content">
    <jsp:include page="sidebar.jsp"/>
  <div id="left">
    <br>
      <center><h1>Please Enter The Following </h1></center>
      <br/>
	<%
	   		String err = request.getParameter("err");
	      	if(err!=null){
	      		if(err.equals("1")){
		    %>
		    <font color="red"><b>Fields cannot be empty!</b></font>
		    <br><br>
			<%
	      		}else if(err.equals("2")){
	    			%>   
	    			<font color="red"><b>The email you've entered is invalid!</b></font>
	    			<br><br>
	    			<%
	    		      		}else if(err.equals("3")){
	    		      			%>   
	    		    			<font color="red"><b>The user you've entered is invalid!</b></font>
	    		    			<br><br>
	    		    			<%
	    		      		}
	      		}
	      		%>
	 <form name="form1"  action="ForgotPasswordServlet" method="post">
		 User name:<br> <input type="text" name="user" style="background-color:#eeeeee; border:1px solid grey">
		<br>
		Email:<br><input type="text" name='email' style="background-color:#eeeeee; border:1px solid grey">
		<br>
		<center><input type="submit" value="ForgotPassword" style="background-color:#eeeeee; border:1px solid grey;"/></center>
	</form>
	<%
	   		String ok = request.getParameter("ok");
	      	if(ok!=null){
	      		if(ok.equals("1")){
		    %>
		    <font color="blue"><b>a mail has been sent to email with your new password.</b></font>
			<br><br>
		    <% } } %>
    </div>
  </div>
 
		
  <jsp:include page="footer.jsp" />
</div>
  </body>
</html>