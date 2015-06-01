
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
       
	
	
      
 
	 <form name="form1"  action="ChangePasswordServlet" method="post">
		 old Password:<br> <input type="text" name="oldPass" style="background-color:#eeeeee; border:1px solid grey">
		<br>
		new Password:<br><input type="text" name='newpass' style="background-color:#eeeeee; border:1px solid grey">
		<br>
		repeat new password:<br><input type="text" name='newpassR' style="background-color:#eeeeee; border:1px solid grey">
		<br>
		<center><input type="submit" value="ChangePassword" style="background-color:#eeeeee; border:1px solid grey;"/></center>
	</form>
	<%
	   		String ok = request.getParameter("ok");
	      	if(ok!=null){
	      		if(ok.equals("1")){
		    %>
		    <font color="blue"><b>your password has been changed successfully.</b></font>
			<br><br>
		    <% } }
    	
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
			<font color="red"><b>The old Password you've entered is incorrect!</b></font>
			<br><br>
	<%
      		}
      		else if(err.equals("3")){
	%>   
			<font color="red"><b>The new Password doesn't match!</b></font>
			<br><br>
	<% 
      		}
      	}
      	
    %>
    </div>
  </div>
 
		
  <jsp:include page="footer.jsp" />
</div>
  </body>
</html>