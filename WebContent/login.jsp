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
      <center><h1>Welcome to TextRPG</h1></center>
      <br/>

<br>

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
	<%
	String user = null;
	if(session.getAttribute("user") == null){
		response.sendRedirect("login.jsp");
	}else user = (String) session.getAttribute("user");
	String userName = null;
	String sessionID = null;
	Cookie[] cookies = request.getCookies();
	if(cookies !=null){
	for(Cookie cookie : cookies){
		if(cookie.getName().equals("user")) userName = cookie.getValue();
		if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
	}
	}
	%>
	<font color="red"><b>Hi <%=userName %> you are already logged in!</b></font>
	
<br>
<form action="LogoutServlet" method="post">
<input type="submit" value="Logout" >
</form>
	
	<% 
      		}
      	}
    %>
    


        <form name="form1" action="LoginServlet" onsubmit="return validateForm()" method="post" >
 
		Username: <br><input type="text" name="user"  style="background-color:#eeeeee; border:1px solid grey"/>
		<br>
		Password:<br> <input type="password" name="pwd"  style="background-color:#eeeeee; border:1px solid grey"/>
		<br><br>
		<center><input type="submit" value="Login" style="background-color:#eeeeee; border:1px solid grey;"/></center>
		</form>
		
		
  		

      <center><a style="font-size: 100%" href="register.jsp">New User? Register Here</a></center>
    </div>
    
  </div>
 
		
  		
		
  <jsp:include page="footer.jsp" />
</div>
</body>
</html>
