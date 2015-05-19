<html>
<head>
<title>TextBased RPG </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="styles.css" rel="stylesheet" type="text/css" />
<%@ page language="java" import="java.sql.*" errorPage="" %>


</head>
<body style="color: black">
<div id="main">
  <jsp:include page="header.jsp"/>
  
  <div id="content">
    <jsp:include page="sidebar.jsp"/>
  <div id="left">
    <br>
      <center><h1>Please Enter The Following </h1></center>
      <br/>

	 <form name="form1"  action="ForgotPasswordServlet" method="post">
		 User name:<br> <input type="text" name="user" style="background-color:#eeeeee; border:1px solid grey" value=${user} >
		<br>
		Email:<br><input type="text" name='email'  id='email'  style="background-color:#eeeeee; border:1px solid grey" value=${email}>
		<br>
  		
		<center><input type="submit" value="ForgotPassword" style="background-color:#eeeeee; border:1px solid grey;"/></center>
	</form>
    </div>
  </div>
 
		
  		
		
  <jsp:include page="footer.jsp" />
</div>
<script src="validation.js"></script>
  </body>
</html>